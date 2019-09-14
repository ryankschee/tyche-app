<!-- PRINT DIALOG -->
<div class="modal inmodal fade" id="mw010" tabindex="-1" role="dialog"  aria-hidden="true">
	<div id="mw010-01" class="modal-dialog modal-lg2" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">POS PRINT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
				    <div class="col-md-4">
				    	<div id="mw010_quotationButton" class="widget style1 lazur-bg" onclick="mw010_selectType('quotation');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Quotation</span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw010_fullOrderButton" class="widget style1 lazur-bg" onclick="mw010_selectType('fullOrder');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Internal Sheet</span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw010_salesInvoiceButton" class="widget style1 lazur-bg" onclick="mw010_selectType('sales_invoice');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Sales Invoice</span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw010_taxInvoiceButton" class="widget style1 lazur-bg" onclick="mw010_selectType('tax_invoice');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Tax Invoice</span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw010_receiptButton" class="widget style1 lazur-bg" onclick="mw010_selectType('receipt');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Receipt</span>
	                            </div>
	                        </div>
	                    </div>
					</div>
					<div class="col-md-8">
						<form role="form">
							<div class="form-group">
							    <div id="mw010_noUserInput" style="display:none;">No User Inputs Required</div> 
							    <div id="mw010_userInputs" style="display:none;">
							    </div>					
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw010_print();"><i class="fa fa-print"></i> Print Now</button>
			</div>
		</div>
	</div>
</div>
	
<script>

var mw010_initialized = false;
var mw010_documentType = '';
var mw010_documentObj;
var mw010_placeDocumentObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw010_isOpen()
{
	return ($("#mw010").data('bs.modal') || {}).isShown;	
} // .end of mw010_isOpen

/**
 * Initiate components/variables
 */
function mw010_init()
{
	if (mw010_initialized)
		return false;

	// On value changes - Print > Document Type
	$("#mw010_documentType").change(function() {
		refreshDocumentPreviewPane();
	});	
	
	mw010_initialized = true;
} // .end of mw010_init

function mw010_show()
{
	mw010_updateUI();
} // .end of mw010_show

/**
 * Initiate data into modal window.
 */
function mw010_updateUI()
{			
	mw010_init();
	
	// Reset state
	$('#document-preview-pane-css').html('');
	$('#document-preview-pane-content').html('');
	
	// Check if billing line exist
	if (global_billingObj.lineList.length == 0) {
		tycheesLogger_showToast("error", "Print not Ready", "Please insert item(s) before proceed to Print.");
		return false;
	}
	
	// Check document option
	var quotationAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_QUOTATION, 
								SettingsConstants.SETTINGS_POS_KEY_QUOTATION_ENABLED);
	var internalBillingAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_ORDER, 
								SettingsConstants.SETTINGS_POS_KEY_BILLING_ENABLED);
	var salesInvoiceAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_SALES_INVOICE, 
								SettingsConstants.SETTINGS_POS_KEY_INVOICE_ENABLED);
	var taxInvoiceAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_TAX_INVOICE, 
								SettingsConstants.SETTINGS_POS_KEY_INVOICE_ENABLED);
	var receiptAvailable = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT, 
								SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_ENABLED);
	
	// FOR QUOTATION MODE ONLY
	if (bil001_ctrl_isQuotationMode(global_billingObj)) 
	{
		if (quotationAvailable)
			$('#mw010_quotationButton').show();
		else
			$('#mw010_quotationButton').hide();			
		$('#mw010_fullOrderButton').hide();
		$('#mw010_salesInvoiceButton').hide();
		$('#mw010_taxInvoiceButton').hide();
		$('#mw010_receiptButton').hide();
	}
	else
	{
		if (bil001_ctrl_hasQuotationNumber(global_billingObj))
		{
			if (quotationAvailable)
				$('#mw010_quotationButton').show();
			else
				$('#mw010_quotationButton').hide();
			if (internalBillingAvailable)
				$('#mw010_fullOrderButton').show();
			else
				$('#mw010_fullOrderButton').hide();				
			if (salesInvoiceAvailable)
				$('#mw010_salesInvoiceButton').show();
			else
				$('#mw010_salesInvoiceButton').hide();			
			if (taxInvoiceAvailable)
				$('#mw010_taxInvoiceButton').show();
			else
				$('#mw010_taxInvoiceButton').hide();
			if (receiptAvailable)
				$('#mw010_receiptButton').show();
			else
				$('#mw010_receiptButton').hide();
		}
		else
		{
			$('#mw010_quotationButton').hide();
			if (internalBillingAvailable)
				$('#mw010_fullOrderButton').show();
			else
				$('#mw010_fullOrderButton').hide();
			if (salesInvoiceAvailable)
				$('#mw010_salesInvoiceButton').show();
			else
				$('#mw010_salesInvoiceButton').hide();
			if (taxInvoiceAvailable)
				$('#mw010_taxInvoiceButton').show();
			else
				$('#mw010_taxInvoiceButton').hide();
			if (receiptAvailable)
				$('#mw010_receiptButton').show();
			else
				$('#mw010_receiptButton').hide();
		}
	}
	
	module_showModalWindow('mw010', true);
} // .end of mw010_updateUI

