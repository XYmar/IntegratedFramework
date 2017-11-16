package com.rengu.actions.aps;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.actions.SuperAction;
import com.rengu.entity.*;
import com.rengu.util.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

/**
 * Created by XY on 2017/11/7.
 */
public class SwitchAPSAction  extends SuperAction {

    public void switchAPSModel() throws Exception {
        JsonNode jsonNode = Tools.jsonTreeModelParse(Tools.getHttpRequestBody(this.httpServletRequest));
        String id = jsonNode.get("model").toString();

        MySessionFactory.getSessionFactory().getCurrentSession().close();
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        //transaction.begin();
        if (!transaction.isActive()) {
            session.beginTransaction();
        }

        /*
        * 0.MySQL
        * 1.简化模型
        * 2.细化模型
        * */

        if(id.equals("1")){   //简化模型

            //清空APS_PROCESS数据库
            String[] tableNamesProcess = {DatabaseInfo.APS_PROCESS};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesProcess);

            //清空APS_TYPERESOURCE数据库
            String[] tableNamesTypeResource = {DatabaseInfo.APS_TYPERESOURCE};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesTypeResource);

            //清空APS_PROCESS_TYPERESOURCE_SITE数据库
            String[] tableNamesProcessTypeResource = {DatabaseInfo.APS_PROCESS_TYPERESOURCE_SITE};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesProcessTypeResource);

            //清空APS_RESOURCE数据库
            String[] tableNamesResource = {DatabaseInfo.APS_RESOURCE};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesResource);


            //简化模型的process表
            List<ApsProcess1Entity> process1EntityList = (List<ApsProcess1Entity>)session.createQuery("select APSProcess1 from ApsProcess1Entity APSProcess1").list();
            //简化模型的typeresource表
            List<ApsTyperesource1Entity> typeresource1EntityList = (List<ApsTyperesource1Entity>)session.createQuery("select APSTyperesource1 from ApsTyperesource1Entity APSTyperesource1").list();
            //简化模型的APS_PROCESS_TYPERESOURCE_SITE表
            List<ApsProcessTyperesourceSite1Entity> processTyperesource1EntityList = (List<ApsProcessTyperesourceSite1Entity>)session.createQuery("select APSProcessTyperesource1 from ApsProcessTyperesourceSite1Entity APSProcessTyperesource1").list();
            //简化模型的APS_RESOURCE表
            List<ApsResource1Entity> resource1EntityList = (List<ApsResource1Entity>)session.createQuery("select APSResource1 from ApsResource1Entity APSResource1").list();

            //插入process表
            if(process1EntityList != null){
                for(ApsProcess1Entity apsProcess1 : process1EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(apsProcess1));
                }
            }

            //插入typeresource表
            if(typeresource1EntityList != null){
                for(ApsTyperesource1Entity typeresource1 : typeresource1EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(typeresource1));
                }
            }

            //插入processTyperesource表
            if(processTyperesource1EntityList != null){
                for(ApsProcessTyperesourceSite1Entity processTyperesource1 : processTyperesource1EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(processTyperesource1));
                }
            }

            //插入resource表
            if(resource1EntityList != null){
                for(ApsResource1Entity resource1 : resource1EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(resource1));
                }
            }

        }else if(id.equals("2")){   //细化模型
            //清空APS_PROCESS数据库
            String[] tableNames = {DatabaseInfo.APS_PROCESS};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNames);

            //清空APS_TYPERESOURCE数据库
            String[] tableNamesTypeResource = {DatabaseInfo.APS_TYPERESOURCE};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesTypeResource);

            //清空APS_PROCESS_TYPERESOURCE_SITE数据库
            String[] tableNamesProcessTypeResource = {DatabaseInfo.APS_PROCESS_TYPERESOURCE_SITE};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesProcessTypeResource);

            //清空APS_RESOURCE数据库
            String[] tableNamesResource = {DatabaseInfo.APS_RESOURCE};
            Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNamesResource);


            //细化模型的process表
            List<ApsProcess2Entity> process2EntityList = (List<ApsProcess2Entity>)session.createQuery("select APSProcess2 from ApsProcess2Entity APSProcess2").list();
            //细化模型的typeresource表
            List<ApsTyperesource2Entity> typeresource2EntityList = (List<ApsTyperesource2Entity>)session.createQuery("select APSTyperesource2 from ApsTyperesource2Entity APSTyperesource2").list();
            //细化模型的APS_PROCESS_TYPERESOURCE_SITE表
            List<ApsProcessTyperesourceSite2Entity> processTyperesource2EntityList = (List<ApsProcessTyperesourceSite2Entity>)session.createQuery("select APSProcessTyperesource2 from ApsProcessTyperesourceSite2Entity APSProcessTyperesource2").list();
            //细化模型的APS_RESOURCE表
            List<ApsResource2Entity> resource2EntityList = (List<ApsResource2Entity>)session.createQuery("select APSResource2 from ApsResource2Entity APSResource2").list();



            //插入process表
            if(process2EntityList != null){
                for(ApsProcess2Entity apsProcess2 : process2EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(apsProcess2));

                }
            }

            //插入typeresource表
            if(typeresource2EntityList != null){
                for(ApsTyperesource2Entity typeresource2 : typeresource2EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(typeresource2));
                }
            }

            //插入processTyperesource表
            if(processTyperesource2EntityList != null){
                for(ApsProcessTyperesourceSite2Entity processTyperesource2 : processTyperesource2EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(processTyperesource2));
                }
            }

            //插入resource表
            if(resource2EntityList != null){
                for(ApsResource2Entity resource2 : resource2EntityList){

                    //插入APS数据库
                    Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(resource2));
                }
            }

        }


    }

    /*public void insertIntoAPS(List<Object> list){
        if(list != null){
            for(Object obj : list){
                //插入APS数据库
                Tools.executeSQLForUpdate(DatabaseInfo.ORACLE, DatabaseInfo.APS, EntityConvertToSQL.insertSQLForAPS(obj));

            }
        }

    }*/

}
