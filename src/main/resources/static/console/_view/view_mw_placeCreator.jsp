
<!-- 
    Title:			CREATE NEW PLACE
    Desc:			Register for new place account.
    Author:			Ryan Chee
    Last Modified:	20171008
-->
<div class="modal inmodal fade" id="mw_placeCreator" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">CREATE NEW PLACE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw_placeCreator_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Business Type</label>
	                                    <div class="col-sm-8">
	                                    	<select id="mw_placeCreator_businessType" class="form-control m-b">
								                <option value="">-- BUSINESS TYPE --</option>
								                <option value="cafe">Cafe</option>
								                <option value="grocery">Grocery</option>
								                <option value="restaurant">Restaurant</option>
								                <option value="tailor">Tailor</option>
								            </select>
	                                    	<span id="mw_placeCreator_businessType_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Company Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_placeCreator_companyName">
	                                    	<span id="mw_placeCreator_companyName_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw_placeCreator_companyName_duplication" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Company UID</label>
	                                    <div class="col-sm-8">
	                                    	<span class="input-group-addon" style="color:#999;">https://www.tychees.com/</span>
          									<input id="mw_placeCreator_companyId" type="text" class="form-control" placeholder="Company UID (2-40 characters)" required/>
	                                    	<span id="mw_placeCreator_companyId_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw_placeCreator_companyId_error_duplication" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>	                                
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button id="mw_placeCreator_closeButton" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button id="mw_placeCreator_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_placeCreator_save();">Create New</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw_placeCreator_initialized = false;
var mw_placeCreator_callbackFn;

function mw_placeCreator_isOpen()
{
	return ($("#mw_placeCreator").data('bs.modal') || {}).isShown;	
} // .end of mw_placeCreator_isOpen

function mw_placeCreator_init()
{
    if (mw_placeCreator_initialized == true)
        return false;
    
    $('#mw_placeCreator').on('shown.bs.modal', function () {
	    $("#mw_placeCreator_newBillingNo").focus();
	});
    
	mw_placeCreator_initialized = true;
} // .end of mw_placeCreator_init

function mw_placeCreator_show(callbackFn)
{
	// Set callback function
	mw_placeCreator_callbackFn = callbackFn;
	// Update UI
	mw_placeCreator_updateUI();
} // .end of mw_placeCreator_show

function mw_placeCreator_updateUI()
{
    mw_placeCreator_init();
    
    // Setup inputs
    $('#mw_placeCreator_businessType').val( '' );
    $('#mw_placeCreator_companyName').val( '' );
    $('#mw_placeCreator_companyId').val( '' );
    $('.error-msg').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw_placeCreator', true);
} // .end of mw_placeCreator_updateUI

function mw_placeCreator_save()
{
	// Get next billing number
	var businessType = $.trim( $('#mw_placeCreator_businessType').val() );
	var companyName = $.trim( $('#mw_placeCreator_companyName').val() );
	var companyUid = $.trim( $('#mw_placeCreator_companyId').val() );
	
	// Validation #1: if empty value
    if ( $.trim(businessType) === '')
    {
    	$('#mw_placeCreator_businessType_error').show();
    	$('#mw_placeCreator_businessType').focus();
    	return false;
    }
 	// Validation #2: if empty value
    if ( $.trim(companyName) === '')
    {
    	$('#mw_placeCreator_companyName_error').show();
    	$('#mw_placeCreator_companyName').focus();
    	return false;
    }
 	// Validation #3: if empty value
    if ( $.trim(companyUid) === '')
    {
    	$('#mw_placeCreator_companyId_error').show();
    	$('#mw_placeCreator_companyId').focus();
    	return false;
    }
	
	$('#mw_placeCreator_saveButton').ladda().ladda('start');

	// Check if any duplicated order found.
	var requestBody = {
		'appName': APP_NAME_ALL,
		'companyUid': companyUid	
	};	

	var params = new Object();
	params.businessType = businessType;
	params.companyName = companyName;
	params.companyUid = companyUid;
	
	tycheesdb_api_validatePlaceRegistration(requestBody, mw_placeCreator_validation_postHandler, params);
} // .end of mw_placeCreator_save

function mw_placeCreator_validation_postHandler(success, responseObj, params)
{
	if (!success) {
		$('#mw_placeCreator_saveButton').ladda().ladda('stop');
		tycheesLogger_logError('Ajax Call failure.', 'mw_placeCreator_validation_postHandler');
		return false;
	}
		
	// Check if any duplicated order found.
	if (responseObj.companyUidExists) {
		$('#mw_placeCreator_saveButton').ladda().ladda('stop');
		$('#mw_placeCreator_companyId_error_duplication').show();
    	$('#mw_placeCreator_companyId').focus();
		return false;		
	}
	
	var requestBody = {
		'appName': APP_NAME_ALL,
		'companyName': params.companyName,
		'companyUid': params.companyUid,
		'businessType': params.businessType	
	};	
	
	tycheesdb_api_registerNewPlace(requestBody, mw_placeCreator_save_postHander, params);
} // .end of mw_placeCreator_validation_postHandler

function mw_placeCreator_save_postHander(success, responseObj, params)
{
	$('#mw_placeCreator_saveButton').ladda().ladda('stop');
	
	if (!success) {
		return false;
	}
	          
	// Switch to new place
	//tycheesCommon_switchPlace(params.companyUid);
	
    // Close Modal Window
    $('#mw_placeCreator').modal('hide');
    
    // Callback function
    if (mw_placeCreator_callbackFn != null)
    	mw_placeCreator_callbackFn();
} // .end of mw_placeCreator_save_postHander

</script>