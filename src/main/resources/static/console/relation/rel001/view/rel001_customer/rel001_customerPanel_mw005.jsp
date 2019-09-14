<!-- Modal Window: Add Properties -->
<div class="modal inmodal fade" id="rel001_customerPanel_mw005" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW PROFILE PROPERTIES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_customerPanel_mw005_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Group Name</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="rel001_customerPanel_mw005_groupName"  class="form-control">
								                </select>
							                </div>
							                <br>
							                <div class="rel001_customerPanel_mw005_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="rel001_customerPanel_mw005_isGroupName" value=""> 
	                                        		<i></i> Give me a new Group Name 
	                                        	</label>
	                                        </div>
	                                        <input type="text" class="form-control" id="rel001_customerPanel_mw005_newGroupName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Key</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw005_key">
	                                    	<span id="rel001_customerPanel_mw005_key_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Value</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw005_value">
	                                    	<span id="rel001_customerPanel_mw005_value_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
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
		    	<button type="button" class="btn btn-primary" onclick="rel001_customerPanel_mw005_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_customerPanel_mw005_initialized = false;
var rel001_customerPanel_mw005_profileId;

/**
 * Init Panel
 */
function rel001_customerPanel_mw005_init()
{
    if (rel001_customerPanel_mw005_initialized == true)
        return false;
    
    $('.rel001_customerPanel_mw005_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_customerPanel_mw005_isGroupName').on('ifChecked', function(event){
    	$('#rel001_customerPanel_mw005_groupName').prop('disabled',true);
		$('#rel001_customerPanel_mw005_newGroupName').prop('disabled',false);
		$("#rel001_customerPanel_mw005_newGroupName").focus();
		
	});
	$('#rel001_customerPanel_mw005_isGroupName').on('ifUnchecked', function(event){
    	$('#rel001_customerPanel_mw005_groupName').prop('disabled',false);
		$('#rel001_customerPanel_mw005_newGroupName').prop('disabled',true);
		$("#rel001_customerPanel_mw005_key").focus();
	});
    
    $('#rel001_customerPanel_mw005').on('shown.bs.modal', function () {
	    $("#rel001_customerPanel_mw005_key").focus();
	});
    
	rel001_customerPanel_mw005_initialized = true;
} // .end of rel001_customerPanel_mw005_init

/**
 * Show Panel
 */
function rel001_customerPanel_mw005_updateUI()
{
    rel001_customerPanel_mw005_init();
    
    var customerProfileObj;
    $.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj) {
    	if (profileObj.id == rel001_customerPanel_mw005_profileId) {
    		customerProfileObj = profileObj;
    		return false;
		}
    });
    
    if (customerProfileObj==null)
    {
    	tycheesLogger_logError('Invalid object: customerProfileObj.', 'rel001_customerPanel_mw005_updateUI');
    	return false;
    }
    
    // Sort list, by group name
    customerProfileObj.propertiesList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.groupName, b.groupName);
		});
    
    var lastGroupName = '';
    var groupNameList = [];
    groupNameList.push('-- NO GROUP --');
    $.each(customerProfileObj.propertiesList, function(i, propertiesObj){
    	
    	if (lastGroupName != propertiesObj.groupName)
    	{
    		lastGroupName = propertiesObj.groupName;
    		groupNameList.push(propertiesObj.groupName);
    	}
    });
    
    $('#rel001_customerPanel_mw005_groupName').empty();
    $.each(groupNameList, function(i, groupName){    		
    	$('#rel001_customerPanel_mw005_groupName').append( '<option value="' + groupName + '">' + groupName + '</option>' );
    });
    
    // Reset inputs
    $('#rel001_customerPanel_mw005_isGroupName').iCheck('uncheck');
    $('#rel001_customerPanel_mw005_newGroupName').val('');
    $('#rel001_customerPanel_mw005_newGroupName').prop('disabled', true);
    $('#rel001_customerPanel_mw005_key').val('');
    $('#rel001_customerPanel_mw005_value').val('');
    $('#rel001_customerPanel_mw005_key_error').hide();
    $('#rel001_customerPanel_mw005_value_error').hide();
        
    // Show Modal Window
    module_showModalWindow('rel001_customerPanel_mw005', true);
} // .end of rel001_customerPanel_mw005_updateUI

/**
 * Show Panel
 */
function rel001_customerPanel_mw005_show(profileId)
{
	rel001_customerPanel_mw005_profileId = profileId;
	
    rel001_customerPanel_mw005_updateUI();
} // .end of rel001_customerPanel_mw005_show

/**
 * Save changes and hide panel.
 */
function rel001_customerPanel_mw005_save()
{
    var groupName = $('#rel001_customerPanel_mw005_groupName').val();
    var isNewGroup = $('#rel001_customerPanel_mw005_isGroupName').prop('checked');
    var newGroupName = $('#rel001_customerPanel_mw005_newGroupName').val();
    var propKey	= $('#rel001_customerPanel_mw005_key').val();
    var propValue = $('#rel001_customerPanel_mw005_value').val();
    var propertiesObj = createNew_CustomerProfileProperties();
        
    if ($.trim(propKey) === '')
    {
    	$('#rel001_customerPanel_mw005_key_error').show();
    	$('#rel001_customerPanel_mw005_key').focus();
    	return false;
    }
    
    if ($.trim(propValue) === '')
    {
    	$('#rel001_customerPanel_mw005_value_error').show();
    	$('#rel001_customerPanel_mw005_value').focus();
    	return false;
    }
    
    var newPropertiesObj = createNew_CustomerProfileProperties();
    newPropertiesObj.profileId = rel001_customerPanel_mw005_profileId;
    if (isNewGroup)
    	newPropertiesObj.groupName = newGroupName;
    else
    	newPropertiesObj.groupName = groupName=='-- NO GROUP --' ? '' : groupName;
    newPropertiesObj.propKey = propKey;
    newPropertiesObj.propValue = propValue;

    // Push new object into profileList
    var profileObj = 
    	Cached_getCustomerProfileById(rel001_customerPanel_customerObj.id, rel001_customerPanel_mw005_profileId);
    profileObj.propertiesList.push( newPropertiesObj );
    // Save into IndexedDB
    tycheesIO_saveBean(rel001_customerPanel_customerObj);
    // Update Customer UI - Only Profiles
    rel001_customerPanel_sw001_updateUI_tab2();
    // Close Modal Window
    $('#rel001_customerPanel_mw005').modal('hide');
} // .end of rel001_customerPanel_mw005_save

</script>