
/**
 * Save billing object into local DB, including following:
 * - transaction object
 * 
 * @param billingObj		Billing object to save.
 * @param itemList			List of item to save.
 */
/*function localdb_billing_save(billingObj, itemList)
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
	
} // .end of billing_save
*/

/**
 * Delete billing object, including following:
 * - delete transaction object
 * 
 * @param billingObj		Billing object to delete.
 */
/*function localdb_billing_delete(billingObj)
{	
	if (billingObj != null)
	{
		// Set billing state
		billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_DELETED;
		billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_DELETED;
		
		// Get billing workflow object
		var billingWorkflowObj;
		$.each(billingObj.workflowList, function(i, workflowObj) {
			if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
				billingWorkflowObj = workflowObj;
		});
	
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
			page_ctrl_deleteInventory(childObj.itemId);
			
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
} // .end of localdb_billing_delete
*/
