<!-- SEARCH BILLING DIALOG -->
<div class="modal inmodal fade" id="mw007" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">SEARCH BILLINGS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger"  onclick="mw007_close();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div id="mw007_dataTable_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw007_dataTable_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
				</div>
				<div id="mw007_dataTable" class="row">
					<div class="col-md-12">
						<div class="ibox" style="margin-bottom:0px;">
							<div class="ibox-content">
								<table id="mw007_dataTable_billing" class="table table-striped table-bordered table-hover">
									<thead>
										<tr id="mw007_dataTable_billing_header">
											<th>Quotation #</th>
											<th>Billing #</th>
											<th>Invoice #</th>
											<th>Date/Time</th>
											<th>Customer</th>
											<th>Total Amount</th>
											<th>Total Payment</th>
											<th class="text-right">Action</th>
										</tr>
									</thead>
									<tbody id="tbody-billing-list">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" onclick="mw007_close();">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw007_initialized = false;
var mw007_printEnabled = false;

var mw007_billingList = [];
var mw007_transactionList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw007_isOpen()
{
	return ($("#mw007").data('bs.modal') || {}).isShown;	
} // .end of mw007_isOpen

/**
 * Initiate components/variables
 */
function mw007_init()
{
	if (mw007_initialized)
		return false;

	$('#mw007').on('shown.bs.modal', function () {
	    //$($('#mw007').find('.modal-dialog')[0]).css('margin-top', '10px');
	})
	
	mw007_initialized = true;
} // .end of mw007_init

function mw007_updateUI()
{
	module_showModalWindow('mw007', true);
	
	// BEGIN
	$('#mw007_dataTable').hide();
	$('#mw007_dataTable_spinner').show();
	$('#mw007_dataTable_spinner_text').html('loading billings...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': false
	};
	
	var params = new Object();
	params.placeId = tycheesCommon_getCurrentPlaceId();
	
	// Call API
	tycheesdb_api_getBillingsByPlace(requestBody, mw007_updateUI_postHandler, params);	
} // .end of mw007_updateUI

/**
 * Initiate data into modal window.
 */
function mw007_updateUI_postHandler(successFlag, responseObj, params)
{		
	if (successFlag==false) {
		return false;
	} 
		
	$('#mw007_dataTable_spinner_text').html('receiving billings...');
		
	mw007_billingList = responseObj.billingList;
	mw007_transactionList = responseObj.transactionList;
	
	mw007_reloadUI();
	
	$('#mw007_dataTable').show();
	$('#mw007_dataTable_spinner').hide();
} // .end of mw007_updateUI_postHandler


/**
 * Initiate data into modal window.
 */
