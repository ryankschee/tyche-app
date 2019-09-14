
<!-- 
    Title:			CONTACT EDITOR
    Desc:			- Show address in details
    Author:			Ryan Chee
    Last Modified:	20170810
-->

<div class="modal inmodal fade" id="mw_contactEditor" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">CONTACT EDITOR</span>
			</div>
		    <div class="modal-body">
			    <div class="row">
				    <div class="col-lg-12">
				    	<div class="ibox float-e-margins">
						    <form role="form">
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Type</label> 
								    	<br>
								    	<select id="mw_contactEditor_contactType"  class="form-control">
								    		<option value="Home">Home</option>
								    		<option value="Office">Office</option>
								    		<option value="Mobile">Mobile</option>
						                </select>
								    </div>	
							    </div>
							    <hr>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		<span class="mandatory-field">* </span>
								    		Country Code
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_contactEditor_contactCountryCode" value="">
								    	<span id="mw_contactEditor_contactCountryCode_helpText"></span>
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		<span class="mandatory-field">* </span>
								    		Phone Number
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_contactEditor_contactNumber" value="">
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Extension</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_contactEditor_extension" value="">
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Default Contact</label> 
								    	<br>
								    	<div class="mw_contactEditor_iCheck">
                                        	<label> 
                                        		<input type="checkbox" id="mw_contactEditor_defaultContact" value=""> 
                                        	</label>
                                        </div>
								    </div>	
							    </div>
							    <div id="mw_contactEditor_errorText_mandatoryFields" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Please fill in highlighted mandatory fields.
							    	</span>
							    </div>
						    </form>
						</div>
				    </div>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" id="mw_contactEditor_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="mw_contactEditor_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_contactEditor_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var mw_contactEditor_initialized = false;
var mw_contactEditor_contactObj;
var mw_contactEditor_postHandlerFn;

function mw_contactEditor_init()
{
    if (mw_contactEditor_initialized == true)
        return false;

    $('.mw_contactEditor_iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#mw_contactEditor').on('shown.bs.modal', function () {
	});
        
	mw_contactEditor_initialized = true;
} // .end of mw_contactEditor_init

function mw_contactEditor_show(contactObj, postHandlerFn)
{
	// Get current user object
	mw_contactEditor_contactObj = contactObj;
	// Post Handler
	mw_contactEditor_postHandlerFn = postHandlerFn;
	// Init UI/data
	mw_contactEditor_updateUI();
} // .end of mw_contactEditor_show

function mw_contactEditor_updateUI()
{
	if (mw_contactEditor_contactObj == null)
		return false;
	
    mw_contactEditor_init();    
    mw_contactEditor_resetErrors();

    // Reset
    $('#mw_contactEditor_contactType').val( $.trim(mw_contactEditor_contactObj.type));
	$('#mw_contactEditor_contactCountryCode').val( $.trim(mw_contactEditor_contactObj.countryCode) );
	$('#mw_contactEditor_contactNumber').val( $.trim(mw_contactEditor_contactObj.phoneNumber) );
	$('#mw_contactEditor_extension').val( $.trim(mw_contactEditor_contactObj.extension) );
	if (mw_contactEditor_contactObj.defaultContact)
		$('#mw_contactEditor_defaultContact').iCheck('check');
	else
		$('#mw_contactEditor_defaultContact').iCheck('uncheck');
 	            
    // Show Window
    module_showModalWindow('mw_contactEditor', true);
} // .end of mw_contactEditor_updateUI

function mw_contactEditor_resetErrors()
{
	$('#mw_contactEditor_errorText_mandatoryFields').hide();
	$('#mw_contactEditor_contactCountryCode').css('background-color','#FFF');
	$('#mw_contactEditor_contactNumber').css('background-color','#FFF');
	$('#mw_contactEditor_extension').css('background-color','#FFF');
} // .end of mw_contactEditor_resetErrors

function mw_contactEditor_save()
{
	// Reset
	mw_contactEditor_resetErrors();
	
	// Get user inputs
	var contactType = $.trim( $('#mw_contactEditor_contactType').val() );
	var countryCode = $.trim( $('#mw_contactEditor_contactCountryCode').val() );
	var phoneNumber = $.trim( $('#mw_contactEditor_contactNumber').val() );
	var extension = $.trim( $('#mw_contactEditor_extension').val() );
	var defaultContact = $('#mw_contactEditor_defaultContact').prop('checked');
    
    // Validation
    var errorFound = false;
    if (countryCode=='') {
    	$('#mw_contactEditor_contactCountryCode').css('background-color','#FFB0B0');
    	$('#mw_contactEditor_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (phoneNumber=='') {
    	$('#mw_contactEditor_contactNumber').css('background-color','#FFB0B0');
    	$('#mw_contactEditor_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    mw_contactEditor_contactObj.type = contactType;
    mw_contactEditor_contactObj.countryCode = countryCode;
    mw_contactEditor_contactObj.phoneNumber = phoneNumber;
    mw_contactEditor_contactObj.extension = extension;
    mw_contactEditor_contactObj.defaultContact = defaultContact;
    mw_contactEditor_contactObj.hasChanged = true;
    
	// Hide Modal Window
    $("#mw_contactEditor").modal('hide');
	// Pass to callback function
    mw_contactEditor_postHandlerFn(true, mw_contactEditor_contactObj);
} // .end of mw_contactEditor_save_postHandler

</script>
