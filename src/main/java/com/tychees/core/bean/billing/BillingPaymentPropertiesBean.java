package com.tychees.core.bean.billing;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="billing_payment_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class BillingPaymentPropertiesBean
	extends CommonPropertiesBean
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;

    @Column(name="payment_id")
	String paymentId = "";
	
    public BillingPaymentPropertiesBean() 
    {
        this.setId(UUID.randomUUID().toString());
    }
    
	public BillingPaymentPropertiesBean(String id)
	{
		super();
		this.setId(id);
	}

    public String getPaymentId() { return this.paymentId; }
    
    public void setPaymentId(String val) { this.paymentId = getSafeString(val); }
    
	@Override
	public String getBeanName() {
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() {
		return this.getClass().getName();
	}
}