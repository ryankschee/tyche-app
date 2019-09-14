package com.tychees.core.service.criteria;

import java.util.ArrayList;
import java.util.List;

public class InventorySearchCriteria 
	extends AbstractSearchCriteria
{
    private String categoryId;				   // If true, will execute full bean retrieval (including filters, such as fullBeanByCategoryId); otherwise none will get full bean.
    private String groupName;
    private String itemId;
    private List<String> fullBeanByCategory;   // contains list of category ID, denotes item(s) within is retrived in FULL BEAN
    private boolean filterByPosVisible;
    private boolean posVisible;
    private boolean filterByPwsVisible;
    private boolean pwsVisible;
    private boolean loadComponentItems;
    private boolean filterByGroupName;
    private boolean viewBean;
    private boolean mandatory;					// ONLY for getting item by components
    private boolean optional;					// ONLY for getting item by components
    
    public InventorySearchCriteria(String placeId) 
    {
    	super(placeId);
        this.filterByPosVisible = false;
        this.filterByPwsVisible = false;
        this.fullBeanByCategory = new ArrayList<String>();
        this.loadComponentItems = false;
        this.filterByGroupName = false;
        this.viewBean = false;
        this.mandatory = false;
        this.optional = false;
    }
    
    public String getCategoryId() { return this.categoryId; }
    public String getGroupName() { return this.groupName; }
    public String getItemId() { return this.itemId; }
    public List<String> getFullBeanByCategory() { return this.fullBeanByCategory; }
    public boolean isFilterByPosVisible() { return this.filterByPosVisible; }
    public boolean isPosVisible() { return this.posVisible; }
    public boolean isFilterByPwsVisible() { return this.filterByPwsVisible; }
    public boolean isPwsVisible() { return this.pwsVisible; }
    public boolean isLoadComponentItems() { return this.loadComponentItems; }
    public boolean isFilterByGroupName() { return this.filterByGroupName; }
    public boolean isViewBean() { return this.viewBean; }
    public boolean isMandatory() { return this.mandatory; }
    public boolean isOptional() { return this.optional; }
    
    public void setCategoryId(String val) { this.categoryId = val; }
    public void setGroupName(String val) { this.groupName = val; }
    public void setItemId(String val) { this.itemId = val; }
    public void setFullBeanByCategory(List<String> val) { this.fullBeanByCategory = val; }
    public void setFilterByPosVisible(boolean val) { this.filterByPosVisible = val; }
    public void setPosVisible(boolean val) { this.posVisible = val; }
    public void setFilterByPwsVisible(boolean val) { this.filterByPwsVisible = val; }
    public void setPwsVisible(boolean val) { this.pwsVisible = val; }
    public void setLoadComponentItems(boolean val) { this.loadComponentItems = val; }
    public void setFilterByGroupName(boolean val) { this.filterByGroupName = val; }
    public void setViewBean(boolean val) { this.viewBean = val; }
    public void setMandatory(boolean val) { this.mandatory = val; }
    public void setOptional(boolean val) { this.optional = val; }
    
    public InventorySearchCriteria clone()
    {
    	InventorySearchCriteria cloned = new InventorySearchCriteria(this.getPlaceId());
    	
    	cloned.setCategoryId(this.getCategoryId());
    	cloned.setFilterByGroupName(this.isFilterByGroupName());
    	cloned.setFilterByLastSyncedTime(this.isFilterByLastSyncedTime());
    	cloned.setFilterByPosVisible(this.isFilterByPosVisible());
    	cloned.setFilterByPwsVisible(this.isFilterByPwsVisible());
    	cloned.setFullBean(this.isFullBean());
    	cloned.setFullBeanByCategory(this.getFullBeanByCategory());
    	cloned.setGroupName(this.getGroupName());
    	cloned.setItemId(this.getItemId());
    	cloned.setLastSyncedTime(this.getLastSyncedTime());
    	cloned.setLoadComponentItems(this.isLoadComponentItems());
    	cloned.setPlaceId(this.getPlaceId());
    	cloned.setPosVisible(this.isPosVisible());
    	cloned.setPwsVisible(this.isPwsVisible());
    	cloned.setViewBean(this.isViewBean());
    	cloned.setMandatory(this.isMandatory());
    	cloned.setOptional(this.isOptional());
    	    	
    	return cloned;
    }
}