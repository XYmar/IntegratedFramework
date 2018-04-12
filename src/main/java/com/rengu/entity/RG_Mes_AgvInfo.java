package com.rengu.entity;

import java.util.Date;

/**agv信息
 * Created by wey580231 on 2017/7/6.
 */
public class RG_Mes_AgvInfo {
    private String id;
    private String agvId;                           //agv编号
    private boolean state;                          //状态
    private String goodsDesc;                       //物料描述
    private String idOrder;                         //订单编号
    private float remainPower;                      //剩余电量
    private Date reportTime;                        //上报时间
    private String site;                            //当前地点编码，对应site表中的字段

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAgvId() {
        return agvId;
    }

    public void setAgvId(String agvId) {
        this.agvId = agvId;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public String getGoodsDesc() {
        return goodsDesc;
    }

    public void setGoodsDesc(String goodsDesc) {
        this.goodsDesc = goodsDesc;
    }

    public String getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(String idOrder) {
        this.idOrder = idOrder;
    }

    public float getRemainPower() {
        return remainPower;
    }

    public void setRemainPower(float remainPower) {
        this.remainPower = remainPower;
    }

    public Date getReportTime() {
        return reportTime;
    }

    public void setReportTime(Date reportTime) {
        this.reportTime = reportTime;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }
}
