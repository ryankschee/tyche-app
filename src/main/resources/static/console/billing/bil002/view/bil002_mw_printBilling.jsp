
<!-- PRINT BILLING DIALOG -->
<div class="modal inmodal fade" id="mw_printBilling" tabindex="-1" role="dialog"  aria-hidden="true">
	<div id="mw_printBilling-01" class="modal-dialog modal-xl" style="margin-top:10px;">
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
				    <div class="col-md-3">
				    	<div id="mw_printBilling_receiptButton" class="widget style1 lazur-bg" onclick="mw_printBilling_printReceipt();" style="cursor:pointer;">
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
					<div class="col-md-9">
						<iframe id="mw_printBilling_previewArea" style="border:0">
						</iframe>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw_printBilling_print();"><i class="fa fa-print"></i> Print Now</button>
			</div>
		</div>
	</div>
</div>
	
<script>

var mw_printBilling_initialized = false;
var mw_printBilling_documentType = '';
var mw_printBilling_documentObj;
var mw_printBilling_placeDocumentObj;

var mw_printBilling_userObj;
var mw_printBilling_billingObj;
var mw_printBilling_placeObj;
var mw_printBilling_placeDocumentObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw_printBilling_isOpen()
{
	return ($("#mw_printBilling").data('bs.modal') || {}).isShown;	
} // .end of mw_printBilling_isOpen

/**
 * Initiate components/variables
 */
function mw_printBilling_init()
{
	if (mw_printBilling_initialized)
		return false;

	// On value changes - Print > Document Type
	$("#mw_printBilling_documentType").change(function() {
		refreshDocumentPreviewPane();
	});	
	
	mw_printBilling_initialized = true;
} // .end of mw_printBilling_init

function mw_printBilling_show(billingObj)
{
	mw_printBilling_billingObj = billingObj;
	mw_printBilling_userObj = tycheesCommon_getCurrentUserObject();
	mw_printBilling_placeObj = tycheesCommon_getCurrentPlaceObject();
	
	mw_printBilling_updateUI();
} // .end of mw_printBilling_show

/**
 * Initiate data into modal window.
 */
function mw_printBilling_updateUI()
{			
	mw_printBilling_init();
	
	// Reset state
	$('#mw_printBucket_previewArea').attr('src', '');
	
	// Check if billing line exist
	if (mw_printBilling_billingObj.lineList.length == 0) {
		tycheesLogger_showToast("error", "Print not Ready", "Please insert item(s) before proceed to Print.");
		return false;
	}
	module_showModalWindow('mw_printBilling', true);
} // .end of mw_printBilling_updateUI

function mw_printBilling_printReceipt()
{
	// Get preset default template
    var settingsObj_selectedReceiptObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_TEMPLATE);    
	var documentObj = Cached_getDocumentByCode(settingsObj_selectedReceiptObj.propValue);
    
	$.each(mw_printBilling_placeObj.documentList, function(i, placeDocObj){
		if (placeDocObj.documentId == documentObj.id) {
			mw_printBilling_placeDocumentObj = placeDocObj;
		}
	});	
	
	// Get jsPDF object
    var pdfDoc = documentCommon_getPDF(
    				documentObj, 
    				mw_printBilling_placeDocumentObj, 
    				mw_printBilling_userObj, 
    				mw_printBilling_billingObj);
    // Get base64 data
    var base64Data = pdfDoc.output('datauri');
    
    $("#mw_printBilling_previewArea").attr("height", "480px");
    $("#mw_printBilling_previewArea").attr("width", "100%");
    $("#mw_printBilling_previewArea").attr("src", base64Data);
} // .end of mw_printBilling_printReceipt

function mw_printBilling_print()
{		
	// Close window
   	module_closeModalWindow('mw_printBilling');
} // .end of mw_printBilling_print

</script>