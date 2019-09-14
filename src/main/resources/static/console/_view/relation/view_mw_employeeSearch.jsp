
<!-- 
    Title:			EMPLOYEE WIZARD 
    Desc:			- Show employee list
            		- Create new employee (quick mode)
    Author:			Ryan Chee
    Last Modified:	20171002
-->

<div class="modal inmodal fade" id="mw_employeeSearch" tabindex="-1" role="dialog"  aria-hidden="true" style="z-index:999999;">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">EMPLOYEE SEARCH</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" onclick="mw_employeeSearch_closeWindow();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
			
				<div class="row">
					<div class="col-lg-12">
						<div class="input-group m-b" style="width:720px;margin:0px auto 0px auto;">
							<input id="mw_employeeSearch_searchKeywords" type="text" class="form-control input-lg" style="z-index:10;" placeholder="employee no, name, contact or email...">
		                	<span class="input-group-btn"> 
								<button type="button" class="btn btn-white" style="height:46px;" onclick="mw_employeeSearch_reset();">
									<i class="fa fa-eraser" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-primary" style="height:46px;font-size:13pt;border:0px;" onclick="mw_employeeSearch_showAll();">
									<i class="fa fa-search" aria-hidden="true"></i> Show All
								</button> 
		                	</span>
		            	</div>
					</div>
				</div> <!-- .end of row -->
				<br>
				<div id="mw_employeeSearch_dataTable_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw_employeeSearch_dataTable_spinner_text" style="padding-top:10px; text-align:center;">loading employees...</div>
				</div>
				<div id="mw_employeeSearch_dataTable" class="row">
					<div class="col-md-3">
						<div class="ibox-title">
							<h5>1. Quick Add New Employee</h5>
						</div>
						<div class="ibox-content">
							<div id="mw_employeeSearch_quickAddEmployee">
								<div class="form-group">
		                            <label for="mw_employeeSearch_employeeNoVal">* Employee No</label>
		                            <input type="text" placeholder="Enter employee number" id="mw_employeeSearch_employeeNoVal" class="form-control" required>
		                        </div>
		                        <div class="form-group">
		                            <label for="mw_employeeSearch_firstNameVal">First Name</label>
		                            <input type="text" placeholder="Enter first name" id="mw_employeeSearch_firstNameVal" class="form-control">
		                        </div>
		                        <div class="form-group">
		                            <label for="mw_employeeSearch_lastNameVal">Last Name</label>
		                            <input type="text" placeholder="last name" id="mw_employeeSearch_lastNameVal" class="form-control">
		                        </div>
		                        <div class="form-group">
		                            <label for="mw_employeeSearch_contactNumberVal">Contact No.</label>
		                            <input type="text" placeholder="contact number" id="mw_employeeSearch_contactNumberVal" class="form-control">
		                        </div>
		                        <div>
		                            <button class="btn btn-primary" type="button" onclick="mw_employeeSearch_createNew();">Create Now</button>
		                        </div>
		                        <br/>
		                        <div id="mw_employeeSearch_create_errorText" style="display:none; color:#ff0000; font-size:12pt;">
		                            Error Text	
		                        </div>
							</div>
							<div id="mw_employeeSearch_quickAddEmployee_error" style="text-align:center; display:none;">
								<i class="fa fa-exclamation-triangle modal-icon" aria-hidden="true"></i>
								<br> Usage Limit Exceeded. Please increase the limit at Settings &gt; My Place.
							</div> 
						</div>
					</div>
					<div class="col-md-9">
						<div class="ibox-title">
							<h5>2. Select Employee</h5>
						</div>
						<div class="ibox-content">
							<table id="mw_employeeSearch_dataTable_employee" class="table table-striped table-bordered table-hover">
								<thead>
									<tr id="mw_employeeSearch_dataTable_employee_header">
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
				<button type="button" class="btn btn-danger" onclick="mw_employeeSearch_closeWindow();">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw_employeeSearch_selectNone();">Select None</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_employeeSearch_initialized = false;
var mw_employeeSearch_systemGeneratedEmployeeNo = '';
var mw_employeeSearch_callbackFn;
var mw_employeeSearch_modalWindowSelectorId;
var mw_employeeSearch_employeeNo;

function mw_employeeSearch_isOpen()
{
	return ($("#mw_employeeSearch").data('bs.modal') || {}).isShown;	
} // .end of mw_employeeSearch_isOpen

