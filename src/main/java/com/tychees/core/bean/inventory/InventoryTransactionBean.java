package com.tychees.core.bean.inventory;

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
@Table(name="inventory_transaction_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryTransactionBean 
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Transient
    public List<InventoryTransactionLineBean> lineList;

    public InventoryTransactionBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryTransactionBean(String id)
    {
        super();
        this.setId(id);
        
        this.lineList = new ArrayList<InventoryTransactionLineBean>();
    }

    @Column(name="place_id")
    String placeId = "";
    @Column(name="type")
    String type = "";
    @Column(name="third_party_id")
    String thirdPartyId = "";
    @Column(name="third_party_type")
    String thirdPartyType = "";
    @Column(name="sub_total_amount")
    double subTotalAmount = 0.0d;
    @Column(name="tax_amount")
    double taxAmount = 0.0d;
    @Column(name="discount_amount")
    double discountAmount = 0.0d;
    @Column(name="total_amount")
    double totalAmount = 0.0d;
    @Column(name="executed")
    boolean executed = false;
    @Column(name="approved_on")
    Timestamp approvedOn;
    @Column(name="approved_by")
    String approvedBy = "";
    @Column(name="delivered_on")
    Timestamp deliveredOn;
    @Column(name="delivered_by")
    String deliveredBy = "";
    @Column(name="received_on")
    Timestamp receivedOn;
    @Column(name="received_by")
    String receivedBy = "";
    
    public String getPlaceId() { return this.placeId; }
    public String getType() { return this.type; }
    public String getThirdPartyId() { return this.thirdPartyId; }
    public String getThirdPartyType() { return this.thirdPartyType; }
    public double getSubTotalAmount() { return this.subTotalAmount; }
    public double getTaxAmount() { return this.taxAmount; }
    public double getDiscountAmount() { return this.discountAmount; }
    public double getTotalAmount() { return this.totalAmount; }
    public boolean isExecuted() { return this.executed; }
    public Timestamp getApprovedOn() { return this.approvedOn; }
    public String getApprovedBy() { return this.approvedBy; }
    public Timestamp getDeliveredOn() { return this.deliveredOn; }
    public String getDeliveredBy() { return this.deliveredBy; }
    public Timestamp getReceivedOn() { return this.receivedOn; }
    public String getReceivedBy() { return this.receivedBy; }
    
    
    public void setPlaceId(String val) { this.placeId = val; }
    public void setType(String val) { this.type = val; }
    public void setThirdPartyId(String val) { this.thirdPartyId = val; }
    public void setThirdPartyType(String val) { this.thirdPartyType = val; }
    public void setSubTotalAmount(double val) { this.subTotalAmount = val; }
    public void setTaxAmount(double val) { this.taxAmount = val; }
    public void setDiscountAmount(double val) { this.discountAmount = val; }
    public void setTotalAmount(double val) { this.totalAmount = val; }
    public void setExecuted(boolean val) { this.executed = val; }
    public void setApprovedOn(Timestamp val) { this.approvedOn = val; }
    public void setApprovedBy(String val) { this.approvedBy = val; }
    public void setDeliveredOn(Timestamp val) { this.deliveredOn = val; }
    public void setDeliveredBy(String val) { this.deliveredBy = val; }
    public void setReceivedOn(Timestamp val) { this.receivedOn = val; }
    public void setReceivedBy(String val) { this.receivedBy = val; }
    
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