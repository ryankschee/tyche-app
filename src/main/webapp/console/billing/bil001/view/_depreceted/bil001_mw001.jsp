<!-- PAYMENT DIALOG -->
<!-- REPLACED by view_mw_paymentTerminal -->
<div class="modal inmodal fade" id="mw001" tabindex="-1" role="dialog" aria-hidden="true">
	<div id="mw001_dialog" class="modal-dialog modal-xl" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="display:none;">
				<span class="modal-title">PAYMENT TERMINAL [<span id="mw001_billingId"></span>]</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
			
				<div class="row">
					<div class="col-sm-4 alert alert-info" style="font-size:18pt;margin-left:5px;margin-right:5px;width:33%;">
				    	<strong>Total: </strong>
				    	<span id="mw001_totalAmount_currency">$CURRENCY</span> 
				    	<span id="mw001_totalAmount">500.00</span>
					</div>
					<div class="col-sm-4 alert alert-info" style="font-size:18pt;margin-left:5px;margin-right:5px;width:33%;">
				    	<strong>Paid: </strong>
				    	<span id="mw001_paidAmount_currency">$CURRENCY</span> 
				    	<span id="mw001_paidAmount">500.00</span>
					</div>
					<div class="col-sm-4 alert alert-info" style="font-size:18pt;margin-left:5px;margin-right:5px;width:31%;">
				    	<strong>Due: </strong>
				    	<span id="mw001_dueAmount_currency">$CURRENCY</span> 
				    	<span id="mw001_dueAmount">1000.00</span>
					</div>
				</div>
				
				<div id="mw001_alert" class="alert alert-info">
				</div>
				
			    <ul class="nav nav-tabs">
					<li class="active" id="mw001_tabHeader_1">
						<a data-toggle="tab" href="#mw001_tabContent_1">
							<i class="fa fa-usd"></i> TRANSACTION
						</a>
					</li>
					<li class="" id="mw001_tabHeader_101">
						<a data-toggle="tab" href="#mw001_tabContent_101">
							<i class="fa fa-history"></i> PAYMENT HISTORY
						</a>
					</li>
				</ul>
				
				<div class="tab-content">
					<!-- TAB 1: Main -->
					<div id="mw001_tabContent_1" class="tab-pane active">
						<div class="row" style="padding-top:15px;">
							<div class="col-md-7">
							    <form role="form" >	
									<div class="row form-group" style="margin-bottom:0px;">
										<div class="col-md-8">
											<label>Select Payment Method</label> 
											<br>
											<div class="btn-group" data-toggle="buttons">
									    		<label id="mw001_paymentMethod_cash_button" class="btn btn-lg btn-info" style="font-size:10pt;" onclick="mw001_selectPaymentMethod('Cash');">
									        		<input type="radio" name="mw001_paymentMethod" id="mw001_paymentMethod_cash" autocomplete="off" checked>
									        		<i class="fa fa-money" aria-hidden="true"></i> CASH
									    		</label>
									    		<label id="mw001_paymentMethod_creditCard_button" class="btn btn-lg btn-info" style="font-size:10pt;" onclick="mw001_selectPaymentMethod('Credit Card');">
									        		<input type="radio" name="mw001_paymentMethod" id="mw001_paymentMethod_creditCard" autocomplete="off"> 
									  				<i class="fa fa-credit-card" aria-hidden="true"></i> CREDIT CARD
									    		</label>
									    		<label id="mw001_paymentMethod_cheque_button" class="btn btn-lg btn-info" style="font-size:10pt;" onclick="mw001_selectPaymentMethod('Cheque');">
									        		<input type="radio" name="mw001_paymentMethod" id="mw001_paymentMethod_cheque" autocomplete="off"> 
									        		<i class="fa fa-list-alt" aria-hidden="true"></i> CHEQUE
									    		</label>
									    	</div>
									    </div>
										<div class="col-md-4">
											<label>Payment Date</label> 
											<input id="mw001_payment_date" type="text" class="form-control" name="mw001_payment_date" data-mask="99/99/9999" placeholder="DD / MM / YYYY" required/>
									    </div>
									    
									</div>
									<div id="mw001_creditCard" class="row" style="display:none;">	
										<div class="col-md-12">
											<label></label>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label>CREDIT CARD NUMBER</label>
														<div class="input-group">
															<input id="mw001_creditCard_number" type="text" class="form-control" name="Number" data-mask="9999-9999-9999-9999" placeholder="Valid Card Number" required />
															<span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
														</div>
													</div>
												</div>
												<div class="col-md-6 pull-right">
													<div class="form-group btn-group" data-toggle="buttons" style="margin-bottom:0px;">
														<div style="padding-bottom:4px; font-weight:bold;">CREDIT CARD TYPE</div>
														<label id="mw001_creditCardTypeVisa" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeVisa');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off">
													    	<i class="fa fa-cc-visa" aria-hidden="true" style="font-size:21pt;"></i> 
														</label>
														<label id="mw001_creditCardTypeMaster" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeMaster');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off">
													    	<i class="fa fa-cc-mastercard" aria-hidden="true" style="font-size:21pt;"></i> 
														</label>
														<label id="mw001_creditCardTypeAmex" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeAmex');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off"> 
													    	<i class="fa fa-cc-amex" aria-hidden="true" style="font-size:21pt;"></i> 
														</label>
														<label id="mw001_creditCardTypeDinersClub" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeDinersClub');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off"> 
													    	<i class="fa fa-cc-diners-club" aria-hidden="true" style="font-size:21pt;"></i> 
														</label>
														<label id="mw001_creditCardTypeJcb" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeJcb');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off"> 
													    	<i class="fa fa-cc-jcb" aria-hidden="true" style="font-size:21pt;"></i> 
														</label>
														<label id="mw001_creditCardTypeDiscover" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeDiscover');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off"> 
													    	<i class="fa fa-cc-discover" aria-hidden="true" style="font-size:21pt;"></i> 
														</label>
														<label id="mw001_creditCardTypeMyDebit" class="btn cc-type" style="padding: 1px 3px 1px 3px;" onclick="mw001_toggleCreditCardType(this, 'creditCardTypeMyDebit');">
													    	<input type="radio" name="mw001_creditCard_type" autocomplete="off"> 
													    	<img src="https://storage.googleapis.com/directme_public/creditCard_myDebit" height="28px" />
														</label>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label>EXPIRATION DATE (MM/YY)</label>
														<input id="mw001_creditCard_expiryDate" type="text" class="form-control" name="Expiry" data-mask="99/99" placeholder="MM / YY" required/>
													</div>
												</div>
												<div class="col-md-6 pull-right">
													<div class="form-group">
														<label>CV CODE</label>
														<input id="mw001_creditCard_securityCode" type="password" class="form-control" name="CVC" data-mask="999" placeholder="CVC" required/>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label>NAME OF CARD</label>
														<input  id="mw001_creditCard_name" type="text" class="form-control" name="nameCard" placeholder="Full Name" required/>
													</div>
												</div>
												<div class="col-md-6 pull-right">
													<div class="form-group">
														<label>ISSUING BANK</label>
														<input id="mw001_creditCard_bank" type="text" class="form-control" name="Bank Name" placeholder="Full Name of Bank" required/>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div id="mw001_cheque" class="row" style="display:none;">	
										<div class="col-md-12">
											<label></label>
											<div class="row">
												<div class="col-xs-12">
													<div class="form-group">
														<label>CHEQUE NUMBER</label>
														<div class="input-group">
															<input id="mw001_cheque_number" type="text" class="form-control" name="Number" data-mask="999999" placeholder="Cheque Number" required />
															<span class="input-group-addon"><i class="fa fa-money"></i></span>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-xs-12">
													<div class="form-group">
														<label>ISSUE DATE (DD/MM/YYYY)</label>
														<input id="mw001_cheque_issueDate" type="text" class="form-control" name="Issue" data-mask="99/99/9999" placeholder="DD / MM / YYYY" required/>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-xs-12">
													<div class="form-group">
														<label>Paying To</label>
														<input id="mw001_cheque_payableName" type="text" class="form-control" name="nameCard" placeholder="" required/>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group" style="margin-bottom:0px;">
										<label>Receiving Amount</label> 
										<input id="mw001_inputPaymentAmount" type="text" placeholder="Enter payment amount" class="form-control input-lg" style="font-size:36pt;height:84px;background-color:#FFFF99" autofocus>
									</div>
									<div class="form-group" style="display:none;">
										<label>Payment Changes</label> 
										<input id="mw001_inputChangeAmount" type="number" placeholder="0.00" class="form-control input-lg" style="font-size:24px;" readonly>
									</div>	
								</form>	
							</div>
							<div class="col-md-5">
								<div class="row">
									<div class="col-md-12">
										<table style="width:100%">
										    <tr>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('7');"><span class="m-xs" style="font-size:30pt;">7</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('8');"><span class="m-xs" style="font-size:30pt;">8</span></button></td> 
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('9');"><span class="m-xs" style="font-size:30pt;">9</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('<');"><span class="m-xs" style="font-size:30pt;"><</span></button></td>
										    </tr>
										    <tr>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('4');"><span class="m-xs" style="font-size:30pt;">4</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('5');"><span class="m-xs" style="font-size:30pt;">5</span></button></td> 
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('6');"><span class="m-xs" style="font-size:30pt;">6</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('CLR');"><span class="m-xs" style="font-size:30pt;">CLR</span></button></td>
										    </tr>
										    <tr>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('1');"><span class="m-xs" style="font-size:30pt;">1</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('2');"><span class="m-xs" style="font-size:30pt;">2</span></button></td> 
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('3');"><span class="m-xs" style="font-size:30pt;">3</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('');"><span class="m-xs" style="font-size:30pt;"></span></button></td>
										    </tr>
										    <tr>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('0');"><span class="m-xs" style="font-size:30pt;">0</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('00');"><span class="m-xs" style="font-size:30pt;">00</span></button></td> 
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('.');"><span class="m-xs" style="font-size:30pt;">.</span></button></td>
												<td><button type="button" class="btn btn-white" style="width:100%;height:80px;" onclick="mw001_numPadClick('');"><span class="m-xs" style="font-size:30pt;"></span></button></td>
										    </tr>
										</table>
									</div>
								</div>					    
							</div>
						</div>
					</div><!-- end of TAB 1 -->
					
					<!-- TAB 2: PAYMENT HISTORY -->
					<div id="mw001_tabContent_101" class="tab-pane">
						<div class="row">
							<div class="col-md-12 col-lg-12">
								<div class="ibox">
									<div class="ibox-content">
										<label>PAYMENT HISTORY</label>
										<table id="mw001_dataTable_billingPayment" class="table table-striped table-bordered table-hover">
											<thead>
												<tr>
													<th data-toggle="true">#</th>
													<th>Date/Time</th>
													<th>Method</th>
													<th>Paying Amount</th>
													<th>Balance/Change Amount</th>
													<th class="text-right" data-sort-ignore="true">Action</th>
												</tr>
											</thead>
											<tbody id="tbody-billing-payment-list">
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div><!-- end of TAB 2 -->
				</div><!-- end of tab-content -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button id="mw001_pay" type="button" class="btn btn-primary" onclick="mw001_pay();">Make Payment</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw001_initialized = false;
