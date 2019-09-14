
<!-- 
    Title:			BILLING ORDER WIZARD 
    Desc:			- Show order list
    Author:			Ryan Chee
    Last Modified:	20170811
-->

<div class="modal inmodal fade" id="mw_billingSearch" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">SEARCH BILLINGS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger"  onclick="mw_billingSearch_close();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div id="mw_billingSearch_dataTable_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw_billingSearch_dataTable_spinner_text" style="padding-top:10px; text-align:center;">loading orders...</div>
				</div>
				<div id="mw_billingSearch_filter" class="row" style="padding-bottom:20px;">
					<div class="col-md-12">
						<div id="mw_billingSearch_filter_input" class="input-group m-b" style="width:720px;margin:0px auto 0px auto;">
		            	</div>
					</div>
				</div>
				<div id="mw_billingSearch_dataTable" class="row">
					<div class="col-md-12">
						<div class="ibox" style="margin-bottom:0px;">
							<div class="ibox-content">
								<table id="mw_billingSearch_dataTable_billing" class="table table-striped table-bordered table-hover">
									<thead>
										<tr id="mw_billingSearch_dataTable_billing_header">
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="padding-top:10px; padding-bottom:10px;">
				<button type="button" class="btn btn-danger" onclick="mw_billingSearch_close();">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_billingSearch_initialized = false;
var mw_billingSearch_printEnabled = false;

var mw_billingSearch_billingList = [];
//var mw_billingSearch_transactionList = [];

var mw_billingSearch_selectCallbackFn;
var mw_billingSearch_deleteCallbackFn;
var mw_billingSearch_modalWindowSelectorId;
var mw_billingSearch_billingId;
var mw_billingSearch_bucketId;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw_billingSearch_isOpen()
{
	return ($("#mw_billingSearch").data('bs.modal') || {}).isShown;	
} // .end of mw_billingSearch_isOpen

/**
 * Initiate components/variables
 */
function mw_billingSearch_init()
{
	if (mw_billingSearch_initialized)
		return false;

	$('#mw_billingSearch').on('shown.bs.modal', function () {
		$('#mw_billingSearch_filter_input input').val('');
		$('#mw_billingSearch_filter_input input').focus();
		$('#mw_billingSearch_filter_input input').select();
	});
	
	// Load table column settings
	var colInvoiceNoEnabled 	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_INVOICE_NUMBER);
	var colDateTimeEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_DATE_TIME);
	var colCustomerEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_CUSTOMER);
	var colTotalAmountEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_TOTAL_AMOUNT);
	var colTotalPaymentEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_TOTAL_PAYMENT);
	
	// Setup DataTable header
	$('#mw_billingSearch_dataTable_billing_header').empty();
	$('#mw_billingSearch_dataTable_billing_header').append('<th style="width:80px;">Quotation #</th>');
	$('#mw_billingSearch_dataTable_billing_header').append('<th style="width:80px;">Billing #</th>');
	
	if (colInvoiceNoEnabled)
		$('#mw_billingSearch_dataTable_billing_header').append('<th style="width:80px;">Invoice #</th>');
	if (colDateTimeEnabled)
		$('#mw_billingSearch_dataTable_billing_header').append('<th>Billing Date</th>');
	if (colCustomerEnabled)
		$('#mw_billingSearch_dataTable_billing_header').append('<th>Customer</th>');
	if (colTotalAmountEnabled)
		$('#mw_billingSearch_dataTable_billing_header').append('<th class="text-right" style="width:120px;">Total Amount</th>');
	if (colTotalPaymentEnabled)
		$('#mw_billingSearch_dataTable_billing_header').append('<th class="text-right" style="width:120px;">Total Payment</th>');
	$('#mw_billingSearch_dataTable_billing_header').append('<th class="text-right" style="width:80px;">Action</th>');


	// Get user's preference on page length
 	var dataTable_pageLength = 10; 
 	var foundPropObj;
 	var userObj = tycheesCommon_getCurrentUserObject();
 	
 	$.each(userObj.propertiesList, function(i, propObj) {
 		if (Cached_isDeletedBean(propObj))
 			return true;
 		
 		if (propObj.propKey == UserConstants.PREF_SEARCH_BILLING_VIEW_SIZE && 
 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
 			foundPropObj = propObj;
 			dataTable_pageLength = Number(propObj.propValue);
 			if (dataTable_pageLength == NaN)
 				dataTable_pageLength = 10;
 		}
 	});
 	
 	if (foundPropObj == null) {
 		var newPropObj = createNew_UserProperties();
 		newPropObj.userId = userObj.id;
 		newPropObj.groupName = tycheesCommon_getCurrentPlaceId();
 		newPropObj.propSeqno = userObj.propertiesList.length;
 		newPropObj.propKey = UserConstants.PREF_SEARCH_BILLING_VIEW_SIZE;
 		newPropObj.propName = UserConstants.PREF_SEARCH_BILLING_VIEW_SIZE;
 		newPropObj.propType = 'Number';
 		newPropObj.propContent = '';
 		newPropObj.propValue = dataTable_pageLength;
 		
 		userObj.propertiesList.push(newPropObj);
 		tycheesIO_saveBean(userObj);
 	}
	 	
	// Init dataTable (customer Modal Dialog)	
	$("#mw_billingSearch_dataTable_billing").DataTable({
		pageLength: dataTable_pageLength,
	    initComplete : function() {
	        // Move DataTable's search field into center
	    	$("#mw_billingSearch_dataTable_billing_filter input").detach().appendTo('#mw_billingSearch_filter_input');
	        // Remove word "Search" from DataTable
	        $("#mw_billingSearch_dataTable_billing_filter").detach();
	        // Add placeholder into search field
	        $('#mw_billingSearch_filter_input input').prop('placeholder', 'Search Billing...');
	    }
	});	
	// Add event handler on page length changed.
	$("#mw_billingSearch_dataTable_billing").on('length.dt', function(e, settings, lens) {
    	var userObj = tycheesCommon_getCurrentUserObject();
    	$.each(userObj.propertiesList, function(i, propObj) {
    		if (Cached_isDeletedBean(propObj))
    			return true;
    		
    		if (propObj.propKey == UserConstants.PREF_SEARCH_BILLING_VIEW_SIZE && 
   	 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
    			propObj.hasChanged = true;
    			propObj.propValue = lens.toString();
    		}
    	});
    	
		tycheesIO_saveBean(userObj);
    });
	// Remove padding of DataTable
	$('#mw_billingSearch_dataTable_billing_wrapper').css('padding', '0px');
	
	mw_billingSearch_initialized = true;
} // .end of mw_billingSearch_init

