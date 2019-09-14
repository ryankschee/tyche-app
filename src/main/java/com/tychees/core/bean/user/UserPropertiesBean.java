package com.tychees.core.bean.user;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;

import com.tychees.core.bean.common.CommonPropertiesBean;
import com.tychees.core.util.BeanUtil;

@Entity  
@Table(name="user_properties_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class UserPropertiesBean
    extends CommonPropertiesBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="user_id")
    String userId = "";
    
    public UserPropertiesBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public UserPropertiesBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getUserId() { return this.userId; }
    
    public void setUserId(String val) { this.userId = getSafeString(val); }
    
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