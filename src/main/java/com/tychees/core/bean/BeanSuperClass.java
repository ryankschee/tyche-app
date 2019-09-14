package com.tychees.core.bean;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import com.tychees.core.util.BeanUtil;

@MappedSuperclass
public abstract class BeanSuperClass 
	extends BeanUtil {
    
    // Class Name. e.g. com.tychees.core.bean.billing.BillingBean
    public abstract String getBeanName();
    // Display Name for Human Reading. e.g. BIL00001
    public abstract String getDisplayName();
        
    //--------------------------------------------------------------------------

    // --- Properties for UI used only, NOT for storing at database. ---
    // True/False indicator, if bean has changed since last save. 
	@Transient
    boolean hasChanged = false;    
    // --- Properties for UI used only, NOT for storing at database. ---
    // True/False 
    @Transient
    boolean fullBeanloaded = false;
     
	@Id  
	@Column(name="id", unique=true)  
	String id = "";  
	@Column(name="remarks")  
	String remarks = "";  
	@Column(name="created_on")
	Timestamp createdOn;
	@Column(name="created_by")  
	String createdBy = ""; 
	@Column(name="updated_on")
	Timestamp updatedOn;
	@Column(name="updated_by")  
	String updatedBy = ""; 
	@Column(name="deleted_on")
	Timestamp deletedOn;
	@Column(name="deleted_by")  
	String deletedBy = ""; 
    
    //--------------------------------------------------------------------------
    // GETTER & SETTER
    
    public String getId() { return this.id; }
    public String getRemarks() { return this.remarks; }
    public Timestamp getCreatedOn() { return this.createdOn; }
    public String getCreatedBy() { return this.createdBy; }
    public Timestamp getUpdatedOn() { return this.updatedOn; }
    public String getUpdatedBy() { return this.updatedBy; }
    public Timestamp getDeletedOn() { return this.deletedOn; }
    public String getDeletedBy() { return this.deletedBy; }
    public boolean isHasChanged() { return this.hasChanged; }
    public boolean isFullBeanLoaded() { return this.fullBeanloaded; }
    
    public void setId(String val) { this.id = val; }
    public void setRemarks(String val) { this.remarks = val; }
    public void setCreatedOn(Timestamp val) { this.createdOn = val; }
    public void setCreatedBy(String val) { this.createdBy = val; }
    public void setUpdatedOn(Timestamp val) { this.updatedOn = val; }
    public void setUpdatedBy(String val) { this.updatedBy = val; }
    public void setDeletedOn(Timestamp val) { this.deletedOn = val; }
    public void setDeletedBy(String val) { this.deletedBy = val; }
    public void setHasChanged(boolean val) { this.hasChanged = val; }
    public void setFullBeanLoaded(boolean val) { this.fullBeanloaded = val; }

    //--------------------------------------------------------------------------
    // Utils
    
    public boolean isDeleted()
    {
    	if (this.getDeletedBy()==null || "".equals(this.getDeletedBy().trim()))
    		return false;    	
    	return true;
    } // .end of isDeleted
}