package com.tychees.core.bean.common;

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
@Table(name="common_template_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CommonTemplateBean
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = 1467880004586236216L;
    
    @Transient
    public List<CommonTemplatePropertiesBean> propertiesList;

    public CommonTemplateBean()
    {
        this(UUID.randomUUID().toString());
    }
    
    public CommonTemplateBean(String id)
    {
        super();
        this.setId(id);
        
        this.propertiesList = new ArrayList<CommonTemplatePropertiesBean>();
    }

    @Column(name="parent_id")
    String parentId = "";
    @Column(name="module_id")
    String moduleId = "";
    @Column(name="template_type")
    String templateType = "";
    @Column(name="template_name")
    String templateName = "";
    @Column(name="default_template")
    boolean defaultTemplate = false;

    public String getParentId() { return this.parentId; }
    public String getModuleId() { return this.moduleId; }
    public String getTemplateType() { return this.templateType; }
    public String getTemplateName() { return this.templateName; }
    public boolean isDefaultTemplate() { return this.defaultTemplate; }
    
    public void setParentId(String val) { this.parentId = getSafeString(val); }
    public void setModuleId(String val) { this.moduleId = getSafeString(val); }
    public void setTemplateType(String val) { this.templateType = getSafeString(val); } 
    public void setTemplateName(String val) { this.templateName = getSafeString(val); } 
    public void setDefaultTemplate(boolean val) { this.defaultTemplate = val; }
    
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