/**
 * Event listener when user select document type on modal window.
 */
function mw010_selectType(documentType) {
	
	mw010_documentType = documentType;
		
	if ('quotation'==mw010_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedQuotationObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_TEMPLATE);
	    
	    var documentObj = Cached_getDocumentByCode(settingsObj_selectedQuotationObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw010_documentObj = documentObj;
	    	mw010_showUserInputs(documentObj);
	    }
	    
	    $('#mw010_quotationButton').addClass('red-bg');
	    $('#mw010_quotationButton').removeClass('lazur-bg');
	    $('#mw010_fullOrderButton').addClass('lazur-bg');
	    $('#mw010_fullOrderButton').removeClass('red-bg');
	    $('#mw010_salesInvoiceButton').addClass('lazur-bg');
	    $('#mw010_salesInvoiceButton').removeClass('red-bg');
	    $('#mw010_taxInvoiceButton').addClass('lazur-bg');
	    $('#mw010_taxInvoiceButton').removeClass('red-bg');
	    $('#mw010_receiptButton').addClass('lazur-bg');
	    $('#mw010_receiptButton').removeClass('red-bg');
	} 
	else
	if ('fullOrder'==mw010_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedFullOrderObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_FULL_TEMPLATE);
	    
		var documentObj = Cached_getDocumentByCode(settingsObj_selectedFullOrderObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw010_documentObj = documentObj;
	    	mw010_showUserInputs(documentObj);
	    }

	    $('#mw010_quotationButton').addClass('lazur-bg');
	    $('#mw010_quotationButton').removeClass('red-bg');
	    $('#mw010_fullOrderButton').addClass('red-bg');
	    $('#mw010_fullOrderButton').removeClass('lazur-bg');
	    $('#mw010_salesInvoiceButton').addClass('lazur-bg');
	    $('#mw010_salesInvoiceButton').removeClass('red-bg');
	    $('#mw010_taxInvoiceButton').addClass('lazur-bg');
	    $('#mw010_taxInvoiceButton').removeClass('red-bg');
	    $('#mw010_receiptButton').addClass('lazur-bg');
	    $('#mw010_receiptButton').removeClass('red-bg');
	}
	else
	if ('invoice'==mw010_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedInvoiceObj	= Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_INVOICE_TEMPLATE);
	    
	    var documentObj = Cached_getDocumentByCode(settingsObj_selectedInvoiceObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw010_documentObj = documentObj;
	    	mw010_showUserInputs(documentObj);
	    }
	    
	    $('#mw010_quotationButton').addClass('lazur-bg');
	    $('#mw010_quotationButton').removeClass('red-bg');
	    $('#mw010_fullOrderButton').addClass('lazur-bg');
	    $('#mw010_fullOrderButton').removeClass('red-bg');
	    $('#mw010_salesInvoiceButton').addClass('red-bg');
	    $('#mw010_salesInvoiceButton').removeClass('lazur-bg');
	    $('#mw010_taxInvoiceButton').addClass('red-bg');
	    $('#mw010_taxInvoiceButton').removeClass('lazur-bg');
	    $('#mw010_receiptButton').addClass('lazur-bg');
	    $('#mw010_receiptButton').removeClass('red-bg');
	} 
	else
	if ('receipt'==mw010_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedReceiptObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_TEMPLATE);
	    
		var documentObj = Cached_getDocumentByCode(settingsObj_selectedReceiptObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw010_documentObj = documentObj;
	    	mw010_showUserInputs(documentObj);
	    }

	    $('#mw010_quotationButton').addClass('lazur-bg');
	    $('#mw010_quotationButton').removeClass('red-bg');
	    $('#mw010_fullOrderButton').addClass('lazur-bg');
	    $('#mw010_fullOrderButton').removeClass('red-bg');
	    $('#mw010_salesInvoiceButton').addClass('lazur-bg');
	    $('#mw010_salesInvoiceButton').removeClass('red-bg');
	    $('#mw010_taxInvoiceButton').addClass('lazur-bg');
	    $('#mw010_taxInvoiceButton').removeClass('red-bg');
	    $('#mw010_receiptButton').addClass('red-bg');
	    $('#mw010_receiptButton').removeClass('lazur-bg');
	}
} // .end of mw010_selectType

