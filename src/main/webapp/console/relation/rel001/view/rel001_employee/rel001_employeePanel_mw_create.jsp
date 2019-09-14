
<!-- Modal Window: Add Employee -->
<div class="modal inmodal fade" id="rel001_employeePanel_mw_create" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW EMPLOYEE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_employeePanel_mw_create_modalBody" class="modal-body">
			    
			    <div class="row">
			    	<div class="col-lg-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Import Template</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="rel001_employeePanel_mw_create_templateList" onchange="rel001_employeePanel_mw_create_templateChanged();"></select>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div>
								    	<ul class="list-group clear-list" style="padding:0px; margin: 0px;">
								          	<span id="rel001_employeePanel_mw_create_templatePropertiesList"></span>
								        </ul>
								    </div>
                            	</form>
                        	</div>
						</div>
					</div>
	                <div class="col-lg-7">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">	                                		
	                                		<span class="mandatory-field">* </span>
	                                		Employee No.
	                                	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_employeePanel_mw_create_employeeNo">
	                                    	<span id="rel001_employeePanel_mw_create_employeeNo_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    	<span id="rel001_employeePanel_mw_create_employeeNo_duplicate_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Duplicated Employee Number Found. 
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		<span class="mandatory-field">* </span>
	                                		First Name
	                                	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_employeePanel_mw_create_firstName">
	                                    	<span id="rel001_employeePanel_mw_create_firstName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">	                                		
	                                		<span class="mandatory-field">* </span>
	                                		Last Name
	                                	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_employeePanel_mw_create_lastName">
	                                    	<span id="rel001_employeePanel_mw_create_lastName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Gender</label>
	                                    <div class="col-sm-8 rel001_employeePanel_mw_create_i-checks">
	                                    	<label class="checkbox-inline i-checks"> <input type="radio" value="Male" id="rel001_employeePanel_mw_create_gender_male" name="rel001_employeePanel_mw_create_gender"> Male </label>
                                            <label class="checkbox-inline i-checks"> <input type="radio" value="Female" id="rel001_employeePanel_mw_create_gender_female" name="rel001_employeePanel_mw_create_gender"> Female </label>
	                                    	<span id="rel001_employeePanel_mw_create_gender_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Selection.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Date of Birth</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_employeePanel_mw_create_dob" data-mask="99/99/9999" aria-invalid="false">
	                                    	<span id="rel001_employeePanel_mw_create_dob_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Phone Number</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_employeePanel_mw_create_phone">
	                                    	<span id="rel001_employeePanel_mw_create_phone_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Email</label>
	                                    <div class="col-sm-8">
	                                    	<input type="email" class="form-control" id="rel001_employeePanel_mw_create_email">
	                                    	<span id="rel001_employeePanel_mw_create_email_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" id="rel001_employeePanel_mw_create_close" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" id="rel001_employeePanel_mw_create_save" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="rel001_employeePanel_mw_create_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_employeePanel_mw_create_initialized = false;
var rel001_employeePanel_mw_create_systemGeneratedEmployeeNo;

/**
 * Init components and variables.
 */
function rel001_employeePanel_mw_create_init()
{
    if (rel001_employeePanel_mw_create_initialized == true)
        return false;
    
    $('.rel001_employeePanel_mw_create_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_employeePanel_mw_create').on('shown.bs.modal', function () {
		// Generate next employee Number
	    rel001_employeePanel_mw_create_systemGeneratedEmployeeNo = consoleCommon_getNextEmployeeNo();
	    $('#rel001_employeePanel_mw_create_employeeNo').val( rel001_employeePanel_mw_create_systemGeneratedEmployeeNo );
	    $("#rel001_employeePanel_mw_create_employeeNo").focus();
	});
    
	rel001_employeePanel_mw_create_initialized = true;
} // .end of rel001_employeePanel_mw_create_init

function rel001_employeePanel_hideErrors() 
{
	$('#rel001_employeePanel_mw_create_employeeNo_error').hide();
    $('#rel001_employeePanel_mw_create_employeeNo_duplicate_error').hide();
    $('#rel001_employeePanel_mw_create_firstName_error').hide();
    $('#rel001_employeePanel_mw_create_lastName_error').hide();
    $('#rel001_employeePanel_mw_create_gender_error').hide();
    $('#rel001_employeePanel_mw_create_dob_error').hide();
    $('#rel001_employeePanel_mw_create_phone_error').hide();
    $('#rel001_employeePanel_mw_create_email_error').hide();   
} // .end of rel001_employeePanel_hideErrors

function rel001_employeePanel_mw_create_show()
{
    rel001_employeePanel_mw_create_updateUI();
} // .end of rel001_employeePanel_mw_create_show

