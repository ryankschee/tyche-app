package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="place_settings_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceSettingsBean
	extends CommonPropertiesBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;
	
	@Column(name="place_id")
	String placeId = "";
	@Column(name="module_id")
	String moduleId = "";
	@Column(name="sub_module_id")
	String subModuleId = "";

    public PlaceSettingsBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
	public PlaceSettingsBean(String id)
	{
	    super();
		this.setId(id);
	}

	public String getPlaceId() { return this.placeId; }
	public String getModuleId() { return this.moduleId; }
	public String getSubModuleId() { return this.subModuleId; }

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }    
    public void setModuleId(String val) { this.moduleId = getSafeString(val); }   
    public void setSubModuleId(String val) { this.subModuleId = getSafeString(val); }   
	
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