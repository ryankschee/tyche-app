<!-- Modal Window: Add Scheduled Event -->
<div class="modal inmodal fade" id="set001_01_07_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW SCHEDULED EVENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_01_07_mw001_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">After Event</label>
	                                    <div class="col-sm-8">
	                                    	<div class="input-group" style="width:100%;">
								                <select id="set001_01_07_mw001_eventList"  class="form-control">
								                </select>
							                </div>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">* Event Title</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_07_mw001_title">
	                                    	<span id="set001_01_07_mw001_title_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
	                                    	<span id="set001_01_07_mw001_title_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Duplication found</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Event Description</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_07_mw001_description">
	                                    	<span id="set001_01_07_mw001_description_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_01_07_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_07_mw001_initialized = false;

/**
 * Init Panel
 */
function set001_01_07_mw001_init()
{
    if (set001_01_07_mw001_initialized == true)
        return false;
    
    $('#set001_01_07_mw001').on('shown.bs.modal', function () {
	    $("#set001_01_07_mw001_key").focus();
	});
    
	set001_01_07_mw001_initialized = true;
} // .end of set001_01_07_mw001_init

/**
 * Show Panel
 */
function set001_01_07_mw001_updateUI()
{
    set001_01_07_mw001_init();
    
    var billingWorkflowObj;
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.workflowList, function(i, workflowObj){
    	
    	if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING && 
    	    workflowObj.subModuleId == ModuleConstants.MODULE_BILLING_SUB_SCHEDULE)
    		billingWorkflowObj = workflowObj;
    });
    
    // Sorting by seqno
    billingWorkflowObj.eventList.sort(function(a, b) {
		return a.seqno - b.seqno;
	});
    
    $('#set001_01_07_mw001_eventList').empty();
    $.each(billingWorkflowObj.eventList, function(i, eventObj){
    	
    	var selectedVal = '';
    	if (i==0)
    		selectedVal = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + eventObj.eventKey + '" ' + selectedVal + '>';
    	htmlLines += eventObj.seqno + ' - ' + eventObj.eventTitle;
    	htmlLines += '</option>';
    	
    	$('#set001_01_07_mw001_eventList').append( htmlLines );    	
    });

    // Reset inputs
    ///$('#set001_01_07_mw001_eventList').val( BillingConstants.WORKFLOW_EVENTKEY_NEW );
    $('#set001_01_07_mw001_title').val('');
    $('#set001_01_07_mw001_description').val('');
    $('#set001_01_07_mw001_title_error').hide();
    $('#set001_01_07_mw001_title_error_duplication').hide();
    $('#set001_01_07_mw001_description_error').hide();
    
    // Show Modal Window
    $('#set001_01_07_mw001').modal({backdrop: 'static', keyboard: false});
} // .end of set001_01_07_mw001_updateUI

/**
 * Show Panel
 */
function set001_01_07_mw001_show()
{
    set001_01_07_mw001_updateUI();
} // .end of set001_01_07_mw001_show

/**
 * Save changes and hide panel.
 */
function set001_01_07_mw001_save()
{
	var afterEventKey = $('#set001_01_07_mw001_eventList').val();
    var eventTitle = $('#set001_01_07_mw001_title').val();
    var eventDescription = $('#set001_01_07_mw001_description').val();
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    // Reset
   	$('#set001_01_07_mw001_title_error').hide();
	$('#set001_01_07_mw001_title_error_duplication').hide();
   	$('#set001_01_07_mw001_description_error').hide();
    
    // Validation #1
    if ($.trim(eventTitle) === '')
    {
    	$('#set001_01_07_mw001_title_error').show();
    	$('#set001_01_07_mw001_title').focus();
    	return false;
    }

    // Validation #2
    var duplicationFound = false;
    var newEventKey = 'eventKey_' + tycheesText_getSafeString_withoutSpace(eventTitle);
    $.each(placeObj.workflowList, function(i, workflowObj){
    	if ( $.trim(workflowObj.eventKey) == $.trim(newEventKey) )
    		duplicationFound = true;
    });
    if (duplicationFound)
    {
    	$('#set001_01_07_mw001_title_error_duplication').show();
    	$('#set001_01_07_mw001_title').focus();
    	return false;    	
    }
    
    // Get user selected event
    var afterEventObj, billingWorkflowObj;
    $.each(placeObj.workflowList, function(i, workflowObj){
    	if (workflowObj.moduleId==ModuleConstants.MODULE_BILLING && 
    	    workflowObj.subModuleId == ModuleConstants.MODULE_BILLING_SUB_SCHEDULE)
    		billingWorkflowObj = workflowObj;
    });
    $.each(billingWorkflowObj.eventList, function(i, eventObj){
    	if (eventObj.eventKey == afterEventKey)	
    		afterEventObj = eventObj;
    });
    
    // Re-order seqno
    $.each(billingWorkflowObj.eventList, function(i, eventObj){
    	if (eventObj.seqno > afterEventObj.seqno)
    		eventObj.seqno = eventObj.seqno + 1;
    });
        
    // Create new workflow object
    var newEventObj = createNew_PlaceWorkflowEvent();
    newEventObj.workflowId = billingWorkflowObj.id;
    newEventObj.seqno = afterEventObj==null ? 1 : afterEventObj.seqno + 1;
    newEventObj.eventKey = 'eventKey_' + tycheesText_getSafeString_withoutSpace(eventTitle);
    newEventObj.eventTitle = eventTitle;	
    newEventObj.eventDescription = eventDescription;	
	// Insert into current place object
    billingWorkflowObj.eventList.push( newEventObj );
    billingWorkflowObj.hasChanged = true;
    
 	// Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Update Customer UI
    set001_01_07_updateUI();
    
    // Close Modal Window
    $('#set001_01_07_mw001').modal('hide');
} // .end of set001_01_07_mw001_save

</script>