function rel001_employeePanel_mw_create_updateUI()
{
    rel001_employeePanel_mw_create_init();
        
    // Hide
    rel001_employeePanel_hideErrors();  
    // Reset
    $('#rel001_employeePanel_mw_create_employeeNo').val('');
    $('#rel001_employeePanel_mw_create_firstName').val('');
    $('#rel001_employeePanel_mw_create_lastName').val('');
    $('#rel001_employeePanel_mw_create_gender_male').iCheck('uncheck');
    $('#rel001_employeePanel_mw_create_gender_female').iCheck('uncheck');
    $('#rel001_employeePanel_mw_create_dob').val('');
    $('#rel001_employeePanel_mw_create_phone').val('');
    $('#rel001_employeePanel_mw_create_email').val('');
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var sortedList = [];
    $.each(placeObj.templateList, function(i, templateObj){
		if (Cached_isDeletedBean(templateObj))
			return true;
		
    	if (templateObj.moduleId == ModuleConstants.MODULE_RELATION &&
       		templateObj.templateType == PlaceConstants.TEMPLATE_TYPE_EMPLOYEE)
       	{
    		sortedList.push(templateObj);
       	}
    });
    
 	// Sort list, by template name
    sortedList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.templateName, b.templateName);
		});
    
 	// Populate Template List
    $('#rel001_employeePanel_mw_create_templateList').empty();
    $('#rel001_employeePanel_mw_create_templateList').append('<option value="">-- USE NO TEMPLATE --</option>')
    $.each(sortedList, function(i, templateObj){
    	
    	var selectedVal = '';
    	if (templateObj.defaultTemplate)
    		selectedVal = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + templateObj.id + '" ' + selectedVal + '>';
    	htmlLines += templateObj.templateName;
    	htmlLines += '</option>';
    	
    	$('#rel001_employeePanel_mw_create_templateList').append( htmlLines );
    });
    
    rel001_employeePanel_mw_create_templateChanged();
 	
    // Show Modal Window
    module_showModalWindow('rel001_employeePanel_mw_create', true);
} // .end of rel001_employeePanel_mw_create_updateUI

/**
 * Event listener for template selection changed.
 */
function rel001_employeePanel_mw_create_templateChanged()
{
    var templateId  = $.trim( $("#rel001_employeePanel_mw_create_templateList").val() );
    if (templateId=='')
    {
    	$('#rel001_employeePanel_mw_create_templatePropertiesList').empty();
    	return false;
    }
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.templateList, function(i, templateObj){
    	if (templateObj.id == templateId)
    	{
    	    rel001_employeePanel_mw_create_showTemplate( templateObj );
    	    
    	    return false;
    	}
    });
} // .end of rel001_employeePanel_mw_create_templateChanged

/**
 * Display all properties inside template object.
 *
 * @param	{CommonTemplateBean} templateObj - Employee Template Object
 */
function rel001_employeePanel_mw_create_showTemplate(templateObj)
{
	// Clear list of properties
	if (templateObj == null)
		return false;
	
	// Extract & Process List
    var sortedList = [];
    $.each(templateObj.propertiesList, function(i, propObj){
    	sortedList.push(propObj);
    });
    // Sort list, by seqno
    sortedList.sort(
		function(a, b){ 
			return tycheesList_sortByNumber(a.propSeqno, b.propSeqno);
		});

    var lastGroupName = '$TEMP_VALUE$';
	$('#rel001_employeePanel_mw_create_templatePropertiesList').empty();
	$.each(sortedList, function(j, propObj){

		if (Cached_isDeletedBean(propObj))
			return true;
		
		if (lastGroupName != propObj.groupName)
    	{
			var groupName = propObj.groupName=='' ? 'No Group' : propObj.groupName;
    			    	    
    	    var dividerHtmlLines = '';		    	    
    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding:3px 10px;">';
    	    dividerHtmlLines += groupName;
    	    dividerHtmlLines += '</li>';	    	    
    	    $('#rel001_employeePanel_mw_create_templatePropertiesList').append(dividerHtmlLines);
    	    
			// For next iteration
    	    lastGroupName = propObj.groupName;	
    	}
		
		// Get input component in HTML
		var htmlLines = employeeCommon_createInputComponent(propObj, false);
		$('#rel001_employeePanel_mw_create_templatePropertiesList').append(htmlLines);
	});
} // .end of rel001_employeePanel_mw_create_showTemplate

/**
 * Save user's inputs as new employee object.
 */
