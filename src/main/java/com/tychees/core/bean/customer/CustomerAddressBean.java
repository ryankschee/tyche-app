package com.tychees.core.bean.customer;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonAddressBean;

@Entity  
@Table(name="customer_address_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CustomerAddressBean
    extends CommonAddressBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="customer_id")
    String customerId = "";
    
    public CustomerAddressBean() {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerAddressBean(String id) {
        super();
        this.setId(id);
    }

    public String getCustomerId() { return this.customerId; }
    
    public void setCustomerId(String val) { this.customerId = getSafeString(val); }
    
	@Override
	public String getBeanName() {
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getClass().getName();
	}
}