var mw001_fullyPaid = false;
var mw001_currency = '';
var mw001_creditCard_type = '';

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw001_isOpen()
{
	return ($("#mw001").data('bs.modal') || {}).isShown;	
} // .end of mw001_isOpen

/**
 * Initiate data into modal window.
 */
function mw001_init()
{			
	if (mw001_initialized==true)
		return false;
    
   	// Init dataTable (billingPayment, Payment Modal Dialog)
	$("#mw001_dataTable_billingPayment").DataTable();
	// When modal window show, set focus on input payment.
	$('#mw001').on('shown.bs.modal', function () {
		$('#mw001_inputPaymentAmount').focus();
		$('#mw001_dialog').css('margin-top','10px');
	});	
	// On key up event - Payment Dialog > Receiving Payment Amount
	$("#mw001_inputPaymentAmount").keyup(function(e) {
		
		if(e.which == 13) 
		{
			// User Pressed Enter
			$("#mw001_pay").click();
	    }
		else
		{
        	mw001_computePayingAmount();
		}
	});       
	
	$('#mw001_payment_date').datepicker({
    	format: 'dd/mm/yyyy',
    	todayBtn: 'linked',
    	todayHighlight: true,
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
	
    mw001_initialized = true;
} // .end of mw001_init

function mw001_updateUI()
{
	mw001_init();

	// Set Currency
	mw001_currency = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
								SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
	$('#mw001_totalAmount_currency').html( mw001_currency );
	$('#mw001_paidAmount_currency').html( mw001_currency );
	$('#mw001_dueAmount_currency').html( mw001_currency );
	
	// Check if billing line exist
	if (global_billingObj.lineList.length == 0) 
	{
		tycheesLogger_showToast("error", "Payment not Ready", "Please insert item(s) before proceed to Payment.");
		return false;
	}
	
	// Check payment option
	var cashOptionAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
								SettingsConstants.SETTINGS_POS_KEY_PAYMENT_OPTION_CASH_ENABLED);
	var creditCardOptionAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
								SettingsConstants.SETTINGS_POS_KEY_PAYMENT_OPTION_CREDIT_CARD_ENABLED);
	var creditCardTypeList = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
								SettingsConstants.SETTINGS_POS_KEY_PAYMENT_CREDIT_CARD_TYPE).split(',');	
	var chequeOptionAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
								SettingsConstants.SETTINGS_POS_KEY_PAYMENT_OPTION_CHEQUE_ENABLED);
	var defaultPaymentOption = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
								SettingsConstants.SETTINGS_POS_KEY_PAYMENT_DEFAULT_OPTION);
	
	if (cashOptionAvailable)
		$('#mw001_paymentMethod_cash_button').show();
	else
		$('#mw001_paymentMethod_cash_button').hide();
	
	if (creditCardOptionAvailable)
		$('#mw001_paymentMethod_creditCard_button').show();
	else
		$('#mw001_paymentMethod_creditCard_button').hide();
	
	if (chequeOptionAvailable)
		$('#mw001_paymentMethod_cheque_button').show();
	else
		$('#mw001_paymentMethod_cheque_button').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_VISA, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeVisa').show();
	else
		$('#mw001_creditCardTypeVisa').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_MASTER, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeMaster').show();
	else
		$('#mw001_creditCardTypeMaster').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_AMEX, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeAmex').show();
	else
		$('#mw001_creditCardTypeAmex').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_DINERS, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeDinersClub').show();
	else
		$('#mw001_creditCardTypeDinersClub').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_JCB, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeJcb').show();
	else
		$('#mw001_creditCardTypeJcb').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_DISCOVER, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeDiscover').show();
	else
		$('#mw001_creditCardTypeDiscover').hide();

	if ($.inArray(SettingsConstants.SETTINGS_POS_VALUE_PAYMENT_CREDIT_CARD_TYPE_MYDEBIT, creditCardTypeList) >= 0)
		$('#mw001_creditCardTypeMyDebit').show();
	else
		$('#mw001_creditCardTypeMyDebit').hide();
	
	// This bill is NOT EDITABLE anymore
	var editable = true;
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_NEW)
	{
		mw001_showAlert('info', 'Payment Terminal is Ready.');
	} 
	else
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_OPEN)
	{
		mw001_showAlert('info', 'Payment Terminal is Ready.');
	}
	else
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_PAID)
	{
		editable = false;
		mw001_showAlert('info', 'This Bill has been fully paid.');
	}
	else
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_DELETED)
	{
		editable = false;
		mw001_showAlert('warning', 'This Bill has been deleted.');
	}
	else
	{
		editable = false;
		mw001_showAlert('error', 'Unknown Billing State found.');
	}
	
	// Editable?
	if (editable==false)
	{
		$('#mw001_payment_date').attr('disabled',true);
		$('#mw001_paymentMethod').attr('disabled',true);
		$('#mw001_inputPaymentAmount').attr('disabled',true);
	}
	else
	{
		$('#mw001_payment_date').attr('disabled', false);
		$('#mw001_paymentMethod').attr('disabled',false);
		$('#mw001_inputPaymentAmount').attr('disabled',false);
	}
	// end of NOT EDITABLE
		
	// Set Payment Date
	var today = new Date();
	$('#mw001_payment_date').val( tycheesDateTime_getFormattedDate_ddMMyyyy(today.getTime()) );
	
	// Clear payment list
	$('#mw001_dataTable_billingPayment').DataTable().clear().draw();
		
	// Get current billing due amount
    var totalAmountDue = Number(global_billingObj.totalAmount);
    $('#mw001_totalAmount').html( tycheesUtil_getSafeNumber(totalAmountDue, 2));
	
	// Calculate total payment received
	var totalPaymentReceived = 0;
	// Prepare list of existing payment
	var totalAmountPaid = 0.0;
	$.each(global_billingObj.paymentList, function(index, paymentObj) {
		
		// Skip if payment object is deleted.
		if (Cached_isDeletedBean(paymentObj)==true)
			return true;
		
		totalPaymentReceived = totalPaymentReceived + paymentObj.payingAmount;
		
		var paidAmount = paymentObj.changeAmount < 0 ? paymentObj.payingAmount : paymentObj.payingAmount - paymentObj.changeAmount;		
		totalAmountPaid += paidAmount;
	});

	// calculate total amount due
	totalAmountDue = totalAmountDue - totalAmountPaid;
	
	// FULLY PAID: No payment accepted anymore.
	if (totalAmountDue <= 0 && totalAmountPaid > 0) 
	{
        mw001_fullyPaid = true;
		totalAmountDue = 0;
		
        $("#mw001_inputPaymentAmount").attr('disabled', true);
        $("#mw001_pay").prop('disabled', true);
        
		// Show status
		$("#mw001_inputPaymentAmount").attr("placeholder", "PAID");
		mw001_showAlert('info','PAID BILL.');		
		// Hide Panel
		$('#mw001_tabHeader_1').hide();
		// Reset TAB
		mw001_selectTab(101);
		// Reset Payment methods
		mw001_selectPaymentMethod( '' );
	}
	else 
	{
		mw001_fullyPaid = false;

        $("#mw001_inputPaymentAmount").attr('disabled', false);
        $("#mw001_pay").prop('disabled', false);
        
		// Show status
		$("#mw001_inputPaymentAmount").prop("placeholder", "Enter payment amount");		
		// Show Panel
		$('#mw001_tabHeader_1').show();
		// Reset TAB
		mw001_selectTab(1);
		// Reset Payment methods
		mw001_selectPaymentMethod( defaultPaymentOption );
	}
	
	// Update Payment History
	mw001_updateUI_paymentHistory();	
	// Set billing ID
	$('#mw001_billingId').html(global_billingObj.billingNo);            
    // Set Total Amount due
    $('#mw001_dueAmount').html( tycheesUtil_getSafeNumber(totalAmountDue, 2));
    // Set total amount paid
    $("#mw001_paidAmount").html( tycheesUtil_getSafeNumber(totalAmountPaid, 2));
    // Reset receiving amount
    $("#mw001_inputPaymentAmount").val("");
    // Reset change amount
    $("#mw001_inputChangeAmount").val( tycheesUtil_getSafeNumber(0, 2));
    
    // Show Modal Window on Top
    module_showModalWindow('mw001', true);
} // .end of mw001_updateUI

