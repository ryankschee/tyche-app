
var bil001_loadImagesDone = false;
var bil001_loadDocumentsDone = false;
var bil001_loadCategoriesDone = false;
var bil001_loadItemsDone = false;

var bil001_categoryList = [];
var bil001_itemList = [];

function module_initApp() {
	tycheesLogger_logInfo('BEGIN 002', 'module_initApp');

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();

	// Call function in inventory-item-main.jsp
	loadUI_custom();

	// Init language pack
	tycheesCommon_initI18N();
	// Stop loading
	tycheesOverlay_stopShortProgress();
	tycheesOverlay_stopLongProgress();

	// Init
	module_init();
	// Post Init
	tycheesCommon_onModulePostInit();
} // .end of initApp

function module_init() {
	$('#main-content').hide();
	$('#module_spinner').show();
	$('#module_spinner_text').html('loading categories...');

	// Reset
	bil001_loadImagesDone = false;
	bil001_loadDocumentsDone = false;
	bil001_loadCategoriesDone = false;
	bil001_loadItemsDone = false;
	
	// Load data
	bil001_loadCategories();	
	bil001_loadItems();
	
	bil001_loadDocuments();
	bil001_loadImages();
} // .end of module_init

function bil001_loadDocuments() {
	var requestBody = new Object();
	var params = new Object();
	
	tycheesdb_api_getDocumentsByPlace(requestBody, bil001_loadDocuments_postHandler, params);
} // .end of bil001_loadDocuments

function bil001_loadDocuments_postHandler(success, responseObj, params) {
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'bil001_loadDocuments_postHandler');
		$('#module_spinner_text').append('<br>Error loading documents.');
		return false;
	}
	
	bil001_loadDocumentsDone = true;	
	Cached_setDocumentList(responseObj.documentList);
} // .end of bil001_loadDocuments_postHandler

function bil001_loadImages() {
    var requestBody = new Object();
    requestBody.onlyTypeLogo = true;
    
    var params = new Object();
    
    tycheesdb_api_getPlaceImagesByPlace(requestBody, bil001_loadImages_postHandler, params);    
} // .end of bil001_loadImages

function bil001_loadImages_postHandler(success, responseObj, params) {
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'bil001_loadImages_postHandler');
		$('#module_spinner_text').append('<br>Error loading images.');
		return false;
	}
	
	bil001_loadImagesDone = true;	
	
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	placeObj.imageList = responseObj.imageList;
	
	Cached_updatePlace(placeObj);
} // .end of bil001_loadImages_postHandler

function bil001_loadCategories() {
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'viewBean': true,
		'filterByPosVisible': false,
		'posVisible': false
	};

	var params = new Object();

	tycheesdb_api_listCategoryByPlace(requestBody, bil001_loadCategories_postHandler, params);
} // .end of bil001_loadCategories

function bil001_loadCategories_postHandler(success, responseObj, params) {
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'bil001_loadCategories_postHandler');
		$('#module_spinner_text').append('<br>Error loading categories.');
		return false;
	}
	
	bil001_loadCategoriesDone = true;
	bil001_categoryList = responseObj.viewList;
	
	module_post_init();
} // .end of bil001_loadCategories_postHandler

function bil001_loadItems() {
	$('#module_spinner_text').html('loading ...');

	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'viewBean': true,
		'filterByPosVisible': true,
		'posVisible': true
	};
	var params = new Object();

	tycheesdb_api_getItemsByPlace(requestBody, bil001_loadItems_postHandler, params);
} // .end of bil001_loadItems

function bil001_loadItems_postHandler(successFlag, responseObj, params) {
	if (successFlag == false) {
		tycheesLogger_logError('Ajax Error.', 'bil001_loadItems_postHandler');
		$('#module_spinner_text').append('<br>Error loading items.');
		return false;
	}

	bil001_loadItemsDone = true;
	bil001_itemList = responseObj.viewList;

	localStorage.setItem(LOCAL_STORAGE_INIT_POS, true);

	module_post_init();
} // .end of bil001_loadItems_postHandler

