<!-- CUSTOMER DIALOG -->
<div class="modal inmodal fade" id="mw004" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">SELECT CUSTOMER</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div id="mw004_dataTable_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw004_dataTable_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
				</div>
				<div id="mw004_dataTable" class="row">
					<div class="col-md-3">
						<div class="ibox-title">
							<h5>1. Quick Add New Customer</h5>
						</div>
						<div class="ibox-content">
							<form role="form">
								 <div class="form-group">
	                                 <label for="mw004_customerNoVal">* Customer No</label>
	                                 <input type="text" placeholder="Enter customer number" id="mw004_customerNoVal" class="form-control" required>
	                             </div>
	                             <div class="form-group">
	                                 <label for="mw004_firstNameVal">First Name</label>
	                                 <input type="text" placeholder="Enter first name" id="mw004_firstNameVal" class="form-control">
	                             </div>
	                             <div class="form-group">
	                                 <label for="mw004_lastNameVal">Last Name</label>
	                                 <input type="text" placeholder="last name" id="mw004_lastNameVal" class="form-control">
	                             </div>
	                             <div class="form-group">
	                                 <label for="mw004_contactNumberVal">Contact No.</label>
	                                 <input type="text" placeholder="contact number" id="mw004_contactNumberVal" class="form-control">
	                             </div>
	                             <div>
                                     <button class="btn btn-primary" type="button" onclick="mw004_createNew();">Create Now</button>
                                 </div>
                                 <br/>
                                 <div id="mw004_create_errorText" style="display:none; color:#ff0000; font-size:12pt;">
                                     Error Text	
                                 </div>
	                         </form>
						</div>
					</div>
					<div class="col-md-9">
						<div class="ibox-title">
							<h5>2. Select Customer</h5>
						</div>
						<div class="ibox-content">
							<table id="mw004_dataTable_customer" class="table table-striped table-bordered table-hover">
								<thead>
									<tr id="mw004_dataTable_customer_header">
										<th id="row1col1">Customer No</th>
										<th>Name</th>
										<th>Contact</th>
										<th>Date of Birth</th>
										<th>Last Order</th>
										<th class="text-right">Action</th>
									</tr>
								</thead>
								<tbody id="tbody-customer-list">	
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw004_selectNone();">Select None</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw004_initialized = false;
var mw004_systemGeneratedCustomerNo = '';

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw004_isOpen()
{
	return ($("#mw004").data('bs.modal') || {}).isShown;	
} // .end of mw004_isOpen

/**
 * Initiate components/variables
 */
function mw004_init()
{
	if (mw004_initialized)
		return false;

	$('#mw004').on('shown.bs.modal', function () {
	    mw004_systemGeneratedCustomerNo = consoleCommon_getNextCustomerNo();
	    $('#mw004_customerNoVal').val( mw004_systemGeneratedCustomerNo );
	})
	
	mw004_initialized = true;
} // .end of mw004_init

/**
 * Ajax call to get customer list
 */
function mw004_updateUI()
{
	// Show Modal Window
	module_showModalWindow('mw004', true);
	// Show/Hide
	$('#mw004_dataTable').hide();
	$('#mw004_dataTable_spinner').show();
	$('#mw004_dataTable_spinner_text').html('loading customers...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': false
	};
	
	var params = new Object();
	
	// Call API
	tycheesdb_api_getCustomersByPlace(requestBody, mw004_updateUI_postHandler, params);
} // .end of mw004_updateUI

/**
 * Initiate data into modal window.
 */
