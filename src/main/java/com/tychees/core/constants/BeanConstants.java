package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class BeanConstants 
	implements java.io.Serializable
{
	private final static long serialVersionUID = 1467880004586236216L;
	
	public BeanConstants() {}
	
	// BEAN CLASS NAME
	public final String BEAN_CLASS_NAME_BILLING							= "com.tychees.core.bean.billing.BillingBean";
	public final String BEAN_CLASS_NAME_BILLING_BUCKET					= "com.tychees.core.bean.billing.BillingBucketBean";
	public final String BEAN_CLASS_NAME_CUSTOMER						= "com.tychees.core.bean.customer.CustomerBean";
	public final String BEAN_CLASS_NAME_DOCUMENT						= "com.tychees.core.bean.document.DocumentBean";
	public final String BEAN_CLASS_NAME_INVENTORY_CATEGORY				= "com.tychees.core.bean.inventory.InventoryCategoryBean";
	public final String BEAN_CLASS_NAME_INVENTORY_ITEM					= "com.tychees.core.bean.inventory.InventoryItemBean";
	public final String BEAN_CLASS_NAME_INVENTORY_TRANSACTION			= "com.tychees.core.bean.inventory.InventoryTransactionBean";
	public final String BEAN_CLASS_NAME_PLACE							= "com.tychees.core.bean.place.PlaceBean";
	public final String BEAN_CLASS_NAME_USER							= "com.tychees.core.bean.user.UserBean";
	
	// BEAN CLASS SHORT NAME
	public final String BEAN_CLASS_SHORT_NAME_BILLING					= "BillingBean";
	public final String BEAN_CLASS_SHORT_NAME_BILLING_BUCKET			= "BillingBucketBean";
	public final String BEAN_CLASS_SHORT_NAME_CUSTOMER					= "CustomerBean";
	public final String BEAN_CLASS_SHORT_NAME_DOCUMENT					= "DocumentBean";
	public final String BEAN_CLASS_SHORT_NAME_INVENTORY_CATEGORY		= "InventoryCategoryBean";
	public final String BEAN_CLASS_SHORT_NAME_INVENTORY_ITEM			= "InventoryItemBean";
	public final String BEAN_CLASS_SHORT_NAME_INVENTORY_TRANSACTION		= "InventoryTransactionBean";
	public final String BEAN_CLASS_SHORT_NAME_PLACE						= "PlaceBean";
	public final String BEAN_CLASS_SHORT_NAME_USER						= "UserBean";
}
