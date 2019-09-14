/**
 * Initiate new billing and transaction objects into cache.
 */
function page_ctrl_closeBilling() {
	// Reset objects
	var billingObj = createNew_Billing();
	billingObj.id = '';
	billingObj.billingNo = '';
	billingObj.placeId = '';
	billingObj.billingDate = tycheesDateTime_getCurrentTimeInMillis();

	// RESET: Assign objects to global scope
	global_billingObj = billingObj;

	// Upadte UI > Override Open Billing UI 
	page_view_openBilling();
} // .end of page_ctrl_closeBilling

/**
 * Initiate new billing and transaction objects into cache.
 */
function bil002_ctrl_createNewBilling(bucketId) {
	// Reset objects
	var billingObj = createNew_Billing();
	billingObj.placeId = tycheesCommon_getCurrentPlaceId();
	billingObj.bucketId = $.trim(bucketId);
	billingObj.billingNo = consoleCommon_getNextBillingNo();
	billingObj.billingDate = tycheesDateTime_getCurrentTimeInMillis();
	billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_NEW;
	billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_NEW;

	var workflowObj = createNew_BillingWorkflow();
	workflowObj.billingId = billingObj.id;
	workflowObj.moduleId = ModuleConstants.MODULE_BILLING;
	workflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
	billingObj.workflowList.push(workflowObj);

	var workflowEventObj = createNew_BillingWorkflowEvent();
	workflowEventObj.workflowId = workflowObj.id;
	workflowEventObj.seqno = 1;
	workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_NEW;
	workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_NEW;
	workflowEventObj.eventDescription = 'BILLING BEGIN';
	workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
	workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
	workflowObj.eventList.push(workflowEventObj);

	var calendarObj = createNew_CommonCalendar();
	calendarObj.foreignId = billingObj.id;
	billingObj.calendarList.push(calendarObj);

	// Assign objects to global scope
	global_billingObj = billingObj;
} // .end of bil002_ctrl_createNewBilling

function bil001_ctrl_getItemFromInventory(itemId, billingId, billingLineId, quantity) 
{
	// Update item in cache
	$.each(bil001_itemList, function(i, itemObj) {
		if (itemId == itemObj.id) {
			itemObj.quantity -= quantity;
			if (!itemObj.quantityOptional) {
				$('#item-quantity-'+itemId).html(itemObj.quantity);
			} 
		}
	});
				
	var requestBody = new Object();
	requestBody.itemId = itemId;
	requestBody.billingId = billingId;	
	requestBody.billingLineId = billingLineId;
	requestBody.quantity = quantity;
	requestBody.reason = 'Added into Billing';
	
	var params = new Object();
	
	tycheesdb_api_decreaseItem(requestBody, bil001_ctrl_getItemFromInventory_postHandler, params);	
} // .end of bil001_ctrl_getItemFromInventory

function bil001_ctrl_getItemFromInventory_postHandler(success, responseObj, params)
{
	tycheesLogger_logDebug('success: ' + success, 'bil001_ctrl_getItemFromInventory_postHandler');
} // .end of bil001_ctrl_getItemFromInventory_postHandler

function bil001_ctrl_putItemIntoInventory(itemId, billingId, billingLineId, quantity) 
{
	// Update item in cache
	$.each(bil001_itemList, function(i, itemObj) {
		if (itemId == itemObj.id) {
			itemObj.quantity += quantity;
			if (!itemObj.quantityOptional) {
				$('#item-quantity-'+itemId).html(itemObj.quantity);
			} 
		}
	});
	
	var requestBody = new Object();
	requestBody.itemId = itemId;
	requestBody.billingId = billingId;	
	requestBody.billingLineId = billingLineId;
	requestBody.quantity = quantity;
	requestBody.reason = 'Removed from Billing';
	
	var params = new Object();
	
	tycheesdb_api_increaseItem(requestBody, bil001_ctrl_putItemIntoInventory_postHandler, params);	
} // .end of bil001_ctrl_putItemIntoInventory

function bil001_ctrl_putItemIntoInventory_postHandler(success, responseObj, params)
{
	tycheesLogger_logDebug('success: ' + success, 'bil001_ctrl_putItemIntoInventory_postHandler');
} // .end of bil001_ctrl_putItemIntoInventory_postHandler


/**
 * Connect to Inventory System - Update Transaction when billing details change.
 */
/*function bil002_ctrl_updateInventory(itemId, operator, changeVal) {
	var itemObj = Cached_getItemById(itemId, bil002_itemList);
	var availability = itemObj.availability;
	var itemQuantity = itemObj.quantity;

	// IF item is always available type, then skip.
	if (availability == InventoryConstants.QUANTITY_AVAILABLE && itemQuantity <= 0)
		return false;

	// revert transaction from inventory
	revertChanges(global_transactionObj);

	// Create/Update transaction line
	updateTransaction_fromBilling(itemId, operator, changeVal, global_transactionObj);

	// apply transaction into inventory
	applyChanges(global_transactionObj);

	// Update UI
	if (global_currentItemViewType == ITEM_VIEW_TYPE_BLOCK)
		page_updateItemInMasonry(itemObj);
	else
	if (global_currentItemViewType == ITEM_VIEW_TYPE_LIST)
		page_updateItemInList(itemObj);
	else
		tycheesLogger_logError('Error: Unidentified view type [' + global_currentItemViewType + '] found.', 'bil002_ctrl_updateInventory');

	var itemInList = false;
	$.each(global_updatedItemList, function(i, updatedItemObj) {
		if (updatedItemObj.id == itemId)
			itemInList = true;
	});
	if (itemInList == false)
		global_updatedItemList.push(itemObj);
} // .end of bil002_ctrl_updateInventory
*/
/**
 * Connect to Inventory System - Update Transaction when billing details change.
 */
