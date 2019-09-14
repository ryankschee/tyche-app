<style>
	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
    
<!-- Add New Role & Permission -->
<div class="modal inmodal fade" id="set001_20_06_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW ROLE & PERMISSION</span>
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
									    <span class="mandatory-field">* </span>
								    	<label>Access Name</label> 
								    	<br>
								    	<input type="text" placeholder="" class="form-control" id="set001_20_06_mw001_input_role" value="">
								    	<span id="set001_20_06_mw001_input_role_helpText"></span>
								    </div>	
							    </div>
							    <div id="set001_20_06_mw001_errorText_mandatoryFields" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Please fill in highlighted mandatory fields.
							    	</span>
							    </div>
							    <div id="set001_20_06_mw001_errorText_duplicationFound" class="form-group" style="display:none;">
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
		    	<button type="button" class="btn btn-primary" onclick="set001_20_06_mw001_save();">Create New</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_06_mw001_initialized = false;

function set001_20_06_mw001_init()
{
    if (set001_20_06_mw001_initialized == true)
        return false;
    
    $('#set001_20_06_mw001').on('shown.bs.modal', function () {
		$('#set001_20_06_mw001_input_role').val('');
		$('#set001_20_06_mw001_input_role').focus();
		$('#set001_20_06_mw001_input_role').select();
	});
    
	set001_20_06_mw001_initialized = true;
} // .end of set001_20_06_mw001_init

function set001_20_06_mw001_show()
{
	set001_20_06_mw001_updateUI();
} // .end of set001_20_06_mw001_show

function set001_20_06_mw001_updateUI()
{
    set001_20_06_mw001_init();    
    set001_20_06_mw001_reset();

    // Reset
    $('#set001_20_06_mw001_input_role').val('');
    
    // Show Window
    module_showModalWindow('set001_20_06_mw001', true);
    
    // Set Focus
	$('#set001_20_06_mw001_input_role').focus();
	$('#set001_20_06_mw001_input_role').select();
} // .end of set001_20_06_mw001_updateUI

function set001_20_06_mw001_reset()
{
	$('#set001_20_06_mw001_errorText_mandatoryFields').hide();
	$('#set001_20_06_mw001_errorText_duplicationFound').hide();
	$('#set001_20_06_mw001_input_role').css('background-color','#FFF');
} // .end of set001_20_06_mw001_reset

function set001_20_06_mw001_save()
{
    // Place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    
	// Reset
	set001_20_06_mw001_reset();
	
	// Get user inputs
    var role = $.trim( $('#set001_20_06_mw001_input_role').val() );
    
    // Validation
    var errorFound = false;
    if (role=='') {
    	$('#set001_20_06_mw001_input_role').css('background-color','#FFB0B0');
    	$('#set001_20_06_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    var duplicatedNameFound = false;
    $.each(placeObj.accessList, function(i, accessObj) {
    	if ($.trim(accessObj.roleName) == role) {
    		duplicatedNameFound = true;
    	}
    });
    
    if (duplicatedNameFound) {
    	$('#set001_20_06_mw001_errorText_duplicationFound').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    var placeAccessObj = createNew_PlaceAccess();
    placeAccessObj.placeId = placeObj.id;
    placeAccessObj.roleName = role;
    	
    placeAccessObj.propertiesList.push(
   		set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 1, ModuleConstants.MODULE_DASHBOARD_PROP_KEY, ModuleConstants.MODULE_DASHBOARD, 'Select', 'No Access, Readable, Writable', 'No Access'));
    placeAccessObj.propertiesList.push(
      	set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 2, ModuleConstants.MODULE_BILLING_PROP_KEY, ModuleConstants.MODULE_BILLING, 'Select', 'No Access, Readable, Writable', 'No Access'));
    placeAccessObj.propertiesList.push(
        set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 3, ModuleConstants.MODULE_CALENDAR_PROP_KEY, ModuleConstants.MODULE_CALENDAR, 'Select', 'No Access, Readable, Writable', 'No Access'));
    placeAccessObj.propertiesList.push(
        set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 4, ModuleConstants.MODULE_INVENTORY_PROP_KEY, ModuleConstants.MODULE_INVENTORY, 'Select', 'No Access, Readable, Writable', 'No Access'));
    placeAccessObj.propertiesList.push(
        set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 5, ModuleConstants.MODULE_RELATION_PROP_KEY, ModuleConstants.MODULE_RELATION, 'Select', 'No Access, Readable, Writable', 'No Access'));
    placeAccessObj.propertiesList.push(
        set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 6, ModuleConstants.MODULE_REPORTS_PROP_KEY, ModuleConstants.MODULE_REPORTS, 'Select', 'No Access, Readable, Writable', 'No Access'));
    placeAccessObj.propertiesList.push(
       	set001_20_06_createPlaceAccessProperties(placeAccessObj.id, 'Root Functions', 7, ModuleConstants.MODULE_SETTINGS_PROP_KEY, ModuleConstants.MODULE_SETTINGS, 'Select', 'No Access, Readable, Writable', 'No Access'));
    
    // Add into current place's role list
    placeObj.accessList.push(placeAccessObj);
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj, true);
    // Hide Modal Window
    $("#set001_20_06_mw001").modal("hide");
    // Update UI
    set001_20_06_updateUI();
} // .end of set001_20_06_mw001_save        

function set001_20_06_createPlaceAccessProperties(accessId, groupName, propSeqno, propKey, propName, propType, propContent, propValue) {
	
	var placeAccessPropObj = createNew_PlaceAccessProperties();
    placeAccessPropObj.accessId = accessId;
    placeAccessPropObj.groupName = groupName;
    placeAccessPropObj.propSeqno = propSeqno;
    placeAccessPropObj.propKey = propKey;
    placeAccessPropObj.propName = propName;
    placeAccessPropObj.propType = propType;
    placeAccessPropObj.propContent = propContent;
    placeAccessPropObj.propValue = propValue;
    
    return placeAccessPropObj;
} // .end of set001_20_06_createPlaceAccessProperties

</script>
