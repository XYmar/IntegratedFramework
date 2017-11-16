package com.rengu.entity;

import javax.persistence.*;

/**
 * Created by XY on 2017/11/8.
 */
@Entity
@Table(name = "aps_process_typeresource_site2", schema = "testdatabase", catalog = "")
public class ApsProcessTyperesourceSite2Entity {
    private String idProcess;
    private String idTypeResource;
    private String primaryForTime;
    private String typeSite;
    private String idSite;
    private String siteInGroupResource;
    private Integer weightParallel;
    private Integer weightSequence;
    private Integer minResource;
    private Integer maxResource;
    private Integer modResource;
    private Integer grp;
    private Integer ord;
    private int id;

    @Basic
    @Column(name = "idProcess")
    public String getIdProcess() {
        return idProcess;
    }

    public void setIdProcess(String idProcess) {
        this.idProcess = idProcess;
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
    @Column(name = "primaryForTime")
    public String getPrimaryForTime() {
        return primaryForTime;
    }

    public void setPrimaryForTime(String primaryForTime) {
        this.primaryForTime = primaryForTime;
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
    @Column(name = "IdSite")
    public String getIdSite() {
        return idSite;
    }

    public void setIdSite(String idSite) {
        this.idSite = idSite;
    }

    @Basic
    @Column(name = "siteInGroupResource")
    public String getSiteInGroupResource() {
        return siteInGroupResource;
    }

    public void setSiteInGroupResource(String siteInGroupResource) {
        this.siteInGroupResource = siteInGroupResource;
    }

    @Basic
    @Column(name = "weightParallel")
    public Integer getWeightParallel() {
        return weightParallel;
    }

    public void setWeightParallel(Integer weightParallel) {
        this.weightParallel = weightParallel;
    }

    @Basic
    @Column(name = "weightSequence")
    public Integer getWeightSequence() {
        return weightSequence;
    }

    public void setWeightSequence(Integer weightSequence) {
        this.weightSequence = weightSequence;
    }

    @Basic
    @Column(name = "minResource")
    public Integer getMinResource() {
        return minResource;
    }

    public void setMinResource(Integer minResource) {
        this.minResource = minResource;
    }

    @Basic
    @Column(name = "maxResource")
    public Integer getMaxResource() {
        return maxResource;
    }

    public void setMaxResource(Integer maxResource) {
        this.maxResource = maxResource;
    }

    @Basic
    @Column(name = "modResource")
    public Integer getModResource() {
        return modResource;
    }

    public void setModResource(Integer modResource) {
        this.modResource = modResource;
    }

    @Basic
    @Column(name = "grp")
    public Integer getGrp() {
        return grp;
    }

    public void setGrp(Integer grp) {
        this.grp = grp;
    }

    @Basic
    @Column(name = "ord")
    public Integer getOrd() {
        return ord;
    }

    public void setOrd(Integer ord) {
        this.ord = ord;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ApsProcessTyperesourceSite2Entity that = (ApsProcessTyperesourceSite2Entity) o;

        if (idProcess != null ? !idProcess.equals(that.idProcess) : that.idProcess != null) return false;
        if (idTypeResource != null ? !idTypeResource.equals(that.idTypeResource) : that.idTypeResource != null)
            return false;
        if (primaryForTime != null ? !primaryForTime.equals(that.primaryForTime) : that.primaryForTime != null)
            return false;
        if (typeSite != null ? !typeSite.equals(that.typeSite) : that.typeSite != null) return false;
        if (idSite != null ? !idSite.equals(that.idSite) : that.idSite != null) return false;
        if (siteInGroupResource != null ? !siteInGroupResource.equals(that.siteInGroupResource) : that.siteInGroupResource != null)
            return false;
        if (weightParallel != null ? !weightParallel.equals(that.weightParallel) : that.weightParallel != null)
            return false;
        if (weightSequence != null ? !weightSequence.equals(that.weightSequence) : that.weightSequence != null)
            return false;
        if (minResource != null ? !minResource.equals(that.minResource) : that.minResource != null) return false;
        if (maxResource != null ? !maxResource.equals(that.maxResource) : that.maxResource != null) return false;
        if (modResource != null ? !modResource.equals(that.modResource) : that.modResource != null) return false;
        if (grp != null ? !grp.equals(that.grp) : that.grp != null) return false;
        if (ord != null ? !ord.equals(that.ord) : that.ord != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idProcess != null ? idProcess.hashCode() : 0;
        result = 31 * result + (idTypeResource != null ? idTypeResource.hashCode() : 0);
        result = 31 * result + (primaryForTime != null ? primaryForTime.hashCode() : 0);
        result = 31 * result + (typeSite != null ? typeSite.hashCode() : 0);
        result = 31 * result + (idSite != null ? idSite.hashCode() : 0);
        result = 31 * result + (siteInGroupResource != null ? siteInGroupResource.hashCode() : 0);
        result = 31 * result + (weightParallel != null ? weightParallel.hashCode() : 0);
        result = 31 * result + (weightSequence != null ? weightSequence.hashCode() : 0);
        result = 31 * result + (minResource != null ? minResource.hashCode() : 0);
        result = 31 * result + (maxResource != null ? maxResource.hashCode() : 0);
        result = 31 * result + (modResource != null ? modResource.hashCode() : 0);
        result = 31 * result + (grp != null ? grp.hashCode() : 0);
        result = 31 * result + (ord != null ? ord.hashCode() : 0);
        return result;
    }

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
