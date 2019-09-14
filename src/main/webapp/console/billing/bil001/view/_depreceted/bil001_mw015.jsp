<!-- Modal Window: Edit Billing No -->
<div class="modal inmodal fade" id="mw015" tabindex="-1" role="dialog"  aria-hidden="true">
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
		    <div id="mw015_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Current Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw015_currentBillingNo" disabled>
	                                    	<span id="mw015_currentBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw015_newBillingNo">
	                                    	<span id="mw015_newBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw015_newBillingNo_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
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
		    	<button id="mw015_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw015_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw015_initialized = false;
var mw015_validInput = false;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw015_isOpen()
{
	return ($("#mw015").data('bs.modal') || {}).isShown;	
} // .end of mw015_isOpen

/**
 * Init Panel
 */
function mw015_init()
{
    if (mw015_initialized == true)
        return false;
    
    $('#mw015').on('shown.bs.modal', function () {
	    $("#mw015_newBillingNo").focus();
	});
    
	mw015_initialized = true;
} // .end of mw015_init

/**
 * Show Panel
 */
function mw015_updateUI()
{
    mw015_init();
    
    // Setup inputs
    $('#mw015_currentBillingNo').val( global_billingObj.billingNo );
    $('#mw015_newBillingNo').val( '' );
    $('#mw015_currentBillingNo_error').hide();
    $('#mw015_newBillingNo_error_duplication').hide();
    $('#mw015_newBillingNo_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw015', true);
} // .end of mw015_updateUI

/**
 * Show Panel
 */
function mw015_show()
{
    mw015_updateUI();
} // .end of mw015_show

function mw015_save()
{
	// Get next billing number
	var currentBillingNo = $.trim( $('#mw015_currentBillingNo').val() );
	var newBillingNo = $.trim( $('#mw015_newBillingNo').val() );
	if (newBillingNo == '')
		return false;
	if (currentBillingNo == newBillingNo)
		return false;
	
	$('#mw015_saveButton').ladda().ladda('start');
	
	// Check if any duplicated order found.
	var requestBody = {
		'appName': APP_NAME_POS,
		'billingNo': newBillingNo,
		'fullBean': false	
	};	

	var params = new Object();
	params.billingNo = newBillingNo;
	
	tycheesdb_api_getBillingByBillingNo(requestBody, mw015_save_postHander, params);
} // .end of mw015_save

function mw015_save_postHander(success, responseObj, params)
{
	$('#mw015_saveButton').ladda().ladda('stop');
	
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
    $('#mw015_currentBillingNo_error').hide();
    $('#mw015_newBillingNo_error_duplication').hide();
    $('#mw015_newBillingNo_error').hide();
    
    // Get user input
    var newBillingNo = params.billingNo;

    // Validation #1: if empty value
    if ( $.trim(newBillingNo) === '')
    {
    	$('#mw015_newBillingNo_error').show();
    	$('#mw015_newBillingNo').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    mw015_validInput = true;
    $.each(Cached_getBillingList(), function(i, billingObj){
    	if (newBillingNo == billingObj.billingNo)
    	{
    		mw015_validInput = false;
    		return false;
    	}
    });
        
    if ( mw015_validInput==false )
    {
    	$('#mw015_newBillingNo_error_duplication').show();
    	$('#mw015_newBillingNo').focus();
    	return false;
    }
    
         
    // Save into IndexedDB
    global_billingObj.billingNo = newBillingNo;   
    // Auto-save Billing
	bil001_menuPanel_save();
		    
	// Save into IndexedDB
	if ( $.trim(global_billingObj.customerId).length > 0 ) 
	{
	    var customerObj = Cached_getCustomerById( global_billingObj.customerId );
	    customerObj.lastBillingId = global_billingObj.id;
	    customerObj.lastBillingNo = global_billingObj.billingNo;
	    tycheesIO_saveBean(customerObj);
	}
	
    // Update Customer UI
    $('#bil001_menuPanel_billingNo').val( newBillingNo );
    // Close Modal Window
    $('#mw015').modal('hide');
} // .end of mw015_save_postHander

</script>