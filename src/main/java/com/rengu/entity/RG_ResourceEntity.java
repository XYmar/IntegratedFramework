package com.rengu.entity;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import javax.persistence.ManyToMany;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by wey580231 on 2017/5/23.
 */
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class RG_ResourceEntity {
    private String idR;
    private String name;
    private String idFeatureResource;
    private String mesSign;
    private String idSiteGroupResource;
    private String typeSite;
    private Short mobility;
    private String sameTypeSequence;
    private String idSiteSequence;
    private Short quantity0;
    private String critical;
    private String nameShift;
    private String calendar;
    private String slot;
    private String dateForbidden;
    private String weekend;
    private String color;
    private String makespan;
    private Double rate;
    private Byte state;
    private Byte sizeIcon;
    private String idIcon;
    private String idSite0;
    private String unit;

    private String assisantResource;            //是否需要载具，在人机协作平台和智能装配平台上此字段有意义


    private String idTypeResource;   //资源类型

    private RG_ClubEntity clubByIdClub;
    private RG_UserEntity userByIdUser;
    @JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property = "GroupresourceId")
    private RG_GroupresourceEntity groupresourceByIdGroupResource;
    private Set<RG_SiteEntity> sitesById = new HashSet<RG_SiteEntity>();
    private Set<RG_ShiftEntity> shiftsById = new HashSet<RG_ShiftEntity>();
    private Set<RG_TyperescourceEntity> typeresourcesById = new HashSet<RG_TyperescourceEntity>();
    @JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property = "ScheduleId")
    private Set<RG_ScheduleEntity> schedules;
    @JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property = "ResourceStateId")
    private Set<RG_ResourceStateEntity> resourceState = new HashSet<RG_ResourceStateEntity>();

    public String getMesSign() {
        return mesSign;
    }

    public void setMesSign(String mesSign) {
        this.mesSign = mesSign;
    }

    public String getIdTypeResource() {
        return idTypeResource;
    }

    public void setIdTypeResource(String idTypeResource) {
        this.idTypeResource = idTypeResource;
    }

    public String getIdR() {
        return idR;
    }

    public void setIdR(String idR) {
        this.idR = idR;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdFeatureResource() {
        return idFeatureResource;
    }

    public void setIdFeatureResource(String idFeatureResource) {
        this.idFeatureResource = idFeatureResource;
    }

    public String getIdSiteGroupResource() {
        return idSiteGroupResource;
    }

    public void setIdSiteGroupResource(String idSiteGroupResource) {
        this.idSiteGroupResource = idSiteGroupResource;
    }

    public String getTypeSite() {
        return typeSite;
    }

    public void setTypeSite(String typeSite) {
        this.typeSite = typeSite;
    }

    public Short getMobility() {
        return mobility;
    }

    public void setMobility(Short mobility) {
        this.mobility = mobility;
    }

    public String getSameTypeSequence() {
        return sameTypeSequence;
    }

    public void setSameTypeSequence(String sameTypeSequence) {
        this.sameTypeSequence = sameTypeSequence;
    }

    public String getIdSiteSequence() {
        return idSiteSequence;
    }

    public void setIdSiteSequence(String idSiteSequence) {
        this.idSiteSequence = idSiteSequence;
    }

    public Short getQuantity0() {
        return quantity0;
    }

    public void setQuantity0(Short quantity0) {
        this.quantity0 = quantity0;
    }

    public String getCritical() {
        return critical;
    }

    public void setCritical(String critical) {
        this.critical = critical;
    }

    public String getNameShift() {
        return nameShift;
    }

    public void setNameShift(String nameShift) {
        this.nameShift = nameShift;
    }

    public String getCalendar() {
        return calendar;
    }

    public void setCalendar(String calendar) {
        this.calendar = calendar;
    }

    public String getSlot() {
        return slot;
    }

    public void setSlot(String slot) {
        this.slot = slot;
    }

    public String getDateForbidden() {
        return dateForbidden;
    }

    public void setDateForbidden(String dateForbidden) {
        this.dateForbidden = dateForbidden;
    }

    public String getWeekend() {
        return weekend;
    }

    public void setWeekend(String weekend) {
        this.weekend = weekend;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getMakespan() {
        return makespan;
    }

    public void setMakespan(String makespan) {
        this.makespan = makespan;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public Byte getState() {
        return state;
    }

    public void setState(Byte state) {
        this.state = state;
    }

    public Byte getSizeIcon() {
        return sizeIcon;
    }

    public void setSizeIcon(Byte sizeIcon) {
        this.sizeIcon = sizeIcon;
    }

    public String getIdIcon() {
        return idIcon;
    }

    public void setIdIcon(String idIcon) {
        this.idIcon = idIcon;
    }

    public String getIdSite0() {
        return idSite0;
    }

    public void setIdSite0(String idSite0) {
        this.idSite0 = idSite0;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getAssisantResource() {
        return assisantResource;
    }

    public void setAssisantResource(String assisantResource) {
        this.assisantResource = assisantResource;
    }

    public RG_ClubEntity getClubByIdClub() {
        return clubByIdClub;
    }

    public void setClubByIdClub(RG_ClubEntity clubByIdClub) {
        this.clubByIdClub = clubByIdClub;
    }

    public RG_UserEntity getUserByIdUser() {
        return userByIdUser;
    }

    public void setUserByIdUser(RG_UserEntity userByIdUser) {
        this.userByIdUser = userByIdUser;
    }

    public RG_GroupresourceEntity getGroupresourceByIdGroupResource() {
        return groupresourceByIdGroupResource;
    }

    public void setGroupresourceByIdGroupResource(RG_GroupresourceEntity groupresourceByIdGroupResource) {
        this.groupresourceByIdGroupResource = groupresourceByIdGroupResource;
    }

    public Set<RG_SiteEntity> getSitesById() {
        return sitesById;
    }

    public void setSitesById(Set<RG_SiteEntity> sitesById) {
        this.sitesById = sitesById;
    }

    @ManyToMany(mappedBy = "resources")
    public Set<RG_ShiftEntity> getShiftsById() {
        return shiftsById;
    }

    public void setShiftsById(Set<RG_ShiftEntity> shiftsById) {
        this.shiftsById = shiftsById;
    }

    public Set<RG_TyperescourceEntity> getTyperesourcesById() {
        return typeresourcesById;
    }

    public void setTyperesourcesById(Set<RG_TyperescourceEntity> typeresourcesById) {
        this.typeresourcesById = typeresourcesById;
    }

    public Set<RG_ScheduleEntity> getSchedules() {
        return schedules;
    }

    public void setSchedules(Set<RG_ScheduleEntity> schedules) {
        this.schedules = schedules;
    }

    public Set<RG_ResourceStateEntity> getResourceState() {
        return resourceState;
    }

    public void setResourceState(Set<RG_ResourceStateEntity> resourceState) {
        this.resourceState = resourceState;
    }
}