function mw004_updateUI_postHandler(successFlag, responseObj, params)
{			
	if (successFlag==false)
		return false;

	$('#mw004_dataTable_spinner_text').html('receiving customers...');
	Cached_setCustomerList( responseObj.customerList );
	
	// Init
	mw004_init();
	
	// Load table column settings
	var colGenderEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_GENDER);
	var colEmailEnabled 		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_EMAIL);
	var colContactEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_CONTACT);
	var colDobEnabled			= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_DOB);
	var colLastBillingEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_LAST_BILLING);
	
	// Setup DataTable header
	$('#mw004_dataTable_customer_header').empty();
	$('#mw004_dataTable_customer_header').append('<th id="row1col1">Customer No</th>');
	$('#mw004_dataTable_customer_header').append('<th>Name</th>');
	if (colGenderEnabled)
		$('#mw004_dataTable_customer_header').append('<th>Gender</th>');
	if (colEmailEnabled)
		$('#mw004_dataTable_customer_header').append('<th>Email</th>');
	if (colContactEnabled)
		$('#mw004_dataTable_customer_header').append('<th>Contact</th>');
	if (colDobEnabled)
		$('#mw004_dataTable_customer_header').append('<th>Date of Birth</th>');
	if (colLastBillingEnabled)
		$('#mw004_dataTable_customer_header').append('<th>Last Billing</th>');
	$('#mw004_dataTable_customer_header').append('<th class="text-right">Action</th>');

	// Init dataTable (customer Modal Dialog)
	$("#mw004_dataTable_customer").DataTable();
	
	// Reset panel 'Create New Customer'
	$('#mw004_firstNameVal').val('');
	$('#mw004_lastNameVal').val('');
	$('#mw004_contactNumberVal').val('');
	
	// Get transaction, object store and list of customer records.
	var transaction = getIDBTransaction(OBJECT_STORE_CUSTOMER);
	var objectStore_customer = transaction.objectStore(OBJECT_STORE_CUSTOMER);
	
	// Clear list
	$('#mw004_dataTable_customer').DataTable().clear().draw();
	// Add record into list
	$.each(Cached_getCustomerList(true), function(i, customerObj) {
	
		var htmlLines_buttonClass = 'btn btn-primary btn-xs';
		var htmlLines_onclick = 'onclick="mw004_select(\'' + customerObj.id + '\');"';
		var htmlLines_buttonText = 'Select';
		if (customerObj.id == global_billingObj.customerId)
		{
			htmlLines_buttonClass = 'btn btn-gray btn-xs';
			htmlLines_onclick = '';
			htmlLines_buttonText = 'Selected';
		}
	
		var htmlLines_selectButton = '';
		htmlLines_selectButton += '<span class="text-right">';
		htmlLines_selectButton += '<button class="' + htmlLines_buttonClass + '" style="width:100%;" ' + htmlLines_onclick + ' style="vertical-align:middle;"> ' + htmlLines_buttonText + '</button>';
		htmlLines_selectButton += '</span>';
	
		var rowSet = [];
		rowSet.push( $.trim(customerObj.customerNo).length==0 ? '-' : customerObj.customerNo );
		rowSet.push( customerObj.firstName + ' ' + customerObj.lastName );
		
		if (colGenderEnabled)
			rowSet.push( customerObj.gender );
		if (colEmailEnabled)
			rowSet.push( customerObj.email );
		if (colContactEnabled)
			rowSet.push( customerObj.contact );
		if (colDobEnabled)
			rowSet.push( tycheesDateTime_getFormattedDate_ddMMyyyy(customerObj.dob) );
		if (colLastBillingEnabled)
			rowSet.push( $.trim(customerObj.lastBillingNo).length==0 ? '-' : customerObj.lastBillingNo );
			
		rowSet.push( htmlLines_selectButton );
	
		$("#mw004_dataTable_customer").dataTable().fnAddData( rowSet, false );
	});
	
	$("#mw004_dataTable_customer").DataTable().draw();

	// Show/Hide
	$('#mw004_dataTable').show();
	$('#mw004_dataTable_spinner').hide();
	
	// Show Modal Window
	module_showModalWindow('mw004', true);
} // .end of mw004_updateUI

/**
 * User selects none as customer.
 */
