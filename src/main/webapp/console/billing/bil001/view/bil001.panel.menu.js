
var bil001_menuPanel_billingNo_processing = false;

function bil001_menuPanel_show() {
	
	if (global_billingObj == null) {
		// Billing Creation Date
		$('#bil001_menuPanel_billingCalendarButton').addClass('btn-grey');
		$('#bil001_menuPanel_billingCalendarButton').removeClass('btn-primary');		
		$('#bil001_menuPanel_billingCreatedOn').val('NONE');
		$('#bil001_menuPanel_billingCreatedOn').prop('disabled', true);

		// Billing No
		$('#bil001_menuPanel_editBillingNoButton').addClass('btn-grey');
		$('#bil001_menuPanel_editBillingNoButton').removeClass('btn-primary');
		$('#bil001_menuPanel_openQuotationButton').addClass('btn-grey');
		$('#bil001_menuPanel_openQuotationButton').removeClass('btn-primary');
		$('#bil001_menuPanel_editQuotationButton').addClass('btn-grey');
		$('#bil001_menuPanel_editQuotationButton').removeClass('btn-primary');
		$('#bil001_menuPanel_billingNo').val('');
		$('#bil001_menuPanel_billingNo').prop('disabled', false);	
		$('#bil001_menuPanel_billingNo').keypress(function (e) {
			 var key = (e.keyCode ? e.keyCode : e.which);
			 if(key == 13 && !bil001_menuPanel_billingNo_processing) {
				 bil001_menuPanel_openBillingByBillingNo( $(this).val().trim() );
			     return false;  
			 }
		}); 
    	$('#bil001_menuPanel_billingNo').focus();
    	$('#bil001_menuPanel_billingNo').select();
		
		$('#bil001_menuPanel_quotationNo').val('');
		$('#bil001_menuPanel_quotationNo').prop('disabled', false);
		$('#bil001_orderNoDiv').show();
		$('#bil001_quotationNoDiv').hide();
		
		// Customer
		$('#bil001_menuPanel_searchCustomerButton').addClass('btn-grey');
		$('#bil001_menuPanel_searchCustomerButton').removeClass('btn-primary');
		$('#bil001_menuPanel_openCustomerButton').addClass('btn-grey');
		$('#bil001_menuPanel_openCustomerButton').removeClass('btn-primary');	
		$('#bil001_menuPanel_customerName').val('');
		
		// Context Buttons
		$($('#bil001_menuPanel_cloneButton').parent()).addClass('disabled');
		$($('#bil001_menuPanel_openWorkflowButton').parent()).addClass('disabled');	
		$($('#bil001_menuPanel_openDeliveryButton').parent()).addClass('disabled');	
		$($('#bil001_menuPanel_saveButton').parent()).addClass('disabled');	
		$($('#bil001_menuPanel_deleteButton').parent()).addClass('disabled');	
		$('#bil001_menuPanel_printButton').addClass('btn-grey');
		$('#bil001_menuPanel_printButton').removeClass('btn-primary');
		$('#bil001_menuPanel_closeButton').addClass('btn-grey');
		$('#bil001_menuPanel_closeButton').removeClass('btn-warning');
		
	} else {
		// Billing Creation Date
		if (bil001_isBillingEditable()==false) {
			$('#bil001_menuPanel_billingCalendarButton').addClass('btn-grey');
			$('#bil001_menuPanel_billingCalendarButton').removeClass('btn-primary');
			$('#bil001_menuPanel_billingCreatedOn').prop('disabled', true);
		} else {
			$('#bil001_menuPanel_billingCalendarButton').addClass('btn-primary');
			$('#bil001_menuPanel_billingCalendarButton').removeClass('btn-grey');
			$('#bil001_menuPanel_billingCreatedOn').prop('disabled', false);
		}
		if (global_billingObj.createdOn == null || global_billingObj.createdOn == 0)
			$('#bil001_menuPanel_billingCreatedOn').val('');
		else
			$('#bil001_menuPanel_billingCreatedOn').val(tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.billingDate));

		// Billing No
		if (bil001_isBillingEditable()==false) {
			$('#bil001_menuPanel_editBillingNoButton').addClass('btn-grey');
			$('#bil001_menuPanel_editBillingNoButton').removeClass('btn-primary');
			$('#bil001_menuPanel_openQuotationButton').addClass('btn-grey');
			$('#bil001_menuPanel_openQuotationButton').removeClass('btn-primary');
			$('#bil001_menuPanel_editQuotationButton').addClass('btn-grey');
			$('#bil001_menuPanel_editQuotationButton').removeClass('btn-primary');
		} else {
			$('#bil001_menuPanel_editBillingNoButton').addClass('btn-primary');
			$('#bil001_menuPanel_editBillingNoButton').removeClass('btn-grey');
			$('#bil001_menuPanel_openQuotationButton').addClass('btn-primary');
			$('#bil001_menuPanel_openQuotationButton').removeClass('btn-grey');
			$('#bil001_menuPanel_editQuotationButton').addClass('btn-primary');
			$('#bil001_menuPanel_editQuotationButton').removeClass('btn-grey');
		}

		$('#bil001_menuPanel_billingNo').val($.trim(global_billingObj.billingNo));
		$('#bil001_menuPanel_billingNo').prop('disabled', true);	
		$('#bil001_menuPanel_quotationNo').val($.trim(global_billingObj.quotationNo));
		$('#bil001_menuPanel_quotationNo').prop('disabled', true);
		$('#bil001_orderNoDiv').show();
		$('#bil001_quotationNoDiv').hide();
		
		if (bil001_ctrl_isQuotationMode(global_billingObj)) {
			$('#bil001_menuPanel_quotationNo').val(global_billingObj.quotationNo);
			$('#bil001_orderNoDiv').hide();
			$('#bil001_quotationNoDiv').show();
		}	
		
		// Customer
		if (bil001_isBillingEditable()==false) {
			$('#bil001_menuPanel_searchCustomerButton').addClass('btn-grey');
			$('#bil001_menuPanel_searchCustomerButton').removeClass('btn-primary');
		} else {
			$('#bil001_menuPanel_searchCustomerButton').addClass('btn-primary');
			$('#bil001_menuPanel_searchCustomerButton').removeClass('btn-grey');
		}
		$('#bil001_menuPanel_openCustomerButton').addClass('btn-primary');
		$('#bil001_menuPanel_openCustomerButton').removeClass('btn-grey');
		$('#bil001_menuPanel_customerName').val($.trim(global_billingObj.customerName));
		
		// Context Buttons
		$($('#bil001_menuPanel_cloneButton').parent()).removeClass('disabled');
		$($('#bil001_menuPanel_openWorkflowButton').parent()).removeClass('disabled');
		$($('#bil001_menuPanel_openDeliveryButton').parent()).removeClass('disabled');
		$($('#bil001_menuPanel_saveButton').parent()).removeClass('disabled');	
		$($('#bil001_menuPanel_deleteButton').parent()).removeClass('disabled');	
		$('#bil001_menuPanel_printButton').addClass('btn-primary');
		$('#bil001_menuPanel_printButton').removeClass('btn-grey');
		$('#bil001_menuPanel_closeButton').addClass('btn-warning');
		$('#bil001_menuPanel_closeButton').removeClass('btn-grey');
	}	
} // .end of bil001_menuPanel_show

