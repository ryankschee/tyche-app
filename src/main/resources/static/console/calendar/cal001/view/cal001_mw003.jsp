<!-- Modal Window: Delete Calendar -->
<div class="modal inmodal fade" id="cal001_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">DELETE CALENDAR</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="cal001_mw003_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-12 control-label" style="text-align:center; font-size:14pt; font-weight: normal;">Confirm to delete this calendar?</label>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Calendar Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw003_calendarName" disabled>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
		    	<button type="button" class="btn btn-primary" onclick="cal001_mw003_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var cal001_mw003_initialized = false;
var cal001_mw003_calendarId;
var cal001_mw003_calendarType;
var cal001_mw003_calendarObj;

/**
 * Init Panel
 */
function cal001_mw003_init()
{
    if (cal001_mw003_initialized == true)
        return false;
        
    $('#cal001_mw003').on('shown.bs.modal', function () {
	    //$("#cal001_mw003_profileName").focus();
	})
    
	cal001_mw003_initialized = true;
} // .end of cal001_mw003_init

/**
 * Show Panel
 */
function cal001_mw003_updateUI()
{
    cal001_mw003_init();
      
    if (cal001_mw003_calendarType=='place')
    {
    	
    }
    else
    if (cal001_mw003_calendarType=='user')
    {
    	 var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
         $.each(userObj.calendarList, function(i, calendarObj) {
         	if (calendarObj.id==cal001_mw003_calendarId)
         	{
         		cal001_mw003_calendarObj = calendarObj;
         		$('#cal001_mw003_calendarName').val( calendarObj.calendarName );
         		return false;
         	}
         });
    }
    else
    {
    	tycheesLogger_showToast('error', 'System Error', 'Invalid calendar type found (' + cal001_mw003_calendarType + ')');
    }
      
    module_showModalWindow('cal001_mw003', true); 
} // .end of cal001_mw003_updateUI

/**
 * Show Panel
 */
function cal001_mw003_show(calendarId, calendarType)
{
	cal001_mw003_calendarId = calendarId;
	cal001_mw003_calendarType = calendarType;

    cal001_mw003_updateUI();
} // .end of cal001_mw003_show

/**
 * Save changes and hide panel.
 */
function cal001_mw003_save()
{
    if (cal001_mw003_calendarObj == null)
    	return false;
    
    // Delete calendar
    Cached_deleteBean(cal001_mw003_calendarObj);
    // Get current user object
    var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
    // Save to IndexedDB
    tycheesIO_saveBean(userObj);
    // Update UI
    cal001_updateUI_calendarList();
	
    // Close Modal Window
    $('#cal001_mw003').modal('hide');
} // .end of cal001_mw003_save

</script>