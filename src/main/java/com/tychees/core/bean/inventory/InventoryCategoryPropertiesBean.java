package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="inventory_category_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryCategoryPropertiesBean 
	extends CommonPropertiesBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
 	
    @Column(name="category_id")
    String categoryId = "";
    @Column(name="seqno")
    int seqno = 0;
    @Column(name="inherited_category_id")
    String inheritedCategoryId = "";
    @Column(name="inherited")
    boolean inherited = false;
    @Column(name="required")
    boolean required = false;
    @Column(name="visible")
    boolean visible = false;
    
    public InventoryCategoryPropertiesBean() 
    {        
    	this(UUID.randomUUID().toString());
    }
    
    public InventoryCategoryPropertiesBean(String id) 
    {        
        super();
    	this.setId(id);
    }

    public String getCategoryId() { return this.categoryId; }
    public int getSeqno() { return this.seqno; }
    public String getInheritedCategoryId() { return this.inheritedCategoryId; }
    public boolean isInherited() { return this.inherited; }
    public boolean isRequired() { return this.required; }
    public boolean isVisible() { return this.visible; }
    
    public void setCategoryId(String val) { this.categoryId = getSafeString(val); }
    public void setSeqno(int val) { this.seqno = val; }
    public void setInheritedCategoryId(String val) { this.inheritedCategoryId = getSafeString(val); }
    public void setInherited(boolean val) { this.inherited = val; }
    public void setRequired(boolean val) { this.required = val; }
    public void setVisible(boolean val) { this.visible = val; }
    
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
