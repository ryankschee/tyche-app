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
@Table(name="user_action_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class UserActionBean 
    extends BeanSuperClass 
    implements java.io.Serializable
{
	
	

	private static final long serialVersionUID = -2492795358937757063L;
    
    @Column(name="user_id")
    String userId = "";
    @Column(name="action_bean_id")
    String actionBeanId = "";
    @Column(name="action_bean_name")
    String actionBeanName = "";
    @Column(name="action_type")
    String actionType = "";
    
    public UserActionBean() 
    {
        this(UUID.randomUUID().toString());
    }

    public UserActionBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getUserId() { return this.userId; }
    public String getActionBeanId() { return this.actionBeanId; }
    public String getActionBeanName() { return this.actionBeanName; }
    public String getActionType() { return this.actionType; }
    
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setActionBeanId(String val) { this.actionBeanId = getSafeString(val); }
    public void setActionBeanName(String val) { this.actionBeanName = getSafeString(val); }
    public void setActionType(String val) { this.actionType = getSafeString(val); }
    
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
