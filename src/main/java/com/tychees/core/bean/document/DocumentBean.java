package com.tychees.core.bean.document;

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
@Table(name="document_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class DocumentBean
	extends BeanSuperClass
	implements java.io.Serializable
{
	private static final long serialVersionUID = 624358538249148435L;
	
    @Transient
    public List<DocumentPropertiesBean> propertiesList;

    public DocumentBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public DocumentBean(String id)
    {
        super();
        this.setId(id);
        
        this.propertiesList = new ArrayList<DocumentPropertiesBean>();
    }
    
    @Column(name="module_id")
    String moduleId = "";
    @Column(name="doc_name")
    String docName = "";
    @Column(name="doc_code")
    String docCode = ""; // variant code to be used across diff systems. e.g. AA01, etc
    @Column(name="doc_type")
    String docType = "";
    @Column(name="doc_type_name")
    String docTypeName = "";
    @Column(name="doc_url")
    String docUrl = "";
    @Transient
    String docContent = "";

    public String getModuleId() { return this.moduleId; }
    public String getDocName() { return this.docName; }
    public String getDocCode() { return this.docCode; }
    public String getDocType() { return this.docType; }
    public String getDocTypeName() { return this.docTypeName; }
    public String getDocUrl() { return this.docUrl; }
    public String getDocContent() { return this.docContent; }
    
    public void setModuleId(String val) { this.moduleId = getSafeString(val); }
    public void setDocName(String val) { this.docName = getSafeString(val); }
    public void setDocCode(String val) { this.docCode = getSafeString(val); }
    public void setDocType(String val) { this.docType = getSafeString(val); }
    public void setDocTypeName(String val) { this.docTypeName = getSafeString(val); }
    public void setDocUrl(String val) { this.docUrl = getSafeString(val); }
    public void setDocContent(String val) { this.docContent = getSafeString(val); }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getDocName();
	}
}
