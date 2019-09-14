package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="place_layout_component_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceLayoutComponentBean
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Column(name="layout_id")
    String layoutId = "";
    @Column(name="bucket_id")
    String bucketId = "";
    @Column(name="name")
    String name = "";
    @Column(name="pax_count")
    int paxCount = 0;
    @Column(name="object_type")
    String objectType = "";
    @Column(name="fill_style")
    String fillStyle = "";
    @Column(name="stroke_style")
    String strokeStyle = "";
    @Column(name="shadow_color")
    String shadowColor = "";
    @Column(name="shadow_blur")
    String shadowBlur = "";
    @Column(name="shadow_offset_x")
    String shadowOffsetX = "";
    @Column(name="shadow_offset_y")
    String shadowOffsetY = "";
    @Column(name="attributes")
    String attributes = "";			// Value Format: JSON, e.g. {"x1":"30","y1":"30"}
    
    public PlaceLayoutComponentBean() {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceLayoutComponentBean(String id) {
        super();
        this.setId(id);
    }

    public String getLayoutId() { return this.layoutId; }
    public String getBucketId() { return this.bucketId; }
    public String getName() { return this.name; }
    public int getPaxCount() { return this.paxCount; }
    public String getObjectType() { return this.objectType; }
    public String getFillStyle() { return this.fillStyle; }
    public String getStrokeStyle() { return this.strokeStyle; }
    public String getShadowColor() { return this.shadowColor; }
    public String getShadowBlur() { return this.shadowBlur; }
    public String getShadowOffsetX() { return this.shadowOffsetX; }
    public String getShadowOffsetY() { return this.shadowOffsetY; }
    public String getAttributes() { return this.attributes; }

    public void setLayoutId(String val) { this.layoutId = getSafeString(val); }
    public void setBucketId(String val) { this.bucketId = getSafeString(val); }
    public void setName(String val) { this.name = getSafeString(val); }
    public void setPaxCount(int val) { this.paxCount = val; }
    public void setObjectType(String val) { this.objectType = getSafeString(val); }
    public void setFillStyle(String val) { this.fillStyle = getSafeString(val); }
    public void setStrokeStyle(String val) { this.strokeStyle = getSafeString(val); }
    public void setShadowColor(String val) { this.shadowColor = getSafeString(val); }
    public void setShadowBlur(String val) { this.shadowBlur = getSafeString(val); }
    public void setShadowOffsetX(String val) { this.shadowOffsetX = getSafeString(val); }
    public void setShadowOffsetY(String val) { this.shadowOffsetY = getSafeString(val); }
    public void setAttributes(String val) { this.attributes = getSafeString(val); }
    
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