<!-- Modal Window: Change Email -->
<div class="modal inmodal fade" id="set001_21_00_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">CHANGE EMAIL</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_21_00_mw001_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Email</label>
	                                    <div class="col-sm-8" class="input-group">
	                                    	<input type="text" class="form-control" id="set001_21_00_mw001_email">
					                    	<span class="input-group-btn">
												<button type="button" class="btn btn-primary" onclick="set001_21_00_mw001_requestCode();">
													<i class="fa fa-shield" aria-hidden="true"></i> Request Code
												</button>
											</span>
	                                        <span class="help-block m-b-none">**Note: You will use this email for login purpose.</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Verification Code</label>
	                                    <div class="col-sm-8" class="input-group">
	                                    	<input type="text" class="form-control" id="set001_21_00_mw001_verificationCode">
					                    	<span class="input-group-btn">
												<button type="button" class="btn btn-primary" onclick="set001_21_00_mw001_verifyCode();">
													<i class="fa fa-shield" aria-hidden="true"></i> Verify Code
												</button>
											</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_21_00_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_21_00_mw001_initialized = false;

/**
 * Init Panel
 */
function set001_21_00_mw001_init()
{
    if (set001_21_00_mw001_initialized == true)
        return false;
    
    $('#set001_21_00_mw001').on('shown.bs.modal', function () {
	    $("#set001_21_00_mw001_email").focus();
	});
    
	set001_21_00_mw001_initialized = true;
} // .end of set001_21_00_mw001_init

/**
 * Show Panel
 */
function set001_21_00_mw001_updateUI()
{
    set001_21_00_mw001_init();
        
    // Reset
    $('#set001_21_00_mw001_email').val('');
    $('#set001_21_00_mw001_verificationCode').val('');
    
    module_showModalWindow('set001_21_00_mw001', true);
} // .end of set001_21_00_mw001_updateUI

/**
 * Show Panel
 */
function set001_21_00_mw001_show()
{
    set001_21_00_mw001_updateUI();
} // .end of set001_21_00_mw001_show

function set001_21_00_mw001_requestCode()
{
	
} // .end of set001_21_00_mw001_requestCode

function set001_21_00_mw001_verifyCode()
{
	
} // .end of set001_21_00_mw001_verifyCode

/**
 * Save changes and hide panel.
 */
function set001_21_00_mw001_save()
{
	var l_userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
	l_userObj.email = $('#set001_21_00_mw001_email').val();
	
    // Save into IndexedDB
    tycheesIO_saveBean(l_userObj);
    // Update Customer UI
    set001_21_00_updateUI();
    // Close Modal Window
    $('#set001_21_00_mw001').modal('hide');
} // .end of set001_21_00_mw001_save

</script>