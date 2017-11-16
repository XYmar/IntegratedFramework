package com.rengu.DAO;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.rengu.actions.mes.MesSender;
import com.rengu.entity.*;
import com.rengu.util.ApsTools;
import com.rengu.util.MySessionFactory;
import com.rengu.util.SnapshotLevel;
import com.rengu.util.Tools;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wey580231 on 2017/6/27.
 */
public class SnapshotDao {

    //Yang 20170809 aps地点与3d车间机器人停靠点转换关系
    private static Map<String, String> distanceMap = new HashMap<String, String>();

    static {
        distanceMap.put("ZNZP", "ZNZPPT_01");
        distanceMap.put("ZNZPPT_01", "ZNZPPT_01");
        distanceMap.put("ZNZPPT_02", "ZNZPPT_02");
        distanceMap.put("RJXZ", "RJXZPT_01");
        distanceMap.put("RJXZPT_01", "RJXZPT_01");
        distanceMap.put("RJXZPT_02", "RJXZPT_02");
        distanceMap.put("TKD-L", "AGV_L");
        distanceMap.put("TKD-R", "AGV_R");
        distanceMap.put("CCJDJC", "UR5");
        distanceMap.put("UR5", "UR5");
        distanceMap.put("XBC", "XBC");
        distanceMap.put("MTJDJC", "OnlineTest");
        distanceMap.put("ZHDXNJC", "AssembleAccuracyTest");
    }

    //将所有订单一起转换
    public boolean switchToEmulateData(String userId, String id) {
        boolean result = false;
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        RG_SnapshotNodeEntity bottomSnapshot = session.get(RG_SnapshotNodeEntity.class, id);
        bottomSnapshot = session.get(RG_SnapshotNodeEntity.class, id);
        if (bottomSnapshot != null && bottomSnapshot.getLevel().equals(SnapshotLevel.BOTTOM)) {

            //【1】查找此次排程对应的所有订单结果信息
            NativeQuery nquery = session.createNativeQuery("select * from rg_plan where idSnapshort=:id  order by t1Task asc", RG_PlanEntity.class);
            nquery.setParameter("id", id);
            List<RG_PlanEntity> plans = nquery.list();

            if (plans.size() > 0) {
                //【2】将plan表转换至模拟数据
                result = convertPlanTo3DEmulateData(plans, id);

                if (result) {
                    RG_SnapshotNodeEntity rootParent = bottomSnapshot.getRootParent();

                    try {
                        String layoutName = rootParent.getSchedule().getLayout().getName();

                        //【3】更新3D车间的对应状态，将布局、仿真、快照节点更新
                        NativeQuery nativeQuery = session.createNativeQuery("update rg_state3d set layoutState = ?, layoutId = ? ,model = ? , snapshotId = ? where id = ?");
                        nativeQuery.setParameter(1, 1);
                        nativeQuery.setParameter(2, layoutName);
                        nativeQuery.setParameter(3, 1);
                        nativeQuery.setParameter(4, id);
                        nativeQuery.setParameter(5, 1);
                        if (nativeQuery.executeUpdate() > 0) {
                            result = true;
                        }
                        tx.commit();
                    } catch (NullPointerException e) {
                        e.printStackTrace();
                        tx.rollback();
                    }
                }
            }
        }

        session.close();

        return result;
    }

