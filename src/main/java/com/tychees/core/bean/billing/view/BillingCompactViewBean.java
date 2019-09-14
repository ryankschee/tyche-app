package com.tychees.core.bean.billing.view;

import java.sql.Timestamp;
import java.util.UUID;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.util.BeanUtil;

public class BillingCompactViewBean
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public BillingCompactViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingCompactViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public BillingCompactViewBean(BillingBean beanObj)
    {
        super();
        this.setId(beanObj.getId());
        this.setBillingNo(beanObj.getBillingNo());
        this.setEmployeeName(beanObj.getEmployeeName());
        this.setCustomerName(beanObj.getCustomerName());
        this.setTotalAmount(beanObj.getTotalAmount());
        this.setTotalPayment(beanObj.getTotalPayment());
        this.setInvoiceNo(beanObj.getInvoiceNo());
        this.setReceiptNo(beanObj.getReceiptNo());
        this.setQuotationNo(beanObj.getQuotationNo());
        this.setBillingDate(beanObj.getBillingDate());
    }
    
    String id = "";
    String billingNo = "";
    String customerName = "";  
    String employeeName = "";  
    double totalAmount = 0.0d;
    double totalPayment = 0.0d;
    String invoiceNo = "";
    String receiptNo = "";
    String quotationNo = "";
    Timestamp billingDate;
    
    public String getId() { return this.id; }
    public String getBillingNo() { return this.billingNo; }
    public String getCustomerName() { return this.customerName; }
    public String getEmployeeName() { return this.employeeName; }
    public double getTotalAmount() { return this.totalAmount; }
    public double getTotalPayment() { return this.totalPayment; }
    public String getInvoiceNo() { return this.invoiceNo; }
    public String getReceiptNo() { return this.receiptNo; }
    public String getQuotationNo() { return this.quotationNo; }
    public Timestamp getBillingDate() { return this.billingDate; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setBillingNo(String val) { this.billingNo = getSafeString(val); }  
    public void setCustomerName(String val) { this.customerName = getSafeString(val); }  
    public void setEmployeeName(String val) { this.employeeName = getSafeString(val); }  
    public void setTotalAmount(double val) { this.totalAmount = getSafeDouble(val); }  
    public void setTotalPayment(double val) { this.totalPayment = getSafeDouble(val); }  
    public void setInvoiceNo(String val) { this.invoiceNo = getSafeString(val); }  
    public void setReceiptNo(String val) { this.receiptNo = getSafeString(val); }  
    public void setQuotationNo(String val) { this.quotationNo = getSafeString(val); }  
    public void setBillingDate(Timestamp val) { this.billingDate = val; }
}
