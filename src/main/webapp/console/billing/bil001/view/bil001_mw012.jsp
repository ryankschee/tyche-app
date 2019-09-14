<!-- Modal Window: Edit Properties -->
<div class="modal inmodal fade" id="mw012" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">EDIT BILLING PROPERTIES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw012_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Group Name</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="mw012_groupName"  class="form-control">
								                </select>
							                </div>
							                <br>
							                <div class="mw012_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="mw012_isGroupName" value=""> 
	                                        		<i></i> Give me a new Group Name 
	                                        	</label>
	                                        </div>
	                                        <input type="text" class="form-control" id="mw012_newGroupName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Key</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw012_key">
	                                    	<span id="mw012_key_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Properties Value</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw012_value">
	                                    	<span id="mw012_value_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
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
		    	<button type="button" class="btn btn-primary" onclick="mw012_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw012_initialized = false;
var mw012_propertiesId;
var mw012_propertiesObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw012_isOpen()
{
	return ($("#mw012").data('bs.modal') || {}).isShown;	
} // .end of mw012_isOpen

/**
 * Init Panel
 */
function mw012_init()
{
    if (mw012_initialized == true)
        return false;
    
    $('.mw012_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#mw012_isGroupName').on('ifChecked', function(event){
    	$('#mw012_groupName').prop('disabled',true);
		$('#mw012_newGroupName').prop('disabled',false);
		$("#mw012_newGroupName").focus();
	});
	$('#mw012_isGroupName').on('ifUnchecked', function(event){
		$('#mw012_groupName').prop('disabled',false);
		$('#mw012_newGroupName').prop('disabled',true);
		$("#mw012_key").focus();
	});
    
    $('#mw012').on('shown.bs.modal', function () {
	    $("#mw012_key").focus();
	});
    
	mw012_initialized = true;
} // .end of mw012_init

/**
 * Show Panel
 */
function mw012_updateUI()
{
    mw012_init();
    
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
    
    $('#mw012_groupName').empty();
    $.each(groupNameList, function(i, groupName){    
    	var selectedVal = '';	
    	if (mw012_propertiesObj.groupName == groupName)
    		selectedVal = 'selected';
    		
    	$('#mw012_groupName').append( '<option value="' + groupName + '" ' + selectedVal + '>' + groupName + '</option>' );
    });
    
    // Reset inputs
    $('#mw012_isGroupName').iCheck('uncheck');
    $('#mw012_newGroupName').val('');
    $('#mw012_newGroupName').prop('disabled', true);
    $('#mw012_key').val( mw012_propertiesObj.propKey );
    $('#mw012_value').val( mw012_propertiesObj.propValue );
    $('#mw012_key_error').hide();
    $('#mw012_value_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw012', true);
} // .end of mw012_updateUI

/**
 * Show Panel
 */
function mw012_show(propertiesId)
{
	mw012_propertiesId = propertiesId;
	
    $.each(global_billingObj.propertiesList, function(i, propObj){
    	if (propObj.id == mw012_propertiesId)
    		mw012_propertiesObj = propObj;
    });
	
    mw012_updateUI();
} // .end of mw012_show

/**
 * Save changes and hide panel.
 */
function mw012_save()
{
    var groupName = $('#mw012_groupName').val();
    var isNewGroup = $('#mw012_isGroupName').prop('checked');
    var newGroupName = $('#mw012_newGroupName').val();
    var propKey	= $('#mw012_key').val();
    var propValue = $('#mw012_value').val();
    var propertiesObj = createNew_CustomerProfileProperties();
        
    if ( $.trim(propKey) === '')
    {
    	$('#mw012_key_error').show();
    	$('#mw012_key').focus();
    	return false;
    }
    
    if ( $.trim(propValue) === '')
    {
    	$('#mw012_value_error').show();
    	$('#mw012_value').focus();
    	return false;
    }
    
    if (isNewGroup)
    	mw012_propertiesObj.groupName = newGroupName;
    else
    	mw012_propertiesObj.groupName = groupName=='-- NO GROUP --' ? '' : groupName;
    mw012_propertiesObj.propKey = propKey;
    mw012_propertiesObj.propValue = propValue;
    mw012_propertiesObj.hasChanged = true;

	// Auto-save Billing
	bil001_menuPanel_save();
    // Update Customer UI
    mw010_reloadBillingProperties();
    // Close Modal Window
    module_closeModalWindow('mw012');
} // .end of mw012_save

</script>