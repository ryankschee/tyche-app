<!-- Modal Window: Add Customer -->
<div class="modal inmodal fade" id="rel001_customerPanel_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW CUSTOMER</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_customerPanel_mw001_modalBody" class="modal-body">
			    
			    <div class="row">
			    	<div class="col-lg-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Import Template</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="rel001_customerPanel_mw001_templateList" onchange="rel001_customerPanel_mw001_templateChanged();"></select>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div>
								    	<ul class="list-group clear-list" style="padding:0px; margin: 0px;">
								          	<span id="rel001_customerPanel_mw001_templatePropertiesList"></span>
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
	                                		Customer No.
	                                	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw001_customerNo">
	                                    	<span id="rel001_customerPanel_mw001_customerNo_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    	<span id="rel001_customerPanel_mw001_customerNo_duplicate_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Duplicated Customer Number Found. 
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
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw001_firstName">
	                                    	<span id="rel001_customerPanel_mw001_firstName_error" style="color:#FF0000;display:none;">
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
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw001_lastName">
	                                    	<span id="rel001_customerPanel_mw001_lastName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Gender</label>
	                                    <div class="col-sm-8 rel001_customerPanel_mw001_i-checks">
	                                    	<label class="checkbox-inline i-checks"> <input type="radio" value="Male" id="rel001_customerPanel_mw001_gender_male" name="rel001_customerPanel_mw001_gender"> Male </label>
                                            <label class="checkbox-inline i-checks"> <input type="radio" value="Female" id="rel001_customerPanel_mw001_gender_female" name="rel001_customerPanel_mw001_gender"> Female </label>
	                                    	<span id="rel001_customerPanel_mw001_gender_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Selection.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Date of Birth</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw001_dob" data-mask="99/99/9999" aria-invalid="false">
	                                    	<span id="rel001_customerPanel_mw001_dob_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Phone Number</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw001_phone">
	                                    	<span id="rel001_customerPanel_mw001_phone_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Email</label>
	                                    <div class="col-sm-8">
	                                    	<input type="email" class="form-control" id="rel001_customerPanel_mw001_email">
	                                    	<span id="rel001_customerPanel_mw001_email_error" style="color:#FF0000;display:none;">
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
		    	<button type="button" id="rel001_customerPanel_mw001_close" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" id="rel001_customerPanel_mw001_save" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="rel001_customerPanel_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_customerPanel_mw001_initialized = false;
var rel001_customerPanel_mw001_systemGeneratedCustomerNo;

/**
 * Init components and variables.
 */
function rel001_customerPanel_mw001_init()
{
    if (rel001_customerPanel_mw001_initialized == true)
        return false;
    
    $('.rel001_customerPanel_mw001_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_customerPanel_mw001').on('shown.bs.modal', function () {
		// Generate next customer Number
	    rel001_customerPanel_mw001_systemGeneratedCustomerNo = consoleCommon_getNextCustomerNo();
	    $('#rel001_customerPanel_mw001_customerNo').val( rel001_customerPanel_mw001_systemGeneratedCustomerNo );
	    $("#rel001_customerPanel_mw001_customerNo").focus();
	});
    
	rel001_customerPanel_mw001_initialized = true;
} // .end of rel001_customerPanel_mw001_init

function rel001_customerPanel_hideErrors() 
{
	$('#rel001_customerPanel_mw001_customerNo_error').hide();
    $('#rel001_customerPanel_mw001_customerNo_duplicate_error').hide();
    $('#rel001_customerPanel_mw001_firstName_error').hide();
    $('#rel001_customerPanel_mw001_lastName_error').hide();
    $('#rel001_customerPanel_mw001_gender_error').hide();
    $('#rel001_customerPanel_mw001_dob_error').hide();
    $('#rel001_customerPanel_mw001_phone_error').hide();
    $('#rel001_customerPanel_mw001_email_error').hide();   
} // .end of rel001_customerPanel_hideErrors

/**
 * Update UI of whole panel. 
 */
