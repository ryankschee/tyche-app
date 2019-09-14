package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonPropertiesBean;

@Entity  
@Table(name="inventory_item_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryItemPropertiesBean 
	extends CommonPropertiesBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;

    @Column(name="item_id")
    String itemId = "";
    @Column(name="category_properties_id")
    String categoryPropertiesId = "";
    @Column(name="seqno")
    int seqno = 0;
    @Column(name="required")
    boolean required = false;
    @Column(name="visible")
    boolean visible = false;
    
    public InventoryItemPropertiesBean() 
    {        
    	this(UUID.randomUUID().toString());
    }
    
    public InventoryItemPropertiesBean(String id) 
    {        
        super();
    	this.setId(id);
    }

    public String getItemId() { return this.itemId; }
    public String getCategoryPropertiesId() { return this.categoryPropertiesId; }
    public int getSeqno() { return this.seqno; }
    public boolean isRequired() { return this.required; }
    public boolean isVisible() { return this.visible; }
    
    public void setItemId(String val) { this.itemId = getSafeString(val); }
    public void setCategoryPropertiesId(String val) { this.categoryPropertiesId = getSafeString(val); }
    public void setSeqno(int val) { this.seqno = val; }
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