function bil001_menuPanel_openBillingCalendar()
{
	if (global_billingObj == null)
		return false;
	
	mw016_show(bil001_isBillingEditable());	
} // .end of bil001_menuPanel_openBillingCalendar

function bil001_menuPanel_editBillingNo()
{
	if (global_billingObj == null) 
		return false;
	if (bil001_isBillingEditable()==false)
		return false;
		
	mw_editBillingNo_show(global_billingObj, bil001_menuPanel_editBillingNo_saveCallbackFn);	
} // .end of bil001_menuPanel_editBillingNo

function bil001_menuPanel_editBillingNo_saveCallbackFn(billingObj)
{
	if (billingObj == null)
		return false;
	
    // Auto-save Billing
	bil001_menuPanel_save();		    
    // Update UI
	bil001_menuPanel_show();
} // .end of bil001_menuPanel_editBillingNo_saveCallbackFn

function bil001_menuPanel_editQuotationNo()
{
	if (global_billingObj == null)
		return false;
	if (bil001_isBillingEditable()==false)
		return false;
	
	mw_editQuotationNo_show(global_billingObj, bil001_menuPanel_editQuotationNo_saveCallbackFn);	
} // .end of bil001_menuPanel_editQuotationNo

function bil001_menuPanel_editQuotationNo_saveCallbackFn(billingObj)
{
	if (billingObj == null)
		return false;
	
    // Auto-save Billing
	bil001_menuPanel_save();		    
    // Update UI
	bil001_menuPanel_show();
} // .end of bil001_menuPanel_editQuotationNo_saveCallbackFn

