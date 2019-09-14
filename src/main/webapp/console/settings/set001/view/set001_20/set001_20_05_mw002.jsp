<style>
	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
    
<!-- Add New Contact -->
<div class="modal inmodal fade" id="set001_20_05_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDID USER</span>
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
								    	<label>Designation</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw002_input_designation" value="">
								    	<span id="set001_20_05_mw002_input_designation_helpText"></span>
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-6 form-group">
									    <span class="mandatory-field">* </span>
								    	<label>First Name</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw002_input_firstName" value="">
								    	<span id="set001_20_05_mw002_input_firstName_helpText"></span>
								    </div>
								    <div class="col-md-6 form-group">
								    	<label>Last Name</label> 
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw002_input_lastName" value="">
								    	<span id="set001_20_05_mw002_input_lastName_helpText"></span>
								    </div>		
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
									    <span class="mandatory-field">* </span>
								    	<label>Email</label> 
								    	<br>
								    	<input type="email" placeholder="" class="form-control" id="set001_20_05_mw002_input_email" value="">
								    	<span id="set001_20_05_mw002_input_email_helpText"></span>
								    </div>	
							    </div>
							    <div class="form-group" style="margin-bottom:0px;">
								    <span class="mandatory-field">* </span>
								    <label>Type</label> 
								    <select class="form-control m-b" name="account" id="set001_20_05_mw002_input_roleList">
								    </select>
							    </div>
							    <div id="set001_20_05_mw002_errorText_mandatoryFields" class="form-group" style="display:none;">
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
		    	<button type="button" id="set001_20_05_mw002_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="set001_20_05_mw002_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="set001_20_05_mw002_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_05_mw002_initialized = false;
var set001_20_05_mw002_userObj;

function set001_20_05_mw002_init()
{
    if (set001_20_05_mw002_initialized == true)
        return false;
    
    $('#set001_20_05_mw002').on('shown.bs.modal', function () {
		$('#set001_20_05_mw002_input_designation').focus();
		$('#set001_20_05_mw002_input_designation').select();
	});
        
	set001_20_05_mw002_initialized = true;
} // .end of set001_20_05_mw002_init

function set001_20_05_mw002_show(userId)
{
	set001_20_05_mw002_userObj = Cached_getUserById(userId);
	
	set001_20_05_mw002_updateUI();
} // .end of set001_20_05_mw002_show

function set001_20_05_mw002_updateUI()
{
	if (set001_20_05_mw002_userObj == null)
		return false;
	
    set001_20_05_mw002_init();    
    set001_20_05_mw002_reset();

    // Reset
    $("#set001_20_05_mw002_input_firstName").val( set001_20_05_mw002_userObj.firstName );
    $("#set001_20_05_mw002_input_lastName").val( set001_20_05_mw002_userObj.lastName );
    $("#set001_20_05_mw002_input_email").val( set001_20_05_mw002_userObj.email );

 	// Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
 	// Setup access list
 	$('#set001_20_05_mw002_input_roleList').empty();
    $('#set001_20_05_mw002_input_roleList').append('<option value="">-- SELECT ROLE--</option>');
    $.each(placeObj.accessList, function(i, accessObj){
    	
    	if (Cached_isDeletedBean(accessObj))
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + accessObj.id + '">';
    	htmlLines += accessObj.roleName;
    	htmlLines += '</option>';
    	
    	$('#set001_20_05_mw002_input_roleList').append( htmlLines );
    });
    // Get placeRole object
 	var placeRoleObj;
    $.each(placeObj.roleList, function(i, roleObj) {
    	if (roleObj.userId == set001_20_05_mw002_userObj.id) {
    		placeRoleObj = roleObj;
    	    $("#set001_20_05_mw002_input_designation").val( placeRoleObj.designation );
    	}	
    });
    // Get placeAccess object
    $.each(placeObj.accessList, function(i, accessObj) {
    	if (accessObj.roleName == placeRoleObj.role) {
    	    $("#set001_20_05_mw002_input_roleList").val( accessObj.id );
    	}
    });   
            
    // Show Window
    module_showModalWindow('set001_20_05_mw002', true);
    
    // Set Focus
	$('#set001_20_05_mw002_input_designation').focus();
	$('#set001_20_05_mw002_input_designation').select();
} // .end of set001_20_05_mw002_updateUI

