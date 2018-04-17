package com.rengu.actions;

import com.fasterxml.jackson.databind.JsonNode;
import com.rengu.DAO.impl.AdjustDeviceDAOImpl;
import com.rengu.entity.*;
import com.rengu.util.ApsTools;
import com.rengu.util.DAOFactory;
import com.rengu.util.MySessionFactory;
import com.rengu.util.Tools;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by XY on 2018/4/16.
 */
public class AdjustFactoryAction extends SuperAction {

    public void getAllAdjustDeviceException() throws Exception {
        AdjustDeviceDAOImpl adjustProcessDAO = DAOFactory.getAdjustDeviceDAOImplInstance();
        List<RG_AdjustDeviceEntity> adjustDeviceEntityList = adjustProcessDAO.findAll();
        String jsonString = Tools.entityConvertToJsonString(adjustDeviceEntityList);
        Tools.jsonPrint(jsonString, httpServletResponse);
    }

    public void creatFactoryException() throws Exception {
        Session session = MySessionFactory.getSessionFactory().openSession();
        session.beginTransaction();

        RG_AdjustLayoutEntity rg_adjustLayoutEntity = new RG_AdjustLayoutEntity();

        String layoutName = (String)session.createQuery("select name from RG_LayoutEntity").list().get(0);

        rg_adjustLayoutEntity.setId(Tools.getUUID());
        rg_adjustLayoutEntity.setName(layoutName);
        rg_adjustLayoutEntity.setReportTime(new Date());
        rg_adjustLayoutEntity.setOrigin("手工模拟");
        rg_adjustLayoutEntity.setState(1);

        session.save(rg_adjustLayoutEntity);

        session.getTransaction().commit();
        session.close();

    }

}
