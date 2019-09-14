
<!-- 
	PRINT DIALOG WIZARD for POS
-->
<div class="modal inmodal fade" id="mw_printWizard" tabindex="-1" role="dialog"  aria-hidden="true">
	<div id="mw_printWizard-01" class="modal-dialog modal-lg4" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">POS PRINT WIZARD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
				    <div class="col-md-3">
				    	<div id="mw_printWizard_quotationButton" class="doc-button widget style1 lazur-bg" onclick="mw_printWizard_selectType('quotation');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Quotation</span>
	                                <br>
	                                <span id="mw_printWizard_quotationNo" class="font-bold" style="font-size:12pt; color:#333333;"></span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw_printWizard_internalOrderButton" class="doc-button widget style1 lazur-bg" onclick="mw_printWizard_selectType('internalOrder');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Internal Order</span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw_printWizard_salesInvoiceButton" class="doc-button widget style1 lazur-bg" onclick="mw_printWizard_selectType('sales_invoice');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Sales Invoice</span>
	                                <br>
	                                <span id="mw_printWizard_salesInvoiceNo" class="font-bold" style="font-size:12pt; color:#333333;"></span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw_printWizard_taxInvoiceButton" class="doc-button widget style1 lazur-bg" onclick="mw_printWizard_selectType('tax_invoice');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Tax Invoice</span>
	                                <br>
	                                <span id="mw_printWizard_taxInvoiceNo" class="font-bold" style="font-size:12pt; color:#333333;"></span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw_printWizard_receiptButton" class="doc-button widget style1 lazur-bg" onclick="mw_printWizard_selectType('receipt');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Receipt</span>
	                                <br>
	                                <span id="mw_printWizard_receiptNo" class="font-bold" style="font-size:12pt; color:#333333;"></span>
	                            </div>
	                        </div>
	                    </div>
					</div>
					<div class="col-md-9">
						<form role="form">
							<div class="form-group">
							    <div id="mw_printWizard_noDocumentFound" style="display:none;">
							    	<div style="font-size: 12pt; color: #F00;">No document found</div>
							    	<div style="font-size: 12pt;">Please go to Settings > Document to create document template.</div>
							    </div> 
							    
							    <div id="mw_printWizard_noUserInput" style="display:none;">No User Inputs Required</div> 
							    
							    <div id="mw_printWizard_defaultInputs" style="display:none; padding-top:5px;">
							    	<div class="form-group">
							    		<label class="col-md-3 control-label">Print Itemized:</label>
	                                    <div class="col-md-9">
	                                    	<label class="checkbox-inline i-checks"> 
		                                    	<div class="icheckbox_square-green" style="position: relative;">
			                                    	<input type="checkbox" id="mw_printWizard_defaultInputs_itemizedRemarks" style="position: absolute; opacity: 0;">			                                    	
		                                    	</div>
		                                    	Remarks
	                                    	</label>	                                        
		                                </div>
								    </div>
								    <div class="form-group">
							    		<!-- label class="col-md-3 control-label">Print Itemized Components</label-->
	                                    <div class="col-md-9">
	                                    	<label class="checkbox-inline i-checks"> 
		                                    	<div class="icheckbox_square-green" style="position: relative;">
			                                    	<input type="checkbox" id="mw_printWizard_defaultInputs_itemizedComponents" style="position: absolute; opacity: 0;">			                                    	
		                                    	</div> 
		                                    	Components
	                                    	</label>	                                        
		                                </div>
								    </div>
							    </div>
							    <div id="mw_printWizard_userInputs" style="display:none; padding-top:5px;"></div>					
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="mw_printWizard_closeButton" type="button" class="btn btn-danger" data-dismiss="modal" onclick="">
					Close
				</button>
				<button id="mw_printWizard_printButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_printWizard_print();">
					<i class="fa fa-print"></i> Print Now
				</button>
			</div>
		</div>
	</div>
</div>
	
<script>

var mw_printWizard_initialized = false;
var mw_printWizard_documentType = '';
var mw_printWizard_placeDocumentTemplateObj;

