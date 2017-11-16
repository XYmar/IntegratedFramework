package com.rengu.entity;

import javax.persistence.*;

/**
 * Created by XY on 2017/11/9.
 */
@Entity
@Table(name = "aps_resource2", schema = "testdatabase", catalog = "")
public class ApsResource2Entity {
    private String id;
    private String idEn;
    private String nameEn;
    private String name;
    private String unit;
    private String idTypeResource;
    private String idGroupResource;
    private String idFeatureResource;
    private String idSite0;
    private String idSite;
    private String idSiteGroupResource;
    private String typeSite;
    private Integer mobility;
    private Integer quantity0;
    private String idSiteSequence;
    private String critical;
    private String dateForbidden;
    private String weekend;
    private String idShift;
    private String nameShift;
    private String calendar;
    private String slot;
    private Double rate;
    private String color;
    private Integer state;
    private Integer sizeIcon;
    private String idIcon;
    private String makespan;
    private String idClub;
    private String idUser;
    private String sameTypeSequence;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "id_en")
    public String getIdEn() {
        return idEn;
    }

    public void setIdEn(String idEn) {
        this.idEn = idEn;
    }

    @Basic
    @Column(name = "name_en")
    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "unit")
    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    @Basic
    @Column(name = "IdTypeResource")
    public String getIdTypeResource() {
        return idTypeResource;
    }

    public void setIdTypeResource(String idTypeResource) {
        this.idTypeResource = idTypeResource;
    }

    @Basic
    @Column(name = "idGroupResource")
    public String getIdGroupResource() {
        return idGroupResource;
    }

    public void setIdGroupResource(String idGroupResource) {
        this.idGroupResource = idGroupResource;
    }

    @Basic
    @Column(name = "idFeatureResource")
    public String getIdFeatureResource() {
        return idFeatureResource;
    }

    public void setIdFeatureResource(String idFeatureResource) {
        this.idFeatureResource = idFeatureResource;
    }

    @Basic
    @Column(name = "idSite0")
    public String getIdSite0() {
        return idSite0;
    }

    public void setIdSite0(String idSite0) {
        this.idSite0 = idSite0;
    }

    @Basic
    @Column(name = "IdSite")
    public String getIdSite() {
        return idSite;
    }

    public void setIdSite(String idSite) {
        this.idSite = idSite;
    }

    @Basic
    @Column(name = "IdSiteGroupResource")
    public String getIdSiteGroupResource() {
        return idSiteGroupResource;
    }

    public void setIdSiteGroupResource(String idSiteGroupResource) {
        this.idSiteGroupResource = idSiteGroupResource;
    }

    @Basic
    @Column(name = "TypeSite")
    public String getTypeSite() {
        return typeSite;
    }

    public void setTypeSite(String typeSite) {
        this.typeSite = typeSite;
    }

    @Basic
    @Column(name = "mobility")
    public Integer getMobility() {
        return mobility;
    }

    public void setMobility(Integer mobility) {
        this.mobility = mobility;
    }

    @Basic
    @Column(name = "quantity0")
    public Integer getQuantity0() {
        return quantity0;
    }

    public void setQuantity0(Integer quantity0) {
        this.quantity0 = quantity0;
    }

    @Basic
    @Column(name = "idSiteSequence")
    public String getIdSiteSequence() {
        return idSiteSequence;
    }

    public void setIdSiteSequence(String idSiteSequence) {
        this.idSiteSequence = idSiteSequence;
    }

    @Basic
    @Column(name = "critical")
    public String getCritical() {
        return critical;
    }

    public void setCritical(String critical) {
        this.critical = critical;
    }

    @Basic
    @Column(name = "DateForbidden")
    public String getDateForbidden() {
        return dateForbidden;
    }

    public void setDateForbidden(String dateForbidden) {
        this.dateForbidden = dateForbidden;
    }

    @Basic
    @Column(name = "weekend")
    public String getWeekend() {
        return weekend;
    }

    public void setWeekend(String weekend) {
        this.weekend = weekend;
    }

    @Basic
    @Column(name = "IdShift")
    public String getIdShift() {
        return idShift;
    }

    public void setIdShift(String idShift) {
        this.idShift = idShift;
    }

    @Basic
    @Column(name = "NameShift")
    public String getNameShift() {
        return nameShift;
    }

    public void setNameShift(String nameShift) {
        this.nameShift = nameShift;
    }

    @Basic
    @Column(name = "Calendar")
    public String getCalendar() {
        return calendar;
    }

    public void setCalendar(String calendar) {
        this.calendar = calendar;
    }

    @Basic
    @Column(name = "Slot")
    public String getSlot() {
        return slot;
    }

    public void setSlot(String slot) {
        this.slot = slot;
    }

    @Basic
    @Column(name = "rate")
    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    @Basic
    @Column(name = "color")
    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    @Basic
    @Column(name = "state")
    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Basic
    @Column(name = "sizeIcon")
    public Integer getSizeIcon() {
        return sizeIcon;
    }

    public void setSizeIcon(Integer sizeIcon) {
        this.sizeIcon = sizeIcon;
    }

    @Basic
    @Column(name = "idIcon")
    public String getIdIcon() {
        return idIcon;
    }

    public void setIdIcon(String idIcon) {
        this.idIcon = idIcon;
    }

    @Basic
    @Column(name = "makespan")
    public String getMakespan() {
        return makespan;
    }

    public void setMakespan(String makespan) {
        this.makespan = makespan;
    }

    @Basic
    @Column(name = "idClub")
    public String getIdClub() {
        return idClub;
    }

    public void setIdClub(String idClub) {
        this.idClub = idClub;
    }

    @Basic
    @Column(name = "idUser")
    public String getIdUser() {
        return idUser;
    }

    public void setIdUser(String idUser) {
        this.idUser = idUser;
    }

    @Basic
    @Column(name = "sameTypeSequence")
    public String getSameTypeSequence() {
        return sameTypeSequence;
    }

    public void setSameTypeSequence(String sameTypeSequence) {
        this.sameTypeSequence = sameTypeSequence;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ApsResource2Entity that = (ApsResource2Entity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (idEn != null ? !idEn.equals(that.idEn) : that.idEn != null) return false;
        if (nameEn != null ? !nameEn.equals(that.nameEn) : that.nameEn != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (unit != null ? !unit.equals(that.unit) : that.unit != null) return false;
        if (idTypeResource != null ? !idTypeResource.equals(that.idTypeResource) : that.idTypeResource != null)
            return false;
        if (idGroupResource != null ? !idGroupResource.equals(that.idGroupResource) : that.idGroupResource != null)
            return false;
        if (idFeatureResource != null ? !idFeatureResource.equals(that.idFeatureResource) : that.idFeatureResource != null)
            return false;
        if (idSite0 != null ? !idSite0.equals(that.idSite0) : that.idSite0 != null) return false;
        if (idSite != null ? !idSite.equals(that.idSite) : that.idSite != null) return false;
        if (idSiteGroupResource != null ? !idSiteGroupResource.equals(that.idSiteGroupResource) : that.idSiteGroupResource != null)
            return false;
        if (typeSite != null ? !typeSite.equals(that.typeSite) : that.typeSite != null) return false;
        if (mobility != null ? !mobility.equals(that.mobility) : that.mobility != null) return false;
        if (quantity0 != null ? !quantity0.equals(that.quantity0) : that.quantity0 != null) return false;
        if (idSiteSequence != null ? !idSiteSequence.equals(that.idSiteSequence) : that.idSiteSequence != null)
            return false;
        if (critical != null ? !critical.equals(that.critical) : that.critical != null) return false;
        if (dateForbidden != null ? !dateForbidden.equals(that.dateForbidden) : that.dateForbidden != null)
            return false;
        if (weekend != null ? !weekend.equals(that.weekend) : that.weekend != null) return false;
        if (idShift != null ? !idShift.equals(that.idShift) : that.idShift != null) return false;
        if (nameShift != null ? !nameShift.equals(that.nameShift) : that.nameShift != null) return false;
        if (calendar != null ? !calendar.equals(that.calendar) : that.calendar != null) return false;
        if (slot != null ? !slot.equals(that.slot) : that.slot != null) return false;
        if (rate != null ? !rate.equals(that.rate) : that.rate != null) return false;
        if (color != null ? !color.equals(that.color) : that.color != null) return false;
        if (state != null ? !state.equals(that.state) : that.state != null) return false;
        if (sizeIcon != null ? !sizeIcon.equals(that.sizeIcon) : that.sizeIcon != null) return false;
        if (idIcon != null ? !idIcon.equals(that.idIcon) : that.idIcon != null) return false;
        if (makespan != null ? !makespan.equals(that.makespan) : that.makespan != null) return false;
        if (idClub != null ? !idClub.equals(that.idClub) : that.idClub != null) return false;
        if (idUser != null ? !idUser.equals(that.idUser) : that.idUser != null) return false;
        if (sameTypeSequence != null ? !sameTypeSequence.equals(that.sameTypeSequence) : that.sameTypeSequence != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (idEn != null ? idEn.hashCode() : 0);
        result = 31 * result + (nameEn != null ? nameEn.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (unit != null ? unit.hashCode() : 0);
        result = 31 * result + (idTypeResource != null ? idTypeResource.hashCode() : 0);
        result = 31 * result + (idGroupResource != null ? idGroupResource.hashCode() : 0);
        result = 31 * result + (idFeatureResource != null ? idFeatureResource.hashCode() : 0);
        result = 31 * result + (idSite0 != null ? idSite0.hashCode() : 0);
        result = 31 * result + (idSite != null ? idSite.hashCode() : 0);
        result = 31 * result + (idSiteGroupResource != null ? idSiteGroupResource.hashCode() : 0);
        result = 31 * result + (typeSite != null ? typeSite.hashCode() : 0);
        result = 31 * result + (mobility != null ? mobility.hashCode() : 0);
        result = 31 * result + (quantity0 != null ? quantity0.hashCode() : 0);
        result = 31 * result + (idSiteSequence != null ? idSiteSequence.hashCode() : 0);
        result = 31 * result + (critical != null ? critical.hashCode() : 0);
        result = 31 * result + (dateForbidden != null ? dateForbidden.hashCode() : 0);
        result = 31 * result + (weekend != null ? weekend.hashCode() : 0);
        result = 31 * result + (idShift != null ? idShift.hashCode() : 0);
        result = 31 * result + (nameShift != null ? nameShift.hashCode() : 0);
        result = 31 * result + (calendar != null ? calendar.hashCode() : 0);
        result = 31 * result + (slot != null ? slot.hashCode() : 0);
        result = 31 * result + (rate != null ? rate.hashCode() : 0);
        result = 31 * result + (color != null ? color.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (sizeIcon != null ? sizeIcon.hashCode() : 0);
        result = 31 * result + (idIcon != null ? idIcon.hashCode() : 0);
        result = 31 * result + (makespan != null ? makespan.hashCode() : 0);
        result = 31 * result + (idClub != null ? idClub.hashCode() : 0);
        result = 31 * result + (idUser != null ? idUser.hashCode() : 0);
        result = 31 * result + (sameTypeSequence != null ? sameTypeSequence.hashCode() : 0);
        return result;
    }
}
