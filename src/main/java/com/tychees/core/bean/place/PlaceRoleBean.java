package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="place_role_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceRoleBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 2293505623929617851L;

    @Column(name="place_id")
    String placeId = "";
    @Column(name="user_id")
    String userId = "";
    @Column(name="role")
    String role = "";
    @Column(name="designation")
    String designation = "";
    
    public PlaceRoleBean() 
    {
        this(UUID.randomUUID().toString());
    }

	public PlaceRoleBean(String id)
	{
	    super();
		this.setId(id);
	}

    public String getPlaceId() { return this.placeId; }
    public String getUserId() { return this.userId; }
    public String getRole() { return this.role; } 
    public String getDesignation() { return this.designation; }

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setRole(String val) { this.role = getSafeString(val); } 
    public void setDesignation(String val) { this.designation = getSafeString(val); }
    
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
