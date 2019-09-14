package com.tychees.core.bean.index;

import java.sql.Timestamp;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="index_master_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class IndexMasterBean
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Column(name="place_id")
    String placeId = "";
    @Column(name="bean_id")
    String beanId = "";
    @Column(name="last_indexed_on")
    Timestamp lastIndexedOn;
    
    public String getPlaceId() { return this.placeId; }
    public String getBeanId() { return this.beanId; }
    public Timestamp getLastIndexedOn() { return this.lastIndexedOn; }

    public void setPlaceId(String val) { this.placeId = val; }
    public void setBeanId(String val) { this.beanId = val; }
    public void setLastIndexedOn(Timestamp val) { this.lastIndexedOn = val; }

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