function mw001_showAlert(alertType, message)
{
	$("#mw001_alert").removeClass();
	$("#mw001_alert").addClass('alert');
	
	if (alertType=='info')
	{
		$("#mw001_alert").addClass('alert-info');
		$("#mw001_alert").html('<strong>INFO:</strong> ' + message)
	}
	
	if (alertType=='warning')
	{
		$("#mw001_alert").addClass('alert-warning');
		$("#mw001_alert").html('<strong>WARNING:</strong> ' + message)
	}
	
	if (alertType=='error')
	{
		$("#mw001_alert").addClass('alert-danger');
		$("#mw001_alert").html('<strong>ERROR:</strong> ' + message)
	}
} // .end of mw001_showAlert

/**
 * Tab 1 - General
 * Tab 2 - Credit Card
 * Tab 3 - Cheque
 * Tab 4 - Voucher
 * Tab 5 - History
 */
function mw001_selectTab(tabNumber) 
{
	// Select 'Payment History'
	if (tabNumber==101)
	{
		$('#mw001_tabHeader_101').addClass('active');
		$('#mw001_tabContent_101').addClass('active');
	}
	else
	{
		$('#mw001_tabHeader_101').removeClass('active');
		$('#mw001_tabContent_101').removeClass('active');
	}
	
	for (i=1 ; i<=1 ; i++)
	{
		if (tabNumber == i)
		{
			$('#mw001_tabHeader_'+i).addClass('active');
			$('#mw001_tabContent_'+i).addClass('active');
		}
		else
		{
			$('#mw001_tabHeader_'+i).removeClass('active');		
			$('#mw001_tabContent_'+i).removeClass('active');	
		}
	}
} // .end of mw001_selectTab

