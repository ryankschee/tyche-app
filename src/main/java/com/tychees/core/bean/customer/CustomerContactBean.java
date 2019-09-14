package com.tychees.core.bean.customer;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonContactBean;

@Entity  
@Table(name="customer_contact_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CustomerContactBean
    extends CommonContactBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
 
    @Column(name="customer_id")
    String customerId = "";
    
    public CustomerContactBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerContactBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getCustomerId() { return this.customerId; }
    
    public void setCustomerId(String val) { this.customerId = getSafeString(val); }
    
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