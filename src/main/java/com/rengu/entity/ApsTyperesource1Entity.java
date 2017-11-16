package com.rengu.entity;

import javax.persistence.*;

/**
 * Created by XY on 2017/11/8.
 */
@Entity
@Table(name = "aps_typeresource1", schema = "testdatabase", catalog = "")
public class ApsTyperesource1Entity {
    private String id;
    private String name;
    private Integer makespan;
    private String color;
    private String description;
    private Integer ratio;

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
    @Column(name = "makespan")
    public Integer getMakespan() {
        return makespan;
    }

    public void setMakespan(Integer makespan) {
        this.makespan = makespan;
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
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "ratio")
    public Integer getRatio() {
        return ratio;
    }

    public void setRatio(Integer ratio) {
        this.ratio = ratio;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ApsTyperesource1Entity that = (ApsTyperesource1Entity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (makespan != null ? !makespan.equals(that.makespan) : that.makespan != null) return false;
        if (color != null ? !color.equals(that.color) : that.color != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (ratio != null ? !ratio.equals(that.ratio) : that.ratio != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (makespan != null ? makespan.hashCode() : 0);
        result = 31 * result + (color != null ? color.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (ratio != null ? ratio.hashCode() : 0);
        return result;
    }
}
