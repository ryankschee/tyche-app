
<!-- MODAL DIALOG: Billing Workflow -->
<div class="modal inmodal fade" id="mw014" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">BILLING WORKFLOW (<span id="mw014_billingNo"></span>)</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-3">
						<div id="mw014_createEvent_header" class="ibox-title" style="background-color:#777;color:#fff;">
							<h5>New Workflow Event</h5>
						</div>
						<div id="mw014_createEvent_body" class="ibox-content" style="background-color:#dddddd;height:250px;">
                            <div id="mw014_createEvent_bodyContent">
                            	<div class="row">
                                	<label class="col-md-4 control-label">Select Event </label>
                                    <div class="col-md-8">
                                    	<div class="input-group" style="width:100%;">
							                <select id="mw014_leftPanel_eventList" class="form-control">
							                </select>
                                    		<span id="mw014_leftPanel_eventList_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
						                </div>
                                    </div>
                                </div>
                                <div class="row">
                                	<label class="col-md-4 control-label">Remarks</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" id="mw014_leftPane_remarks">
                                    	<span id="mw014_leftPane_remarks_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
                                    </div>
                                </div>
                                <div>
                                	<button id="mw014_leftPane_addWorkflowEvent" type="button" class="btn btn-primary pull-right" onclick="mw014_addWorkflowEvent();">
                                		<i class="fa fa-plus" aria-hidden="true"></i> Add Event
                                	</button>
                                </div>								
                            </div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="ibox-title">
							<h5>Workflow History</h5>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
		                        <thead>
			                        <tr>
			                            <th>Tracked On</th>
			                            <th>Tracked By</th>
			                            <th>Title</th>
			                            <th>Description</th>
			                            <th>Actions</th>
			                        </tr>
		                        </thead>
		                        <tbody id="mw014_table">
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

var mw014_initialized = false;
var mw014_editable = true;
var mw014_availableEventCount = 0;
var mw014_placeWorkflowObj;
var mw014_billingWorkflowObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw014_isOpen()
{
	return ($("#mw014").data('bs.modal') || {}).isShown;	
} // .end of mw014_isOpen

function mw014_init()
{
	if (mw014_initialized==true)
		return false;
	
	// on event modal window is shown.
    $('#mw014').on('shown.bs.modal', function () {
	    //$("#set001_01_06_mw001_key").focus();
	});
    
    mw014_initialized = true;
} // .end of mw014_init

function mw014_show(editable)
{
	mw014_editable = editable==null ? true : editable;
	
	mw014_updateUI();
} // .end of mw016_show

function mw014_updateUI()
{
	mw014_init();

	// If billingObj is new and yet to save.
	if (global_billingObj.state==BillingConstants.WORKFLOW_EVENTKEY_NEW)
	{
		swal('Bill Not Ready', 'Status is unavailable.', 'warning');
		return false;
	}
	
	if (mw014_editable) {
		$('#mw014_createEvent_header').html('<h5>Create New Event</h5>');
		$('#mw014_createEvent_bodyContent').show();
	} else {
		$('#mw014_createEvent_header').html('<h5>Workflow Not Editable</h5>');
		$('#mw014_createEvent_bodyContent').hide();
	}
	
	// Current Place Object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	// Get current place workflow object
	$.each(placeObj.workflowList, function(i, workflowObj){
		if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING &&
			workflowObj.subModuleId == ModuleConstants.MODULE_BILLING_SUB_WORKFLOW)
		{
			mw014_placeWorkflowObj = workflowObj;
			if (mw014_placeWorkflowObj.eventList == null)
				mw014_placeWorkflowObj.eventList = [];
		}
	});
	// Get current billing workflow object
	$.each(global_billingObj.workflowList, function(i, workflowObj){
		if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING) {
			mw014_billingWorkflowObj = workflowObj;		
			if (mw014_billingWorkflowObj.eventList == null)
				mw014_billingWorkflowObj.eventList = [];
		}
	});
	
	// LEFT PANEL
	mw014_updateUI_leftPanel();

	// RIGHT PANEL
	mw014_updateUI_rightPanel();

    // Show Modal Window on Top
    module_showModalWindow('mw014', true);
} // .end of mw014_updateUI

function mw014_updateUI_leftPanel()
{
	mw014_availableEventCount = 0;
	$('#mw014_leftPanel_eventList').empty();
	$('#mw014_leftPanel_eventList').append('<option value="0"> --- </option>');
	if (mw014_placeWorkflowObj != null && mw014_placeWorkflowObj.eventList != null) {
	    $.each(mw014_placeWorkflowObj.eventList, function(i, eventObj){
	    	
	    	if ( mw014_isSystemDefinedEvent(eventObj) )
		    	return true;
	    	
	    	mw014_availableEventCount++;
	    	
	    	var htmlLines = '';
	    	htmlLines += '<option value="' + eventObj.id + '">';
	    	htmlLines += eventObj.eventTitle;
	    	htmlLines += '</option>';
	    	
	    	$('#mw014_leftPanel_eventList').append( htmlLines );    	
	    });
	}
    
    if (mw014_availableEventCount==0)
    {
    	$('#mw014_leftPane_addWorkflowEvent').addClass('btn-grey');
    	$('#mw014_leftPane_addWorkflowEvent').removeClass('btn-primary');
    }
    else
    {
    	$('#mw014_leftPane_addWorkflowEvent').addClass('btn-primary');
    	$('#mw014_leftPane_addWorkflowEvent').removeClass('btn-grey');
    }
    
    // Reset values
    $('#mw014_leftPanel_eventList').val('0');
    $('#mw014_leftPanel_eventList_error').hide();
    $('#mw014_leftPane_remarks').val('');
    $('#mw014_leftPane_remarks_error').hide;
} // .end of mw014_updateUI_leftPanel

