package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class PlaceConstants 
	implements java.io.Serializable
{
    private final static long serialVersionUID = 1467880004586236216L;
    
	public PlaceConstants() {}
	
	public final String PLACE_ROLE_ADMINISTRATOR                                = "Administrator";
	public final String PLACE_ROLE_SUPERUSER                                    = "Superuser";
	
    public final String TEMPLATE_TYPE_CUSTOMER                                  = "TEMPLATE_TYPE_CUSTOMER";
    public final String TEMPLATE_TYPE_CUSTOMER_PROFILE                          = "TEMPLATE_TYPE_CUSTOMER_PROFILE";

    public final String TEMPLATE_TYPE_EMPLOYEE                                  = "TEMPLATE_TYPE_EMPLOYEE";
    public final String TEMPLATE_TYPE_EMPLOYEE_PROFILE                          = "TEMPLATE_TYPE_EMPLOYEE_PROFILE";
    
    // LAYOUT DRAWING
    public final String PLACE_LAYOUT_OBJECT_TYPE_LINE                           = "objectType_line";
    public final String PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE                      = "objectType_rectangle";
    public final String PLACE_LAYOUT_OBJECT_TYPE_CIRCLE                         = "objectType_circle";
    
    // Place Proerties GROUP NAME
    public final String PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP						= "placePropGroup_accountMembership";    
    
    // Place Properties VALUE
    public final String PLACE_PROP_VALUE_ACCOUNT_TYPE_BASIC						= "basic";
    public final String PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE				= "enterprise";
    public final String PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM  					= "premium";
    public final String PLACE_PROP_VALUE_BASIC_USER_MAX_COUNT					= "10";
    public final String PLACE_PROP_VALUE_BASIC_CUSTOMER_MAX_COUNT				= "1000";
    public final String PLACE_PROP_VALUE_BASIC_EMPLOYEE_MAX_COUNT				= "100";
    public final String PLACE_PROP_VALUE_BASIC_INVENTORY_CATEGORY_MAX_COUNT		= "100";
    public final String PLACE_PROP_VALUE_BASIC_INVENTORY_ITEM_MAX_COUNT			= "5000";
    public final String PLACE_PROP_VALUE_BASIC_MONTHLY_BILLING_MAX_AMOUNT		= "50000";
    public final String PLACE_PROP_VALUE_ENTERPRISE_USER_MAX_COUNT				= "50";
    public final String PLACE_PROP_VALUE_ENTERPRISE_CUSTOMER_MAX_COUNT			= "5000";
    public final String PLACE_PROP_VALUE_ENTERPRISE_EMPLOYEE_MAX_COUNT			= "500";
    public final String PLACE_PROP_VALUE_ENTERPRISE_INVENTORY_CATEGORY_MAX_COUNT= "500";
    public final String PLACE_PROP_VALUE_ENTERPRISE_INVENTORY_ITEM_MAX_COUNT	= "25000";
    public final String PLACE_PROP_VALUE_ENTERPRISE_MONTHLY_BILLING_MAX_AMOUNT	= "500000";
    public final String PLACE_PROP_VALUE_PREMIUM_USER_MAX_COUNT					= "200";
    public final String PLACE_PROP_VALUE_PREMIUM_CUSTOMER_MAX_COUNT				= "200000";
    public final String PLACE_PROP_VALUE_PREMIUM_EMPLOYEE_MAX_COUNT				= "2000";
    public final String PLACE_PROP_VALUE_PREMIUM_INVENTORY_CATEGORY_MAX_COUNT	= "2000";
    public final String PLACE_PROP_VALUE_PREMIUM_INVENTORY_ITEM_MAX_COUNT		= "100000";
    public final String PLACE_PROP_VALUE_PREMIUM_MONTHLY_BILLING_MAX_AMOUNT		= "1000000";
    
    // Place Properties KEY
    public final String PLACE_PROP_KEY_ACCOUNT_TYPE								= "placePropKey_accountType";
    public final String PLACE_PROP_KEY_USER_MAX_COUNT							= "placePropKey_userMaxCount";
    public final String PLACE_PROP_KEY_CUSTOMER_MAX_COUNT						= "placePropKey_customerMaxCount";
    public final String PLACE_PROP_KEY_EMPLOYEE_MAX_COUNT						= "placePropKey_employeeMaxCount";
    public final String PLACE_PROP_KEY_INVENTORY_CATEGORY_MAX_COUNT				= "placePropKey_inventoryCategoryMaxCount";
    public final String PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT					= "placePropKey_inventoryItemMaxCount";
    public final String PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT				= "placePropKey_monthlyBillingMaxAmount";

    // Place Properties NAME
    public final String PLACE_PROP_NAME_ACCOUNT_TYPE							= "Account Type";
    public final String PLACE_PROP_NAME_USER_MAX_COUNT							= "User Max Count";
    public final String PLACE_PROP_NAME_CUSTOMER_MAX_COUNT						= "Customer Max Count";
    public final String PLACE_PROP_NAME_EMPLOYEE_MAX_COUNT						= "Employee Max Count";
    public final String PLACE_PROP_NAME_INVENTORY_CATEGORY_MAX_COUNT			= "Inventory Category Max Count";
    public final String PLACE_PROP_NAME_INVENTORY_ITEM_MAX_COUNT				= "Inventory Item Max Count";
    public final String PLACE_PROP_NAME_MONTHLY_BILLING_MAX_AMOUNT				= "Monthly Billing Max Amount";
}
