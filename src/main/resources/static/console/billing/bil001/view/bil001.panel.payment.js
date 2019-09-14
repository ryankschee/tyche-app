
function bil001_paymentPanel_show() {
	if (global_billingObj == null) {
		$('#bil001_paymentPanel').addClass('gray-bg');
		$('#bil001_paymentPanel').removeClass('blue-bg');

		// Billing Status
		$('#bil001_paymentPanel_billingStatus').addClass('label-info');
		$('#bil001_paymentPanel_billingStatus').removeClass('label-danger');
		$('#bil001_paymentPanel_billingStatus').removeClass('label-primary');		
		$('#bil001_paymentPanel_billingStatus').html('<i class="fa fa-file-o" aria-hidden="true"></i> NO RECORD');
		
		// Invoice No/Date
		$('#bil001_paymentPanel_invoiceNo').hide();
		$('#bil001_paymentPanel_invoiceDate').hide();
		
		// Amount Details
		$('#bil001_paymentPanel_totalPayable').html('0.00');
		$('#bil001_paymentPanel_subtotal').html('0.00');
		$('#bil001_paymentPanel_paymentBalance').html('0.00');
	} else {
		$('#bil001_paymentPanel').addClass('blue-bg');
		$('#bil001_paymentPanel').removeClass('gray-bg');

		// Billing Status
		if (bil001_isBillingEditable()) {
			$('#bil001_paymentPanel_billingStatus').addClass('label-primary');
			$('#bil001_paymentPanel_billingStatus').removeClass('label-danger');
			$('#bil001_paymentPanel_billingStatus').removeClass('label-info');
			$('#bil001_paymentPanel_billingStatus').html('<i class="fa fa-pencil" aria-hidden="true"></i> ' + global_billingObj.stateDesc.toUpperCase());
		} else {
			$('#bil001_paymentPanel_billingStatus').addClass('label-danger');
			$('#bil001_paymentPanel_billingStatus').removeClass('label-primary');
			$('#bil001_paymentPanel_billingStatus').removeClass('label-info');
			$('#bil001_paymentPanel_billingStatus').html('<i class="fa fa-ban" aria-hidden="true"></i> ' + global_billingObj.stateDesc.toUpperCase());
		}

		// Invoice No/Date
		if ($.trim(global_billingObj.invoiceNo)=='') {
			$('#bil001_paymentPanel_invoiceNo').hide();
			$('#bil001_paymentPanel_invoiceDate').hide();
		} else {
			$('#bil001_paymentPanel_invoiceNo').html($.trim(global_billingObj.invoiceNo));
			$('#bil001_paymentPanel_invoiceDate').html(tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.invoiceDate));
			$('#bil001_paymentPanel_invoiceNo').show();
			$('#bil001_paymentPanel_invoiceDate').show();
		}

		
		// Amount Details
		if (global_billingObj.subTotalAmount == null || global_billingObj.subTotalAmount == '')
			$("#bil001_paymentPanel_subtotal").html('0.00');
		else
			$("#bil001_paymentPanel_subtotal").html(Number(global_billingObj.subTotalAmount).toFixed(2));

		if (global_billingObj.totalAmount == null || global_billingObj.totalAmount == '')
			$("#bil001_paymentPanel_totalPayable").html('0.00');
		else
			$("#bil001_paymentPanel_totalPayable").html(Number(global_billingObj.totalAmount).toFixed(2));

		if (global_billingObj.totalPayment == null || global_billingObj.totalPayment == '')
			$("#bil001_paymentPanel_paymentBalance").html(Number(global_billingObj.totalAmount).toFixed(2));
		else
			$("#bil001_paymentPanel_paymentBalance").html(Number(global_billingObj.totalAmount - global_billingObj.totalPayment).toFixed(2));		
	}
} // .end of bil001_cartPanel_show

function bil001_paymentPanel_showPaymentTerminal() {
	if (global_billingObj == null) 
		return false;
	if (bil001_ctrl_isQuotationMode(global_billingObj)) {
		tycheesLogger_showToast('warning','Payment not Available','Payment is not available for Quatation Order.');
		return false;
	}
	
	mw_paymentTerminal_show(
		bil001_paymentPanel_showPaymentTerminal_payCallbackFn,
		bil001_paymentPanel_showPaymentTerminal_deletePaymentCallbackFn,
		bil001_paymentPanel_showPaymentTerminal_closeCallbackFn,
		null,
		global_billingObj);
} // .end of bil001_paymentPanel_showPaymentTerminal

function bil001_paymentPanel_showPaymentTerminal_payCallbackFn(paymentAmount, changedAmount, balancedAmount) {
	
	// Auto-save Billing
	bil001_menuPanel_save();
    
	var summaryText = 'CHANGE AMOUNT: ' + global_currencySign + tycheesUtil_getSafeNumber(changedAmount, 2);
	if (balancedAmount < 0) {
		summaryText = 'OUTSTANDING: ' + global_currencySign + tycheesUtil_getSafeNumber(Math.abs(balancedAmount), 2);
	}
	else
	if (balancedAmount == 0) {
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
		if (isConfirm) {     
			bil001_menuPanel_newBilling();
		} 
	});
} // .end of bil001_paymentPanel_showPaymentTerminal_payCallbackFn

function bil001_paymentPanel_showPaymentTerminal_deletePaymentCallbackFn() {
	// Auto-save Billing
	bil001_menuPanel_save();
	// Update UI
	bil001_menuPanel_show();
} // .end of bil001_paymentPanel_showPaymentTerminal_deletePaymentCallbackFn

function bil001_paymentPanel_showPaymentTerminal_closeCallbackFn() {
	
} // .end of bil001_paymentPanel_showPaymentTerminal_closeCallbackFn