/*function page_ctrl_deleteInventory(itemId) {
	// revert transaction from inventory
	revertChanges(global_transactionObj, global_billingObj);

	// Create/Update transaction line
	deleteTransaction_fromBilling(itemId, global_transactionObj);

	// apply transaction into inventory
	applyChanges(global_transactionObj, global_billingObj);

	// Update UI
	var itemObj = Cached_getItemById(itemId, bil002_itemList);
	if (global_currentItemViewType == ITEM_VIEW_TYPE_BLOCK)
		page_updateItemInMasonry(itemObj);
	else
	if (global_currentItemViewType == ITEM_VIEW_TYPE_LIST)
		page_updateItemInList(itemObj);
	else
		tycheesLogger_logError('Error: Unidentified view type [' + global_currentItemViewType + '] found.', 'page_ctrl_deleteInventory');

	var itemInList = false;
	$.each(global_updatedItemList, function(i, updatedItemObj) {
		if (updatedItemObj.id == itemId)
			itemInList = true;
	});
	if (itemInList == false)
		global_updatedItemList.push(itemObj);
} // .end of page_ctrl_deleteInventory
*/
/*
function bil002_ctrl_saveBilling() {
	if (global_billingObj == null)
		return false;

	// Recalculate Billing before SAVE
	billingCommon_calculateBilling(global_billingObj);

	// Save billing to LocalDB
	tycheesIO_saveBean(global_billingObj, false);

	// Save transaction to LocalDB
	tycheesIO_saveBean(global_transactionObj, false);

	// Call save explicitly 
	module_sync();

	// Update Billing object & Transaction object
	Cached_updateBilling(global_billingObj);
	Cached_updateTransaction(global_transactionObj);
} // .end of bil002_ctrl_saveBilling
*/
/**
 * Remove billing row that match with given itemId.
 */
/*function page_ctrl_deleteBillingLine(lineId) {
	// Remove from BillingBean's lineList
	$.each(global_billingObj.lineList, function(i, billingLineObj) {
		if (billingLineObj.id == lineId) {
			Cached_deleteBean(billingLineObj);

			$.each(billingLineObj.lineList, function(j, childBillingLineObj) {
				Cached_deleteBean(childBillingLineObj);
			});

			$.each(billingLineObj.mandatoryList, function(j, childBillingLineObj) {
				Cached_deleteBean(childBillingLineObj);
			});

			// Update Inventory
			page_ctrl_deleteInventory(billingLineObj.itemId);

			// Auto-save Billing
			bil001_ctrl_saveBilling();

			// Update UI
			page_view_updateBillingLines();

			return false;
		}
	});
} // .end of page_ctrl_deleteBillingLine
*/

/**
 * Get triggered when button (+) clicked. Actions applied:
 * - Increment value in text field.
 * - trigger calculation
 */
function page_ctrl_incrementQuantity(billingLineId, itemId) {
	var quantity = Number($("#input-quantity-" + billingLineId).val());
	if (isNaN(quantity)) {
		tycheesLogger_showToast('error', 'Invalid Quantity', 'Invalid quantity value')
	}
	else {
		quantity = quantity + 1;
		$("#input-quantity-" + billingLineId).val(quantity);

		page_ctrl_onQuantityValueChanged(billingLineId, itemId);
	}
} // .end of page_ctrl_incrementQuantity

/**
 * Get triggered when button (-) clicked. Actions applied:
 * - Decrement value in text field.
 * - trigger calculation
 */
function page_ctrl_decrementQuantity(billingLineId, itemId) {
	var quantity = Number($("#input-quantity-" + billingLineId).val());
	if (isNaN(quantity)) {
		tycheesLogger_showToast('error', 'Invalid Quantity', 'Invalid quantity value');
	}
	else {
		quantity = quantity - 1;

		if (quantity == 0) {
			tycheesLogger_showToast('error', 'Invalid Quantity', 'Quantity must be more than zero.');
		}
		else {
			$("#input-quantity-" + billingLineId).val(quantity);
			page_ctrl_onQuantityValueChanged(billingLineId, itemId);
		}
	}
} // .end of page_ctrl_decrementQuantity

/**
 * Get triggered when Billing Row's quantity field changed. Actions applied:
 * - Update inventory
 * - Re-compute the summary values. 
 */
function page_ctrl_onQuantityValueChanged(billingLineId, itemId) {
	var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
	var changeVal = 1;

	// Update into BillingBean's lineList
	var newQuantity = $("#input-quantity-" + billingLineId).val();
	$.each(global_billingObj.lineList, function(index, billingLineObj) {
		if (billingLineObj.id == billingLineId) {
			if (billingLineObj.quantity > newQuantity) {
				operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
				changeVal = Number(billingLineObj.quantity) - Number(newQuantity);
			}
			else {
				operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
				changeVal = Number(newQuantity) - Number(billingLineObj.quantity);
			}

			billingLineObj.quantity = newQuantity;
			return false;
		}
	});

	// Auto-save Billing
	bil001_ctrl_saveBilling();

	// Update Inventory
	bil002_ctrl_updateInventory(itemId, operator, changeVal);

	// re-compute
	page_view_computeSummary();
} // .end of page_ctrl_onQuantityValueChanged
