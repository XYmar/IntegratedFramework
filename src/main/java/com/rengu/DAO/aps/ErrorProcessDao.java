package com.rengu.DAO.aps;

import com.rengu.entity.*;
import com.rengu.util.*;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * 用于aps进行异常的处理
 * Created by wey580231 on 2017/6/15.
 */
public class ErrorProcessDao {

    //设备故障
    public Integer processDeviceError(String id) throws SQLException, ClassNotFoundException {

        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        if (!session.getTransaction().isActive()) {
            session.beginTransaction();
        }

        Integer result = ApsTools.UNKNOWN;

        List list = session.createQuery("from RG_AdjustDeviceEntity entity where entity.id=:id").setParameter("id", id).list();

        if (list.size() == 1 && list.get(0) instanceof RG_AdjustDeviceEntity) {
            RG_AdjustDeviceEntity entity = (RG_AdjustDeviceEntity) list.get(0);


            if(entity.getState() == 0){ //恢复资源
                //从资源表找到对应的资源
                String idResource = entity.getResoureId();
                RG_ResourceEntity resourceEntity = DAOFactory.getResourceInstance().findAllById(session,idResource);

                //将资源表该资源State更新为1
                Byte b = 1;
                resourceEntity.setState(b);

                //APS将资源表该资源State更新为1
                String sql1 = "UPDATE " + DatabaseInfo.APS_RESOURCE + " SET STATE = 1 WHERE ID = '" + idResource + "'";
                Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql1);

                //调重启订单接口
                result = ApsTools.instance().executeCommand(ApsTools.ResumeOrderHandlingURL());

               /* Byte orderState = 0;
                List<RG_OrderEntity> orderEntityList = DAOFactory.getOrdersDAOInstance().findByState(orderState);*/

                //查询APS订单表，判断是否有候选订单，state=0
                String sql = "SELECT * FROM " + DatabaseInfo.APS_ORDER + " WHERE STATE = 0";
                List orderList = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql);

                if (orderList.size() > 0) {
                    ApsTools.instance().getInterAdjust();
                }
            }else if(entity.getState() == 1){//撤销资源
                //调撤销接口
                result = ApsTools.instance().executeCommand(ApsTools.instance().getCancelDeviceURL(entity));

                String idResource = entity.getResoureId();

                //从资源表找到对应的资源
                RG_ResourceEntity resourceEntity = DAOFactory.getResourceInstance().findAllById(session,idResource);

                //此资源的类型
                String idTypeResource = resourceEntity.getIdTypeResource();

                //找到此类型的资源的集合
                List<RG_ResourceEntity> resourceEntityList = (List<RG_ResourceEntity>) session.createQuery("select resource from RG_ResourceEntity resource where resource.idTypeResource =:idTypeResource").setParameter("idTypeResource", idTypeResource).list();

                //判断资源是否单个
                if (resourceEntityList.size() == 1) {  //单个
                    /*ApsTools.instance().executeCommand(ApsTools.instance().getCancelDeviceURL(adjustDeviceEntity));*/
                    WebSocketNotification.broadcast(Tools.creatNotificationMessage("资源不足，无法计算", "alert"));

                } else {    //不是单个
                    //查询APS订单表，判断是否有候选订单，state=0
                    String sql = "SELECT * FROM " + DatabaseInfo.APS_ORDER + " WHERE STATE = 0";
                    List orderList = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql);
                    //List<RG_OrderEntity> orderEntityList = (List<RG_OrderEntity>) session.createQuery("select order from RG_OrderEntity order where order.state =:state").setParameter("state", 0).list();

                    if (orderList.size() > 0) {
                        ApsTools.instance().getInterAdjust();

                    }

                }
            }


            //撤销资源
            /*if (entity.getCancelTime() != null && entity.getLatestCancelTime() != null) {
                result = ApsTools.instance().executeCommand(ApsTools.instance().getCancelDeviceURL(entity));
            }
            //设置时段不可用
            else if (entity.getUnavailableStartDate() != null && entity.getUnavailableEndDate() != null) {
                result = ApsTools.instance().executeCommand(ApsTools.instance().getUnavailableDeviceURL(entity));
            }*/

            //更新故障的状态、创建
            if (result == ApsTools.STARTED) {
                entity.setState(ErrorState.ERROR_APS_PROCESS);
                entity.setProcessTime(new Date());
                createSnapNode("设备异常应急优化", "rg_adjustdevice", id);
                session.update(entity);
            }
        }

        session.getTransaction().commit();

        return result;
    }

    //紧急插单
    public Integer processOrderError(String id) {
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        if (!session.getTransaction().isActive()) {
            session.beginTransaction();
        }

        Integer result = ApsTools.UNKNOWN;

        Query query = session.createQuery("from RG_AdjustOrderEntity entity where entity.id=:id");
        query.setParameter("id", id);
        List list = query.list();
        if (list.size() == 1 && list.get(0) instanceof RG_AdjustOrderEntity) {
            RG_AdjustOrderEntity entity = (RG_AdjustOrderEntity) list.get(0);

            RG_ProductEntity product = entity.getOrd().getProductByIdProduct();

            result = ApsTools.instance().executeCommand(ApsTools.instance().getAdjustOrderHandlingURL(entity));

            //更新故障的状态、创建
            if (result == ApsTools.STARTED) {
                entity.setState(ErrorState.ERROR_APS_PROCESS);
                entity.setProcessTime(new Date());
                createSnapNode("紧急插单应急优化", "rg_adjustorder", id);

                String lastesScheduleId = UserConfigTools.getLatestSchedule("1");
                if (lastesScheduleId != null && lastesScheduleId.length() > 0) {
                    RG_ScheduleEntity scheduleEntity = session.get(RG_ScheduleEntity.class, lastesScheduleId);
                    if (scheduleEntity != null) {
                        scheduleEntity.getOrders().add(entity.getOrd());
                        session.update(scheduleEntity);
                    }
                }
                session.update(entity);
            }
        }

        session.getTransaction().commit();

        return result;
    }

    //工序异常
    public Integer processProcessError(String id) {
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        if (!session.getTransaction().isActive()) {
            session.beginTransaction();
        }

        Integer result = ApsTools.UNKNOWN;

        Query query = session.createQuery("from RG_AdjustProcessEntity entity where entity.id=:id");
        query.setParameter("id", id);
        List list = query.list();
        if (list.size() == 1) {
            RG_AdjustProcessEntity entity = (RG_AdjustProcessEntity) list.get(0);

            entity.setState(ErrorState.ERROR_APS_PROCESS);
            entity.setProcessTime(new Date());
            createSnapNode("工序异常应急优化", "rg_adjustprocess", id);
            session.update(entity);

            result = ApsTools.instance().executeCommand(ApsTools.instance().getAdjustProcessHandlingURL(entity));

            //更新故障的状态、创建
            if (result == ApsTools.STARTED) {

            }
        }

        session.getTransaction().commit();

        return result;
    }

    //创建故障应急节点
    private void createSnapNode(String name, String errorType, String errorId) {
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from RG_SnapshotNodeEntity entity where entity.id=:id");
        query.setParameter("id", UserConfigTools.getRootSnapId("1"));
        List list = query.list();
        if (list.size() > 0 && list.get(0) instanceof RG_SnapshotNodeEntity) {
            RG_SnapshotNodeEntity rootSnapshot = (RG_SnapshotNodeEntity) list.get(0);

            RG_SnapshotNodeEntity middleSnapshot = new RG_SnapshotNodeEntity();
            middleSnapshot.setId(Tools.getUUID());
            middleSnapshot.setName(name);
            middleSnapshot.setLevel(SnapshotLevel.MIDDLE);
            middleSnapshot.setNodeCreateTime(new Date());
            middleSnapshot.setApply(false);
            middleSnapshot.setParent(rootSnapshot);
            middleSnapshot.setRootParent(rootSnapshot);
            middleSnapshot.setErrorNode(true);
            middleSnapshot.setFirstNode(true);
            middleSnapshot.setApsBackupSnaoshot(false);
            middleSnapshot.setApsDispatchOrder(false);
            middleSnapshot.setApsRecoverSnapshot(false);

            UserConfigTools.updateMiddleSnapshotId("1", middleSnapshot.getId(), true);
            UserConfigTools.updateApsReplyCount("1", 0);
            UserConfigTools.updateErroInfo("1", errorType, errorId);

            rootSnapshot.getChilds().add(middleSnapshot);
            session.save(rootSnapshot);
        }
    }
}