    //将plan表转换成3d车间的模拟数据，中间存在的字段需要框架来补充
    private boolean convertPlanTo3DEmulateData(List<RG_PlanEntity> plans, String snapShotId) {
        boolean flag = false;

        Session session = MySessionFactory.getSessionFactory().openSession();
        session.beginTransaction();

//        Query queryObject = session.createNativeQuery("TRUNCATE table rg_emulateresult");
        Query queryObject = session.createNativeQuery("delete from rg_emulateresult");
        int result = queryObject.executeUpdate();

        if (result >= 0) {
            System.out.println("清空数据库：rg_emulateresult表已完成");
            try {
                //【1】將快照對應的所有订单一并转换
                switchPlanToEmulateResult(false, plans, session);

                //【2】将快照对应的所有订单，按照订单逐个转换
                NativeQuery nativeQuery = session.createNativeQuery("select idOrder from rg_plan where idSnapshort =:id group by idOrder");
                nativeQuery.setParameter("id", snapShotId);
                List<String> orders = nativeQuery.list();

                for (int i = 0; i < orders.size(); i++) {
                    NativeQuery nQuery = session.createNativeQuery("select * from rg_plan where idOrder = ? and idSnapshort = ? order by t1Task asc", RG_PlanEntity.class);
                    nQuery.setParameter(1, orders.get(i));
                    nQuery.setParameter(2, snapShotId);
                    List<RG_PlanEntity> orderPlans = nQuery.list();

                    switchPlanToEmulateResult(true, nQuery.list(), session);
                }

                flag = true;
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        System.out.println("清空数据表结束");
        session.getTransaction().commit();
        session.close();
        return flag;
    }

    /**
     * 将计划按照订单或按快照转换成结果信息，保存至数据表
     *
     * @param isSignal 为true表示按订单转换，为false表示按照快照转换
     * @param plans    结果信息集合
     * @param session  数据库连接
     * @throws ParseException 日期类型转换出错
     */
    private void switchPlanToEmulateResult(boolean isSignal, List<RG_PlanEntity> plans, Session session) throws ParseException {
        //【1】将当前快照对应的所有订单按照时间升序转换
        RG_PlanEntity startPlan = plans.get(0);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        Date initialDate = sdf.parse(startPlan.getT1Task());

        int perPlanDelayMinuteTime = 0;         //总体上每道计划偏移时间
        int currMultiPlan = -1;                 //对应APS中的第几种策略

//        List<String> switchedProcessList = new ArrayList<String>();

        List<RG_PlanEntity> robotPlan = new ArrayList<RG_PlanEntity>();

        System.out.println("总计需要转换" + plans.size() + "条记录");
        //转换AGV、生产工艺
        for (int i = 0; i < plans.size(); i++) {

            RG_PlanEntity plan = plans.get(i);

            if (plan.getResourceByIdResource().getIdR().equals("KR16_MG")) {
                robotPlan.add(plan);
            }

            RG_ResourceEntity res = plan.getResourceByIdResource();

            if (res != null && res.getCritical() != null && res.getCritical().equals("T")) {
                String processId = plan.getProcessByIdProcess().getId();
                String resourceId = plan.getResourceByIdResource().getIdR();

                NativeQuery nquery = session.createNativeQuery("select * from rg_processassisant where processId = ? ", RG_ProcessAssisantEntity.class);
                nquery.setParameter(1, processId);
                List<RG_ProcessAssisantEntity> list = nquery.list();

                if (list.size() > 0) {
                    RG_EmulateResultEntity result = new RG_EmulateResultEntity();

                    RG_ProcessAssisantEntity entity = list.get(0);

                    if (entity.getResource() != null) {
                        if (!entity.getResource().toUpperCase().contains(resourceId)) {
                            continue;
                        }
                    }

                    //第一道结果来决定以后的结果时间偏移量
                    if (i == 0 && entity.getAutoCreatePreviouseProcess() != null && entity.getPreProcessMobility() != null && entity.getAutoCreatePreviouseProcess().equals("Y")) {
                        int pDelayTime = Integer.parseInt(entity.getpDelayStartTime());

                        perPlanDelayMinuteTime = Integer.parseInt(entity.getPreProcessDistances()) / Integer.parseInt(entity.getPreProcessMobility()) - pDelayTime;
                    }

                    //任务名
                    result.setTask(entity.getTask());
                    //货物名
                    result.setGoods(entity.getGoods());

                    String site = getSite(session, entity, entity.getSite(), plan.getT1Task());
                    result.setSite(site);

                    Date startDate = sdf.parse(plan.getT1Task());
                    Date endDate = sdf.parse(plan.getT2Task());

                    int currPlanStartTime = (int) (startDate.getTime() - initialDate.getTime()) / 1000;
                    int currPlanEndTime = (int) ((endDate.getTime() - initialDate.getTime()) / 1000);

                    //开始时间
                    result.setStartTime(currPlanStartTime + perPlanDelayMinuteTime);
                    //结束时间
                    result.setEndTime(currPlanEndTime + perPlanDelayMinuteTime);
                    //设置订单
                    result.setOrderEntity(plan.getOrderByIdOrder());
                    //设置所属快照
                    if (!isSignal) {
                        result.setSnapshotNodeEntity(plan.getSnapShort());
                    }
                    //设置task
                    result.setIdTask(plan.getIdTask());

                    session.save(result);

                    //Yang 转换当前工序之前的步骤
                    if (entity.getAutoCreatePreviouseProcess() != null && entity.getAutoCreatePreviouseProcess().equals("Y")) {
                        String[] taskList = entity.getPreviousProcessTasks().split(",");
                        String[] distances = entity.getPreProcessDistances().split(",");
                        String[] mobility = entity.getPreProcessMobility().split(",");

                        if (taskList.length == distances.length) {
                            for (int m = 0; m < taskList.length; m++) {

                                RG_EmulateResultEntity nextResult = new RG_EmulateResultEntity();
                                //任务名
                                nextResult.setTask(taskList[m]);
                                //货物名perPlanDelayMinuteTime
                                nextResult.setGoods(entity.getGoods());
                                //地点名(若不存在为null)
                                if (entity.getPreProcessSites() != null) {
                                    String[] sites = entity.getPreProcessSites().split(",");
                                    nextResult.setSite(sites[m]);
                                } else {
                                    nextResult.setSite(null);
                                }

                                long lastTime = 2;

                                int currDis = Integer.parseInt(distances[m]);
                                int currPeed = Integer.parseInt(mobility[m]);

                                if (currDis > 0 && currPeed > 0) {
                                    lastTime = currDis / currPeed;
                                }

                                int pDelayStartTime = Integer.parseInt(entity.getpDelayStartTime());

                                long stime = currPlanStartTime + pDelayStartTime - lastTime + perPlanDelayMinuteTime;

                                //开始时间
                                nextResult.setStartTime((int) stime);
                                //结束时间
                                nextResult.setEndTime((int) (stime + lastTime));
                                nextResult.setOrderEntity(plan.getOrderByIdOrder());

                                if (!isSignal) {
                                    nextResult.setSnapshotNodeEntity(plan.getSnapShort());
                                }

                                session.save(nextResult);
                            }
                        }
                    }

                    //Yang 转换当前工序之后的步骤
                    if (entity.getAutoCreateNextProcess() != null && entity.getNextProcessTask() != null
                            && entity.getNextProcessDistnces() != null && entity.getNextProcessMobility() != null && entity.getAutoCreateNextProcess().equals("Y")) {

                        String[] taskList = entity.getNextProcessTask().split(",");
                        String[] distances = entity.getNextProcessDistnces().split(",");
                        String[] mobility = entity.getNextProcessMobility().split(",");

                        if (taskList.length == distances.length) {
                            for (int m = 0; m < taskList.length; m++) {
                                RG_EmulateResultEntity nextResult = new RG_EmulateResultEntity();
                                //任务名
                                nextResult.setTask(taskList[m]);
                                //货物名
                                nextResult.setGoods(entity.getGoods());
                                //地点名(若不存在为null)
                                if (entity.getNextProcessSites() != null) {
                                    String[] sites = entity.getNextProcessSites().split(",");
                                    nextResult.setSite(sites[m]);
                                } else {
                                    nextResult.setSite(null);
                                }

                                int pAdvanceStartTime = Integer.parseInt(entity.getpAdvanceStartTime());
                                long stime = currPlanEndTime - pAdvanceStartTime + perPlanDelayMinuteTime;

                                long lastTime = 2;

                                int currDis = Integer.parseInt(distances[m]);
                                int currPeed = Integer.parseInt(mobility[m]);

                                if (currDis > 0 && currPeed > 0) {
                                    lastTime = currDis / currPeed;
                                }

                                //开始时间
                                nextResult.setStartTime((int) stime);
                                //结束时间
                                nextResult.setEndTime((int) (stime + lastTime));
                                nextResult.setOrderEntity(plan.getOrderByIdOrder());

                                if (!isSignal) {
                                    nextResult.setSnapshotNodeEntity(plan.getSnapShort());
                                }
                                session.save(nextResult);
                            }
                        }
                    }
                }
            }
        }

        //Yang 20170808转换运输工艺
        for (int i = 0; i < robotPlan.size(); i++) {
            if (i < robotPlan.size() - 1) {
                String startProcessId = robotPlan.get(i).getProcessByIdProcess().getId();
                String endProcessId = robotPlan.get(i + 1).getProcessByIdProcess().getId();

                RG_ProcessAssisantEntity startProcessAssisantEntity = getProcessAssisant(session, startProcessId);
                RG_ProcessAssisantEntity endProcessAssisantEntity = getProcessAssisant(session, endProcessId);

                RG_SiteEntity startSiteEntity = robotPlan.get(i).getSiteByIdSite();
                RG_SiteEntity endSiteEntity = robotPlan.get(i + 1).getSiteByIdSite();

                if (startProcessAssisantEntity == null || endProcessAssisantEntity == null || startSiteEntity == null || endSiteEntity == null) {
                    continue;
                }

                String startSite = getSite(session, startProcessAssisantEntity, startSiteEntity.getId(), robotPlan.get(i).getT1Task());

                String endSite = getSite(session, endProcessAssisantEntity, endSiteEntity.getId(), robotPlan.get(i + 1).getT1Task());

                if (!startSite.equals(endSite)) {
                    Date startDate = sdf.parse(robotPlan.get(i).getT2Task());

                    long stime = (startDate.getTime() - initialDate.getTime()) / 1000 + 1 + perPlanDelayMinuteTime;
                    long lastTime = 0;

                    Short currPeed = robotPlan.get(i).getResourceByIdResource().getMobility();

                    NativeQuery nquery = session.createNativeQuery("select * from rg_distance where idSite1 =:site1 and idSite2 =:site2").addEntity(RG_DistanceEntity.class);

                    if (startSite.toLowerCase().contains("znzp")) {
                        nquery.setParameter("site1", "ZNZP");
                    } else if (startSite.toLowerCase().contains("rjxz")) {
                        nquery.setParameter("site1", "RJXZ");
                    } else {
                        nquery.setParameter("site1", startSite);
                    }

                    if (endSite.toLowerCase().contains("znzp")) {
                        nquery.setParameter("site2", "ZNZP");
                    } else if (endSite.toLowerCase().contains("rjxz")) {
                        nquery.setParameter("site2", "RJXZ");
                    } else {
                        nquery.setParameter("site2", endSite);
                    }

                    List list = nquery.list();

                    if (list.size() > 0) {
                        RG_DistanceEntity distanceEntity = (RG_DistanceEntity) list.get(0);
                        if (distanceEntity != null && currPeed != null && distanceEntity.getDistance() > 0 && currPeed > 0) {
                            lastTime = distanceEntity.getDistance() / currPeed;
                        }
                    } else {
                        System.out.println(startSite + "_**__Yang_" + endSite + "_::_" + startSiteEntity.getId() + "_^^_" + endSiteEntity.getId());
                    }

                    if (lastTime > 0) {
                        RG_EmulateResultEntity nextResult = new RG_EmulateResultEntity();
                        //任务名
                        nextResult.setTask("KR16_MG_Move");
                        //货物名
                        nextResult.setGoods("");
                        //地点名
                        nextResult.setSite(distanceMap.get(endSite));

                        //开始时间
                        nextResult.setStartTime((int) stime);
                        //结束时间
                        nextResult.setEndTime((int) (stime + lastTime));
                        nextResult.setOrderEntity(robotPlan.get(i).getOrderByIdOrder());

                        if (!isSignal) {
                            nextResult.setSnapshotNodeEntity(robotPlan.get(i).getSnapShort());
                        }
                        session.save(nextResult);
                    }
                }
            }
        }
    }

    private String getSite(Session session, RG_ProcessAssisantEntity entity, String processAssisantSite, String t1Task) {
        String site = "";
        if (entity.getSiteRource() != null) {
            NativeQuery planQuery = session.createNativeQuery("select * from rg_plan where t1Task = ?", RG_PlanEntity.class);
            planQuery.setParameter(1, t1Task);
            List<RG_PlanEntity> planList = planQuery.list();
            if (planList.size() > 0) {
                Iterator<RG_PlanEntity> planIter = planList.iterator();
                while (planIter.hasNext()) {
                    RG_PlanEntity tmpPlan = planIter.next();
                    if (!(tmpPlan.getResourceByIdResource().getIdR().toUpperCase().equals("KR16_MG")) && entity.getSiteRource().contains(tmpPlan.getSiteByIdSite().getId())) {
                        site = tmpPlan.getSiteByIdSite().getId();
                        break;
                    }
                }
            } else {
                site = processAssisantSite;
            }
        } else {
            site = processAssisantSite;
        }
        return site;
    }

    private RG_ProcessAssisantEntity getProcessAssisant(Session session, String processId) {
        NativeQuery nquery = session.createNativeQuery("select * from rg_processassisant where processId = ? ", RG_ProcessAssisantEntity.class);
        nquery.setParameter(1, processId);
        List<RG_ProcessAssisantEntity> startList = nquery.list();

        RG_ProcessAssisantEntity entity = null;

        if (startList.size() > 0) {
            entity = startList.get(0);
        }
        return entity;
    }

    //将结果下发给MES，添加对订单状态的修改

    public boolean switchResultToMess(String s, String id) {
        boolean result = false;

        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        //重置所有订单的下发mes状态
        String hql = "from RG_OrderEntity rg_orderEntity";
        Query queryList = session.createQuery(hql);
        List<RG_OrderEntity> rg_orderEntityList = queryList.list();
        for (RG_OrderEntity rg_orderEntity : rg_orderEntityList) {
            rg_orderEntity.setSendToMES(false);
            session.saveOrUpdate(rg_orderEntity);
        }

        try {
            RG_SnapshotNodeEntity snapshot = session.get(RG_SnapshotNodeEntity.class, id);

            if (snapshot != null && snapshot.getLevel().equals(SnapshotLevel.BOTTOM)) {

                RG_SnapshotNodeEntity parent = snapshot.getParent();
                RG_SnapshotNodeEntity rootParent = snapshot.getRootParent();

                if (!parent.getApply() && !snapshot.getApply()) {

                    List<String> orderList = new ArrayList<String>();

                    Set<RG_OrderEntity> orders = rootParent.getSchedule().getOrders();
                    Iterator<RG_OrderEntity> iter = orders.iterator();

                    //【1】更新订单状态
                    while (iter.hasNext()) {
                        RG_OrderEntity tmpOrder = iter.next();
                        tmpOrder.setSendToMES(true);
                        orderList.add(tmpOrder.getId());
                        session.update(tmpOrder);
                    }

                    if (ApsTools.instance().publishOrder(orderList) == ApsTools.STARTED) {

                        //【2】将计划和订单下发给MES
                        iter = orders.iterator();
                        while (iter.hasNext()) {
                            RG_OrderEntity tmpOrder = iter.next();
                            ObjectMapper mapper = new ObjectMapper();
                            ObjectNode dataNode = mapper.createObjectNode();

                            dataNode.put("id", tmpOrder.getId());
                            dataNode.put("name", tmpOrder.getName());
                            dataNode.put("idProduct", tmpOrder.getProductByIdProduct().getMesId());
                            dataNode.put("quantity", tmpOrder.getQuantity());
                            dataNode.put("priority", tmpOrder.getPriority());
                            dataNode.put("t0", Tools.formatToStandardDate(tmpOrder.getT0()));
                            dataNode.put("t1", Tools.formatToStandardDate(tmpOrder.getT1()));
                            dataNode.put("t2", Tools.formatToStandardDate(tmpOrder.getT2()));
                            dataNode.put("ord", tmpOrder.getOrd());
                            dataNode.put("t1Interaction", tmpOrder.getT1Interaction());
                            dataNode.put("t2Interaction", tmpOrder.getT2Interaction());
                            dataNode.put("t1Plan", Tools.formatToStandardDate(tmpOrder.getT1Plan()));
                            dataNode.put("t2Plan", Tools.formatToStandardDate(tmpOrder.getT2Plan()));
                            dataNode.put("advance", tmpOrder.getAdvance());
                            dataNode.put("delay", tmpOrder.getDelay());
                            dataNode.put("nbTask", tmpOrder.getNbTask());

                            MesSender.instance().sendData("orderInfo", dataNode);
                        }

                        //生产工艺信息
//                        NativeQuery query = session.createNativeQuery("select rplan.id,idTask,idOrder,nameTask,rplan.idProduct,quantityTask,t1Task,t2Task from rg_plan rplan left join rg_process rprocess on rplan.idProcess=rprocess.id where rprocess.transport = 0 and idSnapshort=:snapShot ");
                        NativeQuery query = session.createNativeQuery("SELECT p.id, p.idTask, p.idOrder, p.nameTask, prod.mesId , p.quantityTask, p.t1Task, p.t2Task FROM rg_plan p, rg_product prod, rg_process proc WHERE proc.transport = 0 AND p.idSnapshort =:snapShot AND p.idTask NOT LIKE '%JC%' AND proc.idProduct IS NULL AND p.idProcess = proc.id AND p.idProduct = prod.id");
                        query.setParameter("snapShot", id);
                        List plans = query.list();
                        for (int i = 0; i < plans.size(); i++) {
                            Object[] planResult = (Object[]) plans.get(i);

                            ObjectMapper mapper = new ObjectMapper();
                            ObjectNode dataNode = mapper.createObjectNode();

                            dataNode.put("id", planResult[0].toString());
                            //YANG 20170825新增idTask
                            dataNode.put("idTask", planResult[1].toString());
                            dataNode.put("idOrder", planResult[2].toString());
                            dataNode.put("nameTask", planResult[3].toString());
                            dataNode.put("idProductOrder", planResult[4].toString());
                            dataNode.put("quantityTask", Integer.parseInt(planResult[5].toString()));
                            dataNode.put("t1Task", planResult[6].toString());
                            dataNode.put("t2Task", planResult[7].toString());
                            dataNode.put("nameUser", "1");
                            dataNode.put("scheduleTime", Tools.formatToStandardDate(rootParent.getSchedule().getScheduleTime()));
                            MesSender.instance().sendData("planInfo", dataNode);
                        }

                        //【3】更新快照节点的状态
                        parent.setApply(true);
                        parent.setDispatchMesTime(new Date());
                        snapshot.setApply(true);
                        snapshot.setDispatchMesTime(new Date());

                        session.update(snapshot);
                        session.update(parent);

                        query = session.createNativeQuery("update rg_userconfig set dispatchMesSnapshotId = ? where idUser = ?");
                        query.setParameter(1, id);
                        query.setParameter(2, "1");

                        if (query.executeUpdate() > 0) {
                            result = true;
                            tx.commit();
                        } else {
                            result = false;
                            tx.rollback();
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            result = false;
            tx.rollback();
        }
        session.close();

        return result;
    }

    //恢复aps快照
    public boolean recoverSnapshot(String s, String id) {
        boolean result = false;

        if (ApsTools.instance().recoverSnapshot(id) == ApsTools.STARTED) {
            result = true;

            Session session = MySessionFactory.getSessionFactory().openSession();
            session.beginTransaction();

            NativeQuery query = session.createNativeQuery("update rg_userconfig set apsCurrSnapshotId = ? where idUser = ?");
            query.setParameter(1, id);
            query.setParameter(2, "1");
            query.executeUpdate();

            session.getTransaction().commit();
            session.close();
        }

        return result;
    }

    //查询对应节点的快照是否恢复
    public boolean queryRecoverSnapshot(String s, String id) {
        boolean result = false;

        Session session = MySessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        RG_SnapshotNodeEntity entity = session.get(RG_SnapshotNodeEntity.class, id);
        result = entity.getApsRecoverSnapshot();

        session.flush();

        session.getTransaction().commit();
        session.close();

        return result;
    }
}
