package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonLabelBean;

@Entity  
@Table(name="place_label_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class PlaceLabelBean 
	extends CommonLabelBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    @Column(name="place_id")
    String placeId = "";

    public PlaceLabelBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceLabelBean(String id) 
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
