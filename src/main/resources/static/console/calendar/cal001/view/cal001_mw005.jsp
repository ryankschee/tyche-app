<!-- Modal Window: Calendar - Edit Event -->
<div class="modal inmodal fade" id="cal001_mw005" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT CALENDAR EVENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="cal001_mw005_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Calendar</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw005_calendarName">
	                                    	<span id="cal001_mw005_calendarName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Event Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw005_eventName">
	                                    	<span id="cal001_mw005_eventName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Name.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Start Date/Time</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group">
		                                    	<input id="cal001_mw005_eventDate" type="text" class="form-control" value="" data-mask="99/99/9999">
			                                    <span class="input-group-addon">
			                                    	<i class="fa fa-calendar"></i>
			                                    </span>
				                            </div>
	                                    	<span id="cal001_mw005_eventDate_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Date.
	                                    	</span>
				                            <br><br>
											<div class="input-group" data-autoclose="true">
				                                <input id="cal001_mw005_eventTime" type="text" class="form-control" value="" data-mask="99:99">
				                                <span class="input-group-addon">
				                                    <span class="fa fa-clock-o"></span>
				                                </span>	
				                            </div>
	                                    	<span id="cal001_mw005_eventTime_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Time.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <!-- 
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Finish Date/Time</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw005_lastName">
	                                    	<span id="cal001_mw005_eventFinishDateTime_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                 -->
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="cal001_mw005_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var cal001_mw005_initialized = false;
var cal001_mw005_calendarObj;
var cal001_mw005_eventObj;

/**
 * Init Panel
 */
function cal001_mw005_init()
{
    if (cal001_mw005_initialized == true)
        return false;
    
    $('#cal001_mw005').on('shown.bs.modal', function () {
	    $("#cal001_mw005_eventName").focus();
	});
    
	cal001_mw005_initialized = true;
} // .end of cal001_mw005_init

/**
 * Show Panel
 */
function cal001_mw005_updateUI()
{
    cal001_mw005_init();
        
    // Hide
    $('#cal001_mw005_calendarName_error').hide();
    $('#cal001_mw005_eventName_error').hide();
    $('#cal001_mw005_eventStartDateTime_error').hide();
    $('#cal001_mw005_eventFinishDateTime_error').hide();
        
    // Find calendar object
	var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
    $.each(userObj.calendarList, function(i, calendarObj) {
    	$.each(calendarObj.eventList, function(j, eventObj){
    		if (eventObj.id == cal001_mw005_eventObj.id)
    			cal001_mw005_calendarObj = calendarObj; 
    	});	
    });
    
    // Set values
    $('#cal001_mw005_calendarName').val(cal001_mw005_calendarObj.calendarName);
    $('#cal001_mw005_eventName').val( cal001_mw005_eventObj.title );
    $('#cal001_mw005_eventDate').val( tycheesDateTime_getFormattedDate_ddMMyyyy(cal001_mw005_eventObj.start.toDate()) );
    $('#cal001_mw005_eventTime').val( tycheesDateTime_getFormattedDate_hhmm(cal001_mw005_eventObj.start.toDate()) );
    
    // Show Modal Window
    module_showModalWindow('cal001_mw005', true); 
} // .end of cal001_mw005_updateUI

/**
 * Show Panel
 */
function cal001_mw005_show(eventObj)
{
	if (eventObj==null)
		return false;
	
	cal001_mw005_eventObj = eventObj;
    cal001_mw005_updateUI();
} // .end of cal001_mw005_show

/**
 * Save 
 */
function cal001_mw005_save()
{
    // Reset
    $('#cal001_mw005_eventName_error').hide();
    $('#cal001_mw005_eventDate_error').hide();
    $('#cal001_mw005_eventTime_error').hide();
	
    // Get user inputs
    var eventName   = tycheesText_getSafeString( $("#cal001_mw005_eventName").val() );
    var eventDate   = tycheesText_getSafeString( $("#cal001_mw005_eventDate").val() );
    var eventTime   = tycheesText_getSafeString( $("#cal001_mw005_eventTime").val() );
   
    // Validation
    if (eventName=='')
    {
        $('#cal001_mw005_eventName_error').show();
        return false;
    }
    if (tycheesDateTime_isValidDate_ddmmyyyy(eventDate)==false)
    {
        $('#cal001_mw005_eventDate_error').show();
        return false;
    }
    if (tycheesDateTime_isValidTime_hhmm(eventTime)==false)
    {
        $('#cal001_mw005_eventTime_error').show();
        return false;
    }
   
    var dateObj = new Date( tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(eventDate, eventTime) );
    var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );    
   	
   	cal001_mw005_eventObj.title = eventName;
    cal001_mw005_eventObj.start = dateObj;
    cal001_mw005_eventObj.end = dateObj;
   	
    cal001_mw005_calendarObj.hasChanged = true;
    
    // Save to localDB
    tycheesIO_saveBean( userObj );    
    // Update UI
    cal001_updateUI_calendarEvents();
    // Hide modal window
    $("#cal001_mw005").modal('hide');
} // .end of cal001_mw005_save

</script>