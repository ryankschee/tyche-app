
<!-- MODAL DIALOG: Billing Schedule -->
<div class="modal inmodal fade" id="mw016" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">SCHEDULED EVENTS (<span id="mw016_billingNo"></span>)</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-4">
						<div id="mw016_createEvent_header" class="ibox-title" style="background-color:#777;color:#fff;">
							<h5>Create New Event</h5>
						</div>
						<div id="mw016_createEvent_body" class="ibox-content" style="background-color:#dddddd;height:300px;">
                            <div id="mw016_createEvent_bodyContent">
                            	<div class="row">
                                	<label class="col-md-4 control-label">Available Events </label>
                                    <div class="col-md-8">
                                    	<div class="input-group" style="width:100%;">
							                <select id="mw016_leftPanel_eventList" class="form-control">
							                </select>
                                    		<span id="mw016_leftPanel_eventList_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
						                </div>
                                    </div>
                                </div>
                                <div class="row">
                                	<label class="col-md-4 control-label">Date</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" id="mw016_leftPane_date" data-mask="99/99/9999" placeholder="dd/mm/yyyy">
                                    	<span id="mw016_leftPane_date_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
                                    </div>
                                </div>
                                <div class="row">
                                	<label class="col-md-4 control-label">Time</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" id="mw016_leftPane_time" data-mask="99:99" placeholder="hh:mm">
                                    	<span id="mw016_leftPane_time_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
                                    </div>
                                </div>
                                <div class="row">
                                	<label class="col-md-4 control-label">Remarks</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" id="mw016_leftPane_remarks">
                                    	<span id="mw016_leftPane_remarks_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
                                    </div>
                                </div>
                                <div>
                                	<button id="mw016_leftPane_addWorkflowEvent" type="button" class="btn btn-primary pull-right" onclick="mw016_addEvent();">
                                		<i class="fa fa-plus" aria-hidden="true"></i> Add Event
                                	</button>
                                </div>								
                            </div>
						</div>
					</div>
					<div class="col-md-8">
						<div class="ibox-title">
							<h5>Billing Schedule</h5>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
		                        <thead>
			                        <tr>
			                        	<th></th>
			                            <th>Scheduled On</th>
			                            <th>Scheduled By</th>
			                            <th>Event</th>
			                            <th>Description</th>
			                            <th></th>
			                        </tr>
		                        </thead>
		                        <tbody id="mw016_table">
								</tbody>
							</table>
		                </div>
		            </div>
		        </div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw016_initialized = false;
var mw016_editable = true;
var mw016_availableEventCount = 0;
var mw016_placeWorkflowObj;
var mw016_billingCalendarObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw016_isOpen()
{
	return ($("#mw016").data('bs.modal') || {}).isShown;	
} // .end of mw016_isOpen

function mw016_init()
{
	if (mw016_initialized==true)
		return false;
	
	// on event modal window is shown.
    $('#mw016').on('shown.bs.modal', function () {
	    //$("#set001_01_06_mw001_key").focus();
	});
    
    mw016_initialized = true;
} // .end of mw016_init

function mw016_show(editable)
{
	mw016_editable = editable==null ? true : editable;
	
	mw016_updateUI();
} // .end of mw016_show

function mw016_updateUI()
{
	mw016_init();

	// If billingObj is new and yet to save.
	if (global_billingObj.state==BillingConstants.WORKFLOW_EVENTKEY_NEW)
	{
		swal('Bill Not Ready', 'Scheduled Event is unavailable.', 'warning');
		return false;
	}
	
	if (mw016_editable) {
		$('#mw016_createEvent_header').html('<h5>Create New Event</h5>');
		$('#mw016_createEvent_bodyContent').show();
	} else {
		$('#mw016_createEvent_header').html('<h5>Schedule Not Editable</h5>');
		$('#mw016_createEvent_bodyContent').hide();
	}
	
	// Current Place Object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	// Get current place workflow object
	$.each(placeObj.workflowList, function(i, workflowObj){
		if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING &&
			workflowObj.subModuleId == ModuleConstants.MODULE_BILLING_SUB_SCHEDULE)
		{
			mw016_placeWorkflowObj = workflowObj;
		}
	});
		
	// Get current billing workflow object
	if (global_billingObj.calendarList.length == 0)
	{
		var calendarObj = createNew_CommonCalendar();
		calendarObj.foreignId = global_billingObj.id;
		global_billingObj.calendarList.push( calendarObj );
	}
	mw016_billingCalendarObj = global_billingObj.calendarList[0];
	
	// LEFT PANEL
	mw016_updateUI_leftPanel();

	// RIGHT PANEL
	mw016_updateUI_rightPanel();

    // Show Modal Window on Top
    module_showModalWindow('mw016', true);
} // .end of mw016_updateUI

