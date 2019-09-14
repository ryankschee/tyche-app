package com.tychees.core.bean.place;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="place_notification_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceNotificationBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 2293505623929617851L;

    @Column(name="place_id")
    String placeId = "";
    @Column(name="user_id")
    String userId = "";
    @Column(name="request_id")
    String requestId = "";
    @Column(name="name")
    String name = "";
    @Column(name="status")
    String status = "";
    @Column(name="description")
    String description = "";
    @Column(name="notification_read")
    boolean notificationRead = false;
	@Column(name="notification_read_on")
	Timestamp notificationReadOn;
    @Column(name="download_available")
    boolean downloadAvailable = false;
    
    public PlaceNotificationBean() 
    {
        this(UUID.randomUUID().toString());
    }

	public PlaceNotificationBean(String id)
	{
	    super();
		this.setId(id);
	}

    public String getPlaceId() { return this.placeId; }
    public String getUserId() { return this.userId; }
    public String getRequestId() { return this.requestId; }
    public String getName() { return this.name; }    
    public String getStatus() { return this.status; }     
    public String getDescription() { return this.description; }       
    public boolean isNotificationRead() { return this.notificationRead; }
    public Timestamp getNotificationReadOn() { return this.notificationReadOn; }
    public boolean isDownloadAvailable() { return this.downloadAvailable; }

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setRequestId(String val) { this.requestId = getSafeString(val); }
    public void setName(String val) { this.name = getSafeString(val); } 
    public void setStatus(String val) { this.status = getSafeString(val); } 
    public void setDescription(String val) { this.description = getSafeString(val); } 
    public void setNotificationRead(boolean val) { this.notificationRead = val; }
    public void setNotificationReadOn(Timestamp val) { this.notificationReadOn = val; }
    public void setDownloadAvailable(boolean val) { this.downloadAvailable = val; }

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
}
