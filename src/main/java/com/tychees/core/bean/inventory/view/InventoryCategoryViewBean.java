package com.tychees.core.bean.inventory.view;

import java.util.UUID;

import com.tychees.core.util.BeanUtil;
import com.tychees.core.bean.inventory.InventoryCategoryBean;

public class InventoryCategoryViewBean
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public InventoryCategoryViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryCategoryViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public InventoryCategoryViewBean(InventoryCategoryBean beanObj) 
    {
    	super();
    	this.setId(beanObj.getId());
    	this.setPlaceId(beanObj.getPlaceId());
    	this.setParentCategoryId(beanObj.getParentCategoryId());
    	this.setParentCategoryName(beanObj.getParentCategoryName());
    	this.setItemType(beanObj.getItemType());
    	this.setName(beanObj.getName());
    	this.setSeqno(beanObj.getSeqno());
    	this.setSystemDefined(beanObj.isSystemDefined());
    	this.setPosVisible(beanObj.isPosVisible());
    	this.setScmVisible(beanObj.isScmVisible());
    }    

    String id = "";
    String placeId = "";
    String parentCategoryId = "";
    String parentCategoryName = "";
    String itemType = "";
    String name = "";  
    int seqno = -1;
    boolean systemDefined = false;
    boolean posVisible = false;
    boolean scmVisible = false;
    
    public String getId() { return this.id; }
    public String getPlaceId() { return this.placeId; }
    public String getParentCategoryId() { return this.parentCategoryId; }
    public String getParentCategoryName() { return this.parentCategoryName; }
    public String getItemType() { return this.itemType; }
    public String getName() { return this.name; }
    public int getSeqno() { return this.seqno; }
    public boolean isSystemDefined() { return this.systemDefined; }
    public boolean isPosVisible() { return this.posVisible; }
    public boolean isScmVisible() { return this.scmVisible; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setParentCategoryId(String val) { this.parentCategoryId = getSafeString(val); }
    public void setParentCategoryName(String val) { this.parentCategoryName = getSafeString(val); }
    public void setItemType(String val) { this.itemType = getSafeString(val); }  
    public void setName(String val) { this.name = getSafeString(val); }  
    public void setSeqno(int val) { this.seqno = val; }    
    public void setSystemDefined(boolean val) { this.systemDefined = val; }
    public void setPosVisible(boolean val) { this.posVisible = val; }
    public void setScmVisible(boolean val) { this.scmVisible = val; }
}
