function module_initApp() {
	console.log('[module_initApp] - BEGIN 1');

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();
	// Call to update UI
	pla001_updateUI();

	// Call function in inventory-item-main.jsp
	loadUI_custom();
	// Init language pack
	tycheesCommon_initI18N();
	// Stop page loading indicator
	tycheesOverlay_stopShortProgress();
	tycheesOverlay_stopLongProgress();

	console.log('[module_initApp] - END');
} // .end of initApp

/**
 * Call to save data in IDB, to remote DB immediately.
 */
function module_sync() {
	//tycheesdb_syncDatabaseNow(APP_NAME_PLACE);
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

function onTransactionCompleted(returnArray, actionName) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

/**
 * Update the UI of whole page.
 */
function pla001_updateUI() {

} // .end of pla001_updateUI
