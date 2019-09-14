package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="place_operating_hour_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class PlaceOperatingHourBean 
    extends BeanSuperClass
    implements java.io.Serializable, Comparable<PlaceOperatingHourBean>
{
	private static final long serialVersionUID = 4237233611828488255L;
	
	@Column(name="place_id")  
    String placeId = "";
	@Column(name="showing")  
    boolean showing = false;
	@Column(name="open_time_day")  
    int openTimeDay = 0;
	@Column(name="open_time_hour")  
    int openTimeHour = 0;
	@Column(name="open_time_minute")  
    int openTimeMinute = 0;
	@Column(name="close_time_day")  
    int closeTimeDay = 0;
	@Column(name="close_time_hour")  
    int closeTimeHour = 0;
	@Column(name="close_time_minute")  
    int closeTimeMinute = 0;
    
    public PlaceOperatingHourBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceOperatingHourBean(String id)
    {
        super();
    	this.setId(id);
    }

    public String getPlaceId() { return this.placeId; }
    public boolean isShowing() { return this.showing; }
    public int getOpenTimeDay() { return this.openTimeDay; }
    public int getOpenTimeHour() { return this.openTimeHour; }
    public int getOpenTimeMinute() { return this.openTimeMinute; }
    public int getCloseTimeDay() { return this.closeTimeDay; }
    public int getCloseTimeHour() { return this.closeTimeHour; }
    public int getCloseTimeMinute() { return this.closeTimeMinute; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setShowing(boolean val) { this.showing = val; }
    public void setOpenTimeDay(int val) { this.openTimeDay = val; }
    public void setOpenTimeHour(int val) { this.openTimeHour = val; }
    public void setOpenTimeMinute(int val) { this.openTimeMinute = val; }
    public void setCloseTimeDay(int val) { this.closeTimeDay = val; }
    public void setCloseTimeHour(int val) { this.closeTimeHour = val; }
    public void setCloseTimeMinute(int val) { this.closeTimeMinute = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getClass().getName();
	}

	public int compareTo(PlaceOperatingHourBean o) 
	{
		return Integer.valueOf(this.getOpenTimeDay()).compareTo( o.getOpenTimeDay() );
	}
}
