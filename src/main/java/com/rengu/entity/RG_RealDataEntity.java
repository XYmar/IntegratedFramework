package com.rengu.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class RG_RealDataEntity {
    private String id;
    private String idResource;
    private String state;
    private String good;
    private String startLocation;
    private String endLocation;
    private String valueType;
    private String value;
    private String idTask;                  //20170825 新增

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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getGood() {
        return good;
    }

    public void setGood(String good) {
        this.good = good;
    }

    public String getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(String startLocation) {
        this.startLocation = startLocation;
    }

    public String getEndLocation() {
        return endLocation;
    }

    public void setEndLocation(String endLocation) {
        this.endLocation = endLocation;
    }

    public String getValueType() {
        return valueType;
    }

    public void setValueType(String valueType) {
        this.valueType = valueType;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getIdTask() {
        return idTask;
    }

    public void setIdTask(String idTask) {
        this.idTask = idTask;
    }
}
