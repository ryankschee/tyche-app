package com.tychees.core.bean.user;

import java.sql.Timestamp;
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
@Table(name="user_session_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class UserSessionBean 
    extends BeanSuperClass
    implements java.io.Serializable
{
	
	

	private static final long serialVersionUID = -2492795358937757063L;

    @Column(name="user_id")
    String userId = "";
    @Column(name="email")
    String email = "";
    @Column(name="remember")
    boolean remember = false;
    @Column(name="active")
    boolean active = false;
    @Column(name="status")
    String status = "";
    @Column(name="remote_address")
    String remoteAddress = "";
    @Column(name="user_agent")
    String userAgent = "";
    @Column(name="sso_provider")
    String ssoProvider = "";
    @Column(name="started_on")
    Timestamp startedOn;
    @Column(name="last_accessed_on")
    Timestamp lastAccessedOn;
    @Column(name="ended_on")
    Timestamp endedOn;
    @Column(name="validity_period")
    long validityPeriod;
    @Column(name="readable_started_on")
    String readableStartedOn;
    @Column(name="readable_last_accessed_on")
    String readableLastAccessedOn;
    
    public UserSessionBean() 
    {
        this(UUID.randomUUID().toString());
    }

    public UserSessionBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getUserId() { return this.userId; }
    public String getEmail() { return this.email; }
    public boolean isRemember() { return this.remember; }
    public boolean isActive() { return this.active; }
    public String getStatus() { return this.status; }
    public String getRemoteAddress() { return this.remoteAddress; }
    public String getUserAgent() { return this.userAgent; }
    public Timestamp getStartedOn() { return this.startedOn; }
    public Timestamp getLastAccessedOn() { return this.lastAccessedOn; }
    public Timestamp getEndedOn() { return this.endedOn; }
    public String getSsoProvider() { return this.ssoProvider; }
    public long getValidityPeriod() { return this.validityPeriod; }
    public String getReadableStartedOn() { return this.readableStartedOn; }
    public String getReadableLastAccessedOn() { return this.readableLastAccessedOn; }
    
    public void setUserId(String val) { this.userId = getSafeString(val); }
    public void setEmail(String val) { this.email = getSafeString(val); }
    public void setRemember(boolean val) { this.remember = val; }
    public void setActive(boolean val) { this.active = val; }
    public void setStatus(String val) { this.status = getSafeString(val); }
    public void setRemoteAddress(String val) { this.remoteAddress = getSafeString(val); }
    public void setUserAgent(String val) { this.userAgent = getSafeString(val); }
    public void setStartedOn(Timestamp val) { this.startedOn = val; }
    public void setLastAccessedOn(Timestamp val) { this.lastAccessedOn = val; }
    public void setEndedOn(Timestamp val) { this.endedOn = val; }
    public void setSsoProvider(String val) { this.ssoProvider = val; }
    public void setValidityPeriod(long val) { this.validityPeriod = val; }
    public void setReadableStartedOn(String val) { this.readableStartedOn = val; }
    public void setReadableLastAccessedOn(String val) { this.readableLastAccessedOn = val; }
    
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
