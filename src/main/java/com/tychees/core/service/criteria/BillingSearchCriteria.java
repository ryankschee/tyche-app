package com.tychees.core.service.criteria;

public class BillingSearchCriteria 
	extends AbstractSearchCriteria
{
	private String customerId;
	private String bucketId;
	private long beginTime;
	private long endTime;
	private boolean filterByBillingDate = true;
	private boolean filterByInvoiceDate = false;
	
    public BillingSearchCriteria(String placeId) 
    {
        super(placeId);
        setCustomerId("");
        setBucketId("");
    }
    
    public String getCustomerId() { return this.customerId; }
    public String getBucketId() { return this.bucketId; }
    public long getBeginTime() { return this.beginTime; }
    public long getEndTime() { return this.endTime; }
    public boolean isFilterByBillingDate() { return this.filterByBillingDate; }
    public boolean isFilterByInvoiceDate() { return this.filterByInvoiceDate; }
    
    public void setCustomerId(String val) { this.customerId = val; }
    public void setBucketId(String val) { this.bucketId = val; }
    public void setBeginTime(long val) { this.beginTime = val; }
    public void setEndTime(long val) { this.endTime = val; }
    public void setFilterByBillingDate(boolean val) { this.filterByBillingDate = val; }
    public void setFilterByInvoiceDate(boolean val) { this.filterByInvoiceDate = val; }
}