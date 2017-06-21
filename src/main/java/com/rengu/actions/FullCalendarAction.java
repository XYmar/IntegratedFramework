package com.rengu.actions;

import com.rengu.DAO.impl.OrdersDAOImpl;
import com.rengu.DAO.impl.ScheduleDAOImpl;
import com.rengu.entity.FullCalendarEvent;
import com.rengu.entity.RG_OrderEntity;
import com.rengu.entity.RG_ScheduleEntity;
import com.rengu.util.DAOFactory;
import com.rengu.util.GlobalVariable;
import com.rengu.util.Tools;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by hanchangming on 2017/6/20.
 */
public class FullCalendarAction extends SuperAction {

    public String getAllByisFinishedAndDate() throws Exception {
        //获取参数
        Date startDate = Tools.stringConvertToDate(this.httpServletRequest.getParameter("startTime"));
        Date endDate = Tools.stringConvertToDate(this.httpServletRequest.getParameter("endTime"));
        OrdersDAOImpl ordersDAO = DAOFactory.getOrdersDAOInstance();
        //按日期和完成状态查询
        List<RG_OrderEntity> rg_orderEntityUnfinishedList = ordersDAO.findAllByisFinishedAndDate(startDate, endDate, false);
        List<FullCalendarEvent> fullCalendarEventList = new ArrayList<>();
        for (RG_OrderEntity tempRG_OrderEntity : rg_orderEntityUnfinishedList) {
            FullCalendarEvent fullCalendarEvent = new FullCalendarEvent();
            fullCalendarEvent.setId(Tools.getUUID());
            fullCalendarEvent.setAllDay(true);
            if (!tempRG_OrderEntity.getName().isEmpty()) {
                fullCalendarEvent.setTitle(tempRG_OrderEntity.getName());
            } else {
                continue;
            }
            if (tempRG_OrderEntity.getT0() != null) {
                fullCalendarEvent.setStart(tempRG_OrderEntity.getT0());
            } else {
                continue;
            }
            if (tempRG_OrderEntity.getT2() != null) {
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(tempRG_OrderEntity.getT2());
                calendar.add(Calendar.DATE, 1);
                fullCalendarEvent.setEnd(calendar.getTime());
            } else {
                continue;
            }
            fullCalendarEventList.add(fullCalendarEvent);
        }
        String jsonString = Tools.entityConvertToJsonString(fullCalendarEventList);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
        System.out.println(jsonString);
        return "success";
    }


    public String getLastScheduleInfo() throws Exception {
        ScheduleDAOImpl scheduleDAO = DAOFactory.getScheduleDAOImplInstance();
        RG_ScheduleEntity rg_scheduleEntity = scheduleDAO.findAllById(GlobalVariable.latestScheduleId);
        String jsonString = Tools.entityConvertToJsonString(rg_scheduleEntity);
        Tools.jsonPrint(jsonString, this.httpServletResponse);
        return "success";
    }
}
