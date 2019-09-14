
var bil002_loadDocumentsDone = false;
var bil002_loadCategoriesDone = false;
var bil002_loadItemsDone = false;
var bil002_loadBucketsDone = false;

var bil002_categoryList = [];
var bil002_itemList = [];

function module_initApp() {
	tycheesLogger_logInfo('module_initApp', 'BEGIN 003');

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
	
	tycheesLogger_logInfo('module_initApp', 'END');
} // .end of initApp

function module_init() {
	$('#main-content').hide();
	$('#module_spinner').show();
	$('#module_spinner_text').html('loading categories...');

	// Reset
	bil002_loadDocumentsDone = false;
	bil002_loadCategoriesDone = false;
	bil002_loadItemsDone = false;
	
	// Load data
	bil002_loadDocuments();	
	bil002_loadCategories();	
	bil002_loadItems();
	bil002_loadBuckets();
} // .end of module_init

function bil002_loadDocuments() {
	var requestBody = new Object();
	var params = new Object();
	
	tycheesdb_api_getDocumentsByPlace(requestBody, bil002_loadDocuments_postHandler, params);
} // .end of bil002_loadDocuments

function bil002_loadDocuments_postHandler(success, responseObj, params) {
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'bil002_loadDocuments_postHandler');
		$('#module_spinner_text').append('<br>Error loading documents.');
		return false;
	}
	
	bil002_loadDocumentsDone = true;	
	Cached_setDocumentList(responseObj.documentList);
} // .end of bil002_loadDocuments_postHandler

function bil002_loadCategories() {
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'viewBean': true,
		'filterByPosVisible': false,
		'posVisible': false
	};

	var params = new Object();

	tycheesdb_api_listCategoryByPlace(requestBody, bil002_loadCategories_postHandler, params);
} // .end of bil002_loadCategories

function bil002_loadCategories_postHandler(success, responseObj, params) {
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'bil002_loadCategories_postHandler');
		$('#module_spinner_text').append('<br>Error loading categories.');
		return false;
	}
	
	bil002_loadCategoriesDone = true;
	bil002_categoryList = responseObj.viewList;
	
	module_post_init();
} // .end of bil002_loadCategories_postHandler

function bil002_loadItems() {
	$('#module_spinner_text').html('loading ...');

	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'viewBean': true,
		'filterByPosVisible': true,
		'posVisible': true
	};
	var params = new Object();

	tycheesdb_api_getItemsByPlace(requestBody, bil002_loadItems_postHandler, params);
} // .end of bil002_loadItems

function bil002_loadItems_postHandler(successFlag, responseObj, params) {
	if (successFlag == false) {
		tycheesLogger_logError('Ajax Error.', 'bil002_loadItems_postHandler');
		$('#module_spinner_text').append('<br>Error loading items.');
		return false;
	}

	bil002_loadItemsDone = true;
	bil002_itemList = responseObj.viewList;

	localStorage.setItem(LOCAL_STORAGE_INIT_POS, true);

	module_post_init();
} // .end of bil002_loadItems_postHandler


function bil002_loadBuckets() {
	$('#module_spinner_text').html('loading ... ');

	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': true,
		'filterByBucketStatus': true,
		'bucketStatus': BillingConstants.BUCKET_STATUS_RESERVED + ',' + BillingConstants.BUCKET_STATUS_SERVING
	};
	var params = new Object();

	tycheesdb_api_getBillingBucketsByPlace(requestBody, bil002_loadBuckets_postHandler, params);
} // .end of bil002_loadBuckets

function bil002_loadBuckets_postHandler(successFlag, responseObj, params) {
	if (successFlag == false) {
		$('#module_spinner_text').html('Error loading buckets.');
		return false;
	}

	// Add to cache
	Cached_setBillingBucketList(responseObj.billingBucketList);
	// Set flag
	bil002_loadBucketsDone = true;
	
	module_post_init();
} // .end of bil002_loadBuckets_postHandler

