
<!-- 
	Name: 		view_mw_resetPassword.jsp
	Purpose:	Reset own password
 -->
 
<!-- Add New Contact -->
<div class="modal inmodal fade" id="mw_resetPassword" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">RESET PASSWORD</span>
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
								    	<input type="text" placeholder="" class="form-control" id="mw_resetPassword_input_fullName" value="" disabled>
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Current Password</label> 
								    	<br>
								    	<input type="password" placeholder="" class="form-control" id="mw_resetPassword_input_old_password" value="">
								    	<span id="mw_resetPassword_input_designation_helpText"></span>
								    </div>	
							    </div>
							    <hr>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>New Password</label> 
								    	<br>
								    	<input type="password" placeholder="" class="form-control" id="mw_resetPassword_input_new_password" value="">
								    	<span id="mw_resetPassword_input_designation_helpText"></span>
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Retype New Password</label> 
								    	<br>
								    	<input type="password" placeholder="" class="form-control" id="mw_resetPassword_input_new_password_retype" value="">
								    	<span id="mw_resetPassword_input_designation_helpText"></span>
								    </div>	
							    </div>
							    <div id="mw_resetPassword_errorText_mandatoryFields" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Please fill in highlighted mandatory fields.
							    	</span>
							    </div>
							    <div id="mw_resetPassword_errorText_mismatchPassword" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		New password does not match.
							    	</span>
							    </div>
							    <div id="mw_resetPassword_errorText_invalidPassword" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Error: password must be minimum 8 characters, and
							    		<br>
							    		password must contain at least one number (0-9), and
							    		<br>
							    		password must contain at least one lowercase letter (a-z), and
							    		<br>
							    		password must contain at least one uppercase letter (A-Z).
							    	</span>
							    </div>
						    </form>
						</div>
				    </div>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" id="mw_resetPassword_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="mw_resetPassword_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_resetPassword_save();">Reset Password</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var mw_resetPassword_initialized = false;
var mw_resetPassword_userObj;

function mw_resetPassword_init()
{
    if (mw_resetPassword_initialized == true)
        return false;
    
    $('#mw_resetPassword').on('shown.bs.modal', function () {
		$('#mw_resetPassword_input_old_password').focus();
		$('#mw_resetPassword_input_old_password').select();
	});
        
	mw_resetPassword_initialized = true;
} // .end of mw_resetPassword_init

function mw_resetPassword_show(mandatory)
{
	if (mandatory) {
		$('#mw_resetPassword_closeButton').hide();	
	} else {
		$('#mw_resetPassword_closeButton').show();	
	}
	
	// Get current user object
	mw_resetPassword_userObj = Cached_getUserById(tycheesCommon_getCurrentUserId());
	// Init UI/data
	mw_resetPassword_updateUI();
} // .end of mw_resetPassword_show

function mw_resetPassword_updateUI()
{
	if (mw_resetPassword_userObj == null)
		return false;
	
    mw_resetPassword_init();    
    mw_resetPassword_reset();

    var fullName = $.trim(mw_resetPassword_userObj.firstName) + ' ' + $.trim(mw_resetPassword_userObj.lastName);
    
    // Reset
    $('#mw_resetPassword_input_fullName').val( $.trim(fullName) );
	$('#mw_resetPassword_input_old_password').val( '' );
	$('#mw_resetPassword_input_new_password').val( '' );
	$('#mw_resetPassword_input_new_password_retype').val( '' );
 	            
    // Show Window
    module_showModalWindow('mw_resetPassword', true);
    
    // Set Focus
	$('#mw_resetPassword_input_old_password').focus();
	$('#mw_resetPassword_input_old_password').select();
} // .end of mw_resetPassword_updateUI

function mw_resetPassword_reset()
{
	$('#mw_resetPassword_errorText_mandatoryFields').hide();
	$('#mw_resetPassword_errorText_mismatchPassword').hide();
	$('#mw_resetPassword_errorText_invalidPassword').hide();
	$('#mw_resetPassword_input_old_password').css('background-color','#FFF');
	$('#mw_resetPassword_input_new_password').css('background-color','#FFF');
	$('#mw_resetPassword_input_new_password_retype').css('background-color','#FFF');
} // .end of mw_resetPassword_reset