function bil001_menuPanel_openQuotationOptions()
{
	if (global_billingObj == null)
		return false;
	
	mw018_show(bil001_menuPanel_openQuotationOptions_callbackFn);	
} // .end of bil001_menuPanel_openQuotationOptions

function bil001_menuPanel_openQuotationOptions_callbackFn()
{
	bil001_show();
} // .end of bil001_menuPanel_openQuotationOptions_callbackFn

function bil001_menuPanel_openBillingByBillingNo(billingNo) 
{
	if ($.trim(billingNo)=='')
		return false;
	
	tycheesOverlay_startShortProgress('searching order number...');	
	bil001_menuPanel_billingNo_processing = true;
	
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	var requestBody = {
			'appName': APP_NAME_POS,
			'placeId': placeObj.id, 
			'billingNo': billingNo,
			'fullBean': true	
		};	

	var params = new Object();
	params.billingNo = billingNo;
	
	tycheesdb_api_getBillingByBillingNo(requestBody, bil001_menuPanel_openBillingByBillingNo_postHandler, params);
} // .end of bil001_menuPanel_openBillingByBillingNo

function bil001_menuPanel_openBillingByBillingNo_postHandler(successFlag, responseObj, params)
{
	tycheesOverlay_stopShortProgress();
	bil001_menuPanel_billingNo_processing = false;
	
	if (successFlag==false) {
		tycheesLogger_showToast("error", "Error", "No order record found for " + params.billingNo + ".");
		return false;
	}
	
	if (responseObj.billingObj == null) {
		//tycheesLogger_showToast("error", "Error", "Invalid billing object found.");
		tycheesLogger_showToast("error", "Error", "No order record found for " + params.billingNo + ".");
	} else {		
		// Assign objects to global scope
		global_billingObj = responseObj.billingObj;
		// Recalculate/Save billing object silently.
		bil001_menuPanel_save(true);
		// Update page UI
		bil001_show();
	}
} // .end of bil001_menuPanel_openBillingByBillingNo_postHandler

function bil001_menuPanel_searchBilling() 
{
	if (global_billingObj == null)
		mw_billingSearch_show(bil001_menuPanel_searchBilling_selectCallbackFn, bil001_menuPanel_searchBilling_deleteCallbackFn, null, '');
	else
		mw_billingSearch_show(bil001_menuPanel_searchBilling_selectCallbackFn, bil001_menuPanel_searchBilling_deleteCallbackFn, null, $.trim(global_billingObj.id));
} // .end of bil001_menuPanel_searchBilling

function bil001_menuPanel_searchBilling_selectCallbackFn(billingObj)
{
	if (billingObj != null)
	{
		// Assign objects to global scope
		global_billingObj = billingObj;
		// Recalculate/Save billing object silently.
		bil001_menuPanel_save(true);
		// Update page UI
		bil001_show();
	}
} // .end of bil001_searchBilling_selectCallbackFn