function mw007_reloadUI()
{		
	// Init
	mw007_init();
	
	// Load table column settings
	var colInvoiceNoEnabled 	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_INVOICE_NUMBER);
	var colDateTimeEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_DATE_TIME);
	var colCustomerEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_CUSTOMER);
	var colTotalAmountEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_TOTAL_AMOUNT);
	var colTotalPaymentEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_TOTAL_PAYMENT);
	
	// Setup DataTable header
	$('#mw007_dataTable_billing_header').empty();
	$('#mw007_dataTable_billing_header').append('<th style="width:80px;">Quotation #</th>');
	$('#mw007_dataTable_billing_header').append('<th style="width:80px;">Billing #</th>');
	
	if (colInvoiceNoEnabled)
		$('#mw007_dataTable_billing_header').append('<th style="width:80px;">Invoice #</th>');
	if (colDateTimeEnabled)
		$('#mw007_dataTable_billing_header').append('<th>Billing Date</th>');
	if (colCustomerEnabled)
		$('#mw007_dataTable_billing_header').append('<th>Customer</th>');
	if (colTotalAmountEnabled)
		$('#mw007_dataTable_billing_header').append('<th class="text-right" style="width:120px;">Total Amount</th>');
	if (colTotalPaymentEnabled)
		$('#mw007_dataTable_billing_header').append('<th class="text-right" style="width:120px;">Total Payment</th>');
	
	$('#mw007_dataTable_billing_header').append('<th class="text-right" style="width:80px;">Action</th>');

	// Init dataTable (customer Modal Dialog)
	$("#mw007_dataTable_billing").DataTable();
	
	// Clear list
	$('#mw007_dataTable_billing').DataTable().clear().draw();
	// Add record into list
	$.each(mw007_billingList, function(index, billingObj) {
		
		if (Cached_isDeletedBean(billingObj)==true)			
			return true;
		
		var customerName = "NONE";
		if ($.trim(billingObj.customerName) != '')
		{	
			customerName = billingObj.customerName;
		}
			
		var selectButton = '<button class="btn btn-primary btn-xs" style="" onclick="mw007_selectBilling(\'' + billingObj.id + '\');" style="vertical-align:middle;"><i class="fa fa-crosshairs" aria-hidden="true"></i> Select</button>';
		var deleteButton = '<button class="btn btn-danger btn-xs" style="" onclick="mw007_deleteBilling(\'' + billingObj.id + '\');" style="vertical-align:middle;"><i class="fa fa-times" aria-hidden="true"></i></button>'; 	
				
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
	
		$("#mw007_dataTable_billing").dataTable().fnAddData( rowSet, false );
	});
	
	$("#mw007_dataTable_billing").DataTable().draw();
	
	module_showModalWindow('mw007', true);
} // .end of mw007_reloadUI

function mw007_close()
{
	// Close window
	module_closeModalWindow('mw007');
} // .end of mw007_close

/**
 * In response when billing ID is being selected. This is open the billing in
 * the panels.
 *
 * @param billingId		Billing ID
 */
function mw007_selectBilling(billingId)
{
	tycheesOverlay_startShortProgress('Loading...');
	
	var requestBody = {
			'appName': APP_NAME_POS,
			'billingId': billingId,
			'fullBean': true	
		};	

	var params = new Object();
	params.billingId = billingId;
	
	tycheesdb_api_getBillingById(requestBody, mw007_selectBilling_postHandler, params);
} // .end of mw007_selectBilling

function mw007_selectBilling_postHandler(successFlag, responseObj, params)
{
	tycheesOverlay_stopShortProgress();
	
	if (successFlag==false)
		return false;
	
	if (responseObj.billingObj != null && responseObj.transactionObj != null) {
				
		// Assign objects to global scope
		global_billingObj = responseObj.billingObj;
		global_transactionObj = responseObj.transactionObj;
		
		// Hide modal window
		$("#mw007").modal("hide");
		
		$('#pageBody').css('padding-right','0px');
	} 
	else 
	{
		tycheesLogger_showToast("error", "Error", "Invalid billing object found.")
	}
} // .end of mw007_selectBilling_postHandler

/**
 * In response when billing ID is being selected to delete.
 *
 * @param billingId		Billing ID
 */
function mw007_deleteBilling(billingId)
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
        	tycheesOverlay_startShortProgress('Deleting billing...');
        
        	// IF selected billing id EQUALS TO currently opened billing object,
        	// THEN close/reset billing
        	if (global_billingObj.id == billingId)
        	{
        		page_ctrl_closeBilling();
        	}
        	
			var requestBody = {
					'appName': APP_NAME_POS,
					'billingId': billingId,
					'fullBean': true	
				};	
			
			var params = new Object();
			params.billingId = billingId;
			
			tycheesdb_api_getBillingById(requestBody, mw007_deleteBilling_postHandler, params);
        } 
    });
} // .end of mw007_deleteBilling

function mw007_deleteBilling_postHandler(successFlag, responseObj, params)
{
	tycheesOverlay_stopShortProgress();

	if (successFlag==false)
	{
		return false;
	}

	localdb_billing_delete(
			mw007_billingList, 
			responseObj.billingObj, 
			mw007_transactionList,
			responseObj.transactionObj);	        	
	        	
	mw007_reloadUI();
} // .end of mw007_deleteBilling_postHandler

</script>