function mw_resetPassword_save()
{
	// Reset
	mw_resetPassword_reset();
	
	// Get user inputs
	var oldPassword = $.trim( $('#mw_resetPassword_input_old_password').val() );
	var newPassword = $.trim( $('#mw_resetPassword_input_new_password').val() );
	var newPasswordRetype = $.trim( $('#mw_resetPassword_input_new_password_retype').val() );
    
    // Validation
    var errorFound = false;
    if (oldPassword=='') {
    	$('#mw_resetPassword_input_old_password').css('background-color','#FFB0B0');
    	$('#mw_resetPassword_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (newPassword=='') {
    	$('#mw_resetPassword_input_new_password').css('background-color','#FFB0B0');
    	$('#mw_resetPassword_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (newPasswordRetype=='') {
    	$('#mw_resetPassword_input_new_password_retype').css('background-color','#FFB0B0');
    	$('#mw_resetPassword_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (newPassword != newPasswordRetype) {
    	$('#mw_resetPassword_errorText_mismatchPassword').show();
    	errorFound = true;
    }
    if (tycheesSecurity_validatePassword(newPassword, 8)==false) {
    	$('#mw_resetPassword_errorText_invalidPassword').show();
    	errorFound = true;
    }    
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    // Show ladda button
    $('#mw_resetPassword_saveButton').ladda().ladda('start');
    
 	// Prepare request body
  	var requestBody = {
  		'appName': APP_NAME_SETTINGS,
  		'email': mw_resetPassword_userObj.email
  	};
  	
  	var params = new Object();
  	params.oldPassword = oldPassword;
  	params.newPassword = newPassword;
  	params.newPasswordRetype = newPasswordRetype;
  	
  	tycheesdb_api_preAuthenticate(requestBody, mw_resetPassword_preAuthentication_postHanlder, params);
} // .end of mw_resetPassword_save        

function mw_resetPassword_preAuthentication_postHanlder(success, responseObj, params)
{
	if (!success) {
		// Hide ladda button
	    $('#mw_resetPassword_saveButton').ladda().ladda('stop');
		
		swal ('Oops', 'Something went wrong!', 'error');
		return false;
	}
	
	// Prepare request body
  	var requestBody = {
  		'appName': APP_NAME_SETTINGS,
  		'email': mw_resetPassword_userObj.email,
  		'password': tycheesSecurity_hashPassword(params.oldPassword, responseObj.salt)
  	};
	  	
    tycheesdb_api_authenticate(requestBody, mw_resetPassword_authentication_postHanlder, params);
} // .end of mw_resetPassword_preAuthentication_postHanlder

function mw_resetPassword_authentication_postHanlder(success, responseObj, params)
{
	if (!success) {
		// Hide ladda button
	    $('#mw_resetPassword_saveButton').ladda().ladda('stop');
	    
		swal ('Oops', 'Something went wrong!', 'error');
		return false;
	}
	
	if (responseObj.status.code != 0) {
		// Hide ladda button
	    $('#mw_resetPassword_saveButton').ladda().ladda('stop');
		
		swal('Invalid Password', 'Please try again.', 'error');
		return false;	
	}
	
	// Generate secure random as salt
 	var salt = tycheesSecurity_getSalt();    	   	
   	
 	// Prepare request body
 	var requestBody = {
 		'appName': APP_NAME_SETTINGS,
 		'userId': mw_resetPassword_userObj.id,
 		'password': tycheesSecurity_hashPassword(params.newPassword, salt),
 		'salt': salt,
 		'resetPasswordRequired': false
 	};
 	
 	// Ajax Call
 	tycheesdb_api_resetUserPassword(requestBody, mw_resetPassword_save_postHandler, params);
} // .end of mw_resetPassword_authentication_postHanlder

function mw_resetPassword_save_postHandler(success, responseObj, params)
{
	// Hide ladda button
    $('#mw_resetPassword_saveButton').ladda().ladda('stop');
    
	if (!success) {
		swal('Oops', 'Something went wrong!', 'error');
		return false;
	}

	// Reset flag
	localStorage.setItem(LOCAL_STORAGE_KEY_RESET_PASSWORD, 'false');
	
	// Hide Modal Window
    $("#mw_resetPassword").modal('hide');
	// Show SweetAlert
	swal('Success', 'Password has been reset successfully.', 'success');	   
} // .end of mw_resetPassword_save_postHandler

</script>