function bil001_menuPanel_searchBilling_deleteCallbackFn(billingObj)
{
	if (billingObj != null)
	{
		// Delete from DB
		bil001_ctrl_deleteBillingFromIDB(billingObj);	
	}
} // .end of bil001_searchBilling_deleteCallbackFn

function bil001_menuPanel_searchCustomer() 
{
	if (global_billingObj == null)
		return false;
	
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_DELETED) {
		tycheesLogger_showToast('error', 'Prohibited Action', 'You cannot select customer on Deleted Billing.');
		return false;
	}

	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_PAID || bil001_isBillingEditable()) 
	{	
		mw_customerSearch_show(bil001_menuPanel_searchCustomer_callbackFn, null, $.trim(global_billingObj.customerId));
	}
} // .end of bil001_menuPanel_searchCustomer

function bil001_menuPanel_searchCustomer_callbackFn(customerObj)
{
	if (customerObj == null) 
	{		
		// Assign customer
		global_billingObj.customerId = '';
		global_billingObj.customerName = '';
		// Auto-save Billing
		bil001_menuPanel_save();
	    // Update UI
		bil001_show();
	}
	else
	{
		// Update Customer
		customerObj.lastBillingId = global_billingObj.id;
		customerObj.lastBillingNo = global_billingObj.billingNo;
		Cached_updateCustomer(customerObj);
		tycheesIO_saveBean(customerObj);
		
		// Assign customer to billing
		global_billingObj.customerId = customerObj.id;
		global_billingObj.customerName = tycheesBean_person_getFullName(customerObj);
		
		// Auto-save Billing
		bil001_menuPanel_save();
	    // Update UI
		bil001_show();
	}
} // .end of bil001_searchCustomer_callbackFn

function bil001_menuPanel_showCustomerProfile()
{
	if (global_billingObj==null)
		return false;
	if ($.trim(global_billingObj.customerId)=='')
		return false;
	
	mw_customerProfile_show(bil001_menuPanel_showCustomerProfile_callbackFn, null, global_billingObj.customerId);
} // .end of bil001_menuPanel_showCustomerProfile

function bil001_menuPanel_showCustomerProfile_callbackFn()
{
	
} // .end of bil001_showCustomerProfile_callbackFn

function bil001_setCustomerProfile()
{
	if (global_billingObj == null)
		return false;
	
	mw010_updateUI();
} // .end of bil001_setCustomerProfile

function bil001_menuPanel_newBilling(callbackFn, params) {
	
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var monthlyBillingMaxAmount = 0;
	var monthlyBillingUsageAmount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT) {
			monthlyBillingMaxAmount = Number(propObj.propValue);
			monthlyBillingUsageAmount = Number(propObj.propContent);
		}
	});
	
	if (monthlyBillingUsageAmount >= monthlyBillingMaxAmount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	// Show Progress
	tycheesOverlay_startShortProgress('Creating new order...');
	// Check billing number
	bil001_menuPanel_validateBillingNo(callbackFn, params);
} // .end of bil001_menuPanel_newBilling

function bil001_menuPanel_validateBillingNo(callbackFn, params) {
	// Get next billing number
	var billingNo = consoleCommon_getNextBillingNo();
	// Show Progress
	tycheesOverlay_startShortProgress('Checking billing no...' + billingNo);
	// Check if any duplicated order found.
	var requestBody = {
			'appName': APP_NAME_POS,
			'billingNo': billingNo,
			'fullBean': false	
		};	

	if (params == null)
		params = new Object();
	params.billingNo = billingNo;
	params.callbackFn = callbackFn;
	
	tycheesdb_api_getBillingByBillingNo(requestBody, bil001_menuPanel_validateBillingNo_postHandler, params);
} // .end of bil001_menuPanel_validateBillingNo

