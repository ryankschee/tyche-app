<style>
.popover {
    z-index: 999999 !important;
}
.clockpicker-popover {
	z-index: 999999 !important;
}

.datepicker {
    z-index: 999999 !important;
}
</style>

<!-- Modal Window: Table Reservation -->
<div class="modal inmodal fade" id="bil002_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW RESERVATION</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="bil002_mw001_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Customer Name</label>
	                                    <div class="col-sm-8 input-group">
	                                    	<input type="hidden" class="form-control" id="bil002_mw001_customerId">
	                                    	<input type="text" class="form-control" id="bil002_mw001_customerName" disabled>
	                                    	<span class="input-group-btn"> 
	                                    		<button id="bil002_mw001_searchCustomerByName" type="button" class="btn btn-primary ladda-button" data-style="expand-left" onclick="bil002_mw001_searchCustomer();">
	                                    			<i class="fa fa-search" aria-hidden="true"></i>
	                                    		</button> 
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Customer Contact</label>
	                                    <div class="col-sm-8 input-group">
	                                    	<input type="text" class="form-control" id="bil002_mw001_customerContact" disabled>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">No. of Pax</label>
	                                    <div class="col-sm-8 input-group">
	                                    	<input type="number" class="form-control" id="bil002_mw001_paxCount">
	                                    	<span id="bil002_mw001_paxCount_error" style="color:#FF0000; display:none;">Invalid No. of Pax</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Date</label>
	                                    <div class="col-sm-8 input-group">
	                                    	<input id="bil002_mw001_reservationDate" type="text" class="form-control date-picker" value="" data-mask="99/99/9999" placeholder="dd/MM/yyyy">
	                                    	<span id="bil002_mw001_reservationDate_error" style="color:#FF0000; display:none;">Invalid Date</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Time</label>
	                                    <div class="col-sm-8 input-group">
		                                    <input id="bil002_mw001_reservationTimeFrom" type="text" class="form-control clock-picker" value="" data-mask="99:99" placeholder="hh:mm">
											<span class="input-group-addon" style="background-color:#DDDDDD;">until</span>
											<input id="bil002_mw001_reservationTimeTo" type="text" class="form-control clock-picker" value="" data-mask="99:99" placeholder="hh:mm">
	                                    	<span id="bil002_mw001_reservationTime_error" style="color:#FF0000; display:none;">Invalid Time</span>
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
		    	<button type="button" class="btn btn-primary" onclick="bil002_mw001_save();">Reserve Table</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var bil002_mw001_initialized = false;

