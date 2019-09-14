
function module_initApp() {
	console.log('[module_initApp] - BEGIN');

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();
	// Call to update UI
	rel001_updateUI();

	// Check if page redirected from other source
	var customerId = $.trim( localStorage.getItem(OPEN_FROM_SEARCH_CUSTOMER_ID) );
	// If parameters valid, then proceed to show
	if (customerId != '') {
		// Reset
		localStorage.setItem(OPEN_FROM_SEARCH_CUSTOMER_ID, '');
		
		global_openOnPageLoad_byCustomer = true;
		global_openOnPageLoad_customerId = customerId;
		
		rel001_selectCustomerModule();
	}

	// Call function in inventory-item-main.jsp
	loadUI_custom();
	// Init language pack
	tycheesCommon_initI18N();
	// Stop page loading indicator
	tycheesOverlay_stopShortProgress();
	tycheesOverlay_stopLongProgress();
	// Post Init
	tycheesCommon_onModulePostInit();
	
	console.log('[module_initApp] - END');
} // .end of initApp

/**
 * Call to save data in IDB, to remote DB immediately.
 */
function module_sync() {
	//tycheesdb_syncDatabaseNow(APP_NAME_RELATION);
} // .end of module_sync

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

function onTransactionCompleted(returnArray, actionName) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

/**
 * Update the UI of whole page.
 */
function rel001_updateUI() {

} // .end of page_updateUI

function rel001_selectEmployeeModule() {
	rel001_employeePanel_show();
	rel001_customerPanel_hide();

	$('#rel001_sidebar_menu_employee').css('background-color', '#FFFFFF');
	$('#rel001_sidebar_menu_customer').css('background-color', 'transparent');
} // .end of rel001_selectEmployeeModule

function rel001_selectCustomerModule() {
	rel001_employeePanel_hide();
	rel001_customerPanel_show();

	$('#rel001_sidebar_menu_employee').css('background-color', 'transparent');
	$('#rel001_sidebar_menu_customer').css('background-color', '#FFFFFF');
} // .end of rel001_selectCustomerModule

