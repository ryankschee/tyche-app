package com.tychees.core.bean.user;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.tychees.core.bean.BeanSuperClass;
import com.tychees.core.util.BeanUtil;

@Entity  
@Table(name="user_security_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class UserSecurityBean 
    extends BeanSuperClass
    implements java.io.Serializable
{
	private static final long serialVersionUID = -2492795358937757063L;
    
    public UserSecurityBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public UserSecurityBean(String id) 
    {
        super();
        this.setId(id);
    }

    @JsonIgnore
    @Column(name="password")
    String password = "";
    @Column(name="c_salt")
    String cSalt = "";
    @Column(name="s_salt")
    String sSalt = "";
    
    public String getPassword() { return this.password; }
    public String getCSalt() { return this.cSalt; }
    public String getSSalt() { return this.sSalt; }
    
    public void setPassword(String val) { this.password = getSafeString(val); }
    public void setCSalt(String val) { this.cSalt = getSafeString(val); }
    public void setSSalt(String val) { this.sSalt = getSafeString(val); }
    
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