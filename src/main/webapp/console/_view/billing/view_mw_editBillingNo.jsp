
<!-- 
    Modal Window: Edit Billing No 
-->
<div class="modal inmodal fade" id="mw_editBillingNo" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">EDIT BILLING NO.</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw_editBillingNo_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Current Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_editBillingNo_currentBillingNo" disabled>
	                                    	<span id="mw_editBillingNo_currentBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_editBillingNo_newBillingNo">
	                                    	<span id="mw_editBillingNo_newBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw_editBillingNo_newBillingNo_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button id="mw_editBillingNo_closeButton" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button id="mw_editBillingNo_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_editBillingNo_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw_editBillingNo_initialized = false;
var mw_editBillingNo_validInput = false;
var mw_editBillingNo_billingObj;
var mw_editBillingNo_saveCallbackFn;

function mw_editBillingNo_isOpen()
{
	return ($("#mw_editBillingNo").data('bs.modal') || {}).isShown;	
} // .end of mw_editBillingNo_isOpen

function mw_editBillingNo_init()
{
    if (mw_editBillingNo_initialized == true)
        return false;
    
    $('#mw_editBillingNo').on('shown.bs.modal', function () {
	    $("#mw_editBillingNo_newBillingNo").focus();
	});
    
	mw_editBillingNo_initialized = true;
} // .end of mw_editBillingNo_init

function mw_editBillingNo_show(billingObj, saveCallbackFn)
{
	mw_editBillingNo_billingObj = billingObj;
	mw_editBillingNo_saveCallbackFn = saveCallbackFn;
	
    mw_editBillingNo_updateUI();
} // .end of mw_editBillingNo_show

function mw_editBillingNo_updateUI()
{
    mw_editBillingNo_init();
    
    // Setup inputs
    $('#mw_editBillingNo_currentBillingNo').val( mw_editBillingNo_billingObj.billingNo );
    $('#mw_editBillingNo_newBillingNo').val( '' );
    $('#mw_editBillingNo_currentBillingNo_error').hide();
    $('#mw_editBillingNo_newBillingNo_error_duplication').hide();
    $('#mw_editBillingNo_newBillingNo_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw_editBillingNo', true);
} // .end of mw_editBillingNo_updateUI

function mw_editBillingNo_save()
{
	// Get next billing number
	var currentBillingNo = $.trim( $('#mw_editBillingNo_currentBillingNo').val() );
	var newBillingNo = $.trim( $('#mw_editBillingNo_newBillingNo').val() );
	
	if (newBillingNo == '')
		return false;
	if (currentBillingNo == newBillingNo)
		return false;
	
	$('#mw_editBillingNo_saveButton').ladda().ladda('start');
	
	// Check if any duplicated order found.
	var requestBody = {
		'appName': APP_NAME_POS,
		'billingNo': newBillingNo,
		'fullBean': false	
	};	

	var params = new Object();
	params.billingNo = newBillingNo;
	
	tycheesdb_api_getBillingByBillingNo(requestBody, mw_editBillingNo_save_postHander, params);
} // .end of mw_editBillingNo_save

function mw_editBillingNo_save_postHander(success, responseObj, params)
{
	$('#mw_editBillingNo_saveButton').ladda().ladda('stop');
	
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
    $('#mw_editBillingNo_currentBillingNo_error').hide();
    $('#mw_editBillingNo_newBillingNo_error_duplication').hide();
    $('#mw_editBillingNo_newBillingNo_error').hide();
    
    // Get user input
    var newBillingNo = params.billingNo;

    // Validation #1: if empty value
    if ( $.trim(newBillingNo) === '')
    {
    	$('#mw_editBillingNo_newBillingNo_error').show();
    	$('#mw_editBillingNo_newBillingNo').focus();
    	return false;
    }
         
    // Save into IndexedDB
    mw_editBillingNo_billingObj.billingNo = newBillingNo;   
    // Close Modal Window
    $('#mw_editBillingNo').modal('hide');
    // Pass to callback function
    mw_editBillingNo_saveCallbackFn(mw_editBillingNo_billingObj);    
} // .end of mw_editBillingNo_save_postHander

</script>