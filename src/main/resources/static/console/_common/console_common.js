
function getLatestUpdatedOnFromBeanList(beanList)
{
	var latestUpdatedOn = 0;
	$.each(beanList, function(i, beanObj){
		if (beanObj.updatedOn > latestUpdatedOn)	
			latestUpdatedOn = beanObj.updatedOn;
	});
	
	return latestUpdatedOn;
} // .end of getLatestUpdatedOnFromBeanList

/*
 * Get next available billing no.
 */ 
function consoleCommon_getNextBillingNo()
{
    var settingsObj_billingPrefix   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_PREFIX);
    var settingsObj_billingNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_NEXT);
    var settingsObj_billingMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_MAX);
    
    // If next no has burst
    if (settingsObj_billingNextNo.propValue > settingsObj_billingMaxNo.propValue)
    	return 'NOT SET';
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_billingMaxNo.propValue).length;
    var nextBillingNo = settingsObj_billingPrefix.propValue + 
    					tycheesText_leftPad(settingsObj_billingNextNo.propValue, '0', maxLength);
	
	return nextBillingNo;
} // .end of consoleCommon_getNextBillingNo

/**
 * Update billing number as current billing number
 */ 
function consoleCommon_updateNextBillingNo()
{
    var settingsObj_billingNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_NEXT);
    var settingsObj_billingMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_MAX);

    // If next no has burst
    if (settingsObj_billingNextNo.propValue > settingsObj_billingMaxNo.propValue)
    	return 'NOT SET';
    
    // Increment current number
    var newNextNo = Number(settingsObj_billingNextNo.propValue) + 1;
    
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_POS_KEY_BILLING_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextBillingNo_postHandler, params);
} // .end of consoleCommon_updateNextBillingNo

function consoleCommon_updateNextBillingNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextInvoiceNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextInvoiceNo_postHandler');
	}
} // .end of consoleCommon_updateNextBillingNo_postHandler

/**
 * Get next available invoice no.
 */ 
function consoleCommon_getNextInvoiceNo()
{
    var settingsObj_invoicePrefix   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_PREFIX);
    var settingsObj_invoiceNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_NEXT);
    var settingsObj_invoiceMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_MAX);
    
    // If next no has burst
    if (settingsObj_invoiceNextNo.propValue > settingsObj_invoiceMaxNo.propValue)
    	return 'NOT SET';
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_invoiceMaxNo.propValue).length;
    var nextNo = settingsObj_invoicePrefix.propValue + 
					tycheesText_leftPad(settingsObj_invoiceNextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextInvoiceNo

/**
 * Update invoice number as current invoice number
 */ 
function consoleCommon_updateNextInvoiceNo()
{
	var settingsObj_invoiceNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_NEXT);
	var settingsObj_invoiceMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_MAX);

	// If next no has burst
	if (settingsObj_invoiceNextNo.propValue > settingsObj_invoiceMaxNo.propValue)
		return false;

    // Increment current number
    var newNextNo = Number(settingsObj_invoiceNextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextInvoiceNo_postHandler, params);
} // .end of consoleCommon_updateNextInvoiceNo

function consoleCommon_updateNextInvoiceNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextInvoiceNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextInvoiceNo_postHandler');
	}
} // .end of consoleCommon_updateNextInvoiceNo_postHandler

/**
 * Get next available receipt no.
 */ 
function consoleCommon_getNextPaymentReceiptNo()
{
    var settingsObj_receiptPrefix   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_PREFIX);
    var settingsObj_receiptNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_NEXT);
    var settingsObj_receiptMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_MAX);
    
    // If next no has burst
    if (settingsObj_receiptNextNo.propValue > settingsObj_receiptMaxNo.propValue)
    	return false;
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_receiptMaxNo.propValue).length;
    var nextNo = settingsObj_receiptPrefix.propValue + 
					tycheesText_leftPad(settingsObj_receiptNextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextPaymentReceiptNo

/**
 * Update receipt number as current receipt number
 */ 
function consoleCommon_updateNextPaymentReceiptNo()
{
	var settingsObj_receiptNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_NEXT);
    var settingsObj_receiptMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_MAX);
    
    // If next no has burst
    if (settingsObj_receiptNextNo.propValue > settingsObj_receiptMaxNo.propValue)
    	return false;
    
    // Increment current number
    var newNextNo = Number(settingsObj_receiptNextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextPaymentReceiptNo_postHandler, params);
} // .end of consoleCommon_updateNextPaymentReceiptNo

function consoleCommon_updateNextPaymentReceiptNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextPaymentReceiptNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextPaymentReceiptNo_postHandler');
	}
} // .end of consoleCommon_updateNextPaymentReceiptNo_postHandler

/**
 * Get next available receipt no.
 */ 
function consoleCommon_getNextPaymentVoucherNo()
{
    var settingsObj_prefix   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_PREFIX);
    var settingsObj_nextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_NEXT);
    var settingsObj_maxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_MAX);
    
    // If next no has burst
    if (settingsObj_nextNo.propValue > settingsObj_maxNo.propValue)
    	return false;
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_maxNo.propValue).length;
    var nextNo = settingsObj_prefix.propValue + 
					tycheesText_leftPad(settingsObj_nextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextPaymentVoucherNo

/**
 * Update receipt number as current receipt number
 */ 
function consoleCommon_updateNextPaymentVoucherNo()
{
	var settingsObj_nextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_NEXT);
    var settingsObj_maxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_MAX);
    
    // If next no has burst
    if (settingsObj_nextNo.propValue > settingsObj_maxNo.propValue)
    	return false;
    
    // Increment current number
    var newNextNo = Number(settingsObj_nextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextPaymentVoucherNo_postHandler, params);
} // .end of consoleCommon_updateNextPaymentVoucherNo

function consoleCommon_updateNextPaymentVoucherNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextPaymentVoucherNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextPaymentVoucherNo_postHandler');
	}
} // .end of consoleCommon_updateNextPaymentVoucherNo_postHandler

/**
 * Get next available quotation no.
 */ 
function consoleCommon_getNextQuotationNo()
{
    var settingsObj_quotationPrefix   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_PREFIX);
    var settingsObj_quotationNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_NEXT);
    var settingsObj_quotationMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_MAX);
    
    // If next no has burst
    if (settingsObj_quotationNextNo.propValue > settingsObj_quotationMaxNo.propValue)
    	return false;
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_quotationMaxNo.propValue).length;
    var nextNo = settingsObj_quotationPrefix.propValue + 
					tycheesText_leftPad(settingsObj_quotationNextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextQuotationNo

/**
 * Update quotation number as current quotation number
 */ 
function consoleCommon_updateNextQuotationNo()
{
	var settingsObj_quotationNextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_NEXT);
    var settingsObj_quotationMaxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_MAX);
    
    // If next no has burst
    if (settingsObj_quotationNextNo.propValue > settingsObj_quotationMaxNo.propValue)
    	return false;
    
    // Increment current number
    var newNextNo = Number(settingsObj_quotationNextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextQuotationNo_postHandler, params);
} // .end of consoleCommon_updateNextQuotationNo

function consoleCommon_updateNextQuotationNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextQuotationNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextQuotationNo_postHandler');
	}
} // .end of consoleCommon_updateNextQuotationNo_postHandler

/**
 * Get next available quotation no.
 */ 
function consoleCommon_getNextDeliveryOrderNo()
{
    var settingsObj_prefix   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_PREFIX);
    var settingsObj_nextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_NEXT);
    var settingsObj_maxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_MAX);
    
    // If next no has burst
    if (settingsObj_nextNo.propValue > settingsObj_maxNo.propValue)
    	return false;
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_maxNo.propValue).length;
    var nextNo = settingsObj_prefix.propValue + 
					tycheesText_leftPad(settingsObj_nextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextDeliveryOrderNo

/**
 * Update quotation number as current quotation number
 */ 
function consoleCommon_updateNextDeliveryOrderNo()
{
	var settingsObj_nextNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_NEXT);
    var settingsObj_maxNo    = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_MAX);
    
    // If next no has burst
    if (settingsObj_nextNo.propValue > settingsObj_maxNo.propValue)
    	return false;
    
    // Increment current number
    var newNextNo = Number(settingsObj_nextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextDeliveryOrderNo_postHandler, params);
} // .end of consoleCommon_updateNextDeliveryOrderNo

function consoleCommon_updateNextDeliveryOrderNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextDeliveryOrderNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextDeliveryOrderNo_postHandler');
	}
} // .end of consoleCommon_updateNextDeliveryOrderNo_postHandler

/**
 * Get next available customer no.
 */ 
function consoleCommon_getNextCustomerNo()
{
    var settingsObj_customerNoPrefix= Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_PREFIX);
    var settingsObj_customerMaxNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_MAX);
    var settingsObj_customerNextNo  = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_NEXT);
    
    // If next no has burst
    if (settingsObj_customerNextNo.propValue > settingsObj_customerMaxNo.propValue)
    	return false;
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_customerMaxNo.propValue).length;
    var nextNo = settingsObj_customerNoPrefix.propValue + 
					tycheesText_leftPad(settingsObj_customerNextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextCustomerNo

/**
 * Update receipt number as current receipt number
 */ 
function consoleCommon_updateNextCustomerNo()
{
    var settingsObj_customerMaxNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_MAX);
    var settingsObj_customerNextNo  = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_NEXT);
    
    // If next no has burst
    if (settingsObj_customerNextNo.propValue > settingsObj_customerMaxNo.propValue)
    	return false;
    
    // Increment current number
    var newNextNo = Number(settingsObj_customerNextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextCustomerNo_postHandler, params);
} // .end of consoleCommon_updateNextCustomerNo

function consoleCommon_updateNextCustomerNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextCustomerNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextCustomerNo_postHandler');
	}
} // .end of consoleCommon_updateNextCustomerNo_postHandler

/**
 * Get next available employee no.
 */ 
function consoleCommon_getNextEmployeeNo()
{
    var settingsObj_employeeNoPrefix= Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_PREFIX);
    var settingsObj_employeeMaxNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_MAX);
    var settingsObj_employeeNextNo  = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_NEXT);
    
    // If next no has burst
    if (settingsObj_employeeNextNo.propValue > settingsObj_employeeMaxNo.propValue)
    	return false;
    
    // Construct billing number PREFIX + NEXTNO
    var maxLength = String(settingsObj_employeeMaxNo.propValue).length;
    var nextNo = settingsObj_employeeNoPrefix.propValue + 
					tycheesText_leftPad(settingsObj_employeeNextNo.propValue, '0', maxLength);
	
	return nextNo;
} // .end of consoleCommon_getNextEmployeeNo

/**
 * Update receipt number as current receipt number
 */ 
function consoleCommon_updateNextEmployeeNo()
{
    var settingsObj_employeeMaxNo   = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_MAX);
    var settingsObj_employeeNextNo  = Cached_getSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_NEXT);
    
    // If next no has burst
    if (settingsObj_employeeNextNo.propValue > settingsObj_employeeMaxNo.propValue)
    	return false;
    
    // Increment current number
    var newNextNo = Number(settingsObj_employeeNextNo.propValue) + 1;
    
    //settingsObj_billingNextNo.propValue = String(newNextNo);
    Cached_setSettingsByKey(SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_NEXT, newNextNo.toString());
    tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
    
    // Prepare update place settings
    var requestBody = new Object();
    requestBody.propKey = SettingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_NEXT;
    requestBody.propValue = newNextNo.toString();
    
    var params = new Object();
    
    tycheesdb_api_updatePlaceSettings(requestBody, consoleCommon_updateNextEmployeeNo_postHandler, params);
} // .end of consoleCommon_updateNextEmployeeNo

function consoleCommon_updateNextEmployeeNo_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call Failure.', 'consoleCommon_updateNextEmployeeNo_postHandler');
	} else {
		tycheesLogger_logInfo('Ajax Call Success.', 'consoleCommon_updateNextEmployeeNo_postHandler');
	}
} // .end of consoleCommon_updateNextEmployeeNo_postHandler
