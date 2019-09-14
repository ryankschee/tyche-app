package com.tychees.core.bean.report;

public class ReportByCustomerOverviewBean 
    implements java.io.Serializable
{
	private static final long serialVersionUID = -2492795358937757063L;
    
    String customerId = "";
    String customerName = "";
    String customerType = "";
    String state = "";
    String area = "";
    String city = "";
    String lastBillingNo = "";
    long billingCount = 0;
    double totalAmount = 0.0;
    
    public ReportByCustomerOverviewBean() {}

    public String getCustomerId() { return this.customerId; }
    public String getCustomerName() { return this.customerName; }
    public String getCustomerType() { return this.customerType; }
    public String getState() { return this.state; }
    public String getArea() { return this.area; }
    public String getCity() { return this.city; }
    public String getLastBillingNo() { return this.lastBillingNo; }
    public long getBillingCount() { return this.billingCount; }
    public double getTotalAmount() { return this.totalAmount; }
    
    public void setCustomerId(String val) { this.customerId = val; }
    public void setCustomerName(String val) { this.customerName = val; }
    public void setCustomerType(String val) { this.customerType = val; }
    public void setState(String val) { this.state = val; }
    public void setArea(String val) { this.area = val; }
    public void setCity(String val) { this.city = val; }
    public void setLastBillingNo(String val) { this.lastBillingNo = val; }
    public void setBillingCount(long val) { this.billingCount = val; }
    public void setTotalAmount(double val) { this.totalAmount = val; }
}
