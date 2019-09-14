package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonImageBean;

@Entity  
@Table(name="inventory_item_image_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class InventoryItemImageBean 
	extends CommonImageBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;

    @Column(name="item_id")
    String itemId = "";
    @Column(name="pws_visible")
    boolean pwsVisible;
    
    public InventoryItemImageBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemImageBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getItemId() { return this.itemId; }
    public boolean isPwsVisible() { return this.pwsVisible; }
    
    public void setItemId(String val) { this.itemId = getSafeString(val); }
    public void setPwsVisible(boolean val) { this.pwsVisible = val; }
    
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
