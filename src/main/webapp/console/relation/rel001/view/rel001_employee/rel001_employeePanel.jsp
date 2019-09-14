
<!-- 
  	Module:			Relation
  	Submodule:		REL001
  	Function:		Employee Panel 
  	Last Update:	20170930, by Ryan Chee
-->

<div id="rel001_employeePanel" style="display:none;">    
    <div class="row">
        <div class="col-md-12">	        
	        <div id="rel001_employeePanel_spinner" class="spiner-example" style="display:none;">
				<div class="sk-spinner sk-spinner-wave">
				    <div class="sk-rect1"></div>
				    <div class="sk-rect2"></div>
				    <div class="sk-rect3"></div>
				    <div class="sk-rect4"></div>
				    <div class="sk-rect5"></div>
				</div>
			    <div id="rel001_employeePanel_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
			</div>            
            <div id="rel001_employeePanel_mainContent" class="ibox float-e-margins" style="margin-top:4px;" style="display:none;">
            	<div class="ibox-title" style="border:0px;">
                    <!-- Toolbar: BEGIN -->
                	<div class="note-toolbar btn-toolbar">
                		<div class="note-font input-group-btn">                			
                			<div>
							  	<button id="rel001_employeePanel_menu_addEmployee" type="button" class="btn btn-primary" style="margin-right:5px;" tabindex="-1" onclick="rel001_employeePanel_addEmployee();">
	                				<i class="fa fa-plus" aria-hidden="true"></i>
	                				New Employee
	                			</button>
							</div>
							<!-- 
                			<div class="input-group-btn">
							  	<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" style="margin-right:5px;">
							  		<i class="fa fa-cloud-download" aria-hidden="true"></i> Download
							  		<span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							    	<li><a href="#" onclick="rel001_employeePanel_downloadBatch_employeeBasic();">Employee Basic</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#" onclick="rel001_employeePanel_downloadBatch_employeeContacts();">Employee Contacts</a></li>
							    	<li><a href="#" onclick="rel001_employeePanel_downloadBatch_employeeEmails();">Employee Emails</a></li>
							    	<li><a href="#" onclick="rel001_employeePanel_downloadBatch_employeeAddresses();">Employee Addresses</a></li>
							  	</ul>
							</div>
							<div class="input-group-btn">
							  	<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
							  		<i class="fa fa-cloud-upload" aria-hidden="true"></i> Upload
							  		<span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							    	<li><a href="#" onclick="rel001_employeePanel_uploadBatch_employeeBasic();">Employee Basic</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#" onclick="rel001_employeePanel_uploadBatch_employeeContact();">Employee Contacts</a></li>
							    	<li><a href="#" onclick="rel001_employeePanel_uploadBatch_employeeEmail();">Employee Emails</a></li>
							    	<li><a href="#" onclick="rel001_employeePanel_uploadBatch_employeeAddress();">Employee Addresses</a></li>
							  	</ul>
								<input type="file" id="rel001_employeePanel_uploadInput" style="display:none;">
							</div>
							-->
                		</div>
                	</div>
               	</div> <!-- .end of ibox-title -->
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover " id="rel001_employeePanel_dataTable_employee" >
                        <thead>
                            <tr>
                                <th>Full Name</th>
                                <th>Employee No</th>
                                <th>Type</th>
                                <th>Contact</th>
                                <th>Email</th>
                                <th>Area</th>
                                <th style="width:60px;">Action</th>
                            </tr>
                        </thead>
                        <tbody id="rel001_employeePanel_dataTable_employeeList">	                                                    
                        </tbody>
                    </table>
                </div>
            </div>  
        </div>
    </div>
     
    <%@include file="/console/relation/rel001/view/rel001_employee/rel001_employeePanel_sw_showProfile.jsp" %>     
</div>

<!-- EMPLOYEE CREATE WIZARD -->
<%@include file="/console/relation/rel001/view/rel001_employee/rel001_employeePanel_mw_create.jsp" %>

