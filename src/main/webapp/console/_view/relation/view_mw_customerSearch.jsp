
<!-- 
    Title:			CUSTOMER WIZARD 
    Desc:			- Show customer list
            		- Create new customer (quick mode)
    Author:			Ryan Chee
    Last Modified:	20170810
-->

<div class="modal inmodal fade" id="mw_customerSearch" tabindex="-1" role="dialog"  aria-hidden="true" style="z-index:999999;">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">CUSTOMER SEARCH</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" onclick="mw_customerSearch_closeWindow();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
			
				<div class="row">
					<div class="col-lg-12">
						<div class="input-group m-b" style="width:720px;margin:0px auto 0px auto;">
							<input id="mw_customerSearch_searchKeywords" type="text" class="form-control input-lg" style="z-index:10;" placeholder="customer no, name, contact or email...">
		                	<span class="input-group-btn"> 
								<button type="button" class="btn btn-white" style="height:46px;" onclick="mw_customerSearch_reset();">
									<i class="fa fa-eraser" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-primary" style="height:46px;font-size:13pt;border:0px;" onclick="mw_customerSearch_showAll();">
									<i class="fa fa-search" aria-hidden="true"></i> Show All
								</button> 
		                	</span>
		            	</div>
					</div>
				</div> <!-- .end of row -->
				<br>
				<div id="mw_customerSearch_dataTable_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw_customerSearch_dataTable_spinner_text" style="padding-top:10px; text-align:center;">loading customers...</div>
				</div>
				<div id="mw_customerSearch_dataTable" class="row">
					<div class="col-md-3">
						<div class="ibox-title">
							<h5>1. Quick Add New Customer</h5>
						</div>
						<div class="ibox-content">
							<div id="mw_customerSearch_quickAddCustomer">
								<div class="form-group">
		                            <label for="mw_customerSearch_customerNoVal">* Customer No</label>
		                            <input type="text" placeholder="Enter customer number" id="mw_customerSearch_customerNoVal" class="form-control" required>
		                        </div>
		                        <div class="form-group">
		                            <label for="mw_customerSearch_firstNameVal">First Name</label>
		                            <input type="text" placeholder="Enter first name" id="mw_customerSearch_firstNameVal" class="form-control">
		                        </div>
		                        <div class="form-group">
		                            <label for="mw_customerSearch_lastNameVal">Last Name</label>
		                            <input type="text" placeholder="last name" id="mw_customerSearch_lastNameVal" class="form-control">
		                        </div>
		                        <div class="form-group">
		                            <label for="mw_customerSearch_contactNumberVal">Contact No.</label>
		                            <input type="text" placeholder="contact number" id="mw_customerSearch_contactNumberVal" class="form-control">
		                        </div>
		                        <div>
		                            <button class="btn btn-primary" type="button" onclick="mw_customerSearch_createNew();">Create Now</button>
		                        </div>
		                        <br/>
		                        <div id="mw_customerSearch_create_errorText" style="display:none; color:#ff0000; font-size:12pt;">
		                            Error Text	
		                        </div>
							</div>
							<div id="mw_customerSearch_quickAddCustomer_error" style="text-align:center; display:none;">
								<i class="fa fa-exclamation-triangle modal-icon" aria-hidden="true"></i>
								<br> Usage Limit Exceeded. Please increase the limit at Settings &gt; My Place.
							</div> 
						</div>
					</div>
					<div class="col-md-9">
						<div class="ibox-title">
							<h5>2. Select Customer</h5>
						</div>
						<div class="ibox-content">
							<table id="mw_customerSearch_dataTable_customer" class="table table-striped table-bordered table-hover">
								<thead>
									<tr id="mw_customerSearch_dataTable_customer_header">
									</tr>
								</thead>
								<tbody>	
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="padding-top:10px; padding-bottom:10px;">
				<button type="button" class="btn btn-danger" onclick="mw_customerSearch_closeWindow();">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw_customerSearch_selectNone();">Select None</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_customerSearch_initialized = false;
var mw_customerSearch_systemGeneratedCustomerNo = '';
var mw_customerSearch_callbackFn;
var mw_customerSearch_modalWindowSelectorId;
var mw_customerSearch_customerNo;

function mw_customerSearch_isOpen()
{
	return ($("#mw_customerSearch").data('bs.modal') || {}).isShown;	
} // .end of mw_customerSearch_isOpen

