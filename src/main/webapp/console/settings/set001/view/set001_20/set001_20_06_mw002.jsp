<style>
	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
    
<!-- Add New Role & Permission -->
<div class="modal inmodal fade" id="set001_20_06_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT ROLE & PERMISSION</span>
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
								    	<input type="text" placeholder="" class="form-control" id="set001_20_06_mw002_input_current_role" value="" disabled>
								    	<span id="set001_20_06_mw002_input_role_helpText"></span>
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
									    <span class="mandatory-field">* </span>
								    	<label>New Access Name</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_06_mw002_input_new_role" value="">
								    	<span id="set001_20_06_mw002_input_role_helpText"></span>
								    </div>	
							    </div>
							    <div id="set001_20_06_mw002_errorText_mandatoryFields" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Please fill in highlighted mandatory fields.
							    	</span>
							    </div>
							    <div id="set001_20_06_mw002_errorText_duplicationFound" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Duplication found, please try another role name.
							    	</span>
							    </div>
						    </form>
						</div>
				    </div>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_20_06_mw002_save();">Create New</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_06_mw002_initialized = false;
var set001_20_06_mw002_placeAccessObj;

function set001_20_06_mw002_init()
{
    if (set001_20_06_mw002_initialized == true)
        return false;
   
    $('#set001_20_06_mw002').on('shown.bs.modal', function () {
		$('#set001_20_06_mw002_input_role').val('');
		$('#set001_20_06_mw002_input_role').focus();
		$('#set001_20_06_mw002_input_role').select();
	});
       
	set001_20_06_mw002_initialized = true;
} // .end of set001_20_06_mw002_init

function set001_20_06_mw002_show(accessId)
{
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	$.each(placeObj.accessList, function(i, accessObj) {
		if (accessObj.id == accessId)
			set001_20_06_mw002_placeAccessObj = accessObj;
	});
		
	set001_20_06_mw002_updateUI();
} // .end of set001_20_06_mw002_show

function set001_20_06_mw002_updateUI()
{
	if (set001_20_06_mw002_placeAccessObj == null) {
		return false;
	}
	
    set001_20_06_mw002_init();    
    set001_20_06_mw002_reset();

    // Reset
    $('#set001_20_06_mw002_input_current_role').val(set001_20_06_mw002_placeAccessObj.roleName);
    $('#set001_20_06_mw002_input_new_role').val('');
            
    // Show Window
    module_showModalWindow('set001_20_06_mw002', true);
    
    // Set focus
	$('#set001_20_06_mw002_input_new_role').focus();
	$('#set001_20_06_mw002_input_new_role').select();
} // .end of set001_20_06_mw002_updateUI

function set001_20_06_mw002_reset()
{
	$('#set001_20_06_mw002_errorText_mandatoryFields').hide();
	$('#set001_20_06_mw002_errorText_duplicationFound').hide();
	$('#set001_20_06_mw002_input_new_role').css('background-color','#FFF');
} // .end of set001_20_06_mw002_reset

function set001_20_06_mw002_save()
{
    // Place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    
	// Reset
	set001_20_06_mw002_reset();
	
	// Get user inputs
	var currentRoleName = $.trim(set001_20_06_mw002_placeAccessObj.roleName);
    var newRoleName = $.trim( $('#set001_20_06_mw002_input_new_role').val() );
    
    // Validation
    var errorFound = false;
    if (newRoleName=='') {
    	$('#set001_20_06_mw002_input_new_role').css('background-color','#FFB0B0');
    	$('#set001_20_06_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    var duplicatedNameFound = false;
    $.each(placeObj.accessList, function(i, accessObj) {
    	if ($.trim(accessObj.roleName) == newRoleName) {
    		duplicatedNameFound = true;
    	}
    });
    
    if (duplicatedNameFound) {
    	$('#set001_20_06_mw002_errorText_duplicationFound').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    // Change place.access.roleName
    set001_20_06_mw002_placeAccessObj.roleName = newRoleName;
    // Change place.role.name
    $.each(placeObj.roleList, function(i, roleObj) {
    	if ($.trim(roleObj.name) == currentRoleName) {
    		roleObj.name = newRoleName;
    		roleObj.hasChanged = true;
    	}
    });
    
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
    // Hide Modal Window
    $("#set001_20_06_mw002").modal("hide");
    // Update UI
    set001_20_06_updateUI();
} // .end of set001_20_06_mw002_save        

</script>
