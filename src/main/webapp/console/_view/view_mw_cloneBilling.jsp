
<!-- 
    Title:			CLONE BILLING
    Desc:			- Clone current billing (exclude payment, workflow, calendar)
    Author:			Ryan Chee
    Last Modified:	20170810
-->

<div class="modal inmodal fade" id="mw_cloneBilling" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">CLONE BILLING</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw_cloneBilling_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Clone from Billing</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_cloneBilling_currentBillingNo" disabled>
	                                    	<span id="mw_cloneBilling_currentBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_cloneBilling_newBillingNo">
	                                    	<span id="mw_cloneBilling_newBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw_cloneBilling_newBillingNo_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button id="mw017_closeButton" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button id="mw_cloneBilling_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_cloneBilling_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw_cloneBilling_initialized = false;
var mw_cloneBilling_validInput = false;

function mw_cloneBilling_isOpen()
{
	return ($("#mw_cloneBilling").data('bs.modal') || {}).isShown;	
} // .end of mw_cloneBilling_isOpen

function mw_cloneBilling_init()
{
    if (mw_cloneBilling_initialized == true)
        return false;
    
    $('#mw_cloneBilling').on('shown.bs.modal', function () {
	    $("#mw_cloneBilling_newBillingNo").focus();
	});
    
	mw_cloneBilling_initialized = true;
} // .end of mw_cloneBilling_init

function mw_cloneBilling_show()
{
	// Show Progress
	tycheesOverlay_startShortProgress('Creating new order...');
	// Check billing number
	mw_cloneBilling_validateBillingNo();
} // .end of mw_cloneBilling_show

function mw_cloneBilling_validateBillingNo() {
	// Get next billing number
	var billingNo = consoleCommon_getNextBillingNo();
	// Show Progress
	tycheesOverlay_startShortProgress('Checking billing no...' + billingNo);
	// Check if any duplicated order found.
	var requestBody = {
			'appName': APP_NAME_POS,
			'billingNo': billingNo,
			'fullBean': false	
		};	

	var params = new Object();
	params.billingNo = billingNo;
	
	tycheesdb_api_getBillingByBillingNo(requestBody, mw_cloneBilling_validateBillingNo_postHandler, params);
} // .end of mw_cloneBilling_validateBillingNo

function mw_cloneBilling_validateBillingNo_postHandler(success, responseObj, params) {
	if (!success)
		return false;
	
	// No duplication found
	if (responseObj.billingObj == null) {
		// Hide Progress
		tycheesOverlay_stopShortProgress();
		// Create billing object
		mw_cloneBilling_updateUI(params.billingNo);
	} else {
		// Get next billing number
		consoleCommon_updateNextBillingNo();
		// Repeat check
		mw_cloneBilling_validateBillingNo();
	}
} // .end of mw_cloneBilling_validateBillingNo_postHandler

function mw_cloneBilling_updateUI(billingNo)
{
    mw_cloneBilling_init();
    
    // Setup inputs
    $('#mw_cloneBilling_currentBillingNo').val( global_billingObj.billingNo );
    $('#mw_cloneBilling_newBillingNo').val( billingNo );
    $('#mw_cloneBilling_currentBillingNo_error').hide();
    $('#mw_cloneBilling_newBillingNo_error_duplication').hide();
    $('#mw_cloneBilling_newBillingNo_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw_cloneBilling', true);
} // .end of mw_cloneBilling_updateUI

function mw_cloneBilling_save()
{
	// Get next billing number
	var currentBillingNo = $.trim( $('#mw_cloneBilling_currentBillingNo').val() );
	var newBillingNo = $.trim( $('#mw_cloneBilling_newBillingNo').val() );
	if (newBillingNo == '')
		return false;
	if (currentBillingNo == newBillingNo) {
		swal({
			type: 'warning',
		    title: 'Duplicated billing number found',
			text: 'Please use another billing no.'
		});
		return false;
	}
	
	$('#mw_cloneBilling_saveButton').ladda().ladda('start');
	
	// Check if any duplicated order found.
	var requestBody = {
		'appName': APP_NAME_POS,
		'billingNo': newBillingNo,
		'fullBean': false	
	};	

	var params = new Object();
	params.billingNo = newBillingNo;
	
	tycheesdb_api_getBillingByBillingNo(requestBody, mw_cloneBilling_save_postHander, params);
} // .end of mw_cloneBilling_save

