package com.tychees.core.bean.common;

import javax.persistence.Column;  
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;  

@MappedSuperclass 
public abstract class CommonEmailBean 
	extends BeanSuperClass 
{  
	@Column(name="type")
	String type = "";
	@Column(name="email_address")  
	String emailAddress = "";   
	@Column(name="default_email")  
	Boolean defaultEmail = false;   

	public String getType() { return this.type; }
    public String getEmailAddress() { return this.emailAddress; }
    public Boolean isDefaultEmail() { return this.defaultEmail; }
    
    public void setType(String val) { this.type = getSafeString(val); }
    public void setEmailAddress(String val) { this.emailAddress = getSafeString(val); }
    public void setDefaultEmail(Boolean val) { this.defaultEmail = val; }
}
