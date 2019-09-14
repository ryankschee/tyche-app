<!-- Modal Window: Add Properties -->
<div class="modal inmodal fade" id="set001_04_01_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW TEMPLATE PROPERTIES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_04_01_mw003_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Group Name</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="set001_04_01_mw003_groupName"  class="form-control">
								                </select>
							                </div>
							                <br>
							                <div class="set001_04_01_mw003_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_04_01_mw003_isGroupName" value=""> 
	                                        		<i></i> Give me a new Group Name 
	                                        	</label>
	                                        </div>
	                                        <input type="text" class="form-control" id="set001_04_01_mw003_newGroupName" disabled>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		<span class="mandatory-field">* </span>
								    		Properties Name
	                                	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_04_01_mw003_name" oninput="set001_04_01_mw003_nameOnInput();">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
								    		Properties Key
								    	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_04_01_mw003_key" disabled>	                                    	
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		<span class="mandatory-field">* </span>
								    		Properties Type
								    	</label>
	                                    <div class="col-sm-8">
	                                    	<select id="set001_04_01_mw003_type" class="form-control">
	                                    		<option value="">-- SELECT --</option>
	                                    		<option value="Boolean">Boolean</option>
	                                    		<option value="Text">Text</option>
	                                    		<option value="Number">Number</option>
	                                    		<option value="Date">Date</option>
	                                    		<option value="Time">Time</option>
	                                    		<option value="List">List</option>
	                                    		<option value="Tag">Tag</option>
	                                    	</select>
	                                    </div>
	                                </div>	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		<span class="mandatory-field">* </span>
								    		Sequence No.
								    	</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_04_01_mw003_seqno">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Default Value</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_04_01_mw003_value">
	                                    </div>
	                                </div>	                                
								    <div id="set001_04_01_mw003_errorText_mandatoryFields" class="form-group" style="display:none;">
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
		    </div>
		    <div class="modal-footer">
		    	<button type="button" id="set001_04_01_mw003_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="set001_04_01_mw003_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="set001_04_01_mw003_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_04_01_mw003_initialized = false;
var set001_04_01_mw003_templateId;

/**
 * Init Panel
 */
function set001_04_01_mw003_init()
{
    if (set001_04_01_mw003_initialized == true)
        return false;
    
    $('.set001_04_01_mw003_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_04_01_mw003_isGroupName').on('ifChecked', function(event){
    	$('#set001_04_01_mw003_groupName').prop('disabled',true);
		$('#set001_04_01_mw003_newGroupName').prop('disabled',false);
		$("#set001_04_01_mw003_newGroupName").focus();
		
	});
	$('#set001_04_01_mw003_isGroupName').on('ifUnchecked', function(event){
    	$('#set001_04_01_mw003_groupName').prop('disabled',false);
		$('#set001_04_01_mw003_newGroupName').prop('disabled',true);
		$("#set001_04_01_mw003_key").focus();
	});
    
    $('#set001_04_01_mw003').on('shown.bs.modal', function () {
	    $("#set001_04_01_mw003_key").focus();
	});
    
	set001_04_01_mw003_initialized = true;
} // .end of set001_04_01_mw003_init

/**
 * Show Panel
 */
function set001_04_01_mw003_updateUI()
{
    set001_04_01_mw003_init();
    
    var templateObj = 
    	set001_04_01_getPlaceTemplateById(set001_04_01_mw003_templateId);
    
    if (templateObj==null) {
    	tycheesLogger_showToast('warning','No template selected','Please select a template.');
    	return false;
    }
    
    // Sort list, by group name
    templateObj.propertiesList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.groupName, b.groupName);
		});
    
    var lastGroupName = '';
    var groupNameList = [];
    groupNameList.push('-- NO GROUP --');
    $.each(templateObj.propertiesList, function(i, propertiesObj){
    	
    	if (lastGroupName != propertiesObj.groupName)
    	{
    		lastGroupName = propertiesObj.groupName;
    		groupNameList.push(propertiesObj.groupName);
    	}
    });
    
    $('#set001_04_01_mw003_groupName').empty();
    $.each(groupNameList, function(i, groupName){    		
    	$('#set001_04_01_mw003_groupName').append( '<option value="' + groupName + '">' + groupName + '</option>' );
    });
    
    // Reset error message
    set001_04_01_mw003_resetErrors();
    
    // Reset inputs
    $('#set001_04_01_mw003_groupName').val('');
    $('#set001_04_01_mw003_isGroupName').iCheck('uncheck');
    $('#set001_04_01_mw003_newGroupName').val('');
    $('#set001_04_01_mw003_newGroupName').prop('disabled', true);
    $('#set001_04_01_mw003_name').val('');
    $('#set001_04_01_mw003_key').val('');
    $('#set001_04_01_mw003_type').val('');
    $('#set001_04_01_mw003_seqno').val('');
    $('#set001_04_01_mw003_value').val('');
    
    // Show Modal Window
    module_showModalWindow('set001_04_01_mw003', true);
} // .end of set001_04_01_mw003_updateUI

