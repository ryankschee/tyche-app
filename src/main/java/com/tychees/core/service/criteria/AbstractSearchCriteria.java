package com.tychees.core.service.criteria;

public class AbstractSearchCriteria 
{
    private String placeId;
    private boolean fullBean;
    private boolean filterByLastSyncedTime;
    private long lastSyncedTime;
    
    public AbstractSearchCriteria(String placeId) 
    {
        this.placeId = placeId;
        this.fullBean = false;
        this.filterByLastSyncedTime = false;
        this.lastSyncedTime = 0L;
    }
    
    public String getPlaceId() { return this.placeId; }
    public boolean isFullBean() { return this.fullBean; }
    public boolean isFilterByLastSyncedTime() { return this.filterByLastSyncedTime; }
    public long getLastSyncedTime() { return this.lastSyncedTime; }
    
    public void setPlaceId(String val) { this.placeId = val; }
    public void setFullBean(boolean val) { this.fullBean = val; }
    public void setFilterByLastSyncedTime(boolean val) { this.filterByLastSyncedTime = val; }
    public void setFilterByLastSyncedTime(boolean filterByLastSyncedTime, long lastSyncedTime) { 
    	this.filterByLastSyncedTime = filterByLastSyncedTime; 
    	this.lastSyncedTime = lastSyncedTime;
    }
    public void setLastSyncedTime(long val) { this.lastSyncedTime = val; }    
}