package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="place_access_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceAccessPropertiesBean
    extends CommonPropertiesBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="access_id")
    String accessId = "";
    
    public PlaceAccessPropertiesBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceAccessPropertiesBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getAccessId() { return this.accessId; }
    
    public void setAccessId(String val) { this.accessId = getSafeString(val); }
    
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