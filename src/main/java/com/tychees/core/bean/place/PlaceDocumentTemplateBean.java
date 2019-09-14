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
@Table(name="place_document_template_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class PlaceDocumentTemplateBean 
	extends BeanSuperClass
	implements java.io.Serializable 
{
	private static final long serialVersionUID = 624358538249148435L;

    @Transient
    public List<PlaceDocumentTemplateComponentBean> componentList;
    
	@Column(name="place_id")
	String placeId = "";
	@Column(name="name")
	String name = "";
	@Column(name="template_type")
	String templateType = "";
	@Column(name="page_type")
	String pageType = "";
	@Column(name="width")
	int width = 0;
	@Column(name="height")
	int height = 0;
	@Column(name="available")
	boolean available = false;
	
	public PlaceDocumentTemplateBean()
	{
		this(UUID.randomUUID().toString());
	}
	
	public PlaceDocumentTemplateBean(String id)
	{
	    super();
		this.setId(id);
		
		componentList = new ArrayList<PlaceDocumentTemplateComponentBean>();
	}

    public String getPlaceId() { return this.placeId; }
    public String getName() { return this.name; }
    public String getTemplateType() { return this.templateType; }
    public String getPageType() { return this.pageType; }
    public int getWidth() { return this.width; }
    public int getHeight() { return this.height; }
    public boolean isAvailable() { return this.available; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); } 
    public void setName(String val) { this.name = getSafeString(val); } 
    public void setTemplateType(String val) { this.templateType = getSafeString(val); } 
    public void setPageType(String val) { this.pageType = getSafeString(val); } 
    public void setWidth(int val) { this.width = val; }
    public void setHeight(int val) { this.height = val; }
    public void setAvailable(boolean val) { this.available = val; }

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
