package com.tychees.core.bean.common;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonPersonBean
    extends BeanSuperClass
{
	@Column(name="first_name")  
	String firstName = "";   
	@Column(name="last_name")  
	String lastName = "";   
	@Column(name="dob")  
	Date dob;   
	@Column(name="gender")  
	String gender = "";   
	@Column(name="contact")  
	String contact = "";   
	@Column(name="email")  
	String email = "";   
	@Column(name="address")  
	String address = "";   
	@Column(name="area")  
	String area = "";   
	@Column(name="profile_image_url")  
	String profileImageUrl = "";   
	@Column(name="description")  
	String description = "";   
    
    public String getFirstName() { return this.firstName; }
    public String getLastName() { return this.lastName; }
    public Date getDob() { return this.dob; }
    public String getGender() { return this.gender; }
    public String getContact() { return this.contact; }
    public String getEmail() { return this.email; }
    public String getAddress() { return this.address; }
    public String getArea() { return this.area; }
    public String getProfileImageUrl() { return this.profileImageUrl; }
    public String getDescription() { return this.description; }
    
    public void setFirstName(String val) { this.firstName = val; }
    public void setLastName(String val) { this.lastName = val; }
    public void setDob(Date val) { this.dob = val; }
    public void setGender(String val) { this.gender = val; }
    public void setContact(String val) { this.contact = val; }
    public void setEmail(String val) { this.email = val; }
    public void setAddress(String val) { this.address = val; }
    public void setArea(String val) { this.area = val; }
    public void setProfileImageUrl(String val) { this.profileImageUrl = val; }
    public void setDescription(String val) { this.description = val; }
}