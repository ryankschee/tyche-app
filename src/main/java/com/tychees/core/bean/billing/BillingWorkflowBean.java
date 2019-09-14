package com.tychees.core.bean.billing;

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
@Table(name="billing_workflow_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class BillingWorkflowBean
	extends BeanSuperClass
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;

    @Transient
    public List<BillingWorkflowEventBean> eventList;
    
    @Column(name="billing_id")
	String billingId = "";
    @Column(name="module_id")
	String moduleId = "";
    @Column(name="sub_module_id")
	String subModuleId = "";
	
    public BillingWorkflowBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
	public BillingWorkflowBean(String id)
	{
		this.setId(id);
		
		this.eventList = new ArrayList<BillingWorkflowEventBean>();
	}
	
    public String getBillingId() { return this.billingId; }
    public String getModuleId() { return this.moduleId; }
    public String getSubModuleId() { return this.subModuleId; }
    
    public void setBillingId(String val) { this.billingId = getSafeString(val); }
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