package com.rengu.entity;

import javax.persistence.*;

/**
 * Created by XY on 2017/11/8.
 */
@Entity
@Table(name = "aps_process2", schema = "testdatabase", catalog = "")
public class ApsProcess2Entity {
    private String id;
    private String name;
    private String nameEn;
    private String idPrec;
    private String idSucc;
    private String idNextResource;
    private String idTypeResourceNext;
    private String idParent;
    private String idRoot;
    private String idProduct;
    private Integer ordToParent;
    private Double ordToRoot;
    private String ordToRootChild;
    private String idExclusive;
    private Integer minTimeSucc;
    private Integer maxTimeSucc;
    private String slot1;
    private String slot2;
    private Integer typeShift;
    private Integer initTime;
    private Integer unitQuantity;
    private Integer unitTime;
    private Integer postTime;
    private Integer checkTime;
    private Integer delta;
    private Integer estimate;
    private String continuous;
    private Integer supply;
    private Integer quantity;
    private String idPrecSwitch;
    private Integer modQtySwitch;
    private Integer minQtySwitch;
    private Integer maxQtySwitch;
    private Integer modResourceDivision;
    private Integer minResourceDivision;
    private Integer maxResourceDivision;
    private Integer modQtyDivision;
    private Integer minQtyDivision;
    private Integer maxQtyDivision;
    private Integer modTimeDivision;
    private Integer minTimeDivision;
    private Integer maxTimeDivision;
    private String batch;
    private Integer modQtyBatch;
    private Integer minQtyBatch;
    private Integer maxQtyBatch;
    private Integer modTimeBatch;
    private Integer minTimeBatch;
    private Integer maxTimeBatch;
    private String idCoupled;
    private String idCoupledTypeShift;
    private String idCoupledShift;
    private String idCoupledGroupResource;
    private String idCoupledTypeResource;
    private String idCoupledResource;
    private String idCoupledTypeSite;
    private String idCoupledSite;
    private String preemptive;
    private String exclusiveJob;
    private String exclusiveOrder;
    private String coupledTypeOrder;
    private String idIcon;
    private Integer nbTask;
    private String color;
    private Integer apsSwitch;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
    @Column(name = "name_en")
    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    @Basic
    @Column(name = "IdPrec")
    public String getIdPrec() {
        return idPrec;
    }

    public void setIdPrec(String idPrec) {
        this.idPrec = idPrec;
    }

    @Basic
    @Column(name = "IdSucc")
    public String getIdSucc() {
        return idSucc;
    }

    public void setIdSucc(String idSucc) {
        this.idSucc = idSucc;
    }

    @Basic
    @Column(name = "IdNextResource")
    public String getIdNextResource() {
        return idNextResource;
    }

    public void setIdNextResource(String idNextResource) {
        this.idNextResource = idNextResource;
    }

    @Basic
    @Column(name = "IdTypeResourceNext")
    public String getIdTypeResourceNext() {
        return idTypeResourceNext;
    }

    public void setIdTypeResourceNext(String idTypeResourceNext) {
        this.idTypeResourceNext = idTypeResourceNext;
    }

    @Basic
    @Column(name = "idParent")
    public String getIdParent() {
        return idParent;
    }

    public void setIdParent(String idParent) {
        this.idParent = idParent;
    }

    @Basic
    @Column(name = "idRoot")
    public String getIdRoot() {
        return idRoot;
    }

    public void setIdRoot(String idRoot) {
        this.idRoot = idRoot;
    }

    @Basic
    @Column(name = "idProduct")
    public String getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(String idProduct) {
        this.idProduct = idProduct;
    }

    @Basic
    @Column(name = "ordToParent")
    public Integer getOrdToParent() {
        return ordToParent;
    }

    public void setOrdToParent(Integer ordToParent) {
        this.ordToParent = ordToParent;
    }

    @Basic
    @Column(name = "ordToRoot")
    public Double getOrdToRoot() {
        return ordToRoot;
    }

    public void setOrdToRoot(Double ordToRoot) {
        this.ordToRoot = ordToRoot;
    }

    @Basic
    @Column(name = "OrdToRootChild")
    public String getOrdToRootChild() {
        return ordToRootChild;
    }

