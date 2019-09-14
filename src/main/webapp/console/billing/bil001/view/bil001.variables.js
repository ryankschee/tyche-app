
var global_openOnPageLoad_byBilling		= false;
var global_openOnPageLoad_byCustomer	= false;
var global_openOnPageLoad_billingId		= '';
var global_openOnPageLoad_customerId	= '';

/// CONSTANTS
var PAGE_ACTION_MAKE_DELIVERY 	        = 'page_actionName_makeDelivery';

var PAGE_ACTION_FILTER_SEARCH_TEXT 	    = 'page_actioName_filterSearchText';
var PAGE_ACTION_RESET_SEARCH_TEXT 	    = 'page_actioName_resetSearchText';

var PAGE_ACTION_OPEN_DISCOUNT           = 'page_actionName_openDiscount';
var PAGE_ACTION_OPEN_TAX                = 'page_actionName_openTax';

var ACTION_SAVE_TRANSACTION             = 'actionName_saveTransaction';
var ACTION_DELETE_BILLING               = 'actionName_deleteBilling';
var ACTION_DELETE_TRANSACTION           = 'actionName_deleteTransaction';
var ACTION_SAVE_CUSTOMER                = 'actionName_saveCustomer';
var ACTION_SAVE_INVENTORY_ITEM          = 'actionName_saveInventoryItem';

// Query String Options: 
var PARAMETER_NAME_OPEN_BY_CUSTOMER_ID  = 'openByCustomerId';
var PARAMETER_NAME_OPEN_BY_BILLING_ID   = 'openByBillingId';
var PARAMETER_NAME_OPEN_BY_BILLING_NO   = 'openByBillingNo';

// POS item list View Type
var ITEM_VIEW_TYPE_LIST                 = 'itemViewType_list';
var ITEM_VIEW_TYPE_BLOCK                = 'itemViewType_block';

// Global Variables Declaration
var currentPageAction = '';
var previousPageAction = '';

var global_currencySign;

var global_billingObj;
var global_itemImageHeight = [];
var global_selectedBillingLineObj;
var global_itemDetailsTabList = [];		// keep tab id(s)
var global_updatedItemList = [];
var global_componentItemList = [];

var global_billingItemDisplayWidth = 180;
var global_currentItemViewType = ITEM_VIEW_TYPE_BLOCK;
// .end of Global Variables Declaration

//==============================================================================