function bil002_mw001_init()
{
    if (bil002_mw001_initialized == true)
        return false;
    
    // Init DatePicker
	$('.date-picker').datepicker({
    	format: 'dd/mm/yyyy',
    	todayBtn: 'linked',
    	todayHighlight: true,
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
		 
	// Init ClockPicker
	$('.clock-picker').clockpicker({
	    placement: 'top',
	    align: 'left',
	    donetext: 'Done'
	});
    
    $('#bil002_mw001').on('shown.bs.modal', function () {
	    $("#bil002_mw001_customerName").focus();
	});
    
	bil002_mw001_initialized = true;
} // .end of bil002_mw001_init

function bil002_mw001_show()
{
    bil002_mw001_updateUI();
} // .end of bil002_mw001_show

function bil002_mw001_updateUI()
{
    bil002_mw001_init();
        
    // Reset
    $('#bil002_mw001_customerName').val('');
    $('#bil002_mw001_customerContact').val('');
    $('#bil002_mw001_paxCount').val('');
    $('#bil002_mw001_reservationDate').val('');
    $('#bil002_mw001_reservationTimeFrom').val('');
    $('#bil002_mw001_reservationTimeTo').val('');
    // Reset error message
	$('#bil002_mw001_customerName_error').hide();
	$('#bil002_mw001_reservationDate_error').hide();
	$('#bil002_mw001_reservationTime_error').hide();
	
    // Show Modal Window
    module_showModalWindow('bil002_mw001', true);
} // .end of bil002_mw001_updateUI

/**
 * Search customer 
 */
function bil002_mw001_searchCustomer()
{
	// Get currently selected customer ID
	var customerNo = $.trim( $('#bil002_mw001_customerNo').val() );
	// Show customer search MW
	mw_customerSearch_show(bil002_mw001_searchCustomer_callbackFn, 'bil002_mw001', customerNo);
} // .end of bil002_mw001_searchCustomer

function bil002_mw001_searchCustomer_callbackFn(customerObj) 
{
	if (customerObj == null) 
	{
		$('#bil002_mw001_customerNo').val('');
		$('#bil002_mw001_customerName').val('');
		$('#bil002_mw001_customerContact').val('');
		$('#bil002_mw001_paxCount').focus();
	} 
	else 
	{
		$('#bil002_mw001_customerNo').val(customerObj.customerNo);
		$('#bil002_mw001_customerName').val(tycheesBean_person_getFullName(customerObj));
		$('#bil002_mw001_customerContact').val(customerObj.contact);	
		$('#bil002_mw001_paxCount').focus();
	}
} // .end of bil002_mw001_searchCustomer_callbackFn

/**
 * Save changes and hide panel.
 */
function bil002_mw001_save()
{
	// Reset Error Messages
	$('#bil002_mw001_customerName_error').hide();
	$('#bil002_mw001_reservationDate_error').hide();
	$('#bil002_mw001_reservationTime_error').hide();

    var customerId				= $.trim( $('#bil002_mw001_customerId').val() );
    var customerName			= $.trim( $('#bil002_mw001_customerName').val() );
    var customerContact			= $.trim( $('#bil002_mw001_customerContact').val() );
    var paxCount    			= $.trim( $('#bil002_mw001_paxCount').val() );
    var reservationDate			= $.trim( $('#bil002_mw001_reservationDate').val() );
    var reservationTimeFrom		= $.trim( $('#bil002_mw001_reservationTimeFrom').val() );
    var reservationTimeTo		= $.trim( $('#bil002_mw001_reservationTimeTo').val() );
    
    // VALIDATION
    if ($.trim(customerName)=='') {
    	$('#bil002_mw001_customerName').show();
    	return false;
    }
    if (tycheesDateTime_isValidDate_ddmmyyyy(reservationDate)==false) {
		$('#bil002_mw001_reservationDate_error').show();
    	return false;
    }
    if (tycheesDateTime_isValidTime_hhmm(reservationTimeFrom)==false) {
		$('#bil002_mw001_reservationTime_error').show();
    	return false;
    }
    if (tycheesDateTime_isValidTime_hhmm(reservationTimeTo)==false) {
		$('#bil002_mw001_reservationTime_error').show();
    	return false;
    }
    // .end of VALIDATION
    
    global_billingBucketObj = bil002_createBucket(global_placeLayoutComponentObj, BillingConstants.BUCKET_STATUS_RESERVED);
	global_billingBucketObj.paxCount = Number(paxCount);
	global_billingBucketObj.customerName = customerName;
	global_billingBucketObj.customerContact = customerContact;
	global_billingBucketObj.reservedOn = tycheesDateTime_getCurrentTimeInMillis();
	global_billingBucketObj.reservedFrom = tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(reservationDate, reservationTimeFrom);
	global_billingBucketObj.reservedTo = tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(reservationDate, reservationTimeTo);
	
	// Save bucket
	bil002_saveBucket();	
	// Update Place
	global_placeLayoutComponentObj.hasChanged = true;
	global_placeLayoutComponentObj.bucketId = global_billingBucketObj.id;
	// Save Place
	tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());

	// Update UI
	bil002_sw001_updateUI_buttonPanel();
	bil002_sw001_updateUI_tab1(); 
	bil002_sw001_updateUI_tab2(); 
	// Update Canvas
	bil002_tablePanel_canvas_repaint();
	
    // Close Modal Window
    $('#bil002_mw001').modal('hide');
} // .end of bil002_mw001_save

</script>