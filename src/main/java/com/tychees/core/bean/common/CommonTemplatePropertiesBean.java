package com.tychees.core.bean.common;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="common_template_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CommonTemplatePropertiesBean
    extends CommonPropertiesBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="template_id")
    String templateId = "";
    
    public CommonTemplatePropertiesBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CommonTemplatePropertiesBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getTemplateId() { return this.templateId; }
    
    public void setTemplateId(String val) { this.templateId = getSafeString(val); }
    
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