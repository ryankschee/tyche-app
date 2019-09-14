
<!-- 
    Title:			EMAIL EDITOR
    Desc:			- Show address in details
    Author:			Ryan Chee
    Last Modified:	20170810
-->

<div class="modal inmodal fade" id="mw_emailEditor" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EMAIL EDITOR</span>
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
								    	<select id="mw_emailEditor_emailType"  class="form-control">
								    		<option value="Personal">Personal</option>
								    		<option value="Office">Office</option>
						                </select>
								    </div>	
							    </div>
							    <hr>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		<span class="mandatory-field">* </span>
								    		Email Address
								    	</label> 
								    	<br>
								    	<input type="email" class="form-control" id="mw_emailEditor_emailAddress" value="">
								    	<span id="mw_emailEditor_emailAddress_helpText"></span>
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Default Email</label> 
								    	<br>
								    	<div class="mw_emailEditor_iCheck">
                                        	<label> 
                                        		<input type="checkbox" id="mw_emailEditor_defaultEmail" value=""> 
                                        	</label>
                                        </div>
								    </div>	
							    </div>
							    <div id="mw_emailEditor_errorText_mandatoryFields" class="form-group" style="display:none;">
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
		    	<button type="button" id="mw_emailEditor_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="mw_emailEditor_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_emailEditor_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var mw_emailEditor_initialized = false;
var mw_emailEditor_emailObj;
var mw_emailEditor_postHandlerFn;

function mw_emailEditor_init()
{
    if (mw_emailEditor_initialized == true)
        return false;

    $('.mw_emailEditor_iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#mw_emailEditor').on('shown.bs.modal', function () {
	});
        
	mw_emailEditor_initialized = true;
} // .end of mw_emailEditor_init

function mw_emailEditor_show(emailObj, postHandlerFn)
{
	// Get current user object
	mw_emailEditor_emailObj = emailObj;
	// Post Handler
	mw_emailEditor_postHandlerFn = postHandlerFn;
	// Init UI/data
	mw_emailEditor_updateUI();
} // .end of mw_emailEditor_show

function mw_emailEditor_updateUI()
{
	if (mw_emailEditor_emailObj == null)
		return false;
	
    mw_emailEditor_init();    
    mw_emailEditor_resetErrors();

    // Reset
    $('#mw_emailEditor_emailType').val( $.trim(mw_emailEditor_emailObj.type));
	$('#mw_emailEditor_emailAddress').val( $.trim(mw_emailEditor_emailObj.emailAddress) );
	if (mw_emailEditor_emailObj.defaultEmail)
		$('#mw_emailEditor_defaultEmail').iCheck('check');
	else
		$('#mw_emailEditor_defaultEmail').iCheck('uncheck');
 	            
    // Show Window
    module_showModalWindow('mw_emailEditor', true);
} // .end of mw_emailEditor_updateUI

function mw_emailEditor_resetErrors()
{
	$('#mw_emailEditor_errorText_mandatoryFields').hide();
	$('#mw_emailEditor_emailAddress').css('background-color','#FFF');
} // .end of mw_emailEditor_resetErrors

function mw_emailEditor_save()
{
	// Reset
	mw_emailEditor_resetErrors();
	
	// Get user inputs
	var emailType = $.trim( $('#mw_emailEditor_emailType').val() );
	var emailAddress = $.trim( $('#mw_emailEditor_emailAddress').val() );
	var defaultEmail = $('#mw_emailEditor_defaultEmail').prop('checked');
    
    // Validation
    var errorFound = false;
    if (emailAddress=='') {
    	$('#mw_emailEditor_emailAddress').css('background-color','#FFB0B0');
    	$('#mw_emailEditor_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    mw_emailEditor_emailObj.type = emailType;
    mw_emailEditor_emailObj.emailAddress = emailAddress;
    mw_emailEditor_emailObj.defaultEmail = defaultEmail;
    mw_emailEditor_emailObj.hasChanged = true;
    
	// Hide Modal Window
    $("#mw_emailEditor").modal('hide');
	// Pass to callback function
    mw_emailEditor_postHandlerFn(true, mw_emailEditor_emailObj);
} // .end of mw_emailEditor_save_postHandler

</script>
