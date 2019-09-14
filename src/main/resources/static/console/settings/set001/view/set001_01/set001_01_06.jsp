<!-- SET001_01_06: Billing Settings - Workflow -->
<div id="set001_01_06" style="display:none; padding-top:10px;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	BILLING WORKFLOW 
	</span>
   	<span class="pull-right btn btn-success btn-xs" onclick="set001_01_06_mw001_show();">
		<i class="fa fa-plus" aria-hidden="true"></i> Add Workflow Event
	</span>
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <tbody id="set001_01_06_table">
            </tbody>
        </table>
    </div>
</div>

<!-- Add Workflow Event -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_06_mw001.jsp" %>
<!-- Edit Workflow Event -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_06_mw002.jsp" %>
<!-- Delete Workflow Event -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_06_mw003.jsp" %>

<script>

var set001_01_06_initialized = false;

/**
 * Init Panel
 */
function set001_01_06_init()
{
    if (set001_01_06_initialized == true)
        return false;
            
	set001_01_06_initialized = true;
} // .end of set001_01_06_init

/**
 * Show Panel
 */
function set001_01_06_updateUI()
{
    set001_01_06_init();
    
	var billingWorkflowObj;
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.workflowList, function(i, workflowObj){
    	
    	if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING && 
    	    workflowObj.subModuleId == ModuleConstants.MODULE_BILLING_SUB_WORKFLOW)
    		billingWorkflowObj = workflowObj;
    });
    
    if (billingWorkflowObj != null && billingWorkflowObj.eventList != null) 
    {
	    // Sorting by seqno
	    billingWorkflowObj.eventList.sort(function(a, b) {
			return a.seqno - b.seqno;
		});
	    
		$('#set001_01_06_table').empty();
		$.each(billingWorkflowObj.eventList, function(i, eventObj){
	    	
	    	var htmlLines = '';
	    	htmlLines += '<tr class="read">';
	    	
	    	// COL #1
			htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
			htmlLines += eventObj.seqno;
			htmlLines += '</td>';
			
			// COL #2
			htmlLines += '<td class="mail-date">' + eventObj.eventKey + '</td>';
			
			// COL #3
			htmlLines += '<td class="mail-subject">' + eventObj.eventTitle + '</td>';		
	
			// COL #4
			htmlLines += '<td class="mail-subject">' + eventObj.eventDescription + '</td>';
	
			// COL #5
			htmlLines += '<td class="mail-subject pull-right" style="width:100%;">';
			
			var workflowEditable = true;
			if (eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_NEW || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_OPEN || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_PAYMENT || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_PAID || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_CLOSED || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_DELETED || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_RECORD_CREATED || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_RECORD_UPDATED || 
				eventObj.eventKey == BillingConstants.WORKFLOW_EVENTKEY_RECORD_DELETED)
				workflowEditable = false;
			
			if (workflowEditable)
			{
				htmlLines += '<span class="btn btn-success btn-xs" onclick="set001_01_06_editWorkflow(\'' + billingWorkflowObj.id + '\',\'' + eventObj.id + '\');" style="margin-right:5px;">';
				htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
				htmlLines += '</span>';
				htmlLines += '<span class="btn btn-danger btn-xs" onclick="set001_01_06_deleteWorkflow(\'' + billingWorkflowObj.id + '\',\'' + eventObj.id + '\');">';
				htmlLines += '<i class="fa fa-times" aria-hidden="true"></i>';
				htmlLines += '</span>';
			}
			
			htmlLines += '</td>';
			htmlLines += '</tr>';
			
	    	$('#set001_01_06_table').append(htmlLines);
	    });
    }
  	
    $('#set001_01_06').show();
} // .end of set001_01_06_updateUI

/**
 * Hide Panel
 */
function set001_01_06_hide()
{
    $('#set001_01_06').hide();
} // .end of set001_01_06_hide

function set001_01_06_editWorkflow(workflowId, eventId)
{
	set001_01_06_mw002_show(workflowId, eventId);
} // .end of set001_01_06_editWorkflow


function set001_01_06_deleteWorkflow(workflowId, eventId)
{
	set001_01_06_mw003_show(workflowId, eventId);
} // .end of set001_01_06_editWorkflow

</script>