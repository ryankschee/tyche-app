package com.tychees.core.bean.customer;

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

@Entity  
@Table(name="customer_profile_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CustomerProfileBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 1467880004586236216L;
    
    @Transient
    public List<CustomerProfilePropertiesBean> propertiesList;
    
    public CustomerProfileBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerProfileBean(String id) 
    {
        super();
        this.setId(id);
        
        this.propertiesList = new ArrayList<CustomerProfilePropertiesBean>();
    }

    @Column(name="customer_id")
    String customerId = "";
    @Column(name="profile_name")
    String profileName = "";
    @Column(name="default_profile")
    boolean defaultProfile = false;

    public String getCustomerId() { return this.customerId; }
    public String getProfileName() { return this.profileName; }
    public boolean isDefaultProfile() { return this.defaultProfile; }
    
    public void setCustomerId(String val) { this.customerId = getSafeString(val); }
    public void setProfileName(String val) { this.profileName = getSafeString(val); } 
    public void setDefaultProfile(boolean val) { this.defaultProfile = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getClass().getName();
	}
}