<script>

var rel001_employeePanel_initialized = false;
var rel001_employeePanel_systemResetFileUpload = false;
var rel001_employeePanel_uploadBatch_employeeBasic_selected = false;
var rel001_employeePanel_uploadBatch_employeeContact_selected = false;
var rel001_employeePanel_uploadBatch_employeeEmail_selected = false;
var rel001_employeePanel_uploadBatch_employeeAddress_selected = false;
	
var rel001_employeePanel_employeeObj;
var rel001_employeePanel_employeeTypeList = [];

/**
 * Init Panel
 */
function rel001_employeePanel_init()
{
    if (rel001_employeePanel_initialized == true)
        return false;
 
    // Get user's preference on page length
 	var dataTable_pageLength = 10; 
 	var foundPropObj;
 	var userObj = tycheesCommon_getCurrentUserObject();
 	
 	$.each(userObj.propertiesList, function(i, propObj) {
 		if (Cached_isDeletedBean(propObj))
 			return true;
 		
 		if (propObj.propKey == UserConstants.PREF_EMPLOYEE_VIEW_SIZE && 
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
 		newPropObj.propKey = UserConstants.PREF_EMPLOYEE_VIEW_SIZE;
 		newPropObj.propName = UserConstants.PREF_EMPLOYEE_VIEW_SIZE;
 		newPropObj.propType = 'Number';
 		newPropObj.propContent = '';
 		newPropObj.propValue = dataTable_pageLength;
 		
 		userObj.propertiesList.push(newPropObj);
 		tycheesIO_saveBean(userObj);
 	}
 	
 	// Init dataTable: employee
    $("#rel001_employeePanel_dataTable_employee").DataTable({
    	"pageLength": dataTable_pageLength,
     	"order": [[0, "asc"],[1, "asc"]]
    });
    $("#rel001_employeePanel_dataTable_employee").on('length.dt', function(e, settings, lens) {
    	var userObj = tycheesCommon_getCurrentUserObject();
    	$.each(userObj.propertiesList, function(i, propObj) {
    		if (Cached_isDeletedBean(propObj))
    			return true;
    		
    		if (propObj.propKey == UserConstants.PREF_EMPLOYEE_VIEW_SIZE && 
   	 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
    			propObj.hasChanged = true;
    			propObj.propValue = lens.toString();
    		}
    	});
    	
		tycheesIO_saveBean(userObj);
    });
    
	// Upload Button
	$('#rel001_employeePanel_uploadInput').on('change', function () {
    	if (rel001_employeePanel_systemResetFileUpload==false) {
    		if (rel001_employeePanel_uploadBatch_employeeBasic_selected)
				rel001_employeePanel_validateBatchFile_employeeBasic();
    		if (rel001_employeePanel_uploadBatch_employeeContact_selected)
				rel001_employeePanel_validateBatchFile_employeeContact();
    		if (rel001_employeePanel_uploadBatch_employeeEmail_selected)
				rel001_employeePanel_validateBatchFile_employeeEmail();
    		if (rel001_employeePanel_uploadBatch_employeeAddress_selected)
				rel001_employeePanel_validateBatchFile_employeeAddress();
    	}
    	
    	rel001_employeePanel_systemResetFileUpload = false;
    }); 
	
	rel001_employeePanel_initialized = true;
} // .end of rel001_employeePanel_init

function rel001_employeePanel_show()
{
	rel001_employeePanel_updateUI(true);
} // .end of rel001_employeePanel_show

function rel001_employeePanel_hide()
{
    $('#rel001_employeePanel').hide();
    $('#rel001_employeePanel_sw001').hide();
} // .end of rel001_employeePanel_hide

function rel001_employeePanel_updateUI(loadFromServer)
{
	rel001_employeePanel_employeeTypeList = [];
	
	// Reset
	$('#rel001_employeePanel_mainContent').hide();
	$('#rel001_employeePanel_spinner').show();
	$('#rel001_employeePanel_spinner_text').html('loading employees...');
	$('#rel001_employeePanel').show();
	
	if (loadFromServer == null)
		loadFromServer = false;
	
	if (loadFromServer) {	
		rel001_employeePanel_sw001_slideIn();
		
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'fullBean': false
		};
	
		// Call API
		tycheesdb_api_getEmployeesByPlace(requestBody, rel001_employeePanel_updateUI_postHandler, new Object());
	} else {
		var responseObj = new Object();
		responseObj.employeeList = Cached_getEmployeeList();
		
		rel001_employeePanel_updateUI_postHandler(true, responseObj, new Object());
	}
} // .end of rel001_employeePanel_updateUI

function rel001_employeePanel_updateUI_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false)
		return false;

    rel001_employeePanel_init();
	Cached_setEmployeeList(responseObj.employeeList);	
    
    // Remove any existing records
   	$("#rel001_employeePanel_dataTable_employee").DataTable().clear().draw();
   	
   	// Populate records as table row & frame
 	$.each(Cached_getEmployeeList(), function(i, employeeObj) {	

 	    if (employeeObj == null)
 	    	return true;
 		if (Cached_isDeletedBean(employeeObj))
 			return true;
    	
 		var employeeType = $.trim(employeeObj.templateName);
 		if (employeeType != '') {
 			if (rel001_employeePanel_employeeTypeList.indexOf(employeeType) == -1) {
 				rel001_employeePanel_employeeTypeList.push(employeeType);
 			}
 		} 		
 		
 	    rel001_employeePanel_updateUI_addEmployeeIntoDataTable(employeeObj);
  	});
  	
  	$("#rel001_employeePanel_dataTable_employee").DataTable().draw();

	$('#rel001_employeePanel_spinner').hide();
	$('#rel001_employeePanel_mainContent').show();
	
	// If open employee on page load
	if (global_openOnPageLoad_byEmployee) {
		rel001_employeePanel_showEmployee( global_openOnPageLoad_employeeId );
	}
} // .end of rel001_employeePanel_updateUI_postHandler

