package com.tychees.core.bean.billing;

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
@Table(name="billing_line_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class BillingLineBean
    extends BeanSuperClass
	implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Transient
    public List<BillingLineBean> lineList;
    @Transient
    public List<BillingLineBean> mandatoryList;
    
    public BillingLineBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingLineBean(String id)
    {
        super();
        this.setId(id);
        
        this.lineList = new ArrayList<BillingLineBean>();
        this.mandatoryList = new ArrayList<BillingLineBean>();
    }

    @Column(name="billing_id")
    String billingId = "";
    @Column(name="parent_line_id")
    String parentLineId = "";
    @Column(name="component_id")
    String componentId = "";
    @Column(name="item_id")
    String itemId = "";
    @Column(name="item_name")
    String itemName = "";    
    @Column(name="item_type")
    String itemType = "";    
    @Column(name="item_group_name")
    String itemGroupName = "";
    @Column(name="item_image_url")
    String itemImageUrl = "";
    @Column(name="row_id")
    String rowId = "";
    @Column(name="seqno")
    int seqno = 0;
    @Column(name="selected")
    boolean selected = false;
    @Column(name="mandatory")
    boolean mandatory = false;					// IF TRUE, this billing line is at mandatory list
    @Column(name="ignored")
    boolean ignored = false;                 	// If TRUE, this billing line will not get processed.
    @Column(name="quantity")
    double quantity = 0.0;
    @Column(name="quantity_optional")
    boolean quantityOptional = false;
    @Column(name="unit_price_source")
    String unitPriceSource = "";
    @Column(name="default_unit_price")
    double defaultUnitPrice = 0.0;
    @Column(name="compound_unit_price")
    double compoundUnitPrice = 0.0;
    @Column(name="custom_unit_price")
    double customUnitPrice = 0.0;
    @Column(name="compound_unit_cost")
    double compoundUnitCost = 0.0;    
    @Column(name="item_unit_price")
    double itemUnitPrice = 0.0;					// NEW - Item Unit Price (do not change after billing line created)
    @Column(name="billable_amount")
    double billableAmount = 0.0;				// NEW - Billable amount: Amount not include tax, and after discount.     
    @Column(name="tax_inclusive")
    boolean taxInclusive = false;
    @Column(name="tax_discount_in_percentage")
    boolean taxDiscountInPercentage = false;
    @Column(name="tax_discount_in_amount")
    boolean taxDiscountInAmount = false;
    @Column(name="tax_amount")
    double taxAmount = 0.0;
    @Column(name="tax_percentage")
    double taxPercentage = 0.0;
    @Column(name="discount_amount")
    double discountAmount = 0.0;
    @Column(name="discount_percentage")
    double discountPercentage = 0.0;
    
    public String getBillingId() { return this.billingId; }
    public String getParentLineId() { return this.parentLineId; }
    public String getComponentId() { return this.componentId; }
    public String getItemId() { return this.itemId; }
    public String getItemName() { return this.itemName; }
    public String getItemType() { return this.itemType; }
    public String getItemGroupName() { return this.itemGroupName; }
    public String getRowId() { return this.rowId; }
    public int getSeqno() { return this.seqno; }
    public boolean isSelected() { return this.selected; }
    public boolean isMandatory() { return this.mandatory; }
    public boolean isIgnored() { return this.ignored; }
    public double getQuantity() { return this.quantity; }
    public boolean isQuantityOptional() { return this.quantityOptional; }
    public String getUnitPriceSource() { return this.unitPriceSource; }
    public double getDefaultUnitPrice() { return this.defaultUnitPrice; }
    public double getCustomUnitPrice() { return this.customUnitPrice; }
    public double getCompoundUnitCost() { return this.compoundUnitCost; }
    public double getCompoundUnitPrice() { return this.compoundUnitPrice; }
    public double getItemUnitPrice() { return this.itemUnitPrice; }
    public double getBillableAmount() { return this.billableAmount; }
    public boolean isTaxInclusive() { return this.taxInclusive; }
    public boolean isTaxDiscountInPercentage() { return this.taxDiscountInPercentage; }
    public boolean isTaxDiscountInAmount() { return this.taxDiscountInAmount; }
    public double getTaxAmount() { return this.taxAmount; }
    public double getTaxPercentage() { return this.taxPercentage; }
    public double getDiscountAmount() { return this.discountAmount; }
    public double getDiscountPercentage() { return this.discountPercentage; }
    
    public void setBillingId(String val) { this.billingId = getSafeString(val); }
    public void setParentLineId(String val) { this.parentLineId = getSafeString(val); }
    public void setComponentId(String val) { this.componentId = getSafeString(val); }
    public void setItemId(String val) { this.itemId = getSafeString(val); } 
    public void setItemName(String val) { this.itemName = getSafeString(val); }  
    public void setItemType(String val) { this.itemType = getSafeString(val); }
    public void setItemGroupName(String val) { this.itemGroupName = getSafeString(val); }  
    public void setRowId(String val) { this.rowId = getSafeString(val); }
    public void setSeqno(int val) { this.seqno = val; }
    public void setSelected(boolean val) { this.selected = val; }
    public void setMandatory(boolean val) { this.mandatory = val; }
    public void setIgnored(boolean val) { this.ignored = val; }
    public void setQuantity(double val) { this.quantity = val; }
    public void setQuantityOptional(boolean val) { this.quantityOptional = val; }
    public void setUnitPriceSource(String val) { this.unitPriceSource = getSafeString(val); }
    public void setDefaultUnitPrice(double val) { this.defaultUnitPrice = val; }
    public void setCustomUnitPrice(double val) { this.customUnitPrice = val; }
    public void setCompoundUnitCost(double val) { this.compoundUnitCost = val; }
    public void setCompoundUnitPrice(double val) { this.compoundUnitPrice = val; }
    public void setItemUnitPrice(double val) { this.itemUnitPrice = val; }
    public void setBillableAmount(double val) { this.billableAmount = val; }
    public void setTaxInclusive(boolean val) { this.taxInclusive = val; }
    public void setTaxDiscountInPercentage(boolean val) { this.taxDiscountInPercentage = val; }
    public void setTaxDiscountInAmount(boolean val) { this.taxDiscountInAmount = val; }
    public void setTaxAmount(double val) { this.taxAmount = val; }
    public void setTaxPercentage(double val) { this.taxPercentage = val; }
    public void setDiscountAmount(double val) { this.discountAmount = val; }
    public void setDiscountPercentage(double val) { this.discountPercentage = val; }
    
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