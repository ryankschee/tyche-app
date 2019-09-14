<!-- TAX DIALOG -->
<div class="modal inmodal fade" id="mw006" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">ITEMIZED TAXES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="ibox-title">
					<h5>Billing Items with Itemized Taxes</h5>
				</div>
				<div class="ibox-content">
					<table class="table">
						<thead>
							<tr>
								<th id="mw006_tableHeader_col01">#</th>
								<th id="mw006_tableHeader_col02">Item Name</th>
								<th id="mw006_tableHeader_col03">Base Price</th>
								<th id="mw006_tableHeader_col04">Percentage (%)</th>
								<th id="mw006_tableHeader_col05">Amount (MYR)</th>
							</tr>
						</thead>
						<tbody id="mw006_table">
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw006_initialized = false;
var mw006_currency = '$CURRENCY';

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw006_isOpen()
{
	return ($("#mw006").data('bs.modal') || {}).isShown;	
} // .end of mw006_isOpen

/**
 * Initiate data into modal window.
 */
function mw006_init()
{			
	if (mw006_initialized == true)
		return false;
	
	mw006_initialized = true;
} // .end of mw006_init

/**
 * Initiate data into modal window.
 */
function mw006_updateUI()
{			
	mw006_init();

	// Set Currency
	mw006_currency = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
								SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
	$('#mw006_tableHeader_col04').html('Amount (' + mw006_currency + ')');
	
	// empty the list
	$("#mw006_table").empty();
	
	var rowNo = 1;
    // Add discount line into list
	$.each(global_billingObj.lineList, function(index, billingLineObj) {
		
		if (Cached_isDeletedBean(billingLineObj))
			return true;
		
		var billingLineItemObj = Cached_getItemById(billingLineObj.itemId);
		
		if (billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_RAW)
		{
			var htmlLines = '';
        	htmlLines += '<tr id="mw006_line_' + billingLineObj.id + '">';
			htmlLines += '<td>' + (rowNo++) + '</td>';
			htmlLines += '<td>' + billingLineItemObj.name + '</td>';
			htmlLines += '<td>' + Number(billingLineObj.billableAmount * billingLineObj.quantity).toFixed(2) + '</td>';
			htmlLines += '<td><i class="fa fa-plus" aria-hidden="true" style="color:#00af00;"></i> ' + Number(billingLineObj.taxPercentage).toFixed(2) + '</td>';
			htmlLines += '<td><i class="fa fa-plus" aria-hidden="true" style="color:#00af00;"></i> ' + Number(billingLineObj.taxAmount).toFixed(2) + '</td>';
    		htmlLines += '</tr>';
        	
        	$("#mw006_table").append(htmlLines);
		}
	});

	// Show Modal Window
	module_showModalWindow('mw006', true);
} // .end of mw006_updateUI

</script>