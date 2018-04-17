package com.rengu.actions;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.DAO.ResourceDAO;
import com.rengu.DAO.impl.ResourceDAOImpl;
import com.rengu.entity.RG_DistanceEntity;
import com.rengu.entity.RG_ResourceEntity;
import com.rengu.entity.RG_ShiftEntity;
import com.rengu.util.DAOFactory;
import com.rengu.util.MySessionFactory;
import com.rengu.util.Tools;
import com.rengu.util.WebSocketNotification;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import java.util.List;
import java.util.Set;

/**
 * Created by hanchangming on 2017/5/31.
 */
public class ResourceAction extends SuperAction {

    /*public void getAllResource() throws Exception {
        ResourceDAO resourceDAO = DAOFactory.getResourceInstance();
        List list = resourceDAO.findAll();
        String jsonString = Tools.entityConvertToJsonString(list);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
    }*/

    public void getAllResource() throws Exception {

        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();

        List<RG_ResourceEntity> rg_resourceEntityList = session.createQuery("select resource from RG_ResourceEntity resource where resource.isDeleted  <> 0").list();

        //List<RG_ResourceEntity> list = (List<RG_ResourceEntity>)session.createNativeQuery("select * from rg_resource where isDeleted <> ?").setParameter(1,0).list();

        session.getTransaction().commit();


        String jsonString = Tools.entityConvertToJsonString(rg_resourceEntityList);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
        session.close();
    }

    /*public void save() throws Exception {
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();

        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_ResourceEntity rg_resourceEntity = Tools.jsonConvertToEntity(jsonString, RG_ResourceEntity.class);
        rg_resourceEntity.setIdR(Tools.getUUID());
        ResourceDAOImpl resourceDAOInstance = DAOFactory.getResourceInstance();
        if (resourceDAOInstance.save(rg_resourceEntity)) {

        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Resource保存失败", "alert"));
        }
    }*/

    public void save() throws Exception {
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();

        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_ResourceEntity rg_resourceEntity = Tools.jsonConvertToEntity(jsonString, RG_ResourceEntity.class);
        rg_resourceEntity.setIdR(Tools.getUUID());

        String nameShift = rg_resourceEntity.getNameShift();
        RG_ShiftEntity rg_shiftEntity = (RG_ShiftEntity)session.createQuery("select shift from RG_ShiftEntity shift where shift.name =:name").setParameter("name", nameShift).uniqueResult();
        //rg_resourceEntity.getShiftsById().add(rg_shiftEntity);
        rg_shiftEntity.getResources().add(rg_resourceEntity);

        //session.beginTransaction();
        DAOFactory.getResourceInstance().save(session,rg_resourceEntity);

        /*if (isSave) {
            transaction.commit();
            System.out.println("保存成功");
        } else {
            transaction.rollback();
            System.out.println("保存失败");
        }*/

    }

    public void delete() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
       /* RG_ResourceEntity rg_resourceEntity = new RG_ResourceEntity();
        rg_resourceEntity.setIdR(Tools.jsonTreeModelParse(jsonString).get("id").asText());
        ResourceDAOImpl resourceDAOInstance = DAOFactory.getResourceInstance();*/
        /*if (resourceDAOInstance.delete(rg_resourceEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Resource删除失败", "alert"));
        }*/

        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();

        String id = Tools.jsonTreeModelParse(jsonString).get("idR").asText();

        session.createNativeQuery("update rg_resource set isDeleted = ? where id = ?").setParameter(1,0).setParameter(2,id).executeUpdate();

        /*NativeQuery query = session.createNativeQuery("update rg_userconfig set apsCurrSnapshotId = ? where idUser = ?");
        query.setParameter(1, id);
        query.setParameter(2, "1");
        query.executeUpdate();
*/
        session.getTransaction().commit();
        session.close();
    }

    /*public void updateRes() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        *//*ResourceDAOImpl resourceDAO = DAOFactory.getResourceInstance();
        RG_ResourceEntity rg_resourceEntity = resourceDAO.findAllById(Tools.jsonTreeModelParse(jsonString).get("idR").asText());*//*
        RG_ResourceEntity rg_resourceEntity = Tools.jsonConvertToEntity(jsonString, RG_ResourceEntity.class);
        ResourceDAOImpl resourceDAOInstance = DAOFactory.getResourceInstance();
        if (resourceDAOInstance.update(rg_resourceEntity)) {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("删除成功", "confirm"));

        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("删除失败", "alert"));
        }
    }*/

    public void update() throws Exception {
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();

        /*JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(httpServletRequest));
        String id = jsonNode.get("id").asText();
        RG_ResourceEntity rg_resourceEntity0 = DAOFactory.getResourceInstance().findAllById(session, id);*/

        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_ResourceEntity rg_resourceEntity = Tools.jsonConvertToEntity(jsonString, RG_ResourceEntity.class);
        ResourceDAOImpl resourceDAOInstance = DAOFactory.getResourceInstance();

        String nameShift = rg_resourceEntity.getNameShift();

        RG_ShiftEntity rg_shiftEntity = (RG_ShiftEntity)session.createQuery("select shift from RG_ShiftEntity shift where shift.name =:name").setParameter("name", nameShift).uniqueResult();
        String shiftId = rg_shiftEntity.getId();
        /*Set<RG_ShiftEntity> rg_shiftEntity0 = rg_resourceEntity.getShiftsById();
        rg_shiftEntity.getResources().remove(rg_resourceEntity0);
        rg_shiftEntity.getResources().clear();
        rg_shiftEntity.getResources().add(rg_resourceEntity);*/

        session.createNativeQuery("update shift_resource set shift_id = ?").setParameter(1,shiftId).executeUpdate();

        if (resourceDAOInstance.update(session, rg_resourceEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Resource更新失败", "alert"));
        }
    }

    public void findAllById() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        JsonNode jsonNode = Tools.jsonTreeModelParse(jsonString);
        String resourceId = jsonNode.get("id").asText();
        ResourceDAOImpl resourceDAO = DAOFactory.getResourceInstance();
        RG_ResourceEntity rg_resourceEntity = resourceDAO.findAllById(resourceId);
        String resultString = Tools.entityConvertToJsonString(rg_resourceEntity);
        Tools.jsonPrint(resultString, this.httpServletResponse);
    }
}
