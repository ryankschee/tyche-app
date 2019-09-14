package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonWorkflowEventBean;

@Entity  
@Table(name="place_workflow_event_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceWorkflowEventBean
	extends CommonWorkflowEventBean
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;

    @Column(name="workflow_id")
	String workflowId = "";
	
    public PlaceWorkflowEventBean() 
    {
        this.setId(UUID.randomUUID().toString());
    }
    
	public PlaceWorkflowEventBean(String id)
	{
		this.setId(id);
	}
	
    public String getWorkflowId() { return this.workflowId; }
    
    public void setWorkflowId(String val) { this.workflowId = getSafeString(val); }
    
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