function rel001_employeePanel_addEmployee()
{
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var employeeMaxCount = 0;
	var employeeUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_EMPLOYEE_MAX_COUNT) {
			employeeMaxCount = Number(propObj.propValue);
			employeeUsageCount = Number(propObj.propContent);
		}
	});
	
	if (employeeUsageCount >= employeeMaxCount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	// Show add employee window
	rel001_employeePanel_mw_create_show();
} // .end of rel001_employeePanel_addEmployee

function rel001_employeePanel_editEmployee()
{
	
} // .end of rel001_employeePanel_editEmployee

function rel001_employeePanel_deleteEmployee()
{
	
} // .end of rel001_employeePanel_deleteEmployee

function rel001_employeePanel_uploadBatch_employeeBasic()
{
	rel001_employeePanel_uploadBatch_employeeBasic_selected = true;
	
	$('#rel001_employeePanel_uploadInput').click();
} // .end of rel001_employeePanel_uploadBatch_employeeBasic	

function rel001_employeePanel_validateBatchFile_employeeBasic()
{
	// Reset
	rel001_employeePanel_uploadBatch_employeeBasic_selected = false;
	// Get selected file
	var files = $('#rel001_employeePanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_startShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_employeePanel_validateBatchFile_postHandler_employeeBasic);
	}
	
	// Reset
   	rel001_employeePanel_systemResetFileUpload = true;
	$('#rel001_employeePanel_uploadInput').val("");
} // .end of rel001_employeePanel_validateBatchFile_employeeBasic

