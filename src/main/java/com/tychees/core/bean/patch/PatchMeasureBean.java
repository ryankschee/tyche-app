package com.tychees.core.bean.patch;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity  
@Table(name="patch_measure_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PatchMeasureBean 
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    public PatchMeasureBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PatchMeasureBean(String id) 
    {
    	super();  
        this.setId(id);
    }

	@Id  
    @Column(name="id")
    String id = "";
	@Column(name="measure_form_date")
	Timestamp measureFormDate;
	@Column(name="measure_form_event_date")
	Timestamp measureFormEventDate;
	@Column(name="measure_form_first_fitting_date")
	Timestamp measureFormFirstFittingDate;
	@Column(name="measure_form_first_fitting_date_checked")
	boolean measureFormFirstFittingDateChecked;
	@Column(name="measure_form_second_fitting_date")
	Timestamp measureFormSecondFittingDate;
	@Column(name="measure_form_second_fitting_date_checked")
	boolean measureFormSecondFittingDateChecked;
	@Column(name="measure_form_pick_up_date")
	Timestamp measureFormPickUpDate;
	@Column(name="measure_form_pick_up_date_checked")
	boolean measureFormPickUpDateChecked;
    @Column(name="measure_form_status")
    String measureFormStatus = "";
    @Column(name="measure_form_amount")
    double measureFormAmount = 0.0d;
    @Column(name="measure_form_payment")
    double measureFormPayment = 0.0d;
    @Column(name="measure_form_changes")
    double measureFormChanges = 0.0d;
    @Column(name="measure_form_remarks")
    String measureFormRemarks = "";
    @Column(name="customer_id")
    String customerId = "";
    @Column(name="customer_name")
    String customerName = "";
    @Column(name="tax_invoice_no")
    String taxInvoiceNo = "";
	@Column(name="tax_invoice_date")
	Timestamp taxInvoiceDate;
    
	public String getId() { return this.id; }
    public Timestamp getMeasureFormDate() { return this.measureFormDate; }
    public Timestamp getMeasureFormEventDate() { return this.measureFormEventDate; }
    public Timestamp getMeasureFormFirstFittingDate() { return this.measureFormFirstFittingDate; }
    public boolean getMeasureFormFirstFittingDateChecked() { return this.measureFormFirstFittingDateChecked; }
    public Timestamp getMeasureFormSecondFittingDate() { return this.measureFormSecondFittingDate; }
    public boolean getMeasureFormSecondFittingDateChecked() { return this.measureFormSecondFittingDateChecked; }
    public Timestamp getMeasureFormPickUpDate() { return this.measureFormPickUpDate; }
    public boolean getMeasureFormPickUpDateChecked() { return this.measureFormPickUpDateChecked; }
    public String getMeasureFormStatus() { return this.measureFormStatus; }
    public double getMeasureFormAmount() { return this.measureFormAmount; }
    public double getMeasureFormPayment() { return this.measureFormPayment; }
    public double getMeasureFormChanges() { return this.measureFormChanges; }
    public String getMeasureFormRemarks() { return this.measureFormRemarks; }
    public String getCustomerId() { return this.customerId; }
    public String getCustomerName() { return this.customerName; }
    public String getTaxInvoiceNo() { return this.taxInvoiceNo; }
    public Timestamp getTaxInvoiceDate() { return this.taxInvoiceDate; }
    
    public void setId(String val) { this.id = val; }
    public void setMeasureFormDate(Timestamp val) { this.measureFormDate = val; } 
    public void setMeasureFormEventDate(Timestamp val) { this.measureFormEventDate = val; } 
    public void setMeasureFormFirstFittingDate(Timestamp val) { this.measureFormFirstFittingDate = val; } 
    public void setMeasureFormFirstFittingDateChecked(boolean val) { this.measureFormFirstFittingDateChecked = val; } 
    public void setMeasureFormSecondFittingDate(Timestamp val) { this.measureFormSecondFittingDate = val; } 
    public void setMeasureFormSecondFittingDateChecked(boolean val) { this.measureFormSecondFittingDateChecked = val; } 
    public void setMeasureFormPickUpDate(Timestamp val) { this.measureFormPickUpDate = val; } 
    public void setMeasureFormPickUpDateChecked(boolean val) { this.measureFormPickUpDateChecked = val; } 
    public void setMeasureFormStatus(String val) { this.measureFormStatus = val; } 
    public void setMeasureFormAmount(double val) { this.measureFormAmount = val; } 
    public void setMeasureFormPayment(double val) { this.measureFormPayment = val; } 
    public void setMeasureFormChanges(double val) { this.measureFormChanges = val; } 
    public void setMeasureFormRemarks(String val) { this.measureFormRemarks = val; } 
    public void setCustomerId(String val) { this.customerId = val; } 
    public void setCustomerName(String val) { this.customerName = val; } 
    public void setTaxInvoiceNo(String val) { this.taxInvoiceNo = val; } 
    public void setTaxInvoiceDate(Timestamp val) { this.taxInvoiceDate = val; } 
}
