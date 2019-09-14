package com.tychees.core.constants;

public class UserConstants 
	implements java.io.Serializable
{
	private final static long serialVersionUID = 1467880004586236216L;
	
	public UserConstants() {}

	public final String SESSION_STATUS_VALID 							= "session_status_valid";
	public final String SESSION_STATUS_EXPIRED 							= "session_status_expired";
	
	public final String SSO_PROVIDER_GOOGLE 							= "ssoProviderGoogle";
	public final String SSO_PROVIDER_FACEBOOK 							= "ssoProviderFacebook";
		
	// USER PREFERENCES
	public final String PREF_SEARCH_BILLING_VIEW_SIZE					= "prefSearchBillingViewSize";
	public final String PREF_SEARCH_CUSTOMER_VIEW_SIZE					= "prefSearchCustomerViewSize";
	public final String PREF_SEARCH_EMPLOYEE_VIEW_SIZE					= "prefSearchEmployeeViewSize";
	public final String PREF_CUSTOMER_VIEW_SIZE							= "prefCustomerViewSize";
	public final String PREF_EMPLOYEE_VIEW_SIZE							= "prefEmployeeViewSize";
	public final String PREF_POS_LIST_VIEW_SIZE							= "prefPosListViewSize";
}
