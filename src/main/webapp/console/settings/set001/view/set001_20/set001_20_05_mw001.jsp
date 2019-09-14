<!-- Add New Contact -->
<div class="modal inmodal fade" id="set001_20_05_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW USER</span>
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
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw001_input_designation" value="">
								    	<span id="set001_20_05_mw001_input_designation_helpText"></span>
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-6 form-group">
									    <span class="mandatory-field">* </span>
								    	<label>First Name</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw001_input_firstName" value="">
								    	<span id="set001_20_05_mw001_input_firstName_helpText"></span>
								    </div>
								    <div class="col-md-6 form-group">
								    	<label>Last Name</label> 
								    	<input type="text" placeholder="" class="form-control" id="set001_20_05_mw001_input_lastName" value="">
								    	<span id="set001_20_05_mw001_input_lastName_helpText"></span>
								    </div>		
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
									    <span class="mandatory-field">* </span>
								    	<label>Email</label> 
								    	<br>
								    	<input type="email" placeholder="" class="form-control" id="set001_20_05_mw001_input_email" value="">
								    	<span id="set001_20_05_mw001_input_email_helpText"></span>
								    </div>	
							    </div>
							    <div class="form-group" style="margin-bottom:0px;">
								    <span class="mandatory-field">* </span>
								    <label>Type</label> 
								    <select class="form-control m-b" name="account" id="set001_20_05_mw001_input_roleList">
								    </select>
							    </div>
							    <div id="set001_20_05_mw001_errorText_mandatoryFields" class="form-group" style="display:none;">
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
		    	<button type="button" id="set001_20_05_mw001_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="set001_20_05_mw001_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="set001_20_05_mw001_save();">Create New</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_05_mw001_initialized = false;

function set001_20_05_mw001_init()
{
    if (set001_20_05_mw001_initialized == true)
        return false;
    
    $('#set001_20_05_mw001').on('shown.bs.modal', function () {
		$('#set001_20_05_mw001_input_designation').focus();
		$('#set001_20_05_mw001_input_designation').select();
	});
        
	set001_20_05_mw001_initialized = true;
} // .end of set001_20_05_mw001_init

function set001_20_05_mw001_show()
{
	set001_20_05_mw001_updateUI();
} // .end of set001_20_05_mw001_show

function set001_20_05_mw001_updateUI()
{
    set001_20_05_mw001_init();    
    set001_20_05_mw001_reset();

    // Reset
    $("#set001_20_05_mw001_input_designation").val('');
    $("#set001_20_05_mw001_input_firstName").val('');
    $("#set001_20_05_mw001_input_lastName").val('');
    $("#set001_20_05_mw001_input_email").val('');
    $('#set001_20_05_mw001_input_roleList').val('');
    
 	// Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();

    $('#set001_20_05_mw001_input_roleList').empty();
    $('#set001_20_05_mw001_input_roleList').append('<option value="">-- SELECT ROLE--</option>');
    $.each(placeObj.accessList, function(i, accessObj){
    	
    	if (Cached_isDeletedBean(accessObj))
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + accessObj.id + '">';
    	htmlLines += accessObj.roleName;
    	htmlLines += '</option>';
    	
    	$('#set001_20_05_mw001_input_roleList').append( htmlLines );
    });
    
    // Show Window
    module_showModalWindow('set001_20_05_mw001', true);
    
    // Set Focus
	$('#set001_20_05_mw001_input_designation').focus();
	$('#set001_20_05_mw001_input_designation').select();
} // .end of set001_20_05_mw001_updateUI

function set001_20_05_mw001_reset()
{
	$('#set001_20_05_mw001_errorText_mandatoryFields').hide();
	$('#set001_20_05_mw001_input_firstName').css('background-color','#FFF');
	$('#set001_20_05_mw001_input_lastName').css('background-color','#FFF');
	$('#set001_20_05_mw001_input_email').css('background-color','#FFF');
	$('#set001_20_05_mw001_input_roleList').css('background-color','#FFF');
} // .end of set001_20_05_mw001_reset

function set001_20_05_mw001_save()
{
	// Reset
	set001_20_05_mw001_reset();
	
	// Get user inputs
	var designation = $.trim( $('#set001_20_05_mw001_input_designation').val() );
    var firstName = $.trim( $('#set001_20_05_mw001_input_firstName').val() );
    var lastName = $.trim( $('#set001_20_05_mw001_input_lastName').val() );
    var email = $.trim( $('#set001_20_05_mw001_input_email').val() );
    var role = $.trim( $("select[id='set001_20_05_mw001_input_roleList'").find('option:selected').text() );
    
    // Validation
    var errorFound = false;
    if (firstName=='') {
    	$('#set001_20_05_mw001_input_firstName').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (lastName=='') {
    	$('#set001_20_05_mw001_input_lastName').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (email=='') {
    	$('#set001_20_05_mw001_input_email').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (role=='') {
    	$('#set001_20_05_mw001_input_roleList').css('background-color','#FFB0B0');
    	$('#set001_20_05_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;

    // Show ladda button
    $('#set001_20_05_mw001_saveButton').ladda().ladda('start');
    
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
    tycheesdb_api_validateUserEmail(requestBody, set001_20_05_mw001_save_postHandler, params);
    // .end of Validation
} // .end of set001_20_05_mw001_save        

function set001_20_05_mw001_save_postHandler(success, responseObj, params)
{
    // Hide ladda button
    $('#set001_20_05_mw001_saveButton').ladda().ladda('stop');
    
	if (!success) {
		sweetAlert('Oops...', 'Something went wrong!', 'error');
		return false;		
	}
	
	if (responseObj.emailExists) {
		sweetAlert('Duplication Found', 'Please user another email.', 'error');
		return false;		
	}
	
	var userObj = createNew_User();
	userObj.firstName = params.firstName;
	userObj.lastName = params.lastName;
	userObj.email = params.email;
    // Add to cache
    Cached_addUser(userObj);
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    var placeRoleObj = createNew_PlaceRole();
    placeRoleObj.userId = userObj.id;
    placeRoleObj.placeId = placeObj.id;
    placeRoleObj.role = params.role;
    placeRoleObj.designation = params.designation;
    	
    // Add into current place's role list
    placeObj.roleList.push(placeRoleObj);
    // Save to IndexedDB
    tycheesIO_saveBean(userObj, false);
    tycheesIO_saveBean(placeObj, true);
    // Hide Modal Window
    $("#set001_20_05_mw001").modal("hide");
    // Update UI
    set001_20_05_updateUI();
} // .end of set001_20_05_mw001_save_postHandler

</script>
