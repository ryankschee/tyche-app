package com.tychees.core.bean.inventory;

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
@Table(name="inventory_category_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class InventoryCategoryBean 
	extends BeanSuperClass
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;

    @Transient
    public List<InventoryCategoryPropertiesBean> propertiesList;
    @Transient
    public List<String> itemGroupList;
    @Transient 
    public Long itemSize;

    public InventoryCategoryBean() 
    {        
    	this(UUID.randomUUID().toString());
    }
    
    public InventoryCategoryBean(String id) 
    {        
        super();
    	this.setId(id);
    	
    	this.propertiesList = new ArrayList<InventoryCategoryPropertiesBean>();
    	this.itemGroupList = new ArrayList<String>();
    }

	@Column(name="place_id") 
    String placeId = "";
	@Column(name="business_type_id") 
	String businessTypeId = "";
	@Column(name="parent_category_id") 
    String parentCategoryId = "";
	@Column(name="parent_category_name") 
    String parentCategoryName = "";
	@Column(name="item_type") 
    String itemType = "";
	@Column(name="name") 
    String name = "";
	@Column(name="seqno") 
    int seqno = 0;
	@Column(name="system_defined") 
    boolean systemDefined = false;
	@Column(name="pos_visible") 
    boolean posVisible = false;
	@Column(name="scm_visible") 
    boolean scmVisible = false;

    public String getPlaceId() { return this.placeId; }
    public String getBusinessTypeId() { return this.businessTypeId; }
    public String getParentCategoryId() { return this.parentCategoryId; }
    public String getParentCategoryName() { return this.parentCategoryName; }
    public String getItemType() { return this.itemType; }
    public String getName() { return this.name; }
    public int getSeqno() { return this.seqno; }
    public boolean isSystemDefined() { return this.systemDefined; }
    public boolean isPosVisible() { return this.posVisible; }
    public boolean isScmVisible() { return this.scmVisible; }

    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setBusinessTypeId(String val) { this.businessTypeId = getSafeString(val); }
    public void setParentCategoryId(String val) { this.parentCategoryId = getSafeString(val); }
    public void setParentCategoryName(String val) { this.parentCategoryName = getSafeString(val); }
    public void setItemType(String val) { this.itemType = getSafeString(val); }
    public void setName(String val) { this.name = getSafeString(val); }
    public void setSeqno(int val) { this.seqno = val; }
    public void setSystemDefined(boolean val) { this.systemDefined = val; }
    public void setPosVisible(boolean val) { this.posVisible = val; }
    public void setScmVisible(boolean val) { this.scmVisible = val; }
        
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getName();
	}
}
