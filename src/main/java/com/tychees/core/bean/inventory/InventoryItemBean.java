package com.tychees.core.bean.inventory;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tychees.core.bean.common.CommonGeolocationBean;

@Entity  
@Table(name="inventory_item_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryItemBean 
	extends CommonGeolocationBean
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    @Transient
    public List<InventoryItemPropertiesBean> propertiesList;
    @Transient
    public List<InventoryItemComponentBean> componentList;
    @Transient
    public List<InventoryItemImageBean> imageList;
    @Transient
    public List<InventoryItemRuleBean> ruleList;
    @Transient
    public List<InventoryItemTransactionBean> transactionList;
    
    public InventoryItemBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemBean(String id) 
    {
        super();
        this.setId(id);
        
        this.propertiesList = new ArrayList<InventoryItemPropertiesBean>();
        this.componentList = new ArrayList<InventoryItemComponentBean>();
        this.imageList = new ArrayList<InventoryItemImageBean>();
        this.ruleList = new ArrayList<InventoryItemRuleBean>();
        this.transactionList = new ArrayList<InventoryItemTransactionBean>();
    }

    @Column(name="place_id")
    String placeId = "";
    @Column(name="category_id")
    String categoryId = "";
    @Column(name="category_name")
    String categoryName = "";
    @Column(name="item_type")
    String itemType = "";
    @Column(name="group_name")
    String groupName = "";  // To group similar items, but diff details, e.g. supplier, cost, etc
    @Column(name="name")
    String name = "";
    @Column(name="sku_code")
    String skuCode;
    @Column(name="seqno_in_group")
    int seqnoInGroup = 0;
    @Column(name="labels")
    String labels = "";
    @Column(name="availability")
    String availability;
    @Column(name="pos_visible")
    boolean posVisible = false;
    @Column(name="pws_visible")
    boolean pwsVisible = false;
    @Column(name="scm_visible")
    boolean scmVisible = false;
    @Column(name="image_url")
    String imageUrl = "";
    @Column(name="measurement_unit")
    String measurementUnit = "";
    @Column(name="quantity_optional")
    boolean quantityOptional = false;
    @Column(name="minimum_quantity")
    double minimumQuantity = 0.0;
    @Column(name="quantity")
    double quantity = 0.0;
    @Column(name="unit_cost")
    double unitCost = 0.0;
    @Column(name="unit_price")
    double unitPrice = 0.0;
    @Column(name="tax_inclusive")
    boolean taxInclusive = false;
    @Column(name="tax_discount_in_percentage")
    boolean taxDiscountInPercentage = false;
    @Column(name="tax_discount_in_amount")
    boolean taxDiscountInAmount = false;
    @Column(name="tax_discount_percentage")
    double taxDiscountPercentage = 0.0;
    @Column(name="tax_discount_amount")
    double taxDiscountAmount = 0.0;  
    @Transient
    int imageCount = 0;

    public String getPlaceId() { return this.placeId; }
    public String getCategoryId() { return this.categoryId; }
    public String getCategoryName() { return this.categoryName; }
    public String getItemType() { return this.itemType; }
    public String getGroupName() { return this.groupName; }
    public String getName() { return this.name; }
    public String getSkuCode() { return this.skuCode; }
    public int getSeqnoInGroup() { return this.seqnoInGroup; }
    public String getLabels() { return this.labels; }
    public String getAvailability() { return this.availability; }
    public boolean isPosVisible() { return this.posVisible; }
    public boolean isPwsVisible() { return this.pwsVisible; }
    public boolean isScmVisible() { return this.scmVisible; }
    public String getMeasurementUnit() { return this.measurementUnit; }
    public boolean isQuantityOptional() { return this.quantityOptional; }
    public double getMinimumQuantity() { return this.minimumQuantity; }
    public double getQuantity() { return this.quantity; }
    public double getUnitCost() { return this.unitCost; }
    public double getUnitPrice() { return this.unitPrice; }
    public boolean isTaxInclusive() { return this.taxInclusive; }
    public boolean isTaxDiscountInPercentage() { return this.taxDiscountInPercentage; }
    public boolean isTaxDiscountInAmount() { return this.taxDiscountInAmount; }
    public double getTaxDiscountPercentage() { return this.taxDiscountPercentage; }
    public double getTaxDiscountAmount() { return this.taxDiscountAmount; }
    public int getImageCount() { return this.imageCount; }

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }  
    public void setCategoryId(String val) { this.categoryId = getSafeString(val); }  
    public void setCategoryName(String val) { this.categoryName = getSafeString(val); }  
    public void setItemType(String val) { this.itemType = getSafeString(val); }
    public void setGroupName(String val) { this.groupName = getSafeString(val); }  
    public void setName(String val) { this.name = getSafeString(val); }  
    public void setSkuCode(String val) { this.skuCode = getSafeString(val); }
    public void setSeqnoInGroup(int val) { this.seqnoInGroup = val; } 
    public void setLabels(String val) { this.labels = getSafeString(val); }  
    public void setAvailability(String val) { this.availability = getSafeString(val); }
    public void setPosVisible(boolean val) { this.posVisible = val; }
    public void setPwsVisible(boolean val) { this.pwsVisible = val; }
    public void setScmVisible(boolean val) { this.scmVisible = val; }
    public void setMeasurementUnit(String val) { this.measurementUnit = getSafeString(val); }
    public void setQuantityOptional(boolean val) { this.quantityOptional = val; }
    public void setMinimumQuantity(double val) { this.minimumQuantity = val; }
    public void setQuantity(double val) { this.quantity = val; }
    public void setUnitPrice(double val) { this.unitPrice = val; }
    public void setUnitCost(double val) { this.unitCost = val; }
    public void setTaxInclusive(boolean val) { this.taxInclusive = val; }
    public void setTaxDiscountInPercentage(boolean val) { this.taxDiscountInPercentage = val; }
    public void setTaxDiscountInAmount(boolean val) { this.taxDiscountInAmount = val; }
    public void setTaxDiscountPercentage(double val) { this.taxDiscountPercentage = val; }
    public void setTaxDiscountAmount(double val) { this.taxDiscountAmount = val; }
    public void setImageCount(int val) { this.imageCount = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getName();
	}
}
