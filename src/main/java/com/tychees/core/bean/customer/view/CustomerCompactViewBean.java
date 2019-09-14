package com.tychees.core.bean.customer.view;

import java.sql.Date;
import java.util.UUID;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.util.BeanUtil;

public class CustomerCompactViewBean 
	extends BeanUtil
	implements java.io.Serializable
{
	private static final long serialVersionUID = -4953300246789127124L;
    
    public CustomerCompactViewBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerCompactViewBean(String id) 
    {
        super();
        this.setId(id);
    }
    
    public CustomerCompactViewBean(CustomerBean beanObj)
    {
        super();
        this.setId(beanObj.getId());
        this.setCustomerNo(beanObj.getCustomerNo());
        this.setFirstName(beanObj.getFirstName());
        this.setLastName(beanObj.getLastName());
        this.setDob(beanObj.getDob());
        this.setGender(beanObj.getGender());
        this.setContact(beanObj.getContact());
        this.setEmail(beanObj.getEmail());
        this.setAddress(beanObj.getAddress());
        this.setArea(beanObj.getArea());
        this.setTemplateName(beanObj.getTemplateName());
    }
    
    String id = "";
    String customerNo = "";
    String firstName = "";
    String lastName = "";  
    Date dob;
    String gender = "";
    String contact = "";
    String email = "";
    String address = "";
    String area = "";
	String templateName = "";
    
    public String getId() { return this.id; }
    public String getCustomerNo() { return this.customerNo; }
    public String getFirstName() { return this.firstName; }
    public String getLastName() { return this.lastName; }
    public Date getDob() { return this.dob; }
    public String getGender() { return this.gender; }
    public String getContact() { return this.contact; }
    public String getEmail() { return this.email; }
    public String getAddress() { return this.address; }
    public String getArea() { return this.area; }
    public String getTemplateName() { return this.templateName; }
    
    public void setId(String val) { this.id = getSafeString(val); }
    public void setCustomerNo(String val) { this.customerNo = getSafeString(val); }  
    public void setFirstName(String val) { this.firstName = getSafeString(val); }  
    public void setLastName(String val) { this.lastName = getSafeString(val); }  
    public void setDob(Date val) { this.dob = val; }  
    public void setGender(String val) { this.gender = getSafeString(val); }  
    public void setContact(String val) { this.contact = getSafeString(val); }  
    public void setEmail(String val) { this.email = getSafeString(val); }  
    public void setAddress(String val) { this.address = getSafeString(val); }  
    public void setArea(String val) { this.area = getSafeString(val); }
    public void setTemplateName(String val) { this.templateName = getSafeString(val); }  
}