function mw010_showUserInputs(documentObj)
{
	// Resets
	$('#mw010_userInputs').empty();
	
	var userInputCount = 0;
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	    	
	$.each(placeObj.documentList, function(i, placeDocObj){
		if (placeDocObj.documentId == documentObj.id)
		{
			mw010_placeDocumentObj = placeDocObj;
			$.each(placeDocObj.propertiesList, function(j, propObj){
				if (propObj.requireInputFromUser)
				{
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT)
					{
						// Get default value for user input, if any.
						propObj.userInput = mw010_getUserInputFromBillingBean(propObj, '');
							
						var htmlLines = '';
    					htmlLines += '<label class="font-normal">';
    					htmlLines += propObj.propName;
    					htmlLines += '</label>';
    					htmlLines += '<input id="' + propObj.id + '" type="text" class="form-control" value="' + propObj.userInput + '">';
    					htmlLines += '<br>';
    					
    					$('#mw010_userInputs').append(htmlLines);
    					userInputCount++;

    					$('#'+propObj.id).on('input change propertychange paste', function() {
    						propObj.userInput = $('#'+propObj.id).val();
    			        });
					}
					else
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT_AREA)
					{
						propObj.userInput = '';
					}
					else
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT_NUMER)
					{
						propObj.userInput = 0;
					}
					else
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_DATE)
					{
						// Get default value for user input, if any.
						propObj.userInput = mw010_getUserInputFromBillingBean(propObj, '');
				    	
    					var htmlLines = '';
    					htmlLines += '<label class="font-normal">';
    					htmlLines += propObj.propName;
    					htmlLines += '</label>';
    					htmlLines += '<input id="' + propObj.id + '" type="text" class="form-control" data-mask="99/99/9999" placeholder="dd/mm/yyyy" value="' + propObj.userInput + '">';
						htmlLines += '<label style="padding-left:10px; font-size:12px; font-weight:normal;">format: dd/mm/yyyy</label>';
						htmlLines += '<label style="padding-left:10px; font-size:12px; font-weight:normal; color:#FF0000; display:none;">Invalid date format.</label>';
    					htmlLines += '<br>';
    					
    					$('#mw010_userInputs').append(htmlLines);
    					userInputCount++;

    					$('#'+propObj.id).on('input change propertychange paste', function() {
    						var userInputVal = $.trim($('#'+propObj.id).val());
    						if (tycheesDateTime_isValidDate_ddmmyyyy(userInputVal)) {
    							propObj.userInput = userInputVal;
    							$( $(this).children()[1] ).hide();
    						} else {
    							$( $(this).children()[1] ).show();
    						}
    							
    			        });
					}
					else
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT_BOOLEAN)
					{
						
					}
					else
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT_SELECT)
					{
						
					}
					else
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT_SELECT_MULTIPLE)
					{
						
					}
				}
			});
		}
	});
	
	if (userInputCount > 0) {
		$('#mw010_userInputs').show();
		$('#mw010_noUserInput').hide();
	} else {
		$('#mw010_userInputs').hide();
		$('#mw010_noUserInput').show();
	}
} // .end of mw010_showUserInputs

function mw010_getUserInputFromBillingBean(propObj, defaultVal)
{
	if (propObj.propKey == '$_CUSTOMER_NAME_$') {
		return global_billingObj.customerName;
	}
	
	if (propObj.propKey == '$_BILLING_INVOICE_DATE_$') {
		if ($.trim(propObj.propValue)=='') {
			return '';
		} else {
			if (propObj.propValue=='TODAY')
				return tycheesDateTime_getFormattedDate_ddMMyyyy( (new Date()).getTime() );
			else
				return propObj.propValue;
		}
	}
	
	return defaultVal;
} // mw010_getUserInputFromBillingBean

function mw010_print()
{	
	if (mw010_documentType == 'invoice') 
	{
		if (global_billingObj.invoiceNo == null || global_billingObj.invoiceNo == '') 
		{
			global_billingObj.invoiceNo = consoleCommon_getNextInvoiceNo();
			global_billingObj.invoiceDate = tycheesDateTime_getCurrentTimeInMillis();
			
			consoleCommon_updateNextInvoiceNo();
		}
	}
	
	if (mw010_documentType == 'receipt') 
	{
		if (global_billingObj.receiptNo == null || global_billingObj.receiptNo == '') 
		{
			global_billingObj.receiptNo = consoleCommon_getNextReceiptNo();
			global_billingObj.receiptDate = tycheesDateTime_getCurrentTimeInMillis();
			
			consoleCommon_updateNextPaymentReceiptNo();
		}
	}
	
	if (mw010_documentType == 'fullOrder') 
	{
		// do nothing
	}
	
	// Get PDF doc
	var pdfDoc = documentCommon_getPDF(mw010_documentObj, mw010_placeDocumentObj, Cached_userObj, global_billingObj);
	pdfDoc.autoPrint();	
   	pdfDoc.output('dataurlnewwindow');
	
	// Auto-save Billing
	bil001_ctrl_saveBilling();
} // .end of mw010_print

</script>