function mw014_updateUI_rightPanel()
{
	// Set values
	$('#mw014_billingNo').html( global_billingObj.billingNo );

	// Empty table
	$('#mw014_table').empty();
	if (mw014_billingWorkflowObj == null)
		return false;
	
	// Insert table row
	if (mw014_placeWorkflowObj != null && mw014_placeWorkflowObj.eventList != null) {
		$.each(mw014_billingWorkflowObj.eventList, function(i, eventObj){
			
			var htmlLines = '';
	    	htmlLines += '<tr class="read">';
	    	
	    	// COL #1
			htmlLines += '<td class="mail-date">';
			htmlLines += tycheesDateTime_getFormattedDate_ddMMyyyy(eventObj.trackedOn) + ' ' + tycheesDateTime_getFormattedDate_hhmm(eventObj.trackedOn);
			htmlLines += '</td>';
	
			// COL #2
			var userObj = Cached_getUserById( eventObj.trackedBy );
			var trackedByVal = userObj==null ? 'ERR: ' + eventObj.trackedBy : userObj.firstName + ' ' + userObj.lastName;
			htmlLines += '<td class="mail-date">' + trackedByVal + '</td>';
			
			// COL #3
			htmlLines += '<td class="mail-date">' + eventObj.eventTitle + '</td>';
			
			// COL #4
			htmlLines += '<td class="mail-subject">' + eventObj.eventDescription + '</td>';		
	
			// COL #5
			htmlLines += '<td class="mail-subject pull-right" style="width:100%;">';
			
			if ( mw014_isSystemDefinedEvent(eventObj)==false )
			{
				htmlLines += '<span class="btn btn-danger btn-xs" onclick="mw014_deleteWorkflowEvent(\'' + eventObj.id + '\');">';
				htmlLines += '<i class="fa fa-times" aria-hidden="true"></i>';
				htmlLines += '</span>';
			}
			
			htmlLines += '</td>';
			htmlLines += '</tr>';
			
	    	$('#mw014_table').append(htmlLines);
		});
	}
} // .end of mw014_updateUI_rightPanel

function mw014_isSystemDefinedEvent(eventObj)
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
} // .end of mw014_isSystemDefinedEvent

function mw014_addWorkflowEvent()
{
	if (mw014_availableEventCount==0)
		return false;

	// Get user input
	var selectedEventId = $('#mw014_leftPanel_eventList').val();
	var remarks = $('#mw014_leftPane_remarks').val();
	
    // Reset
   	$('#mw014_leftPanel_eventList_error').hide();
   	$('#mw014_leftPane_remarks_error').hide();
    
    // Validation #1
    if (selectedEventId === '0')
    {
    	$('#mw014_leftPanel_eventList_error').show();
    	$('#mw014_leftPanel_eventList').focus();
    	return false;
    }
    
	var selectedEventObj;
	$.each(mw014_placeWorkflowObj.eventList, function(i, eventObj){
		if (eventObj.id == selectedEventId)
			selectedEventObj = eventObj;
	});
	
	var newEventObj = createNew_BillingWorkflowEvent();
	newEventObj.workflowId = mw014_billingWorkflowObj.id;
	newEventObj.seqno = mw014_billingWorkflowObj.eventList.length + 1;
	newEventObj.eventKey = selectedEventObj.eventKey;
	newEventObj.eventTitle = selectedEventObj.eventTitle;
	newEventObj.eventDescription = remarks;
	newEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
	newEventObj.trackedBy = tycheesCommon_getCurrentUserId();
	mw014_billingWorkflowObj.eventList.push( newEventObj );
	mw014_billingWorkflowObj.hasChanged = true;
	
	// Update billing state
	global_billingObj.state = newEventObj.eventKey;
	global_billingObj.stateDesc = newEventObj.eventTitle;
	
	// Save to persistence 
	bil001_menuPanel_save();
	// Update UI
	mw014_updateUI_rightPanel();
} // .end of mw014_addWorkflowEvent

function mw014_deleteWorkflowEvent(eventId)
{
	var selectedEventObj, selectedIndex;
	$.each(mw014_billingWorkflowObj.eventList, function(i, eventObj){
		if (eventObj.id == eventId) 
		{
			selectedEventObj = eventObj;
			selectedIndex = i;
		}
	});
	
	// Check if selectedEventObj is last in event list
	if (selectedIndex == mw014_billingWorkflowObj.eventList.length-1)
	{
		// Update billing state
		global_billingObj.state = mw014_billingWorkflowObj.eventList[selectedIndex-1].eventKey;
		global_billingObj.stateDesc = mw014_billingWorkflowObj.eventList[selectedIndex-1].eventDescription;		
	}
	
	if (selectedEventObj == null)
	{
		tycheesLogger_logError('System Error. Unable to find workflow event object.', 'mw014_addWorkflowEvent');
		return false;
	}

	// Re-Order
	$.each(mw014_billingWorkflowObj.eventList, function(i, eventObj){
		if (eventObj.seqno > selectedEventObj.seqno)
			eventObj.seqno = eventObj.seqno - 1;
	});

	// Set delete
	Cached_deleteBean( selectedEventObj );
	// Save to persistence 
	bil001_menuPanel_save();
	// Reassign billingObj (after filter)
	global_billingObj = Cached_getBillingById( global_billingObj.id );
	// Update UI
	mw014_updateUI_rightPanel();
} // .end of mw014_deleteWorkflowEvent

</script>