function bil001_menuPanel_validateBillingNo_postHandler(success, responseObj, params) {
	if (!success)
		return false;
	
	// No duplication found
	if (responseObj.billingObj == null) {
		// Hide Progress
		tycheesOverlay_stopShortProgress();
		// Create billing object
		bil001_menuPanel_createNewBilling(params.billingNo);
		// Trigger callback
		if (params.callbackFn != null)
			params.callbackFn(params);
	} else {
		// Get next billing number
		consoleCommon_updateNextBillingNo();
		// Repeat check
		bil001_menuPanel_validateBillingNo(params.callbackFn, params);
	}
} // .end of bil001_menuPanel_validateBillingNo_postHandler

function bil001_menuPanel_createNewBilling(billingNo) {
	// Reset objects
	var billingObj = createNew_Billing();
	billingObj.billingNo = billingNo;
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
	// Update UI
	bil001_show();

	tycheesLogger_showToast("info", "New", "New billing loaded.");
} // .end of bil001_menuPanel_createNewBilling

function bil001_menuPanel_newQuotation() {
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var monthlyBillingMaxAmount = 0;
	var monthlyBillingUsageAmount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT) {
			monthlyBillingMaxAmount = Number(propObj.propValue);
			monthlyBillingUsageAmount = Number(propObj.propContent);
		}
	});
	
	if (monthlyBillingUsageAmount >= monthlyBillingMaxAmount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	// Show Progress
	tycheesOverlay_startShortProgress('Creating new quotation...');
	// Check billing number
	bil001_menuPanel_validateQuotationNo();
} // .end of bil001_menuPanel_newQuotation

function bil001_menuPanel_validateQuotationNo() {
	// Get next billing number
	var quotationNo = consoleCommon_getNextQuotationNo();
	// Show Progress
	tycheesOverlay_startShortProgress('Checking quotation no...' + quotationNo);
	// Check if any duplicated order found.
	var requestBody = {
			'appName': APP_NAME_POS,
			'quotationNo': quotationNo,
			'fullBean': false	
		};	

	var params = new Object();
	params.quotationNo = quotationNo;
	
	tycheesdb_api_getBillingByQuotationNo(requestBody, bil001_menuPanel_validateQuotationNo_postHandler, params);
} // .end of bil001_menuPanel_validateQuotationNo

function bil001_menuPanel_validateQuotationNo_postHandler(success, responseObj, params) {
	if (!success)
		return false;
	
	// No duplication found
	if (responseObj.billingObj == null) {
		// Hide Progress
		tycheesOverlay_stopShortProgress();
		// Create billing object
		bil001_menuPanel_createNewQuotation(params.quotationNo);
	} else {
		// Get next billing number
		consoleCommon_updateNextQuotationNo();
		// Repeat check
		bil001_menuPanel_validateQuotationNo();
	}
} // .end of bil001_menuPanel_validateQuotationNo_postHandler


function bil001_menuPanel_createNewQuotation(quotationNo) {
	// Reset objects
	var billingObj = createNew_Billing();
	billingObj.quotationNo = quotationNo;
	billingObj.billingDate = tycheesDateTime_getCurrentTimeInMillis();
	billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_NEW;
	billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_QUOTATION_NEW;

	var workflowObj = createNew_BillingWorkflow();
	workflowObj.billingId = billingObj.id;
	workflowObj.moduleId = ModuleConstants.MODULE_BILLING;
	workflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
	billingObj.workflowList.push(workflowObj);

	var workflowEventObj = createNew_BillingWorkflowEvent();
	workflowEventObj.workflowId = workflowObj.id;
	workflowEventObj.seqno = 1;
	workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_NEW;
	workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_QUOTATION_NEW;
	workflowEventObj.eventDescription = 'QUOTATION BEGIN';
	workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
	workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
	workflowObj.eventList.push(workflowEventObj);

	var calendarObj = createNew_CommonCalendar();
	calendarObj.foreignId = billingObj.id;
	billingObj.calendarList.push(calendarObj);
	
	// Assign objects to global scope
	global_billingObj = billingObj;

	// Update UI
	bil001_show();
	
	tycheesLogger_showToast("info", "New", "New quotation loaded.");
} // .end of bil001_menuPanel_createNewQuotation

