var global_openOnPageLoad_byBilling = false;
var global_openOnPageLoad_byCustomer = false;
var global_openOnPageLoad_billingId = '';
var global_openOnPageLoad_customerId = '';

/// CONSTANTS
var PAGE_ACTION_ENTRY = 'page_actionName_entry';
var PAGE_ACTION_NEW_QUOTATION = 'page_actionName_newQuotation';
var PAGE_ACTION_NEW_BILLING = 'page_actionName_newBilling';
var PAGE_ACTION_OPEN_BILLING = 'page_actionName_openBilling';
var PAGE_ACTION_SAVE_BILLING = 'page_actionName_saveBilling';
var PAGE_ACTION_SAVE_BILLING_BUCKET = 'page_actionName_saveBillingBucket';
var PAGE_ACTION_DELETE_BILLING = 'page_actionName_deleteBilling';
var PAGE_ACTION_SEARCH_BILLING = 'page_actionName_searchBilling';
var PAGE_ACTION_CLOSE_BILLING = 'page_actionName_closeBilling';
var PAGE_ACTION_MAKE_PAYMENT = 'page_actionName_makePayment';
var PAGE_ACTION_MAKE_DELIVERY = 'page_actionName_makeDelivery';
var PAGE_ACTION_PRINT_BILLING = 'page_actionName_printBilling';
var PAGE_ACTION_SHOW_WORKFLOW = 'page_actionName_showWorkflow';

var PAGE_ACTION_FILTER_SEARCH_TEXT = 'page_actioName_filterSearchText';
var PAGE_ACTION_RESET_SEARCH_TEXT = 'page_actioName_resetSearchText';

var PAGE_ACTION_OPEN_DISCOUNT = 'page_actionName_openDiscount';
var PAGE_ACTION_OPEN_TAX = 'page_actionName_openTax';
var PAGE_ACTION_SEARCH_CUSTOMER = 'page_actionName_searchCustomer';
var PAGE_ACTION_EDIT_BILLING_NO = 'page_actionName_editBillingNo';
var PAGE_ACTION_EDIT_QUOTATION_NO = 'page_actionName_editQuotationNo';
var PAGE_ACTION_OPEN_BILLING_CALENDAR = 'page_actionName_openBillingCalendar';
var PAGE_ACTION_OPEN_QUOTATION_OPTIONS = 'page_actionName_openQuotationOptions';

// Menu Switcher
var PAGE_ACTION_SWITCH_MENU_TO_LIST = 'page_actionName_switchMenuToList';
var PAGE_ACTION_SWITCH_MENU_TO_BLOCK = 'page_actionName_switchMenuToBlock';

var ACTION_SAVE_TRANSACTION = 'actionName_saveTransaction';
var ACTION_DELETE_BILLING = 'actionName_deleteBilling';
var ACTION_DELETE_TRANSACTION = 'actionName_deleteTransaction';
var ACTION_SAVE_CUSTOMER = 'actionName_saveCustomer';
var ACTION_SAVE_INVENTORY_ITEM = 'actionName_saveInventoryItem';

// Query String Options: 
var PARAMETER_NAME_OPEN_BY_CUSTOMER_ID = 'openByCustomerId';
var PARAMETER_NAME_OPEN_BY_BILLING_ID = 'openByBillingId';
var PARAMETER_NAME_OPEN_BY_BILLING_NO = 'openByBillingNo';

// POS item list View Type
var ITEM_VIEW_TYPE_LIST = 'itemViewType_list';
var ITEM_VIEW_TYPE_BLOCK = 'itemViewType_block';

// Global Variables Declaration
var currentPageAction = '';
var previousPageAction = '';

// Globally Accessed Variables
var global_currencySign;

// Canvas
var global_placeLayoutObj;
var global_placeLayoutComponentObj;
var global_billingBucketObj;

var global_billingList;
var global_billingObj;

var global_itemImageHeight = [];
var global_selectedBillingLineObj;
var global_itemDetailsTabList = []; // keep tab id(s)
var global_updatedItemList = [];
var global_componentItemList = [];

var global_billingItemDisplayWidth = 120;
var global_currentItemViewType = ITEM_VIEW_TYPE_BLOCK;
// .end of Global Variables Declaration

//==============================================================================