function mw_billingSearch_show(selectCallbackFn, deleteCallbackFn, modalWindowSelectorId, selectedBillingId, bucketId)
{
	if (selectCallbackFn == null) {
		tycheesLogger_logError('Undefined SELECT callbackFn found: ' + selectCallbackFn, 'mw_billingSearch_show');
		tycheesLogger_showToast('error', 'System Error', 'Undefined SELECT callbackFn found: ' + selectCallbackFn);
		return false;
	}
	
	if (deleteCallbackFn == null) {
		tycheesLogger_logError('Undefined DELETE callbackFn found: ' + deleteCallbackFn, 'mw_billingSearch_show');
		tycheesLogger_showToast('error', 'System Error', 'Undefined DELETE callbackFn found: ' + deleteCallbackFn);
		return false;
	}
		
	// Set callback function
	mw_billingSearch_selectCallbackFn = selectCallbackFn;
	mw_billingSearch_deleteCallbackFn = deleteCallbackFn;
	// Set calling Modal Window Selector ID
	mw_billingSearch_modalWindowSelectorId = $.trim(modalWindowSelectorId);
	// Set Billing ID
	mw_billingSearch_billingId = $.trim(selectedBillingId);
	mw_billingSearch_bucketId = $.trim(bucketId);
	// Show window
	mw_billingSearch_updateUI();
} // .end of mw_billingSearch_show

