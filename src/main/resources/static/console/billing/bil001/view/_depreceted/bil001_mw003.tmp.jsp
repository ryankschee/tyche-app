<!-- PRINT DIALOG -->
<div class="modal inmodal fade" id="mw003" tabindex="-1" role="dialog"  aria-hidden="true">
	<div id="mw003-01" class="modal-dialog modal-xxl" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="display:none;">
				<span class="modal-title">PRINTING</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
				    <div class="col-md-2">
						<form role="form">
							<div class="form-group">
							    <label>Select Document Types</label> 
							    <br>
							    <button id="mw003_quotationButton" type="button" class="btn btn-info" style="width:100%;margin-bottom:10px;" onclick="mw003_selectType('quotation');">
							    	Quotation
							    </button>
							    <br>
							    <button id="mw003_fullOrderButton" type="button" class="btn btn-info" style="width:100%;margin-bottom:10px;" onclick="mw003_selectType('fullOrder');">
							    	For Internal
							    </button>
							    <br>
							    <button id="mw003_invoiceButton" type="button" class="btn btn-info" style="width:100%;margin-bottom:10px;" onclick="mw003_selectType('invoice');">
							    	Invoice
							    </button>
							    <br>
							    <button id="mw003_receiptButton" type="button" class="btn btn-info" style="width:100%;margin-bottom:10px;" onclick="mw003_selectType('receipt');">
							    	Receipt
							    </button>
							    <br>
							    <br>
							    <br>
							    <button type="button" class="btn btn-primary" style="width:100%;" onclick="mw003_print();">
							    	<i class="fa fa-print"></i> Print Document
							    </button>
							    <br>
							    <br>
							    <button type="button" class="btn btn-danger" style="width:100%;" data-dismiss="modal">Close</button>								
							</div>
						</form>
					</div>
					<div class="col-md-2">
						<form role="form">
							<div class="form-group">
							    <label>Adjustable Inputs</label> 
							    <br>			
							    <div id="mw003_userInputs">
							    </div>					
							</div>
						</form>
					</div>
					<div class="col-md-8">
						<!-- iframe class="preview-pane" type="application/pdf" width="100%" height="650" frameborder="0" style="position:relative;z-index:999"></iframe-->
						<div class="ibox" id="document-preview-pane">	
    						<div id="document-preview-pane-css">
    						</div>
    						<div id="document-preview-pane-content" style="border-style:solid; border-width:0px; border-color:#888888; margin:0px auto;">
    						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
<script>

var mw003_initialized = false;
var mw003_printEnabled = false;
var mw003_documentType = '';
var mw003_documentObj;
var mw003_placeDocumentObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw003_isOpen()
{
	return ($("#mw003").data('bs.modal') || {}).isShown;	
} // .end of mw003_isOpen

/**
 * Initiate components/variables
 */
function mw003_init()
{
	if (mw003_initialized)
		return false;

	// On value changes - Print > Document Type
	$("#mw003_documentType").change(function() {
		refreshDocumentPreviewPane();
	});	
	
	mw003_initialized = true;
} // .end of mw003_init

/**
 * Initiate data into modal window.
 */
function mw003_updateUI()
{			
	mw003_init();
	
	// Reset state
	$('#document-preview-pane-css').html('');
	$('#document-preview-pane-content').html('');
	
	// Check if billing line exist
	if (global_billingObj.lineList.length == 0) {
		tycheesLogger_showToast("error", "Print not Ready", "Please insert item(s) before proceed to Print.");
		return false;
	}
	
	// FOR QUOTATION MODE ONLY
	if (bil001_ctrl_isQuotationMode(global_billingObj)) 
	{
		$('#mw003_quotationButton').show();
		$('#mw003_fullOrderButton').hide();
		$('#mw003_invoiceButton').hide();
		$('#mw003_receiptButton').hide();
	}
	else
	{
		if (bil001_ctrl_hasQuotationNumber(global_billingObj))
		{
			$('#mw003_quotationButton').show();
			$('#mw003_fullOrderButton').show();
			$('#mw003_invoiceButton').show();
			$('#mw003_receiptButton').show();
		}
		else
		{
			$('#mw003_quotationButton').hide();
			$('#mw003_fullOrderButton').show();
			$('#mw003_invoiceButton').show();
			$('#mw003_receiptButton').show();
		}
	}
	
	module_showModalWindow('mw003', true);
} // .end of mw003_updateUI

