package com.tychees.core.bean.place;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="place_document_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceDocumentPropertiesBean
    extends CommonPropertiesBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Column(name="place_document_id")
    String placeDocumentId = "";
    @Column(name="document_id")
    String documentId = "";
    @Column(name="editable")
    boolean editable = false;
    @Column(name="require_input_from_script")
    boolean requireInputFromScript;
    @Column(name="require_input_from_user")
    boolean requireInputFromUser;
    @Column(name="user_input")
    String userInput;
    
    public PlaceDocumentPropertiesBean() {
        this(UUID.randomUUID().toString());
    }
    
    public PlaceDocumentPropertiesBean(String id) {
        super();
        this.setId(id);
    }

    public String getPlaceDocumentId() { return this.placeDocumentId; }
    public String getDocumentId() { return this.documentId; }
    public boolean isEditable() { return this.editable; }
    public boolean isRequireInputFromScript() { return this.requireInputFromScript; } 
    public boolean isRequireInputFromUser() { return this.requireInputFromUser; } 
    public String getUserInput() { return this.userInput; }

    public void setPlaceDocumentId(String val) { this.placeDocumentId = getSafeString(val); }
    public void setDocumentId(String val) { this.documentId = getSafeString(val); }
    public void setEditable(boolean val) { this.editable = val; }
    public void setRequiredInputFromScript(boolean val) { this.requireInputFromScript = val; }
    public void setRequiredInputFromUser(boolean val) { this.requireInputFromUser = val; }
    public void setUserInput(String val) { this.userInput = getSafeString(val); }
    
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