function mw_customerSearch_init()
{
	if (mw_customerSearch_initialized)
		return false;

	$('#mw_customerSearch').on('shown.bs.modal', function () {
		// Generate next customer Number
	    mw_customerSearch_systemGeneratedCustomerNo = consoleCommon_getNextCustomerNo();
	    $('#mw_customerSearch_customerNoVal').val( mw_customerSearch_systemGeneratedCustomerNo );
		// Set focus to filter box
		$('#mw_customerSearch_searchKeywords').val('');
	    $('#mw_customerSearch_searchKeywords').focus();
		$('#mw_customerSearch_searchKeywords').select();
	})
	
	$("#mw_customerSearch_searchKeywords").keypress(function(event) {
	    if ( event.keyCode == 13 ) {
	    	mw_customerSearch_search();
	    }
	});
	
	// Load table column settings
	var colGenderEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_GENDER);
	var colEmailEnabled 		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_EMAIL);
	var colContactEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_CONTACT);
	var colDobEnabled			= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_DOB);
	var colLastBillingEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_LAST_BILLING);
	
	// Setup DataTable header
	$('#mw_customerSearch_dataTable_customer_header').empty();
	$('#mw_customerSearch_dataTable_customer_header').append('<th id="row1col1">Customer No</th>');
	$('#mw_customerSearch_dataTable_customer_header').append('<th>Name</th>');
	if (colGenderEnabled)
		$('#mw_customerSearch_dataTable_customer_header').append('<th>Gender</th>');
	if (colEmailEnabled)
		$('#mw_customerSearch_dataTable_customer_header').append('<th>Email</th>');
	if (colContactEnabled)
		$('#mw_customerSearch_dataTable_customer_header').append('<th>Contact</th>');
	if (colDobEnabled)
		$('#mw_customerSearch_dataTable_customer_header').append('<th>DOB</th>');
	if (colLastBillingEnabled)
		$('#mw_customerSearch_dataTable_customer_header').append('<th>Last Billing</th>');
	$('#mw_customerSearch_dataTable_customer_header').append('<th class="text-right">Action</th>');

	// Get user's preference on page length
 	var dataTable_pageLength = 10; 
 	var foundPropObj;
 	var userObj = tycheesCommon_getCurrentUserObject();
 	
 	$.each(userObj.propertiesList, function(i, propObj) {
 		if (Cached_isDeletedBean(propObj))
 			return true;
 		
 		if (propObj.propKey == UserConstants.PREF_SEARCH_CUSTOMER_VIEW_SIZE && 
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
 		newPropObj.propKey = UserConstants.PREF_SEARCH_CUSTOMER_VIEW_SIZE;
 		newPropObj.propName = UserConstants.PREF_SEARCH_CUSTOMER_VIEW_SIZE;
 		newPropObj.propType = 'Number';
 		newPropObj.propContent = '';
 		newPropObj.propValue = dataTable_pageLength;
 		
 		userObj.propertiesList.push(newPropObj);
 		tycheesIO_saveBean(userObj);
 	}
 	
	// Init dataTable (customer Modal Dialog)
	$("#mw_customerSearch_dataTable_customer").DataTable({
    	"pageLength": dataTable_pageLength
    });	
	// Add event handler on page length changed.
	$("#mw_customerSearch_dataTable_customer").on('length.dt', function(e, settings, lens) {
    	var userObj = tycheesCommon_getCurrentUserObject();
    	$.each(userObj.propertiesList, function(i, propObj) {
    		if (Cached_isDeletedBean(propObj))
    			return true;
    		
    		if (propObj.propKey == UserConstants.PREF_SEARCH_CUSTOMER_VIEW_SIZE && 
   	 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
    			propObj.hasChanged = true;
    			propObj.propValue = lens.toString();
    		}
    	});
    	
		tycheesIO_saveBean(userObj);
    });
	// Remove padding of DataTable
	$('#mw_customerSearch_dataTable_customer_wrapper').css('padding', '0px');

	// Check if reach max count of customer
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var customerMaxCount = 0;
	var customerUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_CUSTOMER_MAX_COUNT) {
			customerMaxCount = Number(propObj.propValue);
			customerUsageCount = Number(propObj.propContent);
		}
	});
	
	if (customerUsageCount >= customerMaxCount)	{
		$('#mw_customerSearch_quickAddCustomer').hide();
		$('#mw_customerSearch_quickAddCustomer_error').show();
	} else {
		$('#mw_customerSearch_quickAddCustomer').show();
		$('#mw_customerSearch_quickAddCustomer_error').hide();
	}
		
	mw_customerSearch_initialized = true;
} // .end of mw_customerSearch_init

