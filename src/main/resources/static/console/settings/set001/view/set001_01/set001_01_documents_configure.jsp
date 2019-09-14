
<!-- set001_01_documents_configure: Document Configuration -->
<div id="set001_01_documents_configure" style="display:none; padding-top:10px;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	DOCUMENT CONFIGURATION (working)
	</span>
    <div id="set001_01_documents_configure_menu" class="ibox-content" style="padding-left:0px; padding-right:0px;">
        <form role="form" class="form-inline">
        	<span style="font-size:12pt;">Select Document: </span>
            <div class="form-group">
                <label for="set001_01_documents_configure_templateList" class="sr-only">Document Template List</label>
                <select id="set001_01_documents_configure_templateList" class="form-control" style="width:350px;" onchange="set001_01_documents_configure_templateChanged();">
               		<option value="0">-- SELECT --</option>
               		<option value="quotation">Sales Quotation</option>
               		<option value="internal">Sales Order for Internal Use</option>
               		<option value="sales_invoice">Sales Invoice</option>
               		<option value="tax_invoice">Tax Invoice</option>
               		<option value="payment_receipt">Payment Receipt</option>
               		<option value="payment_voucher">Payment Voucher</option>
               		<option value="delivery_order">Delivery Order</option>                	
                </select>
            </div>            
        </form>
    </div>    
    <div id="set001_01_documents_configure_settingsTable">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
        	<tbody id="set001_01_documents_configure_settingList">
            </tbody>
        </table>
    </div>
	<div id="set001_01_documents_configure_propertiesTable_spinner" class="row spiner-example" style="display:none;">
		<div class="sk-spinner sk-spinner-wave">
		    <div class="sk-rect1"></div>
		    <div class="sk-rect2"></div>
		    <div class="sk-rect3"></div>
		    <div class="sk-rect4"></div>
		    <div class="sk-rect5"></div>
		</div>
	    <div id="set001_01_documents_configure_propertiesTable_spinner_text" style="padding-top:10px; text-align:center;">loading documents...</div>
	</div>
</div>

<script>

var set001_01_documents_configure_initialized = false;

function set001_01_documents_configure_init()
{
    if (set001_01_documents_configure_initialized == true)
        return false;
        
	set001_01_documents_configure_initialized = true;
} // .end of set001_01_documents_configure_init

function set001_01_documents_configure_hide()
{
    $('#set001_01_documents_configure').hide();
} // .end of set001_01_documents_configure_hide

function set001_01_documents_configure_show(givenId)
{
	set001_01_documents_configure_updateUI(givenId);
} // .end of set001_01_documents_configure_hide

function set001_01_documents_configure_updateUI(givenId)
{
    // Init, if any
	set001_01_documents_configure_init();
    // Show UI
    $('#set001_01_documents_configure').show();
    // Show Spinner, Hide Table
    $('#set001_01_documents_configure_menu').hide();
    $('#set001_01_documents_configure_settingsTable').hide();
    $('#set001_01_documents_configure_settingsTable_spinner').show();
    
 	// Empty properties list    
 	$('#set001_01_documents_configure_propertiesList').empty();
         
    // Reload properties based on selected template
    set001_01_documents_configure_reloadTemplate();
     
    // Hide Spinner, Show Table
    $('#set001_01_documents_configure_menu').show();
    $('#set001_01_documents_configure_settingsTable').show();
    $('#set001_01_documents_configure_settingsTable_spinner').hide();
} // .end of set001_01_documents_configure_updateUI

/**
 * Reload properties of document template.
 */
function set001_01_documents_configure_reloadTemplate()
{
	// Reset	
	$('#set001_01_documents_configure_settingList').empty();
	
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
	var templateType = $('#set001_01_documents_configure_templateList').val();
	
	// Init list
	var settingsList = [];
	var optionList = [];

	if (templateType == 'quotation') {
		settingsList = Cached_getSettingsListByModule( 
                ModuleConstants.MODULE_BILLING, 
                ModuleConstants.MODULE_BILLING_SUB_QUOTATION);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}
	
	if (templateType == 'internal') {
		settingsList = Cached_getSettingsListByModule( 
                ModuleConstants.MODULE_BILLING, 
                ModuleConstants.MODULE_BILLING_SUB_ORDER);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}

	if (templateType == 'tax_invoice') {
		settingsList = Cached_getSettingsListByModule( 
		                ModuleConstants.MODULE_BILLING, 
		                ModuleConstants.MODULE_BILLING_SUB_TAX_INVOICE);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}

	if (templateType == 'sales_invoice') {
		settingsList = Cached_getSettingsListByModule( 
		                ModuleConstants.MODULE_BILLING, 
		                ModuleConstants.MODULE_BILLING_SUB_SALES_INVOICE);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}

	if (templateType == 'payment_receipt') {
		settingsList = Cached_getSettingsListByModule( 
                ModuleConstants.MODULE_BILLING, 
                ModuleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}

	if (templateType == 'payment_voucher') {
		settingsList = Cached_getSettingsListByModule( 
                ModuleConstants.MODULE_BILLING, 
                ModuleConstants.MODULE_BILLING_SUB_PAYMENT_VOUCHER);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}

	if (templateType == 'delivery_order') {
		settingsList = Cached_getSettingsListByModule( 
                ModuleConstants.MODULE_BILLING, 
                ModuleConstants.MODULE_BILLING_SUB_DELIVERY_ORDER);
		// Sort asc
		settingsList.sort(function(a, b){
			return a.propSeqno - b.propSeqno;
		});
	}
	
	// Prepare list of option (template list)
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    placeObj.documentTemplateList.sort(
 		function(a, b){ 
 			return tycheesList_sortByString(a.name, b.name);
 		});
        
    // Populate Template as option List
    $.each(placeObj.documentTemplateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	if (templateObj.available == false)
    		return true;
    	
     	var selectedVal = '';
     	if (templateType==templateObj.templateType) {
     		var optionObj = new Object();
     		optionObj.id = templateObj.id;
     		optionObj.name = templateObj.name + ' (' + templateObj.width + ' x ' + templateObj.height + ')';
     		
     		optionList.push(optionObj);
     	}
    });
	
	
	var lastGroupName = '';
	var thisGroupName = '';	
	$.each(settingsList, function(i, settingsObj){
	
		thisGroupName = settingsObj.groupName;
		
		if (lastGroupName != thisGroupName)
		{
			var group_htmlLines = '';
			group_htmlLines += '<tr style="background-color:#555;">';
			group_htmlLines += '<td colspan="2" style="font-weight:bold; color:#fff; padding-top:2px; padding-bottom:2px;">';
			group_htmlLines += thisGroupName
			group_htmlLines += '</td>';
			group_htmlLines += '</tr>';
			
			$('#set001_01_documents_configure_settingList').append(group_htmlLines);
		}
		   
		var htmlLines = '';
		htmlLines += '<tr class="read">';
		
		// COL #1
		htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
		htmlLines += settingsObj.propName;
		htmlLines += '</td>';
		
		// COL #2
		htmlLines += '<td class="mail-date">' + settingsCommon_getInputComponent(settingsObj, optionList) + '</td>';
		
		$('#set001_01_documents_configure_settingList').append(htmlLines);
		
		// Register events
		settingsCommon_addEventListeners( settingsObj );
		// Set lastGroupName
		lastGroupName = thisGroupName;
	});
} // .end of set001_01_documents_configure_reloadTemplate

/**
 * Event listener when selection of document changed.
 */
function set001_01_documents_configure_templateChanged()
{
	set001_01_documents_configure_reloadTemplate();
} // .end of set001_01_documents_configure_documentChanged();

</script>
