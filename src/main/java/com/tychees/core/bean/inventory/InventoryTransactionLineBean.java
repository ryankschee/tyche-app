package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="inventory_transaction_line_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryTransactionLineBean
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="transaction_id")
    String transactionId = "";
    @Column(name="item_id")
    String itemId = "";
    @Column(name="foreign_item_id")
    String foreignItemId = "";
    @Column(name="description")
    String description = "";
    @Column(name="operator")
    String operator = "";
    @Column(name="quantity")
    double quantity = 0.0;
    @Column(name="unit_price")
    double unitPrice = 0.0;
    @Column(name="total_price")
    double totalPrice = 0.0;
    
    public InventoryTransactionLineBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryTransactionLineBean(String id)
    {
        super();
        this.setId(id);
    }

    public String getTransactionId() { return this.transactionId; }
    public String getItemId() { return this.itemId; }
    public String getForeignItemId() { return this.foreignItemId; }
    public String getDescription() { return this.description; }
    public String getOperator() { return this.operator; }
    public double getQuantity() { return this.quantity; }
    public double getUnitPrice() { return this.unitPrice; }
    public double getTotalPrice() { return this.totalPrice; }
    
    public void setTransactionId(String val) { this.transactionId = getSafeString(val); }
    public void setItemId(String val) { this.itemId = getSafeString(val); } 
    public void setForeignItemId(String val) { this.foreignItemId = getSafeString(val); } 
    public void setDescription(String val) { this.description = getSafeString(val); } 
    public void setOperator(String val) { this.operator = getSafeString(val); }
    public void setQuantity(double val) { this.quantity = val; }
    public void setUnitPrice(double val) { this.unitPrice = val; }
    public void setTotalPrice(double val) { this.totalPrice = val; }
    
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