function module_post_init() {
	if (!bil002_loadCategoriesDone || !bil002_loadItemsDone || !bil002_loadBucketsDone)
		return false;

	tycheesLogger_logInfo('BEGIN', 'module_post_init');
	
	bil002_cartPanel_masonryView_updateUI();

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	$.each(placeObj.layoutList, function(i, layoutObj) {
		if (layoutObj.defaultLayout) {
			global_placeLayoutObj = layoutObj;
		}
	});

	if (global_placeLayoutObj == null) {
		tycheesLogger_logError('Invalid layout object found.', 'module_init');
	}
	else {
		bil002_tablePanel_canvas_repaint();
	}

	$('#bil002_tablePanel').show();

	$('#module_spinner').hide();
	$('#main-content').show();	
} // .end of module_post_init

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

function bil002_incrementBucketLine(buttonElement, bucketLineId) {
	if ($.trim(bucketLineId) == '')
		return false;

	$.each(global_billingBucketObj.lineList, function(i, lineObj) {
		if (lineObj.id == bucketLineId) {
			$(buttonElement).ladda().ladda('start');
			
			// Check if increment allowed	
			var requestBody = {
				'appName': APP_NAME_POS,
				'itemId': lineObj.itemId,
				'fullBean': true
			};
			var params = new Object();
			params.buttonElement = buttonElement;
			params.bucketLineObj = lineObj;

			tycheesdb_api_getItemById(requestBody, bil002_incrementBucketLine_postHandler, params);
			// Stop iteration
			return false;
		}
	});
} // .end of bil002_incrementBucketLine

function bil002_incrementBucketLine_postHandler(success, responseObj, params) {
	
	// Finish Loading
	$(params.buttonElement).ladda().ladda('stop');
	
	if (success == false) {
		tycheesLogger_showToast('error', 'System Error', 'Please contact our System Administrator for this issue. Thanks!');
		return false;
	}

	// If quantity allowed, reduce item from inventory (if quantity is not optional)
	if (responseObj.itemObj.quantityOptional == false && responseObj.itemObj.quantity < 1) {
		tycheesLogger_showToast('warning', 'Insufficient Quantity', 'This item has not enough quantity in stock.');
		return false;
	}

	// Save item
	responseObj.itemObj.quantity = responseObj.itemObj.quantity - 1;
	tycheesIO_saveBean(responseObj.itemObj);
	// Increment bucket line object
	params.bucketLineObj.quantity = params.bucketLineObj.quantity + 1;
	// Update UI
	bil002_sw001_updateUI_tab3();
	bil002_cartPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_bucketList();
	// Save bucket
	bil002_saveBucket();
} // .end of bil002_incrementBucketLine_postHandler

function bil002_decrementBucketLine(buttonElement, bucketLineId) {
	if ($.trim(bucketLineId) == '')
		return false;

	$.each(global_billingBucketObj.lineList, function(i, lineObj) {
		if (lineObj.id == bucketLineId) {
			if (lineObj.quantity == 0) {
				tycheesLogger_showToast('error', 'Request Aborted', 'This item has ZERO (0) in quantity. No further decrement allowed.');
			}
			else {
				$(buttonElement).ladda().ladda('start');
				
				// Check if increment allowed	
				var requestBody = {
					'appName': APP_NAME_POS,
					'itemId': lineObj.itemId,
					'fullBean': true
				};
				var params = new Object();
				params.buttonElement = buttonElement;
				params.bucketLineObj = lineObj;

				tycheesdb_api_getItemById(requestBody, bil002_decrementBucketLine_postHandler, params);
			}

			// Stop iteration
			return false;
		}
	});
} // .end of bil002_incrementBucketLine

function bil002_decrementBucketLine_postHandler(success, responseObj, params) {
	
	// Finish Loading
	$(params.buttonElement).ladda().ladda('stop');
	
	if (success == false) {
		tycheesLogger_showToast('error', 'System Error', 'Please contact our System Administrator for this issue. Thanks!');
		return false;
	}

	// Save item
	if (responseObj.itemObj.quantityOptional == false)
		responseObj.itemObj.quantity = responseObj.itemObj.quantity + 1;
	tycheesIO_saveBean(responseObj.itemObj);
	// Increment bucket line object
	params.bucketLineObj.quantity = params.bucketLineObj.quantity - 1;
	// Update UI
	bil002_sw001_updateUI_tab3();
	bil002_cartPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_bucketList();
	// Save bucket
	bil002_saveBucket();
} // .end of bil002_incrementBucketLine_postHandler