function rel001_employeePanel_mw_create_save()
{
	// hide errors
	rel001_employeePanel_hideErrors();
	// Get employee no
    var employeeNo = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_employeeNo").val() );
    var firstName  = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_firstName").val() );
    var lastName   = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_lastName").val() );
   
    // Validation
    if (employeeNo=='') {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Employee No.');
        $('#rel001_employeePanel_mw_create_employeeNo_error').show();
        return false;
    }
    if (firstName=='') {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for First Name.');
        $('#rel001_employeePanel_mw_create_firstName_error').show();
        return false;
    }
    if (lastName=='') {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Last Name.');
        $('#rel001_employeePanel_mw_create_lastName_error').show();
        return false;
    }
   
    // Show progress
 	$('#rel001_employeePanel_mw_create_save').ladda().ladda('start');
    
    // Prepare request body
	var requestBody = {
			'appName': APP_NAME_RELATION,
			'employeeNo': employeeNo,
			'lastSyncedTime': 0,
			'fullBean': true
		};
	
	var params = new Object();
	params.employeeNo = employeeNo;
	
	tycheesdb_api_getEmployeeByEmployeeNo(requestBody, rel001_employeePanel_mw_create_save_postHandler, params);    
    
} // .end of rel001_employeePanel_mw_create_save

function rel001_employeePanel_mw_create_save_postHandler(success, responseObj, params) 
{
 	// Hide Progress
	$('#rel001_employeePanel_mw_create_save').ladda().ladda('stop');	 
 	
	if (!success) {	
		swal ('Oops', 'Something went wrong!', 'error');
		return false;
	}

	if (responseObj.employeeObj != null) {
		$('#rel001_employeePanel_mw_create_employeeNo_duplicate_error').show();
		return false;
	}
	
	var placeObj     = tycheesCommon_getCurrentPlaceObject();
    var templateId   = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_templateList").val() );
    var templateName = '';
    var employeeNo   = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_employeeNo").val() );
    var firstName    = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_firstName").val() );
    var lastName     = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_lastName").val() );
    var gender       = tycheesText_getSafeString( $('input[name="rel001_employeePanel_mw_create_gender"]:checked').val() );
    var dob          = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_dob").val() );
    var phone        = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_phone" ).val() );
    var email        = tycheesText_getSafeString( $("#rel001_employeePanel_mw_create_email" ).val() );
   
    $.each(placeObj.templateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
    	if (templateObj.id == templateId)
    		templateName = $.trim(templateObj.templateName);
    });
    
    // IF   system generated EmployeeNo is being used, 
 	// THEN update system about next employee no. 
 	if ($.trim(employeeNo)==$.trim(rel001_employeePanel_mw_create_systemGeneratedEmployeeNo))
 	{
 		consoleCommon_updateNextEmployeeNo();
 	}
 
	// Employee contact object
    var newContactObj = createNew_EmployeeContact();
    newContactObj.countryCode = '';
    newContactObj.areaCode = '';
    newContactObj.phoneNumber = phone;
    newContactObj.extension = '';
    newContactObj.defaultContact = true;
    
    // Employee email object
    var newEmailObj = createNew_EmployeeEmail();
    newEmailObj.emailAddress = email;	
    newContactObj.primaryEmail = true;

    // Employee object
    var newEmployeeObj = createNew_Employee();
    newEmployeeObj.employeeNo = employeeNo;	
    newEmployeeObj.firstName = firstName;
    newEmployeeObj.lastName = lastName;
    newEmployeeObj.dob = tycheesDateTime_toMilliseconds_ddMMyyyy(dob) == 0 ? null : tycheesDateTime_toMilliseconds_ddMMyyyy(dob);
    newEmployeeObj.gender = gender;
    newEmployeeObj.contact = tycheesBean_toString_commonContactBean(newContactObj);
    newEmployeeObj.email = $.trim(newEmailObj.emailAddress);
    newEmployeeObj.templateId = templateId;
    newEmployeeObj.templateName = templateName;
    
    // Push into list
    newEmployeeObj.contactList.push(newContactObj);
    newEmployeeObj.emailList.push(newEmailObj);
    
    // Copy from Template's properties, to Employee's custom field, if any.
    $.each(placeObj.templateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
    	if (templateObj.id == templateId)
    	{
    	    $.each(templateObj.propertiesList, function(j, templatePropObj) {
            	if (Cached_isDeletedBean(templatePropObj))
            		return true;
            	
    	        var newPropObj = createNew_EmployeeProperties();
    	        newPropObj.groupName = templatePropObj.groupName;
    	        newPropObj.propName = templatePropObj.propName;
    	        newPropObj.propKey = templatePropObj.propKey;
    	        newPropObj.propType = templatePropObj.propType;
    	        newPropObj.propContent = templatePropObj.propContent;
    	        newPropObj.propValue = employeeCommon_getInputComponentValue(templatePropObj);
    	        newPropObj.remarks = templatePropObj.remarks;
    	        
    	        newEmployeeObj.propertiesList.push( newPropObj );
    	    });
    	}
    });
    
    // Hide modal window
    $("#rel001_employeePanel_mw_create").modal('hide');
    
    // Update List
    Cached_addEmployee( newEmployeeObj );
    
    // Save to localDB
    tycheesIO_saveBean( newEmployeeObj );
    
    // Update UI
    rel001_employeePanel_updateUI(false);
} // .end of rel001_employeePanel_mw_create_save_postHandler

</script>