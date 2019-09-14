package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonContactBean;

@Entity  
@Table(name="place_contact_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceContactBean
    extends CommonContactBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
 
    @Column(name="place_id")
    String placeId = "";
    
    public PlaceContactBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceContactBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getPlaceId() { return this.placeId; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    
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