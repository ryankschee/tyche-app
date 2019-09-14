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
@Table(name="patch_payment_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PatchPaymentBean 
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    public PatchPaymentBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PatchPaymentBean(String id) 
    {
    	super();  
        this.setId(id);
    }

	@Id  
    @Column(name="id")
    String id = "";
	@Column(name="amount")  
	double amount = 0.0d;   
	@Column(name="type")  
	String type = "";   
	@Column(name="date_time")
	Timestamp dateTime;
	@Column(name="terms")
	String terms;
	@Column(name="notes")
	String notes;
	@Column(name="form_id")
	String formId;
	@Column(name="customer_id")
	String customerId;

	public String getId() { return this.id; }
    public double getAmount() { return this.amount; }
    public String getType() { return this.type; }
    public Timestamp getDateTime() { return this.dateTime; }
    public String getTerms() { return this.terms; }
    public String getNotes() { return this.notes; }
    public String getFormId() { return this.formId; }
    public String getCustomerId() { return this.customerId; }
    
    public void setId(String val) { this.id = val; }
    public void setAmount(double val) { this.amount = val; } 
    public void setType(String val) { this.type = val; } 
    public void setDateTime(Timestamp val) { this.dateTime = val; } 
    public void setTerms(String val) { this.terms = val; } 
    public void setNotes(String val) { this.notes = val; } 
    public void setFormId(String val) { this.formId = val; } 
    public void setCustomerId(String val) { this.customerId = val; }
}
