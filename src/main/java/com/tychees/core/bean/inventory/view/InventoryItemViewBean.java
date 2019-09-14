package com.tychees.core.bean.inventory.view;

import java.util.UUID;

import com.tychees.core.util.BeanUtil;
import com.tychees.core.bean.inventory.InventoryItemBean;

public class InventoryItemViewBean 
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public InventoryItemViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public InventoryItemViewBean(Object[] queryResultList) 
    {
    	this.setId( ((String)queryResultList[0]) );
    	this.setCategoryId( ((String)queryResultList[1]) );
    	this.setGroupName( ((String)queryResultList[2]) );
    	this.setName( ((String)queryResultList[3]) );
    	this.setLabels( ((String)queryResultList[4]) );
    	this.setPosVisible( ((Boolean)queryResultList[5]).booleanValue() );
    	this.setPwsVisible( ((Boolean)queryResultList[6]).booleanValue() );		
    }   
    
    public InventoryItemViewBean(InventoryItemBean beanObj) 
    {
    	this.setId(beanObj.getId());
    	this.setPlaceId(beanObj.getPlaceId());
    	this.setCategoryId(beanObj.getCategoryId());
    	this.setCategoryName(beanObj.getCategoryName());
    	this.setItemType(beanObj.getItemType());
    	this.setGroupName(beanObj.getGroupName());
    	this.setName(beanObj.getName());
    	this.setSkuCode(beanObj.getSkuCode());
    	this.setLabels(beanObj.getLabels());
    	this.setAvailability(beanObj.getAvailability());
    	this.setQuantityOptional(beanObj.isQuantityOptional());
    	this.setMinimumQuantity(beanObj.getMinimumQuantity());
    	this.setQuantity(beanObj.getQuantity());
    	this.setUnitCost(beanObj.getUnitCost());
    	this.setUnitPrice(beanObj.getUnitPrice());
    	this.setTaxInclusive(beanObj.isTaxInclusive());
    	this.setTaxDiscountPercentage(beanObj.getTaxDiscountPercentage());
    	this.setTaxDiscountAmount(beanObj.getTaxDiscountAmount());
    	this.setPosVisible(beanObj.isPosVisible());
    	this.setPwsVisible(beanObj.isPwsVisible());
    	this.setScmVisible(beanObj.isScmVisible());
    }   

    String id = "";
    String placeId = "";
    String categoryId = "";
    String categoryName = "";
    String itemType = "";
    String groupName = "";  // To group similar items, but diff details, e.g. supplier, cost, etc
    String name = "";
    String skuCode = "";
    String labels = "";
    String availability = "";
    boolean quantityOptional = false;
    double minimumQuantity = 0.0d;
    double quantity = 0.0d;
    double unitCost = 0.0d;
    double unitPrice = 0.0d;
    boolean taxInclusive = false;
    double taxDiscountPercentage = 0.0d;
    double taxDiscountAmount = 0.0d;
    boolean posVisible = false;
    boolean pwsVisible = false;
    boolean scmVisible = false;
    
    public String getId() { return this.id; }
    public String getPlaceId() { return this.placeId; }
    public String getCategoryId() { return this.categoryId; }
    public String getCategoryName() { return this.categoryName; }
    public String getItemType() { return this.itemType; }
    public String getGroupName() { return this.groupName; }
    public String getName() { return this.name; }
    public String getSkuCode() { return this.skuCode; }
    public String getLabels() { return this.labels; }
    public String getAvailability() { return this.availability; }
    public boolean isQuantityOptional() { return this.quantityOptional; }
    public double getMinimumQuantity() { return this.minimumQuantity; }
    public double getQuantity() { return this.quantity; }
    public double getUnitCost() { return this.unitCost; }
    public double getUnitPrice() { return this.unitPrice; }
    public boolean isTaxInclusive() { return this.taxInclusive; }
    public double getTaxDiscountPercentage() { return this.taxDiscountPercentage; }
    public double getTaxDiscountAmount() { return this.taxDiscountAmount; }
    public boolean isPosVisible() { return this.posVisible; }
    public boolean isPwsVisible() { return this.pwsVisible; }
    public boolean isScmVisible() { return this.scmVisible; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setCategoryId(String val) { this.categoryId = getSafeString(val); }  
    public void setCategoryName(String val) { this.categoryName = getSafeString(val); } 
    public void setItemType(String val) { this.itemType = getSafeString(val); }
    public void setGroupName(String val) { this.groupName = getSafeString(val); }  
    public void setName(String val) { this.name = getSafeString(val); }  
    public void setSkuCode(String val) { this.skuCode = getSafeString(val); }  
    public void setLabels(String val) { this.labels = getSafeString(val); }  
    public void setAvailability(String val) { this.availability = getSafeString(val); }  
    public void setQuantityOptional(boolean val) { this.quantityOptional = val; }
    public void setMinimumQuantity(double val) { this.minimumQuantity = getSafeDouble(val); }
    public void setQuantity(double val) { this.quantity = getSafeDouble(val); }
    public void setUnitCost(double val) { this.unitCost = getSafeDouble(val); }
    public void setUnitPrice(double val) { this.unitPrice = getSafeDouble(val); }
    public void setTaxInclusive(boolean val) { this.taxInclusive = val; }
    public void setTaxDiscountPercentage(double val) { this.taxDiscountPercentage = getSafeDouble(val); }
    public void setTaxDiscountAmount(double val) { this.taxDiscountAmount = getSafeDouble(val); }
    public void setPosVisible(boolean val) { this.posVisible = val; }
    public void setPwsVisible(boolean val) { this.pwsVisible = val; }
    public void setScmVisible(boolean val) { this.scmVisible = val; }
}
