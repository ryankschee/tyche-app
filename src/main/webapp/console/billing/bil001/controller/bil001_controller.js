
/* global PAGE_ACTION_SEARCH_CUSTOMER */

/**
 * Page Level - action executer
 * 
 * @param actionName	predefined name of action
 * @param params		Parameter values in array form.
 */
function page_executeAction(actionName, params) {
	previousPageAction = currentPageAction;
	currentPageAction = actionName;

	tycheesLogger_logInfo('previousPageAction=' + previousPageAction, 'page_executeAction');
	tycheesLogger_logInfo('currentPageAction=' + currentPageAction, 'page_executeAction');

	if (actionName == PAGE_ACTION_MAKE_DELIVERY) {
		if (bil001_ctrl_isQuotationMode(global_billingObj))
			return false;

		mw002_updateUI();
	} // .end of PAGE_ACTION_MAKE_DELIVERY

	if (actionName == PAGE_ACTION_FILTER_SEARCH_TEXT) {
		// RE-Setup Category options 
		init_categoryPanel_blockView();
		// RE-Setup component list option in modal window
		init_itemPanel_blockView();
	} // .end of PAGE_ACTION_FILTER_SEARCH_TEXT

	if (actionName == PAGE_ACTION_RESET_SEARCH_TEXT) {
		$("#inputSearchItem").val("");
		page_executeAction(PAGE_ACTION_FILTER_SEARCH_TEXT);
	} // .end of PAGE_ACTION_FILTER_SEARCH_TEXT
} // .end of page_executeAction

/**
 * Return true if current billing object in quotation mode 
 * - Has quotation number, AND
 * - No billing number.
 */
function bil001_ctrl_isQuotationMode(billingObj) {
	if (billingObj == null)
		return false;

	if ($.trim(billingObj.quotationNo) != '' &&
		$.trim(billingObj.billingNo) == '')
		return true;

	return false;
} // .end of bil001_ctrl_isQuotationMode

/**
 * Return true if current billing object in quotation mode 
 * - Has quotation number, AND
 * - No billing number.
 */
function bil001_ctrl_hasQuotationNumber(billingObj) {
	if (billingObj == null)
		return false;

	if ($.trim(billingObj.quotationNo) != '')
		return true;

	return false;
} // .end of bil001_ctrl_hasQuotationNumber

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
 * Add new row of billing line into billable panel.
 */
function page_ctrl_insertItemAsBillingLine(itemId) {

	if (global_billingObj == null)
		return false;
	if (bil001_isBillingEditable()==false)
		return false;
	
	var itemSpinner = $('#itemView-spinner-' + itemId);
	if (itemSpinner.css('display') == 'none') {
		itemSpinner.show();

		// Prepare request object
		var requestBody = {
			'appName': APP_NAME_POS,
			'itemId': itemId,
			'fullBean': true
		};

		var params = new Object();
		params.itemId = itemId;
		params.itemSpinner = itemSpinner;

		tycheesdb_api_getItemById(requestBody, page_ctrl_insertItemAsBillingLine_step1, params);
	}
	else {
		tycheesLogger_showToast('warning', 'No insert allowed', 'System is processing this item now. Please try again later.');
	}
	
} // .end of page_ctrl_insertItemAsBillingLine

function page_ctrl_insertItemAsBillingLine_step1(success, responseObj, params) {
	if (success == false) {
		tycheesLogger_showToast('error', 'Ajax Error', 'Failure in calling tycheesdb_api_getItemById.');
		params.itemSpinner.hide();
		return false;
	}

	var defaultMinUnit = 1;

	// VALIDATION
	// #1 - Is item available in stock?
	if (responseObj.itemObj.availability == InventoryConstants.QUANTITY_NO_STOCK) {
		tycheesLogger_showToast('warning', 'Warning', 'Stock unavailable.');
		params.itemSpinner.hide();
		return false;
	}
	// .end of VALIDATION

	// Create new Billing Line (LEVEL 1)   
	var billingLineObj = billingCommon_createBillingLine(global_billingObj, responseObj.itemObj);
	if (billingLineObj != null) {
		// Push line object into billing object
		global_billingObj.lineList.push(billingLineObj);
		// Update UI
		bil001_cartPanel_updateUI();
		// Update Inventory
		bil001_ctrl_getItemFromInventory(params.itemId, global_billingObj.id, billingLineObj.id, defaultMinUnit);
				
		// Prepare Ajax data
		var requestBody = {
			'appName': APP_NAME_POS,
			'itemId': responseObj.itemObj.id,
			'mandatory': true,
			'optional': false,
			'fullBean': true
		};

		params.itemObj = responseObj.itemObj;
		params.billingLineObj = billingLineObj;

		// Ajax Call
		tycheesdb_api_listComponentItemsByItemId(requestBody, page_ctrl_insertItemAsBillingLine_step2, params);
	}
} // .end of page_ctrl_insertItemAsBillingLine_step1

