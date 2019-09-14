package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="place_document_template_component_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceDocumentTemplateComponentBean
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Column(name="place_document_template_id")
    String placeDocumentTemplateId = "";
    @Column(name="name")
    String name = "";
    @Column(name="object_type")
    String objectType = "";
    @Column(name="seqno")
    int seqno = 0;
    @Column(name="attributes")
    String attributes = "";			// Value Format: JSON, e.g. {"x1":"30","y1":"30"}
    
    public PlaceDocumentTemplateComponentBean() {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceDocumentTemplateComponentBean(String id) {
        super();
        this.setId(id);
    }

    public String getPlaceDocumentTempplateId() { return this.placeDocumentTemplateId; }
    public String getName() { return this.name; }
    public String getObjectType() { return this.objectType; }
    public int getSeqno() { return this.seqno; }
    public String getAttributes() { return this.attributes; } 

    public void setPlaceDocumentTemplateId(String val) { this.placeDocumentTemplateId = getSafeString(val); }
    public void setName(String val) { this.name = getSafeString(val); }
    public void setObjectType(String val) { this.objectType = val; }
    public void setSeqno(int val) { this.seqno = val; }
    public void setAttributes(String val) { this.attributes = val; }
    
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