var mw_printWizard_documentObj;
var mw_printWizard_placeDocumentObj;

var mw_printWizard_userInput_customerName;
var mw_printWizard_userInput_invoiceDate;
var mw_printWizard_userInput_quotationDate;

var mw_printWizard_internalOrderTemplateReady = false;
var mw_printWizard_quotationTemplateReady = false;
var mw_printWizard_salesInvoiceTemplateReady = false;
var mw_printWizard_taxInvoiceTemplateReady = false;
var mw_printWizard_receiptTemplateReady = false;

function mw_printWizard_isOpen()
{
	return ($("#mw_printWizard").data('bs.modal') || {}).isShown;	
} // .end of mw_printWizard_isOpen

function mw_printWizard_init()
{
	if (mw_printWizard_initialized)
		return false;
	
	mw_printWizard_initialized = true;
} // .end of mw_printWizard_init

function mw_printWizard_show() 
{
	mw_printWizard_updateUI();
} // .end of mw_printWizard_show

function mw_printWizard_updateUI()
{			
	// Check if billing line exist
	if (global_billingObj.lineList.length == 0) {
		tycheesLogger_showToast("error", "Print not Ready", "Please insert item(s) before proceed to Print.");
		return false;
	}
	
	mw_printWizard_init();
	
	// Reset checkboxes
	$('#mw_printWizard_defaultInputs_itemizedRemarks').iCheck('uncheck');
	$('#mw_printWizard_defaultInputs_itemizedComponents').iCheck('uncheck');
		
	// Reset state
	$('#mw_printWizard_noDocumentFound').hide();
	$('#mw_printWizard_noUserInput').hide();
	$('#mw_printWizard_defaultInputs').hide();
	$('#mw_printWizard_userInputs').hide();
	
	$('#document-preview-pane-css').html('');
	$('#document-preview-pane-content').html('');
	
	$('#mw_printWizard_noUserInput').hide();
	$('#mw_printWizard_defaultInputs').hide();
	$('#mw_printWizard_userInputs').hide();
	$('#mw_printWizard_userInputs').html('');

	$('.doc-button').addClass('lazur-bg');
	$('.doc-button').removeClass('red-bg');
    
 	// Get Place Object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Get document template
    $.each(placeObj.documentTemplateList, function(i, templateObj) {
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	if (templateObj.templateType == 'internal')
    		mw_printWizard_internalOrderTemplateReady = true;
    	if (templateObj.templateType == 'quotation')
    		mw_printWizard_quotationTemplateReady = true;
    	if (templateObj.templateType == 'sales_invoice')
    		mw_printWizard_salesInvoiceTemplateReady = true;
    	if (templateObj.templateType == 'tax_invoice')
    		mw_printWizard_taxInvoiceTemplateReady = true;
    	if (templateObj.templateType == 'receipt')
    		mw_printWizard_receiptTemplateReady = true;
    });
    
	if (mw_printWizard_internalOrderTemplateReady) {
		$('#mw_printWizard_internalOrderButton').show();
	} else {
		$('#mw_printWizard_internalOrderButton').hide();
	    $('#mw_printWizard_internalOrderButton').addClass('gray-bg');
	    $('#mw_printWizard_internalOrderButton').removeClass('red-bg');
	    $('#mw_printWizard_internalOrderButton').removeClass('lazur-bg');
	} 
		
	if (mw_printWizard_quotationTemplateReady) {
		$('#mw_printWizard_quotationButton').show();
		var quotationNo = '';
		if ($.trim(global_billingObj.quotationNo)=='') {
			quotationNo = consoleCommon_getNextQuotationNo();
		} else {
			quotationNo = $.trim(global_billingObj.quotationNo);
		}	
		$('#mw_printWizard_quotationNo').html(quotationNo);
	} else {
	    $('#mw_printWizard_quotationButton').hide();
	    $('#mw_printWizard_quotationButton').addClass('gray-bg');
	    $('#mw_printWizard_quotationButton').removeClass('red-bg');
	    $('#mw_printWizard_quotationButton').removeClass('lazur-bg');
	}

	if (mw_printWizard_salesInvoiceTemplateReady) {
		$('#mw_printWizard_salesInvoiceButton').show();
		$('#mw_printWizard_salesInvoiceNo').html( $.trim(global_billingObj.billingNo) );
	} else {
	    $('#mw_printWizard_salesInvoiceButton').hide();
	    $('#mw_printWizard_salesInvoiceButton').addClass('gray-bg');
	    $('#mw_printWizard_salesInvoiceButton').removeClass('red-bg');
	    $('#mw_printWizard_salesInvoiceButton').removeClass('lazur-bg');
	}

	if (mw_printWizard_taxInvoiceTemplateReady) {
		// In Quotation mode
		if ($.trim(global_billingObj.quotationNo) != '' && $.trim(global_billingObj.billingNo) == '') {
			$('#mw_printWizard_taxInvoiceButton').hide();
		} else {
			$('#mw_printWizard_taxInvoiceButton').show();
			var invoiceNo = '';
			if ($.trim(global_billingObj.invoiceNo)=='') {
				invoiceNo = consoleCommon_getNextInvoiceNo();
			} else {
				invoiceNo = $.trim(global_billingObj.invoiceNo);
			}	
			$('#mw_printWizard_taxInvoiceNo').html(invoiceNo);
		}		
	} else {
		$('#mw_printWizard_taxInvoiceButton').hide();
		$('#mw_printWizard_taxInvoiceButton').addClass('gray-bg');
	    $('#mw_printWizard_taxInvoiceButton').removeClass('red-bg');
	    $('#mw_printWizard_taxInvoiceButton').removeClass('lazur-bg');
	}

	if (mw_printWizard_receiptTemplateReady) {
		$('#mw_printWizard_receiptButton').show();
		var receiptNo = '';
		if ($.trim(global_billingObj.receiptNo)=='') {
			receiptNo = consoleCommon_getNextReceiptNo();
		} else {
			receiptNo = $.trim(global_billingObj.receiptNo);
		}	
		$('#mw_printWizard_receiptNo').html(receiptNo);
	} else {
		$('#mw_printWizard_receiptButton').hide();
		$('#mw_printWizard_receiptButton').addClass('gray-bg');
	    $('#mw_printWizard_receiptButton').removeClass('red-bg');
	    $('#mw_printWizard_receiptButton').removeClass('lazur-bg');
	}

	module_showModalWindow('mw_printWizard', true);
} // .end of mw_printWizard_updateUI