    public void setOrdToRootChild(String ordToRootChild) {
        this.ordToRootChild = ordToRootChild;
    }

    @Basic
    @Column(name = "IdExclusive")
    public String getIdExclusive() {
        return idExclusive;
    }

    public void setIdExclusive(String idExclusive) {
        this.idExclusive = idExclusive;
    }

    @Basic
    @Column(name = "minTimeSucc")
    public Integer getMinTimeSucc() {
        return minTimeSucc;
    }

    public void setMinTimeSucc(Integer minTimeSucc) {
        this.minTimeSucc = minTimeSucc;
    }

    @Basic
    @Column(name = "maxTimeSucc")
    public Integer getMaxTimeSucc() {
        return maxTimeSucc;
    }

    public void setMaxTimeSucc(Integer maxTimeSucc) {
        this.maxTimeSucc = maxTimeSucc;
    }

    @Basic
    @Column(name = "Slot1")
    public String getSlot1() {
        return slot1;
    }

    public void setSlot1(String slot1) {
        this.slot1 = slot1;
    }

    @Basic
    @Column(name = "Slot2")
    public String getSlot2() {
        return slot2;
    }

    public void setSlot2(String slot2) {
        this.slot2 = slot2;
    }

    @Basic
    @Column(name = "typeShift")
    public Integer getTypeShift() {
        return typeShift;
    }

    public void setTypeShift(Integer typeShift) {
        this.typeShift = typeShift;
    }

    @Basic
    @Column(name = "initTime")
    public Integer getInitTime() {
        return initTime;
    }

    public void setInitTime(Integer initTime) {
        this.initTime = initTime;
    }

    @Basic
    @Column(name = "unitQuantity")
    public Integer getUnitQuantity() {
        return unitQuantity;
    }

    public void setUnitQuantity(Integer unitQuantity) {
        this.unitQuantity = unitQuantity;
    }

    @Basic
    @Column(name = "unitTime")
    public Integer getUnitTime() {
        return unitTime;
    }

    public void setUnitTime(Integer unitTime) {
        this.unitTime = unitTime;
    }

    @Basic
    @Column(name = "postTime")
    public Integer getPostTime() {
        return postTime;
    }

    public void setPostTime(Integer postTime) {
        this.postTime = postTime;
    }

    @Basic
    @Column(name = "checkTime")
    public Integer getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(Integer checkTime) {
        this.checkTime = checkTime;
    }

    @Basic
    @Column(name = "delta")
    public Integer getDelta() {
        return delta;
    }

    public void setDelta(Integer delta) {
        this.delta = delta;
    }

    @Basic
    @Column(name = "estimate")
    public Integer getEstimate() {
        return estimate;
    }

    public void setEstimate(Integer estimate) {
        this.estimate = estimate;
    }

    @Basic
    @Column(name = "continuous")
    public String getContinuous() {
        return continuous;
    }

    public void setContinuous(String continuous) {
        this.continuous = continuous;
    }

    @Basic
    @Column(name = "supply")
    public Integer getSupply() {
        return supply;
    }

    public void setSupply(Integer supply) {
        this.supply = supply;
    }

    @Basic
    @Column(name = "quantity")
    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Basic
    @Column(name = "IdPrecSwitch")
    public String getIdPrecSwitch() {
        return idPrecSwitch;
    }

    public void setIdPrecSwitch(String idPrecSwitch) {
        this.idPrecSwitch = idPrecSwitch;
    }

    @Basic
    @Column(name = "modQtySwitch")
    public Integer getModQtySwitch() {
        return modQtySwitch;
    }

    public void setModQtySwitch(Integer modQtySwitch) {
        this.modQtySwitch = modQtySwitch;
    }

    @Basic
    @Column(name = "minQtySwitch")
    public Integer getMinQtySwitch() {
        return minQtySwitch;
    }

    public void setMinQtySwitch(Integer minQtySwitch) {
        this.minQtySwitch = minQtySwitch;
    }

    @Basic
    @Column(name = "maxQtySwitch")
    public Integer getMaxQtySwitch() {
        return maxQtySwitch;
    }

    public void setMaxQtySwitch(Integer maxQtySwitch) {
        this.maxQtySwitch = maxQtySwitch;
    }

