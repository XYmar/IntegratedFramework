package com.rengu.entity;

import java.util.Date;

/**
 * Created by hanchangming on 2017/6/20.
 */
public class FullCalendarEvent {
    private String Id;
    private String Title;
    private boolean AllDay;
    private Date Start;
    private Date End;
    private String color;

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public boolean isAllDay() {
        return AllDay;
    }

    public void setAllDay(boolean allDay) {
        AllDay = allDay;
    }

    public Date getStart() {
        return Start;
    }

    public void setStart(Date start) {
        Start = start;
    }

    public Date getEnd() {
        return End;
    }

    public void setEnd(Date end) {
        End = end;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}
