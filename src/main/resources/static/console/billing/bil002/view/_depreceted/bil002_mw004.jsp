<!-- Modal Window: Edit Billing No -->
<div class="modal inmodal fade" id="mw004" tabindex="-1" role="dialog"  aria-hidden="true">
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
		    <div id="mw004_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Current Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw004_currentBillingNo" disabled>
	                                    	<span id="mw004_currentBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Billing No.</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw004_newBillingNo">
	                                    	<span id="mw004_newBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw004_newBillingNo_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
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
		    	<button type="button" class="btn btn-primary" onclick="mw004_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw004_initialized = false;
var mw004_validInput = false;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw004_isOpen()
{
	return ($("#mw004").data('bs.modal') || {}).isShown;	
} // .end of mw004_isOpen

/**
 * Init Panel
 */
function mw004_init()
{
    if (mw004_initialized == true)
        return false;
    
    $('#mw004').on('shown.bs.modal', function () {
	    $("#mw004_newBillingNo").focus();
	});
    
	mw004_initialized = true;
} // .end of mw004_init

function mw004_show()
{
	mw004_updateUI();
} // .end of mw004_show

/**
 * Show Panel
 */
function mw004_updateUI()
{
    mw004_init();
    
    // Setup inputs
    $('#mw004_currentBillingNo').val( global_billingObj.billingNo );
    $('#mw004_newBillingNo').val( '' );
    $('#mw004_currentBillingNo_error').hide();
    $('#mw004_newBillingNo_error_duplication').hide();
    $('#mw004_newBillingNo_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw004', true);
} // .end of mw004_updateUI

/**
 * Show Panel
 */
function mw004_show()
{
    mw004_updateUI();
} // .end of mw004_show

/**
 * Save changes and hide panel.
 */
function mw004_save()
{
	// reset
    $('#mw004_currentBillingNo_error').hide();
    $('#mw004_newBillingNo_error_duplication').hide();
    $('#mw004_newBillingNo_error').hide();
    
    // Get user input
    var newBillingNo = $.trim( $('#mw004_newBillingNo').val() );

    // Validation #1: if empty value
    if ( $.trim(newBillingNo) === '')
    {
    	$('#mw004_newBillingNo_error').show();
    	$('#mw004_newBillingNo').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    mw004_validInput = true;
    $.each(Cached_getBillingList(), function(i, billingObj){
    	if (newBillingNo == billingObj.billingNo)
    	{
    		mw004_validInput = false;
    		return false;
    	}
    });
        
    if ( mw004_validInput==false )
    {
    	$('#mw004_newBillingNo_error_duplication').show();
    	$('#mw004_newBillingNo').focus();
    	return false;
    }
    
         
    // Save into IndexedDB
    global_billingObj.billingNo = newBillingNo;   
    // Auto-save Billing
	bil001_ctrl_saveBilling();
		    
	// Save into IndexedDB
	if ( $.trim(global_billingObj.customerId).length > 0 ) 
	{
	    var customerObj = Cached_getCustomerById( global_billingObj.customerId );
	    customerObj.lastBillingId = global_billingObj.id;
	    customerObj.lastBillingNo = global_billingObj.billingNo;
	    tycheesIO_saveBean(customerObj);
	}
	
    // Update Customer UI
    $('#summaryPanelBillingNo').val( newBillingNo );
    // Close Modal Window
    $('#mw004').modal('hide');
} // .end of mw004_save

</script>