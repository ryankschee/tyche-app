package com.tychees.core.bean.billing.view;

import java.sql.Timestamp;
import java.util.UUID;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.util.BeanUtil;

public class BillingViewBean
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public BillingViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public BillingViewBean(BillingBean beanObj)
    {
        super();
        this.setId(beanObj.getId());
        this.setPlaceId(beanObj.getPlaceId());
        this.setBillingNo(beanObj.getBillingNo());
        this.setCustomerId(beanObj.getCustomerId());
        this.setCustomerName(beanObj.getCustomerName());
        this.setState(beanObj.getState());
        this.setStateDesc(beanObj.getStateDesc());
        this.setTotalAmount(beanObj.getTotalAmount());
        this.setTotalPayment(beanObj.getTotalPayment());
        this.setInvoiceNo(beanObj.getInvoiceNo());
        this.setReceiptNo(beanObj.getReceiptNo());
        this.setQuotationNo(beanObj.getQuotationNo());
        this.setBillingDate(beanObj.getBillingDate());
    }
    
    String id = "";
    String placeId;
    String billingNo = "";
    String customerId = "";
    String customerName = "";  
    String state = ""; 
    String stateDesc = "";
    double totalAmount = 0.0d;
    double totalPayment = 0.0d;
    String invoiceNo = "";
    String receiptNo = "";
    String quotationNo = "";
    Timestamp billingDate;
    
    public String getId() { return this.id; }
    public String getPlaceId() { return this.placeId; }
    public String getBillingNo() { return this.billingNo; }
    public String getCustomerId() { return this.customerId; }
    public String getCustomerName() { return this.customerName; }
    public String getState() { return this.state; }
    public String getStateDesc() { return this.stateDesc; }
    public double getTotalAmount() { return this.totalAmount; }
    public double getTotalPayment() { return this.totalPayment; }
    public String getInvoiceNo() { return this.invoiceNo; }
    public String getReceiptNo() { return this.receiptNo; }
    public String getQuotationNo() { return this.quotationNo; }
    public Timestamp getBillingDate() { return this.billingDate; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setBillingNo(String val) { this.billingNo = getSafeString(val); }  
    public void setCustomerId(String val) { this.customerId = getSafeString(val); }  
    public void setCustomerName(String val) { this.customerName = getSafeString(val); }  
    public void setState(String val) { this.state = val; }   
    public void setStateDesc(String val) { this.stateDesc = val; }  
    public void setTotalAmount(double val) { this.totalAmount = getSafeDouble(val); }  
    public void setTotalPayment(double val) { this.totalPayment = getSafeDouble(val); }  
    public void setInvoiceNo(String val) { this.invoiceNo = getSafeString(val); }  
    public void setReceiptNo(String val) { this.receiptNo = getSafeString(val); }  
    public void setQuotationNo(String val) { this.quotationNo = getSafeString(val); }  
    public void setBillingDate(Timestamp val) { this.billingDate = val; }
}
