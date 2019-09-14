function module_initApp() {
	console.log('[module_initApp] - BEGIN 1');

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();
	// Call to update UI
	das001_updateUI();
	//das001_row01_updateUI();
	//das001_row02_updateUI();
	//das001_row03_updateUI();    
	das_portlet_calendar_updateUI();
	das_portlet_chart_orders_updateUI();	
	das_portlet_summary_newOrders_updateUI();
	das_portlet_summary_sales_updateUI();
	das_portlet_summary_visitors_updateUI();
	// Call function in inventory-item-main.jsp
	loadUI_custom();
	// Init language pack
	tycheesCommon_initI18N(tycheesCommon_getConsoleBox() + '/dashboard/das001/view/');
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
	//tycheesdb_syncDatabaseNow(APP_NAME_DASHBOARD);
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

function onTransactionCompleted(actionName, nextPage, returnArray) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

/**
 * Update the UI of whole page.
 */
function das001_updateUI() {

} // .end of das001_updateUI

/**
 * Update the UI of whole page.
 */
function das001_executeAction(actionName) {
	/*
	if (actionName == INV002_ACTION_SELECT_CRM)
	{
		// Hide VRM
		inv002_02_hide();
		// Show CRM
		inv002_01_updateUI();
	}
	
	if (actionName == INV002_ACTION_SELECT_VRM)
	{
		// Hide CRM
		inv002_01_hide();
		// Show VRM
		inv002_02_updateUI();
	}
	*/
} // .end of inv002_executeAction