function set001_20_05_mw002_reset()
{
	$('#set001_20_05_mw002_errorText_mandatoryFields').hide();
	$('#set001_20_05_mw002_input_firstName').css('background-color','#FFF');
	$('#set001_20_05_mw002_input_lastName').css('background-color','#FFF');
	$('#set001_20_05_mw002_input_email').css('background-color','#FFF');
	$('#set001_20_05_mw002_input_roleList').css('background-color','#FFF');
} // .end of set001_20_05_mw002_reset

function set001_20_05_mw002_save()
{
	// Reset
	set001_20_05_mw002_reset();
	
	// Get user inputs
	var designation = $.trim( $('#set001_20_05_mw002_input_designation').val() );
    var firstName = $.trim( $('#set001_20_05_mw002_input_firstName').val() );
    var lastName = $.trim( $('#set001_20_05_mw002_input_lastName').val() );
    var email = $.trim( $('#set001_20_05_mw002_input_email').val() );
    var role = $.trim( $("select[id='set001_20_05_mw002_input_roleList'").find('option:selected').text() );
    
    // Validation
    var errorFound = false;
    if (firstName=='') {
    	$('#set001_20_05_mw002_input_firstName').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (lastName=='') {
    	$('#set001_20_05_mw002_input_lastName').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (email=='') {
    	$('#set001_20_05_mw002_input_email').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (role=='') {
    	$('#set001_20_05_mw002_input_roleList').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    // Show ladda button
    $('#set001_20_05_mw002_saveButton').ladda().ladda('start');
    
    // Prepare request body
	var requestBody = {
		'appName': APP_NAME_SETTINGS,
		'email': email
	};
	
	var params = new Object();
	params.firstName = firstName;
	params.lastName = lastName;
	params.email = email;
	params.role = role;
	params.designation = designation;
	
	// Ajax Call
    tycheesdb_api_validateUserEmail(requestBody, set001_20_05_mw002_save_postHandler, params);
} // .end of set001_20_05_mw002_save        

function set001_20_05_mw002_save_postHandler(success, responseObj, params)
{
    // Hide ladda button
    $('#set001_20_05_mw002_saveButton').ladda().ladda('stop');
    
	if (!success) {
		sweetAlert('Oops...', 'Something went wrong!', 'error');
		return false;		
	}
	
	if (responseObj.emailExists && set001_20_05_mw002_userObj.email != params.email) {
		sweetAlert('Duplication Found', 'Please user another email.', 'error');
		return false;		 
	}
	
	// Update User Object
    set001_20_05_mw002_userObj.firstName = params.firstName;
    set001_20_05_mw002_userObj.lastName = params.lastName;
    set001_20_05_mw002_userObj.email = params.email;
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
 	// Get placeRole object
  	var placeRoleObj;
    $.each(placeObj.roleList, function(i, roleObj) {
    	if (roleObj.userId == set001_20_05_mw002_userObj.id) {
    		placeRoleObj = roleObj;
    	}	
    });
    
    // Update Place Role object
    placeRoleObj.role = params.role;
    placeRoleObj.designation = params.designation;
    placeRoleObj.hasChanged = true;
    	
    // Save to IndexedDB
    tycheesIO_saveBean(set001_20_05_mw002_userObj);
    tycheesIO_saveBean(placeObj);
    // Hide Modal Window
    $("#set001_20_05_mw002").modal("hide");
    // Update UI
    set001_20_05_updateUI();
} // .end of set001_20_05_mw002_save_postHandler

</script>
