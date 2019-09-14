package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="inventory_item_transaction_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class InventoryItemTransactionBean 
	extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    @Column(name="item_id")
    String itemId = "";
    @Column(name="billing_id")
    String billingId = "";
    @Column(name="billing_line_id")
    String billingLineId = "";
    @Column(name="operator")
    String operator = "";
    @Column(name="quantity")
    double quantity = 0.0;
    @Column(name="reason")
    String reason = "";

    public InventoryItemTransactionBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemTransactionBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getItemId() { return this.itemId; }
    public String getBillingId() { return this.billingId; }
    public String getBillingLineId() { return this.billingLineId; }
    public String getOperator() { return this.operator; }
    public double getQuantity() { return this.quantity; }
    public String getReason() { return this.reason; }
    
    public void setItemId(String val) { this.itemId = getSafeString(val); } 
    public void setBillingId(String val) { this.billingId = getSafeString(val); } 
    public void setBillingLineId(String val) { this.billingLineId = getSafeString(val); } 
    public void setOperator(String val) { this.operator = getSafeString(val); } 
    public void setQuantity(double val) { this.quantity = val; }
    public void setReason(String val) { this.reason = val; }
    
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
