package com.tychees.core.bean.billing;

import java.sql.Timestamp;
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
@Table(name="billing_payment_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class BillingPaymentBean
    extends BeanSuperClass
	implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Transient
    public List<BillingPaymentPropertiesBean> propertiesList;
    
    public BillingPaymentBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingPaymentBean(String id)
    {
        super();
        this.setId(id);
        
        this.propertiesList = new ArrayList<BillingPaymentPropertiesBean>();
    }

    @Column(name="billing_id")
    String billingId = "";
    @Column(name="place_id")
    String placeId = "";
    @Column(name="payment_date")
    Timestamp paymentDate;
    @Column(name="paying_amount")
    double payingAmount = 0.0;
    @Column(name="change_amount")
    double changeAmount = 0.0;
    @Column(name="method")
    String method = "";
    @Column(name="method_desc")
    String methodDesc = "";
    @Column(name="details")
    String details = "";
    @Column(name="status")
    String status = "";

    public String getBillingId() { return this.billingId; }
    public String getPlaceId() { return this.placeId; }
    public Timestamp getPaymentDate() { return this.paymentDate; }
    public double getPayingAmount() { return this.payingAmount; }
    public double getChangeAmount() { return this.changeAmount; }
    public String getMethod() { return this.method; }
    public String getMethodDesc() { return this.methodDesc; }
    public String getDetails() { return this.details; }
    public String getStatus() { return this.status; }
    
    public void setBillingId(String val) { this.billingId = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setPaymentDate(Timestamp val) { this.paymentDate = val; }
    public void setPayingAmount(double val) { this.payingAmount = val; } 
    public void setChangeAmount(double val) { this.changeAmount = val; } 
    public void setMethod(String val) { this.method = getSafeString(val); }
    public void setMethodDesc(String val) { this.methodDesc = getSafeString(val); }
    public void setDetails(String val) { this.details = getSafeString(val); }
    public void setStatus(String val) { this.status = getSafeString(val); }
    
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