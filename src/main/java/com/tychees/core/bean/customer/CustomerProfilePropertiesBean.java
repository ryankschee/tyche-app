package com.tychees.core.bean.customer;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="customer_profile_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CustomerProfilePropertiesBean
	extends CommonPropertiesBean
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;

    @Column(name="profile_id")
	String profileId = "";
	
    public CustomerProfilePropertiesBean() 
    {
        this.setId(UUID.randomUUID().toString());
    }
    
	public CustomerProfilePropertiesBean(String id) 
	{
		super();
		this.setId(id);
	}

    public String getProfileId() { return this.profileId; }
    
    public void setProfileId(String val) { this.profileId = getSafeString(val); }
    
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