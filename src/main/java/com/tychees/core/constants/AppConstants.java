package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class AppConstants 
	implements java.io.Serializable
{
	private final static long serialVersionUID = 1467880004586236216L;
	
	public AppConstants() {}
	
	// DEV
	//public final static String CONSOLE_SITE_URL						    = "http://dev.tychees.com";
	// PRODUCTION
	//public final static String CONSOLE_SITE_URL							= "http://console.tychees.com";
	public final static String CONSOLE_SITE_URL							= "https://tyche-console-prod.appspot.com";
	
	// PWS DEV
	public final static String PWS_SITE_URL								= "https://tyche-pws-dev.appspot.com/";
	// PWS PRODUCTION
	//public final static String PWS_SITE_URL								= "https://www.tychees.com/";
	
	public final double EARTH_RADIUS 									= 6371.01;

	public final String GENDER_MALE										= "Male";
	public final String GENDER_FEMALE									= "Female";
	
	public final String CONTACT_TYPE_HOME								= "Home";
	public final String CONTACT_TYPE_OFFICE								= "Office";
	public final String CONTACT_TYPE_MOBILE								= "Mobile";

	// Query String Options: 
	public final String PARAMETER_NAME_OPEN_BY_CUSTOMER_ID  			= "openByCustomerId";
	public final String PARAMETER_NAME_OPEN_BY_BILLING_ID   			= "openByBillingId";
	public final String PARAMETER_NAME_OPEN_BY_BILLING_NO   			= "openByBillingNo";
	public final String PARAMETER_NAME_SUB_MODULE	   					= "subModule";
	public final String PARAMETER_NAME_CUSTOMER_ID	   					= "customerId";
	public final String PARAMETER_NAME_INVENTORY_CATEGORY_ID			= "categoryId";
	public final String PARAMETER_NAME_INVENTORY_ITEM_ID				= "itemId";

	// CommonPropertiesBean
	public final String COMMON_PROPERTIES_TYPE_TEXT						= "Text";
	public final String COMMON_PROPERTIES_TYPE_TEXTAREA					= "Text Area";
	public final String COMMON_PROPERTIES_TYPE_NUMBER					= "Number";
	public final String COMMON_PROPERTIES_TYPE_DATE						= "Date";
	public final String COMMON_PROPERTIES_TYPE_BOOLEAN					= "Boolean";
	public final String COMMON_PROPERTIES_TYPE_SELECT					= "Select";
	public final String COMMON_PROPERTIES_TYPE_SELECT_MULTIPLE			= "Select Multiple";
	
	
	// FILE CONTROL - file upload, file retrieval, etc
	public final String FILE_CONTROL_USER_IMAGE							= "FileControl_UserImage";
	public final String FILE_CONTROL_PLACE_IMAGE						= "FileControl_PlaceImage";
	public final String FILE_CONTROL_INVENTORY_ITEM_IMAGE				= "FileControl_InventoryItemImage";
}
