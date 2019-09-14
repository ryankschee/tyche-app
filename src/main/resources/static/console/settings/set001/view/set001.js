function module_initApp() {
	console.log('[module_initApp] - BEGIN');

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();
	// Call to update UI
	set001_updateUI();
	// Init language pack
	tycheesCommon_initI18N();
	// Call function in inventory-item-main.jsp
	loadUI_custom();
	// Validate identity
	module_validateIdentity();
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
	//tycheesdb_syncDatabaseNow(APP_NAME_SETTINGS);
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

function onTransactionCompleted(actionName) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

/**
 * Update the UI of whole page.
 */
function set001_updateUI() {

} // .end of set001_updateUI

function module_validateIdentity()
{
	var placeObj = tycheesCommon_getCurrentPlaceObject(); 
		
	var userPlaceRoleObj;
	$.each(placeObj.roleList, function(i, roleObj) {
		if ($.trim(roleObj.userId) == tycheesCommon_getCurrentUserId()) {
			userPlaceRoleObj = roleObj;
		}
	});
	
	var placeAccessObj;
	$.each(placeObj.accessList, function(i, accessObj) {
		if ($.trim(accessObj.roleName) == $.trim(userPlaceRoleObj.role)) {
			placeAccessObj = accessObj;
		}
	});

	var functionSettingsAccessible = false;
	$.each(placeAccessObj.propertiesList, function(i, accessPropObj) {
		if (accessPropObj.propKey == ModuleConstants.MODULE_SETTINGS_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionSettingsAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
	});
	
	if (functionSettingsAccessible) {
		$('#set001_sidebar_menu_01').show();
		$('#set001_sidebar_menu_02').show();
		$('#set001_sidebar_menu_03').show();
		$('#set001_sidebar_menu_04').show();
		$('#set001_sidebar_menu_document').show();
		$('#set001_sidebar_menu_20').show();
		$('#set001_sidebar_menu_21').show();
		$('#set001_sidebar_menu_31').show();
	} else {
		$('#set001_sidebar_menu_01').hide();
		$('#set001_sidebar_menu_02').hide();
		$('#set001_sidebar_menu_03').hide();
		$('#set001_sidebar_menu_04').hide();
		$('#set001_sidebar_menu_document').hide();
		$('#set001_sidebar_menu_20').hide();
		$('#set001_sidebar_menu_21').show();
		$('#set001_sidebar_menu_31').hide();
	}
} // .end of module_validateIdentity

/**
 * Update the UI of whole page.
 */
function set001_executeAction(actionName) {
	if (actionName == SET001_ACTION_SELECT_GENERAL) {
		set001_00_updateUI();
		set001_01_hide();
		set001_02_hide();
		set001_03_hide();
		set001_04_hide();
		set001_document_hide();
		set001_20_hide();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_BILLING) {
		set001_00_hide();
		set001_01_updateUI();
		set001_02_hide();
		set001_03_hide();
		set001_04_hide();
		set001_document_hide();
		set001_20_hide();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_INVENTORY) {
		set001_00_hide();
		set001_01_hide();
		set001_02_updateUI();
		set001_03_hide();
		set001_04_hide();
		set001_document_hide();
		set001_20_hide();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_CUSTOMER) {
		set001_00_hide();
		set001_01_hide();
		set001_02_hide();
		set001_03_updateUI();
		set001_04_hide();
		set001_document_hide();
		set001_20_hide();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_EMPLOYEE) {
		set001_00_hide();
		set001_01_hide();
		set001_02_hide();
		set001_03_hide();
		set001_04_updateUI();
		set001_document_hide();
		set001_20_hide();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_DOCUMENT) {
		set001_00_hide();
		set001_01_hide();
		set001_02_hide();
		set001_03_hide();
		set001_04_hide();
		set001_document_updateUI();
		set001_20_hide();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_STORE) {
		set001_00_hide();
		set001_01_hide();
		set001_02_hide();
		set001_03_hide();
		set001_04_hide();
		set001_document_hide();
		set001_20_updateUI();
		set001_21_hide();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_USER) {
		set001_00_hide();
		set001_01_hide();
		set001_02_hide();
		set001_03_hide();
		set001_04_hide();
		set001_document_hide();
		set001_20_hide();
		set001_21_updateUI();
		set001_31_hide();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', '#FFFFFF');
		$('#set001_sidebar_menu_31').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_ACTION_SELECT_SEARCH) {
		set001_00_hide();
		set001_01_hide();
		set001_02_hide();
		set001_03_hide();
		set001_04_hide();
		set001_document_show();
		set001_20_hide();
		set001_21_hide();
		set001_31_updateUI();

		$('#set001_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_sidebar_menu_document').css('background-color', 'transparent');
		$('#set001_sidebar_menu_20').css('background-color', 'transparent');
		$('#set001_sidebar_menu_21').css('background-color', 'transparent');
		$('#set001_sidebar_menu_31').css('background-color', '#FFFFFF');
	}
	else {
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_executeAction
