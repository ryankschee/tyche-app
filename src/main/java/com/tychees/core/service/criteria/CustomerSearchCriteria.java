package com.tychees.core.service.criteria;

public class CustomerSearchCriteria 
	extends AbstractSearchCriteria
{
    private boolean filterByCustomerType;
    private String customerType;
	
    public CustomerSearchCriteria(String placeId) 
    {
        super(placeId);
    }

    public boolean isFilterByCustomerType() { return this.filterByCustomerType; }
    public String getCustomerType() { return this.customerType; }

    public void setFilterByCustomerType(boolean val) { this.filterByCustomerType = val; }
    public void setCustomerType(String val) { this.customerType = val; }
}