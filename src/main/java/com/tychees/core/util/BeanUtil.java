package com.tychees.core.util;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.tychees.core.bean.BeanSuperClass;
import com.tychees.core.bean.common.CommonAddressBean;
import com.tychees.core.bean.common.CommonContactBean;

@Component
public class BeanUtil {

	public boolean getBooleanValue(String booleanVal) 
	{
		if (booleanVal == null || booleanVal.trim().length()==0)
			return false;
		
		String uppercase = booleanVal.trim().toUpperCase();
		if ("Y".equals(uppercase))
			return true;
		if ("YES".equals(uppercase))
			return true;
		if ("TRUE".equals(uppercase))
			return true;
		if ("1".equals(uppercase))
			return true;
		
		return false;
	} // .end of getBooleanValue
	
    /**
     * Find value of matched 'key' from jsonObj, and return it as String. 
     */ 
    protected String jsonValueToString(JsonObject jsonObj, String key) 
    {    	
    	return getSafeString(jsonObj.get(key).getAsString());
    } // .end of jsonValueToString

    /**
     * Find value of matched 'key' from jsonObj, and return it as Integer. 
     */ 
    protected Integer jsonValueToInteger(JsonObject jsonObj, String key) 
    {
    	return getSafeInteger(jsonObj.get(key).getAsInt());    	
    } // .end of jsonValueToInteger
    
    /**
     * Find value of matched 'key' from jsonObj, and return it as Long. 
     */ 
    protected Long jsonValueToLong(JsonObject jsonObj, String key) 
    {
    	return getSafeLong(jsonObj.get(key).getAsLong());    	
    } // .end of jsonValueToLong
    
    /**
     * Find value of matched 'key' from jsonObj, and return it as Double. 
     */ 
    protected Double jsonValueToDouble(JsonObject jsonObj, String key) 
    {
    	return getSafeDouble(jsonObj.get(key).getAsDouble());
    } // .end of jsonValueToDouble
    
    /**
     * Find value of matched 'key' from jsonObj, and return it as Boolean. 
     */ 
    protected Boolean jsonValueToBoolean(JsonObject jsonObj, String key) 
    {
    	return jsonObj.get(key).getAsBoolean();    	
    } // .end of jsonValueToBoolean

    /**
     * Find value of matched 'key' from jsonObj, and return it as Boolean. 
     */ 
    protected Date jsonValueToDate(JsonObject jsonObj, String key) 
    {
    	return new Date(jsonObj.get(key).getAsLong());   	
    } // .end of jsonValueToDate
    
    /**
     * Find value of matched 'key' from jsonObj, and return it as Boolean. 
     */ 
    protected Timestamp jsonValueToTimestamp(JsonObject jsonObj, String key) 
    {
    	return new Timestamp(jsonObj.get(key).getAsLong());   	
    } // .end of jsonValueToTimestamp
    
    /**
     * Get json representation of object.
     */ 
    public String toJsonString() 
    {
        Gson gson = new Gson();
        return gson.toJson(this);
    } // .end of toJsonString
    
    public String getSafeString(String val) 
    { 
    	if (val == null)
    		return "";
    	else
    		return val.trim();
    } // .end of getSafeString

    public int getSafeInteger(Integer val) 
    {
    	if (val == null)
    		return 0;
    	else
    		return val.intValue();
    } // .end of getSafeInteger
    
    public long getSafeLong(Long val) 
    {
    	if (val == null)
    		return 0L;
    	else
    		return val.longValue();
    } // .end of getSafeLong
    
    public double getSafeDouble(Double val) 
    {
    	if (val == null)
    		return 0.0d;
    	else
    		return val.doubleValue();
    } // .end of getSafeDouble
      
    /**
     * Convert JSONObject to string in json.
     * 
     * @param jsonObj
     * @return
     */
    public String fromJSONObjectToString(JsonObject jsonObj) 
    {
    	return jsonObj.toString();
    } // .end of fromJSONObjectToString
    
    public boolean isDeletedBean(BeanSuperClass beanObj)
    {
    	if (beanObj==null)
    		return false;
    	if (beanObj.getDeletedBy() == null || "".equals(beanObj.getDeletedBy().trim()))
    		return false;
    	return true;
    } // .end of isDeletedBean
    
    public String formatContactBeanToString(CommonContactBean contactObj) 
	{		
		if (contactObj == null) {
			return "-";
		}
		else {
			StringBuffer buffer = new StringBuffer();
			
			if (contactObj.getCountryCode() != null && contactObj.getCountryCode().trim().length() > 0)
				buffer.append("(+" + contactObj.getCountryCode() + ") ");

			if (contactObj.getAreaCode() != null && contactObj.getAreaCode().trim().length() > 0)
				buffer.append(contactObj.getAreaCode() + " ");

			if (contactObj.getPhoneNumber() != null && contactObj.getPhoneNumber().trim().length() > 0)
				buffer.append(contactObj.getPhoneNumber());

			return buffer.toString();
		}
	} // .end of formatContactBeanToString

	public String formatAddressBeanToString(CommonAddressBean addressObj) 
	{		
		if (addressObj == null) {
			return "-";
		}
		else {
			StringBuffer buffer = new StringBuffer();
			
			if (addressObj.getStreetLine1() != null && addressObj.getStreetLine1().trim().length() > 0) {
				buffer.append(addressObj.getStreetLine1().trim());
				if (addressObj.getStreetLine1().trim().endsWith("."))
					buffer.append(" ");
				else
					buffer.append(", ");
			}

			if (addressObj.getStreetLine2() != null && addressObj.getStreetLine2().trim().length() > 0) {
				buffer.append(addressObj.getStreetLine2().trim());
				if (addressObj.getStreetLine2().trim().endsWith("."))
					buffer.append(" ");
				else
					buffer.append(", ");
			}
			
			if (addressObj.getStreetLine3() != null && addressObj.getStreetLine3().trim().length() > 0) {
				buffer.append(addressObj.getStreetLine3().trim());
				if (addressObj.getStreetLine3().trim().endsWith("."))
					buffer.append(" ");
				else
					buffer.append(", ");
			}
			
			if (addressObj.getPostalCode() != null && addressObj.getPostalCode().trim().length() > 0) {
				buffer.append(addressObj.getPostalCode().trim());
				buffer.append(" ");				
			}
			
			if (addressObj.getCity() != null && addressObj.getCity().trim().length() > 0) {
				buffer.append(addressObj.getCity().trim());
				buffer.append(", ");				
			}
			
			if (addressObj.getState() != null && addressObj.getState().trim().length() > 0) {
				buffer.append(addressObj.getState().trim());
				buffer.append(", ");				
			}
			
			if (addressObj.getCountry() != null && addressObj.getCountry().trim().length() > 0) {
				buffer.append(addressObj.getCountry().trim());
				buffer.append(".");				
			}
						
			return buffer.toString();
		}
	} // .end of formatAddressBeanToString
}