function mw016_updateUI_leftPanel()
{
	mw016_availableEventCount = 0;
	$('#mw016_leftPanel_eventList').empty();
	$('#mw016_leftPanel_eventList').append('<option value="0">--- SELECT ---</option>');
	if (mw016_placeWorkflowObj != null) {
		if (mw016_placeWorkflowObj.eventList != null) {
		    $.each(mw016_placeWorkflowObj.eventList, function(i, eventObj){
		    	
		    	if ( mw016_isSystemDefinedEvent(eventObj) )
			    	return true;
		    	
		    	mw016_availableEventCount++;
		    	
		    	var htmlLines = '';
		    	htmlLines += '<option value="' + eventObj.id + '">';
		    	htmlLines += eventObj.eventTitle;
		    	htmlLines += '</option>';
		    	
		    	$('#mw016_leftPanel_eventList').append( htmlLines );    	
		    });
		}
	}
	
    if (mw016_availableEventCount==0)
    {
    	$('#mw016_leftPane_addWorkflowEvent').addClass('btn-grey');
    	$('#mw016_leftPane_addWorkflowEvent').removeClass('btn-primary');
    }
    else
    {
    	$('#mw016_leftPane_addWorkflowEvent').addClass('btn-primary');
    	$('#mw016_leftPane_addWorkflowEvent').removeClass('btn-grey');
    }
    
    // Reset values
    $('#mw016_leftPanel_eventList').val('0');
    $('#mw016_leftPanel_eventList_error').hide();
    $('#mw016_leftPane_remarks').val('');
    $('#mw016_leftPane_remarks_error').hide;
} // .end of mw016_updateUI_leftPanel

function mw016_updateUI_rightPanel()
{
	// Set values
	$('#mw016_billingNo').html( global_billingObj.billingNo );
	
	// Empty Table
	$('#mw016_table').empty();
	if (mw016_billingCalendarObj == null)
		return false;
	
	// Sorting
	mw016_billingCalendarObj.eventList.sort(function(a, b){
		return a.start - b.start;
	});
	
	// Insert event row
	$.each(mw016_billingCalendarObj.eventList, function(i, eventObj){
		
		// Skip deleted event
		if (Cached_isDeletedBean(eventObj))
			return true;
		
		var rowClass = 'read';
		if (i%2==0)
			rowClass = '';
		
		var htmlLines = '';
    	htmlLines += '<tr class="' + rowClass + '">';
    	
    	// COL #1
    	var daysDiff = tycheesDateTime_getDaysInBetween(tycheesDateTime_getCurrentTimeInMillis(), eventObj.start);
    	var cell1Val = '<span class="label label-info">In ' + Math.abs(daysDiff) + ' days</span>';
    	if (daysDiff==1)
    		cell1Val = '<span class="label label-info">Tomorrow</span>';
    	if (daysDiff==0)
    		cell1Val = '<span class="label label-primary">TODAY</span>';
       	if (daysDiff==-1)
       		cell1Val = '<span class="label label-danger">Yesterday</span>';
       	if (daysDiff<-1)
       		cell1Val = '<span class="label label-danger">' + Math.abs(daysDiff) + ' days ago</span>';
    	htmlLines += '<td>';
    	htmlLines += cell1Val;
    	htmlLines += '</td>';
    	
    	// COL #2
		htmlLines += '<td class="mail-date">';
		htmlLines += tycheesDateTime_getFormattedDate_ddMMyyyy(eventObj.start) + ' ' + tycheesDateTime_getFormattedDate_hhmm(eventObj.start);
		htmlLines += '</td>';

		// COL #3
		var userObj = Cached_getUserById( eventObj.createdBy );
		var scheduledByVal = userObj==null ? 'ERR: ' + eventObj.createdBy : userObj.firstName + ' ' + userObj.lastName;
		htmlLines += '<td class="mail-date">' + scheduledByVal + '</td>';
		
		// COL #4
		htmlLines += '<td class="mail-date">' + eventObj.title + '</td>';
		
		// COL #5
		htmlLines += '<td class="mail-subject">' + eventObj.remarks + '</td>';		

		// COL #6
		htmlLines += '<td class="mail-subject" style="width:100%;">';
		htmlLines += '<span class="btn btn-danger btn-xs pull-right" onclick="mw016_deleteEvent(\'' + eventObj.id + '\');">';
		htmlLines += '<i class="fa fa-times" aria-hidden="true"></i>';
		htmlLines += '</span>';
		htmlLines += '</td>';
		
		htmlLines += '</tr>';
		
    	$('#mw016_table').append(htmlLines);
	});
} // .end of mw016_updateUI_rightPanel

