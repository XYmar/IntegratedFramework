package com.rengu.entity;

/**
 * Created by XY on 2017/10/17.
 */
public class RG_ResourceRateEntity {
    private String id;
    private String idSnapshot;
    private String idResource;
    /*private RG_SnapshotNodeEntity idSnapshot;
    private RG_ResourceEntity idResource;*/
    private double rate;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdSnapshot() {
        return idSnapshot;
    }

    public void setIdSnapshot(String idSnapshot) {
        this.idSnapshot = idSnapshot;
    }

    public String getIdResource() {
        return idResource;
    }

    public void setIdResource(String idResource) {
        this.idResource = idResource;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }
}