/**
 * Event listener when user select document type on modal window.
 */
function mw_printWizard_selectType(documentType) {
	
	mw_printWizard_documentType = documentType;
	mw_printWizard_placeDocumentTemplateObj = null;
		
	if ('quotation'==mw_printWizard_documentType && mw_printWizard_quotationTemplateReady) 
	{	    
		$('.doc-button').addClass('lazur-bg');
		$('.doc-button').removeClass('red-bg');
		
		$('#mw_printWizard_quotationButton').addClass('red-bg');
	    $('#mw_printWizard_quotationButton').removeClass('lazur-bg');
	    
		// Get preset default template
	    var defaultQuotationObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_TEMPLATE);
	    // Get Place Object
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    // Get document template
	    $.each(placeObj.documentTemplateList, function(i, templateObj) {
	    	if (Cached_isDeletedBean(templateObj))
	    		return true;
	    	if (templateObj.id == defaultQuotationObj.propValue)   
	    		mw_printWizard_placeDocumentTemplateObj = templateObj;
	    });
	} 
	else
	if ('internalOrder'==mw_printWizard_documentType && mw_printWizard_internalOrderTemplateReady) 
	{
		$('.doc-button').addClass('lazur-bg');
		$('.doc-button').removeClass('red-bg');
		
		$('#mw_printWizard_internalOrderButton').addClass('red-bg');
	    $('#mw_printWizard_internalOrderButton').removeClass('lazur-bg');
	    
		// Get preset default template
	    var defaultInternalOrderObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_FULL_TEMPLATE);
	    // Get Place Object
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    // Get document template
	    $.each(placeObj.documentTemplateList, function(i, templateObj) {
	    	if (Cached_isDeletedBean(templateObj))
	    		return true;
	    	if (templateObj.id == defaultInternalOrderObj.propValue)   
	    		mw_printWizard_placeDocumentTemplateObj = templateObj;
	    });	    
	}
	else
	if ('sales_invoice'==mw_printWizard_documentType && mw_printWizard_salesInvoiceTemplateReady) 
	{
		$('.doc-button').addClass('lazur-bg');
		$('.doc-button').removeClass('red-bg');
		
		$('#mw_printWizard_salesInvoiceButton').addClass('red-bg');
	    $('#mw_printWizard_salesInvoiceButton').removeClass('lazur-bg');
	    
		// Get preset default template
	    var defaultInvoiceObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_SALES_INVOICE_TEMPLATE);
	    // Get Place Object
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    // Get document template
	    $.each(placeObj.documentTemplateList, function(i, templateObj) {
	    	if (Cached_isDeletedBean(templateObj))
	    		return true;
	    	if (templateObj.id == defaultInvoiceObj.propValue)   
	    		mw_printWizard_placeDocumentTemplateObj = templateObj;
	    });
	}
	else
	if ('tax_invoice'==mw_printWizard_documentType && mw_printWizard_taxInvoiceTemplateReady) 
	{
		$('.doc-button').addClass('lazur-bg');
		$('.doc-button').removeClass('red-bg');
		
		$('#mw_printWizard_taxInvoiceButton').addClass('red-bg');
	    $('#mw_printWizard_taxInvoiceButton').removeClass('lazur-bg');
	    
		// Get preset default template
	    var defaultInvoiceObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_TEMPLATE);
	    // Get Place Object
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    // Get document template
	    $.each(placeObj.documentTemplateList, function(i, templateObj) {
	    	if (Cached_isDeletedBean(templateObj))
	    		return true;
	    	if (templateObj.id == defaultInvoiceObj.propValue)   
	    		mw_printWizard_placeDocumentTemplateObj = templateObj;
	    });
	} 
	else
	if ('receipt'==mw_printWizard_documentType && mw_printWizard_receiptTemplateReady) 
	{
		$('.doc-button').addClass('lazur-bg');
		$('.doc-button').removeClass('red-bg');
		
		$('#mw_printWizard_receiptButton').addClass('red-bg');
	    $('#mw_printWizard_receiptButton').removeClass('lazur-bg');
	    
		// Get preset default template
	    var defaultReceiptObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_TEMPLATE);
	    // Get Place Object
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    // Get document template
	    $.each(placeObj.documentTemplateList, function(i, templateObj) {
	    	if (Cached_isDeletedBean(templateObj))
	    		return true;
	    	if (templateObj.id == defaultReceiptObj.propValue)   
	    		mw_printWizard_placeDocumentTemplateObj = templateObj;
	    });    
	}
    
	if (mw_printWizard_placeDocumentTemplateObj == null) {
		$('#mw_printWizard_noDocumentFound').show();
		$('#mw_printWizard_defaultInputs').hide();
		$('#mw_printWizard_userInputs').hide();
	} else {
		$('#mw_printWizard_noDocumentFound').hide();
    	mw_printWizard_showUserInputs(mw_printWizard_placeDocumentTemplateObj);
	}
} // .end of mw_printWizard_selectType