function bil002_removeBucketLine(buttonElement, bucketLineId) {
	if ($.trim(bucketLineId) == '')
		return false;

	$.each(global_billingBucketObj.lineList, function(i, lineObj) {
		if (lineObj.id == bucketLineId) {
			$(buttonElement).ladda().ladda('start');
			
			// Check if increment allowed	
			var requestBody = {
				'appName': APP_NAME_POS,
				'itemId': lineObj.itemId,
				'fullBean': true
			};
			var params = new Object();
			params.buttonElement = buttonElement;
			params.bucketLineObj = lineObj;

			tycheesdb_api_getItemById(requestBody, bil002_removeBucketLine_postHandler, params);

			// Stop iteration
			return false;
		}
	});
} // .end of bil002_removeBucketLine

function bil002_removeBucketLine_postHandler(success, responseObj, params) {
	
	// Finish Loading
	$(params.buttonElement).ladda().ladda('stop');
	
	if (success == false) {
		tycheesLogger_showToast('error', 'System Error', 'Please contact our System Administrator for this issue. Thanks!');
		return false;
	}

	// Save item
	if (responseObj.itemObj.quantityOptional == false)
		responseObj.itemObj.quantity = responseObj.itemObj.quantity + params.bucketLineObj.quantity;
	tycheesIO_saveBean(responseObj.itemObj);
	// Remove line object
	Cached_deleteBean(params.bucketLineObj);
	// Update UI
	bil002_sw001_updateUI_tab3();
	bil002_cartPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_bucketList();
	// Save bucket
	bil002_saveBucket();
} // .end of bil002_removeBucketLine_postHandler

function bil002_createBucket(placeLayoutComponent, status) {
	if (placeLayoutComponent == null) {
		tycheesLogger_logError('placeLayoutComponent is null.', 'bil002_createBucket');
		return false;
	}

	var bucketObj = createNew_BillingBucket();
	bucketObj.layoutComponentId = placeLayoutComponent.id;
	bucketObj.bucketName = placeLayoutComponent.name;
	bucketObj.bucketStatus = status==null ? BillingConstants.BUCKET_STATUS_SERVING : status;
	bucketObj.paxCount = 0;
	bucketObj.paxMaxCount = placeLayoutComponent.paxCount;
	bucketObj.seatedOn = tycheesDateTime_getCurrentTimeInMillis();
	bucketObj.orderedOn = null;
	bucketObj.completedOn = null;
	bucketObj.leftOn = null;
	bucketObj.servedBy = tycheesCommon_getCurrentUserId();
	bucketObj.customerName = '';
	bucketObj.customerContact = '';
	bucketObj.reservedOn = null;
	bucketObj.reservedFrom = null;
	bucketObj.reservedTo = null;
	
	return bucketObj;
} // .end of bil002_createBucket

function bil002_cancelBucket() {
	if (global_billingBucketObj == null)
		return false;
	
	// Set Cancel status
	global_billingBucketObj.cancelledBy = tycheesCommon_getCurrentUserId();
	global_billingBucketObj.cancelledOn = tycheesDateTime_getCurrentTimeInMillis();
	Cached_deleteBean(global_billingBucketObj);
	
	// Save Bucket
	bil002_saveBucket();
	
	global_billingBucketObj = null;
} // .end of bil002_cancelBucket

function bil002_printBucket() {
	if (global_billingBucketObj == null)
		return false;
	
	mw_printBucket_show();
} // .end of bil002_printBucket

function bil002_saveBucket(syncNow) {
	if (global_billingBucketObj == null)
		return false;

	if (syncNow == null)
		syncNow = true;
	
	// Update Cache
	Cached_updateBillingBucket(global_billingBucketObj);
	// Save billing bucket
	tycheesIO_saveBean(global_billingBucketObj, syncNow);
} // .end of bil002_saveBucket

function bil002_saveBilling(syncNow) {
	if (global_billingObj == null)
		return false;

	if (syncNow == null)
		syncNow = true;
	
	// Recalculate Billing before SAVE
	billingCommon_calculateBilling(global_billingObj);
	// Update Cache
	Cached_updateBilling(global_billingObj);
	// Save billing
	tycheesIO_saveBean(global_billingObj, syncNow);
} // .end of bil002_saveBilling