function rel001_employeePanel_validateBatchFile_postHandler_employeeBasic(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = employeeUtil_processBatchUpload_employeeBasic(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	
	// Update UI
	mw_previewUpload_employeeBasic_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_employeePanel_validateBatchFile_postHandler_employeeBasic
rel001_employeePanel_updateUI
function rel001_employeePanel_uploadBatch_employeeContact()
{
	rel001_employeePanel_uploadBatch_employeeContact_selected = true;
	
	$('#rel001_employeePanel_uploadInput').click();
} // .end of rel001_employeePanel_uploadBatch_employeeContact	

function rel001_employeePanel_validateBatchFile_employeeContact()
{
	// Reset
	rel001_employeePanel_uploadBatch_employeeContact_selected = false;
	// Get selected file
	var files = $('#rel001_employeePanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_employeePanel_validateBatchFile_postHandler_employeeContact);
	}
	
	// Reset
   	rel001_employeePanel_systemResetFileUpload = true;
	$('#rel001_employeePanel_uploadInput').val("");
} // .end of rel001_employeePanel_validateBatchFile_employeeContact

function rel001_employeePanel_validateBatchFile_postHandler_employeeContact(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = employeeUtil_processBatchUpload_employeeContact(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	// Update UI
	mw_previewUpload_employeeContact_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_employeePanel_validateBatchFile_postHandler_employeeContact

function rel001_employeePanel_uploadBatch_employeeEmail()
{
	rel001_employeePanel_uploadBatch_employeeEmail_selected = true;
	
	$('#rel001_employeePanel_uploadInput').click();
} // .end of rel001_employeePanel_uploadBatch_employeeEmail	

function rel001_employeePanel_validateBatchFile_employeeEmail()
{
	// Reset
	rel001_employeePanel_uploadBatch_employeeEmail_selected = false;
	// Get selected file
	var files = $('#rel001_employeePanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_employeePanel_validateBatchFile_postHandler_employeeEmail);
	}
	
	// Reset
   	rel001_employeePanel_systemResetFileUpload = true;
	$('#rel001_employeePanel_uploadInput').val("");
} // .end of rel001_employeePanel_validateBatchFile_employeeEmail

function rel001_employeePanel_validateBatchFile_postHandler_employeeEmail(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = employeeUtil_processBatchUpload_employeeEmail(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	// Update UI
	mw_previewUpload_employeeEmail_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_employeePanel_validateBatchFile_postHandler_employeeEmail

function rel001_employeePanel_uploadBatch_employeeAddress()
{
	rel001_employeePanel_uploadBatch_employeeAddress_selected = true;
	
	$('#rel001_employeePanel_uploadInput').click();
} // .end of rel001_employeePanel_uploadBatch_employeeAddress	

function rel001_employeePanel_validateBatchFile_employeeAddress()
{
	// Reset
	rel001_employeePanel_uploadBatch_employeeAddress_selected = false;
	// Get selected file
	var files = $('#rel001_employeePanel_uploadInput')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], rel001_employeePanel_validateBatchFile_postHandler_employeeAddress);
	}
	
	// Reset
   	rel001_employeePanel_systemResetFileUpload = true;
	$('#rel001_employeePanel_uploadInput').val("");
} // .end of rel001_employeePanel_validateBatchFile_employeeAddress

function rel001_employeePanel_validateBatchFile_postHandler_employeeAddress(success, base64, fileName, fileType, fileSize)
{
	// Show Overlay
	tycheesOverlay_startShortProgress('Preprocessing file...');
	// Get values
	var params = employeeUtil_processBatchUpload_employeeAddress(base64);
	if (params == false) {
		tycheesOverlay_stopShortProgress();
		swal("Opppss!", "We are unable to parse the file correctly. Please double check with the downloaded copy.", "error");
		return false;
	}
	// Update UI
	mw_previewUpload_employeeAddress_updateUI(params);
	// Hide Progress
	tycheesOverlay_stopShortProgress();
} // .end of rel001_employeePanel_validateBatchFile_postHandler_employeeAddress

function rel001_employeePanel_downloadBatch_employeeBasic()
{
	rel001_employeePanel_preDownload_show(rel001_employeePanel_employeeTypeList, rel001_employeePanel_downloadBatch_employeeBasic_step1);
} // .end of rel001_employeePanel_downloadBatch_employeeBasic

function rel001_employeePanel_downloadBatch_employeeBasic_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'employeeTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadEmployees(requestBody, rel001_employeePanel_downloadBatch_employeeBasic_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_employeePanel_downloadBatch_employeeBasic_step1

function rel001_employeePanel_downloadBatch_employeeBasic_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_employeePanel_downloadBatch_employeeBasic_postHandler

function rel001_employeePanel_downloadBatch_employeeContacts()
{
	rel001_employeePanel_preDownload_show(rel001_employeePanel_employeeTypeList, rel001_employeePanel_downloadBatch_employeeContacts_step1);
} // .end of rel001_employeePanel_downloadBatch_employeeContacts

function rel001_employeePanel_downloadBatch_employeeContacts_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'employeeTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadEmployeeContacts(requestBody, rel001_employeePanel_downloadBatch_employeeContacts_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_employeePanel_downloadBatch_employeeContacts_step1

function rel001_employeePanel_downloadBatch_employeeContacts_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_employeePanel_downloadBatch_employeeContacts_postHandler

function rel001_employeePanel_downloadBatch_employeeEmails()
{
	rel001_employeePanel_preDownload_show(rel001_employeePanel_employeeTypeList, rel001_employeePanel_downloadBatch_employeeEmails_step1);
} // .end of rel001_employeePanel_downloadBatch_employeeEmails

function rel001_employeePanel_downloadBatch_employeeEmails_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'employeeTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadEmployeeEmails(requestBody, rel001_employeePanel_downloadBatch_employeeEmails_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_employeePanel_downloadBatch_employeeEmails_step1

function rel001_employeePanel_downloadBatch_employeeEmails_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_employeePanel_downloadBatch_employeeEmails_postHandler

function rel001_employeePanel_downloadBatch_employeeAddresses()
{
	rel001_employeePanel_preDownload_show(rel001_employeePanel_employeeTypeList, rel001_employeePanel_downloadBatch_employeeAddresses_step1);
} // .end of rel001_employeePanel_downloadBatch_employeeAddresses

function rel001_employeePanel_downloadBatch_employeeAddresses_step1(proceedToDownload, selectedTypeList)
{
	if (selectedTypeList == null) {
		swal("Opppss!", "Something went wrong! Please let us know this asap!", "error");
		return false;
	}
	
	if (proceedToDownload) {
		
		var requestBody = {
			'appName': APP_NAME_RELATION,
			'employeeTypeList': selectedTypeList.toString()
		};
		
		var params = new Object();
		
		// Batch Download Request
		tycheesdb_api_batchDownloadEmployeeAddresses(requestBody, rel001_employeePanel_downloadBatch_employeeAddresses_postHandler, params);
		
		//  Show message
		swal({
			type: 'success',
		    title: 'Preprocessing in Progress',
			text: 'We will notify (few minutes) you once the batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	}
} // .end of rel001_employeePanel_downloadBatch_employeeAddresses_step1

function rel001_employeePanel_downloadBatch_employeeAddresses_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
} // .end of rel001_employeePanel_downloadBatch_employeeAddresses_postHandler

/**
 * Common Action Delegate
 */
function rel001_employeePanel_executeAction(actionName, params)
{
    if (actionName == REL001_02_ACTION_OPEN_POS_BY_CUSTOMER)
    {
        var employeeId = '';
        if (params==null) 
        {
            employeeId = $('#rel001_employeePanel_employeeId').val();
        }
        else
        {
        	employeeId = params;
        }
        
        var employeeObj = Cached_getEmployeeById( employeeId );
        
        if (employeeObj != null)
        {
            var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING) + '?' + PARAMETER_NAME_OPEN_BY_CUSTOMER_ID + '=' + employeeId ;
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
            billingId = $('#rel001_employeePanel_billingId').val();
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
    	var selectedProfileId = $('#rel001_employeePanel_tab_profiles_select').val();
        rel001_employeePanel_mw007_show( selectedProfileId );
    } // .end of REL001_02_ACTION_ADD_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_ADD_PROFILE)
    {
        rel001_employeePanel_mw003_show();
    } // .end of REL001_02_ACTION_ADD_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_EDIT_PROFILE)
    {
    	var selectedProfileId = $('#rel001_employeePanel_tab_profiles_select').val();
        rel001_employeePanel_mw004_show( selectedProfileId );
    } // .end of REL001_02_ACTION_EDIT_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_DELETE_PROFILE)
    {
    	var profileId = $('#rel001_employeePanel_tab_profiles_select').val();
    	
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
    		  		$.each(rel001_employeePanel_employeeObj.profileList, function(i, profileObj){
    		  			if (profileObj.id == profileId)
    		  			{
    		  			    Cached_deleteBean(profileObj);
    	    		  		
    	    		  		// Save to IndexedDB
    	    		    	tycheesIO_saveBean(rel001_employeePanel_employeeObj);
    	    		  		// Refresh UI
    	    		    	rel001_employeePanel_showEmployee(rel001_employeePanel_employeeObj.id);
    		  			}
    		  		});
    		  	}
    		});
    } // .end of REL001_02_ACTION_DELETE_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_ADD_PROPERTIES)
    {
        var selectedProfileId = $('#rel001_employeePanel_tab_profiles_select').val();
        rel001_employeePanel_mw005_show( selectedProfileId );
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_EDIT_PROPERTIES)
    {
    	var profileId = $('#rel001_employeePanel_tab_profiles_select').val();
		var propertiesId = params;
		
        rel001_employeePanel_mw006_show(profileId, propertiesId);
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_DELETE_PROPERTIES)
    {
		var profileId = $('#rel001_employeePanel_tab_profiles_select').val();
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
    		  		var profileObj = Cached_getEmployeeProfileById(rel001_employeePanel_employeeObj.id, profileId);
    		  		
    		  		$.each(profileObj.propertiesList, function(i, propObj){
    		  			if (propObj.id == propertiesId)
    		  			{
    		  			    Cached_deleteBean(propObj);
    	    		  		
    	    		  		// Save to IndexedDB
    	    		    	tycheesIO_saveBean(rel001_employeePanel_employeeObj);
    	    		  		// Refresh UI
    	    		    	rel001_employeePanel_showEmployee(rel001_employeePanel_employeeObj.id);
    		  			}
    		  		});
    		  	}
    		});
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
} // .end of rel001_employeePanel_executeAction