function rel001_customerPanel_mw001_updateUI()
{
    rel001_customerPanel_mw001_init();
        
    // Hide
    rel001_customerPanel_hideErrors();  
    // Reset
    $('#rel001_customerPanel_mw001_customerNo').val('');
    $('#rel001_customerPanel_mw001_firstName').val('');
    $('#rel001_customerPanel_mw001_lastName').val('');
    $('#rel001_customerPanel_mw001_gender_male').iCheck('uncheck');
    $('#rel001_customerPanel_mw001_gender_female').iCheck('uncheck');
    $('#rel001_customerPanel_mw001_dob').val('');
    $('#rel001_customerPanel_mw001_phone').val('');
    $('#rel001_customerPanel_mw001_email').val('');
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var sortedList = [];
    $.each(placeObj.templateList, function(i, templateObj){
		if (Cached_isDeletedBean(templateObj))
			return true;
		
    	if (templateObj.moduleId == ModuleConstants.MODULE_RELATION &&
       		templateObj.templateType == PlaceConstants.TEMPLATE_TYPE_CUSTOMER)
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
    $('#rel001_customerPanel_mw001_templateList').empty();
    $('#rel001_customerPanel_mw001_templateList').append('<option value="">-- USE NO TEMPLATE --</option>')
    $.each(sortedList, function(i, templateObj){
    	
    	var selectedVal = '';
    	if (templateObj.defaultTemplate)
    		selectedVal = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + templateObj.id + '" ' + selectedVal + '>';
    	htmlLines += templateObj.templateName;
    	htmlLines += '</option>';
    	
    	$('#rel001_customerPanel_mw001_templateList').append( htmlLines );
    });
    
    rel001_customerPanel_mw001_templateChanged();
 	
    // Show Modal Window
    module_showModalWindow('rel001_customerPanel_mw001', true);
} // .end of rel001_customerPanel_mw001_updateUI

/**
 * Show Panel
 */
function rel001_customerPanel_mw001_show()
{
    rel001_customerPanel_mw001_updateUI();
} // .end of rel001_customerPanel_mw001_show

/**
 * Event listener for template selection changed.
 */
function rel001_customerPanel_mw001_templateChanged()
{
    var templateId  = $.trim( $("#rel001_customerPanel_mw001_templateList").val() );
    if (templateId=='')
    {
    	$('#rel001_customerPanel_mw001_templatePropertiesList').empty();
    	return false;
    }
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.templateList, function(i, templateObj){
    	if (templateObj.id == templateId)
    	{
    	    rel001_customerPanel_mw001_showTemplate( templateObj );
    	    
    	    return false;
    	}
    });
} // .end of rel001_customerPanel_mw001_templateChanged

/**
 * Display all properties inside template object.
 *
 * @param	{CommonTemplateBean} templateObj - Customer Template Object
 */
function rel001_customerPanel_mw001_showTemplate(templateObj)
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
	$('#rel001_customerPanel_mw001_templatePropertiesList').empty();
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
    	    $('#rel001_customerPanel_mw001_templatePropertiesList').append(dividerHtmlLines);
    	    
			// For next iteration
    	    lastGroupName = propObj.groupName;	
    	}
		
		// Get input component in HTML
		var htmlLines = customerCommon_createInputComponent(propObj, false);
		$('#rel001_customerPanel_mw001_templatePropertiesList').append(htmlLines);
	});
} // .end of rel001_customerPanel_mw001_showTemplate

/**
 * Save user's inputs as new customer object.
 */
function rel001_customerPanel_mw001_save()
{
	// hide errors
	rel001_customerPanel_hideErrors();
	// Get customer no
    var customerNo = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_customerNo").val() );
    var firstName  = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_firstName").val() );
    var lastName   = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_lastName").val() );
   
    // Validation
    if (customerNo=='') {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Customer No.');
        $('#rel001_customerPanel_mw001_customerNo_error').show();
        return false;
    }
    if (firstName=='') {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for First Name.');
        $('#rel001_customerPanel_mw001_firstName_error').show();
        return false;
    }
    if (lastName=='') {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Last Name.');
        $('#rel001_customerPanel_mw001_lastName_error').show();
        return false;
    }
   
    // Show progress
 	$('#rel001_customerPanel_mw001_save').ladda().ladda('start');
    
    // Prepare request body
	var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerNo': customerNo,
			'lastSyncedTime': 0,
			'fullBean': true
		};
	
	var params = new Object();
	params.customerNo = customerNo;
	
	tycheesdb_api_getCustomerByCustomerNo(requestBody, rel001_customerPanel_mw001_save_postHandler, params);    
    
} // .end of rel001_customerPanel_mw001_save

