function module_initApp() {
	tycheesLogger_logInfo("BEGIN 10", "module_initApp");

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();
	// Call to update UI
	page_updateUI();

	// Check if page redirected from other source
	var categoryId = $.trim( localStorage.getItem(OPEN_FROM_SEARCH_CATEGORY_ID) );
	var itemId = $.trim( localStorage.getItem(OPEN_FROM_SEARCH_ITEM_ID) );

	// If parameters valid, then proceed to show
	if (categoryId != '' && itemId == '') {
		// Reset
		localStorage.setItem(OPEN_FROM_SEARCH_CATEGORY_ID, '');
		localStorage.setItem(OPEN_FROM_SEARCH_ITEM_ID, '');
		
		global_openOnPageLoad_byCategory = true;
		global_openOnPageLoad_categoryId = categoryId;
	}
	if (categoryId != '' && itemId != '') {
		// Reset
		localStorage.setItem(OPEN_FROM_SEARCH_CATEGORY_ID, '');
		localStorage.setItem(OPEN_FROM_SEARCH_ITEM_ID, '');
		
		global_openOnPageLoad_byItem = true;
		global_openOnPageLoad_categoryId = categoryId;
		global_openOnPageLoad_itemId = itemId;
	}

	// Call function in inventory-item-main.jsp
	loadUI_custom();
	// Init Language Pack
	tycheesCommon_initI18N(tycheesCommon_getConsoleBox() + '/inventory/inv002/view/');
	// Stop page loading indicator
	tycheesOverlay_stopShortProgress();
	tycheesOverlay_stopLongProgress();
	// Post Init
	tycheesCommon_onModulePostInit();
	
	tycheesLogger_logInfo("END 8", "module_initApp");
} // .end of initApp

/**
 * Call to save data in IDB, to remote DB immediately.
 */
function module_sync() {
	//tycheesdb_syncDatabaseNow(APP_NAME_INVENTORY);
} // .end of module_sync

function onTransactionCompleted(actionName, nextPage, returnArray) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

/**
 * Update the UI of whole page.
 */
function page_updateUI() {
	segment01_updateUI();
} // .end of page_updateUI

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
