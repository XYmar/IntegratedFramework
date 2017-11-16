package com.rengu.entity;

import java.util.Date;

/**
 * 设备状态信息
 * Created by wey580231 on 2017/6/28.
 */
public class RG_ResourceStateEntity {

    private String id;
    private String idResource;                  //设备编号
    private String resourceName;                //设备名称
    private String manufacturer;                //设备厂商
    private String idTask;                      //当前任务号
    private String idProcess;                    //工序号
    private String idClub;                      //客户名称
    private String idProduct;                   //零件编号
    private String productName;                 //零件名称
    private Date t1Task;                        //计划开工时间
    private Date t2Task;                        //计划完工时间
    private Date currTime;                      //当前时间
    private Date t1RealTask;                    //工序实际开始时间
    private Date t2RealTask;                    //工序实际完工时间
    private short state;                        //状态
    private float bootstrapTime;                //开机时间比
    private float awaitTime;                    //待机时间比
    private float processTime;                  //加工时间比
    private RG_ResourceEntity resourceEntity;   //资源

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdResource() {
        return idResource;
    }

    public void setIdResource(String idResource) {
        this.idResource = idResource;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getIdTask() {
        return idTask;
    }

    public void setIdTask(String idTask) {
        this.idTask = idTask;
    }

    public String getIdProcess() {
        return idProcess;
    }

    public void setIdProcess(String idProcess) {
        this.idProcess = idProcess;
    }

    public String getIdClub() {
        return idClub;
    }

    public void setIdClub(String idClub) {
        this.idClub = idClub;
    }

    public String getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(String idProduct) {
        this.idProduct = idProduct;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Date getT1Task() {
        return t1Task;
    }

    public void setT1Task(Date t1Task) {
        this.t1Task = t1Task;
    }

    public Date getT2Task() {
        return t2Task;
    }

    public void setT2Task(Date t2Task) {
        this.t2Task = t2Task;
    }

    public Date getCurrTime() {
        return currTime;
    }

    public void setCurrTime(Date currTime) {
        this.currTime = currTime;
    }

    public Date getT1RealTask() {
        return t1RealTask;
    }

    public void setT1RealTask(Date t1RealTask) {
        this.t1RealTask = t1RealTask;
    }

    public Date getT2RealTask() {
        return t2RealTask;
    }

    public void setT2RealTask(Date t2RealTask) {
        this.t2RealTask = t2RealTask;
    }

    public short getState() {
        return state;
    }

    public void setState(short state) {
        this.state = state;
    }

    public float getBootstrapTime() {
        return bootstrapTime;
    }

    public void setBootstrapTime(float bootstrapTime) {
        this.bootstrapTime = bootstrapTime;
    }

    public float getAwaitTime() {
        return awaitTime;
    }

    public void setAwaitTime(float awaitTime) {
        this.awaitTime = awaitTime;
    }

    public float getProcessTime() {
        return processTime;
    }

    public void setProcessTime(float processTime) {
        this.processTime = processTime;
    }

    public RG_ResourceEntity getResourceEntity() {
        return resourceEntity;
    }

    public void setResourceEntity(RG_ResourceEntity resourceEntity) {
        this.resourceEntity = resourceEntity;
    }
}