function rel001_customerPanel_mw001_save_postHandler(success, responseObj, params) 
{
 	// Hide Progress
	$('#rel001_customerPanel_mw001_save').ladda().ladda('stop');	 
 	
	if (!success) {	
		swal ('Oops', 'Something went wrong!', 'error');
		return false;
	}

	if (responseObj.customerObj != null) {
		$('#rel001_customerPanel_mw001_customerNo_duplicate_error').show();
		return false;
	}
	
	var placeObj     = tycheesCommon_getCurrentPlaceObject();
    var templateId   = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_templateList").val() );
    var templateName = '';
    var customerNo   = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_customerNo").val() );
    var firstName    = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_firstName").val() );
    var lastName     = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_lastName").val() );
    var gender       = tycheesText_getSafeString( $('input[name="rel001_customerPanel_mw001_gender"]:checked').val() );
    var dob          = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_dob").val() );
    var phone        = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_phone" ).val() );
    var email        = tycheesText_getSafeString( $("#rel001_customerPanel_mw001_email" ).val() );
   
    $.each(placeObj.templateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
    	if (templateObj.id == templateId)
    		templateName = $.trim(templateObj.templateName);
    });
    
    // IF   system generated CustomerNo is being used, 
 	// THEN update system about next customer no. 
 	if ($.trim(customerNo)==$.trim(rel001_customerPanel_mw001_systemGeneratedCustomerNo))
 	{
 		consoleCommon_updateNextCustomerNo();
 	}
 
	// Customer contact object
    var newContactObj = createNew_CustomerContact();
    newContactObj.countryCode = '';
    newContactObj.areaCode = '';
    newContactObj.phoneNumber = phone;
    newContactObj.extension = '';
    newContactObj.defaultContact = true;
    
    // Customer email object
    var newEmailObj = createNew_CustomerEmail();
    newEmailObj.emailAddress = email;	
    newContactObj.primaryEmail = true;

    // Customer object
    var newCustomerObj = createNew_Customer();
    newCustomerObj.customerNo = customerNo;	
    newCustomerObj.firstName = firstName;
    newCustomerObj.lastName = lastName;
    newCustomerObj.dob = tycheesDateTime_toMilliseconds_ddMMyyyy(dob) == 0 ? null : tycheesDateTime_toMilliseconds_ddMMyyyy(dob);
    newCustomerObj.gender = gender;
    newCustomerObj.contact = tycheesBean_toString_commonContactBean(newContactObj);
    newCustomerObj.email = customerEmail_getFullEmail(newEmailObj);
    newCustomerObj.templateId = templateId;
    newCustomerObj.templateName = templateName;
    
    // Push into list
    newCustomerObj.contactList.push(newContactObj);
    newCustomerObj.emailList.push(newEmailObj);
    
    // Copy from Template's properties, to Customer's custom field, if any.
    $.each(placeObj.templateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
    	if (templateObj.id == templateId)
    	{
    	    $.each(templateObj.propertiesList, function(j, templatePropObj) {
            	if (Cached_isDeletedBean(templatePropObj))
            		return true;
            	
    	        var newPropObj = createNew_CustomerProperties();
    	        newPropObj.groupName = templatePropObj.groupName;
    	        newPropObj.propName = templatePropObj.propName;
    	        newPropObj.propKey = templatePropObj.propKey;
    	        newPropObj.propType = templatePropObj.propType;
    	        newPropObj.propContent = templatePropObj.propContent;
    	        newPropObj.propValue = customerCommon_getInputComponentValue(templatePropObj);
    	        newPropObj.remarks = templatePropObj.remarks;
    	        
    	        newCustomerObj.propertiesList.push( newPropObj );
    	    });
    	}
    });
    
    // Hide modal window
    $("#rel001_customerPanel_mw001").modal('hide');
    
    // Update List
    Cached_addCustomer( newCustomerObj );
    
    // Save to localDB
    tycheesIO_saveBean( newCustomerObj );
    
    // Update UI
    rel001_customerPanel_updateUI(false);
} // .end of rel001_customerPanel_mw001_save_postHandler

</script>