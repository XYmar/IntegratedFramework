package com.rengu.entity;

import java.util.Date;

public class RG_ElectricityInfo {
    private String id;
    private String carryId;
    private boolean state;                      //正常、不正常
    private String jobDesc;                     //正在执行搬运工作
    private String idOrder;                     //订单编号
    private Date reportTime;                    //上报时间

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCarryId() {
        return carryId;
    }

    public void setCarryId(String carryId) {
        this.carryId = carryId;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public String getJobDesc() {
        return jobDesc;
    }

    public void setJobDesc(String jobDesc) {
        this.jobDesc = jobDesc;
    }

    public String getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(String idOrder) {
        this.idOrder = idOrder;
    }

    public Date getReportTime() {
        return reportTime;
    }

    public void setReportTime(Date reportTime) {
        this.reportTime = reportTime;
    }
}