package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class InventoryConstants 
	implements java.io.Serializable
{
	private final static long serialVersionUID = 1467880004586236216L;
	
	public final String SYSTEM_DEFINED_MASTER_ID 						= "system-master";

	// ITEM TYPE
	public final String ITEM_TYPE_PRODUCT								= "product";
	public final String ITEM_TYPE_SERVICE								= "service";
	public final String ITEM_TYPE_EVENT									= "event";
	public final String ITEM_TYPE_RAW									= "raw";
	public final String ITEM_TYPE_DISCOUNT								= "discount";
	public final String ITEM_TYPE_TAX									= "tax";
	
	// CONSTANTS - FIELD TYPES
	public final String PROP_TYPE_BOOLEAN								= "Boolean";
	public final String PROP_TYPE_TEXT									= "Text";
	public final String PROP_TYPE_NUMBER								= "Number";
	public final String PROP_TYPE_DATE									= "Date";
	public final String PROP_TYPE_TIME									= "Time";
	public final String PROP_TYPE_LIST									= "List";
	public final String PROP_TYPE_TAG									= "Tag";
	
	public final String QUANTITY_AVAILABLE								= "quantityAvailable";
	public final String QUANTITY_LOW_STOCK								= "quantityLowStock";
	public final String QUANTITY_NO_STOCK								= "quantityNoStock";
	public final String QUANTITY_INVALID_ITEM_FOUND						= "quantityInvalidItemFound";
	public final String QUANTITY_ERROR_LOOP_FOUND						= "quantityErrorLoopFound";
	
	public final String QUANTITY_AVAILABLE_DESC							= "Available";
	public final String QUANTITY_LOW_STOCK_DESC							= "Low Stock";
	public final String QUANTITY_NO_STOCK_DESC							= "No Stock";
	public final String QUANTITY_INVALID_ITEM_FOUND_DESC				= "Error: Invalid Item";
	public final String QUANTITY_ERROR_LOOP_FOUND_DESC					= "Error: Circular Loop";

	// Inventory Image
	public final String IMAGE_TYPE_PRIMARY								= "Primary";
	public final String IMAGE_TYPE_NOT_PRIMARY							= "Not Primary";
	
	// Inventory Component
	public final String COMPONENT_SELECTION_MODE_SINGLE					= "single";
	public final String COMPONENT_SELECTION_MODE_MULTIPLE				= "multiple";
	
	// Inventory Transaction
	public final String TRANSACTION_TYPE_SEARCH 						= "transactionTypeSearch";
	public final String TRANSACTION_TYPE_BILLING 						= "transactionTypeBilling";
	public final String TRANSACTION_TYPE_ADJUSTMENT      				= "transactionTypeAdjustment";
    public final String TRANSACTION_TYPE_PURCHASE        				= "transactionTypePurchase";
    public final String TRANSACTION_TYPE_PURCHASE_IN     				= "transactionTypePurchaseIn";
    public final String TRANSACTION_TYPE_PURCHASE_OUT    				= "transactionTypePurchaseOut";
    public final String TRANSACTION_TYPE_LOST            				= "transactionTypeLost";
    public final String TRANSACTION_TYPE_TRANSFER        				= "transactionTypeTransfer";
    public final String TRANSACTION_TYPE_TRANSFER_IN     				= "transactionTypeTransferIn";
    public final String TRANSACTION_TYPE_TRANSFER_OUT    				= "transactionTypeTransferOut";
    public final String TRANSACTION_THIRD_PARTY_TYPE_VENDOR         	= "thirdPartyTypeVendor";
    public final String TRANSACTION_THIRD_PARTY_TYPE_BRANCH         	= "thirdPartyTypeBranch";
	// Transaction Line Operator
	public final String TRANSACTION_LINE_OPERATOR_ADD 					= "OP_ADD";
	public final String TRANSACTION_LINE_OPERATOR_SUB 					= "OP_SUB";
    
}
