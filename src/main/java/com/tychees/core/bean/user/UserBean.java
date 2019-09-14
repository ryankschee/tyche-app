package com.tychees.core.bean.user;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.beans.factory.annotation.Autowired;

import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonPersonBean;
import com.tychees.core.util.BeanUtil;

@Entity  
@Table(name="user_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false")
public class UserBean 
    extends CommonPersonBean
    implements java.io.Serializable
{
	private static final long serialVersionUID = -2492795358937757063L;
    
    @Transient
    public List<UserActionBean> actionList;
    @Transient
    public List<UserSessionBean> sessionList;
    @Transient
    public List<UserPropertiesBean> propertiesList;
    @Transient
    public List<UserAccessRightBean> accessRightList;
    @Transient
    public List<CommonCalendarBean> calendarList;
    @Transient
    public List<UserRoleBean> roleList;
    
    public UserBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public UserBean(String id) 
    {
        super();
        this.setId(id);
        
        this.actionList = new ArrayList<UserActionBean>();
        this.sessionList = new ArrayList<UserSessionBean>();
        this.propertiesList = new ArrayList<UserPropertiesBean>();
        this.accessRightList = new ArrayList<UserAccessRightBean>();
        this.calendarList = new ArrayList<CommonCalendarBean>();
        this.roleList = new ArrayList<UserRoleBean>();
    }

    @Column(name="last_login")
    Timestamp lastLogin;
    @Column(name="home_latitude")
    double homeLatitude = 0.0d;
    @Column(name="home_longitude")
    double homeLongitude = 0.0d;
    @Column(name="home_radius")
    double homeRadius = 0.0d;
    @Column(name="reset_password_required")
    boolean resetPasswordRequired = false;
    @Column(name="logout_required")
    boolean logoutRequired = false;
    
    public Timestamp getLastLogin() { return this.lastLogin; }
    public double getHomeLatitude() { return this.homeLatitude ; }
    public double getHomeLongitude() { return this.homeLongitude ; }
    public double getHomeRadius() { return this.homeRadius; }
    public boolean isResetPasswordRequired() { return this.resetPasswordRequired; }
    public boolean isLogoutRequired() { return this.logoutRequired; }
    
    public void setLastLogin(Timestamp val) { this.lastLogin = val; }
    public void setHomeLatitude(double val) { this.homeLatitude = val; }
    public void setHomeLongitude(double val) { this.homeLongitude = val; }
    public void setHomeRadius(double val) { this.homeRadius = val; }
    public void setResetPasswordRequired(boolean val) { this.resetPasswordRequired = val; }
    public void setLogoutRequired(boolean val) { this.logoutRequired = val; }
    
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