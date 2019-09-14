package com.tychees.core.bean.billing;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonAddressBean;

@Entity  
@Table(name="billing_delivery_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class BillingDeliveryBean
    extends CommonAddressBean
	implements java.io.Serializable
{
	private static final long serialVersionUID = 1467880004586236216L;  
    
    @Column(name="billing_id")
    String billingId = "";
    @Column(name="ref_no")
    String refNo = "";      // Delivery No
    @Column(name="contact_no")
    String contactNo = "";
    @Column(name="method")
    String method = "";
    @Column(name="terms")
    String terms = "";
    @Column(name="dispatched_on")
    Timestamp dispatchedOn;
    @Column(name="received_on")
    Timestamp receivedOn;
    
    public BillingDeliveryBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingDeliveryBean(String id)
    {
        super();
        this.setId(id);
    }
    
    public String getBillingId() { return this.billingId; }
    public String getRefNo() { return this.refNo; }
    public String getContactNo() { return this.contactNo; }
    public String getMethod() { return this.method; }
    public String getTerms() { return this.terms; }
    public Timestamp getDispatchedOn() { return this.dispatchedOn; }
    public Timestamp getReceivedOn() { return this.receivedOn; }
        
    public void setBillingId(String val) { this.billingId = getSafeString(val); }
    public void setRefNo(String val) { this.refNo = getSafeString(val); }
    public void setContactNo(String val) { this.contactNo = getSafeString(val); }
    public void setMethod(String val) { this.method = getSafeString(val); }
    public void setTerms(String val) { this.terms = getSafeString(val); }
    public void setDispatchedOn(Timestamp val) { this.dispatchedOn = val; }
    public void setReceivedOn(Timestamp val) { this.receivedOn = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getRefNo();
	}
}