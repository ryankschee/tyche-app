package com.tychees.core.bean.inventory.view;

import java.util.UUID;

import com.tychees.core.util.BeanUtil;
import com.tychees.core.bean.inventory.InventoryItemBean;

public class InventoryItemCompactViewBean 
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public InventoryItemCompactViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemCompactViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public InventoryItemCompactViewBean(InventoryItemBean beanObj) 
    {
    	this.setId(beanObj.getId());
    	this.setPlaceId(beanObj.getPlaceId());
    	this.setItemType(beanObj.getItemType());
    	this.setName(beanObj.getName());
    	this.setLabels(beanObj.getLabels());
    	this.setAvailability(beanObj.getAvailability());
    	this.setQuantity( beanObj.getQuantity() );	
    	this.setUnitCost( beanObj.getUnitCost() );	
    	this.setUnitPrice(beanObj.getUnitPrice());
    	this.setTaxInclusive( beanObj.isTaxInclusive() );	
    	this.setTaxDiscountPercentage( beanObj.getTaxDiscountPercentage() );	
    	this.setTaxDiscountAmount( beanObj.getTaxDiscountAmount() );	
    }   

    public InventoryItemCompactViewBean(Object[] queryResultList) 
    {
    	this.setId( ((String)queryResultList[0]) );
    	this.setPlaceId("");
    	this.setItemType( ((String)queryResultList[1]) );
    	this.setName( ((String)queryResultList[2]) );
    	this.setLabels( ((String)queryResultList[3]) );
    	this.setAvailability( ((String)queryResultList[4]) );
    	this.setQuantity( ((Double)queryResultList[5]).doubleValue() );	
    	this.setUnitCost( ((Double)queryResultList[6]).doubleValue() );	
    	this.setUnitPrice( ((Double)queryResultList[7]).doubleValue() );	
    	this.setTaxInclusive( ((Boolean)queryResultList[8]).booleanValue() );	
    	this.setTaxDiscountPercentage( ((Double)queryResultList[9]).doubleValue() );	
    	this.setTaxDiscountAmount( ((Double)queryResultList[10]).doubleValue() );	    	
    }   
    
    String id = "";
    String placeId = "";
    String itemType = "";
    String name = "";
    String labels = "";
    String availability = "";
    double quantity = 0.0d;
    double unitCost = 0.0d;
    double unitPrice = 0.0d;
    boolean taxInclusive = false;
    double taxDiscountPercentage = 0.0d;
    double taxDiscountAmount = 0.0d;
    
    public String getId() { return this.id; }
    public String getPlaceId() { return this.placeId; }
    public String getItemType() { return this.itemType; }
    public String getName() { return this.name; }
    public String getLabels() { return this.labels; }
    public String getAvailability() { return this.availability; }
    public double getQuantity() { return this.quantity; }
    public double getUnitCost() { return this.unitCost; }
    public double getUnitPrice() { return this.unitPrice; }
    public boolean isTaxInclusive() { return this.taxInclusive; }
    public double getTaxDiscountPercentage() { return this.taxDiscountPercentage; }
    public double getTaxDiscountAmount() { return this.taxDiscountAmount; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setItemType(String val) { this.itemType = getSafeString(val); } 
    public void setName(String val) { this.name = getSafeString(val); }  
    public void setLabels(String val) { this.labels = getSafeString(val); }  
    public void setAvailability(String val) { this.availability = getSafeString(val); }  
    public void setQuantity(double val) { this.quantity = val; }
    public void setUnitCost(double val) { this.unitCost = val; }
    public void setUnitPrice(double val) { this.unitPrice = val; }
    public void setTaxInclusive(boolean val) { this.taxInclusive = val; }
    public void setTaxDiscountPercentage(double val) { this.taxDiscountPercentage = val; }
    public void setTaxDiscountAmount(double val) { this.taxDiscountAmount = val; }
}
