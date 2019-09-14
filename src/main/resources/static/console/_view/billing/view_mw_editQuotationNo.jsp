
<!-- 
	Modal Window: Edit Billing No 
-->
<div class="modal inmodal fade" id="mw_editQuotationNo" tabindex="-1" role="dialog"  aria-hidden="true">
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
		    <div id="mw_editQuotationNo_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-5 control-label">Current Quotation No.</label>
	                                    <div class="col-sm-7">
	                                    	<input type="text" class="form-control" id="mw_editQuotationNo_currentQuotationNo" disabled>
	                                    	<span id="mw_editQuotationNo_currentQuotationNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-5 control-label">New Quotation No.</label>
	                                    <div class="col-sm-7">
	                                    	<input type="text" class="form-control" id="mw_editQuotationNo_newQuotationNo">
	                                    	<span id="mw_editQuotationNo_newQuotationNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="mw_editQuotationNo_newQuotationNo_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button id="mw_editQuotationNo_closeButton" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button id="mw_editQuotationNo_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_editQuotationNo_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw_editQuotationNo_initialized = false;
var mw_editQuotationNo_validInput = false;
var mw_editQuotationNo_billingObj;
var mw_editQuotationNo_saveCallbackFn;

function mw_editQuotationNo_isOpen()
{
	return ($("#mw_editQuotationNo").data('bs.modal') || {}).isShown;	
} // .end of mw_editQuotationNo_isOpen

function mw_editQuotationNo_init()
{
    if (mw_editQuotationNo_initialized == true)
        return false;
    
    $('#mw_editQuotationNo').on('shown.bs.modal', function () {
	    $("#mw_editQuotationNo_newQuotationNo").focus();
	});
    
	mw_editQuotationNo_initialized = true;
} // .end of mw_editQuotationNo_init

function mw_editQuotationNo_show(billingObj, saveCallbackFn)
{
	mw_editQuotationNo_billingObj = billingObj;
	mw_editQuotationNo_saveCallbackFn = saveCallbackFn;
	
    mw_editQuotationNo_updateUI();
} // .end of mw_editQuotationNo_show

function mw_editQuotationNo_updateUI()
{
    mw_editQuotationNo_init();
    
    // Setup inputs
    $('#mw_editQuotationNo_currentQuotationNo').val( mw_editQuotationNo_billingObj.quotationNo );
    $('#mw_editQuotationNo_newQuotationNo').val( '' );
    $('#mw_editQuotationNo_currentQuotationNo_error').hide();
    $('#mw_editQuotationNo_newQuotationNo_error_duplication').hide();
    $('#mw_editQuotationNo_newQuotationNo_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('mw_editQuotationNo', false);
} // .end of mw_editQuotationNo_updateUI

function mw_editQuotationNo_save()
{
	// Get next billing number
	var currentQuotationNo = $.trim( $('#mw015_currentQuotationNo').val() );
	var newQuotationNo = $.trim( $('#mw_editQuotationNo_newQuotationNo').val() );
	if (newQuotationNo == '')
		return false;
	if (currentQuotationNo == newQuotationNo)
		return false;
	
	$('#mw_editQuotationNo_saveButton').ladda().ladda('start');
	
	// Check if any duplicated order found.
	var requestBody = {
		'appName': APP_NAME_POS,
		'quotationNo': newQuotationNo,
		'fullBean': false	
	};	

	var params = new Object();
	params.quotationNo = newQuotationNo;
	
	tycheesdb_api_getBillingByQuotationNo(requestBody, mw_editQuotationNo_save_postHandler, params);
} // .end of mw_editQuotationNo_save

function mw_editQuotationNo_save_postHandler(success, responseObj, params)
{
	$('#mw_editQuotationNo_saveButton').ladda().ladda('stop');
	
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
    $('#mw_editQuotationNo_currentQuotationNo_error').hide();
    $('#mw_editQuotationNo_newQuotationNo_error_duplication').hide();
    $('#mw_editQuotationNo_newQuotationNo_error').hide();
    
    // Get user input
    var newQuotationNo = params.quotationNo;

    // Validation #1: if empty value
    if ( $.trim(newQuotationNo) === '')
    {
    	$('#mw_editQuotationNo_newQuotationNo_error').show();
    	$('#mw_editQuotationNo_newQuotationNo').focus();
    	return false;
    }
         
    // Save into IndexedDB
    mw_editQuotationNo_billingObj.quotationNo = newQuotationNo;   
    // Close Modal Window
    $('#mw_editQuotationNo').modal('hide');
    // Pass to callback function
    mw_editQuotationNo_saveCallbackFn(mw_editQuotationNo_billingObj);  
} // .end of mw_editQuotationNo_save

</script>