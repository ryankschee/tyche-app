<!-- Modal Window: Change Password -->
<div class="modal inmodal fade" id="set001_21_00_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">CHANGE PASSWORD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_21_00_mw002_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Current Password</label>
	                                    <div class="col-sm-8" class="input-group">
	                                    	<input type="password" class="form-control" id="set001_21_00_mw002_currentPassword">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Password</label>
	                                    <div class="col-sm-8" class="input-group">
	                                    	<input type="password" class="form-control" id="set001_21_00_mw002_newPassword">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Retype Password</label>
	                                    <div class="col-sm-8" class="input-group">
	                                    	<input type="password" class="form-control" id="set001_21_00_mw002_retypePassword">
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
		    	<button type="button" class="btn btn-primary" onclick="set001_21_00_mw002_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_21_00_mw002_initialized = false;

/**
 * Init Panel
 */
function set001_21_00_mw002_init()
{
    if (set001_21_00_mw002_initialized == true)
        return false;
    
    $('#set001_21_00_mw002').on('shown.bs.modal', function () {
	    $("#set001_21_00_mw002_currentPassword").focus();
	});
    
	set001_21_00_mw002_initialized = true;
} // .end of set001_21_00_mw002_init

/**
 * Show Panel
 */
function set001_21_00_mw002_updateUI()
{
    set001_21_00_mw002_init();
        
    // Reset
    $('#set001_21_00_mw002_currentPassword').val('');
    $('#set001_21_00_mw002_newPassword').val('');
    $('#set001_21_00_mw002_retypePassword').val('');
    
    module_showModalWindow('set001_21_00_mw002', true);
} // .end of set001_21_00_mw002_updateUI

/**
 * Show Panel
 */
function set001_21_00_mw002_show()
{
    set001_21_00_mw002_updateUI();
} // .end of set001_21_00_mw002_show

/**
 * Save changes and hide panel.
 */
function set001_21_00_mw002_save()
{
	var l_userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
	//l_userObj.email = $('#set001_21_00_mw002_email').val();
	
    // Save into IndexedDB
    tycheesIO_saveBean(l_userObj);
    // Update Customer UI
    set001_21_00_updateUI();
    // Close Modal Window
    $('#set001_21_00_mw002').modal('hide');
} // .end of set001_21_00_mw002_save

</script>