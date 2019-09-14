var rep001_subNodeTriggered = false;

function module_initApp() {
	console.log('[module_initApp] - BEGIN 4');

	// Init header
	tycheesCommon_loadUI_header();
	// Init sidebar
	tycheesCommon_loadUI_sidebar();
	// Call function in inventory-item-main.jsp
	loadUI_custom();
	// Init language pack
	tycheesCommon_initI18N();
	// Stop page loading indicator
	tycheesOverlay_stopShortProgress();
	tycheesOverlay_stopLongProgress();
	// Call to update UI
	rep001_updateUI();
	// Post Init
	tycheesCommon_onModulePostInit();
	
	console.log('[module_initApp] - END');
} // .end of initApp

function onTransactionCompleted(returnArray, actionName) {
	tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
	tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

function module_sync() {
	//tycheesdb_syncDatabaseNow(APP_NAME_REPORTS);
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

function rep001_init() {
	if (rep001_initialized == true)
		return false;

	rep001_initialized = true;
} // .end of rep001_init

function rep001_updateUI() {
	rep001_init();

} // .end of rep001_updateUI

function rep001_executeAction(actionName) {
	if (actionName == REP001_ACTION_SELECT_OVERVIEW) {
		rep001_00_updateUI();
		rep001_01_hide();
		rep001_02_hide();
		rep001_03_hide();

		$('#rep001_menu_1').css('background-color', '#FFFFFF');
		$('#rep001_menu_billing').css('background-color', 'transparent');
		$('#rep001_menu_3').css('background-color', 'transparent');
		$('#rep001_menu_4').css('background-color', 'transparent');
	}
	else
	if (actionName == REP001_ACTION_SELECT_BILLING) {
		$('#rep001_menu_billing_nodes').show();
		$('#rep001_menu_3_nodes').hide();

		$('#rep001_menu_billing').css('background-color', '#FFFFFF');
		$('#rep001_menu_3').css('background-color', 'transparent');
	}
	else
	if (actionName == REP001_ACTION_SELECT_INVENTORY) {
		$('#rep001_menu_billing_nodes').hide();
		$('#rep001_menu_3_nodes').show();

		$('#rep001_menu_billing').css('background-color', 'transparent');
		$('#rep001_menu_3').css('background-color', '#FFFFFF');
	}
	else
	if (actionName == REP001_ACTION_SELECT_RELATION) {
		rep001_00_hide();
		rep001_01_hide();
		rep001_02_hide();
		rep001_03_updateUI();

		$('#rep001_menu_1').css('background-color', 'transparent');
		$('#rep001_menu_billing').css('background-color', 'transparent');
		$('#rep001_menu_3').css('background-color', 'transparent');
		$('#rep001_menu_4').css('background-color', '#FFFFFF');
	}
	else {
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of rep001_executeAction

function rep001_selectMenu_billing()
{
	// If event triggered from sub-node, then discontinue here.
	if (rep001_subNodeTriggered) {
		rep001_subNodeTriggered = false;
		return false;
	}
	
	// de-Highlight sub-node
	$('#rep001_menu_billing_node_1').css('background-color', '#fff');
	$('#rep001_menu_billing_node_1').css('color', '#666');
	$($('#rep001_menu_billing_node_1').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_2').css('background-color', '#fff');
	$('#rep001_menu_billing_node_2').css('color', '#666');
	$($('#rep001_menu_billing_node_2').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_3').css('background-color', '#fff');
	$('#rep001_menu_billing_node_3').css('color', '#666');
	$($('#rep001_menu_billing_node_3').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_4').css('background-color', '#fff');
	$('#rep001_menu_billing_node_4').css('color', '#666');
	$($('#rep001_menu_billing_node_4').children()[0]).css('color', '#666');
	
	// Show/Hide nodes
	$('#rep001_menu_billing_nodes').show();
	$('#rep001_menu_relation_nodes').hide();
	$('#rep001_menu_inventory_nodes').hide();

	// Highlight/de-highlight nodes
	$('#rep001_menu_billing').css('background-color', '#FFFFFF');
	$('#rep001_menu_relation').css('background-color', 'transparent');
	$('#rep001_menu_inventory').css('background-color', 'transparent');
} // .end of rep001_selectMenu_billing

function rep001_selectMenu_billing_hide()
{
	rep001_01_00_hide();
	rep001_01_01_hide();
	rep001_01_02_hide();
	rep001_01_03_hide();
} // .end of rep001_selectMenu_billing_hide

function rep001_selectMenu_billing_overview()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Show/hide content panels
	rep001_01_00_updateUI();
	rep001_01_01_hide();
	rep001_01_02_hide();
	rep001_01_03_hide();
	
	// Hide other nodes
	rep001_selectMenu_relation_hide();
	rep001_selectMenu_inventory_hide();

	// Highlight sub-node
	$('#rep001_menu_billing_node_1').css('background-color', '#ed5565');
	$('#rep001_menu_billing_node_1').css('color', '#ffffff');
	$($('#rep001_menu_billing_node_1').children()[0]).css('color', '#ffffff');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_2').css('background-color', '#fff');
	$('#rep001_menu_billing_node_2').css('color', '#666');
	$($('#rep001_menu_billing_node_2').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_3').css('background-color', '#fff');
	$('#rep001_menu_billing_node_3').css('color', '#666');
	$($('#rep001_menu_billing_node_3').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_4').css('background-color', '#fff');
	$('#rep001_menu_billing_node_4').css('color', '#666');
	$($('#rep001_menu_billing_node_4').children()[0]).css('color', '#666');
} // .end of rep001_selectMenu_billing_overview

function rep001_selectMenu_billing_orders()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Show/hide content panels
	rep001_01_00_hide();
	rep001_01_01_updateUI();
	rep001_01_02_hide();
	rep001_01_03_hide();

	// Hide other nodes
	rep001_selectMenu_relation_hide();
	rep001_selectMenu_inventory_hide();

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_1').css('background-color', '#fff');
	$('#rep001_menu_billing_node_1').css('color', '#666');
	$($('#rep001_menu_billing_node_1').children()[0]).css('color', '#666');

	// Highlight sub-node
	$('#rep001_menu_billing_node_2').css('background-color', '#ed5565');
	$('#rep001_menu_billing_node_2').css('color', '#ffffff');
	$($('#rep001_menu_billing_node_2').children()[0]).css('color', '#ffffff');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_3').css('background-color', '#fff');
	$('#rep001_menu_billing_node_3').css('color', '#666');
	$($('#rep001_menu_billing_node_3').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_4').css('background-color', '#fff');
	$('#rep001_menu_billing_node_4').css('color', '#666');
	$($('#rep001_menu_billing_node_4').children()[0]).css('color', '#666');
} // .end of rep001_selectMenu_billing_orders

function rep001_selectMenu_billing_payment()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Show/Hide content panels
	rep001_01_00_hide();
	rep001_01_01_hide();
	rep001_01_02_updateUI();
	rep001_01_03_hide();

	// Hide other nodes
	rep001_selectMenu_relation_hide();
	rep001_selectMenu_inventory_hide();

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_1').css('background-color', '#fff');
	$('#rep001_menu_billing_node_1').css('color', '#666');
	$($('#rep001_menu_billing_node_1').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_2').css('background-color', '#fff');
	$('#rep001_menu_billing_node_2').css('color', '#666');
	$($('#rep001_menu_billing_node_2').children()[0]).css('color', '#666');

	// Highlight sub-node
	$('#rep001_menu_billing_node_3').css('background-color', '#ed5565');
	$('#rep001_menu_billing_node_3').css('color', '#ffffff');
	$($('#rep001_menu_billing_node_3').children()[0]).css('color', '#ffffff');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_4').css('background-color', '#fff');
	$('#rep001_menu_billing_node_4').css('color', '#666');
	$($('#rep001_menu_billing_node_4').children()[0]).css('color', '#666');	
} // .end of rep001_selectMenu_billing_payment

function rep001_selectMenu_billing_gst()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Show/hide content panel
	rep001_01_00_hide();
	rep001_01_01_hide();
	rep001_01_02_hide();
	rep001_01_03_updateUI();

	// Hide other nodes
	rep001_selectMenu_relation_hide();
	rep001_selectMenu_inventory_hide();

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_1').css('background-color', '#fff');
	$('#rep001_menu_billing_node_1').css('color', '#666');
	$($('#rep001_menu_billing_node_1').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_2').css('background-color', '#fff');
	$('#rep001_menu_billing_node_2').css('color', '#666');
	$($('#rep001_menu_billing_node_2').children()[0]).css('color', '#666');

	// de-Highlight sub-node
	$('#rep001_menu_billing_node_3').css('background-color', '#fff');
	$('#rep001_menu_billing_node_3').css('color', '#666');
	$($('#rep001_menu_billing_node_3').children()[0]).css('color', '#666');

	// Highlight sub-node
	$('#rep001_menu_billing_node_4').css('background-color', '#ed5565');
	$('#rep001_menu_billing_node_4').css('color', '#ffffff');
	$($('#rep001_menu_billing_node_4').children()[0]).css('color', '#ffffff');
} // .end of rep001_selectMenu_billing_gst

function rep001_selectMenu_relation()
{
	// If event triggered from sub-node, then discontinue here.
	if (rep001_subNodeTriggered) {
		rep001_subNodeTriggered = false;
		return false;
	}
	
	// highlight sub-nodes
	$('#rep001_menu_relation_node_1').css('background-color', '#fff');
	$('#rep001_menu_relation_node_1').css('color', '#666');
	$($('#rep001_menu_relation_node_1').children()[0]).css('color', '#666');
	
	// Show/Hide nodes
	$('#rep001_menu_billing_nodes').hide();
	$('#rep001_menu_relation_nodes').show();
	$('#rep001_menu_inventory_nodes').hide();

	// Highlight/de-highlight nodes
	$('#rep001_menu_billing').css('background-color', 'transparent');
	$('#rep001_menu_relation').css('background-color', '#FFFFFF');
	$('#rep001_menu_inventory').css('background-color', 'transparent');
} // .end of rep001_selectMenu_relation

function rep001_selectMenu_relation_hide()
{
	rep001_relationOverview_hide();
} // .end of rep001_selectMenu_relation_hide

function rep001_selectMenu_relation_overview()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Show content panel
	rep001_relationOverview_updateUI();
	
	// Hide other nodes
	rep001_selectMenu_billing_hide();
	rep001_selectMenu_inventory_hide();
	
	// Highlight sub-node
	$('#rep001_menu_relation_node_1').css('background-color', '#ed5565');
	$('#rep001_menu_relation_node_1').css('color', '#ffffff');
	$($('#rep001_menu_relation_node_1').children()[0]).css('color', '#ffffff');
} // .end of rep001_selectMenu_relation_overview

function rep001_selectMenu_inventory()
{
	// If event triggered from sub-node, then discontinue here.
	if (rep001_subNodeTriggered) {
		rep001_subNodeTriggered = false;
		return false;
	}
	
	// De-highlight sub-node
	$('#rep001_menu_inventory_node_1').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_1').css('color', '#666');
	$($('#rep001_menu_inventory_node_1').children()[0]).css('color', '#666');

	// De-highlight sub-node
	$('#rep001_menu_inventory_node_2').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_2').css('color', '#666');
	$($('#rep001_menu_inventory_node_2').children()[0]).css('color', '#666');

	// De-highlight sub-node
	$('#rep001_menu_inventory_node_3').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_3').css('color', '#666');
	$($('#rep001_menu_inventory_node_3').children()[0]).css('color', '#666');
	
	// Show/hide nodes
	$('#rep001_menu_billing_nodes').hide();
	$('#rep001_menu_relation_nodes').hide();
	$('#rep001_menu_inventory_nodes').show();

	// Highligh/de-highlight nodes
	$('#rep001_menu_billing').css('background-color', 'transparent');
	$('#rep001_menu_relation').css('background-color', 'transparent');
	$('#rep001_menu_inventory').css('background-color', '#FFFFFF');
} // .end of rep001_selectMenu_inventory

function rep001_selectMenu_inventory_hide()
{
	rep001_inventoryOverview_hide();
} // .end of rep001_selectMenu_inventory_hide

function rep001_selectMenu_inventory_overview()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Hide other nodes
	rep001_selectMenu_billing_hide();
	rep001_selectMenu_relation_hide();

	// Show/Hide content panel
	rep001_inventoryOverview_updateUI();
	rep001_inventoryItemVariants_hide();
	rep001_inventorySuppliers_hide();
		
	// Highlight sub-node
	$('#rep001_menu_inventory_node_1').css('background-color', '#ed5565');
	$('#rep001_menu_inventory_node_1').css('color', '#ffffff');
	$($('#rep001_menu_inventory_node_1').children()[0]).css('color', '#ffffff');

	// De-highlight sub-node
	$('#rep001_menu_inventory_node_2').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_2').css('color', '#666');
	$($('#rep001_menu_inventory_node_2').children()[0]).css('color', '#666');

	// De-highlight sub-node
	$('#rep001_menu_inventory_node_3').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_3').css('color', '#666');
	$($('#rep001_menu_inventory_node_3').children()[0]).css('color', '#666');
} // .end of rep001_selectMenu_inventory_overview

function rep001_selectMenu_inventory_itemVariants()
{
	// Set flag
	rep001_subNodeTriggered = true;
	
	// Hide other nodes
	rep001_selectMenu_billing_hide();
	rep001_selectMenu_relation_hide();

	// Show/Hide content panel
	rep001_inventoryOverview_hide();
	rep001_inventoryItemVariants_updateUI();
	rep001_inventorySuppliers_hide();
	
	// de-highlight sub-node
	$('#rep001_menu_inventory_node_1').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_1').css('color', '#666');
	$($('#rep001_menu_inventory_node_1').children()[0]).css('color', '#666');

	// highlight sub-node
	$('#rep001_menu_inventory_node_2').css('background-color', '#ed5565');
	$('#rep001_menu_inventory_node_2').css('color', '#ffffff');
	$($('#rep001_menu_inventory_node_2').children()[0]).css('color', '#ffffff');

	// de-highlight sub-node
	$('#rep001_menu_inventory_node_3').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_3').css('color', '#666');
	$($('#rep001_menu_inventory_node_3').children()[0]).css('color', '#666');
} // .end of rep001_selectMenu_inventory_itemVariants

function rep001_selectMenu_inventory_suppliers()
{
	// set flag
	rep001_subNodeTriggered = true;
	
	// Hide other nodes
	rep001_selectMenu_billing_hide();
	rep001_selectMenu_relation_hide();

	// Show/Hide content panel
	rep001_inventoryOverview_hide();
	rep001_inventoryItemVariants_hide();
	rep001_inventorySuppliers_updateUI();

	// de-highlight sub-node
	$('#rep001_menu_inventory_node_1').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_1').css('color', '#666');
	$($('#rep001_menu_inventory_node_1').children()[0]).css('color', '#666');

	// de-highlight sub-node
	$('#rep001_menu_inventory_node_2').css('background-color', '#fff');
	$('#rep001_menu_inventory_node_2').css('color', '#666');
	$($('#rep001_menu_inventory_node_2').children()[0]).css('color', '#666');

	// highlight sub-node
	$('#rep001_menu_inventory_node_3').css('background-color', '#ed5565');
	$('#rep001_menu_inventory_node_3').css('color', '#ffffff');
	$($('#rep001_menu_inventory_node_3').children()[0]).css('color', '#ffffff');
} // .end of rep001_selectMenu_inventory_suppliers

