package com.rengu.actions;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.DAO.AssisantprocessDAO;
import com.rengu.DAO.impl.AssisantprocessDAOImpl;
import com.rengu.entity.RG_AssisantprocessEntity;
import com.rengu.util.DAOFactory;
import com.rengu.util.DatabaseInfo;
import com.rengu.util.Tools;
import com.rengu.util.WebSocketNotification;

import java.util.List;

/**
 * Created by hanchangming on 2017/5/31.
 */
public class AssisantprocessAction extends SuperAction {

    public void getAllAssisantProcess() throws Exception {
        //AssisantprocessDAOImpl assisantprocessDAO = DAOFactory.getAssisantprocessDAOInstance();
        //List list = assisantprocessDAO.findAll();

        //查询APS数据的语句
        String SQLString = "select * from " + DatabaseInfo.APS_PROCESS_TYPERESOURCE_SITE;
        //查询APS数据库
        List list = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, SQLString);

        String jsonString = Tools.entityConvertToJsonString(list);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
    }

    public void findAllByUsername() throws Exception {

    }

    public void save() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_AssisantprocessEntity rg_assisantprocessEntity = Tools.jsonConvertToEntity(jsonString, RG_AssisantprocessEntity.class);
        rg_assisantprocessEntity.setId(Tools.getUUID());
        AssisantprocessDAOImpl assisantprocessDAOInstance = DAOFactory.getAssisantprocessDAOInstance();
        if (assisantprocessDAOInstance.save(rg_assisantprocessEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Assisantprocess保存失败", "alert"));
        }
    }

    public void delete() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_AssisantprocessEntity rg_assisantprocessEntity = Tools.jsonConvertToEntity(jsonString, RG_AssisantprocessEntity.class);
        AssisantprocessDAOImpl assisantprocessDAOInstance = DAOFactory.getAssisantprocessDAOInstance();
        if (assisantprocessDAOInstance.delete(rg_assisantprocessEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Assisantprocess删除失败", "alert"));
        }
    }

    public void update() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        RG_AssisantprocessEntity rg_assisantprocessEntity = Tools.jsonConvertToEntity(jsonString, RG_AssisantprocessEntity.class);
        AssisantprocessDAOImpl assisantprocessDAOInstance = DAOFactory.getAssisantprocessDAOInstance();
        if (assisantprocessDAOInstance.update(rg_assisantprocessEntity)) {
        } else {
            WebSocketNotification.broadcast(Tools.creatNotificationMessage("Assisantprocess更新失败", "alert"));
        }
    }

    public void findAllById() throws Exception {
        String jsonString = Tools.getHttpRequestBody(httpServletRequest);
        JsonNode jsonNode = Tools.jsonTreeModelParse(jsonString);
        String assisantProcessId = jsonNode.get("id").asText();
        AssisantprocessDAOImpl assisantprocessDAO = DAOFactory.getAssisantprocessDAOInstance();
        RG_AssisantprocessEntity rg_assisantprocessEntity = assisantprocessDAO.findAllById(assisantProcessId);
        String resultString = Tools.entityConvertToJsonString(rg_assisantprocessEntity);
        Tools.jsonPrint(resultString, this.httpServletResponse);
    }
}
