package com.rengu.actions.mes;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.actions.AdjustDeviceAction;
import com.rengu.entity.*;
import com.rengu.util.*;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.TextMessage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.BlockingQueue;

/**
 * 多线程解析active'MQ消息
 * Created by wey580231 on 2017/7/5.
 */
public class MesConsumer extends Thread {

    private BlockingQueue<Message> messages;

    private boolean runningFlag = false;

    public MesConsumer(BlockingQueue<Message> messages) {
        this.setName("MesConsumer");
        this.messages = messages;
    }

    @Override
    public void run() {
        while (runningFlag) {
            try {
                Message mess = messages.take();
                if (mess instanceof TextMessage) {
                    TextMessage tx = (TextMessage) mess;
                    parseMessage(tx.getText());
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            } catch (JMSException e) {
                e.printStackTrace();
            }
        }
    }

//    private void parseMessage(String message, int a) {
//        JsonNode jsonNode = null;
//        try {
//            jsonNode = Tools.jsonTreeModelParse(message);
//            String mesType = jsonNode.get("FC").asText();                //功能编码
//            String UUID = jsonNode.get("UUID").asText();                 //接收消息UUID，用于在回复时加入
//            JsonNode dataNode = jsonNode.get("DATA");
//            System.out.println("消息类型：" + mesType + "，接受到消息+:" + message);
//            Session session = MySessionFactory.getSessionFactory().openSession();
//            session.beginTransaction();
//            //产品表
//            if (mesType.equals(MessTable.MES_PRODUCT)) {
//                RG_ProductEntity rg_productEntity = session.get(RG_ProductEntity.class, dataNode.get("id").asText());
//                if (rg_productEntity == null) {
//                    rg_productEntity = new RG_ProductEntity();
//                }
//                rg_productEntity.setId(dataNode.get("id").asText());
//                rg_productEntity.setName(dataNode.get("name").asText());
//                rg_productEntity.setStock((short) dataNode.get("stock").asInt());
//                rg_productEntity.setUnit(dataNode.get("unit").asText());
//                rg_productEntity.setModel(dataNode.get("model").asText());
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

    //信息解析
    private void parseMessage(String message) {
        try {
            JsonNode root = Tools.jsonTreeModelParse(message);
            String mesType = root.get("FC").asText();                //功能编码
            String UUID = root.get("UUID").asText();                 //接收消息UUID，用于在回复时加入
            String sender = root.get("SENDER").asText();
            JsonNode dataNode = root.get("DATA");
            String idSnapShort = UserConfigTools.getLatestDispatchMesId("1");
            Session session = MySessionFactory.getSessionFactory().openSession();
            session.beginTransaction();
            //保存消息历史
            RG_MesMessageLog rg_mesMessageLog = new RG_MesMessageLog();
            rg_mesMessageLog.setId(Tools.getUUID());
            rg_mesMessageLog.setMessageType(mesType);
            rg_mesMessageLog.setReceiveTime(new Date());
            rg_mesMessageLog.setMessage(message);
            session.save(rg_mesMessageLog);
            System.out.println("消息类型：" + mesType + "，接受到消息+:" + message);
            //【已调】产品
            if (mesType.equals(MessTable.MES_PRODUCT)) {

                RG_ProductEntity product = null;

                product = session.get(RG_ProductEntity.class, dataNode.get("id").asText());

                if (product == null) {
                    product = new RG_ProductEntity();
                }
                product.setId(dataNode.get("id").asText());
                product.setName(dataNode.get("name").asText());
                product.setStock((short) dataNode.get("stock").asInt());
                product.setUnit(dataNode.get("unit").asText());
                if (dataNode.has("model")) {
                    product.setModel(dataNode.get("model").asText());
                }

                session.saveOrUpdate(product);
            }
            //【已调】资源
            else if (mesType.equals(MessTable.MES_RESOURCE)) {
                RG_ResourceEntity resource = null;

                resource = session.get(RG_ResourceEntity.class, dataNode.get("id").asText());

                if (resource == null) {
                    resource = new RG_ResourceEntity();
                }

                resource.setIdR(dataNode.get("id").asText());
                resource.setName(dataNode.get("name").asText());
                resource.setMobility((short) dataNode.get("mobility").asInt());

                session.saveOrUpdate(resource);
            }
            //【已调】地点
            else if (mesType.equals(MessTable.MES_SITE)) {

                if (dataNode.isArray()) {
                    for (int i = 0; i < dataNode.size(); i++) {
                        JsonNode subNode = dataNode.get(i);
                        Query query = session.createQuery("from RG_SiteEntity rg_siteEntity where rg_siteEntity.mesId =:mesId");
                        query.setParameter("mesId", subNode.get("id").asText());
                        RG_SiteEntity rg_siteEntity = (RG_SiteEntity) query.uniqueResult();
                        if (rg_siteEntity != null) {
//                            rg_siteEntity.setX(Short.parseShort(subNode.get("x").asText()));
//                            rg_siteEntity.setY(Short.parseShort(subNode.get("y").asText()));
//                            rg_siteEntity.setCapacity(Short.parseShort(subNode.get("capacity").asText()));
                        }
                    }
                }
            }
            //【已调】地点距离
            else if (mesType.equals(MessTable.MES_SITE_DISTANCE)) {
                if (dataNode.isArray()) {
                    for (int i = 0; i < dataNode.size(); i++) {
                        JsonNode subNode = dataNode.get(i);

                        String idSite1 = subNode.get("idSite1").asText();
                        String idSite2 = subNode.get("idSite2").asText();

                        RG_SiteEntity site1 = (RG_SiteEntity) session.get(RG_SiteEntity.class, idSite1);
                        RG_SiteEntity site2 = (RG_SiteEntity) session.get(RG_SiteEntity.class, idSite2);


                        if (site1 != null && site2 != null) {
                            RG_DistanceEntity distance = new RG_DistanceEntity();

                            List<RG_DistanceEntity> rg_distanceEntityList = session.createQuery("select distance from RG_DistanceEntity distance where distance.startSite.id =:idSite1 and distance.endSite.id =:idSite2").setParameter("idSite1", idSite1).setParameter("idSite2", idSite2).list();

                            for (RG_DistanceEntity rg_distanceEntity : rg_distanceEntityList) {
                                if (rg_distanceEntity != null) {
                                    String idDistance = rg_distanceEntity.getId();
                                    int distance3 = subNode.get("distance").asInt();
                                    session.createNativeQuery("update rg_distance set distance = ?").setParameter(1, distance3).executeUpdate();
                                    session.delete(rg_distanceEntity);
                                    distance.setId(idDistance);
                                    distance.setStartSite(site1);
                                    distance.setEndSite(site2);
                                    distance.setDistance(subNode.get("distance").asInt());
                                } else {
                                    distance.setId(Tools.getUUID());
                                    distance.setStartSite(site1);
                                    distance.setEndSite(site2);
                                    distance.setDistance(subNode.get("distance").asInt());
                                    session.saveOrUpdate(distance);
                                }
                            }
                        }
                    }
                }
            }
            //监控信息
            else if (mesType.equals(MessTable.MES_REAL_INFO)) {
                String type = dataNode.get("type").asText();
                //【已调】立体仓库信息
                //TODO 仓库信息中含有多个货物，修改保存的方式
                if (type.equals(MessTable.MES_DEPORT_INFO)) {
                    JsonNode subDataNode = dataNode.get("data");
                    if (subDataNode.isArray()) {
                        for (int i = 0; i < subDataNode.size(); i++) {
                            JsonNode realData = subDataNode.get(i);

                            RG_Mes_DeportInfo deportInfo = new RG_Mes_DeportInfo();

                            if (realData.get("name") != null && realData.get("name").isArray()) {
                                JsonNode nameNode = realData.get("name");
                                /*for (int j = 0; j < nameNode.size(); j++) {
                                }*/
                                deportInfo.setDeportName(nameNode.toString());
                            }

                            if (realData.get("productId") != null && realData.get("productId").isArray()) {
                                JsonNode product = realData.get("productId");
                                for (int j = 0; j < product.size(); j++) {

                                }
                            }

                            deportInfo.setId(Tools.getUUID());
                            deportInfo.setDeportId(realData.get("id").asText());
//                            deportInfo.setDeportName(subDataNode.get("name").asText());
                            deportInfo.setStock(Integer.parseInt(realData.get("stock").asText()));
//                            deportInfo.setTotalPlace(Integer.parseInt(subDataNode.get("totalPlace").asText()));
                            deportInfo.setFreePlace(Integer.parseInt(realData.get("freePlace").asText()));
                            deportInfo.setReportTime(new Date());
                            session.save(deportInfo);
                        }
                    }
                }
                //尺寸精度检测
                else if (type.equals(MessTable.MES_DEGREE_INFO)) {
                    RG_DegreeAccuracyInfo rg_degreeAccuracyInfo = new RG_DegreeAccuracyInfo();
                    rg_degreeAccuracyInfo.setId(Tools.getUUID());
                    rg_degreeAccuracyInfo.setReportTime(new Date());
                    rg_degreeAccuracyInfo.setCarryId(dataNode.get("id").asText());
                    rg_degreeAccuracyInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    rg_degreeAccuracyInfo.setIdOrder(dataNode.get("idOrder").asText());

                    String mesSign = "degree";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    session.save(rg_degreeAccuracyInfo);
                }
                //电性能检测
                else if (type.equals(MessTable.MES_ELECTRICITY_INFO)) {
                    RG_ElectricityInfo rg_electricityInfo = new RG_ElectricityInfo();
                    rg_electricityInfo.setId(Tools.getUUID());
                    rg_electricityInfo.setReportTime(new Date());
                    rg_electricityInfo.setCarryId(dataNode.get("id").asText());
                    rg_electricityInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    rg_electricityInfo.setIdOrder(dataNode.get("idOrder").asText());
                    rg_electricityInfo.setState(dataNode.get("state").asBoolean());

                    String mesSign = "elec";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    /*RG_ResourceEntity resource = (RG_ResourceEntity)session.createQuery("select resource from RG_ResourceEntity resource where resource.mesSign =:mesSign").setParameter("mesSign",mesSign).uniqueResult();
                    String idResource = resource.getIdR();
                    Byte state = resource.getState();
                    Boolean flag = false;


                    if(state==0){
                        flag = false;
                    }else {
                        flag = true;
                    }

                    if(flag != stateMes){
                        AdjustDeviceAction.saveAdjustDevice(session,idOrder,idResource);
                    }*/


                    session.save(rg_electricityInfo);
                }
                //人机协作平台
                else if (type.equals(MessTable.MES_MAN_MANCHINE_INFO)) {
                    RG_ManMachineInfo rg_manMachineInfo = new RG_ManMachineInfo();
                    rg_manMachineInfo.setId(Tools.getUUID());
                    rg_manMachineInfo.setReportTime(new Date());
                    rg_manMachineInfo.setCarryId(dataNode.get("id").asText());
                    rg_manMachineInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    rg_manMachineInfo.setIdOrder(dataNode.get("idOrder").asText());
                    rg_manMachineInfo.setState(dataNode.get("state").asBoolean());

                    String mesSign = "manMachine";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    session.save(rg_manMachineInfo);
                }
                //模态检测
                else if (type.equals(MessTable.MES_MODEL_TEST_INFO)) {
                    RG_ModelTestInfo rg_modelTestInfo = new RG_ModelTestInfo();
                    rg_modelTestInfo.setId(Tools.getUUID());
                    rg_modelTestInfo.setReportTime(new Date());
                    rg_modelTestInfo.setCarryId(dataNode.get("id").asText());
                    rg_modelTestInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    rg_modelTestInfo.setIdOrder(dataNode.get("idOrder").asText());
                    rg_modelTestInfo.setState(dataNode.get("state").asBoolean());

                    String mesSign = "model";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    session.save(rg_modelTestInfo);
                }
                //仓库搬运机器人信息
                else if (type.equals(MessTable.MES_CARRY_INFO)) {
                    RG_Mes_CarryInfo carryInfo = new RG_Mes_CarryInfo();
                    carryInfo.setAgvId(dataNode.get("id").asText());
                    carryInfo.setState(Boolean.parseBoolean(dataNode.get("state").asText()));
                    carryInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    carryInfo.setIdOrder(dataNode.get("idOrder").asText());
                    carryInfo.setReportTime(new Date());
                    session.save(carryInfo);
                }
                //【已调】AGV信息
                else if (type.equals(MessTable.MES_AGV_INFO)) {
                    JsonNode subDataNode = dataNode.get("data");

                    RG_Mes_AgvInfo agvInfo = new RG_Mes_AgvInfo();

                    agvInfo.setAgvId(subDataNode.get("id").asText());
                    agvInfo.setState(subDataNode.get("state").asBoolean());
                    agvInfo.setGoodsDesc(subDataNode.get("jobDesc").asText());
                    agvInfo.setIdOrder(subDataNode.get("idOrder").asText());
                    agvInfo.setRemainPower(Float.parseFloat(subDataNode.get("remainPower").asText()));
                    agvInfo.setReportTime(new Date());
//                    agvInfo.setSite(subDataNode.get("site").asText());

                    String mesSign = "agv";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    session.save(agvInfo);
                }
                //【已调】装配线搬运机器人信息
                else if (type.equals(MessTable.MES_ASSEMBLYCARRY_INFO)) {
                    RG_Mes_AssemblyCarryInfo carryInfo = new RG_Mes_AssemblyCarryInfo();

                    carryInfo.setCarryId(dataNode.get("id").asText());
                    carryInfo.setState(Boolean.parseBoolean(dataNode.get("state").asText()));
                    carryInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    if (dataNode.has("idOrder")) {
                        carryInfo.setIdOrder(dataNode.get("idOrder").asText());
                    }
                    carryInfo.setReportTime(new Date());

                    String mesSign = "assemblyCarry";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    session.save(carryInfo);
                }
                //【已调】智能装配中心信息
                else if (type.equals(MessTable.MES_ASSEMBLYCENTER_INFO)) {
                    RG_Mes_AssemblyCenterInfo centerInfo = new RG_Mes_AssemblyCenterInfo();

                    centerInfo.setCarryId(dataNode.get("id").asText());
                    centerInfo.setState(Boolean.parseBoolean(dataNode.get("state").asText()));
                    centerInfo.setJobDesc(dataNode.get("jobDesc").asText());
                    centerInfo.setIdOrder(dataNode.get("idOrder").asText());
                    centerInfo.setReportTime(new Date());

                    String mesSign = "assemblyCenter";

                    String idOrder = dataNode.get("idOrder").asText();

                    Boolean stateMes = dataNode.get("state").asBoolean();

                    AdjustDeviceAction.saveAdjustDevice(session,idOrder,mesSign,stateMes);

                    session.save(centerInfo);
                }
            }
            //【已调】设备状态信息
            else if (mesType.equals(MessTable.MES_DEVICESTATE_INFO)) {

                RG_ResourceStateEntity stateEntity = new RG_ResourceStateEntity();
                stateEntity.setId(Tools.getUUID());
//                stateEntity.setResourceName(dataNode.get("resourceName").asText());
//                stateEntity.setManufacturer(dataNode.get("manufacturer").asText());
                if (dataNode.has("idTask")) {
                    stateEntity.setIdTask(dataNode.get("idTask").asText());
                }
                stateEntity.setIdProcess(dataNode.get("idProcess").asText());
                if (dataNode.has("idProduct")) {
                    stateEntity.setIdProduct(dataNode.get("idProduct").asText());
                }
                if (dataNode.has("productName")) {
                    stateEntity.setProductName(dataNode.get("productName").asText());
                }
                stateEntity.setT1Task(Tools.parseStandTextDate(dataNode.get("t1PlanTask").asText()));
                stateEntity.setT2Task(Tools.parseStandTextDate(dataNode.get("t2PlanTask").asText()));
                stateEntity.setCurrTime(new Date());
                if (dataNode.has("t1RealTask")) {
                    stateEntity.setT1RealTask(Tools.parseStandTextDate(dataNode.get("t1RealTask").asText()));
                }
                if (dataNode.has("t2RealTask")) {
                    stateEntity.setT2RealTask(Tools.parseStandTextDate(dataNode.get("t2RealTask").asText()));
                }

                stateEntity.setState(Short.parseShort(dataNode.get("state").asText()));

                session.save(stateEntity);
            }
            //订单执行信息
            else if (mesType.equals(MessTable.MES_ORDERSTATE_INFO)) {
                //获取订单id
                String idOrder = dataNode.get("idOrder").asText();
                String idTask = dataNode.get("idTask").asText();
                //查询工序()
                Query query = session.createQuery("from RG_PlanEntity rg_planEntity where rg_planEntity.idTask =:idTask and rg_planEntity.snapShort.id =:idSnapShort");
                query.setParameter("idTask", idTask);
                query.setParameter("idSnapShort", idSnapShort);
                List list = query.list();
                if (list != null) {
                    for (Object object : list) {
                        if (object instanceof RG_PlanEntity) {
                            RG_PlanEntity rg_planEntity = (RG_PlanEntity) object;
                            Date planStartTime = Tools.dateFormater(rg_planEntity.getT1Task(), "yy-MM-dd HH:mm:ss");
                            Date planFinishTime = Tools.dateFormater(rg_planEntity.getT2Task(), "yy-MM-dd HH:mm:ss");
                            RG_OrderStateEntity rg_orderStateEntity = new RG_OrderStateEntity();
                            rg_orderStateEntity.setPlanStartTime(planStartTime);
                            rg_orderStateEntity.setPlanFinishTime(planFinishTime);
                            rg_orderStateEntity.setIdTask(rg_planEntity.getIdTask());
                            rg_orderStateEntity.setNameTask(rg_planEntity.getNameTask());
                            rg_orderStateEntity.setPlanDevice(dataNode.get("planDevice").toString());
                            rg_orderStateEntity.setPlanCount(Short.parseShort(dataNode.get("planCount").asText()));
                            rg_orderStateEntity.setActualDispatchDevice(dataNode.get("realDispatchDevice").toString());
                            if (dataNode.has("realExcuteTime")) {
                                rg_orderStateEntity.setActualDispatchTime(Tools.parseStandTextDate(dataNode.get("realExcuteTime").asText()));
                                Date startTime = Tools.dateFormater(rg_orderStateEntity.getActualDispatchTime(), "yy-MM-dd HH:mm:ss am");
                                if (startTime.after(planStartTime)) {
                                    RG_AdjustProcessEntity rg_adjustProcessEntity = new RG_AdjustProcessEntity();
                                    rg_adjustProcessEntity.setId(Tools.getUUID());
                                    rg_adjustProcessEntity.setIdOrder(idOrder);
                                    rg_adjustProcessEntity.setIdTask(idTask);
                                    rg_adjustProcessEntity.setState(1);
                                    session.save(rg_adjustProcessEntity);
                                    Tools.createEventLog(EventLogTools.AdjustProcessEvent, EventLogTools.StandardTimeLineItem, "工序异常", EventLogTools.createAdjustProcessEventContent(rg_adjustProcessEntity), rg_adjustProcessEntity.getId());
                                }
                            }
                            if (dataNode.has("realFinishTime")) {
                                rg_orderStateEntity.setActualFinsihTime(Tools.parseStandTextDate(dataNode.get("realFinishTime").asText()));
                                Date finishTime = Tools.dateFormater(rg_orderStateEntity.getActualFinsihTime(), "yy-MM-dd HH:mm:ss am");
                                if (finishTime.after(planFinishTime)) {
                                    RG_AdjustProcessEntity rg_adjustProcessEntity = new RG_AdjustProcessEntity();
                                    rg_adjustProcessEntity.setId(Tools.getUUID());
                                    rg_adjustProcessEntity.setIdOrder(idOrder);
                                    rg_adjustProcessEntity.setIdTask(idTask);
                                    rg_adjustProcessEntity.setState(1);
                                    session.save(rg_adjustProcessEntity);
                                    Tools.createEventLog(EventLogTools.AdjustProcessEvent, EventLogTools.StandardTimeLineItem, "工序异常", EventLogTools.createAdjustProcessEventContent(rg_adjustProcessEntity), rg_adjustProcessEntity.getId());
                                }
                            }
                            short planCount = Short.parseShort(dataNode.get("planCount").asText());
                            rg_orderStateEntity.setUnqualifiedCount(Short.parseShort(dataNode.get("unqualifiedCount").asText()));
                            rg_orderStateEntity.setQualifiedCount(Short.parseShort(dataNode.get("qualifiedCount").asText()));
                            rg_orderStateEntity.setActualFinishCount((float) (rg_orderStateEntity.getUnqualifiedCount() + rg_orderStateEntity.getQualifiedCount()) / planCount);//实际完工量
                            rg_orderStateEntity.setCurrTime(new Date());
                            rg_orderStateEntity.setFinished(Boolean.parseBoolean(dataNode.get("isCompleted").asText()));
                            RG_OrderEntity rg_orderEntity = session.get(RG_OrderEntity.class, idOrder);
                            if (rg_orderEntity != null) {
                                rg_orderStateEntity.setOrderEntity(rg_orderEntity);
                                List<RG_ProcessEntity> rg_processEntityList = (List<RG_ProcessEntity>) session.createQuery("from RG_ProcessEntity rg_processEntity where rg_processEntity.productByIdProduct.id =:idProduct").setParameter("idProduct", rg_orderEntity.getProductByIdProduct().getId()).list();
                                int count = 0;
                                for (RG_ProcessEntity rg_processEntity : rg_processEntityList) {
                                    List<RG_ProcessEntity> processEntityList = session.createQuery("from RG_ProcessEntity rg_processEntity where rg_processEntity.transport =:transport and rg_processEntity.idRoot =:idRoot").setParameter("transport", false).setParameter("idRoot", rg_processEntity.getId()).list();
                                    count = count + processEntityList.size();
                                }
                                if (count != 0) {
                                    rg_orderStateEntity.setFinishPercent(rg_orderStateEntity.getActualFinishCount() / count);
                                }
                            }
                            session.save(rg_orderStateEntity);
                        }
                    }
                }
            }
            //【已调】工序指令信息
            else if (mesType.equals(MessTable.MES_INSTRUCT_INFO)) {
                RG_RealDataEntity data = new RG_RealDataEntity();
//                data.setIdResource(dataNode.get("idResource").asText());
                data.setState(dataNode.get("state").asText());
                data.setGood(dataNode.get("good").asText());
                data.setStartLocation(dataNode.get("startLocation").asText());
                data.setEndLocation(dataNode.get("endLocation").asText());
                String valueType = dataNode.get("valueType").asText();
                data.setValueType(valueType);
                //TODO value待处理
                if (valueType.equals("time")) {
                    data.setValue(dataNode.get("value").asText());
                }
                if (valueType.equals("pos")) {
                    data.setValue(dataNode.get("value").asText());
                }
                //Yang 20170825新增idTask
//                data.setIdTask(dataNode.get("idTask").asText());
                session.save(data);
            }
            //【已调】设备调整
            else if (mesType.equals(MessTable.MES_ADJUSTDEVICE_INFO)) {
                String idOrder = dataNode.get("idOrder").asText();
                Date reportTime = Tools.parseStandTextDate(dataNode.get("reportTime").asText());
                String idResource = dataNode.get("idResource").asText();
                Boolean enable = dataNode.get("enable").asBoolean();

                RG_AdjustDeviceEntity data = new RG_AdjustDeviceEntity();
                data.setId(Tools.getUUID());
                data.setOrderId(idOrder);
                data.setReportTime(reportTime);
                data.setResoureId(idResource);
                data.setCancelTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                session.save(data);

                //TODO 待记录并产生异常信息
                System.out.println(idOrder + "__" + reportTime + "__" + idResource + "__" + enable);
            }

            //接收MES确认消息后，发送确认消息
            MesSender.instance().sendReplyMessage(mesType, UUID, sender);

            session.getTransaction().commit();
            session.close();

        } catch (IOException e) {
            e.printStackTrace();
        } catch (NullPointerException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isRunningFlag() {
        return runningFlag;
    }

    public void setRunningFlag(boolean runningFlag) {
        this.runningFlag = runningFlag;
    }
}
