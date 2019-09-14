<!-- Modal Window: Edit Billing No -->
<div class="modal inmodal fade" id="mw017" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">EDIT QUOTATION NO.</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw017_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-5 control-label">Current Quotation No.</label>
	                                    <div class="col-sm-7">
	                                    	<input type="text" class="form-control" id="mw017_currentQuotationNo" disabled>
	                                    	<span id="mw017_currentQuotationNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-5 control-label">New Quotation No.</label>
	                                    <div class="col-sm-7">
	                                    	<input type="text" class="form-control" id="mw017_newQuotationNo">
	                                    	<span id="mw017_newQuotationNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw017_newQuotationNo_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
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
		    	<button id="mw017_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw017_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw017_initialized = false;
var mw017_validInput = false;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw017_isOpen()
{
	return ($("#mw017").data('bs.modal') || {}).isShown;	
} // .end of mw017_isOpen

/**
 * Init Panel
 */
function mw017_init()
{
    if (mw017_initialized == true)
        return false;
    
    $('#mw017').on('shown.bs.modal', function () {
	    $("#mw017_newQuotationNo").focus();
	});
    
	mw017_initialized = true;
} // .end of mw017_init

/**
 * Show Panel
 */
function mw017_updateUI()
{
    mw017_init();
    
    // Setup inputs
    $('#mw017_currentQuotationNo').val( global_billingObj.quotationNo );
    $('#mw017_newQuotationNo').val( '' );
    $('#mw017_currentQuotationNo_error').hide();
    $('#mw017_newQuotationNo_error_duplication').hide();
    $('#mw017_newQuotationNo_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw017', false);
} // .end of mw017_updateUI

/**
 * Show Panel
 */
function mw017_show()
{
    mw017_updateUI();
} // .end of mw017_show

function mw017_save()
{
	// Get next billing number
	var currentQuotationNo = $.trim( $('#mw015_currentQuotationNo').val() );
	var newQuotationNo = $.trim( $('#mw017_newQuotationNo').val() );
	if (newQuotationNo == '')
		return false;
	if (currentQuotationNo == newQuotationNo)
		return false;
	
	$('#mw017_saveButton').ladda().ladda('start');
	
	// Check if any duplicated order found.
	var requestBody = {
		'appName': APP_NAME_POS,
		'quotationNo': newQuotationNo,
		'fullBean': false	
	};	

	var params = new Object();
	params.quotationNo = newQuotationNo;
	
	tycheesdb_api_getBillingByQuotationNo(requestBody, mw017_save_postHandler, params);
} // .end of mw017_save

function mw017_save_postHandler(success, responseObj, params)
{
	$('#mw017_saveButton').ladda().ladda('stop');
	
	if (!success) {
		return false;
	}
	
	// Duplication found
	if (responseObj.billingObj != null) {
		swal({
			type: 'warning',
		    title: 'Duplicated quotation number found',
			text: 'Please use another quotation no.'
		});
		return false;
	}
	
	// reset
    $('#mw017_currentQuotationNo_error').hide();
    $('#mw017_newQuotationNo_error_duplication').hide();
    $('#mw017_newQuotationNo_error').hide();
    
    // Get user input
    var newQuotationNo = params.quotationNo;

    // Validation #1: if empty value
    if ( $.trim(newQuotationNo) === '')
    {
    	$('#mw017_newQuotationNo_error').show();
    	$('#mw017_newQuotationNo').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    mw017_validInput = true;
    $.each(Cached_getBillingList(), function(i, billingObj){
    	if (newQuotationNo == billingObj.quotationNo)
    	{
    		mw017_validInput = false;
    		return false;
    	}
    });
        
    if ( mw017_validInput==false )
    {
    	$('#mw017_newQuotationNo_error_duplication').show();
    	$('#mw017_newQuotationNo').focus();
    	return false;
    }
    
         
    // Save into IndexedDB
    global_billingObj.quotationNo = newQuotationNo;   
    // Auto-save Billing
	bil001_menuPanel_save();
		    
	// Save into IndexedDB
	if ( $.trim(global_billingObj.customerId).length > 0 ) 
	{
	    var customerObj = Cached_getCustomerById( global_billingObj.customerId );
	    customerObj.lastBillingId = global_billingObj.id;
	    customerObj.lastQuotationNo = global_billingObj.quotationNo;
	    tycheesIO_saveBean(customerObj);
	}
	
    // Update Customer UI
    $('#bil001_menuPanel_quotationNo').val( newQuotationNo );
    // Close Modal Window
    $('#mw017').modal('hide');
} // .end of mw017_save

</script>