    @Basic
    @Column(name = "modResourceDivision")
    public Integer getModResourceDivision() {
        return modResourceDivision;
    }

    public void setModResourceDivision(Integer modResourceDivision) {
        this.modResourceDivision = modResourceDivision;
    }

    @Basic
    @Column(name = "minResourceDivision")
    public Integer getMinResourceDivision() {
        return minResourceDivision;
    }

    public void setMinResourceDivision(Integer minResourceDivision) {
        this.minResourceDivision = minResourceDivision;
    }

    @Basic
    @Column(name = "maxResourceDivision")
    public Integer getMaxResourceDivision() {
        return maxResourceDivision;
    }

    public void setMaxResourceDivision(Integer maxResourceDivision) {
        this.maxResourceDivision = maxResourceDivision;
    }

    @Basic
    @Column(name = "modQtyDivision")
    public Integer getModQtyDivision() {
        return modQtyDivision;
    }

    public void setModQtyDivision(Integer modQtyDivision) {
        this.modQtyDivision = modQtyDivision;
    }

    @Basic
    @Column(name = "minQtyDivision")
    public Integer getMinQtyDivision() {
        return minQtyDivision;
    }

    public void setMinQtyDivision(Integer minQtyDivision) {
        this.minQtyDivision = minQtyDivision;
    }

    @Basic
    @Column(name = "maxQtyDivision")
    public Integer getMaxQtyDivision() {
        return maxQtyDivision;
    }

    public void setMaxQtyDivision(Integer maxQtyDivision) {
        this.maxQtyDivision = maxQtyDivision;
    }

    @Basic
    @Column(name = "modTimeDivision")
    public Integer getModTimeDivision() {
        return modTimeDivision;
    }

    public void setModTimeDivision(Integer modTimeDivision) {
        this.modTimeDivision = modTimeDivision;
    }

    @Basic
    @Column(name = "minTimeDivision")
    public Integer getMinTimeDivision() {
        return minTimeDivision;
    }

    public void setMinTimeDivision(Integer minTimeDivision) {
        this.minTimeDivision = minTimeDivision;
    }

    @Basic
    @Column(name = "maxTimeDivision")
    public Integer getMaxTimeDivision() {
        return maxTimeDivision;
    }

    public void setMaxTimeDivision(Integer maxTimeDivision) {
        this.maxTimeDivision = maxTimeDivision;
    }

