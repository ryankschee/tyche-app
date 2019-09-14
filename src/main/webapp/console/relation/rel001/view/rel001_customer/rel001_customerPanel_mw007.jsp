<!-- Modal Window: Clone Profile -->
<div class="modal inmodal fade" id="rel001_customerPanel_mw007" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">CLONE CUSTOMER PROFILE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_customerPanel_mw007_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Clone from Profile</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw007_originalProfileName" disabled>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Profile Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw007_profileName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Default Profile <br>
	                                		<small class="text-navy">Custom elements</small>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="rel001_customerPanel_mw007_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="rel001_customerPanel_mw007_defaultProfile" value=""> 
	                                        		<i></i> Check it to enable. 
	                                        	</label>
	                                        </div>
	                                        <span class="help-block m-b-none">Making this profile default will deselect other profiles.</span>
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
		    	<button type="button" class="btn btn-primary" onclick="rel001_customerPanel_mw007_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_customerPanel_mw007_initialized = false;
var rel001_customerPanel_mw007_profileId;

/**
 * Init Panel
 */
function rel001_customerPanel_mw007_init()
{
    if (rel001_customerPanel_mw007_initialized == true)
        return false;
    
    $('.rel001_customerPanel_mw007_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_customerPanel_mw007').on('shown.bs.modal', function () {
	    $("#rel001_customerPanel_mw007_profileName").focus();
	})
    
	rel001_customerPanel_mw007_initialized = true;
} // .end of rel001_customerPanel_mw007_init

/**
 * Show Panel
 */
function rel001_customerPanel_mw007_updateUI()
{
    rel001_customerPanel_mw007_init();
        
    var customerProfileObj;
    $.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj) {
    	if (profileObj.id == rel001_customerPanel_mw007_profileId) {
    		customerProfileObj = profileObj;
    		return false;
		}
    });
    
    if (customerProfileObj==null)
    {
    	tycheesLogger_logError('Invalid object: customerProfileObj.', 'rel001_customerPanel_mw007_updateUI');
    	return false;
    }
    
    // Reset    
    $('#rel001_customerPanel_mw007_originalProfileName').val(customerProfileObj.profileName);
    $('#rel001_customerPanel_mw007_profileName').val('');
    $('#rel001_customerPanel_mw007_defaultProfile').iCheck('uncheck');
    
    module_showModalWindow('rel001_customerPanel_mw007', true);
} // .end of rel001_customerPanel_mw007_updateUI

/**
 * Show Panel
 */
function rel001_customerPanel_mw007_show(selectedProfileId)
{
	rel001_customerPanel_mw007_profileId = selectedProfileId;
	
    rel001_customerPanel_mw007_updateUI();
} // .end of rel001_customerPanel_mw007_show

/**
 * Save changes and hide panel.
 */
function rel001_customerPanel_mw007_save()
{
    var originalProfileObj = 
    	Cached_getCustomerProfileById(rel001_customerPanel_customerObj.id, rel001_customerPanel_mw007_profileId);
    
    var profileName	= $('#rel001_customerPanel_mw007_profileName').val();
    var defaultProfile = $('#rel001_customerPanel_mw007_defaultProfile').prop('checked');
    var newProfileObj = JSON.parse(JSON.stringify(originalProfileObj));
    
    console.log('rel001_customerPanel_mw007_save >> profileName='+profileName);
    console.log('rel001_customerPanel_mw007_save >> defaultProfile='+defaultProfile);
    console.log('rel001_customerPanel_mw007_save >> profileObj='+newProfileObj.id);
    
    newProfileObj.id = tycheesCommon_getUniqueId();
    newProfileObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
    newProfileObj.createdBy = tycheesCommon_getCurrentUserId();
    newProfileObj.profileName = profileName;
    newProfileObj.defaultProfile = defaultProfile;
    newProfileObj.hasChanged = true;
    
    if (defaultProfile==true)
    {
    	$.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj){
    		if (newProfileObj.id != profileObj.id)
    			profileObj.defaultProfile = false;
    	});
    }        
    
    $.each(newProfileObj.propertiesList, function(i, propertiesObj){
    	propertiesObj.id = tycheesCommon_getUniqueId();
    });
    
    // Push new object into profileList
    rel001_customerPanel_customerObj.profileList.push(newProfileObj);
    // Save into IndexedDB
    tycheesIO_saveBean(rel001_customerPanel_customerObj);
    // Update Customer UI - Only Profiles
    rel001_customerPanel_sw001_updateUI_tab2();
    // Close Modal Window
    $('#rel001_customerPanel_mw007').modal('hide');
} // .end of rel001_customerPanel_mw007_save

</script>