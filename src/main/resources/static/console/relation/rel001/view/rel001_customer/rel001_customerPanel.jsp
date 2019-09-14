
<!-- REL001_02: Customer -->
<div id="rel001_customerPanel" style="display:none;">
    <input type="hidden" id="rel001_customerPanel_customerId" value="">
    <input type="hidden" id="rel001_customerPanel_billingId" value="">
    
    <div class="row">
        <div class="col-md-12">	        
	        <div id="rel001_customerPanel_spinner" class="spiner-example" style="display:none;">
				<div class="sk-spinner sk-spinner-wave">
				    <div class="sk-rect1"></div>
				    <div class="sk-rect2"></div>
				    <div class="sk-rect3"></div>
				    <div class="sk-rect4"></div>
				    <div class="sk-rect5"></div>
				</div>
			    <div id="rel001_customerPanel_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
			</div>            
            <div id="rel001_customerPanel_mainContent" class="ibox float-e-margins" style="margin-top:4px;" style="display:none;">
            	<div class="ibox-title" style="border:0px;">
                    <!-- Toolbar: BEGIN -->
                	<div class="note-toolbar btn-toolbar">
                		<div class="note-font input-group-btn">                			
                			<div>
							  	<button id="rel001_customerPanel_menu_addCustomer" type="button" class="btn btn-primary" style="margin-right:5px;" tabindex="-1" onclick="rel001_customerPanel_addCustomer();">
	                				<i class="fa fa-plus" aria-hidden="true"></i>
	                				New Customer
	                			</button>
							</div>
                			<div class="input-group-btn">
							  	<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" style="margin-right:5px;">
							  		<i class="fa fa-cloud-download" aria-hidden="true"></i> Download
							  		<span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							    	<li><a href="#" onclick="rel001_customerPanel_downloadBatch_customerBasic();">Customer Basic</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#" onclick="rel001_customerPanel_downloadBatch_customerContacts();">Customer Contacts</a></li>
							    	<li><a href="#" onclick="rel001_customerPanel_downloadBatch_customerEmails();">Customer Emails</a></li>
							    	<li><a href="#" onclick="rel001_customerPanel_downloadBatch_customerAddresses();">Customer Addresses</a></li>
							  	</ul>
							</div>
							<div class="input-group-btn">
							  	<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
							  		<i class="fa fa-cloud-upload" aria-hidden="true"></i> Upload
							  		<span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							    	<li><a href="#" onclick="rel001_customerPanel_uploadBatch_customerBasic();">Customer Basic</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#" onclick="rel001_customerPanel_uploadBatch_customerContact();">Customer Contacts</a></li>
							    	<li><a href="#" onclick="rel001_customerPanel_uploadBatch_customerEmail();">Customer Emails</a></li>
							    	<li><a href="#" onclick="rel001_customerPanel_uploadBatch_customerAddress();">Customer Addresses</a></li>
							  	</ul>
								<input type="file" id="rel001_customerPanel_uploadInput" style="display:none;">
							</div>
                		</div>
                	</div>
               	</div> <!-- .end of ibox-title -->
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover " id="rel001_customerPanel_dataTable_customer" >
                        <thead>
                            <tr>
                                <th>Full Name</th>
                                <th>Customer No</th>
                                <th>Type</th>
                                <th>Contact</th>
                                <th>Email</th>
                                <th>Area</th>
                                <th style="width:60px;">Action</th>
                            </tr>
                        </thead>
                        <tbody id="rel001_customerPanel_dataTable_customerList">	                                                    
                        </tbody>
                    </table>
                </div>
            </div>  
        </div>
    </div>
    
    <%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_sw001.jsp" %> 
</div>

