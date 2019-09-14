package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class CommonAddressBean
	extends CommonGeolocationBean
{
	@Column(name="type")
    String type = "";
	@Column(name="attention_to")    
    String attentionTo = "";
	@Column(name="street_line_1")
    String streetLine1 = "";
	@Column(name="street_line_2")
    String streetLine2 = "";
	@Column(name="street_line_3")
    String streetLine3 = "";
	@Column(name="postal_code")
    String postalCode = "";
	@Column(name="area")
	String area = "";
	@Column(name="city")
    String city = "";
	@Column(name="state")
    String state = "";
	@Column(name="country")
    String country = "";
	@Column(name="default_address")
	boolean defaultAddress = false;
	
    public String getType() { return this.type; }
    public String getAttentionTo() { return this.attentionTo; }
    public String getStreetLine1() { return this.streetLine1; }
    public String getStreetLine2() { return this.streetLine2; }
    public String getStreetLine3() { return this.streetLine3; }
    public String getPostalCode() { return this.postalCode; }
    public String getCity() { return this.city; }
    public String getArea() { return this.area; }
    public String getState() { return this.state; }
    public String getCountry() { return this.country; }
    public boolean isDefaultAddress() { return this.defaultAddress; }
    
    public void setType(String val) { this.type = getSafeString(val); }
    public void setAttentionTo(String val) { this.attentionTo = getSafeString(val); }
    public void setStreetLine1(String val) { this.streetLine1 = getSafeString(val); }
    public void setStreetLine2(String val) { this.streetLine2 = getSafeString(val); }
    public void setStreetLine3(String val) { this.streetLine3 = getSafeString(val); }
    public void setPostalCode(String val) { this.postalCode = getSafeString(val); }
    public void setCity(String val) { this.city = getSafeString(val); }
    public void setArea(String val) { this.area = getSafeString(val); }
    public void setState(String val) { this.state = getSafeString(val); }
    public void setCountry(String val) { this.country = getSafeString(val); }
    public void setDefaultAddress(boolean val) { this.defaultAddress = val; }
}