function mw_billingSearch_updateUI()
{
	mw_billingSearch_init();
	
	// Hide caller modal window
	if (mw_billingSearch_modalWindowSelectorId != '')
		$('#'+mw_billingSearch_modalWindowSelectorId).modal('hide');
	// Show Modal Window
	module_showModalWindow('mw_billingSearch', true);

	// Show/Hide
	$('#mw_billingSearch_dataTable').hide();
	$('#mw_billingSearch_filter').hide();
	$('#mw_billingSearch_dataTable_spinner').show();
	$('#mw_billingSearch_dataTable_spinner_text').html('loading orders...');
	
	if (mw_billingSearch_bucketId != '') {
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_ALL,
			'bucketId': mw_billingSearch_bucketId,
			'fullBean': false
		};
		
		var params = new Object();
		
		// Call API
		tycheesdb_api_getBillingsByBucket(requestBody, mw_billingSearch_updateUI_postHandler, params);
	} else {	
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_ALL,
			'fullBean': false
		};
		
		var params = new Object();
		params.placeId = tycheesCommon_getCurrentPlaceId();
		
		// Call API
		tycheesdb_api_getBillingsByPlace(requestBody, mw_billingSearch_updateUI_postHandler, params);
	}
} // .end of mw_billingSearch_updateUI

/**
 * Initiate data into modal window.
 */
function mw_billingSearch_updateUI_postHandler(successFlag, responseObj, params)
{		
	if (successFlag==false)
		return false;
	
	if (!mw_billingSearch_isOpen())
		return false;
	
	// Show Progressing Message
	$('#mw_billingSearch_dataTable_spinner_text').html('receiving orders...');
	
	mw_billingSearch_billingList = responseObj.billingList;
	//mw_billingSearch_transactionList = responseObj.transactionList;
	
	mw_billingSearch_reloadUI();

	// Show/Hide
	$('#mw_billingSearch_dataTable').show();
	$('#mw_billingSearch_filter').show();
	$('#mw_billingSearch_dataTable_spinner').hide();

	// Show Modal Window
	module_showModalWindow('mw_billingSearch', true);

	$('#mw_billingSearch_filter_input input').val('');
	$('#mw_billingSearch_filter_input input').focus();
	$('#mw_billingSearch_filter_input input').select();
	
	$('#mw_billingSearch_dataTable_billing').DataTable().draw();
} // .end of mw_billingSearch_updateUI_postHandler

/**
 * Initiate data into modal window.
 */
function mw_billingSearch_reloadUI()
{		
	// Init
	mw_billingSearch_init();
	
	// Load table column settings
	var colInvoiceNoEnabled 	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_INVOICE_NUMBER);
	var colDateTimeEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_DATE_TIME);
	var colCustomerEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_CUSTOMER);
	var colTotalAmountEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_TOTAL_AMOUNT);
	var colTotalPaymentEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_TOTAL_PAYMENT);
	
	// Clear list
	$('#mw_billingSearch_dataTable_billing').DataTable().clear().draw();
	
	// Add record into list
	$.each(mw_billingSearch_billingList, function(index, billingObj) {
		
		if (Cached_isDeletedBean(billingObj)==true)			
			return true;
		
		var customerName = "NONE";
		if ($.trim(billingObj.customerName) != '')
		{	
			customerName = billingObj.customerName;
		}
			
		var selectButton = '';
		selectButton += '<button class="btn btn-primary btn-xs ladda-button" data-style="zoom-in" id="selectBtn-' + billingObj.id + '" onclick="mw_billingSearch_selectBilling(\'' + billingObj.id + '\');" style="vertical-align:middle;">';
		selectButton += '<i class="fa fa-hand-pointer-o" aria-hidden="true"></i> Select';
		selectButton += '</button>';
		var deleteButton = '';
		deleteButton += '<button class="btn btn-danger btn-xs ladda-button" data-style="zoom-in" id="deleteBtn-' + billingObj.id + '" onclick="mw_billingSearch_deleteBilling(\'' + billingObj.id + '\');" style="vertical-align:middle;">';
		deleteButton += '<i class="fa fa-times" aria-hidden="true"></i>';
		deleteButton += '</button>'; 	
				
		var rowSet = [];
		rowSet.push( $.trim(billingObj.quotationNo)=='' ? '-' : billingObj.quotationNo );
		rowSet.push( $.trim(billingObj.billingNo)=='' ? '-' : billingObj.billingNo );
		
		if (colInvoiceNoEnabled)
			rowSet.push( $.trim(billingObj.invoiceNo)=='' ? '-' : billingObj.invoiceNo );
		if (colDateTimeEnabled)
			rowSet.push( tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss( billingObj.billingDate ) );
		if (colCustomerEnabled)
			rowSet.push( tycheesText_getDisplayText(customerName, 0) );
		if (colTotalAmountEnabled)
			rowSet.push( '<span class="pull-right">' + Number(billingObj.totalAmount).toFixed(2) + '</span>' );
		if (colTotalPaymentEnabled)
			rowSet.push( '<span class="pull-right">' + Number(billingObj.totalPayment).toFixed(2) + '</span>' );
			
		rowSet.push( '<span class="pull-right">' + selectButton + ' ' + deleteButton + '</span>');
	
		$("#mw_billingSearch_dataTable_billing").dataTable().fnAddData( rowSet, false );
	});
} // .end of mw_billingSearch_reloadUI

