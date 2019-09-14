package com.tychees.core.constants;

public class DocumentConstants 
	implements java.io.Serializable
{
	private static final long serialVersionUID = 1467880004586236216L;
	
	public DocumentConstants() {}
	
	public final String DOC_TYPE_INVOICE 								= "billing_invoice";
	public final String DOC_TYPE_INVOICE_NAME							= "Invoice";
	
	public final String DOC_TYPE_DELIVERY_ORDER							= "delivery_order";
	public final String DOC_TYPE_DELIVERY_ORDER_NAME 					= "Delivery Order";
	
	public final String DOC_TYPE_PAYMENT_RECEIPT 						= "billing_receipt";
	public final String DOC_TYPE_PAYMENT_RECEIPT_NAME					= "Receipt";
	
	public final String COMPONENT_OBJECT_TYPE_TEXT					    = "objectType_text";
	public final String COMPONENT_OBJECT_TYPE_LINE					    = "objectType_line";
	public final String COMPONENT_OBJECT_TYPE_BOX					    = "objectType_box";
	public final String COMPONENT_OBJECT_TYPE_DATE					    = "objectType_date";
	public final String COMPONENT_OBJECT_TYPE_IMAGE					    = "objectType_image";
	public final String COMPONENT_OBJECT_TYPE_PLACE_FIELD			    = "objectType_placeField";
	public final String COMPONENT_OBJECT_TYPE_CUSTOMER_FIELD			= "objectType_customerField";
	public final String COMPONENT_OBJECT_TYPE_BILLING_FIELD			    = "objectType_billingField";
}
