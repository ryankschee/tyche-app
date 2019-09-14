<!-- Modal Window: Add User -->
<div class="modal inmodal fade" id="rel001_20_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW USER</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_20_mw001_modalBody" class="modal-body">
			    
			    <div class="row">
			    	<div class="col-lg-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Import Template</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="rel001_20_mw001_templateList" onchange="rel001_20_mw001_templateChanged();"></select>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div>
								    	<ul class="list-group clear-list" style="padding:0px; margin: 0px;">
								          	<span id="rel001_20_mw001_templatePropertiesList"></span>
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
	                                	<label class="col-sm-4 control-label">Customer No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_20_mw001_customerNo">
	                                    	<span id="rel001_20_mw001_customerNo_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">First Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_20_mw001_firstName">
	                                    	<span id="rel001_20_mw001_firstName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Last Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_20_mw001_lastName">
	                                    	<span id="rel001_20_mw001_lastName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Gender</label>
	                                    <div class="col-sm-8 rel001_20_mw001_i-checks">
	                                    	<label class="checkbox-inline i-checks"> <input type="radio" value="Male" name="rel001_20_mw001_gender"> Male </label>
                                            <label class="checkbox-inline i-checks"> <input type="radio" value="Female" name="rel001_20_mw001_gender"> Female </label>
	                                    	<span id="rel001_20_mw001_gender_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Selection.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Date of Birth</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_20_mw001_dob" data-mask="99/99/9999" aria-invalid="false">
	                                    	<span id="rel001_20_mw001_dob_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Phone Number</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_20_mw001_phone">
	                                    	<span id="rel001_20_mw001_phone_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Email</label>
	                                    <div class="col-sm-8">
	                                    	<input type="email" class="form-control" id="rel001_20_mw001_email">
	                                    	<span id="rel001_20_mw001_email_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="rel001_20_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_20_mw001_initialized = false;

/**
 * Init components and variables.
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function rel001_20_mw001_init()
{
    if (rel001_20_mw001_initialized == true)
        return false;
    
    $('.rel001_20_mw001_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_20_mw001').on('shown.bs.modal', function () {
	    $("#rel001_20_mw001_customerNo").focus();
	});
    
	rel001_20_mw001_initialized = true;
} // .end of rel001_20_mw001_init

/**
 * Update UI of whole panel. 
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function rel001_20_mw001_updateUI()
{
    rel001_20_mw001_init();
        
    // Hide
    $('#rel001_20_mw001_customerNo_error').hide();
    $('#rel001_20_mw001_firstName_error').hide();
    $('#rel001_20_mw001_lastName_error').hide();
    $('#rel001_20_mw001_gender_error').hide();
    $('#rel001_20_mw001_dob_error').hide();
    $('#rel001_20_mw001_phone_error').hide();
    $('#rel001_20_mw001_email_error').hide();
        
    // Reset
    $('#rel001_20_mw001_customerNo').val('');
    $('#rel001_20_mw001_firstName').val('');
    $('#rel001_20_mw001_lastName').val('');
    $('#rel001_20_mw001_gender').iCheck('uncheck');
    $('#rel001_20_mw001_dob').val('');
    $('#rel001_20_mw001_phone').val('');
    $('#rel001_20_mw001_email').val('');
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var sortedList = [];
    $.each(placeObj.templateList, function(i, templateObj){
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
    $('#rel001_20_mw001_templateList').empty();
    $('#rel001_20_mw001_templateList').append('<option value="">-- USE NO TEMPLATE --</option>')
    $.each(sortedList, function(i, templateObj){
    	
    	var selectedVal = '';
    	if (templateObj.defaultTemplate)
    		selectedVal = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + templateObj.id + '" ' + selectedVal + '>';
    	htmlLines += templateObj.templateName;
    	htmlLines += '</option>';
    	
    	$('#rel001_20_mw001_templateList').append( htmlLines );
    });
    
    rel001_20_mw001_templateChanged();
 	
    // Show Modal Window
    $('#rel001_20_mw001').modal({backdrop: 'static', keyboard: false});
} // .end of rel001_20_mw001_updateUI

/**
 * Show Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function rel001_20_mw001_show()
{
    rel001_20_mw001_updateUI();
} // .end of rel001_20_mw001_show

/**
 * Event listener for template selection changed.
 * 
 * Change Logs
 * -----------
 * 20170125 Ryan Chee   Initial
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function rel001_20_mw001_templateChanged()
{
    var templateId  = $.trim( $("#rel001_20_mw001_templateList").val() );
    if (templateId=='')
    {
    	$('#rel001_20_mw001_templatePropertiesList').empty();
    	return false;
    }
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.templateList, function(i, templateObj){
    	if (templateObj.id == templateId)
    	{
    	    rel001_20_mw001_showTemplate( templateObj );
    	    
    	    return false;
    	}
    });
} // .end of rel001_20_mw001_templateChanged

/**
 * Display all properties inside template object.
 * 
 * Change Logs
 * -----------
 * 20170125 Ryan Chee   Initial
 *
 * @author	Ryan Chee
 * @version	1.0
 *
 * @param	{CommonTemplateBean} templateObj - Customer Template Object
 */