function mw_billingSearch_reset()
{
	mw_billingSearch_selectCallbackFn = null;
	mw_billingSearch_modalWindowSelectorId = null;
	mw_billingSearch_billingId = null;	
} // .end of mw_billingSearch_reset

function mw_billingSearch_close()
{
	// Close window
	$('#mw_billingSearch').modal('hide');
	// Show Modal Window
	if (mw_billingSearch_modalWindowSelectorId != null) 
		$('#'+mw_billingSearch_modalWindowSelectorId).modal('show');
	// Trigger Caller
	mw_billingSearch_selectCallbackFn();
	// Reset 
	mw_billingSearch_reset();
} // .end of mw_billingSearch_close

/**
 * In response when billing ID is being selected. This is open the billing in
 * the panels.
 *
 * @param billingId		Billing ID
 */
function mw_billingSearch_selectBilling(billingId)
{
	$('#selectBtn-'+billingId).ladda().ladda('start');
	
	var requestBody = {
			'appName': APP_NAME_POS,
			'billingId': billingId,
			'fullBean': true	
		};	

	var params = new Object();
	params.billingId = billingId;
	
	tycheesdb_api_getBillingById(requestBody, mw_billingSearch_selectBilling_postHandler, params);
} // .end of mw_billingSearch_selectBilling

function mw_billingSearch_selectBilling_postHandler(successFlag, responseObj, params)
{
	$('#selectBtn-'+params.billingId).ladda().ladda('stop');
	
	if (successFlag==false)
		return false;
	
	if (responseObj.billingObj != null) {
				
		// Hide window
		$('#mw_billingSearch').modal('hide');
		// Show Modal Window
		if (mw_billingSearch_modalWindowSelectorId != '') 
			$('#'+mw_billingSearch_modalWindowSelectorId).modal('show');
		// Trigger callback function
		mw_billingSearch_selectCallbackFn(responseObj.billingObj);	
		// Reset 
		mw_billingSearch_reset();
	} 
	else 
	{
		tycheesLogger_showToast("error", "Error", "Invalid billing object found.")
	}
} // .end of mw_billingSearch_selectBilling_postHandler

/**
 * In response when billing ID is being selected to delete.
 *
 * @param billingId		Billing ID
 */
function mw_billingSearch_deleteBilling(billingId)
{
	swal({
        title: "Are you sure?",
        text: "You will lose this billing data.",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete this bill!",
        cancelButtonText: "No, cancel please!",
        closeOnConfirm: true,
        closeOnCancel: true },
    	function (isConfirm) {
        	
        if (isConfirm) 
        {
        	$('#deleteBtn-'+billingId).ladda().ladda('start');  
        	
			var requestBody = {
				'appName': APP_NAME_ALL,
				'billingId': billingId,
				'fullBean': true	
			};	
			
			var params = new Object();
			params.billingId = billingId;
			
			tycheesdb_api_getBillingById(requestBody, mw_billingSearch_deleteBilling_postHandler, params);
        } 
    });
} // .end of mw_billingSearch_deleteBilling

function mw_billingSearch_deleteBilling_postHandler(success, responseObj, params)
{
	// Stop ladda
	$('#deleteBtn-'+params.billingId).ladda().ladda('stop');

	if (!success)
		return false;

	// Remove from list, if any
	if (mw_billingSearch_billingList != null)
	{
		$.each(mw_billingSearch_billingList, function(i, obj) {
			if (obj.id == responseObj.billingObj.id) 
			{
				mw_billingSearch_billingList.splice(i, 1);		
				return false;
			}	
		});
	}
	// Update UI
	mw_billingSearch_reloadUI();
	// Pass control back to Caller
	mw_billingSearch_deleteCallbackFn(responseObj.billingObj);	        	
} // .end of mw_billingSearch_deleteBilling_postHandler

</script>