/**
 * Add employee details as table row into DataTable.
 *
 * @param   {EmployeeBean} employeeObj - Employee Object
 */
function rel001_employeePanel_updateUI_addEmployeeIntoDataTable(employeeObj) 
{	
    if (employeeObj == null)
        return false;

    // Col #1
	var profileImage = employeeObj.profileImageUrl;
	if ($.trim(profileImage)=='')
		profileImage = 'https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png';
	var htmlLines_col1 = '';
	htmlLines_col1 += '<span class="client-avatar" style="padding-right:5px;">';
	htmlLines_col1 += '<img alt="image" src="' + profileImage + '" style="width:22px; height:22px;">'; 
	htmlLines_col1 += '</span>';
	htmlLines_col1 += '<a onclick="rel001_employeePanel_showEmployee(\'' + employeeObj.id +'\');" class="client-link">';
	htmlLines_col1 += (employeeObj.firstName + ' ' + employeeObj.lastName);
	htmlLines_col1 += '</a>';
	
	// Col #2
	var htmlLines_col2 = '';
	htmlLines_col2 += '<a onclick="rel001_employeePanel_showEmployee(\'' + employeeObj.id +'\');" class="client-link">';
	htmlLines_col2 += $.trim(employeeObj.employeeNo)=='' ? 'N/A' : $.trim(employeeObj.employeeNo);
	htmlLines_col2 += '</a>';

    // Col #3
    var htmlLines_col3 = '';
    htmlLines_col3 += $.trim(employeeObj.templateName) == '' ? '-' : $.trim(employeeObj.templateName);
    
	// Col #4
	var htmlLines_col4 = '';
	htmlLines_col4 += $.trim(employeeObj.contact)=='' ? 'N/A' : $.trim(employeeObj.contact);
	
	// Col #5
	var htmlLines_col5 = '';
	htmlLines_col5 += $.trim(employeeObj.email)=='' ? 'N/A' : $.trim(employeeObj.email);

	// Col #6
	var htmlLines_col6 = '';
	htmlLines_col6 += $.trim(employeeObj.area)=='' ? 'N/A' : $.trim(employeeObj.area);
	
	// Col #7
	var htmlLines_col7 = '';
	htmlLines_col7 += '<a onclick="rel001_employeePanel_openBillingByEmployee(\'' + employeeObj.id + '\');" class="btn btn-primary btn-xs" style="margin:0px;">';
	htmlLines_col7 += '<i class="fa fa-shopping-bag" aria-hidden="true"></i>';
	htmlLines_col7 += '</a> ';
	htmlLines_col7 += '<a onclick="rel001_employeePanel_deleteEmployee(\'' + employeeObj.id + '\');" class="btn btn-danger btn-xs" style="margin:0px;">';
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
	
	$('#rel001_employeePanel_dataTable_employee').dataTable().fnAddData(tableRow, false);
} // .end of rel001_employeePanel_updateUI_addEmployeeIntoDataTable
	    