/**
 * Process user select on payment method. 
 */
function mw001_selectPaymentMethod(method)
{
	if (method=='')
	{
		$('#mw001_paymentMethod_cash_button').addClass('btn-info');
		$('#mw001_paymentMethod_cash_button').removeClass('btn-danger active');
		$('#mw001_paymentMethod_creditCard_button').addClass('btn-info');
		$('#mw001_paymentMethod_creditCard_button').removeClass('btn-danger active');
		$('#mw001_paymentMethod_cheque_button').addClass('btn-info');
		$('#mw001_paymentMethod_cheque_button').removeClass('btn-danger active');
		
		$('#mw001_paymentMethod_cash').prop('checked', false);
		$('#mw001_paymentMethod_creditCard').prop('checked', false);
		$('#mw001_paymentMethod_cheque').prop('checked', false);		
	}
	else
	{
		if (mw001_fullyPaid)
		{
			mw001_showAlert('error', 'Fully Paid Bill. No further payment allowed.');
			return false;
		}
		
		if (method==BillingConstants.PAYMENT_METHOD_CASH)
		{
			$('#mw001_paymentMethod_cash_button').addClass('btn-danger');
			$('#mw001_paymentMethod_cash_button').removeClass('btn-info');
			$('#mw001_paymentMethod_creditCard_button').addClass('btn-info');
			$('#mw001_paymentMethod_creditCard_button').removeClass('btn-danger');
			$('#mw001_paymentMethod_cheque_button').addClass('btn-info');
			$('#mw001_paymentMethod_cheque_button').removeClass('btn-danger');
			
			// Set Focus
			$('#mw001_inputPaymentAmount').focus();
			// Show/hide form
			$('#mw001_creditCard').hide();
			$('#mw001_cheque').hide();
		}
		else
		if (method==BillingConstants.PAYMENT_METHOD_CREDIT_CARD)
		{
			$('#mw001_paymentMethod_cash_button').addClass('btn-info');
			$('#mw001_paymentMethod_cash_button').removeClass('btn-danger');
			$('#mw001_paymentMethod_creditCard_button').addClass('btn-danger');
			$('#mw001_paymentMethod_creditCard_button').removeClass('btn-info');
			$('#mw001_paymentMethod_cheque_button').addClass('btn-info');
			$('#mw001_paymentMethod_cheque_button').removeClass('btn-danger');
			
			// Set Focus
			$('#mw001_inputPaymentAmount').focus();
			// Show/hide form
			$('#mw001_creditCard').show();
			$('#mw001_cheque').hide();
		}
		else
		if (method==BillingConstants.PAYMENT_METHOD_CHEQUE)
		{
			$('#mw001_paymentMethod_cash_button').addClass('btn-info');
			$('#mw001_paymentMethod_cash_button').removeClass('btn-danger');
			$('#mw001_paymentMethod_creditCard_button').addClass('btn-info');
			$('#mw001_paymentMethod_creditCard_button').removeClass('btn-danger');
			$('#mw001_paymentMethod_cheque_button').addClass('btn-danger');
			$('#mw001_paymentMethod_cheque_button').removeClass('btn-info');
		
			// Set Focus
			$('#mw001_inputPaymentAmount').focus();
			// Show/hide form
			$('#mw001_creditCard').hide();
			$('#mw001_cheque').show();
		}
		else
		if (method==BillingConstants.PAYMENT_METHOD_VOUCHER)
		{
			// Set Focus
			$('#mw001_inputPaymentAmount').focus();
			// Show/hide form
			$('#mw001_creditCard').hide();
			$('#mw001_cheque').hide();
		}
	}	
} // .end of mw001_onchange_paymentMethod