function page_ctrl_insertItemAsBillingLine_step2(success, responseObj, params) {
	if (success == false) {
		tycheesLogger_showToast('error', 'Ajax Error', 'Failure in calling tycheesdb_api_listComponentItemsByItemId.');
		params.itemSpinner.hide();
		return false;
	}
	
	// Prepare Ajax data
	var requestBody = {
		'appName': APP_NAME_POS,
		'billingId': global_billingObj.id,
		'billingLineId': params.billingLineObj.id,
		'fullBean': true
	};

	params.itemList = responseObj.itemList;

	// Ajax Call
	tycheesdb_api_listItemsByBillingLine(requestBody, page_ctrl_insertItemAsBillingLine_postHandler, params);
} // .end of page_ctrl_insertItemAsBillingLine_step2

function page_ctrl_insertItemAsBillingLine_postHandler(success, responseObj, params) {
	if (success == false) {
		tycheesLogger_showToast('error', 'Ajax Error', 'Failure in calling tycheesdb_api_listItemsByBillingLine.');
		params.itemSpinner.hide();
		return false;
	}

	var itemObj = params.itemObj;
	var billingLineObj = params.billingLineObj;
	$.each(responseObj.itemList, function(i, obj) {
		params.itemList.push(obj);
	});

	// Add mandatory components as Billing Line
	$.each(itemObj.componentList, function(i, componentObj) {
		if (componentObj.selectable == false) {
			var itemIdsList = componentObj.itemIds.split(',');
			$.each(itemIdsList, function(j, component_itemId) {
				if ($.trim(component_itemId) == '')
					return true;

				var component_itemObj = Cached_getItemById(component_itemId, params.itemList);
				var component_billingLineObj = billingCommon_createBillingLine(global_billingObj, component_itemObj);
				if (component_billingLineObj == null)
					return true;

				component_billingLineObj.parentLineId = billingLineObj.id;
				component_billingLineObj.componentId = componentObj.id;
				component_billingLineObj.mandatory = true;
				component_billingLineObj.quantity = componentObj.defaultQuantity;

				billingLineObj.lineList.push(component_billingLineObj);
			});
		}

		if (componentObj.selectable == true) {
			var defaultItemIdList = $.trim(componentObj.defaultItemIds).split(',');
			$.each(defaultItemIdList, function(i, defaultItemId) {
				if (defaultItemId == '')
					return true;

				var component_itemObj = Cached_getItemById(defaultItemId, params.itemList);
				var component_billingLineObj = billingCommon_createBillingLine(global_billingObj, component_itemObj);
				if (component_billingLineObj == null)
					return true;

				component_billingLineObj.parentLineId = billingLineObj.id;
				component_billingLineObj.componentId = componentObj.id;
				component_billingLineObj.mandatory = false;
				component_billingLineObj.quantity = componentObj.defaultQuantity;

				billingLineObj.lineList.push(component_billingLineObj);
			});
		}
	});

	// Auto-save Billing
	//bil001_menuPanel_save();

	// Hide progress
	params.itemSpinner.hide();
} // .end of page_ctrl_insertItemAsBillingLine_postHandler

/**
 * Remove billing row that match with given itemId.
 */