/**
 * Show Panel
 */
function set001_04_01_mw003_show(templateId)
{
	set001_04_01_mw003_templateId = templateId;
	
    set001_04_01_mw003_updateUI();
} // .end of set001_04_01_mw003_show

function set001_04_01_mw003_nameOnInput()
{
	var name = $('#set001_04_01_mw003_name').val();
	$('#set001_04_01_mw003_key').val( tycheesText_getSelectorIdFormat(name) );
} // .end of set001_04_01_mw003_nameOnInput

function set001_04_01_mw003_resetErrors()
{
	$('#set001_04_01_mw003_errorText_mandatoryFields').hide();
	$('#set001_04_01_mw003_newGroupName').css('background-color','');
	$('#set001_04_01_mw003_name').css('background-color','#FFF');
	$('#set001_04_01_mw003_type').css('background-color','#FFF');
	$('#set001_04_01_mw003_seqno').css('background-color','#FFF');
} // .end of set001_04_01_mw003_resetErrors

/**
 * Save changes and hide panel.
 */
function set001_04_01_mw003_save()
{
	$('#set001_04_01_mw003_saveButton').ladda().ladda('start');
	
	set001_04_01_mw003_resetErrors();
	
	var groupName = $.trim( $('#set001_04_01_mw003_groupName').val() );
    var isNewGroup = $('#set001_04_01_mw003_isGroupName').prop('checked');
    var newGroupName = $.trim( $('#set001_04_01_mw003_newGroupName').val() );
    var propKey	= $.trim( $('#set001_04_01_mw003_key').val() );
    var propName = $.trim( $('#set001_04_01_mw003_name').val() );
    var propType = $.trim( $('#set001_04_01_mw003_type').val() );
    var propSeqno = $.trim( $('#set001_04_01_mw003_seqno').val() );
    var propValue = $.trim( $('#set001_04_01_mw003_value').val() );
        
    if (isNewGroup && newGroupName == '') {
    	$('#set001_04_01_mw003_newGroupName').focus();
    	$('#set001_04_01_mw003_newGroupName').css('background-color','#FFB0B0');
    	$('#set001_04_01_mw003_errorText_mandatoryFields').show();
    	$('#set001_04_01_mw003_saveButton').ladda().ladda('stop');
    	return false;
    }
    
    if (propName == '') {
    	$('#set001_04_01_mw003_name').focus();
    	$('#set001_04_01_mw003_name').css('background-color','#FFB0B0');
    	$('#set001_04_01_mw003_errorText_mandatoryFields').show();
    	$('#set001_04_01_mw003_saveButton').ladda().ladda('stop');
    	return false;
    }

    if (propType == '') {
    	$('#set001_04_01_mw003_type').focus();
    	$('#set001_04_01_mw003_type').css('background-color','#FFB0B0');
    	$('#set001_04_01_mw003_errorText_mandatoryFields').show();
    	$('#set001_04_01_mw003_saveButton').ladda().ladda('stop');
    	return false;
    }

    if (propSeqno == '') {
    	$('#set001_04_01_mw003_seqno').focus();
    	$('#set001_04_01_mw003_seqno').css('background-color','#FFB0B0');
    	$('#set001_04_01_mw003_errorText_mandatoryFields').show();
    	$('#set001_04_01_mw003_saveButton').ladda().ladda('stop');
    	return false;
    }
        
    var newPropertiesObj = createNew_CommonTemplateProperties();
    newPropertiesObj.templateId = set001_04_01_mw003_templateId;
    if (isNewGroup)
    	newPropertiesObj.groupName = newGroupName;
    else
    	newPropertiesObj.groupName = groupName=='-- NO GROUP --' ? '' : groupName;
    newPropertiesObj.propKey = propKey;
    newPropertiesObj.propName = propName;
    newPropertiesObj.propType = propType;
    newPropertiesObj.propSeqno = Number(propSeqno);
    newPropertiesObj.propValue = propValue;

    // Push new object into profileList
    var templateObj = 
    	set001_04_01_getPlaceTemplateById(set001_04_01_mw003_templateId);
    templateObj.propertiesList.push( newPropertiesObj );
    templateObj.hasChanged = true;
    
    // Save into IndexedDB
    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
    // Update Employee UI
    set001_04_01_updateUI(templateObj.id);
    // Hide Progress
    $('#set001_04_01_mw003_saveButton').ladda().ladda('stop');
    // Close Modal Window
    $('#set001_04_01_mw003').modal('hide');
} // .end of set001_04_01_mw003_save

</script>