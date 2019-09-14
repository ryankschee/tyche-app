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
@Table(name="billing_bucket_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class BillingBucketBean 
    extends BeanSuperClass
	implements java.io.Serializable 
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Transient
    public List<BillingBucketLineBean> lineList;
    
    public BillingBucketBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingBucketBean(String id)
    {
        super();
        this.setId(id);
        
        this.lineList = new ArrayList<BillingBucketLineBean>();
    }

	@Column(name="place_id") 
    String placeId = "";
	@Column(name="layout_component_id") 
    String layoutComponentId = "";
	@Column(name="bucket_name") 
    String bucketName = "";
	@Column(name="bucket_status") 
    String bucketStatus = "";
	@Column(name="pax_count")
	int paxCount = 0;
	@Column(name="pax_max_count")
	int paxMaxCount = 0;
	@Column(name="seated_on")
	Timestamp seatedOn;
	@Column(name="ordered_on")
	Timestamp orderedOn;
	@Column(name="completed_on")
	Timestamp completedOn;
	@Column(name="left_on")
	Timestamp leftOn;
	@Column(name="served_by")
	String servedBy;
	@Column(name="customer_no") 
    String customerNo = "";
	@Column(name="customer_name") 
    String customerName = "";
	@Column(name="customer_contact") 
    String customerContact = "";
	@Column(name="reserved_on")
	Timestamp reservedOn;
	@Column(name="reserved_from")
	Timestamp reservedFrom;
	@Column(name="reserved_to")
	Timestamp reservedTo;
	@Column(name="cancelled_by")
	String cancelledBy = "";
	@Column(name="cancelled_on")
	Timestamp cancelledOn;

    public String getPlaceId() { return this.placeId; }
    public String getLayoutComponentId() { return this.layoutComponentId; }
    public String getBucketName() { return this.bucketName; }
    public String getBucketStatus() { return this.bucketStatus; }
    public int getPaxCount() { return this.paxCount; }
    public int getPaxMaxCount() { return this.paxMaxCount; }
    public Timestamp getSeatedOn() { return this.seatedOn; }
    public Timestamp getOrderedOn() { return this.orderedOn; }
    public Timestamp getCompletedOn() { return this.completedOn; }
    public Timestamp getLeftOn() { return this.leftOn; }
    public String getServedBy() { return this.servedBy; }
    public String getCustomerNo() { return this.customerNo; }
    public String getCustomerName() { return this.customerName; }
    public String getCustomerContact() { return this.customerContact; }
    public Timestamp getReservedOn() { return this.reservedOn; }
    public Timestamp getReservedFrom() { return this.reservedFrom; }
    public Timestamp getReservedTo() { return this.reservedTo;}
    public String getCancelledBy() { return this.cancelledBy; }
    public Timestamp getCancelledOn() { return this.cancelledOn; }

    public void setPlaceId(String val) { this.placeId = val; }
    public void setLayoutComponentId(String val) { this.layoutComponentId = val; }
    public void setBucketName(String val) { this.bucketName = val; }
    public void setBucketStatus(String val) { this.bucketStatus = val; }
    public void setPaxCount(int val) { this.paxCount = val; }
    public void setPaxMaxCount(int val) { this.paxMaxCount = val; }
    public void setSeatedOn(Timestamp val) { this.seatedOn = val; }
    public void setOrderedOn(Timestamp val) { this.orderedOn = val; }
    public void setCompletedOn(Timestamp val) { this.completedOn = val; }
    public void setLeftOn(Timestamp val) { this.leftOn = val; }
    public void setServedBy(String val) { this.servedBy = val; }
    public void setCustomerNo(String val) { this.customerNo = val; }
    public void setCustomerName(String val) { this.customerName = val; }
    public void setCustomerContact(String val) { this.customerContact = val; }
    public void setReservedOn(Timestamp val) { this.reservedOn = val; }
    public void setReservedFrom(Timestamp val) { this.reservedFrom = val; }
    public void setReservedTo(Timestamp val) { this.reservedTo = val; }
    public void setCancelledBy(String val) { this.cancelledBy = val; }
    public void setCancelledOn(Timestamp val) { this.cancelledOn = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getBucketName();
	}
}