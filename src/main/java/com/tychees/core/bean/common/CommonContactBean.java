package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonContactBean
    extends BeanSuperClass
{
    @Column(name="type")
    String type = "";
    @Column(name="country_code")
    String countryCode = "";
    @Column(name="area_code")
    String areaCode = "";
    @Column(name="phone_number")
    String phoneNumber = "";
    @Column(name="extension")
    String extension = "";
    @Column(name="default_contact")
    boolean defaultContact = false;
    
    public String getType() { return this.type; }
    public String getCountryCode() { return this.countryCode; }
    public String getAreaCode() { return this.areaCode; }
    public String getPhoneNumber() { return this.phoneNumber; }
    public String getExtension() { return this.extension; }
    public boolean isDefaultContact() { return this.defaultContact; }
    
    public void setType(String val) { this.type = val; }
    public void setCountryCode(String val) { this.countryCode = getSafeString(val); } 
    public void setAreaCode(String val) { this.areaCode = getSafeString(val); }
    public void setPhoneNumber(String val) { this.phoneNumber = getSafeString(val); }
    public void setExtension(String val) { this.extension = getSafeString(val); }
    public void setDefaultContact(boolean val) { this.defaultContact = val; }
}