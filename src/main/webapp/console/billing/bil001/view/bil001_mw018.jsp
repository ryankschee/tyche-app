<!-- Modal Window: Edit Billing No -->
<div class="modal inmodal fade" id="mw018" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-md1">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">QUOTATION OPTIONS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw018_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-8 control-label" style="text-align:left;">Convert Quotation to Billing:</label>
	                                    <div class="col-sm-4" style="text-align:right;">
		    								<button type="button" class="btn btn-primary" onclick="mw018_convert();">Convert Now</button>
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
		    </div>
	    </div>
    </div>
</div>

<script>

var mw018_initialized = false;
var mw018_validInput = false;
var mw018_callbackFn;

function mw018_isOpen()
{
	return ($("#mw018").data('bs.modal') || {}).isShown;	
} // .end of mw018_isOpen

function mw018_init()
{
    if (mw018_initialized == true)
        return false;
    
    $('#mw018').on('shown.bs.modal', function () {
	    $("#mw018_newQuotationNo").focus();
	});
    
	mw018_initialized = true;
} // .end of mw018_init

function mw018_updateUI()
{
    mw018_init();
    
    // Show Modal Window on Top
    module_showModalWindow('mw018', false);
} // .end of mw018_updateUI

function mw018_show(callbackFn)
{
	mw018_callbackFn = callbackFn;
	
    mw018_updateUI();
} // .end of mw018_show

function mw018_convert()
{
	// Set new billing number	
	global_billingObj.billingNo = consoleCommon_getNextBillingNo();
	
	// Set new workflow event
	var billingWorkflowObj;
	$.each(global_billingObj.workflowList, function(i, workflowObj) {
		if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
			billingWorkflowObj = workflowObj;
	});

	if (billingWorkflowObj == null) {
		billingWorkflowObj = createNew_BillingWorkflow();
		billingWorkflowObj.billingId = billingObj.id;
		billingWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
		billingWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
		global_billingObj.workflowList.push(billingWorkflowObj);
	} else {
		billingWorkflowObj.hasChanged = true;
	}
	
	// Create new workflow event (deleted)
	var workflowEventObj = createNew_BillingWorkflowEvent();
	workflowEventObj.workflowId = billingWorkflowObj.id;
	workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
	workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
	workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
	workflowEventObj.eventDescription = 'BILLING OPENED.';
	workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
	workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
	billingWorkflowObj.eventList.push( workflowEventObj );
	
	// Set billing state
	global_billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
	global_billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
	
	// Update next billing number
	consoleCommon_updateNextBillingNo();

    // Update IDB
    tycheesIO_saveBean( global_billingObj );
    // Close Modal Window
    $('#mw018').modal('hide');
    // Callback
    mw018_callbackFn();
} // .end of mw018_convert

</script>