function rel001_20_mw001_showTemplate(templateObj)
{
	// Clear list of properties
	if (templateObj == null)
		return false;
	
	// Extract & Process List
    var sortedList = [];
    $.each(templateObj.propertiesList, function(i, propObj){
    	sortedList.push(propObj);
    });
    // Sort list, by group name
    sortedList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.groupName, b.groupName);
		});

    var lastGroupName = '$TEMP_VALUE$';
	$('#rel001_20_mw001_templatePropertiesList').empty();
	$.each(sortedList, function(j, propObj){
		
		if (lastGroupName != propObj.groupName)
    	{
			var groupName = propObj.groupName=='' ? 'No Group' : propObj.groupName;
    			    	    
    	    var dividerHtmlLines = '';		    	    
    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding:3px 10px;">';
    	    dividerHtmlLines += groupName;
    	    dividerHtmlLines += '</li>';	    	    
    	    $('#rel001_20_mw001_templatePropertiesList').append(dividerHtmlLines);
    	    
			// For next iteration
    	    lastGroupName = propObj.groupName;	
    	}
		
		var htmlLines = '';
		htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
		htmlLines += '<span style="height:25px;margin-top:5px;">';
		htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
		htmlLines += propObj.propKey;
		htmlLines += '</span>';
		htmlLines += '<span class="pull-right"> ';
		htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propObj.propValue, 0) + '" disabled>';
		htmlLines += '</span>';
		htmlLines += '</li>';
		
		$('#rel001_20_mw001_templatePropertiesList').append(htmlLines);
	});
} // .end of rel001_20_mw001_showTemplate

/**
 * Save user's inputs as new customer object.
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 * 
 * @author	Ryan Chee
 * @version	1.0
 */
function rel001_20_mw001_save()
{
    var templateId  = tycheesText_getSafeString( $("#rel001_20_mw001_templateList").val() );
    var customerNo  = tycheesText_getSafeString( $("#rel001_20_mw001_customerNo").val() );
    var firstName   = tycheesText_getSafeString( $("#rel001_20_mw001_firstName").val() );
    var lastName    = tycheesText_getSafeString( $("#rel001_20_mw001_lastName").val() );
    var gender      = tycheesText_getSafeString( $('input[name="rel001_20_mw001_gender"]:checked').val() );
    var dob         = tycheesText_getSafeString( $("#rel001_20_mw001_dob").val() );
    var phone       = tycheesText_getSafeString( $("#rel001_20_mw001_phone" ).val() );
    var email       = tycheesText_getSafeString( $("#rel001_20_mw001_email" ).val() );
   
    // Validation
    if (customerNo=='')
    {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Customer No.');
        $('#rel001_20_mw001_customerNo_error').show();
        return false;
    }
    if (firstName=='')
    {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for First Name.');
        $('#rel001_20_mw001_firstName_error').show();
        return false;
    }
    if (lastName=='')
    {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Last Name.');
        $('#rel001_20_mw001_lastName_error').show();
        return false;
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
    newCustomerObj.dob = tycheesDateTime_toMilliseconds_ddMMyyyy(dob);
    newCustomerObj.gender = gender;
    newCustomerObj.contact = tycheesBean_toString_commonContactBean(newContactObj);
    newCustomerObj.email = customerEmail_getFullEmail(newEmailObj);
    
    // Push into list
    newCustomerObj.contactList.push(newContactObj);
    newCustomerObj.emailList.push(newEmailObj);
    
    // Copy from Template's properties, to Customer's custom field, if any.
    if (templateId != '') 
    {
        var placeObj = tycheesCommon_getCurrentPlaceObject();
        $.each(placeObj.templateList, function(i, templateObj){
        	if (templateObj.id == templateId)
        	{
        	    $.each(templateObj.propertiesList, function(j, templatePropObj){
        	        var newPropObj = createNew_CustomerProperties();
        	        newPropObj.groupName = templatePropObj.groupName;
        	        newPropObj.propKey = templatePropObj.propKey;
        	        newPropObj.propValue = templatePropObj.propValue;
        	        newPropObj.remarks = templatePropObj.remarks;
        	        
        	        newCustomerObj.propertiesList.push( newPropObj );
        	    });
        	}
        });
    }
    
    // Hide modal window
    $("#rel001_20_mw001").modal('hide');
    
    // Update List
    Cached_addCustomer( newCustomerObj );
    
    // Save to localDB
    tycheesIO_saveBean( newCustomerObj );
    
    // Update UI
    rel001_02_updateUI(false);
} // .end of rel001_20_mw001_save

</script>