/**
 * Process user click on number pad button.
 *
 * @param btnText		Keypad button text
 */
function mw001_numPadClick(btnText)
{
	if (mw001_fullyPaid)
	{
		mw001_showAlert('error', 'Fully Paid Bill. No further payment allowed.');
		return false;
	}
	
	var currentValue = $("#mw001_inputPaymentAmount").val();
	
	if (btnText=='') 
	{
		return false;
	}
	else
	if (btnText=='<') 
	{
		$("#mw001_inputPaymentAmount").val(currentValue.substring(0, currentValue.length-1));
	}
	else
	if (btnText=='CLR')	
	{
		inputPaymentAmount.val("");
	}
	else
	if (btnText=='.')	
	{
		$("#mw001_inputPaymentAmount").val(currentValue+btnText);
	}
	else 
	{
		$("#mw001_inputPaymentAmount").val(currentValue+btnText);
	}
	
	mw001_computePayingAmount();
	$("#mw001_inputPaymentAmount").focus();
	
	return false;
} // .emd of mw001_numPadClick

/**
 * Process user click on quick payment button.
 *
 * @param btnText		Keypad button text
 */
function mw001_quickPayment(btnText)
{
	// Get amount from clicked button
	var btnTextInDouble = parseFloat(btnText);
	// Set values to input component
	$("#mw001_inputPaymentAmount").val( tycheesUtil_getSafeNumber(btnTextInDouble, 2) );
	$("#mw001_inputReceivedCashAmount").val( tycheesUtil_getSafeNumber(btnTextInDouble, 2));
	
	// Compute values from entered paying amount
	mw001_computePayingAmount();
	// Set focus on input component 'Paying amount'
	$("#mw001_inputPaymentAmount").focus();
} // .end of mw001_quickPayment

function mw001_toggleCreditCardType(element, type)
{
	var parentElement = $(element).parent();
	var labelElementList = parentElement.find('.cc-type');
	
	$.each(labelElementList, function(i, labelElement){
		$(labelElement).removeClass('btn-danger');
	});
	
	mw001_creditCard_type = type;
	$(element).addClass('btn-danger');
} // .end of mw001_toggleCreditCardType

