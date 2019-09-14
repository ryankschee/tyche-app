<!-- Modal Window: Edit Profile -->
<div class="modal inmodal fade" id="rel001_customerPanel_mw004" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT CUSTOMER PROFILE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_customerPanel_mw004_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Profile Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw004_profileName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Default Profile <br>
	                                		<small class="text-navy">Custom elements</small>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="rel001_customerPanel_mw004_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="rel001_customerPanel_mw004_defaultProfile" value=""> 
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
		    	<button type="button" class="btn btn-primary" onclick="rel001_customerPanel_mw004_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_customerPanel_mw004_initialized = false;
var rel001_customerPanel_mw004_profileId;

/**
 * Init Panel
 */
function rel001_customerPanel_mw004_init()
{
    if (rel001_customerPanel_mw004_initialized == true)
        return false;
    
    $('.rel001_customerPanel_mw004_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_customerPanel_mw004').on('shown.bs.modal', function () {
	    $("#rel001_customerPanel_mw004_profileName").focus();
	})
    
	rel001_customerPanel_mw004_initialized = true;
} // .end of rel001_customerPanel_mw004_init

/**
 * Show Panel
 */
function rel001_customerPanel_mw004_updateUI()
{
    rel001_customerPanel_mw004_init();
    
    var customerProfileObj;
    $.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj) {
    	if (profileObj.id == rel001_customerPanel_mw004_profileId) {
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
    $('#rel001_customerPanel_mw004_profileName').val(customerProfileObj.profileName);
    if (customerProfileObj.defaultProfile == true)
    	$('#rel001_customerPanel_mw004_defaultProfile').iCheck('check');
    else
    	$('#rel001_customerPanel_mw004_defaultProfile').iCheck('uncheck');
    
    module_showModalWindow('rel001_customerPanel_mw004', true);
} // .end of rel001_customerPanel_mw004_updateUI

/**
 * Show Panel
 */
function rel001_customerPanel_mw004_show(selectedProfileId)
{
	rel001_customerPanel_mw004_profileId = selectedProfileId;
	
    rel001_customerPanel_mw004_updateUI();
} // .end of rel001_customerPanel_mw004_show

/**
 * Save changes and hide panel.
 */
function rel001_customerPanel_mw004_save()
{
    var profileName	= $('#rel001_customerPanel_mw004_profileName').val();
    var defaultProfile = $('#rel001_customerPanel_mw004_defaultProfile').prop('checked');
    var existingProfileObj = Cached_getCustomerProfileById(rel001_customerPanel_customerObj.id, rel001_customerPanel_mw004_profileId);
    
    existingProfileObj.profileName = profileName;
    existingProfileObj.defaultProfile = defaultProfile;
    existingProfileObj.hasChanged = true;
    
    if (defaultProfile==true)
    {
    	$.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj){
    		if (existingProfileObj.id != profileObj.id)
    			profileObj.defaultProfile = false;
    	});
    }
        
    // Save into IndexedDB
    tycheesIO_saveBean(rel001_customerPanel_customerObj);
    // Update Customer UI - Only Profiles
    rel001_customerPanel_sw001_updateUI_tab2();
    // Close Modal Window
    $('#rel001_customerPanel_mw004').modal('hide');
} // .end of rel001_customerPanel_mw004_save

</script>