function bil001_menuPanel_cloneBilling() {
	if (global_billingObj == null)
		return false;
	
	if ($.trim(global_billingObj.billingNo) == '') {
		swal({
			type: 'warning',
		    title: 'Invalid Clone Request',
			text: 'Cloning only for Order with billing number.'
		});
		return false;
	}
	
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var monthlyBillingMaxAmount = 0;
	var monthlyBillingUsageAmount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT) {
			monthlyBillingMaxAmount = Number(propObj.propValue);
			monthlyBillingUsageAmount = Number(propObj.propContent);
		}
	});
	
	if (monthlyBillingUsageAmount >= monthlyBillingMaxAmount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	mw_cloneBilling_show();
} // .end of bil001_menuPanel_cloneBilling

function bil001_menuPanel_showWorkflow() {
	if (global_billingObj == null)
		return false;
	
	mw014_show(bil001_isBillingEditable());
} // .end of bil001_menuPanel_showWorkflow

function bil001_menuPanel_showDelivery() {
	if (global_billingObj == null)
		return false;

	mw002_show(bil001_isBillingEditable());
} // .end of bil001_menuPanel_showDelivery

function bil001_menuPanel_print() {
	if (global_billingObj == null)
		return false;
	
	mw_printWizard_show();
} // .end of bil001_menuPanel_print

function bil001_menuPanel_initBilling() {	
	global_billingObj = null;
	
	bil001_show();
} // .end of bil001_menuPanel_close

function bil001_menuPanel_close() {
	if (global_billingObj == null)
		return false;
	
	if (global_billingObj.hasChanged == true) {
		swal({
				title: "Are you sure?",
				text: "You will lose this unsaved billing record.",
				type: "warning",
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "Yes, close this bill without save!",
				cancelButtonText: "No, cancel please!",
				closeOnConfirm: true,
				closeOnCancel: true
			},
			function(isConfirm) {
				if (isConfirm) {
					bil001_menuPanel_initBilling();
				}
			});
	}
	else {
		bil001_menuPanel_initBilling();
	}
} // .end of bil001_menuPanel_close

function bil001_menuPanel_delete() {
	if (global_billingObj == null)
		return false;
	
	var showingNumber = $.trim(global_billingObj.billingNo);
	if (showingNumber == '')
		showingNumber = $.trim(global_billingObj.quotationNo);

	swal({
		title: "Are you sure?",
		text: "You will lose this billing data (" + showingNumber + ")",
		type: "warning",
		showCancelButton: true,
		confirmButtonColor: "#DD6B55",
		confirmButtonText: "Yes, delete this bill!",
		cancelButtonText: "No, cancel please!",
		closeOnConfirm: true,
		closeOnCancel: true
	},
	function(isConfirm) {

		if (isConfirm) {
			bil001_ctrl_deleteBillingFromIDB(global_billingObj);

			// Go back to entry settings
			bil001_menuPanel_initBilling();
		}
	});
} // .end of bil001_menuPanel_delete

