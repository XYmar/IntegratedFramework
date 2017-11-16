package com.rengu.entity;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import java.util.Set;

/**
 * Created by wey580231 on 2017/5/23.
 */
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class RG_SiteEntity {
    private String id;
    private String name;
    private String type;
    private Short x;
    private Short y;
    private String color;
    private String idIcon;
    private Short sizeIcon;
    private Short capacity;
    private String mesId;
    @JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property = "ResourceId")
    private Set<RG_ResourceEntity> resources;
    @JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property = "_ScheduleId")
    private Set<RG_ScheduleEntity> schedules;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Short getX() {
        return x;
    }

    public void setX(Short x) {
        this.x = x;
    }

    public Short getY() {
        return y;
    }

    public void setY(Short y) {
        this.y = y;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getIdIcon() {
        return idIcon;
    }

    public void setIdIcon(String idIcon) {
        this.idIcon = idIcon;
    }

    public Short getSizeIcon() {
        return sizeIcon;
    }

    public void setSizeIcon(Short sizeIcon) {
        this.sizeIcon = sizeIcon;
    }

    public Short getCapacity() {
        return capacity;
    }

    public void setCapacity(Short capacity) {
        this.capacity = capacity;
    }

    public String getMesId() {
        return mesId;
    }

    public void setMesId(String mesId) {
        this.mesId = mesId;
    }

    public Set<RG_ResourceEntity> getResources() {
        return resources;
    }

    public void setResources(Set<RG_ResourceEntity> resources) {
        this.resources = resources;
    }

    public Set<RG_ScheduleEntity> getSchedules() {
        return schedules;
    }

    public void setSchedules(Set<RG_ScheduleEntity> schedules) {
        this.schedules = schedules;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RG_SiteEntity that = (RG_SiteEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (x != null ? !x.equals(that.x) : that.x != null) return false;
        if (y != null ? !y.equals(that.y) : that.y != null) return false;
        if (color != null ? !color.equals(that.color) : that.color != null) return false;
        if (idIcon != null ? !idIcon.equals(that.idIcon) : that.idIcon != null) return false;
        if (sizeIcon != null ? !sizeIcon.equals(that.sizeIcon) : that.sizeIcon != null) return false;
        if (capacity != null ? !capacity.equals(that.capacity) : that.capacity != null) return false;
        if (mesId != null ? !mesId.equals(that.mesId) : that.mesId != null) return false;
        if (resources != null ? !resources.equals(that.resources) : that.resources != null) return false;
        return schedules != null ? schedules.equals(that.schedules) : that.schedules == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (x != null ? x.hashCode() : 0);
        result = 31 * result + (y != null ? y.hashCode() : 0);
        result = 31 * result + (color != null ? color.hashCode() : 0);
        result = 31 * result + (idIcon != null ? idIcon.hashCode() : 0);
        result = 31 * result + (sizeIcon != null ? sizeIcon.hashCode() : 0);
        result = 31 * result + (capacity != null ? capacity.hashCode() : 0);
        result = 31 * result + (mesId != null ? mesId.hashCode() : 0);
        result = 31 * result + (resources != null ? resources.hashCode() : 0);
        result = 31 * result + (schedules != null ? schedules.hashCode() : 0);
        return result;
    }
}
