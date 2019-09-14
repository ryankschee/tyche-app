<!-- Modal Window: Edit Workflow Event -->
<div class="modal inmodal fade" id="set001_01_07_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT SCHEDULED EVENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_01_07_mw002_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">After Event</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="set001_01_07_mw002_eventList"  class="form-control">
								                </select>
							                </div>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">* Event Title</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_07_mw002_title">
	                                    	<span id="set001_01_07_mw002_title_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
	                                    	<span id="set001_01_07_mw002_title_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Duplication found</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Event Description</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_07_mw002_description">
	                                    	<span id="set001_01_07_mw002_description_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_01_07_mw002_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_07_mw002_initialized = false;
var set001_01_07_mw002_workflowId;
var set001_01_07_mw002_eventId;
var set001_01_07_mw002_workflowObj;
var set001_01_07_mw002_eventObj;

/**
 * Init Panel
 */
function set001_01_07_mw002_init()
{
    if (set001_01_07_mw002_initialized == true)
        return false;
    
    $('#set001_01_07_mw002').on('shown.bs.modal', function () {
	    $("#set001_01_07_mw002_key").focus();
	});
    
	set001_01_07_mw002_initialized = true;
} // .end of set001_01_07_mw002_init

/**
 * Show Panel
 */
function set001_01_07_mw002_updateUI()
{
    set001_01_07_mw002_init();
    
    $('#set001_01_07_mw002_eventList').empty();    
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();   

	$.each(placeObj.workflowList, function(i, workflowObj){    	
		if (workflowObj.id == set001_01_07_mw002_workflowId)
    		set001_01_07_mw002_workflowObj = workflowObj;		
    });
    
    $.each(set001_01_07_mw002_workflowObj.eventList, function(i, eventObj){    	
		if (eventObj.id == set001_01_07_mw002_eventId)
    		set001_01_07_mw002_eventObj = eventObj;		
    });

    // Sorting by seqno
    set001_01_07_mw002_workflowObj.eventList.sort(function(a, b) {
		return a.seqno - b.seqno;
	});
    
    var previousEventKey;
    $.each(set001_01_07_mw002_workflowObj.eventList, function(i, eventObj){
    	
        var addEventIntoSelection = true;

    	if (eventObj.seqno+1 == set001_01_07_mw002_eventObj.seqno)
    	{
    		previousEventKey = eventObj.eventKey;
    	}
    	
    	if (eventObj.id==set001_01_07_mw002_eventId)
    	{
    		addEventIntoSelection = false;
    	}
    	
    	if (addEventIntoSelection)
    	{
    		var selectedVal = '';
    		if (i == set001_01_07_mw002_eventObj.seqno-2)
    			selectedVal = 'selected';
    		
	    	var htmlLines = '';
	    	htmlLines += '<option value="' + eventObj.eventKey + '" ' + selectedVal + '>';
	    	htmlLines += eventObj.seqno + ' - ' + eventObj.eventTitle;
	    	htmlLines += '</option>';
	    	
	    	$('#set001_01_07_mw002_eventList').append( htmlLines );
    	}
    });
    
    // Reset inputs
    $('#set001_01_07_mw002_eventList').val( previousEventKey );
    $('#set001_01_07_mw002_title').val( set001_01_07_mw002_eventObj.eventTitle );
    $('#set001_01_07_mw002_description').val( set001_01_07_mw002_eventObj.eventDescription );
    $('#set001_01_07_mw002_title_error').hide();
    $('#set001_01_07_mw002_title_error_duplication').hide();
    $('#set001_01_07_mw002_description_error').hide();
    
    // Show Modal Window
    $('#set001_01_07_mw002').modal({backdrop: 'static', keyboard: false});
} // .end of set001_01_07_mw002_updateUI

/**
 * Show Panel
 */
function set001_01_07_mw002_show(workflowId, eventId)
{
	set001_01_07_mw002_workflowId = workflowId;
	set001_01_07_mw002_eventId = eventId;
    set001_01_07_mw002_updateUI();
} // .end of set001_01_07_mw002_show

/**
 * Save changes and hide panel.
 */