function page_ctrl_deleteBillingLine(lineId) {
	swal({
        title: "Are you sure?",
        text: "You will lose this billing line record.",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete this record!",
        cancelButtonText: "No, cancel please!",
        closeOnConfirm: true,
        closeOnCancel: true },
    	function (isConfirm) {
        	
        if (isConfirm) 
        {
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
    				bil001_ctrl_putItemIntoInventory(billingLineObj.itemId, global_billingObj.id, billingLineObj.id, billingLineObj.quantity);

        			// Auto-save Billing
        			//bil001_menuPanel_save();

        			// Update UI
        			bil001_cartPanel_updateUI();

        			return false;
        		}
        	});
        } 
    });
} // .end of page_ctrl_deleteBillingLine

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
				// Update Inventory
				bil001_ctrl_putItemIntoInventory(itemId, global_billingObj.id, billingLineObj.id, changeVal);
			}
			else {
				operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
				changeVal = Number(newQuantity) - Number(billingLineObj.quantity);
				// Update Inventory
				bil001_ctrl_getItemFromInventory(itemId, global_billingObj.id, billingLineObj.id, changeVal);
			}

			billingLineObj.hasChanged = true;
			billingLineObj.quantity = newQuantity;
			
			return false;
		}
	});

	// Auto-save Billing
    //bil001_menuPanel_save();

	// Update UI
	bil001_paymentPanel_show();
} // .end of page_ctrl_onQuantityValueChanged

/**
 * Save billing object into local DB, including following:
 * - transaction object
 */
function bil001_ctrl_saveBillingIntoIDB(billingObj, itemList)
{
	// Save billing to LocalDB
	tycheesIO_saveBean(billingObj, false);

	// Save item list to LocalDB
	if (itemList != null && itemList.length > 0) 
	{
		tycheesIO_saveBeanList(itemList, false);	
		itemList = [];
	}
	
	// Call save explicitly 
	module_sync();
	
} // .end of bil001_ctrl_saveBillingIntoIDB


/**
 * Delete billing object, including following:
 * - delete transaction object
 * 
 * @param billingObj		Billing object to delete.
 */
function bil001_ctrl_deleteBillingFromIDB(billingObj)
{	
	if (billingObj != null)
	{
		// Show status
		tycheesLogger_showToast('info', 'System Status', 'Deleting order... please wait');
		
		// Set billing state
		billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_DELETED;
		billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_DELETED;
		
		// Get billing workflow object
		var billingWorkflowObj;
		$.each(billingObj.workflowList, function(i, workflowObj) {
			if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
				billingWorkflowObj = workflowObj;
		});

		if (billingWorkflowObj == null) {
			billingWorkflowObj = createNew_BillingWorkflow();
			billingWorkflowObj.billingId = billingObj.id;
			billingWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
			billingWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
			billingObj.workflowList.push(billingWorkflowObj);
		} else {
			billingWorkflowObj.hasChanged = true;
		}
		
		// Create new workflow event (deleted)
		var workflowEventObj = createNew_BillingWorkflowEvent();
		workflowEventObj.workflowId = billingWorkflowObj.id;
		workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
		workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_DELETED;
		workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_DELETED;
		workflowEventObj.eventDescription = 'BILLING DELETED';
		workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
		workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
		billingWorkflowObj.eventList.push( workflowEventObj );
		
		$.each(billingObj.deliveryList, function(i, childObj) {
			Cached_deleteBean(childObj);
		});
		$.each(billingObj.lineList, function(i, childObj) {
			// Update Inventory
			bil001_ctrl_putItemIntoInventory(childObj.itemId, billingObj.id, childObj.id, childObj.quantity);
			
			Cached_deleteBean(childObj);
			
			$.each(childObj.lineList, function(i, grandchildObj) {
				Cached_deleteBean(grandchildObj);
			});
			$.each(childObj.mandatoryList, function(i, grandchildObj) {
				Cached_deleteBean(grandchildObj);
			});
		});
		$.each(billingObj.paymentList, function(i, childObj) {
			Cached_deleteBean(childObj);
		});
		$.each(billingObj.propertiesList, function(i, childObj) {
			Cached_deleteBean(childObj);
		});
		$.each(billingObj.workflowList, function(i, childObj) {
			Cached_deleteBean(childObj);
		});
		$.each(billingObj.calendarList, function(i, childObj) {
			Cached_deleteBean(childObj);
		});		
		
		// Delete object
		Cached_deleteBean(billingObj);
		// Submit to local DB
		tycheesIO_saveBean(billingObj, false);
	}

	// Call save explicitly 
	module_sync();
} // .end of bil001_ctrl_deleteBillingFromIDB


