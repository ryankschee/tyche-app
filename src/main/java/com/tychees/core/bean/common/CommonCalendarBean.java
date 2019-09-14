package com.tychees.core.bean.common;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="common_calendar_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CommonCalendarBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	
	

    private static final long serialVersionUID = 1467880004586236218L;
    
    @Transient
    public List<CommonCalendarEventBean> eventList;

    public CommonCalendarBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public CommonCalendarBean(String id)
    {
        super();
        this.setId(id);
        
        this.eventList = new ArrayList<CommonCalendarEventBean>();
    }

    @Column(name="place_id")
    String placeId;
    @Column(name="user_id")
    String userId = "";
    @Column(name="foreign_id")
    String foreignId = "";
    @Column(name="calendar_name")
    String calendarName = "";
    @Column(name="view_name")           // Ref Doc: https://fullcalendar.io/docs/views/Available_Views/
    String viewName = "";
    @Column(name="color")
    String color = "";
    @Column(name="background_color")
    String backgroundColor = "";
    @Column(name="border_color")
    String borderColor = "";
    @Column(name="text_color")
    String textColor = "";
    @Column(name="showing")
    boolean showing;

    public String getPlaceId() { return this.placeId; }
    public String getUserId() { return this.userId; }
    public String getForeignId() { return this.foreignId; }
    public String getCalendarName() { return this.calendarName; }
    public String getViewName() { return this.viewName; }
    public String getColor() { return this.color; }
    public String getBackgrounColor() { return this.backgroundColor; }
    public String getBorderColor() { return this.borderColor; }
    public String getTextColor() { return this.textColor; }
    public boolean isShowing() { return this.showing; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setForeignId(String val) { this.foreignId = getSafeString(val); }
    public void setCalendarName(String val) { this.calendarName = getSafeString(val); } 
    public void setViewName(String val) { this.viewName = getSafeString(val); } 
    public void setColor(String val) { this.color = getSafeString(val); }
    public void setBackgrounColor(String val) { this.backgroundColor = getSafeString(val); }
    public void setBorderColor(String val) { this.borderColor = getSafeString(val); }
    public void setTextColor(String val) { this.textColor = getSafeString(val); }
    public void setShowing(boolean val) { this.showing = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}

	@Override
	public String getDisplayName() 
	{
		return this.getCalendarName();
	}
}