package com.tychees.core.bean.user;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;

import com.tychees.core.bean.BeanSuperClass;
import com.tychees.core.util.BeanUtil;

@Entity  
@Table(name="user_role_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class UserRoleBean 
    extends BeanSuperClass 
    implements java.io.Serializable
{
	
	

	private static final long serialVersionUID = -2492795358937757063L;
    
    @Column(name="user_id")
    String userId = "";
    @Column(name="place_id")
    String placeId = "";
    @Column(name="role_name")
    String roleName = "";
    
    public UserRoleBean() 
    {
        this(UUID.randomUUID().toString());
    }

    public UserRoleBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getUserId() { return this.userId; }
    public String getPlaceId() { return this.placeId; }
    public String getRoleName() { return this.roleName; }
    
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setRoleName(String val) { this.roleName = getSafeString(val); }
    
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
