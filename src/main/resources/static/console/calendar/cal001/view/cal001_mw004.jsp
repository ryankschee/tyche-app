<!-- Modal Window: Calendar - Create Event -->
<div class="modal inmodal fade" id="cal001_mw004" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW CALENDAR EVENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="cal001_mw004_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Add into Calendar</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="cal001_mw004_calendarList">
	                                    	</select>
	                                    	<span id="cal001_mw004_calendarList_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Event Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw004_eventName">
	                                    	<span id="cal001_mw004_eventName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Name.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Start Date/Time</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group">
		                                    	<input id="cal001_mw004_eventDate" type="text" class="form-control" value="" data-mask="99/99/9999">
			                                    <span class="input-group-addon">
			                                    	<i class="fa fa-calendar"></i>
			                                    </span>
				                            </div>
	                                    	<span id="cal001_mw004_eventDate_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Date.
	                                    	</span>
				                            <br><br>
											<div class="input-group" data-autoclose="true">
				                                <input id="cal001_mw004_eventTime" type="text" class="form-control" value="" data-mask="99:99">
				                                <span class="input-group-addon">
				                                    <span class="fa fa-clock-o"></span>
				                                </span>	
				                            </div>
	                                    	<span id="cal001_mw004_eventTime_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Time.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <!-- 
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Finish Date/Time</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw004_lastName">
	                                    	<span id="cal001_mw004_eventFinishDateTime_error" style="color:#FF0000;display:none;">
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
		    	<button type="button" class="btn btn-primary" onclick="cal001_mw004_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var cal001_mw004_initialized = false;
var selectedDateObj;

/**
 * Init Panel
 */
function cal001_mw004_init()
{
    if (cal001_mw004_initialized == true)
        return false;
    
    //$('.cal001_mw004_i-checks').iCheck({
    //    checkboxClass: 'icheckbox_square-green',
    //    radioClass: 'iradio_square-green'
    //});
    /*
    $('#data_1 .input-group.date').datepicker({
            todayBtn: "linked",
            keyboardNavigation: false,
            forceParse: false,
            calendarWeeks: true,
            autoclose: true
        });
    
    $('.clockpicker').clockpicker();
	*/
    
    $('#cal001_mw004').on('shown.bs.modal', function () {
	    $("#cal001_mw004_eventName").focus();
	});
    
	cal001_mw004_initialized = true;
} // .end of cal001_mw004_init

/**
 * Show Panel
 */
function cal001_mw004_updateUI()
{
    cal001_mw004_init();
        
    // Hide
    $('#cal001_mw004_calendarList_error').hide();
    $('#cal001_mw004_eventName_error').hide();
    $('#cal001_mw004_eventStartDateTime_error').hide();
    $('#cal001_mw004_eventFinishDateTime_error').hide();
        
    // Construct Calendar list
    $('#cal001_mw004_calendarList').empty();
    var htmlLines = '<option value="0">--- SELECT MY CALENDAR ---</option>';
    $('#cal001_mw004_calendarList').append( htmlLines );
    
    // Prepare Calendar list from Place
    /*var placeObj = Cached_getPlaceById( tycheesCommon_getCurrentPlaceId() );
    $.each(placeObj.calendarList, function(i, calendarObj){
    	var selectedVal = '';
    	var htmlLines = '';
    	htmlLines += '<option value="' + calendarObj.id + '" ' + selectedVal + '>';
    	htmlLines += calendarObj.calendarName + ' (PLACE)';
    	htmlLines += '</option>';
    	
    	$('#cal001_mw004_calendarList').append( htmlLines );
    });*/
    
    // Prepare Calendar list from User
    var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
    $.each(userObj.calendarList, function(i, calendarObj){
    	var selectedVal = '';
    	var htmlLines = '';
    	htmlLines += '<option value="' + calendarObj.id + '" ' + selectedVal + '>';
    	htmlLines += calendarObj.calendarName;
    	htmlLines += '</option>';
    	
    	$('#cal001_mw004_calendarList').append( htmlLines );
    });
    
    if (selectedDateObj != null)
    {
    	$('#cal001_mw004_eventDate').val( tycheesDateTime_getFormattedDate_ddMMyyyy(selectedDateObj) );
    	$('#cal001_mw004_eventDate').prop('disabled', true);
    }
    else
    {
    	$('#cal001_mw004_eventDate').val( "" );
    	$('#cal001_mw004_eventDate').prop('disabled', false);
    }
    
    // Reset
    $('#cal001_mw004_calendarList').val('0');
    $('#cal001_mw004_eventName').val('');
    
    // Show Modal Window
    module_showModalWindow('cal001_mw004', true); 
} // .end of cal001_mw004_updateUI

/**
 * Show Panel
 */
function cal001_mw004_show(dateObj)
{
	selectedDateObj = dateObj;
    cal001_mw004_updateUI();
} // .end of cal001_mw004_show

/**
 * Save 
 */
function cal001_mw004_save()
{
    // Reset
    $('#cal001_mw004_calendarList_error').hide();
    $('#cal001_mw004_eventName_error').hide();
    $('#cal001_mw004_eventDate_error').hide();
    $('#cal001_mw004_eventTime_error').hide();
	
    // Get user inputs
	var calendarId  = tycheesText_getSafeString( $("#cal001_mw004_calendarList").val() );
    var eventName   = tycheesText_getSafeString( $("#cal001_mw004_eventName").val() );
    var eventDate   = tycheesText_getSafeString( $("#cal001_mw004_eventDate").val() );
    var eventTime   = tycheesText_getSafeString( $("#cal001_mw004_eventTime").val() );
   
    // Validation
    if (calendarId=='' || calendarId=='0')
    {
        $('#cal001_mw004_calendarList_error').show();
        return false;
    }
    if (eventName=='')
    {
        $('#cal001_mw004_eventName_error').show();
        return false;
    }
    if (tycheesDateTime_isValidDate_ddmmyyyy(eventDate)==false)
    {
        $('#cal001_mw004_eventDate_error').show();
        return false;
    }
    if (tycheesDateTime_isValidTime_hhmm(eventTime)==false)
    {
        $('#cal001_mw004_eventTime_error').show();
        return false;
    }
   
    var dateObj = new Date( tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(eventDate, eventTime) );
    var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );    
   	$.each(userObj.calendarList, function(i, calendarObj){
   		if (calendarObj.id == calendarId)
   		{
   			// Calendar event object
		    var newEventObj = createNew_CommonCalendarEvent();
		    newEventObj.calendarId = calendarId;
		    newEventObj.title = eventName;
		    newEventObj.start = dateObj;
		    newEventObj.end = dateObj;
		    newEventObj.color = calendarObj.color;
		    newEventObj.backgroundColor = calendarObj.backgroundColor;
		    newEventObj.borderColor = calendarObj.borderColor;
		    newEventObj.textColor = calendarObj.textColor;
   
   			calendarObj.eventList.push( newEventObj );
   			calendarObj.hasChanged = true;
   		}
   	});
   	
    // Save to localDB
    tycheesIO_saveBean( userObj );    
    // Update UI
    cal001_updateUI_calendarEvents();
    // Hide modal window
    $("#cal001_mw004").modal('hide');
} // .end of cal001_mw004_save

</script>