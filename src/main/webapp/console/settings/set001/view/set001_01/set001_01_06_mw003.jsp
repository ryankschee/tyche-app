<!-- Modal Window: Edit Workflow Event -->
<div class="modal inmodal fade" id="set001_01_06_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">DELETE WORKFLOW EVENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_01_06_mw003_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">* Event Title</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_06_mw003_title" disabled>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Event Description</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_06_mw003_description" disabled>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_01_06_mw003_delete();">Delete</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_06_mw003_initialized = false;
var set001_01_06_mw003_workflowId;
var set001_01_06_mw003_eventId;
var set001_01_06_mw003_workflowObj;
var set001_01_06_mw003_eventObj;

/**
 * Init Panel
 */
function set001_01_06_mw003_init()
{
    if (set001_01_06_mw003_initialized == true)
        return false;
    
    $('#set001_01_06_mw003').on('shown.bs.modal', function () {
	    //$("#set001_01_06_mw003_key").focus();
	});
    
	set001_01_06_mw003_initialized = true;
} // .end of set001_01_06_mw003_init

/**
 * Show Panel
 */
function set001_01_06_mw003_updateUI()
{
    set001_01_06_mw003_init();
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();   
	$.each(placeObj.workflowList, function(i, workflowObj){    	
		if (workflowObj.id == set001_01_06_mw003_workflowId)
    		set001_01_06_mw003_workflowObj = workflowObj;		
    });
    $.each(set001_01_06_mw003_workflowObj.eventList, function(i, eventObj){    	
		if (eventObj.id == set001_01_06_mw003_eventId)
    		set001_01_06_mw003_eventObj = eventObj;		
    });

    // Reset inputs
    $('#set001_01_06_mw003_title').val( set001_01_06_mw003_eventObj.eventTitle );
    $('#set001_01_06_mw003_description').val( set001_01_06_mw003_eventObj.eventDescription );
    
    // Show Modal Window
    $('#set001_01_06_mw003').modal({backdrop: 'static', keyboard: false});
} // .end of set001_01_06_mw003_updateUI

/**
 * Show Panel
 */
function set001_01_06_mw003_show(workflowId, eventId)
{
	set001_01_06_mw003_workflowId = workflowId;
	set001_01_06_mw003_eventId = eventId;
    set001_01_06_mw003_updateUI();
} // .end of set001_01_06_mw003_show

/**
 * Delete workflow event and hide panel.
 */
function set001_01_06_mw003_delete()
{
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    // Re-order seqno    
    $.each(set001_01_06_mw003_workflowObj.eventList, function(i, eventObj){
        if (eventObj.id == set001_01_06_mw003_eventId)
            return true;
        
        if (eventObj.seqno > set001_01_06_mw003_eventObj.seqno)
            eventObj.seqno = eventObj.seqno - 1;
    });
    	
    // Delete workflow object
    Cached_deleteBean( set001_01_06_mw003_eventObj );
    // Set Flag
    set001_01_06_mw003_workflowObj.hasChanged = true;
 	// Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Update Customer UI
    set001_01_06_updateUI();
    
    // Close Modal Window
    $('#set001_01_06_mw003').modal('hide');
} // .end of set001_01_06_mw003_delete

</script>