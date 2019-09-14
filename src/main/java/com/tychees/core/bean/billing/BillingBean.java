package com.tychees.core.bean.billing;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tychees.core.bean.BeanSuperClass;
import com.tychees.core.bean.common.CommonCalendarBean;

@Entity  
@Table(name="billing_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class BillingBean 
    extends BeanSuperClass
	implements java.io.Serializable 
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Transient
    public List<CommonCalendarBean> calendarList;
    @Transient
    public List<BillingDeliveryBean> deliveryList;
    @Transient
    public List<BillingLineBean> lineList;
    @Transient
    public List<BillingPaymentBean> paymentList;
    @Transient
    public List<BillingPropertiesBean> propertiesList;
    @Transient
    public List<BillingWorkflowBean> workflowList;
    
    public BillingBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public BillingBean(String id)
    {
        super();
        this.setId(id);
        
        this.deliveryList = new ArrayList<BillingDeliveryBean>();
        this.lineList = new ArrayList<BillingLineBean>();
        this.paymentList = new ArrayList<BillingPaymentBean>();
        this.propertiesList = new ArrayList<BillingPropertiesBean>();
        this.workflowList = new ArrayList<BillingWorkflowBean>();
        this.calendarList = new ArrayList<CommonCalendarBean>();
    }
    
    @Column(name="bucket_id")
    String bucketId = "";
	@Column(name="billing_no") 
    String billingNo = "";
	@Column(name="billing_date") 
    Timestamp billingDate;
	@Column(name="place_id") 
    String placeId = "";
	@Column(name="customer_id") 
    String customerId = "";
	@Column(name="customer_name") 
    String customerName = "";
	@Column(name="employee_id") 
    String employeeId = "";
	@Column(name="employee_name") 
    String employeeName = "";
	@Column(name="transaction_id") 
    String transactionId = "";
	@Column(name="state") 
    String state = "";
	@Column(name="state_desc") 
    String stateDesc = "";
	@Column(name="tax_amount") 
    double taxAmount = 0.0;
	@Column(name="tax_percentage") 
    double taxPercentage = 0.0;
	@Column(name="discount_amount") 
    double discountAmount = 0.0;
	@Column(name="discount_percentage") 
    double discountPercentage = 0.0;
	@Column(name="sub_total_amount") 
    double subTotalAmount = 0.0;
	@Column(name="total_amount") 
    double totalAmount = 0.0;
	@Column(name="round_off_amount") 
    double roundOffAmount = 0.0;
	@Column(name="total_payment") 
    double totalPayment = 0.0;
	@Column(name="payment_terms") 
    String paymentTerms = "";
	@Column(name="purchase_order_no") 
    String purchaseOrderNo = "";
	@Column(name="purchase_order_date") 
    Timestamp purchaseOrderDate;
	@Column(name="invoice_no") 
    String invoiceNo = "";
	@Column(name="invoice_date") 
    Timestamp invoiceDate;
	@Column(name="receipt_no") 
    String receiptNo = "";
	@Column(name="receipt_date") 
    Timestamp receiptDate;
	@Column(name="quotation_no") 
    String quotationNo = "";
	@Column(name="quotation_date") 
    Timestamp quotationDate;
	@Column(name="attributes")
	String attributes = "";
    
    public String getBucketId() { return this.bucketId; }
    public String getBillingNo() { return this.billingNo; }
    public Timestamp getBillingDate() { return this.billingDate; }
    public String getPlaceId() { return this.placeId; }
    public String getCustomerId() { return this.customerId; }
    public String getCustomerName() { return this.customerName; }
    public String getEmployeeId() { return this.employeeId; }
    public String getEmployeeName() { return this.employeeName; }
    public String getTransactionId() { return this.transactionId; }
    public String getState() { return this.state; }
    public String getStateDesc() { return this.stateDesc; }
    public double getTaxAmount() { return this.taxAmount; }
    public double getTaxPercentage() { return this.taxPercentage; }
    public double getDiscountAmount() { return this.discountAmount; }
    public double getDiscountPercentage() { return this.discountPercentage; }
    public double getSubTotalAmount() { return this.subTotalAmount; }
    public double getTotalAmount() { return this.totalAmount; }
    public double getRoundOffAmount() { return this.roundOffAmount; }
    public double getTotalPayment() { return this.totalPayment; }
    public String getPaymentTerms() { return this.paymentTerms; }
    public String getPurchaseOrderNo() { return this.purchaseOrderNo; }
    public Timestamp getPurchaseOrderDate() { return this.purchaseOrderDate; }
    public String getInvoiceNo() { return this.invoiceNo; }
    public Timestamp getInvoiceDate() { return this.invoiceDate; }
    public String getReceiptNo() { return this.receiptNo; }
    public Timestamp getReceiptDate() { return this.receiptDate; }
    public String getQuotationNo() { return this.quotationNo; }
    public Timestamp getQuotationDate() { return this.quotationDate; }
    public String getAttributes() { return this.attributes; }
    
    public void setBucketId(String val) { this.bucketId = val; }
    public void setBillingNo(String val) { this.billingNo = val; }
    public void setBillingDate(Timestamp val) { this.billingDate = val; }
    public void setPlaceId(String val) { this.placeId = val; }
    public void setCustomerId(String val) { this.customerId = val; }
    public void setCustomerName(String val) { this.customerName = val; }
    public void setEmployeeId(String val) { this.employeeId = val; }
    public void setEmployeeName(String val) { this.employeeName = val; }
    public void setTransactionId(String val) { this.transactionId = val; }
    public void setState(String val) { this.state = val; }
    public void setStateDesc(String val) { this.stateDesc = val; }
    public void setTaxAmount(double val) { this.taxAmount = val; }
    public void setTaxPercentage(double val) { this.taxPercentage = val; }
    public void setDiscountAmount(double val) { this.discountAmount = val; }
    public void setDiscountPercentage(double val) { this.discountPercentage = val; }
    public void setSubTotalAmount(double val) { this.subTotalAmount = val; }
    public void setTotalAmount(double val) { this.totalAmount = val; }
    public void setRoundOffAmount(double val) { this.roundOffAmount = val; }
    public void setTotalPayment(double val) { this.totalPayment = val; }
    public void setPaymentTerms(String val) { this.paymentTerms = getSafeString(val); }
    public void setPurchaseOrderNo(String val) { this.purchaseOrderNo = getSafeString(val); }
    public void setPurchaseOrderDate(Timestamp val) { this.purchaseOrderDate = val; }
    public void setInvoiceNo(String val) { this.invoiceNo = getSafeString(val); }
    public void setInvoiceDate(Timestamp val) { this.invoiceDate = val; }
    public void setReceiptNo(String val) { this.receiptNo = getSafeString(val); }
    public void setReceiptDate(Timestamp val) { this.receiptDate = val; }
    public void setQuotationNo(String val) { this.quotationNo = getSafeString(val); }
    public void setQuotationDate(Timestamp val) { this.quotationDate = val; }
    public void setAttributes(String val) { this.attributes = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getBillingNo();
	}
}