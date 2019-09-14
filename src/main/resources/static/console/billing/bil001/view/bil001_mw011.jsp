<!-- Modal Window: Add Properties -->
<div class="modal inmodal fade" id="mw011" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">NEW BILLING PROPERTIES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw011_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Group Name</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="mw011_groupName"  class="form-control">
								                </select>
							                </div>
							                <br>
							                <div class="mw011_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="mw011_isGroupName" value=""> 
	                                        		<i></i> Give me a new Group Name 
	                                        	</label>
	                                        </div>
	                                        <input type="text" class="form-control" id="mw011_newGroupName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Key</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw011_key">
	                                    	<span id="mw011_key_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Value</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw011_value">
	                                    	<span id="mw011_value_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="mw011_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw011_initialized = false;
var mw011_profileId;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw011_isOpen()
{
	return ($("#mw011").data('bs.modal') || {}).isShown;	
} // .end of mw011_isOpen

/**
 * Init Panel
 */
function mw011_init()
{
    if (mw011_initialized == true)
        return false;
    
    $('.mw011_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#mw011_isGroupName').on('ifChecked', function(event){
    	$('#mw011_groupName').prop('disabled',true);
		$('#mw011_newGroupName').prop('disabled',false);
		$("#mw011_newGroupName").focus();
		
	});
	$('#mw011_isGroupName').on('ifUnchecked', function(event){
    	$('#mw011_groupName').prop('disabled',false);
		$('#mw011_newGroupName').prop('disabled',true);
		$("#mw011_key").focus();
	});
    
    $('#mw011').on('shown.bs.modal', function () {
	    $("#mw011_key").focus();
	});
    
	mw011_initialized = true;
} // .end of mw011_init

/**
 * Show Panel
 */
function mw011_updateUI()
{
    mw011_init();
    
    // Sort list, by group name
    global_billingObj.propertiesList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.groupName, b.groupName);
		});
		
	var lastGroupName = '';
    var groupNameList = [];
    groupNameList.push('-- NO GROUP --');
    $.each(global_billingObj.propertiesList, function(i, propertiesObj){
    	
    	if (lastGroupName != propertiesObj.groupName)
    	{
    		lastGroupName = propertiesObj.groupName;
    		groupNameList.push(propertiesObj.groupName);
    	}
    });
    
    $('#mw011_groupName').empty();
    $.each(groupNameList, function(i, groupName){    		
    	$('#mw011_groupName').append( '<option value="' + groupName + '">' + groupName + '</option>' );
    });
    
    // Reset inputs
    $('#mw011_isGroupName').iCheck('uncheck');
    $('#mw011_newGroupName').val('');
    $('#mw011_newGroupName').prop('disabled', true);
    $('#mw011_key').val('');
    $('#mw011_value').val('');
    $('#mw011_key_error').hide();
    $('#mw011_value_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw011', true);
} // .end of mw011_updateUI

/**
 * Show Panel
 */
function mw011_show()
{
	mw011_updateUI();
} // .end of mw011_show

/**
 * Save changes and hide panel.
 */
function mw011_save()
{
    var groupName = $('#mw011_groupName').val();
    var isNewGroup = $('#mw011_isGroupName').prop('checked');
    var newGroupName = $('#mw011_newGroupName').val();
    var propKey	= $('#mw011_key').val();
    var propValue = $('#mw011_value').val();
    var propertiesObj = createNew_CustomerProfileProperties();
        
    if ( $.trim(propKey) === '')
    {
    	$('#mw011_key_error').show();
    	$('#mw011_key').focus();
    	return false;
    }
    
    if ( $.trim(propValue) === '')
    {
    	$('#mw011_value_error').show();
    	$('#mw011_value').focus();
    	return false;
    }
    
    var newPropertiesObj = createNew_BillingProperties();
    newPropertiesObj.billingId = global_billingObj.id;
    if (isNewGroup)
    	newPropertiesObj.groupName = newGroupName;
    else  	
    	newPropertiesObj.groupName = groupName=='-- NO GROUP --' ? '' : groupName;
    newPropertiesObj.propKey = propKey;
    newPropertiesObj.propValue = propValue;

    // Push new object into profileList
    global_billingObj.propertiesList.push( newPropertiesObj );
	// Auto-save Billing
	bil001_menuPanel_save();
    // Update Customer UI
    mw010_reloadBillingProperties();
    // Close Modal Window
    module_closeModalWindow('mw011');
} // .end of mw011_save

</script>