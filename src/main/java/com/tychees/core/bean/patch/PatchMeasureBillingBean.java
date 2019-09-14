package com.tychees.core.bean.patch;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity  
@Table(name="patch_measure_billing_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PatchMeasureBillingBean 
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    public PatchMeasureBillingBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PatchMeasureBillingBean(String id) 
    {
    	super();  
        this.setId(id);
    }

	@Id  
    @Column(name="id")
    String id = "";
	@Column(name="unit_price")  
	double unitPrice = 0.0d;   
	@Column(name="sales_price")  
	double salesPrice = 0.0d; 
	@Column(name="quantity")  
	int quantity = 0;   
	@Column(name="amount")
	double amount = 0.0d;
	@Column(name="apparel_id")
	String apparelId;
	@Column(name="apparel_name")
	String apparelName;
	@Column(name="form_id")
	String formId;
	@Column(name="apparel_material")
	String apparelMaterial;
	@Column(name="apparel_length")
	String apparelLength;
	@Column(name="remarks")
	String remarks;
	@Column(name="apparel_description")
	String apparelDescription;

	public String getId() { return this.id; }
    public double getUnitPrice() { return this.unitPrice; }
    public double getSalesPrice() { return this.salesPrice; }
    public int getQuantity() { return this.quantity; }
    public double getAmount() { return this.amount; }
    public String getApparelId() { return this.apparelId; }
    public String getApparelName() { return this.apparelName; }
    public String getFormId() { return this.formId; }
    public String getApparelMaterial() { return this.apparelMaterial; }
    public String getApparelLength() { return this.apparelLength; }
    public String getRemarks() { return this.remarks; }
    public String getApparelDescription() { return this.apparelDescription; }
    
    public void setId(String val) { this.id = val; }
    public void setUnitPrice(double val) { this.unitPrice = val; } 
    public void setSalesPrice(double val) { this.salesPrice = val; } 
    public void setQuantity(int val) { this.quantity = val; } 
    public void setAmount(double val) { this.amount = val; } 
    public void setApparelId(String val) { this.apparelId = val; } 
    public void setApparelName(String val) { this.apparelName = val; } 
    public void setFormId(String val) { this.formId = val; } 
    public void setApparelMaterial(String val) { this.apparelMaterial = val; } 
    public void setApparelLength(String val) { this.apparelLength = val; }
    public void setRemarks(String val) { this.remarks = val; }
    public void setApparelDescription(String val) { this.apparelDescription = val; }
}