function mw_printWizard_showUserInputs(documentTemplateObj)
{
	$('#mw_printWizard_userInputs').empty();
	
	var userInputCount = 0;
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	$.each(documentTemplateObj.componentList, function(i, componentObj) {
		if (Cached_isDeletedBean(componentObj))
			return true;
		
		var attributesObj = JSON.parse(componentObj.attributes);
		if (attributesObj.requireUserInput) {
			var htmlLines = mw_printWizard_getInputComponent(componentObj);

			$('#mw_printWizard_userInputs').append(htmlLines);
			userInputCount++;
		}
	});
	
	if (userInputCount == 0) {
		$('#mw_printWizard_noUserInput').show();
		$('#mw_printWizard_defaultInputs').hide();
		$('#mw_printWizard_userInputs').hide();
	} else {
		$('.datepicker-field .input-group.date').datepicker({
            todayBtn: "linked",
            keyboardNavigation: false,
            forceParse: false,
            calendarWeeks: true,
            autoclose: true
        });
		
		$('.error-msg').hide();
		$('#mw_printWizard_defaultInputs').show();
		$('#mw_printWizard_userInputs').show();
	}
} // .end of mw_printWizard_showUserInputs

function mw_printWizard_getInputComponent(templateComponentObj)
{
	var attributesObj = JSON.parse(templateComponentObj.attributes);
	if (!attributesObj.requireUserInput) 
		return '';
	
	if (templateComponentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {

		var billingAttributesStr = $.trim(global_billingObj.attributes);
		var billingAttributesObj = new Object();
		if (billingAttributesStr != '')
			billingAttributesObj = JSON.parse(billingAttributesStr);
		
		var componentTextVal = $.trim(billingAttributesObj[templateComponentObj.name]);
		
		var textVal = attributesObj.text;		
		if (componentTextVal != '') {
			textVal = componentTextVal;
		}
		
		var htmlLines = '';
		htmlLines += '<div class="form-group" style="height:160px;">';
		htmlLines += '<label class="col-md-12 font-normal" style="padding-left:15px;font-weight:bold;">' + templateComponentObj.name + '</label>';
		htmlLines += '<div class="col-md-12" style="height:100%;">';
		htmlLines += '<textarea id="' + templateComponentObj.id + '" rows="4" cols="50" class="form-control" style="height:100%;">' + textVal + '</textarea>';
		htmlLines += '<span id="' + templateComponentObj.id + '_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		
		return htmlLines;
	}
	
	if (attributesObj.fieldType == 'customer.name') {
		
		//var billingAttributesStr = $.trim(global_billingObj.attributes);
		//var billingAttributesObj = new Object();
		//if (billingAttributesStr != '')
		//	billingAttributesObj = JSON.parse(billingAttributesStr);
		
		//var textVal = $.trim(billingAttributesObj[templateComponentObj.name]);
		
		var textVal = global_billingObj.customerName;
		
		var htmlLines = '';
		htmlLines += '<div class="form-group" style="height:100%;">';
		htmlLines += '<label class="col-md-12 font-normal" style="padding-left:15px;font-weight:bold;">Customer Name</label>';
		htmlLines += '<div class="col-md-12" style="height:100%;">';
		htmlLines += '<input id="' + templateComponentObj.id + '" type="text" class="form-control" style="width:100%;" value="' + textVal + '">';
		htmlLines += '<span id="' + templateComponentObj.id + '_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		
		return htmlLines;
	}
	
	if (attributesObj.fieldType == 'billing.billingDate') {
		
		var inputValue = '';
		if (global_billingObj.billingDate != null)
			inputValue = tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.billingDate);
		else
			inputValue = tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis());
		
		var htmlLines = '';		
		htmlLines += '<div class="form-group datepicker-field">';
		htmlLines += '<label class="col-md-12 font-normal">Invoice Date (dd/mm/yyyy)</label>';
		htmlLines += '<div class="input-group date">';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<i class="fa fa-calendar"></i>';
		htmlLines += '</span>';
		htmlLines += '<input id="' + templateComponentObj.id + '" type="text" class="form-control" value="' + inputValue + '" data-mask="99/99/9999">';
		htmlLines += '</div>';
		htmlLines += '<span id="' + templateComponentObj.id + '-error" class="error-msg" style="color:#F00;">Invalid Date Value</span>';
		htmlLines += '</div>';
		
		return htmlLines;
	}
	
	if (attributesObj.fieldType == 'billing.invoiceDate') {
		
		var inputValue = '';
		if (global_billingObj.invoiceDate != null)
			inputValue = tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.invoiceDate);
		else
			inputValue = tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis());
		
		var htmlLines = '';		
		htmlLines += '<div class="form-group datepicker-field">';
		htmlLines += '<label class="col-md-12 font-normal">Invoice Date (dd/mm/yyyy)</label>';
		htmlLines += '<div class="input-group date">';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<i class="fa fa-calendar"></i>';
		htmlLines += '</span>';
		htmlLines += '<input id="' + templateComponentObj.id + '" type="text" class="form-control" value="' + inputValue + '" data-mask="99/99/9999">';
		htmlLines += '</div>';
		htmlLines += '<span id="' + templateComponentObj.id + '-error" class="error-msg" style="color:#F00;">Invalid Date Value</span>';
		htmlLines += '</div>';
		
		return htmlLines;
	}

	if (attributesObj.fieldType == 'billing.quotationDate') {
		var inputValue = '';
		if (global_billingObj.quotationDate != null)
			inputValue = tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.quotationDate);
		
		var htmlLines = '';		
		htmlLines += '<div class="form-group datepicker-field">';
		htmlLines += '<label class="col-md-12 font-normal">Quotation Date (dd/mm/yyyy)</label>';
		htmlLines += '<div class="input-group date">';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<i class="fa fa-calendar"></i>';
		htmlLines += '</span>';
		htmlLines += '<input id="' + templateComponentObj.id + '" type="text" class="form-control" value="' + inputValue + '" data-mask="99/99/9999">';
		htmlLines += '</div>';
		htmlLines += '<span id="' + templateComponentObj.id + '-error" class="error-msg" style="color:#F00;">Invalid Date Value</span>';
		htmlLines += '</div>';
		
		return htmlLines;
	}	
} // .end of mw_printWizard_getInputComponent

