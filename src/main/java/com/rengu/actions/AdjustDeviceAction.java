package com.rengu.actions;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.DAO.impl.AdjustDeviceDAOImpl;
import com.rengu.entity.RG_AdjustDeviceEntity;
import com.rengu.entity.RG_OrderEntity;
import com.rengu.entity.RG_ResourceEntity;
import com.rengu.util.*;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wey580231 on 2017/6/19.
 */
public class AdjustDeviceAction extends SuperAction {

    public void getAllAdjustDeviceException() throws Exception {
        AdjustDeviceDAOImpl adjustProcessDAO = DAOFactory.getAdjustDeviceDAOImplInstance();
        List<RG_AdjustDeviceEntity> adjustDeviceEntityList = adjustProcessDAO.findAll();
        String jsonString = Tools.entityConvertToJsonString(adjustDeviceEntityList);
        Tools.jsonPrint(jsonString, httpServletResponse);
    }

    public static void saveAdjustDevice(Session session, String orderId, String mesSign, Boolean stateMes) throws Exception{

        List<RG_ResourceEntity> resourceList = (List<RG_ResourceEntity>)session.createQuery("select resource from RG_ResourceEntity resource where resource.mesSign =:mesSign").setParameter("mesSign",mesSign).uniqueResult();

        for(RG_ResourceEntity resource : resourceList){

            RG_AdjustDeviceEntity adjustDeviceEntity = new RG_AdjustDeviceEntity();

            String resourceId = resource.getIdR();
            Byte state = resource.getState();
            Boolean flag = false;


            if(state==0){
                flag = false;
            }else {
                flag = true;
            }

            if(flag != stateMes){
                adjustDeviceEntity.setId(Tools.getUUID());
                adjustDeviceEntity.setOrderId(orderId);
                adjustDeviceEntity.setResoureId(resourceId);
                adjustDeviceEntity.setReportTime(new Date());
                adjustDeviceEntity.setOrigin("MES");

                session.save(adjustDeviceEntity);
            }
        }


    }

    //撤销资源
    public void cancelResource() throws Exception {

        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        JsonNode jsonNode = Tools.jsonTreeModelParse(jsonString);
        String id = jsonNode.get("id").asText();

        MySessionFactory.getSessionFactory().getCurrentSession().close();
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        //transaction.begin();
        if (!transaction.isActive()) {
            session.beginTransaction();
        }

        //找到此id对应的设备资源的idResource
        RG_AdjustDeviceEntity adjustDeviceEntity = (RG_AdjustDeviceEntity)session.createQuery("select adjustDevice from RG_AdjustDeviceEntity adjustDevice where id =:id").setParameter("id",id).uniqueResult();
        //String idResource = (String)session.createQuery("select resoureId from RG_AdjustDeviceEntity adjustDevice where id =:id").setParameter("id",id).uniqueResult();
        String idResource = adjustDeviceEntity.getResoureId();

        //从资源表找到对应的资源
        RG_ResourceEntity resourceEntity = (RG_ResourceEntity)session.createQuery("select resource from RG_ResourceEntity resource where id =:id").setParameter("id",idResource).uniqueResult();

        //此资源的类型
        String idTypeResource = resourceEntity.getIdTypeResource();

        //找到此类型的资源的集合
        List<RG_ResourceEntity> resourceEntityList = (List<RG_ResourceEntity>)session.createQuery("select resource from RG_ResourceEntity resource where resource.idTypeResource =:idTypeResource").setParameter("idTypeResource",idTypeResource).list();

        //判断资源是否单个
        if(resourceEntityList.size() == 1){  //单个
            ApsTools.instance().executeCommand(ApsTools.instance().getCancelDeviceURL(adjustDeviceEntity));

        }else if(resourceEntityList.size() > 1){  //不是单个
            ApsTools.instance().executeCommand(ApsTools.instance().getCancelDeviceURL(adjustDeviceEntity));

            //判断是否有候选订单，state=0
            List<RG_OrderEntity> orderEntityList = (List<RG_OrderEntity>)session.createQuery("select order from RG_OrderEntity order where order.state =:state").setParameter("state",0).list();

            if(orderEntityList.size() > 0){
                ApsTools.instance().getInterAdjust();
            }

        }





        //查找所有资源
        /*String SQLString = "select * from " + DatabaseInfo.APS_RESOURCE + "where STATE = 1";
        List resourceList = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, SQLString);

        //1.先判断撤销的资源是否是单个
        //遍历APS资源表
        for(Object object : resourceList){
            if (object instanceof HashMap) {
                Map rowData = (HashMap) object;

                if (rowData.get("IDTYPERESOURCE") != null) {
                    //String idTypeResource = rowData.get("IDTYPERESOURCE").toString();

                    //查找所有类型为idTypeResource的资源的数量
                    String SQLStringEXC = "select * from " + DatabaseInfo.APS_RESOURCE + "where STATE = 1 and IDTYPERESOURCE = '" + idTypeResource +"'";
                    List resourceListEXC = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, SQLStringEXC);

                    if(resourceListEXC.size() == 1){ //单个资源


                    }else if(resourceListEXC.size() > 1){ //不是单个

                    }
                }
            }

        }*/

    }

    //恢复资源
    public void resumeResource() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        JsonNode jsonNode = Tools.jsonTreeModelParse(jsonString);
        String id = jsonNode.get("id").asText();

        MySessionFactory.getSessionFactory().getCurrentSession().close();
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        //transaction.begin();
        if (!transaction.isActive()) {
            session.beginTransaction();
        }

        //找到此id对应的设备资源的idResource
        RG_AdjustDeviceEntity adjustDeviceEntity = (RG_AdjustDeviceEntity)session.createQuery("select adjustDevice from RG_AdjustDeviceEntity adjustDevice where id =:id").setParameter("id",id).uniqueResult();
        //String idResource = (String)session.createQuery("select resoureId from RG_AdjustDeviceEntity adjustDevice where id =:id").setParameter("id",id).uniqueResult();
        String idResource = adjustDeviceEntity.getResoureId();

        //从资源表找到对应的资源
        RG_ResourceEntity resourceEntity = (RG_ResourceEntity)session.createQuery("select resource from RG_ResourceEntity resource where id =:id").setParameter("id",idResource).uniqueResult();

        //将资源表该资源State更新为1
        Byte b = 1;
        resourceEntity.setState(b);

        //调重启订单接口
        ApsTools.instance().executeCommand(ApsTools.ResumeOrderHandlingURL());

        //判断是否有候选订单，如果有候选订单，再调reusumeScheduling
        List<RG_OrderEntity> orderEntityList = (List<RG_OrderEntity>)session.createQuery("select order from RG_OrderEntity order where order.state =:state").setParameter("state",0).list();

        if(orderEntityList.size() > 0){
            ApsTools.instance().getInterAdjust();
        }


    }
}
