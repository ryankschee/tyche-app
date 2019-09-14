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
@Table(name="user_access_right_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class UserAccessRightBean 
    extends BeanSuperClass 
    implements java.io.Serializable
{
	
	

	private static final long serialVersionUID = -2492795358937757063L;
    
    @Column(name="place_id")
    String placeId = "";
    @Column(name="user_id")
    String userId = "";
    @Column(name="function_id")
    String functionId = "";
    @Column(name="readable")
    boolean readable = false;
    @Column(name="writable")
    boolean writable = false;
    
    public UserAccessRightBean() 
    {
        this(UUID.randomUUID().toString());
    }

    public UserAccessRightBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getPlaceId() { return this.placeId; }
    public String getUserId() { return this.userId; }
    public String getFunctionId() { return this.functionId; }
    public boolean isReadable() { return this.readable; }
    public boolean isWritable() { return this.writable; }
    
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setFunctionId(String val) { this.functionId = getSafeString(val); }
    public void setReadable(boolean val) { this.readable = val; }
    public void setWritable(boolean val) { this.writable = val; }
    
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
