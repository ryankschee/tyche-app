<!-- Modal Window: Edit Calendar -->
<div class="modal inmodal fade" id="cal001_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT CALENDAR</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="cal001_mw002_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Current Calendar Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw002_currentName" disabled>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">New Calendar Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw002_newName">
	                                    </div>
	                                    <span id="cal001_mw002_newName_error" style="color:#ff000; display: none;">Invalid Calendar Name</span>
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
		    	<button type="button" class="btn btn-primary" onclick="cal001_mw002_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var cal001_mw002_initialized = false;
var cal001_mw002_calendarId;
var cal001_mw002_calendarType;
var cal001_mw002_calendarObj;

/**
 * Init Panel
 */
function cal001_mw002_init()
{
    if (cal001_mw002_initialized == true)
        return false;
    
    $('.cal001_mw002_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#cal001_mw002').on('shown.bs.modal', function () {
	    $("#cal001_mw002_newName").focus();
	})
    
	cal001_mw002_initialized = true;
} // .end of cal001_mw002_init

/**
 * Show Panel
 */
function cal001_mw002_updateUI()
{
    cal001_mw002_init();
      
    if (cal001_mw002_calendarType=='place')
    {
    	
    }
    else
    if (cal001_mw002_calendarType=='user')
    {
        var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
        $.each(userObj.calendarList, function(i, calendarObj) {
        	if (calendarObj.id==cal001_mw002_calendarId)
        	{
        		cal001_mw002_calendarObj = calendarObj;
        		$('#cal001_mw002_currentName').val( calendarObj.calendarName );
        		return false;
        	}
        });
    }
    else
    {
    	tycheesLogger_showToast('error', 'System Error', 'Invalid calendar type found (' + cal001_mw002_calendarType + ')');
    }
    
    module_showModalWindow('cal001_mw002', true); 
} // .end of cal001_mw002_updateUI

/**
 * Show Panel
 */
function cal001_mw002_show(calendarId, calendarType)
{
	cal001_mw002_calendarId = calendarId;
	cal001_mw002_calendarType = calendarType;

    cal001_mw002_updateUI();
} // .end of cal001_mw002_show

/**
 * Save changes and hide panel.
 */
function cal001_mw002_save()
{
	if (cal001_mw002_calendarObj == null)
    	return false;
    
	// Reset error
	$('#cal001_mw002_newName_error').hide();
	
    // Get user input
    var newCalendarName = $('#cal001_mw002_newName').val();
    
    // Validation #1
    if ($.trim(newCalendarName)=='')
    {
    	$('#cal001_mw002_newName_error').show();
    	return false;
    }
    
    // Set value
    cal001_mw002_calendarObj.calendarName = newCalendarName;
    cal001_mw002_calendarObj.hasChanged = true;
    // Get current user object
    var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
    // Save to IndexedDB
    tycheesIO_saveBean(userObj);
    // Update UI
    cal001_updateUI_calendarList();
	
    // Close Modal Window
    $('#cal001_mw002').modal('hide');
} // .end of cal001_mw002_save

</script>