function mw004_selectNone()
{
	// Assign customer
	global_billingObj.customerId = '';
	global_billingObj.customerName = '';
	// Auto-save Billing
	bil001_menuPanel_save();
    		
	// Set name 
	$("#bil001_menuPanel_customerName").val("None");
	$('#bil001_menuPanel_billingCreatedOn').val("None");
	// Show window
	$('#mw004').modal('hide');
} // .end of mw004_selectNone

/**
 * User select custommer.
 *
 * @param	customerId		Customer ID
 */
function mw004_select(customerId)
{
	// Reset, and load with latest list of customer
	var customerObj = Cached_getCustomerById( customerId );
	if (customerObj == null) 
	{
		tycheesLogger_showToast('error','Bug Error','Unable to read customer record. [' + customerId + ']');
	} 
	else 
	{
		//tycheesLogger_showToast('info','Success','Customer [' + customerObj.firstName + " " + customerObj.lastName + '] has been selected.')
		
		// Update Customer
		customerObj.lastBillingId = global_billingObj.id;
		customerObj.lastBillingNo = global_billingObj.billingNo;
		Cached_updateCustomer(customerObj);
		tycheesIO_saveBean(customerObj);
		
		// Assign customer to billing
		global_billingObj.customerId = customerObj.id;
		global_billingObj.customerName = tycheesBean_customer_getFullName(customerObj);
		
		// Auto-save Billing
		bil001_menuPanel_save();
		// Set name 
		$("#bil001_menuPanel_customerName").val(global_billingObj.customerName);
		
		// Hide window
		$('#mw004').modal('hide');
	}
} // .end of mw004_select

/**
 * User create new custommer (quick form).
 */
function mw004_createNew()
{	
	var customerNo = $('#mw004_customerNoVal').val();
	var firstName = $('#mw004_firstNameVal').val();
	var lastName = $('#mw004_lastNameVal').val();
	var contactNumber = $('#mw004_contactNumberVal').val();

	$('#mw004_create_errorText').hide();
	
	if (customerNo==null || customerNo.length==0)
	{
		$('#mw004_create_errorText').html('<i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please enter Customer No.');
		$('#mw004_create_errorText').show();
		return false;
	}
	
	// IF   system generated CustomerNo is being used, 
	// THEN update system about next customer no. 
	if ($.trim(customerNo)==$.trim(mw004_systemGeneratedCustomerNo))
	{
		consoleCommon_updateNextCustomerNo();
	}
		
	// Create object
	var newCustomerObj = createNew_Customer();
	newCustomerObj.customerNo = customerNo;
	newCustomerObj.firstName = firstName;
	newCustomerObj.lastName = lastName;
	newCustomerObj.contact = contactNumber;
	newCustomerObj.placeId = tycheesCommon_getCurrentPlaceId();
	newCustomerObj.lastBillingId = global_billingObj.id;
	newCustomerObj.lastBillingNo = global_billingObj.billingNo;

	var newCustomerContactObj = createNew_CustomerContact();
	newCustomerContactObj.customerId = newCustomerObj.id;
	newCustomerContactObj.type = 'Mobile';
	newCustomerContactObj.phoneNumber = contactNumber;
	newCustomerContactObj.defaultContact = true;
	newCustomerObj.contactList.push(newCustomerContactObj);
	
	// Add to customer list
	Cached_addCustomer( newCustomerObj );
	
	// Save to localDb
	tycheesIO_saveBean(newCustomerObj);
	
	// Assign customer
	global_billingObj.customerId = newCustomerObj.id;
	global_billingObj.customer = newCustomerObj;
	
	// Auto-save Billing
	bil001_menuPanel_save();
    		
	// Update UI
	// Set name 
	$("#bil001_menuPanel_customerName").val(newCustomerObj.firstName + " " + newCustomerObj.lastName);
	// Close window
    module_closeModalWindow('mw004');
} // .end of mw004_createNew


</script>