function mw016_isSystemDefinedEvent(eventObj)
{
	if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_NEW) 
		return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_OPEN)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_PAYMENT)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_PAID)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_CLOSED)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_DELETED)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_RECORD_CREATED)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_RECORD_UPDATED)
    	return true;
    if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_RECORD_DELETED)
    	return true;
    
    return false;
} // .end of mw016_isSystemDefinedEvent

function mw016_addEvent()
{
	if (mw016_availableEventCount==0)
		return false;

	// Get user input
	var selectedEventId = $('#mw016_leftPanel_eventList').val();
	var dateStr = $('#mw016_leftPane_date').val();
	var timeStr = $('#mw016_leftPane_time').val();
	var remarks = $('#mw016_leftPane_remarks').val();
	
    // Reset
   	$('#mw016_leftPanel_eventList_error').hide();
	$('#mw016_leftPanel_date_error').hide();
	$('#mw016_leftPanel_time_error').hide();
   	$('#mw016_leftPane_remarks_error').hide();
    
    // Validation #1
    if (selectedEventId === '0')
    {
    	$('#mw016_leftPanel_eventList_error').show();
    	$('#mw016_leftPanel_eventList').focus();
    	return false;
    }
    // Validation #2
    if (tycheesDateTime_isValidDate_ddmmyyyy(dateStr)==false)
    {
    	$('#mw016_leftPane_date_error').show();
    	$('#mw016_leftPane_date').focus();
    	return false;
    }
    // Validation #3
    if (tycheesDateTime_isValidTime_hhmm(timeStr)==false)
    {
    	$('#mw016_leftPane_time_error').show();
    	$('#mw016_leftPane_time').focus();
    	return false;
    }
    
    
	var selectedEventObj;
	$.each(mw016_placeWorkflowObj.eventList, function(i, eventObj){
		if (eventObj.id == selectedEventId)
			selectedEventObj = eventObj;
	});
	
	var newEventObj = createNew_CommonCalendarEvent();
	newEventObj.calendarId = mw016_billingCalendarObj.id;
	newEventObj.title = selectedEventObj.eventTitle;
	newEventObj.remarks = remarks;
	newEventObj.start = tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(dateStr, timeStr);
	mw016_billingCalendarObj.eventList.push( newEventObj );
	mw016_billingCalendarObj.hasChanged = true;
	
	// Save to persistence 
	bil001_menuPanel_save();
	// Update UI
	mw016_updateUI_rightPanel();
	
	// Reset after save
	$('#mw016_leftPanel_eventList').val('0');
	$('#mw016_leftPane_date').val('');
	$('#mw016_leftPane_time').val('');
	$('#mw016_leftPane_remarks').val('');
	// Reset after save
   	$('#mw016_leftPanel_eventList_error').hide();
	$('#mw016_leftPanel_date_error').hide();
	$('#mw016_leftPanel_time_error').hide();
   	$('#mw016_leftPane_remarks_error').hide();	
} // .end of mw016_addEvent

function mw016_deleteEvent(eventId)
{
	var selectedEventObj, selectedIndex;
	$.each(mw016_billingCalendarObj.eventList, function(i, eventObj){
		if (eventObj.id == eventId) {
			selectedEventObj = eventObj;
			selectedIndex = i;
		}
	});
	
	if (selectedEventObj == null)
	{
		tycheesLogger_logError('System Error. Unable to find calendar event object.', 'mw016_deleteEvent');
		return false;
	}

	// Set delete
	Cached_deleteBean( selectedEventObj );
	// Save to persistence 
	bil001_menuPanel_save();
	// Reassign billingObj (after filter)
	global_billingObj = Cached_getBillingById( global_billingObj.id );
	// Update UI
	mw016_updateUI_rightPanel();
} // .end of mw016_deleteEvent

</script>