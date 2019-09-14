package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonRuleBean;

@Entity  
@Table(name="inventory_item_rule_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class InventoryItemRuleBean 
	extends CommonRuleBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    @Column(name="item_id")
    String itemId = "";

    public InventoryItemRuleBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemRuleBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getItemId() { return this.itemId; }
    
    public void setItemId(String val) { this.itemId = getSafeString(val); } 
    
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
