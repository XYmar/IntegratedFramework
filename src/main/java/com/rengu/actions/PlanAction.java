package com.rengu.actions;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.DAO.impl.PlanDAOImpl;
import com.rengu.entity.*;
import com.rengu.util.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by hanch on 2017/7/1.
 */
public class PlanAction extends SuperAction {
    public void getAllPlanBySnapshotId() throws Exception {
        JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(this.httpServletRequest));
        String snapshotId = jsonNode.get("id").asText();
        PlanDAOImpl planDAO = DAOFactory.getPlanDAOImplInstance();
        List<RG_PlanEntity> rg_planEntityList = planDAO.findAllBySnapshotId(snapshotId);
        String jsonString = Tools.entityConvertToJsonString(rg_planEntityList);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
    }

    public void getAllResultBySnapshotId() throws Exception {
        JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(this.httpServletRequest));

        JsonNode snapNodes = jsonNode.get("snaps");
        Set<RG_SnapshotNodeEntity> rg_snapshotEntitySet = new HashSet<>();

        List<RG_SnapShotResult> resultList = new ArrayList<RG_SnapShotResult>();

        MySessionFactory.getSessionFactory().getCurrentSession().close();
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        //transaction.begin();
        if (!transaction.isActive()) {
            session.beginTransaction();
        }

        //连接数据库
        //加载驱动
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/testdatabase?serverTimezone=UTC";
        String username = "root";
        String password = "root";

        //得到连接对象
        Connection conn = DriverManager.getConnection(url,username,password);


        //每次先清空利用率表
        String sql0 = "delete from rg_resourcerate";

        //得到PreparedStatement对象
        PreparedStatement pstmt0 = conn.prepareStatement(sql0);
        pstmt0.executeUpdate();

        for (JsonNode snap : snapNodes) {
            // RG_SnapshotNodeEntity rg_snapEntity = session.get(RG_SnapshotNodeEntity.class, snap.get("id").asText());

            String snapshotId = snap.get("id").asText();
            PlanDAOImpl planDAO = DAOFactory.getPlanDAOImplInstance();
            List<RG_PlanEntity> rg_planEntityList = planDAO.findAllBySnapshotId(snapshotId, session);
            List<RG_OrderEntity> rg_orderEntityList = (List<RG_OrderEntity>)session.createQuery("select DISTINCT plan.orderByIdOrder from RG_PlanEntity plan where plan.snapShort.id =:id").setParameter("id", snapshotId).list();

            //获取排程时间跨度
            //RG_SnapshotNodeEntity snapshotEntity = (RG_SnapshotNodeEntity) session.createQuery("select snapshot from RG_SnapshotNodeEntity snapshot where id =:id").setParameter("id", snapshotId);
            RG_SnapshotNodeEntity snapshotEntity = (RG_SnapshotNodeEntity) session.get(RG_SnapshotNodeEntity.class, snapshotId);
            String topId = snapshotEntity.getRootParent().getId();
            RG_SnapshotNodeEntity topSnapshotEntity = (RG_SnapshotNodeEntity) session.get(RG_SnapshotNodeEntity.class, topId);
            int scheduleWindow = topSnapshotEntity.getSchedule().getScheduleWindow();

            //计算跨度
            String maxT2Task = (String) session.createQuery("select MAX(t2Task) from RG_PlanEntity plan  where plan.snapShort.id =:id").setParameter("id", snapshotId).uniqueResult();
            String minT1Task = (String) session.createQuery("select MIN(t1Task) from RG_PlanEntity plan  where plan.snapShort.id =:id").setParameter("id", snapshotId).uniqueResult();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
            SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
            Date t2Task = sdf.parse(maxT2Task);
            Date t1Task = sdf.parse(minT1Task);

            long taskSpan0 = t2Task.getTime() - t1Task.getTime();
            System.out.println(taskSpan0);
            long taskSpan = (long)(taskSpan0/1000);
            System.out.println(taskSpan);

            int count = 0;          //拖期订单数量
            long sum = 0;           //拖期量累加值
            int countChange = 0;   //有变化的工序数量
            int overSpan = 0;       //工序时间跨度超过滚动周期的


            //计算拖期量累加值
            if(rg_orderEntityList != null){
                for(RG_OrderEntity order : rg_orderEntityList){
                    String idOrder = order.getId();
                    String maxT2TaskSum = (String) session.createQuery("select MAX(t2Task) from RG_PlanEntity plan  where plan.snapShort.id =:id and plan.orderByIdOrder.id =:idOrder").setParameter("id", snapshotId).setParameter("idOrder", idOrder).uniqueResult();
                    String t2OrderSum = (String) session.createQuery("select DISTINCT t2Order from RG_PlanEntity plan  where plan.snapShort.id =:id and plan.orderByIdOrder.id =:idOrder").setParameter("id", snapshotId).setParameter("idOrder", idOrder).uniqueResult();

                    Date t2TaskSum = sdf.parse(maxT2TaskSum);
                    Date t2Order2Sum = sdf.parse(t2OrderSum);

                    long delayOrder0 = t2Order2Sum.getTime() - t2TaskSum.getTime();
                    System.out.println(delayOrder0);
                    long delayOrder = (long)(delayOrder0/1000);
                    System.out.println(delayOrder);

                    if (delayOrder < 0) {
                        //计算拖期订单数量
                        count++;
                        //TODO 此处结果可能有精度问题，待测试
                        //计算拖期量累加值
                        sum += delayOrder;
                    }
                }

                sum = sum * (-1);
            }


            //计算工序资源有变化的工序数量

            //获取此节点下的所有idTask
            List<String> taskList = (List<String>) session.createQuery("select DISTINCT idTask from RG_PlanEntity plan where plan.snapShort.id =:snapshotId").setParameter("snapshotId", snapshotId).list();

            for(String idTask : taskList){
                //初次排程使用的资源
                List<RG_ResourceEntity> resourceEntity1 = (List<RG_ResourceEntity>) session.createQuery("select plan.resourceByIdResource from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapshotId").setParameter("idTask", idTask).setParameter("snapshotId", snapshotId).list();

                //找到此工序的最小的t1
                String t1TaskResource1 = (String) session.createQuery("select MIN(t1Task) from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapshotId").setParameter("idTask", idTask).setParameter("snapshotId", snapshotId).uniqueResult();
                Date t1TaskResource11 = sdf.parse(t1TaskResource1);

                //找到此节点的根节点
                String rootId = (String) session.createQuery("select snapshot.rootParent.id from RG_SnapshotNodeEntity snapshot where snapshot.id =:id").setParameter("id", snapshotId).uniqueResult();

                RG_SnapshotNodeEntity snapshotEntity0 = (RG_SnapshotNodeEntity) session.createQuery("select snapshot from RG_SnapshotNodeEntity snapshot where id =:id").setParameter("id", rootId).uniqueResult();

                //找到此根节点下的所有子节点
                Set<RG_SnapshotNodeEntity> snapshotNodes = snapshotEntity0.getChilds();

                boolean flag = false;

                //遍历这些节点,并找到每个节点下此工序所使用的资源
                for(RG_SnapshotNodeEntity snapshot : snapshotNodes){
                    String idSnap = snapshot.getId();

                    //判断，从子节点中将此节点去掉
                    if(idSnap != snapshotId){

                        //拖拽后排程使用的资源
                        List<RG_ResourceEntity> resourceEntity2 = (List<RG_ResourceEntity>) session.createQuery("select plan.resourceByIdResource from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapshotId").setParameter("idTask", idTask).setParameter("snapshotId", idSnap).list();

                        String t1TaskResource2 = (String) session.createQuery("select MIN(t1Task) from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapshotId").setParameter("idTask", idTask).setParameter("snapshotId", idSnap).uniqueResult();

                        if(resourceEntity2 != null){        //判断工序所使用的资源是否正确
                            if (resourceEntity1 != resourceEntity2) {
                                flag = true;

                            }
                        }

                        if(t1TaskResource2 != null){
                            Date t1TaskResource22 = sdf.parse(t1TaskResource2);

                            long taskSpan12 = (long)((t1TaskResource22.getTime() - t1TaskResource11.getTime())/1000);

                            if ((t1TaskResource11 != null) && (t1TaskResource22 != null) && taskSpan12 > (24 * 60 * 60)) {
                                overSpan++;
                            }
                        }

                    }

                }

                if(flag){
                    //工序资源有变化的工序数量
                    countChange++;
                }


            }
            System.out.println("工序有变化的工序数量countChange: " + countChange);
            System.out.println("超过滚动周期的工序数量overSpan: " + overSpan);

            //注释
            if (rg_planEntityList != null) {

                /*for (RG_PlanEntity plan : rg_planEntityList) {

                    //计算工序资源有变化的工序数量
                    String idTask = plan.getIdTask();
                    //初次排程使用的资源
                    List<RG_ResourceEntity> resourceEntity1 = (List<RG_ResourceEntity>) session.createQuery("select plan.resourceByIdResource from RG_PlanEntity plan where plan.idTask =:idTask").setParameter("idTask", idTask).list();


                    String t1TaskResource1 = (String) session.createQuery("select MIN(t1Task) from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapshotId").setParameter("idTask", idTask).setParameter("snapshotId", snapshotId).uniqueResult();
                    Date t1TaskResource11 = sdf.parse(t1TaskResource1);

                    //找到初次排程起点
                    long t1TaskResource0 = 0;

                    //其他情况工序所用的资源
                    List<RG_SnapshotNodeEntity> snapshotEntity1 = (List<RG_SnapshotNodeEntity>) session.createQuery("select plan.snapShort from RG_PlanEntity plan where plan.idTask =:idTask").setParameter("idTask", idTask).list();
                    if (snapshotEntity1 != null) {
                        for (RG_SnapshotNodeEntity snapshot1 : snapshotEntity1) {
                            String snapId = snapshot1.getId();

                            if (!snapId.equals(snapshotId)) {  //找到此快照节点外的其他快照节点

                                List<RG_ResourceEntity> resourceEntity2 = (List<RG_ResourceEntity>) session.createQuery("select plan.resourceByIdResource from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapId").setParameter("idTask", idTask).setParameter("snapId", snapId).list();
                                if (resourceEntity1 != resourceEntity2) {
                                    countChange++;
                                }


                                String rootId = (String) session.createQuery("select snapshot.rootParent.id from RG_SnapshotNodeEntity snapshot where snapshot.id =:id").setParameter("id", snapId).uniqueResult();
                                //List<RG_SnapshotNodeEntity> snapshotEntity2 = (List<RG_SnapshotNodeEntity>) session.createQuery("select snapshot from RG_SnapshotNodeEntity snapshot where snapshot.rootParent.id =:id and level =:level").setParameter("id", rootId).setParameter("level","bottom").list();*//**//*

                                String middleId = (String) session.createQuery("select snapshot.parent.id from RG_SnapshotNodeEntity snapshot where snapshot.id =:id").setParameter("id", snapId).uniqueResult();
                                List<RG_SnapshotNodeEntity> snapshotEntity2 = (List<RG_SnapshotNodeEntity>) session.createQuery("select snapshot from RG_SnapshotNodeEntity snapshot where snapshot.rootParent.id =:rootId and snapshot.parent.id <>:id").setParameter("rootId", rootId).setParameter("id", middleId).list();

                                *//*for(RG_ResourceEntity resource : resourceEntity2){
                                    long second = getTimeSpan(resource,session);    //初次排程的时间跨度
                                    secondSum += second;
                                }*//*

                                if (snapshotEntity2 != null) {
                                    for (RG_SnapshotNodeEntity snapshot2 : snapshotEntity2) {
                                        String snapId2 = snapshot2.getId();

                                        String t1TaskResource2 = (String) session.createQuery("select MIN(t1Task) from RG_PlanEntity plan where plan.idTask =:idTask and plan.snapShort.id =:snapshotId").setParameter("idTask", idTask).setParameter("snapshotId", snapId2).uniqueResult();
                                        if (t1TaskResource2 != null) {
                                            Date t1TaskResource22 = sdf.parse(t1TaskResource2);

                                            if ((t1TaskResource11 != null) && (t1TaskResource22 != null) && (t1TaskResource22.getTime() - t1TaskResource11.getTime()) > (24 * 60 * 60)) {
                                                overSpan++;
                                            }
                                        }


                                    }
                                }


                            }

                        }
                    }

                    //计算跨度超过滚动周期的工序数量


                }*/



                //计算资源利用率
                long spanSum = 0;

                //1、找到所有资源
                List<RG_ResourceEntity> resourceEntity = (List<RG_ResourceEntity>) session.createQuery("select DISTINCT plan.resourceByIdResource from RG_PlanEntity plan where plan.snapShort.id =:idSnapshot").setParameter("idSnapshot", snapshotId).list();

                /*//连接数据库
                //加载驱动
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/testdatabase?serverTimezone=UTC";
                String username = "root";
                String password = "root";

                //得到连接对象
                Connection conn = DriverManager.getConnection(url,username,password);


                //每次先清空利用率表
                String sql0 = "delete from rg_resourcerate";

                //得到PreparedStatement对象
                PreparedStatement pstmt0 = conn.prepareStatement(sql0);
                pstmt0.executeUpdate();*/

                //2、遍历每个资源，获取它所对应的t1Task和t2Task

                String slot = null;
                long shiftSpan = 0;
                List<RG_ResourceRateEntity> listRate = new ArrayList<RG_ResourceRateEntity>();

                if (resourceEntity != null) {
                    for (RG_ResourceEntity resource : resourceEntity) {   //11个

                        spanSum = getTimeSpan(resource, session, snapshotId);

                        //TODO 计算班次时间跨度
                        Set<RG_ShiftEntity> shifts = resource.getShiftsById();
                        for (RG_ShiftEntity shift : shifts) {   //只有一个班次
                            slot = shift.getSlot();

                        }

                        String slot1 = slot.substring(1, 9);
                        String slot2 = slot.substring(11, 19);

                        /*Date slot11 = sdf2.parse(slot1);
                        Date slot12 = sdf2.parse(slot2);*/

                        Date slot11 = sdf2.parse(slot1);
                        Date slot12 = sdf2.parse(slot2);

                        long shiftSpan0 = slot12.getTime() - slot11.getTime();
                        shiftSpan = (long)(shiftSpan0/1000);


                        RG_ResourceRateEntity resourceRate = new RG_ResourceRateEntity();
                        if (scheduleWindow != 0 && shiftSpan != 0) {
                            double rate = (double) (100.0 * spanSum / (scheduleWindow * shiftSpan));

                            String id = Tools.getUUID();
                            String idSnapshot = snapshotId;
                            String idResource = resource.getIdR();
                            /*resourceRate.setId(Tools.getUUID());
                            resourceRate.setIdResource(resource.getIdR());
                            resourceRate.setIdSnapshot(snapshotId);
                            resourceRate.setRate(rate);
                            listRate.add(resourceRate);*/

                            //sql
                            String sql = "insert into rg_resourcerate(id,idSnapshot,idResource,rate) values(?,?,?,?)";

                            //得到PreparedStatement对象
                            PreparedStatement pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1,id);
                            pstmt.setString(2,idSnapshot);
                            pstmt.setString(3,idResource);
                            pstmt.setDouble(4,rate);
                            pstmt.executeUpdate();

                           /* String sql = "insert into rg_resourcerate(id,idSnapshot,idResource,rate) values(id,snapshotId,res,?)";
                            session.createNativeQuery("select * from rg_resourcestate where resourceId = ? order by currTime desc limit 0,1").addEntity(RG_ResourceStateEntity.class);
                            query.setParameter(1, code);
                            List list = query.list();*/
                        }


                        //resource.setRate();
                    }
                }


                /*System.out.println(session.isOpen());
                RG_SnapShotResult rg_result = new RG_SnapShotResult();
                //rg_result.setId(Tools.getUUID());
                rg_result.setId(snapshotId);
                rg_result.setSpan(taskSpan);
                rg_result.setDelayOrder(count);
                rg_result.setDelaySum(sum);
                rg_result.setUseRate(listRate);
                rg_result.setChangeNum(countChange);
                rg_result.setOverSpan(overSpan);
                resultList.add(rg_result);*/
            }

            System.out.println(session.isOpen());
            RG_SnapShotResult rg_result = new RG_SnapShotResult();
            //rg_result.setId(Tools.getUUID());
            rg_result.setId(snapshotId);
            rg_result.setSpan(taskSpan);
            rg_result.setDelayOrder(count);
            rg_result.setDelaySum(sum);
            //rg_result.setUseRate(listRate);
            rg_result.setChangeNum(countChange);
            rg_result.setOverSpan(overSpan);
            resultList.add(rg_result);
        }

        conn.close();

        System.out.println(session.isOpen());
        String jsonString = Tools.entityConvertToJsonString(resultList);

        Tools.jsonPrint(jsonString, this.httpServletResponse);


    }

    //计算某个资源时间跨度
    private static long getTimeSpan(RG_ResourceEntity resource, Session session, String idSnapshot) throws ParseException {
        long spanSum = 0;

        String resourceId = resource.getIdR();

        List<RG_PlanEntity> planEntity1 = (List<RG_PlanEntity>) session.createQuery("select plan from RG_PlanEntity plan where plan.resourceByIdResource.id =:idResource and plan.snapShort.id =:idSnapshot").setParameter("idResource", resourceId).setParameter("idSnapshot", idSnapshot).list();


                /*List<String> t1Tasklist = new ArrayList<String>();
                List<String> t2Tasklist = new ArrayList<String>();*/

        Map<String, String> map = new TreeMap<String, String>(
                new Comparator<String>() {
                    public int compare(String obj1, String obj2) {
                        // 升序排序
                        return obj1.compareTo(obj2);
                    }
                });

        for (RG_PlanEntity plan1 : planEntity1) {
            String plant1Task = plan1.getT1Task();
            String plant2Task = plan1.getT2Task();


            map.put(plant1Task, plant2Task);

        }

        System.out.println(map);

        Set<String> keySet = map.keySet();
        Iterator<String> iter = keySet.iterator();
        while (iter.hasNext()) {
            String key1 = iter.next();
            //System.out.println(key + ":" + map.get(key));
            while (iter.hasNext()) {
                String key2 = iter.next();

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");

                Date spanvalue1 = sdf.parse(map.get(key1));
                Date spanvalue2 = sdf.parse(map.get(key2));
                Date spankey1 = sdf.parse(key1);
                Date spankey2 = sdf.parse(key2);

                        /*
                        * 3、判断是否相交
                        *    相交：(t6-t5)+(t4 -t1)
                        *    不相交：(t6-t5)+(t4-t3)+(t2-t1)
                        * */
                if (!key1.equals(key2)) {
                    long spanminus = spanvalue1.getTime() - spankey2.getTime();

                    if (spanminus > 0) { //相交
                        spanSum += ((spanvalue2.getTime() - spankey1.getTime())/1000);
                        //TODO 两两相交
                    } else if(spanminus < 0){ //不相交
                        if(spanSum == 0 ){  //开始时前两个相加
                            spanSum += ((spanvalue1.getTime() - spankey1.getTime())/1000) + ((spanvalue2.getTime() - spankey2.getTime())/1000);
                        }else{
                            spanSum += ((spanvalue2.getTime() - spankey2.getTime())/1000);
                        }

                    }
                }

                key1 = key2;

            }
        }
        //System.out.println(spanSum);

        return spanSum;
    }

    public void fingRateById() throws Exception {

        MySessionFactory.getSessionFactory().getCurrentSession().close();
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        //transaction.begin();
        if (!transaction.isActive()) {
            session.beginTransaction();
        }

        JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(this.httpServletRequest));
        String snapshotId = jsonNode.get("id").asText();

        List<RG_ResourceEntity> resourceEntity = (List<RG_ResourceEntity>) session.createQuery("select DISTINCT plan.resourceByIdResource from RG_PlanEntity plan where plan.snapShort.id =:idSnapshot").setParameter("idSnapshot", snapshotId).list();


        List list = new ArrayList();
        if (resourceEntity != null) {
            for (RG_ResourceEntity resource : resourceEntity) {   //11个
                String resourceID = resource.getIdR();
                /*List list1 = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, "select * from APS_ORDER_RESOURCE_RATE where IDRESOURCE =" + "\'" + resourceID + "\'");

                list.add(list1.get(0));*/

                RG_ResourceRateEntity rateEntity = (RG_ResourceRateEntity)session.createQuery("select rg_resourcerate from RG_ResourceRateEntity rg_resourcerate where idResource =:idResource and idSnapshot =:idSnapshot").setParameter("idResource",resourceID).setParameter("idSnapshot",snapshotId).uniqueResult();
                list.add(rateEntity);
            }
        }

        String jsonString = Tools.entityConvertToJsonString(list);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
    }

}
