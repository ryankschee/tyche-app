package com.tychees.core.service.criteria;

public class OpportunitySearchCriteria 
	extends AbstractSearchCriteria
{
	private String customerId;
	
    public OpportunitySearchCriteria(String placeId) 
    {
        super(placeId);
        setCustomerId("");
    }
    
    public String getCustomerId() { return this.customerId; }
    
    public void setCustomerId(String val) { this.customerId = val; }
}