/**
 * Event listener when user select document type on modal window.
 */
function mw003_selectType(documentType) {
	
	mw003_documentType = documentType;
		
	if ('quotation'==mw003_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedQuotationObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_QUOTATION_TEMPLATE);
	    
	    var documentObj = Cached_getDocumentByCode(settingsObj_selectedQuotationObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw003_documentObj = documentObj;
	    	mw003_callToPreview(documentObj);
	    }
	} 
	else
	if ('invoice'==mw003_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedInvoiceObj	= Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_INVOICE_TEMPLATE);
	    
	    var documentObj = Cached_getDocumentByCode(settingsObj_selectedInvoiceObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw003_documentObj = documentObj;
	    	mw003_callToPreview(documentObj);
	    }
	} 
	else
	if ('receipt'==mw003_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedReceiptObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_TEMPLATE);
	    
		var documentObj = Cached_getDocumentByCode(settingsObj_selectedReceiptObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw003_documentObj = documentObj;
	    	mw003_callToPreview(documentObj);
	    }
	}
	else
	if ('fullOrder'==mw003_documentType) 
	{
		// Get preset default template
	    var settingsObj_selectedFullOrderObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_BILLING_FULL_TEMPLATE);
	    
		var documentObj = Cached_getDocumentByCode(settingsObj_selectedFullOrderObj.propValue);
	    if (documentObj != null) 
	    {
	    	mw003_documentObj = documentObj;
	    	mw003_callToPreview(documentObj);
	    }
	}
} // .end of mw003_selectType