function bil001_menuPanel_save(silent) {
	if (global_billingObj == null)
		return false;
	if (silent == null)
		silent = false;
	
	// Check if billing line exist
	if (global_billingObj.lineList.length == 0) {
		if ($.trim(global_billingObj.id).length == 0 &&
			global_billingObj.state != BillingConstants.WORKFLOW_EVENTKEY_NEW) {
			if (!silent)
				tycheesLogger_showToast("error", "Bill Not Complete", "Please insert at least one item before Save Bill.");
			return false;
		}
	}

	// Check billing date
	if (!silent) {
		var billingDate = $('#bil001_menuPanel_billingCreatedOn').val();
		if (tycheesDateTime_isValidDate_ddmmyyyy(billingDate)) {
			$('#bil001_menuPanel_billingCreatedOn').css('border-color', '#e5e6e7');
			global_billingObj.billingDate = new Date(tycheesDateTime_toMilliseconds_ddMMyyyy(billingDate));
			global_billingObj.billingDate.setHours(12, 0, 0, 0);
		}
		else {
			sweetAlert('Oppsss', 'Invalid Billing Date Value (' + billingDate + ').', 'error');
			$('#bil001_menuPanel_billingCreatedOn').css('border-color', '#FF0000');
			$('#bil001_menuPanel_billingCreatedOn').focus();
			return false;
		}
	}
	
	if (!silent) {
		tycheesLogger_showToast('info', 'In Progress', '[' + global_billingObj.billingNo + '] Saving order...');
	}
	
	// IF this is first time SAVE quotation, THEN
	// - Update billing status
	// - Update quotation number
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_NEW) {
		// Get billing workflow object
		var billingWorkflowObj;
		$.each(global_billingObj.workflowList, function(i, workflowObj) {
			if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
				billingWorkflowObj = workflowObj;
		});

		if (billingWorkflowObj == null) {
			billingWorkflowObj = createNew_BillingWorkflow();
			billingWorkflowObj.billingId = billingObj.id;
			billingWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
			billingWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
			global_billingObj.workflowList.push(billingWorkflowObj);
		} else {
			billingWorkflowObj.hasChanged = true;
		}
		
		// Create new workflow event (deleted)
		var workflowEventObj = createNew_BillingWorkflowEvent();
		workflowEventObj.workflowId = billingWorkflowObj.id;
		workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
		workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_OPEN;
		workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_QUOTATION_OPEN;
		workflowEventObj.eventDescription = 'QUOTATION OPENED.';
		workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
		workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
		billingWorkflowObj.eventList.push(workflowEventObj);

		// Set billing state
		global_billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_OPEN;
		global_billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_QUOTATION_OPEN;
		// Update next quotation number
		consoleCommon_updateNextQuotationNo();

		// Add to cached list
		Cached_addBilling(global_billingObj);
	}

	// IF this is first time SAVE billing, THEN
	// - Update billing status
	// - Update billing number
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_NEW) {
		// Get billing workflow object
		var billingWorkflowObj;
		$.each(global_billingObj.workflowList, function(i, workflowObj) {
			if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
				billingWorkflowObj = workflowObj;
		});

		// Create new workflow event (deleted)
		var workflowEventObj = createNew_BillingWorkflowEvent();
		workflowEventObj.workflowId = billingWorkflowObj.id;
		workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
		workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
		workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
		workflowEventObj.eventDescription = 'BILLING OPENED.';
		workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
		workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
		billingWorkflowObj.eventList.push(workflowEventObj);

		// Set billing state
		global_billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
		global_billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
		// Update next billing number
		consoleCommon_updateNextBillingNo();

		// Add to cached list
		Cached_addBilling(global_billingObj);
	}

	// Set change state to FALSE
	global_billingObj.hasChanged = false;
	// Recalculate Billing before SAVE
	billingCommon_calculateBilling(global_billingObj);
	
	// IF this billing has been paid, THEN
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_PAID) {

		// - Check if total payment > total billing
		if (global_billingObj.totalPayment < global_billingObj.totalAmount) {

			// Reset billing state to OPEN
			global_billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
			global_billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
		}
	}

	// Update UI
	bil001_cartPanel_updateUI();
	
	// Save changes to local DB
	bil001_ctrl_saveBillingIntoIDB(global_billingObj, global_updatedItemList);

	// Update Billing object
	Cached_updateBilling(global_billingObj);
	
	//if (!silent)
	//	tycheesLogger_showToast('success', 'Success', 'Order saved successfully.');
} // .end of bil001_menuPanel_save