function set001_01_07_mw002_save()
{
	var afterEventKey = $('#set001_01_07_mw002_eventList').val();
    var eventTitle = $('#set001_01_07_mw002_title').val();
    var eventDescription = $('#set001_01_07_mw002_description').val();
    var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Reset
   	$('#set001_01_07_mw002_title_error').hide();
	$('#set001_01_07_mw002_title_error_duplication').hide();
   	$('#set001_01_07_mw002_description_error').hide();

    // Validation #1
    if ($.trim(eventTitle) === '')
    {
    	$('#set001_01_07_mw002_title_error').show();
    	$('#set001_01_07_mw002_title').focus();
    	return false;
    }

    // Validation #2
    var duplicationFound = false;
    var newEventKey = 'eventKey_' + tycheesText_getSafeString_withoutSpace(eventTitle);
    $.each(set001_01_07_mw002_workflowObj.eventList, function(i, eventObj){
    	if ( eventObj.id == set001_01_07_mw002_eventId )
    		return true;
    	
    	if ( $.trim(eventObj.eventKey) == $.trim(newEventKey) )
    		duplicationFound = true;
    });
    if (duplicationFound)
    {
    	$('#set001_01_07_mw002_title_error_duplication').show();
    	$('#set001_01_07_mw002_title').focus();
    	return false;    	
    }
    
    // Get user selected event
    var afterEventObj;
    $.each(set001_01_07_mw002_workflowObj.eventList, function(i, eventObj){
    	if (eventObj.eventKey==afterEventKey)
    		afterEventObj = eventObj;
    });
    // Re-order seqno    
    var eventSeqno = 1;
    if (afterEventObj != null && 
    	afterEventObj.seqno+1 == set001_01_07_mw002_eventObj.seqno)
    {
    	// no change on ordering
    	eventSeqno = afterEventObj.seqno + 1;
    }
    else
    if (afterEventObj != null && 
    	afterEventObj.seqno+1 > set001_01_07_mw002_eventObj.seqno) 
    {
    	eventSeqno = afterEvent.seqno;
    	$.each(set001_01_07_mw002_workflowObj.eventList, function(i, eventObj){
    		if (set001_01_07_mw002_eventObj.seqno == eventObj.seqno) {
    			return true;
    		}
    		if (set001_01_07_mw002_eventObj.seqno > eventObj.seqno) {
    			return true;
    		}
    		if (set001_01_07_mw002_eventObj.seqno < eventObj.seqno) {
    			if (eventObj.seqno <= afterEventObj.seqno)
    				eventObj.seqno = eventObj.seqno - 1;    				
    		}
   		}); 
    }
    else
    if (afterEventObj != null && 
    	afterEventObj.seqno+1 < set001_01_07_mw002_eventObj.seqno) 
    {
    	eventSeqno = afterEventObj.seqno + 1;
    	$.each(set001_01_07_mw002_workflowObj.eventList, function(i, eventObj){
    		if (set001_01_07_mw002_eventObj.seqno == eventObj.seqno) {
    			return true;
    		}
    		if (set001_01_07_mw002_eventObj.seqno < eventObj.seqno) {
    			return true;
    		}
    		if (set001_01_07_mw002_eventObj.seqno > eventObj.seqno) {
    			if (eventObj.seqno > afterEventObj.seqno)
    				eventObj.seqno = eventObj.seqno + 1;    				
    		}
   		}); 
    }
    	
    // Edit existing workflow object
    set001_01_07_mw002_eventObj.seqno = eventSeqno;
    set001_01_07_mw002_eventObj.eventKey = 'eventKey_' + tycheesText_getSafeString_withoutSpace(eventTitle);
    set001_01_07_mw002_eventObj.eventTitle = eventTitle;	
    set001_01_07_mw002_eventObj.eventDescription = eventDescription;	
	
    // Set Flag
    set001_01_07_mw002_workflowObj.hasChanged = true;
 	// Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Update Customer UI
    set001_01_07_updateUI();
    
    // Close Modal Window
    $('#set001_01_07_mw002').modal('hide');
} // .end of set001_01_07_mw002_save

</script>