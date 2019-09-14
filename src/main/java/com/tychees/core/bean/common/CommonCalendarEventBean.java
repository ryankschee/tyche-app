package com.tychees.core.bean.common;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="common_calendar_event_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CommonCalendarEventBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	
	

    private static final long serialVersionUID = 1467880004586238216L;
    
    // Ref Doc: https://fullcalendar.io/docs/event_data/Event_Object/
    public CommonCalendarEventBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public CommonCalendarEventBean(String id)
    {
        super();
        this.setId(id);
    }

    @Column(name="calendar_id")
    String calendarId = "";
    @Column(name="title")
    String title = "";
    @Column(name="all_day")
    boolean allDay = false;
    @Column(name="start")
    Timestamp start;
    @Column(name="end")
    Timestamp end;
    @Column(name="url")
    String url = "";
    @Column(name="editable")
    boolean editable = false;
    @Column(name="start_editable")
    boolean startEditable = true;
    @Column(name="duration_editable")
    boolean durationEditable = true;
    @Column(name="resource_editable")
    boolean resourceEditable = true;
    @Column(name="overlap")
    boolean overlap = true;
    @Column(name="color")
    String color = "";
    @Column(name="background_color")
    String backgroundColor = "";
    @Column(name="border_color")
    String borderColor = "";
    @Column(name="text_color")
    String textColor = "";

    public String getCalendarId() { return this.calendarId; }
    public String getTitle() { return this.title; }
    public boolean isAllDay() { return this.allDay; }
    public Timestamp getStart() { return this.start; }
    public Timestamp getEnd() { return this.end; }
    public String getUrl() { return this.url; }
    public boolean isEditable() { return this.editable; }
    public boolean isStartEditable() { return this.startEditable; }
    public boolean isDurationEditable() { return this.durationEditable; }
    public boolean isResourceEditable() { return this.resourceEditable; }
    public boolean isOverlap() { return this.overlap; }
    public String getColor() { return this.color; }
    public String getBackgrounColor() { return this.backgroundColor; }
    public String getBorderColor() { return this.borderColor; }
    public String getTextColor() { return this.textColor; }
    
    public void setCalendarId(String val) { this.calendarId = getSafeString(val); }
    public void setTitle(String val) { this.title = getSafeString(val); }
    public void setAllDay(boolean val) { this.allDay = val; }
    public void setStart(Timestamp val) { this.start = val; }
    public void setEnd(Timestamp val) { this.end = val; }
    public void setUrl(String val) { this.url = getSafeString(val); }
    public void setEditable(boolean val) { this.editable = val; }
    public void setStartEditable(boolean val) { this.startEditable = val; }
    public void setDurationEditable(boolean val) { this.durationEditable = val; }
    public void setResourceEditable(boolean val) { this.resourceEditable = val; }
    public void setOverlap(boolean val) { this.overlap = val; }
    public void setColor(String val) { this.color = getSafeString(val); }
    public void setBackgrounColor(String val) { this.backgroundColor = getSafeString(val); }
    public void setBorderColor(String val) { this.borderColor = getSafeString(val); }
    public void setTextColor(String val) { this.textColor = getSafeString(val); }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getTitle();
	}
}