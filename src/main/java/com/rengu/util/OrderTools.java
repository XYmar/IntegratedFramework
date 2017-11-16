package com.rengu.util;

import com.rengu.entity.RG_OrderEntity;
import org.hibernate.Session;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderTools {
    //同步订单的计划时间
    public static void syncOrderPlanDate(Session session) {
        try {
            String sql = "SELECT * FROM " + DatabaseInfo.APS_ORDER;
            List orderList = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, sql);
            for (Object object : orderList) {
                if (object instanceof HashMap) {
                    Map tempMap = (HashMap) object;
                    RG_OrderEntity rg_orderEntity = session.get(RG_OrderEntity.class, tempMap.get("ID").toString());
                    if (rg_orderEntity != null) {
                        if (tempMap.get("T1PLAN") != null) {
                            rg_orderEntity.setT1Plan(Tools.dateFormater(tempMap.get("T1PLAN").toString(), "yyyy-MM-dd HH:mm:ss"));
                        }
                        if (tempMap.get("T2PLAN") != null) {
                            rg_orderEntity.setT1Plan(Tools.dateFormater(tempMap.get("T2PLAN").toString(), "yyyy-MM-dd HH:mm:ss"));
                        }
                        session.saveOrUpdate(rg_orderEntity);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