function mw001_updateUI_paymentHistory()
{
	// Clear payment list
	$('#mw001_dataTable_billingPayment').DataTable().clear().draw();
		
	// Prepare list of existing payment
	var totalAmountPaid = 0.0;
	var rowNo = 1;
	$.each(global_billingObj.paymentList, function(index, paymentObj) {

		if (Cached_isDeletedBean(paymentObj)==true)
			return true;
		
		var htmlLines_buttons = '';
		htmlLines_buttons += '<span class="text-right pull-right">';
		htmlLines_buttons += '<button class="btn btn-danger btn-xs" style="width:100%;" onclick="mw001_delete(\'' + paymentObj.id + '\');" style="vertical-align:middle;">';
		htmlLines_buttons += 'Delete';
		htmlLines_buttons += '</button>';
		htmlLines_buttons += '</span>';
		
		var rowSet = [];
		rowSet.push( rowNo++ );
		rowSet.push( tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss(paymentObj.createdOn) );
		rowSet.push( paymentObj.method + ' (' + $.trim(paymentObj.methodDesc) + ')' );
		rowSet.push( tycheesUtil_getSafeNumber(paymentObj.payingAmount, 2) );
		rowSet.push( tycheesUtil_getSafeNumber(paymentObj.changeAmount, 2) );
		rowSet.push( htmlLines_buttons );
		
		$("#mw001_dataTable_billingPayment").dataTable().fnAddData( rowSet, false );
	});	
	
	$("#mw001_dataTable_billingPayment").DataTable().draw();
} // .end of mw001_updateUI_paymentHistory

/**
 * Delete payment record.
 *
 * @param paymentId		Payment ID
 * @param rowNo			Row number of payment in dataTable.
 */
function mw001_delete(paymentId)
{
	$.each(global_billingObj.paymentList, function(i, paymentObj) {
		if (Cached_isDeletedBean(paymentObj)==true)
			return true;
		
		if (paymentObj.id == paymentId) 
		{
			// Create workflow event
			// Get billing workflow object
			var billingWorkflowObj;
			$.each(global_billingObj.workflowList, function(j, workflowObj) {
				if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
					billingWorkflowObj = workflowObj;
			});

			// Create new workflow event (deleted)
			var workflowEventObj = createNew_BillingWorkflowEvent();
			workflowEventObj.workflowId = billingWorkflowObj.id;
			workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
			workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_RECORD_DELETED;
			workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_RECORD_DELETED;
			workflowEventObj.eventDescription = 'Payment record deleted (amount=' + paymentObj.payingAmount + ')';
			workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
			workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
			billingWorkflowObj.eventList.push( workflowEventObj );
				
			Cached_deleteBean(paymentObj);			
			return false;
		}
	});

	// Save Billing
	bil001_menuPanel_save();
	// Update UI
	mw001_updateUI();
	
	$('#mw001_tabHeader_1').removeClass('active');
	$('#mw001_tabHeader_101').addClass('active');
	$('#mw001_tabContent_1').removeClass('active');
	$('#mw001_tabContent_101').addClass('active');
} // .end of mw001_delete

/**
 * Compute user's paying amount from screen. 
 */
function mw001_computePayingAmount()
{
	var paymentAmount = Number($("#mw001_inputPaymentAmount").val());
	
	if (isNaN(paymentAmount))
	{
		mw001_showAlert('error','Receiving amount is not in number format.');
		return false;
	}
	
    var dueAmount = Number($("#mw001_dueAmount").html());
    var changeAmount = paymentAmount - dueAmount;
    if (changeAmount < 0)
    	changeAmount = 0;

    if (paymentAmount != 0 && paymentAmount < dueAmount) 
    {
    	mw001_showAlert('warning','Receiving amount is lesser than Payment Due.');
    }
    else 
    {
    	mw001_showAlert('info','Receiving amount is OK.');
    }
    
    $("#mw001_inputChangeAmount").val( tycheesUtil_getSafeNumber(changeAmount, 2));
} // .end of mw001_computePayingAmount
        
/**
 * Process user click on button 'Pay'.
 */        
