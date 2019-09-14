package com.tychees.core.service.criteria;

public class BillingBucketSearchCriteria 
	extends AbstractSearchCriteria
{
	private boolean filterByBucketStatus;
	private String bucketStatus;
	
    public BillingBucketSearchCriteria(String placeId) 
    {
        super(placeId);
        setFilterByBucketStatus(false);
        setBucketStatus("");
    }

    public boolean isFilterByBucketStatus() { return this.filterByBucketStatus; }
    public String getBucketStatus() { return this.bucketStatus; }
    
    public void setFilterByBucketStatus(boolean val) { this.filterByBucketStatus = val; }
    public void setBucketStatus(String val) { this.bucketStatus = val; }
}