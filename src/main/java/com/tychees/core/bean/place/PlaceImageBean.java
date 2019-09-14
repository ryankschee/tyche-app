package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonImageBean;

@Entity  
@Table(name="place_image_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class PlaceImageBean 
	extends CommonImageBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;

    @Column(name="place_id")
    String placeId = "";
    @Column(name="type_logo")
    boolean typeLogo = false;
    
    public PlaceImageBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceImageBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getPlaceId() { return this.placeId; }
    public boolean isTypeLogo() { return this.typeLogo; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setTypeLogo(boolean val) { this.typeLogo = val; }
    
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
