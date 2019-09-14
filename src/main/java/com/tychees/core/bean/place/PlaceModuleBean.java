package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="place_module_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceModuleBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 2293505623929617851L;

    @Column(name="place_id")
    String placeId = "";
    @Column(name="module_id")
    String moduleId = "";
    @Column(name="module_layout_id")
    String moduleLayoutId = "";
    @Column(name="module_layout_path")
    String moduleLayoutPath = "";
    
    public PlaceModuleBean() 
    {
        this(UUID.randomUUID().toString());
    }

	public PlaceModuleBean(String id)
	{
	    super();
		this.setId(id);
	}

    public String getPlaceId() { return this.placeId; }
    public String getModuleId() { return this.moduleId; } 
    public String getModuleLayoutId() { return this.moduleLayoutId; }   
    public String getModuleLayoutPath() { return this.moduleLayoutPath; }           

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setModuleId(String val) { this.moduleId = getSafeString(val); } 
    public void setModuleLayoutId(String val) { this.moduleLayoutId = getSafeString(val); } 
    public void setModuleLayoutPath(String val) { this.moduleLayoutPath = getSafeString(val); } 

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
