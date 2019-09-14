package com.tychees.core.bean.place;

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
@Table(name="place_workflow_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceWorkflowBean
	extends BeanSuperClass
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;

    @Transient
    public List<PlaceWorkflowEventBean> eventList;
    
    @Column(name="place_id")
	String placeId = "";
    @Column(name="module_id")
	String moduleId = "";
    @Column(name="sub_module_id")
	String subModuleId = "";
	
    public PlaceWorkflowBean() 
    {
        this.setId(UUID.randomUUID().toString());
        this.eventList = new ArrayList<PlaceWorkflowEventBean>();
    }
    
	public PlaceWorkflowBean(String id)
	{
		this.setId(id);
        this.eventList = new ArrayList<PlaceWorkflowEventBean>();
	}
	
    public String getPlaceId() { return this.placeId; }
    public String getModuleId() { return this.moduleId; }
    public String getSubModuleId() { return this.subModuleId; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setModuleId(String val) { this.moduleId = getSafeString(val); }
    public void setSubModuleId(String val) { this.subModuleId = getSafeString(val); }
    
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