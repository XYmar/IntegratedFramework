package com.rengu.actions;

import com.fasterxml.jackson.databind.JsonNode;
import com.opensymphony.xwork2.ModelDriven;
import com.rengu.DAO.ShiftDAO;
import com.rengu.DAO.impl.ShiftDAOImpl;
import com.rengu.entity.RG_ShiftEntity;
import com.rengu.util.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;
import java.util.UUID;

/**
 * Created by hanchangming on 2017/5/31.
 */
public class ShiftAction extends SuperAction implements ModelDriven<RG_ShiftEntity> {
    RG_ShiftEntity rg_shiftEntity = new RG_ShiftEntity();

    @Override
    public RG_ShiftEntity getModel() {
        return this.rg_shiftEntity;
    }

    public void getAllShift() throws Exception {
        ShiftDAO shiftDAO = DAOFactory.getShiftInstance();
        List list = shiftDAO.findAll();
        String jsonString = Tools.entityConvertToJsonString(list);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
    }

    public void save() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_ShiftEntity rg_shiftEntity = Tools.jsonConvertToEntity(jsonString, RG_ShiftEntity.class);
        rg_shiftEntity.setId(Tools.getUUID());
        ShiftDAOImpl shiftDAOInstance = DAOFactory.getShiftInstance();
        if (shiftDAOInstance.save(rg_shiftEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Shift保存失败", "alert"));
        }
    }

    public void delete() throws Exception {
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();
        JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(httpServletRequest));
        String id = jsonNode.get("id").asText();
        RG_ShiftEntity rg_shiftEntity = DAOFactory.getShiftInstance().findAllById(session, id);
        if (rg_shiftEntity != null) {
            boolean isDelete = DAOFactory.getShiftInstance().delete(session, rg_shiftEntity);
            if (isDelete) {
                transaction.commit();
                System.out.println("删除成功");
            } else {
                transaction.rollback();
                System.out.println("删除失败");
            }
        }
    }

    public void update() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_ShiftEntity rg_shiftEntity = Tools.jsonConvertToEntity(jsonString, RG_ShiftEntity.class);
        ShiftDAOImpl shiftDAOInstance = DAOFactory.getShiftInstance();
        if (shiftDAOInstance.update(rg_shiftEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Shift更新失败", "alert"));
        }

    }

    public void findAllById() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        JsonNode jsonNode = Tools.jsonTreeModelParse(jsonString);
        String shiftId = jsonNode.get("id").asText();
        ShiftDAOImpl shiftDAO = DAOFactory.getShiftInstance();
        RG_ShiftEntity rg_shiftEntity = shiftDAO.findAllById(shiftId);
        String resultString = Tools.entityConvertToJsonString(rg_shiftEntity);
        Tools.jsonPrint(resultString, this.httpServletResponse);
    }

    public void saveAPS() throws Exception {
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();
        JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(httpServletRequest));
        String id = jsonNode.get("id").asText();
        RG_ShiftEntity rg_shiftEntity = DAOFactory.getShiftInstance().findAllById(session, id);
        if (rg_shiftEntity != null) {
            //清空APS数据库
            /*String[] tableNames = {DatabaseInfo.APS_SHIFT};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNames);*/

            //判断此班次是否存在，不存在则插入，存在则修改
            String sql0 = "SELECT * FROM " + DatabaseInfo.APS_SHIFT + " WHERE ID = '" + id + "'";
            List shiftList = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql0);

            if(shiftList.size() == 0){ //插入
                Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(rg_shiftEntity));

            }else if(shiftList.size() == 1){
                //String sql = "UPDATE " + DatabaseInfo.APS_RESOURCE + " SET IDSHIFT = '{\"" + rg_shiftEntity.getId() + "\"}'";
                String sql = "UPDATE " + DatabaseInfo.APS_SHIFT + " SET SLOT =  '" + rg_shiftEntity.getSlot() + "'" + " WHERE ID = '" + id + "'";
                String sql2 = "UPDATE " + DatabaseInfo.APS_SHIFT + " SET NAME =  '" + rg_shiftEntity.getName() + "'" + " WHERE ID = '" + id + "'";
                Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql);
                Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql2);

            }
            //插入
            /*String sql = "UPDATE " + DatabaseInfo.APS_RESOURCE + " SET IDSHIFT = '{\"" + rg_shiftEntity.getId() + "\"}'";
            Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(rg_shiftEntity));
            Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql);*/
            // 调用aps计算
            ApsTools.instance().startAPSSchedule(UUID.randomUUID().toString());
        }
    }
}
