
<!-- PRINT BUCKET DIALOG -->
<div class="modal inmodal fade" id="mw_printBucket" tabindex="-1" role="dialog"  aria-hidden="true">
	<div id="mw_printBucket-01" class="modal-dialog modal-xl" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">BACK OFFICE PRINT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
				    <div class="col-md-3">
				    	<div id="mw_printBucket_foodOrderButton" class="widget style1 lazur-bg" onclick="mw_printBucket_printFoodOrder();" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Food Order</span>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="mw_printBucket_drinkOrderButton" class="widget style1 lazur-bg" onclick="mw_printBucket_printDrinkOrder();" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-3x fa-file-text-o" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Drink Order</span>
	                            </div>
	                        </div>
	                    </div>
					</div>
					<div class="col-md-9">
						<iframe id="mw_printBucket_previewArea" style="border:0">
						</iframe>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw_printBucket_print();"><i class="fa fa-print"></i> Print Now</button>
			</div>
		</div>
	</div>
</div>
	
<script>

var mw_printBucket_initialized = false;
var mw_printBucket_documentType = '';
var mw_printBucket_documentObj;
var mw_printBucket_placeDocumentObj;

var mw_printBucket_userObj;
var mw_printBucket_placeObj;
var mw_printBucket_placeDocumentObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw_printBucket_isOpen()
{
	return ($("#mw_printBucket").data('bs.modal') || {}).isShown;	
} // .end of mw_printBucket_isOpen

/**
 * Initiate components/variables
 */
function mw_printBucket_init()
{
	if (mw_printBucket_initialized)
		return false;

	// On value changes - Print > Document Type
	$("#mw_printBucket_documentType").change(function() {
		refreshDocumentPreviewPane();
	});	
	
	mw_printBucket_initialized = true;
} // .end of mw_printBucket_init

function mw_printBucket_show()
{
	mw_printBucket_userObj = tycheesCommon_getCurrentUserObject();
	mw_printBucket_placeObj = tycheesCommon_getCurrentPlaceObject();
	
	mw_printBucket_updateUI();
} // .end of mw_printBucket_show

/**
 * Initiate data into modal window.
 */
function mw_printBucket_updateUI()
{			
	mw_printBucket_init();
	
	// Reset state
	$('#mw_printBucket_previewArea').attr('src', '');
	
	// Retrieve settings
	var foodOrderEnabled = settingsCommon_getSettingsValue(
			ModuleConstants.MODULE_BILLING, 
			ModuleConstants.MODULE_BILLING_SUB_BACKOFFICE, 
			SettingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_ENABLED);
	var drinkOrderEnabled = settingsCommon_getSettingsValue(
			ModuleConstants.MODULE_BILLING, 
			ModuleConstants.MODULE_BILLING_SUB_BACKOFFICE, 
			SettingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_ENABLED);
	
	if (foodOrderEnabled) {
		$('#mw_printBucket_foodOrderButton').show();
	} else {
		$('#mw_printBucket_foodOrderButton').hide();
	}
	
	if (drinkOrderEnabled) {
		$('#mw_printBucket_drinkOrderButton').show();
	} else {
		$('#mw_printBucket_drinkOrderButton').hide();
	}	
	
	// Show Window
	module_showModalWindow('mw_printBucket', true);
} // .end of mw_printBucket_updateUI

function mw_printBucket_printFoodOrder()
{
	// Get preset default template
    var selectedTemplateObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_TEMPLATE);    
	var documentObj = Cached_getDocumentByCode(selectedTemplateObj.propValue);
    
	$.each(mw_printBucket_placeObj.documentList, function(i, placeDocObj){
		if (placeDocObj.documentId == documentObj.id) {
			mw_printBucket_placeDocumentObj = placeDocObj;
		}
	});	
	
	// Get jsPDF object
    var pdfDoc = documentCommon_getPDF(
    				documentObj, 
    				mw_printBucket_placeDocumentObj, 
    				mw_printBucket_userObj, 
    				global_billingBucketObj);
    // Get base64 data
    var base64Data = pdfDoc.output('datauri');
    // Show content
    $("#mw_printBucket_previewArea").attr("height", "480px");
    $("#mw_printBucket_previewArea").attr("width", "100%");
    $("#mw_printBucket_previewArea").attr("src", base64Data);
} // .end of mw_printBucket_printFoodOrder

function mw_printBucket_printDrinkOrder()
{
	// Get preset default template
    var selectedTemplateObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_TEMPLATE);    
	var documentObj = Cached_getDocumentByCode(selectedTemplateObj.propValue);
    
	$.each(mw_printBucket_placeObj.documentList, function(i, placeDocObj){
		if (placeDocObj.documentId == documentObj.id) {
			mw_printBucket_placeDocumentObj = placeDocObj;
		}
	});	
	
	// Get jsPDF object
    var pdfDoc = documentCommon_getPDF(
    				documentObj, 
    				mw_printBucket_placeDocumentObj, 
    				mw_printBucket_userObj, 
    				global_billingBucketObj);
    // Get base64 data
    var base64Data = pdfDoc.output('datauri');
    // Show content
    $("#mw_printBucket_previewArea").attr("height", "480px");
    $("#mw_printBucket_previewArea").attr("width", "100%");
    $("#mw_printBucket_previewArea").attr("src", base64Data);
} // .end of mw_printBucket_printDrinkOrder

function mw_printBucket_print()
{		
	// Close window
   	module_closeModalWindow('mw_printBucket');
} // .end of mw_printBucket_print

</script>