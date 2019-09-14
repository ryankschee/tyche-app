package com.tychees.core.bean.customer.view;

import java.sql.Date;
import java.util.UUID;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.util.BeanUtil;

public class CustomerViewBean 
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public CustomerViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public CustomerViewBean(CustomerBean beanObj)
    {
        super();
        this.setId(beanObj.getId());
        this.setPlaceId(beanObj.getPlaceId());
        this.setCustomerNo(beanObj.getCustomerNo());
        this.setFirstName(beanObj.getFirstName());
        this.setLastName(beanObj.getLastName());
        this.setDob(beanObj.getDob());
        this.setGender(beanObj.getGender());
        this.setContact(beanObj.getContact());
        this.setEmail(beanObj.getEmail());
        this.setAddress(beanObj.getAddress());
        this.setProfileImageUrl(beanObj.getProfileImageUrl());
        this.setDescription(beanObj.getDescription());
        this.setLastBillingId(beanObj.getLastBillingId());
        this.setLastBillingNo(beanObj.getLastBillingNo());
        this.setTemplateName(beanObj.getTemplateName());
    }
    
    String id = "";
    String placeId = "";
    String customerNo = "";
    String firstName = "";
    String lastName = "";  
    Date dob;
    String gender = "";
    String contact = "";
    String email = "";
    String address = "";
    String profileImageUrl = "";
    String description = "";
	String lastBillingId = "";
	String lastBillingNo = "";
	String templateName = "";
    
    public String getId() { return this.id; }
    public String getPlaceId() { return this.placeId; }
    public String getCustomerNo() { return this.customerNo; }
    public String getFirstName() { return this.firstName; }
    public String getLastName() { return this.lastName; }
    public Date getDob() { return this.dob; }
    public String getGender() { return this.gender; }
    public String getContact() { return this.contact; }
    public String getEmail() { return this.email; }
    public String getAddress() { return this.address; }
    public String getProfileImageUrl() { return this.profileImageUrl; }
    public String getDescription() { return this.description; }
    public String getLastBillingId() { return this.lastBillingId; }
    public String getLastBillingNo() { return this.lastBillingNo; }
    public String getTemplateName() { return this.templateName; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setPlaceId(String val) { this.placeId = getSafeString(val); }
    public void setCustomerNo(String val) { this.customerNo = getSafeString(val); }  
    public void setFirstName(String val) { this.firstName = getSafeString(val); }  
    public void setLastName(String val) { this.lastName = getSafeString(val); }  
    public void setDob(Date val) { this.dob = val; }  
    public void setGender(String val) { this.gender = getSafeString(val); }  
    public void setContact(String val) { this.contact = getSafeString(val); }  
    public void setEmail(String val) { this.email = getSafeString(val); }  
    public void setAddress(String val) { this.address = getSafeString(val); }  
    public void setProfileImageUrl(String val) { this.profileImageUrl = getSafeString(val); }  
    public void setDescription(String val) { this.description = getSafeString(val); }  
    public void setLastBillingId(String val) { this.lastBillingId = getSafeString(val); }  
    public void setLastBillingNo(String val) { this.lastBillingNo = getSafeString(val); }  
    public void setTemplateName(String val) { this.templateName = getSafeString(val); }  
}
