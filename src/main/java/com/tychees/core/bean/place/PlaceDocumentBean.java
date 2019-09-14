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
@Table(name="place_document_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class PlaceDocumentBean 
	extends BeanSuperClass
	implements java.io.Serializable 
{
	private static final long serialVersionUID = 624358538249148435L;

    @Transient
    public List<PlaceDocumentPropertiesBean> propertiesList;
    
	@Column(name="place_id")
	String placeId = "";
	@Column(name="document_id")
	String documentId = "";
	
	public PlaceDocumentBean()
	{
		this(UUID.randomUUID().toString());
	}
	
	public PlaceDocumentBean(String id)
	{
	    super();
		this.setId(id);
		
		propertiesList = new ArrayList<PlaceDocumentPropertiesBean>();
	}

    public String getPlaceId() { return this.placeId; }
    public String getDocumentId() { return this.documentId; }
        
    public void setPlaceId(String val) { this.placeId = getSafeString(val); } 
    public void setDocumentId(String val) { this.documentId = getSafeString(val); } 

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
