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
@Table(name="place_layout_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceLayoutBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 2293505623929617851L;

    @Transient
    public List<PlaceLayoutComponentBean> componentList;
    
    @Column(name="place_id")
    String placeId = "";
    @Column(name="layout_name")
    String layoutName = "";
    @Column(name="default_layout")
    boolean defaultLayout;
    @Column(name="width")
    int width = 0;
    @Column(name="height")
    int height = 0;
    
    public PlaceLayoutBean() 
    {
        this(UUID.randomUUID().toString());
    }

	public PlaceLayoutBean(String id)
	{
	    super();
		this.setId(id);
        
    	this.componentList = new ArrayList<PlaceLayoutComponentBean>();
	}

    public String getPlaceId() { return this.placeId; }
    public String getLayoutName() { return this.layoutName; }     
    public boolean isDefaultLayout() { return this.defaultLayout; }
    public int getWidth() { return this.width; }
    public int getHeight() { return this.height; }

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setLayoutName(String val) { this.layoutName = getSafeString(val); } 
    public void setDefaultLayout(boolean val) { this.defaultLayout = val; }
    public void setWidth(int val) { this.width = val; }
    public void setHeight(int val) { this.height = val; }

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