function mw003_callToPreview(documentObj)
{
	// Resets
	$('#mw003_userInputs').empty();

	var placeObj = Cached_getPlaceById( tycheesCommon_getCurrentPlaceId() );
	    	
	$.each(placeObj.documentList, function(i, placeDocObj){
		if (placeDocObj.documentId == documentObj.id)
		{
			mw003_placeDocumentObj = placeDocObj;
			$.each(placeDocObj.propertiesList, function(j, propObj){
				if (propObj.requireInputFromUser)
				{
					if (propObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT)
					{
						propObj.userInput = '';
							
						var htmlLines = '';
    					htmlLines += '<label class="font-noraml">';
    					htmlLines += propObj.propName;
    					htmlLines += '</label>';
    					htmlLines += '<input id="' + propObj.id + '" type="text" class="form-control" placeholder="" value="">';
    					htmlLines += '<br>';
    					
    					$('#mw003_userInputs').append(htmlLines);

    					$('#'+propObj.id).on('input change propertychange paste', function() {
    						propObj.userInput = $('#'+propObj.id).val();
    						mw003_reloadPreviewPane(documentObj, placeDocObj);
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
				    	var dateVal = tycheesDateTime_getFormattedDate_ddMMyyyy( (new Date()).getTime() );
				    	if ( propObj.propValue != 'TODAY' )
				    		dateVal = propObj.propValue;
				    	
				    	propObj.userInput = dateVal;
				    	
    					var htmlLines = '';
    					htmlLines += '<label class="font-noraml">';
    					htmlLines += propObj.propName;
    					htmlLines += '</label>';
    					htmlLines += '<input id="' + propObj.id + '" type="text" class="form-control" data-mask="99/99/9999" placeholder="dd/mm/yyyy" value="' + dateVal + '">';
						htmlLines += '<label class="font-noraml" style="padding-left:10px; font-size:12px;">dd/mm/yyyy</label>';
    					htmlLines += '<br>';
    					
    					$('#mw003_userInputs').append(htmlLines);

    					$('#'+propObj.id).on('input change propertychange paste', function() {
    						propObj.userInput = $('#'+propObj.id).val();
    						mw003_reloadPreviewPane(documentObj, placeDocObj);
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
	
	// Display preview
	if (mw003_placeDocumentObj.propertiesList==null || mw003_placeDocumentObj.propertiesList.length==0)
		swal('Oops...', 'Please enable this document in Settings.', 'error');
	else
		mw003_reloadPreviewPane(documentObj, mw003_placeDocumentObj);
} // .end of mw003_callToPreview

function mw003_print()
{	
	if (global_billingObj.id==null || global_billingObj.id.length==0) {
		menu_saveBilling();
	}
	
	if (mw003_printEnabled) {
		
		if (mw003_documentType == 'invoice') 
		{
			if (global_billingObj.invoiceNo == null || global_billingObj.invoiceNo == '') 
			{
				global_billingObj.invoiceNo = consoleCommon_getNextInvoiceNo();
				global_billingObj.invoiceDate = tycheesDateTime_getCurrentTimeInMillis();
				
				consoleCommon_updateNextInvoiceNo();
			}
		}
		
		if (mw003_documentType == 'receipt') 
		{
			if (global_billingObj.receiptNo == null || global_billingObj.receiptNo == '') 
			{
				global_billingObj.receiptNo = consoleCommon_getNextReceiptNo();
				global_billingObj.receiptDate = tycheesDateTime_getCurrentTimeInMillis();
				
				consoleCommon_updateNextPaymentReceiptNo();
			}
		}
		
		if (mw003_documentType == 'fullOrder') 
		{
			// do nothing
		}
		
		var css_lines = '';
		css_lines += '<link href="http://dev.tychees.com/resources/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">';
		css_lines += '<link href="http://dev.tychees.com/resources/plugins/jquery-ui/jquery-ui.css" rel="stylesheet">';
		css_lines += '<link href="http://dev.tychees.com/resources/plugins/Inspinia/console_style.css" rel="stylesheet">';
	
		//$('#document-preview-pane-css').html(css_lines);
		//$('#document-preview-pane').printElement();
		//$('#'+mw003_documentObj.docCode).prepend(css_lines);
		//$('#'+mw003_documentObj.docCode).printElement();
		
		//var doc = new jsPDF("potrait", "pt", "a4");
		var pdfDoc = processDocument_INV001_002_getPDF(mw003_documentObj, mw003_placeDocumentObj, global_billingObj, Cached_userObj);
		
		//var pdfDoc = new jsPDF('portrait', 'pt', 'a4');
		//var margins = {top: 50, bottom: 10, left: 10, width: 600 };

		//pdfDoc.setFontSize(18);
		//pdfDoc.setFontType('bold');
		//pdfDoc.text(250, 40, 'TAX INVOICE');
		
		//pdfDoc.setLineWidth(0.1);
		//pdfDoc.line(40, 50, 520, 50);	
		

		//pdfDoc.setFontSize(15);
		//pdfDoc.setFontType('normal');
		//pdfDoc.text(450, 60, 'Tax Invoice No.');
		
		
		pdfDoc.autoPrint();	
    	pdfDoc.output('dataurlnewwindow');
		
		//pdfDoc.addHTML(
		//    $('#'+mw003_documentObj.docCode).children()[0], 
		//    function () {
		    	//tycheesLogger_logDebug('1', 'mw003_print');
		    	//pdfDoc.autoPrint();	
		    	//pdfDoc.output('dataurlnewwindow');
		    	
		    	/*
		   		var pdfFileName = '';
		   		pdfFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		   		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		   		pdfFileName += '.pdf';

		   		tycheesLogger_logDebug('2', 'mw003_print');
		    	pdfDoc.save( pdfFileName );
		    	
		    	tycheesLogger_logDebug('3', 'mw003_print');
		    	
		    	//window.open(pdfDoc.output('bloburl'), '_blank');
		    	window.open(pdfDoc.output(pdfFileName), '_blank');
		    	*/
		// 	},
		// 	margins
		//);
		
		// Auto-save Billing
		bil001_menuPanel_save();
		// Close window
    	module_closeModalWindow('mw003');
	}
} // .end of mw003_print

function mw003_reloadPreviewPane(docObj, placeDocObj)
{
	// Find placeholders and replace with value
	var docContent = documentCommon_processDocument_moduleBilling(docObj, placeDocObj, global_billingObj, Cached_userObj);
	
	$("#document-preview-pane-content").html(docContent);
	$("#mw003-01").css("margin-top","10px");
	
	mw003_printEnabled = true;
} // .end of mw003_reloadPreviewPane


</script>