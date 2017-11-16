package com.rengu.DAO.d3;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.rengu.actions.mes.MesReceiver;
import com.rengu.entity.*;
import com.rengu.util.MyLog;
import com.rengu.util.MySessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import java.lang.annotation.Native;
import java.util.*;
import java.util.logging.Logger;

/**
 * Created by wey580231 on 2017/6/6.
 */
public class Emulate3DAO {

    @Deprecated
    public boolean getEmulateData(String snapshotId, StringBuilder jsonString) {
        boolean flag = false;
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();

        if (!session.getTransaction().isActive()) {
            session.beginTransaction();
        }

        RG_SnapshotNodeEntity bottomSnapshot = session.get(RG_SnapshotNodeEntity.class, snapshotId);

        Set<RG_OrderEntity> orders = null;

        if (bottomSnapshot != null) {

            RG_SnapshotNodeEntity rootSnapshot = bottomSnapshot.getRootParent();

            if (rootSnapshot != null) {
                //查找此次排程对应的订单信息
                RG_ScheduleEntity scheduleEntity = rootSnapshot.getSchedule();
                if (scheduleEntity != null) {
                    orders = scheduleEntity.getOrders();
                }
            }
        }

        if (orders != null) {
            Iterator<RG_OrderEntity> iter = orders.iterator();

            ObjectMapper mapper = new ObjectMapper();               //定义转换类
            ObjectNode root = mapper.createObjectNode();            //创建根节点
            root.put("result", "0");

            ArrayNode array = mapper.createArrayNode();

            while (iter.hasNext()) {

                ObjectNode dataNode = mapper.createObjectNode();

                RG_OrderEntity entity = iter.next();

                RG_ProductEntity product = entity.getProductByIdProduct();
                List<RG_EmulateDataEntity> emulateDatas = entity.getEmulateDatas();
                Iterator<RG_EmulateDataEntity> emulateIter = emulateDatas.iterator();

                ArrayNode arrayNode = mapper.createArrayNode();

                while (emulateIter.hasNext()) {
                    RG_EmulateDataEntity emulateData = emulateIter.next();

                    if (emulateData != null) {
                        ObjectNode node = mapper.createObjectNode();

                        node.put("item", emulateData.getItem());
                        node.put("state", emulateData.getState());
                        node.put("good", emulateData.getGood());
                        node.put("startLocation", emulateData.getStartLocation());
                        node.put("ednLocation", emulateData.getEndLocation());
                        node.put("startTime", Integer.parseInt(emulateData.getStartTime()));
                        node.put("endTime", Integer.parseInt(emulateData.getEndTime()));

                        arrayNode.add(node);
                    }
                }

                dataNode.put("id", entity.getId());
                dataNode.put("name", product.getName());
                dataNode.put("info", arrayNode);

                array.add(dataNode);
            }

            root.put("data", array);

            try {
                jsonString.append(mapper.writeValueAsString(root));
                flag = true;
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        session.getTransaction().commit();

        return flag;
    }

    //获取新格式排程结果
    public boolean getEmulateResult(String snapshotId, StringBuilder jsonString) {
        boolean flag = false;
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        RG_SnapshotNodeEntity bottomSnapshot = session.get(RG_SnapshotNodeEntity.class, snapshotId);

        Set<RG_OrderEntity> orders = null;

        if (bottomSnapshot != null) {

            RG_SnapshotNodeEntity rootSnapshot = bottomSnapshot.getRootParent();

            if (rootSnapshot != null) {
                //查找此次排程对应的订单信息
                RG_ScheduleEntity scheduleEntity = rootSnapshot.getSchedule();
                if (scheduleEntity != null) {
                    orders = scheduleEntity.getOrders();
                }
            }
        }

        if (orders != null) {
            Iterator<RG_OrderEntity> iter = orders.iterator();

            ObjectMapper mapper = new ObjectMapper();               //定义转换类
            ObjectNode root = mapper.createObjectNode();            //创建根节点
            root.put("result", "0");

            ArrayNode array = mapper.createArrayNode();

            while (iter.hasNext()) {
                ObjectNode dataNode = mapper.createObjectNode();

                RG_OrderEntity entity = iter.next();

                RG_ProductEntity product = entity.getProductByIdProduct();

                NativeQuery query = session.createNativeQuery("select * from rg_emulateresult where idOrder = ? and idSnapshort is null order by startTime asc", RG_EmulateResultEntity.class);
                query.setParameter(1, entity.getId());

                List<RG_EmulateResultEntity> emulateDatas = query.list();
                Iterator<RG_EmulateResultEntity> emulateIter = emulateDatas.iterator();

                ArrayNode arrayNode = mapper.createArrayNode();

                while (emulateIter.hasNext()) {
                    RG_EmulateResultEntity emulateData = emulateIter.next();

                    if (emulateData != null) {
                        ObjectNode node = mapper.createObjectNode();

                        node.put("task", emulateData.getTask());
                        node.put("good", emulateData.getGoods());
                        node.put("startTime", emulateData.getStartTime());
                        node.put("endTime", emulateData.getEndTime());

                        if (emulateData.getSite() != null && emulateData.getSite().length() > 0) {
                            node.put("site", emulateData.getSite());
                        } else {
                            node.put("site", "");
                        }

                        if (emulateData.getIdTask() != null && emulateData.getIdTask().length() > 0) {
                            node.put("idTask", emulateData.getIdTask());
                        } else {
                            node.put("idTask", "");
                        }

                        if (emulateData.getOrderEntity() != null && emulateData.getOrderEntity().getId().length() > 0) {
                            node.put("idOrder", emulateData.getOrderEntity().getId());
                        } else {
                            node.put("idOrder", "");
                        }

                        arrayNode.add(node);
                    }
                }

                ArrayNode deviceNode = mapper.createArrayNode();

                //Yang 20170808 获取参与此次订单的所有设备
                query = session.createNativeQuery("select distinct idResource from rg_plan rp left join rg_resource rr on rp.idResource = rr.id where rr.critical='T'and rp.idResource !='UR5' and rp.idOrder=:idOrder and rp.idSnapshort =:idSnapshort");
                query.setParameter("idOrder", entity.getId());
                query.setParameter("idSnapshort", snapshotId);
                List<String> deviceList = query.list();
                for (String dev : deviceList) {
                    deviceNode.add(dev);
                }
                deviceNode.add("KR16_CQ");
                deviceNode.add("UR5");

                dataNode.put("id", entity.getId());
                dataNode.put("name", entity.getName());
                dataNode.put("info", arrayNode);
                dataNode.put("device", deviceNode);

                ObjectNode orderInfoNode = mapper.createObjectNode();
                orderInfoNode.put("id", entity.getId());
                orderInfoNode.put("name", entity.getName());
                orderInfoNode.put("startTime", emulateDatas.get(0).getStartTime());
                orderInfoNode.put("endTime", emulateDatas.get(emulateDatas.size() - 1).getEndTime());

                dataNode.put("orderTime",orderInfoNode);

                array.add(dataNode);
            }

            root.put("data", array);

            try {
                jsonString.append(mapper.writeValueAsString(root));
                flag = true;
                tx.commit();
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                flag = false;
                tx.rollback();
            }
        } else {
            tx.commit();
        }

        MyLog.getLogger().info("*************************按订单查询结果*******************************");
        MyLog.getLogger().info(jsonString);
        MyLog.getLogger().info("*********************************************************************");

        session.close();

        return flag;
    }

    //获取所有订单信息，利用在快招树节点转换后的结果，直接查询
    public boolean getAllOrderEmulateResult(String snapshotId, StringBuilder jsonString) {
        boolean flag = false;
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        NativeQuery query = session.createNativeQuery("select * from rg_emulateresult where idSnapshort=:id order by startTime asc", RG_EmulateResultEntity.class);
        query.setParameter("id", snapshotId);

        List<RG_EmulateResultEntity> results = query.list();

        if (results.size() > 0) {

            ObjectMapper mapper = new ObjectMapper();               //定义转换类
            ObjectNode root = mapper.createObjectNode();            //创建根节点
            root.put("result", "0");

            ArrayNode array = mapper.createArrayNode();

            ObjectNode dataNode = mapper.createObjectNode();
            dataNode.put("id", "All Orders");
            dataNode.put("name", "orders");

            ArrayNode arrayNode = mapper.createArrayNode();

            List<OrderInfo> orderInfo = new ArrayList<OrderInfo>();

            for (int i = 0; i < results.size(); i++) {
                RG_EmulateResultEntity entity = results.get(i);
                ObjectNode node = mapper.createObjectNode();

                node.put("task", entity.getTask());
                node.put("good", entity.getGoods());
                node.put("startTime", entity.getStartTime());
                node.put("endTime", entity.getEndTime());

                if (entity.getSite() != null) {
                    node.put("site", entity.getSite());
                } else {
                    node.put("site", "");
                }

                if (entity.getIdTask() != null) {
                    node.put("idTask", entity.getIdTask());
                } else {
                    node.put("idTask", "");
                }

                if (entity.getOrderEntity() != null && entity.getOrderEntity().getId().length() > 0) {
                    node.put("idOrder", entity.getOrderEntity().getId());
                } else {
                    node.put("idOrder", "");
                }

                //Yang-20171023计算多个订单中每个订单的开始、结束时间
                boolean exist = false;
                for (OrderInfo info : orderInfo) {
                    if (entity.getOrderEntity() != null) {
                        if (info.getId().equals(entity.getOrderEntity().getId())) {

                            info.setMaxTime(entity.getEndTime());

                            exist = true;
                        }
                    }
                }

                if (!exist) {
                    OrderInfo info = new OrderInfo();
                    info.setId(entity.getOrderEntity().getId());
                    info.setName(entity.getOrderEntity().getName());
                    info.setMinTime(entity.getStartTime());
                    info.setMaxTime(entity.getEndTime());
                    orderInfo.add(info);
                }

                arrayNode.add(node);
            }
            ArrayNode deviceNode = mapper.createArrayNode();

            //Yang 20170808 获取参与此次订单的所有设备
            query = session.createNativeQuery("select distinct idResource from rg_plan rp left join rg_resource rr on rp.idResource = rr.id where rr.critical='T'and rp.idResource !='UR5' and rp.idSnapshort =:idSnapshort");
            query.setParameter("idSnapshort", snapshotId);
            List<String> deviceList = query.list();
            for (String dev : deviceList) {
                deviceNode.add(dev);
            }
            deviceNode.add("KR16_CQ");
            deviceNode.add("UR5");

            dataNode.put("info", arrayNode);
            dataNode.put("device", deviceNode);

            array.add(dataNode);

            ArrayNode orderTimeNode = mapper.createArrayNode();

            for (OrderInfo info : orderInfo) {
                ObjectNode node = mapper.createObjectNode();
                node.put("id", info.getId());
                node.put("name", info.getName());
                node.put("startTime", info.getMinTime());
                node.put("endTime", info.getMaxTime());

                orderTimeNode.add(node);
            }

            dataNode.put("orderTime", orderTimeNode);

            root.put("data", array);

            try {
                jsonString.append(mapper.writeValueAsString(root));
                flag = true;
                tx.commit();
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                flag = false;
                tx.rollback();
            }
        } else {
            tx.commit();
        }

        session.close();

        MyLog.getLogger().info("*************************按快照查询结果*******************************");
        MyLog.getLogger().info(jsonString);
        MyLog.getLogger().info("*********************************************************************");

        return flag;
    }
}

class OrderInfo {
    private String id;
    private String name;
    private int minTime;
    private int MaxTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMinTime() {
        return minTime;
    }

    public void setMinTime(int minTime) {
        this.minTime = minTime;
    }

    public int getMaxTime() {
        return MaxTime;
    }

    public void setMaxTime(int maxTime) {
        MaxTime = maxTime;
    }
}