function module_post_init() {
	if (!bil001_loadCategoriesDone || !bil001_loadItemsDone)
		return false;

	tycheesLogger_logInfo('BEGIN 1', 'module_post_init');
	
	var settingsObj_itemView = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_ITEMVIEW_TYPE);
	if (settingsObj_itemView.propValue == SettingsConstants.SETTINGS_POS_VALUE_GENERAL_ITEMVIEW_LIST)
		init_listView(false);
	else
		init_blockView(false);

	// Check if page redirected from other source
	var customerId = $.trim( localStorage.getItem(OPEN_FROM_SEARCH_CUSTOMER_ID) );
	var billingId = $.trim( localStorage.getItem(OPEN_FROM_SEARCH_BILLING_ID) );
	
	if (customerId != '') {
		// Reset 
		localStorage.setItem(OPEN_FROM_SEARCH_CUSTOMER_ID, '');
		
		var requestBody = {
			'appName': APP_NAME_POS,
			'customerId': $.trim(customerId),
			'fullBean': true	
		};	

		var params = new Object();
		params.customerId = $.trim(customerId);
		
		tycheesdb_api_getCustomerById(requestBody, module_init_openCustomer_postHandler, params);
	}	
	else
	if (billingId != '') {
		// Reset
		localStorage.setItem(OPEN_FROM_SEARCH_BILLING_ID, '');
		// Request Object
		var requestBody = {
			'appName': APP_NAME_ALL,
			'billingId': billingId,
			'fullBean': true	
		};	

		var params = new Object();
		params.billingId = billingId;
		
		tycheesdb_api_getBillingById(requestBody, module_init_openBilling_postHandler, params);
	} else {
		// Init Panels
		bil001_menuPanel_initBilling();
		// Hide Spinner
		$('#module_spinner').hide();
		$('#main-content').show();
	}
} // .end of module_post_init

function module_init_openCustomer_postHandler(success, responseObj, params) {
	if (success==false)
		return false;
	
	if (responseObj.customerObj != null) {
		// Assign customer object
		params.customerObj = responseObj.customerObj;
		// New Billing
		bil001_menuPanel_newBilling(module_init_openCustomer_afterBillingCreated, params);
	} else {
		tycheesLogger_showToast("error", "Error", "Invalid billing object found.")
	}
} // .end of module_init_openCustomer_postHandler

function module_init_openCustomer_afterBillingCreated(params) {
	
	// Update Customer
	params.customerObj.lastBillingId = global_billingObj.id;
	params.customerObj.lastBillingNo = global_billingObj.billingNo;
	// Save
	tycheesIO_saveBean(params.customerObj);
	
	// Assign customer to billing
	global_billingObj.customerId = params.customerObj.id;
	global_billingObj.customerName = tycheesBean_person_getFullName(params.customerObj);
	
	// Auto-save Billing
	bil001_menuPanel_save();
	
	// Hide Spinner
	$('#module_spinner').hide();
	$('#main-content').show();
	
	// Update page UI
	bil001_show();
} // .end of module_init_openCustomer_postHandler

function module_init_openBilling_postHandler(success, responseObj, params) {
	if (success==false)
		return false;
	
	if (responseObj.billingObj == null) {
		tycheesLogger_showToast("error", "Error", "Invalid billing object found.");
	} else {
		// Assign objects to global scope
		global_billingObj = responseObj.billingObj;
		
		// Hide Spinner
		$('#module_spinner').hide();
		$('#main-content').show();
		
		// Update page UI
		bil001_show();
	}
} // .end of sea001_mw000_openBilling_postHandler

/**
 * Call to save data in IDB, to remote DB immediately.
 */
function module_sync() {
	//tycheesdb_syncDatabaseNow(APP_NAME_POS);
} // .end of module_sync

function onTransactionCompleted(actionName) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

function module_showModalWindow(selectorId, stickToTop) {
	// Show Modal Window
	$('#' + selectorId).modal({
		backdrop: 'static',
		keyboard: false
	});
	// Move Modal Window to top of browser window
	if (stickToTop)
		$($('#' + selectorId).children()[0]).css('margin-top', '10px');
} // .end of module_showModalWindow

function module_closeModalWindow(selectorId) {

	$("#" + selectorId).modal("hide");
} // .end of module_closeModalWindow

function bil001_isBillingEditable() {
	if (global_billingObj == null)
		return false;
	
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_NEW ||
		global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_OPEN ||
		global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_NEW ||
		global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_OPEN) {
		
		return true;
	} else {
		return false;
	}
} // .end of bil001_isBillingEditable

function bil001_show() {		
	bil001_menuPanel_show();
	bil001_cartPanel_show();
	bil001_paymentPanel_show();
	bil001_mansoryPanel_show();
	bil001_dataTablePanel_show();
} // .end of bil001_show
