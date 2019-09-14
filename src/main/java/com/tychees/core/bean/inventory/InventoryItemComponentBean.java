package com.tychees.core.bean.inventory;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="inventory_item_component_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryItemComponentBean 
	extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
 
    @Column(name="item_id")
    String itemId = "";
    @Column(name="seqno")
    int seqno = 0;
    @Column(name="category_id")
    String categoryId = "";
    @Column(name="item_group_list")
    String itemGroupList = "";
    @Column(name="title")
    String title = "";
    @Column(name="help_text")
    String helpText = "";
    @Column(name="group_name")
    String groupName = "";
    @Column(name="seqno_in_group")
    int seqnoInGroup = 0;
    @Column(name="selection_mode")
    String selectionMode = "";
    @Column(name="selectable")
    boolean selectable = false;
    @Column(name="minimum_selection")
    int minimumSelection = 0;
    @Column(name="maximum_selection")
    int maximumSelection = 0;
    @Column(name="allow_default_quantity_only")
    boolean allowDefaultQuantityOnly = false;
    @Column(name="default_quantity")
    double defaultQuantity = 1;
    @Column(name="tags")
    String tags = "";    // Item label 
    @Column(name="item_ids")
    String itemIds = ""; // e.g. "id1, id2, id3"
    @Column(name="exclude_item_ids")
    String excludeItemIds = "";
    @Column(name="default_item_ids")
    String defaultItemIds = "";
    
    public InventoryItemComponentBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public InventoryItemComponentBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getItemId() { return this.itemId; }
    public int getSeqno() { return this.seqno; }
    public String getCategoryId() { return this.categoryId; }
    public String getItemGroupList() { return this.itemGroupList; }
    public String getTitle() { return this.title; }
    public String getHelpText() { return this.helpText; }
    public String getGroupName() { return this.groupName; }
    public int getSeqnoInGroup() { return this.seqnoInGroup; }
    public String getSelectionMode() { return this.selectionMode; }
    public boolean isSelectable() { return this.selectable; }
    public int getMinimumSelection() { return this.minimumSelection; }
    public int getMaximumSelection() { return this.maximumSelection; }
    public boolean isAllowDefaultQuantityOnly() { return this.allowDefaultQuantityOnly; }
    public double getDefaultQuantity() { return this.defaultQuantity; }
    public String getTags() { return this.tags; }
    public String getItemIds() { return this.itemIds; }
    public String getExcludeItemIds() { return this.excludeItemIds; }
    public String getDefaultItemIds() { return this.defaultItemIds; }
    
    public void setItemId(String val) { this.itemId = getSafeString(val); }
    public void setSeqno(int val) { this.seqno = val; }
    public void setCategoryId(String val) { this.categoryId = getSafeString(val); }
    public void setItemGroupList(String val) { this.itemGroupList = getSafeString(val); }
    public void setTitle(String val) { this.title = getSafeString(val); }
    public void setHelpText(String val) { this.helpText = getSafeString(val); }
    public void setGroupName(String val) { this.groupName = getSafeString(val); }
    public void setSeqnoInGroup(int val) { this.seqnoInGroup = val; }
    public void setSelectionMode(String val) { this.selectionMode = getSafeString(val); }
    public void setSelectable(boolean val) { this.selectable = val; }
    public void setMinimumSelection(int val) { this.minimumSelection = val; }
    public void setMaximumSelection(int val) { this.maximumSelection = val; }
    public void setAllowDefaultQuantityOnly(boolean val) { this.allowDefaultQuantityOnly = val; }
    public void setDefaultQuantity(double val) { this.defaultQuantity = val; }
    public void setTags(String val) { this.tags = getSafeString(val); }
    public void setItemIds(String val) { this.itemIds = getSafeString(val); }
    public void setExcludeItemIds(String val) { this.excludeItemIds = getSafeString(val); }
    public void setDefaultItemIds(String val) { this.defaultItemIds = getSafeString(val); }
        
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
