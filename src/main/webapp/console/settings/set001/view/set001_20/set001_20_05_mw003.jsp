<style>
	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
    
<!-- Add New Contact -->
<div class="modal inmodal fade" id="set001_20_05_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">RESET PASSWORD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="modalWindow-placeEdit-modalBody" class="modal-body">
			    <div class="row">
				    <div class="col-lg-12">
				    	<div class="ibox float-e-margins">
						    <form role="form">
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Full Name</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw003_input_fullName" value="" disabled>
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Email</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw003_input_email" value="" disabled>
								    </div>	
							    </div>
							    <hr>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>New Password</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw003_input_password" value="">
								    	<span id="set001_20_05_mw003_input_designation_helpText"></span>
								    </div>	
							    </div>
							    <div id="set001_20_05_mw003_errorText_mandatoryFields" class="form-group" style="display:none;">
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
		    	<button type="button" id="set001_20_05_mw003_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="set001_20_05_mw003_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="set001_20_05_mw003_save();">Reset Password</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_05_mw003_initialized = false;
var set001_20_05_mw003_userObj;
var set001_20_05_mw003_openCallbackFn;

function set001_20_05_mw003_init()
{
    if (set001_20_05_mw003_initialized == true)
        return false;
    
    $('#set001_20_05_mw003').on('shown.bs.modal', function () {
		$('#set001_20_05_mw003_input_password').focus();
		$('#set001_20_05_mw003_input_password').select();
	});
        
	set001_20_05_mw003_initialized = true;
} // .end of set001_20_05_mw003_init

function set001_20_05_mw003_show(userId, openCallbackFn)
{
	set001_20_05_mw003_openCallbackFn = openCallbackFn;
	
	var requestBody = new Object();
	requestBody.userId = userId;
	
	var params = new Object();
	params.userId = userId;
	
	tycheesdb_api_getUserById(requestBody, set001_20_05_mw003_show_postHanlder ,params);
} // .end of set001_20_05_mw003_show

function set001_20_05_mw003_show_postHanlder(success, responseObj, params)
{
	set001_20_05_mw003_openCallbackFn(success, params.userId);
	
	if (!success)
		return false;
	
	// Assign user object
	set001_20_05_mw003_userObj = responseObj.userObj;
	
	// Update UI
	set001_20_05_mw003_updateUI();
} // .end of set001_20_05_mw003_show_postHanlder

function set001_20_05_mw003_updateUI()
{
	if (set001_20_05_mw003_userObj == null)
		return false;
	
    set001_20_05_mw003_init();    
    set001_20_05_mw003_reset();

    var fullName = $.trim(set001_20_05_mw003_userObj.firstName) + ' ' + $.trim(set001_20_05_mw003_userObj.lastName);
    
    // Reset
    $('#set001_20_05_mw003_input_fullName').val( $.trim(fullName) );
    $('#set001_20_05_mw003_input_email').val( $.trim(set001_20_05_mw003_userObj.email) );
	$('#set001_20_05_mw003_input_password').val( tycheesText_getRandomString(12) );
 	            
    // Show Window
    module_showModalWindow('set001_20_05_mw003', true);
    
    // Set Focus
	$('#set001_20_05_mw003_input_password').focus();
	$('#set001_20_05_mw003_input_password').select();
} // .end of set001_20_05_mw003_updateUI

function set001_20_05_mw003_reset()
{
	$('#set001_20_05_mw003_errorText_mandatoryFields').hide();
	$('#set001_20_05_mw003_input_password').css('background-color','#FFF');
} // .end of set001_20_05_mw003_reset

function set001_20_05_mw003_save()
{
	// Reset
	set001_20_05_mw003_reset();
	
	// Get user inputs
	var password = $.trim( $('#set001_20_05_mw003_input_password').val() );
    
    // Validation
    var errorFound = false;
    if (password=='') {
    	$('#set001_20_05_mw003_input_password').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw003_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    // Show ladda button
    $('#set001_20_05_mw003_saveButton').ladda().ladda('start');
    
 	// Generate secure random as salt
 	var salt = tycheesSecurity_getSalt();    	   	
   	
 	// Prepare request body
 	var requestBody = {
 		'appName': APP_NAME_SETTINGS,
 		'userId': set001_20_05_mw003_userObj.id,
 		'password': tycheesSecurity_hashPassword(password, salt),
 		'salt': salt,
 		'resetPasswordRequired': true
 	};
 	
 	var params = new Object();
 	params.userId = set001_20_05_mw003_userObj.id;
 	
 	// Ajax Call
 	tycheesdb_api_resetUserPassword(requestBody, set001_20_05_mw003_save_postHandler, params);
} // .end of set001_20_05_mw003_save        

function set001_20_05_mw003_save_postHandler(success, responseObj, params)
{
    // Hide ladda button
    $('#set001_20_05_mw003_saveButton').ladda().ladda('stop');
    
	if (!success) {
		sweetAlert('Oops...', 'Something went wrong!', 'error');
		return false;
	}
	
	// Hide Modal Window
    $("#set001_20_05_mw003").modal('hide');
	// Show SweetAlert
	sweetAlert("Reset Complete", "New password reset for email " + responseObj.userEmail, "success");    
} // .end of set001_20_05_mw003_save_postHandler

</script>
