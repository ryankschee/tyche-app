var global_openOnPageLoad_byCategory        = false;
var global_openOnPageLoad_byItem            = false;
var global_openOnPageLoad_categoryId        = '';
var global_openOnPageLoad_itemId            = '';


var PARAMETER_NAME_OPEN_BY_BILLING_ID 					= 'openByBillingId';

// Executable Action Names
var SEGMENT00_ACTION_SHOW_TRANSACTION_LIST      	    = 'segment00_actionName_showTransactionList';
var SEGMENT00_ACTION_ADD_ITEM 						    = 'segment00_actionName_addItem';
var SEGMENT00_ACTION_SUB_ITEM 						    = 'segment00_actionName_subItem';
var SEGMENT00_ACTION_REMOVE_ITEM 					    = 'segment00_actionName_removeItem';
var SEGMENT00_ACTION_EXECUTE 						    = 'segment00_actionName_execute';
var SEGMENT00_ACTION_REVERT 						    = 'segment00_actionName_revert';
var SEGMENT00_ACTION_SAVE 							    = 'segment00_actionName_save';
var SEGMENT00_ACTION_PRINT 							    = 'segment00_actionName_print';
var SEGMENT00_ACTION_CLOSE 							    = 'segment00_actionName_close';

var SEGMENT00_ACTION_OPEN_POS_BY_BILLING_ID				= 'segment00_actionName_openPosByBillingId';
var SEGMENT00_ACTION_OPEN_TRANSACTION 					= 'segment00_actionName_openTransaction';
var SEGMENT00_ACTION_DELETE_TRANSACTION 				= 'segment00_actionName_deleteTransaction';

//--- BELOW IS OLD

var ACTION_PAGE_REFRESH 						= 'actionName_page_refresh';
var ACTION_PAGE_EDIT_TRANSACTION 				= 'actionName_page_editTransaction';
var ACTION_PAGE_DELETE_TRANSACTION 				= 'actionName_page_deleteTransaction';

var ACTION_MW001_ADD_ITEM 						= 'actionName_mw001_addItem';
var ACTION_MW001_SUB_ITEM 						= 'actionName_mw001_subItem';
var ACTION_MW001_REMOVE_ITEM 					= 'actionName_mw001_removeItem';
var ACTION_MW001_EXECUTE 						= 'actionName_mw001_execute';
var ACTION_MW001_REVERT 						= 'actionName_mw001_revert';
var ACTION_MW001_SAVE 							= 'actionName_mw001_save';
var ACTION_MW001_PRINT 							= 'actionName_mw001_print';
var ACTION_MW001_CLOSE 							= 'actionName_mw001_close';

var ACTION_MW002_SHOW_ITEM_LIST 				= 'actionName_mw002_showItemList';
var ACTION_MW002_SHOW_VENDOR_LIST 				= 'actionName_mw002_showVendorList';
var ACTION_MW002_SHOW_STORE_LIST 				= 'actionName_mw002_showStoreList';
var ACTION_MW002_RESET_VENDOR 					= 'actionName_mw002_resetVendor';
var ACTION_MW002_RESET_STORE 					= 'actionName_mw002_resetStore';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL			= 'actionName_mw002_show_topPanelRight';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_DATE 		= 'actionName_mw002_show_topRightPanel_date';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_YOUR_REF 	= 'actionName_mw002_show_topRightPanel_yourRef';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_OUR_REF 	= 'actionName_mw002_show_topRightPanel_ourRef';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_CREDIT_TERM = 'actionName_mw002_show_topRightPanel_creditTerm';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_DATE = 'actionName_mw002_show_topRightPanel_updateDate';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_YOUR_REF = 'actionName_mw002_show_topRightPanel_updateYourRef';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_OUR_REF = 'actionName_mw002_show_topRightPanel_updateYourRef';
var ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_CREDIT_TERM = 'actionName_mw002_show_topRightPanel_updateCreditTerm';

var ACTION_MW003_ADD_ITEM 						= 'actionName_mw003_addItem';
var ACTION_MW003_SUB_ITEM 						= 'actionName_mw003_subItem';
var ACTION_MW003_REMOVE_ITEM 					= 'actionName_mw003_removeItem';
var ACTION_MW003_EXECUTE 						= 'actionName_mw003_execute';
var ACTION_MW003_REVERT 						= 'actionName_mw003_revert';
var ACTION_MW003_SAVE 							= 'actionName_mw003_save';
var ACTION_MW003_PRINT 							= 'actionName_mw003_print';
var ACTION_MW003_CLOSE 							= 'actionName_mw003_close';

var ACTION_MW004_ADD_ITEM 						= 'actionName_mw004_addItem';
var ACTION_MW004_SUB_ITEM 						= 'actionName_mw004_subItem';
var ACTION_MW004_REMOVE_ITEM 					= 'actionName_mw004_removeItem';
var ACTION_MW004_EXECUTE 						= 'actionName_mw004_execute';
var ACTION_MW004_REVERT 						= 'actionName_mw004_revert';
var ACTION_MW004_SAVE 							= 'actionName_mw004_save';
var ACTION_MW004_PRINT 							= 'actionName_mw004_print';
var ACTION_MW004_CLOSE 							= 'actionName_mw004_close';

var ACTION_MW005_CLOSE 							= 'actionName_mw005_close';
