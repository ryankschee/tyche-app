package com.tychees.core.bean.billing;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="billing_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class BillingPropertiesBean
	extends CommonPropertiesBean
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;

    @Column(name="billing_id")
	String billingId = "";
	
    public BillingPropertiesBean() 
    {
        this.setId(UUID.randomUUID().toString());
    }
    
	public BillingPropertiesBean(String id)
	{
		this.setId(id);
	}
	
    public String getBillingId() { return this.billingId; }
    
    public void setBillingId(String val) { this.billingId = getSafeString(val); }
    
	@Override
	public String getBeanName() {
		return this.getClass().getName();
	}

	@Override
	public String getDisplayName() {
		return this.getClass().getName();
	}
}