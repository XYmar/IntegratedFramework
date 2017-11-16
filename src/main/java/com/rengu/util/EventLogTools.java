package com.rengu.util;

import com.rengu.entity.RG_AdjustOrderEntity;
import com.rengu.entity.RG_AdjustProcessEntity;
import com.rengu.entity.RG_OrderEntity;
import com.rengu.entity.RG_ScheduleEntity;

/**
 * Created by hanch on 2017/7/20.
 */
public class EventLogTools {
    public static final Short ExceptionCreateEvent = 0;//订单事件
    public static final Short ScheduleCreateEvent = 1;//排程事件
    public static final Short ScheduleFailedEvent = 2;//排程失败
    public static final Short AdjustLayoutExceptionCreatedEvent = 3;//布局调整异常事件
    public static final Short AdjustProcessEvent = 4;//工序异常事件

    //时间线节点样式。
    public static final Short SimpleTimeLineItem = 0;
    public static final Short StandardTimeLineItem = 1;

    public static String createScheduleStartEventContent(RG_ScheduleEntity rg_scheduleEntity) {
        String contentString = rg_scheduleEntity.getName() + "开始进行APS排程，滚动周期为：" + rg_scheduleEntity.getRollTime() + "天，排程时间窗为：" + rg_scheduleEntity.getScheduleWindow() + "天。APS排程模式设置为：'" + rg_scheduleEntity.getApsModel() + "'";
        return contentString;
    }

    public static String createOrderEventContent(RG_OrderEntity rg_orderEntity) {
        String contentString = rg_orderEntity.getName() + "订单录入系统中，订单来源为：手工输入，订单数量为：" + rg_orderEntity.getQuantity() + "个。订单最晚完工时间为：" + rg_orderEntity.getT2();
        return contentString;
    }

    public static String createAdjustProcessEventContent(RG_AdjustProcessEntity adjustProcessEntity) {
        String contentString = "工序异常插入系统中，其任务编码为：" + adjustProcessEntity.getIdTask() + ",：其订单编码为：" + adjustProcessEntity.getIdOrder();
        return contentString;
    }

    public static String createExceptionEventContent(RG_AdjustOrderEntity rg_adjustOrderEntity) {
        String contentString = "于" + rg_adjustOrderEntity.getReportTime() + "产生紧急插单异常。";
        return contentString;
    }
}