<!-- CUSTOMER CREATE WIZARD -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw001.jsp" %>
<!-- CUSTOMER EDITOR -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw002.jsp" %>
<!-- Add Profile -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw003.jsp" %>
<!-- Edit Profile -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw004.jsp" %>
<!-- Add Properties -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw005.jsp" %>
<!-- Edit Properties -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw006.jsp" %>
<!-- Clone Profile -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw007.jsp" %>
<!-- Pre Download Confirmation Window -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw_preDownload.jsp" %>
<!-- Preview Batch Upload: Customer Basic -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw_previewUpload_customerBasic.jsp" %>
<!-- Preview Batch Upload: Customer Basic -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw_previewUpload_customerAddress.jsp" %>
<!-- Preview Batch Upload: Customer Basic -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw_previewUpload_customerContact.jsp" %>
<!-- Preview Batch Upload: Customer Basic -->
<%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel_mw_previewUpload_customerEmail.jsp" %>

<script>

var rel001_customerPanel_initialized = false;
var rel001_customerPanel_systemResetFileUpload = false;
var rel001_customerPanel_uploadBatch_customerBasic_selected = false;
var rel001_customerPanel_uploadBatch_customerContact_selected = false;
var rel001_customerPanel_uploadBatch_customerEmail_selected = false;
var rel001_customerPanel_uploadBatch_customerAddress_selected = false;
	
var rel001_customerPanel_customerObj;
var rel001_customerPanel_customerTypeList = [];

/**
 * Init Panel
 */
function rel001_customerPanel_init()
{
    if (rel001_customerPanel_initialized == true)
        return false;

	// Get user's preference on page length
	var dataTable_pageLength = 10; 
	var foundPropObj;
	var userObj = tycheesCommon_getCurrentUserObject();
	
	$.each(userObj.propertiesList, function(i, propObj) {
		if (Cached_isDeletedBean(propObj))
			return true;
		
		if (propObj.propKey == UserConstants.PREF_CUSTOMER_VIEW_SIZE && 
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
		newPropObj.propKey = UserConstants.PREF_CUSTOMER_VIEW_SIZE;
		newPropObj.propName = UserConstants.PREF_CUSTOMER_VIEW_SIZE;
		newPropObj.propType = 'Number';
		newPropObj.propContent = '';
		newPropObj.propValue = dataTable_pageLength;
		
		userObj.propertiesList.push(newPropObj);
		tycheesIO_saveBean(userObj);
	}
	
	// Init dataTable - customer
    $("#rel001_customerPanel_dataTable_customer").DataTable({
        //"columnDefs": [{"width": "80px", "targets": 7}],
        "pageLength": dataTable_pageLength,
     	"order": [[0, "asc"],[1, "asc"]]
    });
    $("#rel001_customerPanel_dataTable_customer").on('length.dt', function(e, settings, lens) {
    	var userObj = tycheesCommon_getCurrentUserObject();
    	$.each(userObj.propertiesList, function(i, propObj) {
    		if (Cached_isDeletedBean(propObj))
    			return true;
    		
    		if (propObj.propKey == UserConstants.PREF_CUSTOMER_VIEW_SIZE && 
   	 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
    			propObj.hasChanged = true;
    			propObj.propValue = lens.toString();
    		}
    	});
    	
		tycheesIO_saveBean(userObj);
    });
    
    // Init dataTable - billing
	$('#rel001_customerPanel_dataTable_billing').DataTable();
	
	// Upload Button
	$('#rel001_customerPanel_uploadInput').on('change', function () {
    	if (rel001_customerPanel_systemResetFileUpload==false) {
    		if (rel001_customerPanel_uploadBatch_customerBasic_selected)
				rel001_customerPanel_validateBatchFile_customerBasic();
    		if (rel001_customerPanel_uploadBatch_customerContact_selected)
				rel001_customerPanel_validateBatchFile_customerContact();
    		if (rel001_customerPanel_uploadBatch_customerEmail_selected)
				rel001_customerPanel_validateBatchFile_customerEmail();
    		if (rel001_customerPanel_uploadBatch_customerAddress_selected)
				rel001_customerPanel_validateBatchFile_customerAddress();
    	}
    	
    	rel001_customerPanel_systemResetFileUpload = false;
    }); 
	
	rel001_customerPanel_initialized = true;
} // .end of rel001_customerPanel_init

function rel001_customerPanel_show()
{
	rel001_customerPanel_updateUI(true);
} // .end of rel001_customerPanel_show

function rel001_customerPanel_updateUI(loadFromServer)
{
    rel001_customerPanel_init();
    
	rel001_customerPanel_customerTypeList = [];
	
	// Reset
	$('#rel001_customerPanel_mainContent').hide();
	$('#rel001_customerPanel_spinner').show();
	$('#rel001_customerPanel_spinner_text').html('loading customers...');
	$('#rel001_customerPanel').show();
	
	if (loadFromServer == null)
		loadFromServer = false;
	
	if (loadFromServer) {	
		rel001_customerPanel_sw001_slideIn();
		
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'fullBean': false
		};
	
		// Call API
		tycheesdb_api_getCustomersByPlace(requestBody, rel001_customerPanel_updateUI_postHandler, new Object());
	} else {
		var responseObj = new Object();
		responseObj.customerList = Cached_getCustomerList();
		
		rel001_customerPanel_updateUI_postHandler(true, responseObj, new Object());
	}
} // .end of rel001_customerPanel_updateUI

function rel001_customerPanel_updateUI_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false)
		return false;

	Cached_setCustomerList(responseObj.customerList);	
    
    // Remove any existing records
   	$("#rel001_customerPanel_dataTable_customer").DataTable().clear().draw();
   	$("#rel001_customerPanel_dataTable_billing").DataTable().clear().draw();
   	
   	// Populate records as table row & frame
 	$.each(Cached_getCustomerList(), function(i, customerObj) {	

 	    if (customerObj == null)
 	    	return true;
 		if (Cached_isDeletedBean(customerObj))
 			return true;
    	
 		var customerType = $.trim(customerObj.templateName);
 		if (customerType != '') {
 			if (rel001_customerPanel_customerTypeList.indexOf(customerType) == -1) {
 				rel001_customerPanel_customerTypeList.push(customerType);
 			}
 		} 		
 		
 	    rel001_customerPanel_updateUI_addCustomerIntoDataTable(customerObj);
  	});
  	
  	$("#rel001_customerPanel_dataTable_customer").DataTable().draw();

	$('#rel001_customerPanel_spinner').hide();
	$('#rel001_customerPanel_mainContent').show();
	
	// If open customer on page load
	if (global_openOnPageLoad_byCustomer) {
		rel001_customerPanel_showCustomer( global_openOnPageLoad_customerId );
	}
} // .end of rel001_customerPanel_updateUI_postHandler