function mw_employeeSearch_init()
{
	if (mw_employeeSearch_initialized)
		return false;

	$('#mw_employeeSearch').on('shown.bs.modal', function () {
		// Generate next employee Number
	    mw_employeeSearch_systemGeneratedEmployeeNo = consoleCommon_getNextEmployeeNo();
	    $('#mw_employeeSearch_employeeNoVal').val( mw_employeeSearch_systemGeneratedEmployeeNo );
		// Set focus to filter box
		$('#mw_employeeSearch_searchKeywords').val('');
	    $('#mw_employeeSearch_searchKeywords').focus();
		$('#mw_employeeSearch_searchKeywords').select();
	})
	
	$("#mw_employeeSearch_searchKeywords").keypress(function(event) {
	    if ( event.keyCode == 13 ) {
	    	mw_employeeSearch_search();
	    }
	});
	
	// Load table column settings
	var colGenderEnabled	= true;
	var colEmailEnabled 	= true;
	var colContactEnabled	= true;
	var colDobEnabled		= true;
	
	// Setup DataTable header
	$('#mw_employeeSearch_dataTable_employee_header').empty();
	$('#mw_employeeSearch_dataTable_employee_header').append('<th id="row1col1">Employee No</th>');
	$('#mw_employeeSearch_dataTable_employee_header').append('<th>Name</th>');
	if (colGenderEnabled)
		$('#mw_employeeSearch_dataTable_employee_header').append('<th>Gender</th>');
	if (colEmailEnabled)
		$('#mw_employeeSearch_dataTable_employee_header').append('<th>Email</th>');
	if (colContactEnabled)
		$('#mw_employeeSearch_dataTable_employee_header').append('<th>Contact</th>');
	if (colDobEnabled)
		$('#mw_employeeSearch_dataTable_employee_header').append('<th>DOB</th>');
	$('#mw_employeeSearch_dataTable_employee_header').append('<th class="text-right">Action</th>');
	
	// Get user's preference on page length
 	var dataTable_pageLength = 10; 
 	var foundPropObj;
 	var userObj = tycheesCommon_getCurrentUserObject();
 	
 	$.each(userObj.propertiesList, function(i, propObj) {
 		if (Cached_isDeletedBean(propObj))
 			return true;
 		
 		if (propObj.propKey == UserConstants.PREF_SEARCH_EMPLOYEE_VIEW_SIZE && 
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
 		newPropObj.propKey = UserConstants.PREF_SEARCH_EMPLOYEE_VIEW_SIZE;
 		newPropObj.propName = UserConstants.PREF_SEARCH_EMPLOYEE_VIEW_SIZE;
 		newPropObj.propType = 'Number';
 		newPropObj.propContent = '';
 		newPropObj.propValue = dataTable_pageLength;
 		
 		userObj.propertiesList.push(newPropObj);
 		tycheesIO_saveBean(userObj);
 	}
	 	
	// Init dataTable (employee Modal Dialog)
	$("#mw_employeeSearch_dataTable_employee").DataTable({
    	"pageLength": dataTable_pageLength
    });	
	// Add event handler on page length changed.
	$("#mw_employeeSearch_dataTable_employee").on('length.dt', function(e, settings, lens) {
    	var userObj = tycheesCommon_getCurrentUserObject();
    	$.each(userObj.propertiesList, function(i, propObj) {
    		if (Cached_isDeletedBean(propObj))
    			return true;
    		
    		if (propObj.propKey == UserConstants.PREF_SEARCH_EMPLOYEE_VIEW_SIZE && 
   	 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
    			propObj.hasChanged = true;
    			propObj.propValue = lens.toString();
    		}
    	});
    	
		tycheesIO_saveBean(userObj);
    });
	// Remove padding of DataTable
	$('#mw_employeeSearch_dataTable_employee_wrapper').css('padding', '0px');

	// Check if reach max count of employee
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
		$('#mw_employeeSearch_quickAddEmployee').hide();
		$('#mw_employeeSearch_quickAddEmployee_error').show();
	} else {
		$('#mw_employeeSearch_quickAddEmployee').show();
		$('#mw_employeeSearch_quickAddEmployee_error').hide();
	}
		
	mw_employeeSearch_initialized = true;
} // .end of mw_employeeSearch_init

function mw_employeeSearch_show(callbackFn, modalWindowSelectorId, selectedEmployeeNo)
{
	if (callbackFn == null) {
		tycheesLogger_logError('Null callbackFn found: ' + callbackFn, 'mw_employeeSearch_show');
		tycheesLogger_showToast('error', 'System Error', 'Undefined callbackFn found: ' + callbackFn);
		return false;
	}
		
	// Set callback function
	mw_employeeSearch_callbackFn = callbackFn;
	// Set calling Modal Window Selector ID
	mw_employeeSearch_modalWindowSelectorId = $.trim(modalWindowSelectorId);
	// Set employee ID
	mw_employeeSearch_employeeNo = $.trim(selectedEmployeeNo);
	// Show window
	mw_employeeSearch_updateUI();
} // .end of mw_employeeSearch_show

function mw_employeeSearch_updateUI()
{
	// Hide caller modal window
	if (mw_employeeSearch_modalWindowSelectorId != '')
		$('#'+mw_employeeSearch_modalWindowSelectorId).hide();
	
	mw_employeeSearch_init();
	
	// Default: show all
	mw_employeeSearch_showAll();
	
	// Show Modal Window
	module_showModalWindow('mw_employeeSearch', true);
} // .end of mw_employeeSearch_updateUI

function mw_employeeSearch_showAll()
{
	// Show/Hide
	$('#mw_employeeSearch_dataTable').hide();
	$('#mw_employeeSearch_dataTable_spinner').show();
	$('#mw_employeeSearch_dataTable_spinner_text').html('loading employees...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': false
	};
	
	var params = new Object();
	
	// Call API
	tycheesdb_api_getEmployeesByPlace(requestBody, mw_employeeSearch_showResult, params);
} // .end of mw_employeeSearch_showAll

function mw_employeeSearch_search()
{
	// Show/Hide
	$('#mw_employeeSearch_dataTable').hide();
	$('#mw_employeeSearch_dataTable_spinner').show();
	$('#mw_employeeSearch_dataTable_spinner_text').html('loading employees...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': false,
		'keywords': $.trim( $('#mw_employeeSearch_searchKeywords').val() )
	};
	
	var params = new Object();
	
	// Call API
	tycheesdb_api_getEmployeesByKeywords(requestBody, mw_employeeSearch_showResult, params);
} // .end of mw_employeeSearch_search

function mw_employeeSearch_reset()
{	
	// Reset
	$('#mw_employeeSearch_searchKeywords').val('');
    $('#mw_employeeSearch_searchKeywords').focus();
	$('#mw_employeeSearch_searchKeywords').select();
	// Clear results
	$('#mw_employeeSearch_dataTable_employee').DataTable().clear().draw();	
} // .end of mw_employeeSearch_reset

function mw_employeeSearch_showResult(successFlag, responseObj, params)
{			
	if (successFlag==false)
		return false;
	
	if (!mw_employeeSearch_isOpen())
		return false;
	
	// Show Progressing Message
	$('#mw_employeeSearch_dataTable_spinner_text').html('receiving employees...');
	
	// Set employee records into cache list
	Cached_setEmployeeList( responseObj.employeeList );
	
	// Load table column settings
	var colGenderEnabled	= true;
	var colEmailEnabled 	= true;
	var colContactEnabled	= true;
	var colDobEnabled		= true;
	
	// Reset panel 'Create New Employee'
	$('#mw_employeeSearch_firstNameVal').val('');
	$('#mw_employeeSearch_lastNameVal').val('');
	$('#mw_employeeSearch_contactNumberVal').val('');
	
	// Clear list
	$('#mw_employeeSearch_dataTable_employee').DataTable().clear().draw();
	// Add record into list
	$.each(Cached_getEmployeeList(true), function(i, employeeObj) {
	
		if (Cached_isDeletedBean(employeeObj))
			return true;
		
		var htmlLines_buttonClass = 'btn btn-primary btn-xs ladda-button';
		var htmlLines_onclick = 'onclick="mw_employeeSearch_select(\'' + employeeObj.id + '\');"';
		var htmlLines_buttonText = 'Select';
		if (employeeObj.id == mw_employeeSearch_employeeNo || employeeObj.employeeNo == mw_employeeSearch_employeeNo)
		{
			htmlLines_buttonClass = 'btn btn-gray btn-xs ladda-button';
			htmlLines_onclick = '';
			htmlLines_buttonText = 'Selected';
		}
	
		var htmlLines_selectButton = '';
		htmlLines_selectButton += '<span class="text-right">';
		htmlLines_selectButton += '<button id="selectBtn-' + employeeObj.id + '" class="' + htmlLines_buttonClass + '" data-style="zoom-in" style="width:100%;vertical-align:middle;" ' + htmlLines_onclick + '> ' + htmlLines_buttonText + '</button>';
		htmlLines_selectButton += '</span>';
	
		var rowSet = [];
		rowSet.push( $.trim(employeeObj.employeeNo).length==0 ? '-' : employeeObj.employeeNo );
		rowSet.push( $.trim(employeeObj.firstName) + ' ' + $.trim(employeeObj.lastName) );
		
		if (colGenderEnabled)
			rowSet.push( employeeObj.gender );
		if (colEmailEnabled)
			rowSet.push( employeeObj.email );
		if (colContactEnabled)
			rowSet.push( employeeObj.contact );
		if (colDobEnabled)
			rowSet.push( tycheesDateTime_getFormattedDate_ddMMyyyy(employeeObj.dob) );
			
		rowSet.push( htmlLines_selectButton );
	
		$("#mw_employeeSearch_dataTable_employee").dataTable().fnAddData( rowSet, false );
	});
	
	// Show/Hide
	$('#mw_employeeSearch_dataTable').show();
	$('#mw_employeeSearch_dataTable_spinner').hide();
	
	// Show Modal Window
	module_showModalWindow('mw_employeeSearch', true);
	
	// Generate next employee Number
    mw_employeeSearch_systemGeneratedEmployeeNo = consoleCommon_getNextEmployeeNo();
    $('#mw_employeeSearch_employeeNoVal').val( mw_employeeSearch_systemGeneratedEmployeeNo );
    
	// Redraw DataTable
	$("#mw_employeeSearch_dataTable_employee").DataTable().draw();	
} // .end of mw_employeeSearch_updateUI

/**
 * User selects none as employee.
 */
function mw_employeeSearch_selectNone()
{	
	// Show window
	$('#mw_employeeSearch').modal('hide');
	// Show Modal Window
	if (mw_employeeSearch_modalWindowSelectorId != '') 
		$('#'+mw_employeeSearch_modalWindowSelectorId).show();
	// Trigger callback function
	mw_employeeSearch_callbackFn();
} // .end of mw_employeeSearch_selectNone

/**
 * User select custommer.
 */
function mw_employeeSearch_select(employeeId)
{
	$('#selectBtn-'+employeeId).ladda().ladda('start');
	
	var requestBody = {
			'appName': APP_NAME_POS,
			'employeeId': employeeId,
			'fullBean': true	
		};	

	var params = new Object();
	params.employeeId = employeeId;
	
	tycheesdb_api_getEmployeeById(requestBody, mw_employeeSearch_select_postHandler, params);
} // .end of mw_employeeSearch_select

function mw_employeeSearch_select_postHandler(success, responseObj, params)
{
	$('#selectBtn-'+params.employeeId).ladda().ladda('stop');
	
	if (!success)
		return false;
	
	// Hide window
	$('#mw_employeeSearch').modal('hide');
	// Show Modal Window
	if (mw_employeeSearch_modalWindowSelectorId != '') 
		$('#'+mw_employeeSearch_modalWindowSelectorId).show();
	// Trigger callback function
	mw_employeeSearch_callbackFn(responseObj.employeeObj);	
} // .end of mw_employeeSearch_select_postHandler

function mw_employeeSearch_closeWindow() 
{
	// Show window
	$('#mw_employeeSearch').modal('hide');
	// Show Modal Window
	if (mw_employeeSearch_modalWindowSelectorId != null) 
		$('#'+mw_employeeSearch_modalWindowSelectorId).show();
} // .end of mw_employeeSearch_closeWindow

/**
 * User create new custommer (quick form).
 */
function mw_employeeSearch_createNew()
{	
	// Reset
	$('#mw_employeeSearch_create_errorText').hide();
	// Get user inputs
	var employeeNo 		= $.trim( $('#mw_employeeSearch_employeeNoVal').val() );
	var firstName 		= $.trim( $('#mw_employeeSearch_firstNameVal').val() );
	var lastName 		= $.trim( $('#mw_employeeSearch_lastNameVal').val() );
	var contactNumber 	= $.trim( $('#mw_employeeSearch_contactNumberVal').val() );

	if (employeeNo.length==0)
	{
		$('#mw_employeeSearch_create_errorText').html('<i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please enter Employee No.');
		$('#mw_employeeSearch_create_errorText').show();
		return false;
	}
	
	// IF   system generated EmployeeNo is being used, 
	// THEN update system about next employee no. 
	if ($.trim(employeeNo)==$.trim(mw_employeeSearch_systemGeneratedEmployeeNo))
	{
		consoleCommon_updateNextEmployeeNo();
	}
		
	// Create object
	var newEmployeeObj = createNew_Employee();
	newEmployeeObj.employeeNo = employeeNo;
	newEmployeeObj.firstName = firstName;
	newEmployeeObj.lastName = lastName;
	newEmployeeObj.contact = contactNumber;
	newEmployeeObj.placeId = tycheesCommon_getCurrentPlaceId();

	var newEmployeeContactObj = createNew_EmployeeContact();
	newEmployeeContactObj.employeeId = newEmployeeObj.id;
	newEmployeeContactObj.type = AppConstants.CONTACT_TYPE_MOBILE;
	newEmployeeContactObj.phoneNumber = contactNumber;
	newEmployeeContactObj.defaultContact = true;
	newEmployeeObj.contactList.push(newEmployeeContactObj);
	
	// Save to localDb
	tycheesIO_saveBean(newEmployeeObj);
	
	// Close window
	$('#mw_employeeSearch').modal('hide');
	// Show Modal Window
	if (mw_employeeSearch_modalWindowSelectorId != '') 
		$('#'+mw_employeeSearch_modalWindowSelectorId).show();
	
	// Trigger callback function
	mw_employeeSearch_callbackFn(newEmployeeObj);		
} // .end of mw_employeeSearch_createNew

</script>