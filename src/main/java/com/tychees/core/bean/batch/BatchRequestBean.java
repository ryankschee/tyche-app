package com.tychees.core.bean.batch;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="batch_request_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class BatchRequestBean 
    extends BeanSuperClass 
    implements java.io.Serializable
{
	private static final long serialVersionUID = -2492795358937757063L;
    
    @Column(name="place_id")
    String placeId = "";
    @Column(name="user_id")
    String userId = "";
    @Column(name="action_id")
    String actionId = "";
    @Column(name="action_name")
    String actionName = "";
    @Column(name="action_desc")
    String actionDesc = "";
    @Column(name="action_status")
    String actionStatus = "";
    @Column(name="action_status_desc")
    String actionStatusDesc = "";
    @Column(name="started_on")
    Timestamp startedOn;
    @Column(name="ended_on")
    Timestamp endedOn;
    @Column(name="file_name")
    String fileName = "";
    @Column(name="base64")
    String base64 = "";
    
    public BatchRequestBean() 
    {
        this(UUID.randomUUID().toString());
    }

    public BatchRequestBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getPlaceId() { return this.placeId; }
    public String getUserId() { return this.userId; }
    public String getActionId() { return this.actionId; }
    public String getActionName() { return this.actionName; }
    public String getActionDesc() { return this.actionDesc; }
    public String getActionStatus() { return this.actionStatus; }
    public String getActionStatusDesc() { return this.actionStatusDesc; }
    public Timestamp getStartedOn() { return this.startedOn; }
    public Timestamp getEndedOn() { return this.endedOn; }
    public String getFileName() { return fileName; }
    public String getBase64() { return base64; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setActionId(String val) { this.actionId = getSafeString(val); }
    public void setActionName(String val) { this.actionName = getSafeString(val); }
    public void setActionDesc(String val) { this.actionDesc = getSafeString(val); }
    public void setActionStatus(String val) { this.actionStatus = getSafeString(val); }
    public void setActionStatusDesc(String val) { this.actionStatusDesc = getSafeString(val); }
    public void setStartedOn(Timestamp val) { this.startedOn = val; }
    public void setEndedOn(Timestamp val) { this.endedOn = val; }
    public void setFileName(String val) { this.fileName = getSafeString(val); }
    public void setBase64(String val) { this.base64 = getSafeString(val); }
    
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
