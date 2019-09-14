package com.tychees.core.bean.place;

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
@Table(name="place_access_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceAccessBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 2293505623929617851L;

    @Transient
    public List<PlaceAccessPropertiesBean> propertiesList;
    
    @Column(name="place_id")
    String placeId = "";
    @Column(name="role_name")
    String roleName = "";
    
    public PlaceAccessBean() 
    {
        this(UUID.randomUUID().toString());
    }

	public PlaceAccessBean(String id)
	{
	    super();
		this.setId(id);
        
    	this.propertiesList = new ArrayList<PlaceAccessPropertiesBean>();
	}

    public String getPlaceId() { return this.placeId; }
    public String getRoleName() { return this.roleName; }         

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setRoleName(String val) { this.roleName = getSafeString(val); } 

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