function mw001_pay()
{
	var paymentDate = $('#mw001_payment_date').val();
	var paymentDue = Number($("#mw001_dueAmount").html());
	var paymentDone = Number($("#mw001_paidAmount").html());
	var payingAmount = Number($("#mw001_inputPaymentAmount").val());

	if (tycheesDateTime_isValidDate_ddmmyyyy(paymentDate)==false)
	{
		mw001_showAlert('error','Invalid Payment Date.');
		$('#mw001_payment_date').css('border-color','#FF0000');
		$('#mw001_payment_date').focus();		
		return false;
	}
	
	if (isNaN(payingAmount))
	{
		mw001_showAlert('error','Receiving amount is not in number format.');
		$('#mw001_inputPaymentAmount').css('border-color','#FF0000');
		$("#mw001_inputPaymentAmount").focus();
		return false;
	}

	var paymentMethod = '';
	var paymentMethodDesc = '';
	if ($('#mw001_paymentMethod_cash_button').hasClass('btn-danger'))
		paymentMethod = BillingConstants.PAYMENT_METHOD_CASH;
	if ($('#mw001_paymentMethod_creditCard_button').hasClass('btn-danger'))
		paymentMethod = BillingConstants.PAYMENT_METHOD_CREDIT_CARD;
	if ($('#mw001_paymentMethod_cheque_button').hasClass('btn-danger'))
		paymentMethod = BillingConstants.PAYMENT_METHOD_CHEQUE;
	
	/*
	if ($('#mw001_paymentMethod_cash').prop('checked')==true)
		paymentMethod = BillingConstants.PAYMENT_METHOD_CASH;
	if ($('#mw001_paymentMethod_creditCard').prop('checked')==true)
		paymentMethod = BillingConstants.PAYMENT_METHOD_CREDIT_CARD;
	if ($('#mw001_paymentMethod_cheque').prop('checked')==true)
		paymentMethod = BillingConstants.PAYMENT_METHOD_CHEQUE;
	*/
	var paymentFieldList = [];
	
	// VALIDATION
	if (payingAmount=='' || payingAmount==0)
	{
		mw001_showAlert('error','Invalid paying amount.');
		return false;	
	}
	
	if (paymentMethod=='')
	{
		mw001_showAlert('error','Invalid payment method selection.');
		return false;	
	}
	
	if (paymentMethod==BillingConstants.PAYMENT_METHOD_CREDIT_CARD) 
	{
		var cc_type = mw001_creditCard_type;
		var cc_number = $('#mw001_creditCard_number').val();
		var cc_expiryDate = $('#mw001_creditCard_expiryDate').val();
		var cc_securityCode = $('#mw001_creditCard_securityCode').val();
		var cc_name = $('#mw001_creditCard_name').val();
		var cc_bank = $('#mw001_creditCard_bank').val();
	
		// Check if validation required.
		var validationRequired = settingsCommon_getSettingsValue(
									ModuleConstants.MODULE_BILLING, 
									ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
									SettingsConstants.SETTINGS_POS_KEY_PAYMENT_CREDIT_CARD_INFO_REQUIRED);
		if (validationRequired==true) 
		{
			if (cc_type=='')
			{
				mw001_showAlert('error','Invalid Credit Card Type. Please select the one of the type.');
				return false;
			}
			
			if (cc_number=='' || cc_number.length != 19) 
			{
				mw001_showAlert('error','Invalid Credit Card Number. Please enter 16-digits number.');
				return false;
			}
			
			if (cc_expiryDate=='' || cc_expiryDate.length != 5) 
			{
				mw001_showAlert('error','Invalid Credit Card Expiry Date.');
				return false;
			}
			
			var cc_expiryDate_month = cc_expiryDate.substring(0, 2);
			if (Number(cc_expiryDate_month)==NaN || cc_expiryDate_month < 1 || cc_expiryDate_month > 12)
			{
				mw001_showAlert('error','Invalid Credit Card Expiry Date. Please enter valid month (01-12).');
				return false;
			}
	
			var cc_expiryDate_year = cc_expiryDate.substring(3, 5);
			if (Number(cc_expiryDate_year)==NaN)
			{
				mw001_showAlert('error','Invalid Credit Card Expiry Date. Please enter valid year (digit only).');
				return false;
			}
			
			if (cc_securityCode=='' || cc_securityCode.length != 3) 
			{
				mw001_showAlert('error','Invalid Credit Card Security Code. Please enter 3-digits number.');
				return false;
			}
			
			if (cc_bank=='') 
			{
				mw001_showAlert('error','Invalid Issuing Bank Name. Please enter full name of Bank.');
				return false;
			}
		}
		
		// Create payment fields
		var cc_type_obj = createNew_BillingPaymentProperties();
		var cc_number_obj = createNew_BillingPaymentProperties();
		var cc_expiryDateMonth_obj = createNew_BillingPaymentProperties();
		var cc_expiryDateYear_obj = createNew_BillingPaymentProperties();
		var cc_securityCode_obj = createNew_BillingPaymentProperties();
		var cc_name_obj = createNew_BillingPaymentProperties();
		var cc_bank_obj = createNew_BillingPaymentProperties();
		
		cc_type_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_TYPE;
		cc_type_obj.propValue = cc_type;
		cc_number_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_NUMBER;
		cc_number_obj.propValue = cc_number;
		cc_expiryDateMonth_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_EXPIRY_DATE_MONTH;
		cc_expiryDateMonth_obj.propValue = cc_expiryDate_month;
		cc_expiryDateYear_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_EXPIRY_DATE_YEAR;
		cc_expiryDateYear_obj.propValue = cc_expiryDate_year;
		cc_securityCode_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_SECURITY_CODE;
		cc_securityCode_obj.propValue = cc_securityCode;
		cc_name_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_NAME;
		cc_name_obj.propValue = cc_name;	
		cc_bank_obj.propKey = BillingConstants.PAYMENT_FIELD_CREDIT_CARD_BANK;
		cc_bank_obj.propValue = cc_bank;	

		paymentFieldList.push(cc_type_obj);
		paymentFieldList.push(cc_number_obj);
		paymentFieldList.push(cc_expiryDateMonth_obj);
		paymentFieldList.push(cc_expiryDateYear_obj);
		paymentFieldList.push(cc_securityCode_obj);
		paymentFieldList.push(cc_name_obj);
		paymentFieldList.push(cc_bank_obj);
		
		// Set Credit Card type
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_VISA)
			paymentMethodDesc = 'VISA';
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_MASTER)
			paymentMethodDesc = 'MASTER';
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_AMEX)
			paymentMethodDesc = 'AMEX';
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_DINERS_CLUB)
			paymentMethodDesc = 'DINERS CLUB';
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_DISCOVER)
			paymentMethodDesc = 'DISCOVER';
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_JCB)
			paymentMethodDesc = 'JCB';
		if (cc_type == BillingConstants.CREDIT_CARD_TYPE_MYDEBIT)
			paymentMethodDesc = 'MY DEBIT';
	}
	if (paymentMethod==BillingConstants.PAYMENT_METHOD_CHEQUE) 
	{
		var cheque_number = $('#mw001_cheque_number').val();
		var cheque_issueDate = $('#mw001_cheque_issueDate').val();
		var cheque_payableName = $('#mw001_cheque_payableName').val();

		// Check if validation required.
		var validationRequired = settingsCommon_getSettingsValue(
									ModuleConstants.MODULE_BILLING, 
									ModuleConstants.MODULE_BILLING_SUB_PAYMENT, 
									SettingsConstants.SETTINGS_POS_KEY_PAYMENT_CHEQUE_INFO_REQUIRED);
		if (validationRequired==true) 
		{
			if (cheque_number=='' || cheque_number.length != 6) 
			{
				mw001_showAlert('error','Invalid Cheque Number. Please enter 6-digits number.');
				return false;
			}
	
			var cheque_issueDate_millisecond = tycheesDateTime_toMilliseconds_ddMMyyyy(cheque_issueDate);
			if (cheque_issueDate_millisecond == 0) 
			{
				mw001_showAlert('error','Invalid Cheque Issue Date. Please enter in format dd/MM/yyyy.');
				return false;
			}
		}
		
		// Create payment fields
		var cheque_number_obj = createNew_BillingPaymentProperties();
		var cheque_issueDate_obj = createNew_BillingPaymentProperties();
		var cheque_payableName_obj = createNew_BillingPaymentProperties();
		
		cheque_number_obj.propKey = BillingConstants.PAYMENT_FIELD_CHEQUE_NUMBER;
		cheque_number_obj.propValue = cc_number;
		cheque_issueDate_obj.propKey = BillingConstants.PAYMENT_FIELD_CHEQUE_ISSUE_DATE;
		cheque_issueDate_obj.propValue = cc_expiryDate_month;
		cheque_payableName_obj.propKey = BillingConstants.PAYMENT_FIELD_CHEQUE_NAME;
		cheque_payableName_obj.propValue = cc_expiryDate_year;
		
		paymentFieldList.push(cheque_number_obj);
		paymentFieldList.push(cheque_issueDate_obj);
		paymentFieldList.push(cheque_payableName_obj);
	}
	if (paymentMethod==BillingConstants.PAYMENT_METHOD_VOUCHER) 
	{
		// temporary not available
	}
	// .end of VALIDATION
	
	// Create payment object	
	var dateTime = new Date( tycheesDateTime_toMilliseconds_ddMMyyyy(paymentDate) );
	var newPaymentObj = createNew_BillingPayment();
	newPaymentObj.placeId = tycheesCommon_getCurrentPlaceId();
	newPaymentObj.paymentDate = tycheesDateTime_getCurrentTimeInMillis();
	newPaymentObj.payingAmount = payingAmount;
	newPaymentObj.changeAmount = payingAmount - paymentDue;
	newPaymentObj.method = paymentMethod;
	newPaymentObj.methodDesc = paymentMethodDesc;
	newPaymentObj.details = payingAmount >= paymentDue ? 'full' : 'deposit';
	newPaymentObj.createdOn = dateTime.getTime();      		
	global_billingObj.paymentList.push(newPaymentObj);
	
	$.each(paymentFieldList, function(i, propObj){
		propObj.billingId = global_billingObj.id;
		propObj.paymentId = newPaymentObj.id;
		newPaymentObj.propertiesList.push(propObj);
	});
	
	// Create workflow event
	// Get billing workflow object
	var billingWorkflowObj;
	$.each(global_billingObj.workflowList, function(i, workflowObj) {
		if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
			billingWorkflowObj = workflowObj;
	});

	// Create new workflow event (deleted)
	var workflowEventObj = createNew_BillingWorkflowEvent();
	workflowEventObj.workflowId = billingWorkflowObj.id;
	workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
	workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_PAYMENT;
	workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_PAYMENT;
	workflowEventObj.eventDescription = 'Payment Amount (' + payingAmount + ')';
	workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
	workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
	billingWorkflowObj.eventList.push( workflowEventObj );
		
	// Auto-save Billing
	bil001_menuPanel_save();
    
    // Hide Modal Window
    module_closeModalWindow('mw001');
    
	// Changes Amount
	var changedAmount = $('#mw001_inputChangeAmount').val();
    var summaryText = 'CHANGE AMOUNT: ' + mw001_currency + tycheesUtil_getSafeNumber(changedAmount, 2);

	if (newPaymentObj.changeAmount < 0)
	{
		summaryText = 'OUTSTANDING: ' + mw001_currency + tycheesUtil_getSafeNumber(Math.abs(newPaymentObj.changeAmount), 2);
	}
	else
	if (newPaymentObj.changeAmount == 0) 
	{
		summaryText = 'Full Payment has been completed.';
	}
    
	swal({   
		title: summaryText, 
		text: "",   
		type: "info",      
		showCancelButton: true,   
		confirmButtonColor: "#DD6B55",   
		confirmButtonText: "New Billing",   
		cancelButtonText: "Remain in this Billing",   
		closeOnConfirm: true,   
		closeOnCancel: true
		
	}, function(isConfirm){   
		if (isConfirm) 
		{     
			page_executeAction(PAGE_ACTION_NEW_BILLING);
		} 
	});

} // .end of mw001_pay

</script>