/**
 * Hide CRM Panel
 */
function rel001_customerPanel_hide()
{
    $('#rel001_customerPanel').hide();
    $('#rel001_customerPanel_sw001').hide();
} // .end of rel001_customerPanel_hide

function rel001_customerPanel_addCustomer()
{
	// Check if reach max count
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
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	// Show add customer window
	rel001_customerPanel_mw001_show();
} // .end of rel001_customerPanel_addCustomer

function rel001_customerPanel_editCustomer()
{
	
} // .end of rel001_customerPanel_editCustomer

function rel001_customerPanel_deleteCustomer()
{
	
} // .end of rel001_customerPanel_deleteCustomer

function rel001_customerPanel_uploadBatch_customerBasic()
{
	rel001_customerPanel_uploadBatch_customerBasic_selected = true;
	
	$('#rel001_customerPanel_uploadInput').click();
} // .end of rel001_customerPanel_uploadBatch_customerBasic	

function rel001_customerPanel_validateBatchFile_customerBasic()
{
	// Reset
	rel001_customerPanel_uploadBatch_customerBasic_selected = false;
	// Get selected file
	var files = $('#rel001_customerPanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_startShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_customerPanel_validateBatchFile_postHandler_customerBasic);
	}
	
	// Reset
   	rel001_customerPanel_systemResetFileUpload = true;
	$('#rel001_customerPanel_uploadInput').val("");
} // .end of rel001_customerPanel_validateBatchFile_customerBasic

