package com.tychees.core.bean.customer;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonEmailBean;  
  
@Entity  
@Table(name="customer_email_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CustomerEmailBean 
	extends CommonEmailBean
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 8539335464954385814L;

    public CustomerEmailBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerEmailBean(String id) 
    {
    	super();
        this.setId(id);
    }

	@Column(name="customer_id")  
	String customerId = "";   
	
	public String getCustomerId() { return this.customerId; }
	
    public void setCustomerId(String val) { this.customerId = getSafeString(val); }
    
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