function mw_customerSearch_show(callbackFn, modalWindowSelectorId, selectedCustomerNo)
{
	if (callbackFn == null) {
		tycheesLogger_logError('Null callbackFn found: ' + callbackFn, 'mw_customerSearch_show');
		tycheesLogger_showToast('error', 'System Error', 'Undefined callbackFn found: ' + callbackFn);
		return false;
	}
		
	// Set callback function
	mw_customerSearch_callbackFn = callbackFn;
	// Set calling Modal Window Selector ID
	mw_customerSearch_modalWindowSelectorId = $.trim(modalWindowSelectorId);
	// Set customer ID
	mw_customerSearch_customerNo = $.trim(selectedCustomerNo);
	// Show window
	mw_customerSearch_updateUI();
} // .end of mw_customerSearch_show

function mw_customerSearch_updateUI()
{
	// Hide caller modal window
	if (mw_customerSearch_modalWindowSelectorId != '')
		$('#'+mw_customerSearch_modalWindowSelectorId).hide();
	
	mw_customerSearch_init();
	
	// Show Modal Window
	module_showModalWindow('mw_customerSearch', true);
} // .end of mw_customerSearch_updateUI

function mw_customerSearch_showAll()
{
	// Show/Hide
	$('#mw_customerSearch_dataTable').hide();
	$('#mw_customerSearch_dataTable_spinner').show();
	$('#mw_customerSearch_dataTable_spinner_text').html('loading customers...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': false
	};
	
	var params = new Object();
	
	// Call API
	tycheesdb_api_getCustomersByPlace(requestBody, mw_customerSearch_showResult, params);
} // .end of mw_customerSearch_showAll

function mw_customerSearch_search()
{
	// Show/Hide
	$('#mw_customerSearch_dataTable').hide();
	$('#mw_customerSearch_dataTable_spinner').show();
	$('#mw_customerSearch_dataTable_spinner_text').html('loading customers...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': false,
		'keywords': $.trim( $('#mw_customerSearch_searchKeywords').val() )
	};
	
	var params = new Object();
	
	// Call API
	tycheesdb_api_getCustomersByKeywords(requestBody, mw_customerSearch_showResult, params);
} // .end of mw_customerSearch_search

function mw_customerSearch_reset()
{	
	// Reset
	$('#mw_customerSearch_searchKeywords').val('');
    $('#mw_customerSearch_searchKeywords').focus();
	$('#mw_customerSearch_searchKeywords').select();
	// Clear results
	$('#mw_customerSearch_dataTable_customer').DataTable().clear().draw();	
} // .end of mw_customerSearch_reset

function mw_customerSearch_showResult(successFlag, responseObj, params)
{			
	if (successFlag==false)
		return false;
	
	if (!mw_customerSearch_isOpen())
		return false;
	
	// Show Progressing Message
	$('#mw_customerSearch_dataTable_spinner_text').html('receiving customers...');
	
	// Set customer records into cache list
	Cached_setCustomerList( responseObj.customerList );
	
	// Load table column settings
	var colGenderEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_GENDER);
	var colEmailEnabled 		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_EMAIL);
	var colContactEnabled		= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_CONTACT);
	var colDobEnabled			= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_DOB);
	var colLastBillingEnabled	= settingsCommon_getSettingsValue(ModuleConstants.MODULE_BILLING, ModuleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, SettingsConstants.SETTINGS_POS_KEY_COL_LAST_BILLING);
	
	// Reset panel 'Create New Customer'
	$('#mw_customerSearch_firstNameVal').val('');
	$('#mw_customerSearch_lastNameVal').val('');
	$('#mw_customerSearch_contactNumberVal').val('');
	
	// Clear list
	$('#mw_customerSearch_dataTable_customer').DataTable().clear().draw();
	// Add record into list
	$.each(Cached_getCustomerList(true), function(i, customerObj) {
	
		if (Cached_isDeletedBean(customerObj))
			return true;
		
		var htmlLines_buttonClass = 'btn btn-primary btn-xs ladda-button';
		var htmlLines_onclick = 'onclick="mw_customerSearch_select(\'' + customerObj.id + '\');"';
		var htmlLines_buttonText = 'Select';
		if (customerObj.id == mw_customerSearch_customerNo || customerObj.customerNo == mw_customerSearch_customerNo)
		{
			htmlLines_buttonClass = 'btn btn-gray btn-xs ladda-button';
			htmlLines_onclick = '';
			htmlLines_buttonText = 'Selected';
		}
	
		var htmlLines_selectButton = '';
		htmlLines_selectButton += '<span class="text-right">';
		htmlLines_selectButton += '<button id="selectBtn-' + customerObj.id + '" class="' + htmlLines_buttonClass + '" data-style="zoom-in" style="width:100%;vertical-align:middle;" ' + htmlLines_onclick + '> ' + htmlLines_buttonText + '</button>';
		htmlLines_selectButton += '</span>';
	
		var rowSet = [];
		rowSet.push( $.trim(customerObj.customerNo).length==0 ? '-' : customerObj.customerNo );
		rowSet.push( $.trim(customerObj.firstName) + ' ' + $.trim(customerObj.lastName) );
		
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
	
		$("#mw_customerSearch_dataTable_customer").dataTable().fnAddData( rowSet, false );
	});
	
	// Show/Hide
	$('#mw_customerSearch_dataTable').show();
	$('#mw_customerSearch_dataTable_spinner').hide();
	
	// Show Modal Window
	module_showModalWindow('mw_customerSearch', true);
	
	// Generate next customer Number
    mw_customerSearch_systemGeneratedCustomerNo = consoleCommon_getNextCustomerNo();
    $('#mw_customerSearch_customerNoVal').val( mw_customerSearch_systemGeneratedCustomerNo );
    
	// Redraw DataTable
	$("#mw_customerSearch_dataTable_customer").DataTable().draw();	
} // .end of mw_customerSearch_updateUI