function rel001_customerPanel_validateBatchFile_postHandler_customerBasic(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = customerUtil_processBatchUpload_customerBasic(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	
	// Update UI
	mw_previewUpload_customerBasic_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_customerPanel_validateBatchFile_postHandler_customerBasic
rel001_customerPanel_updateUI
function rel001_customerPanel_uploadBatch_customerContact()
{
	rel001_customerPanel_uploadBatch_customerContact_selected = true;
	
	$('#rel001_customerPanel_uploadInput').click();
} // .end of rel001_customerPanel_uploadBatch_customerContact	

function rel001_customerPanel_validateBatchFile_customerContact()
{
	// Reset
	rel001_customerPanel_uploadBatch_customerContact_selected = false;
	// Get selected file
	var files = $('#rel001_customerPanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_customerPanel_validateBatchFile_postHandler_customerContact);
	}
	
	// Reset
   	rel001_customerPanel_systemResetFileUpload = true;
	$('#rel001_customerPanel_uploadInput').val("");
} // .end of rel001_customerPanel_validateBatchFile_customerContact

function rel001_customerPanel_validateBatchFile_postHandler_customerContact(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = customerUtil_processBatchUpload_customerContact(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	// Update UI
	mw_previewUpload_customerContact_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_customerPanel_validateBatchFile_postHandler_customerContact

function rel001_customerPanel_uploadBatch_customerEmail()
{
	rel001_customerPanel_uploadBatch_customerEmail_selected = true;
	
	$('#rel001_customerPanel_uploadInput').click();
} // .end of rel001_customerPanel_uploadBatch_customerEmail	

function rel001_customerPanel_validateBatchFile_customerEmail()
{
	// Reset
	rel001_customerPanel_uploadBatch_customerEmail_selected = false;
	// Get selected file
	var files = $('#rel001_customerPanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_customerPanel_validateBatchFile_postHandler_customerEmail);
	}
	
	// Reset
   	rel001_customerPanel_systemResetFileUpload = true;
	$('#rel001_customerPanel_uploadInput').val("");
} // .end of rel001_customerPanel_validateBatchFile_customerEmail

function rel001_customerPanel_validateBatchFile_postHandler_customerEmail(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = customerUtil_processBatchUpload_customerEmail(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	// Update UI
	mw_previewUpload_customerEmail_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_customerPanel_validateBatchFile_postHandler_customerEmail

function rel001_customerPanel_uploadBatch_customerAddress()
{
	rel001_customerPanel_uploadBatch_customerAddress_selected = true;
	
	$('#rel001_customerPanel_uploadInput').click();
} // .end of rel001_customerPanel_uploadBatch_customerAddress	

function rel001_customerPanel_validateBatchFile_customerAddress()
{
	// Reset
	rel001_customerPanel_uploadBatch_customerAddress_selected = false;
	// Get selected file
	var files = $('#rel001_customerPanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_customerPanel_validateBatchFile_postHandler_customerAddress);
	}
	
	// Reset
   	rel001_customerPanel_systemResetFileUpload = true;
	$('#rel001_customerPanel_uploadInput').val("");
} // .end of rel001_customerPanel_validateBatchFile_customerAddress

function rel001_customerPanel_validateBatchFile_postHandler_customerAddress(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = customerUtil_processBatchUpload_customerAddress(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	// Update UI
	mw_previewUpload_customerAddress_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_customerPanel_validateBatchFile_postHandler_customerAddress

function rel001_customerPanel_downloadBatch_customerBasic()
{
	rel001_customerPanel_preDownload_show(rel001_customerPanel_customerTypeList, rel001_customerPanel_downloadBatch_customerBasic_step1);
} // .end of rel001_customerPanel_downloadBatch_customerBasic

function rel001_customerPanel_downloadBatch_customerBasic_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadCustomers(requestBody, rel001_customerPanel_downloadBatch_customerBasic_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_customerPanel_downloadBatch_customerBasic_step1

function rel001_customerPanel_downloadBatch_customerBasic_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_customerPanel_downloadBatch_customerBasic_postHandler

function rel001_customerPanel_downloadBatch_customerContacts()
{
	rel001_customerPanel_preDownload_show(rel001_customerPanel_customerTypeList, rel001_customerPanel_downloadBatch_customerContacts_step1);
} // .end of rel001_customerPanel_downloadBatch_customerContacts

function rel001_customerPanel_downloadBatch_customerContacts_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadCustomerContacts(requestBody, rel001_customerPanel_downloadBatch_customerContacts_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_customerPanel_downloadBatch_customerContacts_step1

function rel001_customerPanel_downloadBatch_customerContacts_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_customerPanel_downloadBatch_customerContacts_postHandler

function rel001_customerPanel_downloadBatch_customerEmails()
{
	rel001_customerPanel_preDownload_show(rel001_customerPanel_customerTypeList, rel001_customerPanel_downloadBatch_customerEmails_step1);
} // .end of rel001_customerPanel_downloadBatch_customerEmails

function rel001_customerPanel_downloadBatch_customerEmails_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadCustomerEmails(requestBody, rel001_customerPanel_downloadBatch_customerEmails_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_customerPanel_downloadBatch_customerEmails_step1

function rel001_customerPanel_downloadBatch_customerEmails_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_customerPanel_downloadBatch_customerEmails_postHandler

function rel001_customerPanel_downloadBatch_customerAddresses()
{
	rel001_customerPanel_preDownload_show(rel001_customerPanel_customerTypeList, rel001_customerPanel_downloadBatch_customerAddresses_step1);
} // .end of rel001_customerPanel_downloadBatch_customerAddresses

function rel001_customerPanel_downloadBatch_customerAddresses_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadCustomerAddresses(requestBody, rel001_customerPanel_downloadBatch_customerAddresses_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_customerPanel_downloadBatch_customerAddresses_step1

function rel001_customerPanel_downloadBatch_customerAddresses_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_customerPanel_downloadBatch_customerAddresses_postHandler

/**
 * Common Action Delegate
 */
function rel001_customerPanel_executeAction(actionName, params)
{
    if (actionName == REL001_02_ACTION_OPEN_POS_BY_CUSTOMER)
    {
        var customerId = '';
        if (params==null) 
        {
            customerId = $('#rel001_customerPanel_customerId').val();
        }
        else
        {
        	customerId = params;
        }
        
        var customerObj = Cached_getCustomerById( customerId );
        
        if (customerObj != null)
        {
            var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING) + '?' + PARAMETER_NAME_OPEN_BY_CUSTOMER_ID + '=' + customerId ;
	        window.open(location, '_self');
        }
    } // .end of REL001_02_ACTION_OPEN_POS_BY_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_OPEN_POS_BY_BILLING)
    {
        var billingId = '';
        if (params==null) 
        {
            billingId = $('#rel001_customerPanel_billingId').val();
        }
        else
        {
            billingId = params;
        }
        
        var billingObj = Cached_getBillingById(billingId);
        
        if (billingObj != null)
        {
            var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING) + '?' + PARAMETER_NAME_OPEN_BY_BILLING_ID + '=' + billingObj.id ;
	        window.open(location, '_self');
        }
    } // .end of REL001_02_ACTION_OPEN_POS_BY_BILLING
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_CLONE_PROFILE)
    {
    	var selectedProfileId = $('#rel001_customerPanel_tab_profiles_select').val();
        rel001_customerPanel_mw007_show( selectedProfileId );
    } // .end of REL001_02_ACTION_ADD_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_ADD_PROFILE)
    {
        rel001_customerPanel_mw003_show();
    } // .end of REL001_02_ACTION_ADD_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_EDIT_PROFILE)
    {
    	var selectedProfileId = $('#rel001_customerPanel_tab_profiles_select').val();
        rel001_customerPanel_mw004_show( selectedProfileId );
    } // .end of REL001_02_ACTION_EDIT_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_DELETE_PROFILE)
    {
    	var profileId = $('#rel001_customerPanel_tab_profiles_select').val();
    	
    	swal({
    		  title: "Are you sure?",
    		  text: "You will not be able to recover this profile record!",
    		  type: "warning",
    		  showCancelButton: true,
    		  confirmButtonColor: "#DD6B55",
    		  confirmButtonText: "Yes, delete it!",
    		  cancelButtonText: "No, cancel plx!",
    		  closeOnConfirm: true,
    		  closeOnCancel: true
    		},
    		function(isConfirm) {
    		  	if (isConfirm) 
    		  	{
    		  		$.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj){
    		  			if (profileObj.id == profileId)
    		  			{
    		  			    Cached_deleteBean(profileObj);
    	    		  		
    	    		  		// Save to IndexedDB
    	    		    	tycheesIO_saveBean(rel001_customerPanel_customerObj);
    	    		  		// Refresh UI
    	    		    	rel001_customerPanel_showCustomer(rel001_customerPanel_customerObj.id);
    		  			}
    		  		});
    		  	}
    		});
    } // .end of REL001_02_ACTION_DELETE_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_ADD_PROPERTIES)
    {
        var selectedProfileId = $('#rel001_customerPanel_tab_profiles_select').val();
        rel001_customerPanel_mw005_show( selectedProfileId );
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_EDIT_PROPERTIES)
    {
    	var profileId = $('#rel001_customerPanel_tab_profiles_select').val();
		var propertiesId = params;
		
        rel001_customerPanel_mw006_show(profileId, propertiesId);
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_DELETE_PROPERTIES)
    {
		var profileId = $('#rel001_customerPanel_tab_profiles_select').val();
		var propertiesId = params;
    	
    	swal({
    		  title: "Are you sure?",
    		  text: "You will not be able to recover this properties record!",
    		  type: "warning",
    		  showCancelButton: true,
    		  confirmButtonColor: "#DD6B55",
    		  confirmButtonText: "Yes, delete it!",
    		  cancelButtonText: "No, cancel plx!",
    		  closeOnConfirm: true,
    		  closeOnCancel: true
    		},
    		function(isConfirm) {
    		  	if (isConfirm) 
    		  	{
    		  		var profileObj = Cached_getCustomerProfileById(rel001_customerPanel_customerObj.id, profileId);
    		  		
    		  		$.each(profileObj.propertiesList, function(i, propObj){
    		  			if (propObj.id == propertiesId)
    		  			{
    		  			    Cached_deleteBean(propObj);
    	    		  		
    	    		  		// Save to IndexedDB
    	    		    	tycheesIO_saveBean(rel001_customerPanel_customerObj);
    	    		  		// Refresh UI
    	    		    	rel001_customerPanel_showCustomer(rel001_customerPanel_customerObj.id);
    		  			}
    		  		});
    		  	}
    		});
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
} // .end of rel001_customerPanel_executeAction

/**
 * Add customer details as table row into DataTable.
 *
 * @param   {CustomerBean} customerObj - Customer Object
 */
function rel001_customerPanel_updateUI_addCustomerIntoDataTable(customerObj) 
{	
    if (customerObj == null)
        return false;

    // Col #1
	var profileImage = customerObj.profileImageUrl;
	if ($.trim(profileImage)=='')
		profileImage = 'https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png';
	var htmlLines_col1 = '';
	htmlLines_col1 += '<span class="client-avatar" style="padding-right:5px;">';
	htmlLines_col1 += '<img alt="image" src="' + profileImage + '" style="width:22px; height:22px;">'; 
	htmlLines_col1 += '</span>';
	htmlLines_col1 += '<a onclick="rel001_customerPanel_showCustomer(\'' + customerObj.id +'\');" class="client-link">';
	htmlLines_col1 += (customerObj.firstName + ' ' + customerObj.lastName);
	htmlLines_col1 += '</a>';
	
	// Col #2
	var htmlLines_col2 = '';
	htmlLines_col2 += '<a onclick="rel001_customerPanel_showCustomer(\'' + customerObj.id +'\');" class="client-link">';
	htmlLines_col2 += $.trim(customerObj.customerNo)=='' ? 'N/A' : $.trim(customerObj.customerNo);
	htmlLines_col2 += '</a>';

    // Col #3
    var htmlLines_col3 = '';
    htmlLines_col3 += $.trim(customerObj.templateName) == '' ? '-' : $.trim(customerObj.templateName);
    
	// Col #4
	var htmlLines_col4 = '';
	htmlLines_col4 += $.trim(customerObj.contact)=='' ? 'N/A' : $.trim(customerObj.contact);
	
	// Col #5
	var htmlLines_col5 = '';
	htmlLines_col5 += $.trim(customerObj.email)=='' ? 'N/A' : $.trim(customerObj.email);

	// Col #6
	var htmlLines_col6 = '';
	htmlLines_col6 += $.trim(customerObj.area)=='' ? 'N/A' : $.trim(customerObj.area);
	
	// Col #7
	var htmlLines_col7 = '';
	htmlLines_col7 += '<a onclick="rel001_customerPanel_openBillingByCustomer(\'' + customerObj.id + '\');" class="btn btn-primary btn-xs" style="margin:0px;">';
	htmlLines_col7 += '<i class="fa fa-shopping-bag" aria-hidden="true"></i>';
	htmlLines_col7 += '</a> ';
	htmlLines_col7 += '<a onclick="rel001_customerPanel_deleteCustomer(\'' + customerObj.id + '\');" class="btn btn-danger btn-xs" style="margin:0px;">';
	htmlLines_col7 += '<i class="fa fa-times" aria-hidden="true"></i>';
	htmlLines_col7 += '</a>';
	
    var tableRow = [];
	tableRow.push(htmlLines_col1);
	tableRow.push(htmlLines_col2);
	tableRow.push(htmlLines_col3);
	tableRow.push(htmlLines_col4);
	tableRow.push(htmlLines_col5);
	tableRow.push(htmlLines_col6);
	tableRow.push(htmlLines_col7);
	
	$('#rel001_customerPanel_dataTable_customer').dataTable().fnAddData(tableRow, false);
} // .end of rel001_customerPanel_updateUI_addCustomerIntoDataTable
	    
function rel001_customerPanel_openBillingByCustomer(customerId)
{
	if ($.trim(customerId)=='')
		return false;
	
	// Set billing ID to localstorage
	localStorage.setItem(OPEN_FROM_SEARCH_CUSTOMER_ID, $.trim(customerId));
	
	var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING);
	window.open(location, '_self');
} // .end of rel001_customerPanel_openBillingByCustomer
	    
function rel001_customerPanel_deleteCustomer(customerId)
{    
    var customerObj = Cached_getCustomerById(customerId);
    if (customerObj != null)
    {
        swal({
            title: "Are you sure?",
            text: "You will not be able to recover this customer!",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete it!",
            closeOnConfirm: true
        }, 
        function () {
        	// Prepare request body
        	var requestBody = {
        			'appName': APP_NAME_RELATION,
        			'customerId': customerId,
        			'fullBean': true
        		};
        	
        	var params = new Object();
        	params.customerId = customerId;
        	
        	tycheesdb_api_getCustomerById(requestBody, rel001_customerPanel_deleteCustomer_postHandler, params);
        });
    }	
} // .end of rel001_customerPanel_deleteCustomer
	
function rel001_customerPanel_deleteCustomer_postHandler(success, responseObj, params)
{
	if (success) 
	{    	
		Cached_updateCustomer(responseObj.customerObj);

        // Delete from localDB
        Cached_deleteBean(responseObj.customerObj);
    	tycheesIO_saveBean(responseObj.customerObj);
    	
    	// Update UI
    	rel001_customerPanel_updateUI(false);    	
    	
        // Show message
        swal("Deleted!", "Customer record has been deleted.", "success");		
	}
} // .end of rel001_customerPanel_deleteCustomer_postHandler

/**
 * Display customer details on customer pane (right-most pane).
 *
 * @param   {String} customerId - Customer ID
 * @param   {String} profileId - Customer Profile ID
 */
function rel001_customerPanel_showCustomer(customerId, profileId)
{
	 rel001_customerPanel_sw001_updateUI(customerId, profileId);
} // .end of rel001_customerPanel_showCustomer
	    	    
</script>