function rel001_employeePanel_openBillingByEmployee(employeeId)
{
	if ($.trim(employeeId)=='')
		return false;
	
	// Set billing ID to localstorage
	localStorage.setItem(OPEN_FROM_SEARCH_CUSTOMER_ID, $.trim(employeeId));
	
	var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING);
	window.open(location, '_self');
} // .end of rel001_employeePanel_openBillingByEmployee
	    
function rel001_employeePanel_deleteEmployee(employeeId)
{    
    var employeeObj = Cached_getEmployeeById(employeeId);
    if (employeeObj != null)
    {
        swal({
            title: "Are you sure?",
            text: "You will not be able to recover this employee!",
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
        			'employeeId': employeeId,
        			'fullBean': true
        		};
        	
        	var params = new Object();
        	params.employeeId = employeeId;
        	
        	tycheesdb_api_getEmployeeById(requestBody, rel001_employeePanel_deleteEmployee_postHandler, params);
        });
    }	
} // .end of rel001_employeePanel_deleteEmployee
	
function rel001_employeePanel_deleteEmployee_postHandler(success, responseObj, params)
{
	if (success) 
	{    	
		Cached_updateEmployee(responseObj.employeeObj);

        // Delete from localDB
        Cached_deleteBean(responseObj.employeeObj);
    	tycheesIO_saveBean(responseObj.employeeObj);
    	
    	// Update UI
    	rel001_employeePanel_updateUI(false);    	
    	
        // Show message
        swal("Deleted!", "Employee record has been deleted.", "success");		
	}
} // .end of rel001_employeePanel_deleteEmployee_postHandler

/**
 * Display employee details on employee pane (right-most pane).
 *
 * @param   {String} employeeId - Employee ID
 * @param   {String} profileId - Employee Profile ID
 */
function rel001_employeePanel_showEmployee(employeeId, profileId)
{
	 rel001_employeePanel_sw001_updateUI(employeeId, profileId);
} // .end of rel001_employeePanel_showEmployee
	    	    
</script>