function mw_printWizard_print()
{	
	// Save text-typed value into billingObj.attributes
	$.each(mw_printWizard_placeDocumentTemplateObj.componentList, function(i, componentObj) {
		if (Cached_isDeletedBean(componentObj))
			return true;
				
		var attributesObj = JSON.parse(componentObj.attributes);
		if (!attributesObj.requireUserInput) 
			return true;

		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {
			var textVal = $('#' + componentObj.id).val();
			var billingAttributesStr = $.trim(global_billingObj.attributes);
			var billingAttributesObj = new Object();
			if (billingAttributesStr != '')
				billingAttributesObj = JSON.parse(billingAttributesStr);
			
			billingAttributesObj[componentObj.name] = textVal;
			
			global_billingObj.attributes = JSON.stringify(billingAttributesObj);
		}
		
		if (attributesObj.fieldType == 'customer.name') {
			var textVal = $('#' + componentObj.id).val();
			var billingAttributesStr = $.trim(global_billingObj.attributes);
			var billingAttributesObj = new Object();
			if (billingAttributesStr != '')
				billingAttributesObj = JSON.parse(billingAttributesStr);
			
			billingAttributesObj[componentObj.name] = textVal;
			
			global_billingObj.attributes = JSON.stringify(billingAttributesObj);
		}
	});
		
	if (mw_printWizard_placeDocumentTemplateObj == null) {
		// Show alert
		swal(
			'Oops', 
			'Please go to Settings > Documents, and setup document for type ' + mw_printWizard_documentType, 
			'error');

		// Stop progress, if any
		$('#mw_printWizard_printButton').ladda().ladda('stop');
		
		return false;
	}
		
	if (mw_printWizard_documentType == 'internalOrder') 
	{
		// do nothing
	}
	
	if (mw_printWizard_documentType == 'quotation') 
	{
		// Show progress
		$('#mw_printWizard_printButton').ladda().ladda('start');
		
		var validUserInputs = true;
		$.each(mw_printWizard_placeDocumentTemplateObj.componentList, function(i, componentObj) {
			if (Cached_isDeletedBean(componentObj))
				return true;
			
			var attributesObj = JSON.parse(componentObj.attributes);
			if (!attributesObj.requireUserInput) 
				return true;

			if (attributesObj.fieldType == 'billing.quotationDate') {
				var quotationDate = $('#'+componentObj.id).val();
				if (tycheesDateTime_isValidDate_ddmmyyyy(quotationDate)==false) {
					validUserInputs = false;
					$('#'+componentObj.id+'-error').show();
				} else {
					global_billingObj.quotationDate = 
						tycheesDateTime_toMilliseconds_ddMMyyyy(quotationDate);
				}
			}
		});

		if (validUserInputs) {
			if ($.trim(global_billingObj.quotationNo) == '') {
				// Assign Invoice Number
				global_billingObj.quotationNo = consoleCommon_getNextQuotationNo();
				// Update Invoice Number
				consoleCommon_updateNextQuotationNo();
			}
		} else {
			// Show progress
			$('#mw_printWizard_printButton').ladda().ladda('stop');
			
			return false;
		}
	}

	if (mw_printWizard_documentType == 'sales_invoice') 
	{
		// Show progress
		$('#mw_printWizard_printButton').ladda().ladda('start');
		
		var validUserInputs = true;
		if (validUserInputs) {
			
		} else {
			// Show progress
			$('#mw_printWizard_printButton').ladda().ladda('stop');
			
			return false;
		}
	}
	
	if (mw_printWizard_documentType == 'tax_invoice') 
	{
		// Show progress
		$('#mw_printWizard_printButton').ladda().ladda('start');
		
		var validUserInputs = true;
		$.each(mw_printWizard_placeDocumentTemplateObj.componentList, function(i, componentObj) {
			if (Cached_isDeletedBean(componentObj))
				return true;
			
			var attributesObj = JSON.parse(componentObj.attributes);
			if (!attributesObj.requireUserInput) 
				return true;

			if (attributesObj.fieldType == 'billing.invoiceDate') {
				var invoiceDate = $('#'+componentObj.id).val();
				if (tycheesDateTime_isValidDate_ddmmyyyy(invoiceDate)==false) {
					validUserInputs = false;
					$('#'+componentObj.id+'-error').show();
				} else {
					global_billingObj.invoiceDate = 
						tycheesDateTime_toMilliseconds_ddMMyyyy(invoiceDate);
				}
			}
		});

		if (validUserInputs) {
			if ($.trim(global_billingObj.invoiceNo) == '') {
				// Assign Invoice Number
				global_billingObj.invoiceNo = consoleCommon_getNextInvoiceNo();
				// Update Invoice Number
				consoleCommon_updateNextInvoiceNo();
			}
		} else {
			// Show progress
			$('#mw_printWizard_printButton').ladda().ladda('stop');
			
			return false;
		}
	}
	
	if (mw_printWizard_documentType == 'receipt') 
	{
		if ($.trim(global_billingObj.receiptNo) == '') 
		{
			global_billingObj.receiptNo = consoleCommon_getNextReceiptNo();
			global_billingObj.receiptDate = tycheesDateTime_getCurrentTimeInMillis();
			
			consoleCommon_updateNextPaymentReceiptNo();
		}
	}

   	// Auto-save Billing
	bil001_menuPanel_save();
	
   	// Check if print itemized remarks / components
   	var printRemarks = $('#mw_printWizard_defaultInputs_itemizedRemarks').prop('checked');
   	var printComponents = $('#mw_printWizard_defaultInputs_itemizedComponents').prop('checked');
   	
	documentProcessor_preview_preload(
			mw_printWizard_print_callback,
			mw_printWizard_placeDocumentTemplateObj,
			global_billingObj,
			printRemarks,
			printComponents);
} // .end of mw_printWizard_print

function mw_printWizard_print_callback(pdfDoc)
{
	// Show progress
	$('#mw_printWizard_printButton').ladda().ladda('stop');
		
	if (tycheesCommon_isMobileDevice()) {
		pdfDoc.output('dataurlnewwindow');
	}
	else {
	  debugBase64(pdfDoc);
		//mw_pdfPreview_show(pdfDoc.output('datauri'), 'mw_printWizard');
	}
} // .end of mw_printWizard_print_callback

function debugBase64(base64URL) {
    var win = window.open();
    win.document.write('<iframe src="' + base64URL  + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>');
}
</script>