function mw_cloneBilling_save_postHander(success, responseObj, params)
{
	$('#mw_cloneBilling_saveButton').ladda().ladda('stop');
	
	if (!success) {
		return false;
	}
	
	// Duplication found
	if (responseObj.billingObj != null) {
		swal({
			type: 'warning',
		    title: 'Duplicated billing number found',
			text: 'Please use another billing no.'
		});
		return false;
	}
	
	// reset
    $('#mw_cloneBilling_currentBillingNo_error').hide();
    $('#mw_cloneBilling_newBillingNo_error_duplication').hide();
    $('#mw_cloneBilling_newBillingNo_error').hide();
    
    // Get user input
    var newBillingNo = params.billingNo;

    // Validation #1: if empty value
    if ( $.trim(newBillingNo) === '')
    {
    	$('#mw_cloneBilling_newBillingNo_error').show();
    	$('#mw_cloneBilling_newBillingNo').focus();
    	return false;
    }
        
 	// Clone new object
 	var newBillingObj = tycheesCommon_cloneObject(global_billingObj);
 	newBillingObj.billingNo = newBillingNo;
 	newBillingObj.id = tycheesCommon_getUniqueId();
 	newBillingObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 	newBillingObj.createdBy = tycheesCommon_getCurrentUserId();
 	newBillingObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 	newBillingObj.updatedBy = tycheesCommon_getCurrentUserId();
 	newBillingObj.state = BillingConstants.WORKFLOW_EVENTKEY_NEW;
 	newBillingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_NEW;
 	newBillingObj.invoiceNo = '';
 	newBillingObj.invoiceDate = null;
 	newBillingObj.purchaseOrderNo = '';
 	newBillingObj.purchaseOrderDate = null;
 	newBillingObj.receiptNo = '';
 	newBillingObj.receiptDate = null;
 	newBillingObj.quotationNo = '';
 	newBillingObj.quotationDate = null;
 	newBillingObj.paymentTerms = '';
 	newBillingObj.totalPayment = 0;
 	

 	$.each(newBillingObj.deliveryList, function(i, deliveryObj) {
 		deliveryObj.id = tycheesCommon_getUniqueId();
 		deliveryObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 		deliveryObj.createdBy = tycheesCommon_getCurrentUserId();
 		deliveryObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 		deliveryObj.updatedBy = tycheesCommon_getCurrentUserId();
 		deliveryObj.billingId = newBillingObj.id;
 		deliveryObj.hasChanged = true;
 	});

 	$.each(newBillingObj.lineList, function(i, lineObj) {
 		lineObj.id = tycheesCommon_getUniqueId();
 		lineObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 		lineObj.createdBy = tycheesCommon_getCurrentUserId();
 		lineObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 		lineObj.updatedBy = tycheesCommon_getCurrentUserId();
 		lineObj.billingId = newBillingObj.id;
 		lineObj.hasChanged = true;
 		
 		$.each(lineObj.lineList, function(i, childLineObj) {
 			childLineObj.id = tycheesCommon_getUniqueId();
 			childLineObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 			childLineObj.createdBy = tycheesCommon_getCurrentUserId();
 			childLineObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 			childLineObj.updatedBy = tycheesCommon_getCurrentUserId();
 			childLineObj.billingId = newBillingObj.id;
 			childLineObj.parentLineId = lineObj.id;
 	 	});
 		
 		$.each(lineObj.mandatoryList, function(i, childLineObj) {
 			childLineObj.id = tycheesCommon_getUniqueId();
 			childLineObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 			childLineObj.createdBy = tycheesCommon_getCurrentUserId();
 			childLineObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 			childLineObj.updatedBy = tycheesCommon_getCurrentUserId();
 			childLineObj.billingId = newBillingObj.id;
 			childLineObj.parentLineId = lineObj.id;
 	 	});
 	});

 	$.each(newBillingObj.calendarList, function(i, calendarObj) {
 		calendarObj.id = tycheesCommon_getUniqueId();
 		calendarObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 		calendarObj.createdBy = tycheesCommon_getCurrentUserId();
 		calendarObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 		calendarObj.updatedBy = tycheesCommon_getCurrentUserId();
 		calendarObj.billingId = newBillingObj.id;
 		calendarObj.hasChanged = true;
 	});

 	$.each(newBillingObj.propertiesList, function(i, propertiesObj) {
 		propertiesObj.id = tycheesCommon_getUniqueId();
 		propertiesObj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
 		propertiesObj.createdBy = tycheesCommon_getCurrentUserId();
 		propertiesObj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
 		propertiesObj.updatedBy = tycheesCommon_getCurrentUserId();
 		propertiesObj.billingId = newBillingObj.id;
 		propertiesObj.hasChanged = true;
 	});
        	
 	newBillingObj.workflowList = [];
 	
 	var newWorkflowObj = createNew_BillingWorkflow();
 	newWorkflowObj.billingId = newBillingObj.id;
 	newWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
	newWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
	newBillingObj.workflowList.push(newWorkflowObj);
	
	var newWorkflowEventObj = createNew_BillingWorkflowEvent();
	newWorkflowEventObj.workflowId = newWorkflowObj.id;
	newWorkflowEventObj.seqno = 1;
	newWorkflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_NEW;
	newWorkflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_NEW;
	newWorkflowEventObj.eventDescription = 'BILLING BEGIN';
	newWorkflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
	newWorkflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
	newWorkflowObj.eventList.push(newWorkflowEventObj);
 	
 	newBillingObj.paymentList = [];
 	newBillingObj.calendarList = [];
 	
 	// Asssign as current object
 	global_billingObj = newBillingObj; 	
    // Auto-save Billing
	bil001_menuPanel_save();		
	// Update page UI
	bil001_show();
    // Close Modal Window
    $('#mw_cloneBilling').modal('hide');
} // .end of mw_cloneBilling_save_postHander

</script>