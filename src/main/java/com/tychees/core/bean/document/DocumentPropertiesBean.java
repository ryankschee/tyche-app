package com.tychees.core.bean.document;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="document_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class DocumentPropertiesBean
    extends CommonPropertiesBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="document_id")
    String documentId = "";
    @Column(name="editable")
    boolean editable = false;
    @Column(name="require_input_from_user")
    boolean requireInputFromUser;
    
    public DocumentPropertiesBean() {
        this(UUID.randomUUID().toString());
    }
    
    public DocumentPropertiesBean(String id) {
        super();
        this.setId(id);
    }

    public String getDocumentId() { return this.documentId; }
    public boolean isEditable() { return this.editable; }
    public boolean isRequireInputFromUser() { return this.requireInputFromUser; } 
    
    public void setDocumentId(String val) { this.documentId = getSafeString(val); }
    public void setEditable(boolean val) { this.editable = val; }
    public void setRequiredInputFromUser(boolean val) { this.requireInputFromUser = val; }
    
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