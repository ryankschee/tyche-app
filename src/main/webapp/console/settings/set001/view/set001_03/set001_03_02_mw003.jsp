<!-- Modal Window: Add Properties -->
<div class="modal inmodal fade" id="set001_03_02_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
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
		    <div id="set001_03_02_mw003_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Group Name</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="set001_03_02_mw003_groupName"  class="form-control">
								                </select>
							                </div>
							                <br>
							                <div class="set001_03_02_mw003_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_03_02_mw003_isGroupName" value=""> 
	                                        		<i></i> Give me a new Group Name 
	                                        	</label>
	                                        </div>
	                                        <input type="text" class="form-control" id="set001_03_02_mw003_newGroupName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Key</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_03_02_mw003_key">
	                                    	<span id="set001_03_02_mw003_key_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Value</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_03_02_mw003_value">
	                                    	<span id="set001_03_02_mw003_value_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_03_02_mw003_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_03_02_mw003_initialized = false;
var set001_03_02_mw003_templateId;

/**
 * Init Panel
 */
function set001_03_02_mw003_init()
{
    if (set001_03_02_mw003_initialized == true)
        return false;
    
    $('.set001_03_02_mw003_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_03_02_mw003_isGroupName').on('ifChecked', function(event){
    	$('#set001_03_02_mw003_groupName').prop('disabled',true);
		$('#set001_03_02_mw003_newGroupName').prop('disabled',false);
		$("#set001_03_02_mw003_newGroupName").focus();
		
	});
	$('#set001_03_02_mw003_isGroupName').on('ifUnchecked', function(event){
    	$('#set001_03_02_mw003_groupName').prop('disabled',false);
		$('#set001_03_02_mw003_newGroupName').prop('disabled',true);
		$("#set001_03_02_mw003_key").focus();
	});
    
    $('#set001_03_02_mw003').on('shown.bs.modal', function () {
	    $("#set001_03_02_mw003_key").focus();
	});
    
	set001_03_02_mw003_initialized = true;
} // .end of set001_03_02_mw003_init

/**
 * Show Panel
 */
function set001_03_02_mw003_updateUI()
{
    set001_03_02_mw003_init();
    
    var templateObj = 
    	set001_03_02_getPlaceTemplateById(set001_03_02_mw003_templateId);
    
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
    
    $('#set001_03_02_mw003_groupName').empty();
    $.each(groupNameList, function(i, groupName){    		
    	$('#set001_03_02_mw003_groupName').append( '<option value="' + groupName + '">' + groupName + '</option>' );
    });
    
    // Reset inputs
    $('#set001_03_02_mw003_isGroupName').iCheck('uncheck');
    $('#set001_03_02_mw003_newGroupName').val('');
    $('#set001_03_02_mw003_newGroupName').prop('disabled', true);
    $('#set001_03_02_mw003_key').val('');
    $('#set001_03_02_mw003_value').val('');
    $('#set001_03_02_mw003_key_error').hide();
    $('#set001_03_02_mw003_value_error').hide();
        
    // Show Modal Window
    $('#set001_03_02_mw003').modal({backdrop: 'static', keyboard: false});
} // .end of set001_03_02_mw003_updateUI

/**
 * Show Panel
 */
function set001_03_02_mw003_show(templateId)
{
	set001_03_02_mw003_templateId = templateId;
	
    set001_03_02_mw003_updateUI();
} // .end of set001_03_02_mw003_show

/**
 * Save changes and hide panel.
 */
function set001_03_02_mw003_save()
{
    var groupName = $('#set001_03_02_mw003_groupName').val();
    var isNewGroup = $('#set001_03_02_mw003_isGroupName').prop('checked');
    var newGroupName = $('#set001_03_02_mw003_newGroupName').val();
    var propKey	= $('#set001_03_02_mw003_key').val();
    var propValue = $('#set001_03_02_mw003_value').val();
        
    if ($.trim(propKey) === '')
    {
    	$('#set001_03_02_mw003_key_error').show();
    	$('#set001_03_02_mw003_key').focus();
    	return false;
    }
        
    var newPropertiesObj = createNew_CommonTemplateProperties();
    newPropertiesObj.templateId = set001_03_02_mw003_templateId;
    if (isNewGroup)
    	newPropertiesObj.groupName = newGroupName;
    else
    	newPropertiesObj.groupName = groupName=='-- NO GROUP --' ? '' : groupName;
    newPropertiesObj.propKey = propKey;
    newPropertiesObj.propValue = propValue;

    // Push new object into profileList
    var templateObj = 
    	set001_03_02_getPlaceTemplateById(set001_03_02_mw003_templateId);
    templateObj.propertiesList.push( newPropertiesObj );
    templateObj.hasChanged = true;
    // Save into IndexedDB
    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
    // Update Customer UI
    set001_03_02_updateUI(templateObj.id);
    // Close Modal Window
    $('#set001_03_02_mw003').modal('hide');
} // .end of set001_03_02_mw003_save

</script>