    @Basic
    @Column(name = "batch")
    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }

    @Basic
    @Column(name = "modQtyBatch")
    public Integer getModQtyBatch() {
        return modQtyBatch;
    }

    public void setModQtyBatch(Integer modQtyBatch) {
        this.modQtyBatch = modQtyBatch;
    }

    @Basic
    @Column(name = "minQtyBatch")
    public Integer getMinQtyBatch() {
        return minQtyBatch;
    }

    public void setMinQtyBatch(Integer minQtyBatch) {
        this.minQtyBatch = minQtyBatch;
    }

    @Basic
    @Column(name = "maxQtyBatch")
    public Integer getMaxQtyBatch() {
        return maxQtyBatch;
    }

    public void setMaxQtyBatch(Integer maxQtyBatch) {
        this.maxQtyBatch = maxQtyBatch;
    }

    @Basic
    @Column(name = "modTimeBatch")
    public Integer getModTimeBatch() {
        return modTimeBatch;
    }

    public void setModTimeBatch(Integer modTimeBatch) {
        this.modTimeBatch = modTimeBatch;
    }

    @Basic
    @Column(name = "minTimeBatch")
    public Integer getMinTimeBatch() {
        return minTimeBatch;
    }

    public void setMinTimeBatch(Integer minTimeBatch) {
        this.minTimeBatch = minTimeBatch;
    }

    @Basic
    @Column(name = "maxTimeBatch")
    public Integer getMaxTimeBatch() {
        return maxTimeBatch;
    }

    public void setMaxTimeBatch(Integer maxTimeBatch) {
        this.maxTimeBatch = maxTimeBatch;
    }

    @Basic
    @Column(name = "IdCoupled")
    public String getIdCoupled() {
        return idCoupled;
    }

    public void setIdCoupled(String idCoupled) {
        this.idCoupled = idCoupled;
    }

    @Basic
    @Column(name = "IdCoupledTypeShift")
    public String getIdCoupledTypeShift() {
        return idCoupledTypeShift;
    }

    public void setIdCoupledTypeShift(String idCoupledTypeShift) {
        this.idCoupledTypeShift = idCoupledTypeShift;
    }

    @Basic
    @Column(name = "IdCoupledShift")
    public String getIdCoupledShift() {
        return idCoupledShift;
    }

    public void setIdCoupledShift(String idCoupledShift) {
        this.idCoupledShift = idCoupledShift;
    }

    @Basic
    @Column(name = "IdCoupledGroupResource")
    public String getIdCoupledGroupResource() {
        return idCoupledGroupResource;
    }

    public void setIdCoupledGroupResource(String idCoupledGroupResource) {
        this.idCoupledGroupResource = idCoupledGroupResource;
    }

    @Basic
    @Column(name = "IdCoupledTypeResource")
    public String getIdCoupledTypeResource() {
        return idCoupledTypeResource;
    }

    public void setIdCoupledTypeResource(String idCoupledTypeResource) {
        this.idCoupledTypeResource = idCoupledTypeResource;
    }

    @Basic
    @Column(name = "IdCoupledResource")
    public String getIdCoupledResource() {
        return idCoupledResource;
    }

    public void setIdCoupledResource(String idCoupledResource) {
        this.idCoupledResource = idCoupledResource;
    }

    @Basic
    @Column(name = "IdCoupledTypeSite")
    public String getIdCoupledTypeSite() {
        return idCoupledTypeSite;
    }

    public void setIdCoupledTypeSite(String idCoupledTypeSite) {
        this.idCoupledTypeSite = idCoupledTypeSite;
    }

    @Basic
    @Column(name = "IdCoupledSite")
    public String getIdCoupledSite() {
        return idCoupledSite;
    }

    public void setIdCoupledSite(String idCoupledSite) {
        this.idCoupledSite = idCoupledSite;
    }

    @Basic
    @Column(name = "preemptive")
    public String getPreemptive() {
        return preemptive;
    }

    public void setPreemptive(String preemptive) {
        this.preemptive = preemptive;
    }

    @Basic
    @Column(name = "exclusiveJob")
    public String getExclusiveJob() {
        return exclusiveJob;
    }

    public void setExclusiveJob(String exclusiveJob) {
        this.exclusiveJob = exclusiveJob;
    }

    @Basic
    @Column(name = "exclusiveOrder")
    public String getExclusiveOrder() {
        return exclusiveOrder;
    }

    public void setExclusiveOrder(String exclusiveOrder) {
        this.exclusiveOrder = exclusiveOrder;
    }

    @Basic
    @Column(name = "coupledTypeOrder")
    public String getCoupledTypeOrder() {
        return coupledTypeOrder;
    }

    public void setCoupledTypeOrder(String coupledTypeOrder) {
        this.coupledTypeOrder = coupledTypeOrder;
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
    @Column(name = "nbTask")
    public Integer getNbTask() {
        return nbTask;
    }

    public void setNbTask(Integer nbTask) {
        this.nbTask = nbTask;
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
    @Column(name = "apsSwitch")
    public Integer getApsSwitch() {
        return apsSwitch;
    }

    public void setApsSwitch(Integer apsSwitch) {
        this.apsSwitch = apsSwitch;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ApsProcess2Entity that = (ApsProcess2Entity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (nameEn != null ? !nameEn.equals(that.nameEn) : that.nameEn != null) return false;
        if (idPrec != null ? !idPrec.equals(that.idPrec) : that.idPrec != null) return false;
        if (idSucc != null ? !idSucc.equals(that.idSucc) : that.idSucc != null) return false;
        if (idNextResource != null ? !idNextResource.equals(that.idNextResource) : that.idNextResource != null)
            return false;
        if (idTypeResourceNext != null ? !idTypeResourceNext.equals(that.idTypeResourceNext) : that.idTypeResourceNext != null)
            return false;
        if (idParent != null ? !idParent.equals(that.idParent) : that.idParent != null) return false;
        if (idRoot != null ? !idRoot.equals(that.idRoot) : that.idRoot != null) return false;
        if (idProduct != null ? !idProduct.equals(that.idProduct) : that.idProduct != null) return false;
        if (ordToParent != null ? !ordToParent.equals(that.ordToParent) : that.ordToParent != null) return false;
        if (ordToRoot != null ? !ordToRoot.equals(that.ordToRoot) : that.ordToRoot != null) return false;
        if (ordToRootChild != null ? !ordToRootChild.equals(that.ordToRootChild) : that.ordToRootChild != null)
            return false;
        if (idExclusive != null ? !idExclusive.equals(that.idExclusive) : that.idExclusive != null) return false;
        if (minTimeSucc != null ? !minTimeSucc.equals(that.minTimeSucc) : that.minTimeSucc != null) return false;
        if (maxTimeSucc != null ? !maxTimeSucc.equals(that.maxTimeSucc) : that.maxTimeSucc != null) return false;
        if (slot1 != null ? !slot1.equals(that.slot1) : that.slot1 != null) return false;
        if (slot2 != null ? !slot2.equals(that.slot2) : that.slot2 != null) return false;
        if (typeShift != null ? !typeShift.equals(that.typeShift) : that.typeShift != null) return false;
        if (initTime != null ? !initTime.equals(that.initTime) : that.initTime != null) return false;
        if (unitQuantity != null ? !unitQuantity.equals(that.unitQuantity) : that.unitQuantity != null) return false;
        if (unitTime != null ? !unitTime.equals(that.unitTime) : that.unitTime != null) return false;
        if (postTime != null ? !postTime.equals(that.postTime) : that.postTime != null) return false;
        if (checkTime != null ? !checkTime.equals(that.checkTime) : that.checkTime != null) return false;
        if (delta != null ? !delta.equals(that.delta) : that.delta != null) return false;
        if (estimate != null ? !estimate.equals(that.estimate) : that.estimate != null) return false;
        if (continuous != null ? !continuous.equals(that.continuous) : that.continuous != null) return false;
        if (supply != null ? !supply.equals(that.supply) : that.supply != null) return false;
        if (quantity != null ? !quantity.equals(that.quantity) : that.quantity != null) return false;
        if (idPrecSwitch != null ? !idPrecSwitch.equals(that.idPrecSwitch) : that.idPrecSwitch != null) return false;
        if (modQtySwitch != null ? !modQtySwitch.equals(that.modQtySwitch) : that.modQtySwitch != null) return false;
        if (minQtySwitch != null ? !minQtySwitch.equals(that.minQtySwitch) : that.minQtySwitch != null) return false;
        if (maxQtySwitch != null ? !maxQtySwitch.equals(that.maxQtySwitch) : that.maxQtySwitch != null) return false;
        if (modResourceDivision != null ? !modResourceDivision.equals(that.modResourceDivision) : that.modResourceDivision != null)
            return false;
        if (minResourceDivision != null ? !minResourceDivision.equals(that.minResourceDivision) : that.minResourceDivision != null)
            return false;
        if (maxResourceDivision != null ? !maxResourceDivision.equals(that.maxResourceDivision) : that.maxResourceDivision != null)
            return false;
        if (modQtyDivision != null ? !modQtyDivision.equals(that.modQtyDivision) : that.modQtyDivision != null)
            return false;
        if (minQtyDivision != null ? !minQtyDivision.equals(that.minQtyDivision) : that.minQtyDivision != null)
            return false;
        if (maxQtyDivision != null ? !maxQtyDivision.equals(that.maxQtyDivision) : that.maxQtyDivision != null)
            return false;
        if (modTimeDivision != null ? !modTimeDivision.equals(that.modTimeDivision) : that.modTimeDivision != null)
            return false;
        if (minTimeDivision != null ? !minTimeDivision.equals(that.minTimeDivision) : that.minTimeDivision != null)
            return false;
        if (maxTimeDivision != null ? !maxTimeDivision.equals(that.maxTimeDivision) : that.maxTimeDivision != null)
            return false;
        if (batch != null ? !batch.equals(that.batch) : that.batch != null) return false;
        if (modQtyBatch != null ? !modQtyBatch.equals(that.modQtyBatch) : that.modQtyBatch != null) return false;
        if (minQtyBatch != null ? !minQtyBatch.equals(that.minQtyBatch) : that.minQtyBatch != null) return false;
        if (maxQtyBatch != null ? !maxQtyBatch.equals(that.maxQtyBatch) : that.maxQtyBatch != null) return false;
        if (modTimeBatch != null ? !modTimeBatch.equals(that.modTimeBatch) : that.modTimeBatch != null) return false;
        if (minTimeBatch != null ? !minTimeBatch.equals(that.minTimeBatch) : that.minTimeBatch != null) return false;
        if (maxTimeBatch != null ? !maxTimeBatch.equals(that.maxTimeBatch) : that.maxTimeBatch != null) return false;
        if (idCoupled != null ? !idCoupled.equals(that.idCoupled) : that.idCoupled != null) return false;
        if (idCoupledTypeShift != null ? !idCoupledTypeShift.equals(that.idCoupledTypeShift) : that.idCoupledTypeShift != null)
            return false;
        if (idCoupledShift != null ? !idCoupledShift.equals(that.idCoupledShift) : that.idCoupledShift != null)
            return false;
        if (idCoupledGroupResource != null ? !idCoupledGroupResource.equals(that.idCoupledGroupResource) : that.idCoupledGroupResource != null)
            return false;
        if (idCoupledTypeResource != null ? !idCoupledTypeResource.equals(that.idCoupledTypeResource) : that.idCoupledTypeResource != null)
            return false;
        if (idCoupledResource != null ? !idCoupledResource.equals(that.idCoupledResource) : that.idCoupledResource != null)
            return false;
        if (idCoupledTypeSite != null ? !idCoupledTypeSite.equals(that.idCoupledTypeSite) : that.idCoupledTypeSite != null)
            return false;
        if (idCoupledSite != null ? !idCoupledSite.equals(that.idCoupledSite) : that.idCoupledSite != null)
            return false;
        if (preemptive != null ? !preemptive.equals(that.preemptive) : that.preemptive != null) return false;
        if (exclusiveJob != null ? !exclusiveJob.equals(that.exclusiveJob) : that.exclusiveJob != null) return false;
        if (exclusiveOrder != null ? !exclusiveOrder.equals(that.exclusiveOrder) : that.exclusiveOrder != null)
            return false;
        if (coupledTypeOrder != null ? !coupledTypeOrder.equals(that.coupledTypeOrder) : that.coupledTypeOrder != null)
            return false;
        if (idIcon != null ? !idIcon.equals(that.idIcon) : that.idIcon != null) return false;
        if (nbTask != null ? !nbTask.equals(that.nbTask) : that.nbTask != null) return false;
        if (color != null ? !color.equals(that.color) : that.color != null) return false;
        if (apsSwitch != null ? !apsSwitch.equals(that.apsSwitch) : that.apsSwitch != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (nameEn != null ? nameEn.hashCode() : 0);
        result = 31 * result + (idPrec != null ? idPrec.hashCode() : 0);
        result = 31 * result + (idSucc != null ? idSucc.hashCode() : 0);
        result = 31 * result + (idNextResource != null ? idNextResource.hashCode() : 0);
        result = 31 * result + (idTypeResourceNext != null ? idTypeResourceNext.hashCode() : 0);
        result = 31 * result + (idParent != null ? idParent.hashCode() : 0);
        result = 31 * result + (idRoot != null ? idRoot.hashCode() : 0);
        result = 31 * result + (idProduct != null ? idProduct.hashCode() : 0);
        result = 31 * result + (ordToParent != null ? ordToParent.hashCode() : 0);
        result = 31 * result + (ordToRoot != null ? ordToRoot.hashCode() : 0);
        result = 31 * result + (ordToRootChild != null ? ordToRootChild.hashCode() : 0);
        result = 31 * result + (idExclusive != null ? idExclusive.hashCode() : 0);
        result = 31 * result + (minTimeSucc != null ? minTimeSucc.hashCode() : 0);
        result = 31 * result + (maxTimeSucc != null ? maxTimeSucc.hashCode() : 0);
        result = 31 * result + (slot1 != null ? slot1.hashCode() : 0);
        result = 31 * result + (slot2 != null ? slot2.hashCode() : 0);
        result = 31 * result + (typeShift != null ? typeShift.hashCode() : 0);
        result = 31 * result + (initTime != null ? initTime.hashCode() : 0);
        result = 31 * result + (unitQuantity != null ? unitQuantity.hashCode() : 0);
        result = 31 * result + (unitTime != null ? unitTime.hashCode() : 0);
        result = 31 * result + (postTime != null ? postTime.hashCode() : 0);
        result = 31 * result + (checkTime != null ? checkTime.hashCode() : 0);
        result = 31 * result + (delta != null ? delta.hashCode() : 0);
        result = 31 * result + (estimate != null ? estimate.hashCode() : 0);
        result = 31 * result + (continuous != null ? continuous.hashCode() : 0);
        result = 31 * result + (supply != null ? supply.hashCode() : 0);
        result = 31 * result + (quantity != null ? quantity.hashCode() : 0);
        result = 31 * result + (idPrecSwitch != null ? idPrecSwitch.hashCode() : 0);
        result = 31 * result + (modQtySwitch != null ? modQtySwitch.hashCode() : 0);
        result = 31 * result + (minQtySwitch != null ? minQtySwitch.hashCode() : 0);
        result = 31 * result + (maxQtySwitch != null ? maxQtySwitch.hashCode() : 0);
        result = 31 * result + (modResourceDivision != null ? modResourceDivision.hashCode() : 0);
        result = 31 * result + (minResourceDivision != null ? minResourceDivision.hashCode() : 0);
        result = 31 * result + (maxResourceDivision != null ? maxResourceDivision.hashCode() : 0);
        result = 31 * result + (modQtyDivision != null ? modQtyDivision.hashCode() : 0);
        result = 31 * result + (minQtyDivision != null ? minQtyDivision.hashCode() : 0);
        result = 31 * result + (maxQtyDivision != null ? maxQtyDivision.hashCode() : 0);
        result = 31 * result + (modTimeDivision != null ? modTimeDivision.hashCode() : 0);
        result = 31 * result + (minTimeDivision != null ? minTimeDivision.hashCode() : 0);
        result = 31 * result + (maxTimeDivision != null ? maxTimeDivision.hashCode() : 0);
        result = 31 * result + (batch != null ? batch.hashCode() : 0);
        result = 31 * result + (modQtyBatch != null ? modQtyBatch.hashCode() : 0);
        result = 31 * result + (minQtyBatch != null ? minQtyBatch.hashCode() : 0);
        result = 31 * result + (maxQtyBatch != null ? maxQtyBatch.hashCode() : 0);
        result = 31 * result + (modTimeBatch != null ? modTimeBatch.hashCode() : 0);
        result = 31 * result + (minTimeBatch != null ? minTimeBatch.hashCode() : 0);
        result = 31 * result + (maxTimeBatch != null ? maxTimeBatch.hashCode() : 0);
        result = 31 * result + (idCoupled != null ? idCoupled.hashCode() : 0);
        result = 31 * result + (idCoupledTypeShift != null ? idCoupledTypeShift.hashCode() : 0);
        result = 31 * result + (idCoupledShift != null ? idCoupledShift.hashCode() : 0);
        result = 31 * result + (idCoupledGroupResource != null ? idCoupledGroupResource.hashCode() : 0);
        result = 31 * result + (idCoupledTypeResource != null ? idCoupledTypeResource.hashCode() : 0);
        result = 31 * result + (idCoupledResource != null ? idCoupledResource.hashCode() : 0);
        result = 31 * result + (idCoupledTypeSite != null ? idCoupledTypeSite.hashCode() : 0);
        result = 31 * result + (idCoupledSite != null ? idCoupledSite.hashCode() : 0);
        result = 31 * result + (preemptive != null ? preemptive.hashCode() : 0);
        result = 31 * result + (exclusiveJob != null ? exclusiveJob.hashCode() : 0);
        result = 31 * result + (exclusiveOrder != null ? exclusiveOrder.hashCode() : 0);
        result = 31 * result + (coupledTypeOrder != null ? coupledTypeOrder.hashCode() : 0);
        result = 31 * result + (idIcon != null ? idIcon.hashCode() : 0);
        result = 31 * result + (nbTask != null ? nbTask.hashCode() : 0);
        result = 31 * result + (color != null ? color.hashCode() : 0);
        result = 31 * result + (apsSwitch != null ? apsSwitch.hashCode() : 0);
        return result;
    }
}