/**
 * User selects none as customer.
 */
function mw_customerSearch_selectNone()
{	
	// Show window
	$('#mw_customerSearch').modal('hide');
	// Show Modal Window
	if (mw_customerSearch_modalWindowSelectorId != '') 
		$('#'+mw_customerSearch_modalWindowSelectorId).show();
	// Trigger callback function
	mw_customerSearch_callbackFn();
} // .end of mw_customerSearch_selectNone

/**
 * User select custommer.
 */
function mw_customerSearch_select(customerId)
{
	$('#selectBtn-'+customerId).ladda().ladda('start');
	
	var requestBody = {
			'appName': APP_NAME_POS,
			'customerId': customerId,
			'fullBean': true	
		};	

	var params = new Object();
	params.customerId = customerId;
	
	tycheesdb_api_getCustomerById(requestBody, mw_customerSearch_select_postHandler, params);
} // .end of mw_customerSearch_select

function mw_customerSearch_select_postHandler(success, responseObj, params)
{
	$('#selectBtn-'+params.customerId).ladda().ladda('stop');
	
	if (!success)
		return false;
	
	// Hide window
	$('#mw_customerSearch').modal('hide');
	// Show Modal Window
	if (mw_customerSearch_modalWindowSelectorId != '') 
		$('#'+mw_customerSearch_modalWindowSelectorId).show();
	// Trigger callback function
	mw_customerSearch_callbackFn(responseObj.customerObj);	
} // .end of mw_customerSearch_select_postHandler

function mw_customerSearch_closeWindow() 
{
	// Show window
	$('#mw_customerSearch').modal('hide');
	// Show Modal Window
	if (mw_customerSearch_modalWindowSelectorId != null) 
		$('#'+mw_customerSearch_modalWindowSelectorId).show();
} // .end of mw_customerSearch_closeWindow

/**
 * User create new custommer (quick form).
 */
function mw_customerSearch_createNew()
{	
	// Reset
	$('#mw_customerSearch_create_errorText').hide();
	// Get user inputs
	var customerNo 		= $.trim( $('#mw_customerSearch_customerNoVal').val() );
	var firstName 		= $.trim( $('#mw_customerSearch_firstNameVal').val() );
	var lastName 		= $.trim( $('#mw_customerSearch_lastNameVal').val() );
	var contactNumber 	= $.trim( $('#mw_customerSearch_contactNumberVal').val() );

	if (customerNo.length==0)
	{
		$('#mw_customerSearch_create_errorText').html('<i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please enter Customer No.');
		$('#mw_customerSearch_create_errorText').show();
		return false;
	}
	
	// IF   system generated CustomerNo is being used, 
	// THEN update system about next customer no. 
	if ($.trim(customerNo)==$.trim(mw_customerSearch_systemGeneratedCustomerNo))
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
	newCustomerObj.lastBillingId = '';
	newCustomerObj.lastBillingNo = '';

	var newCustomerContactObj = createNew_CustomerContact();
	newCustomerContactObj.customerId = newCustomerObj.id;
	newCustomerContactObj.type = AppConstants.CONTACT_TYPE_MOBILE;
	newCustomerContactObj.phoneNumber = contactNumber;
	newCustomerContactObj.defaultContact = true;
	newCustomerObj.contactList.push(newCustomerContactObj);
	
	// Save to localDb
	tycheesIO_saveBean(newCustomerObj);
	
	// Close window
	$('#mw_customerSearch').modal('hide');
	// Show Modal Window
	if (mw_customerSearch_modalWindowSelectorId != '') 
		$('#'+mw_customerSearch_modalWindowSelectorId).show();
	
	// Trigger callback function
	mw_customerSearch_callbackFn(newCustomerObj);		
} // .end of mw_customerSearch_createNew

</script>