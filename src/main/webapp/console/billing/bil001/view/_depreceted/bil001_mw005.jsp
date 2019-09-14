<!-- DISCOUNT DIALOG -->
<div class="modal inmodal fade" id="mw005" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">ITEMIZED DISCOUNTS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="ibox-title">
					<h5>Billing Items with Itemized Discounts</h5>
				</div>
				<div class="ibox-content">
					<table class="table">
						<thead>
							<tr>
								<th id="mw005_tableHeader_col01">#</th>
								<th id="mw005_tableHeader_col02">Item Name</th>
								<th id="mw005_tableHeader_col03">Base Price</th>
								<th id="mw005_tableHeader_col04">Percentage (%)</th>
								<th id="mw005_tableHeader_col05">Amount (MYR)</th>
							</tr>
						</thead>
						<tbody id="mw005_table">
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

var mw005_initialized = false;
var mw005_currency = '$CURRENCY';

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw005_isOpen()
{
	return ($("#mw005").data('bs.modal') || {}).isShown;	
} // .end of mw005_isOpen

/**
 * Initiate data into modal window.
 */
function mw005_init()
{			
	if (mw005_initialized == true)
		return false;
	
	mw005_initialized = true;
} // .end of mw005_init

/**
 * Initiate components/variables
 */
function mw005_updateUI()
{
	mw005_init();
	
	// Set Currency
	mw005_currency = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
								SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
	$('#mw005_tableHeader_col04').html('Amount (' + mw005_currency + ')');
	
	// Empty the list
	$("#mw005_table").empty();

	var rowNo = 1;
	// Add discount line into list
	$.each(global_billingObj.lineList, function(index, billingLineObj) {

		var billingLineItemObj = Cached_getItemById(billingLineObj.itemId);
		
		if (billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			billingLineItemObj.itemType == InventoryConstants.ITEM_TYPE_RAW)
		{
			var htmlLines = '';
        	htmlLines += '<tr id="mw005_line_' + billingLineObj.id + '">';
			htmlLines += '<td>' + (rowNo++) + '</td>';
			htmlLines += '<td>' + billingLineItemObj.name + '</td>';
			htmlLines += '<td>' + Number((billingLineObj.billableAmount + billingLineObj.discountAmount) * billingLineObj.quantity).toFixed(2) + '</td>';
			htmlLines += '<td><i class="fa fa-minus" aria-hidden="true" style="color:#ff3737;"></i> ' + Number(billingLineObj.discountPercentage).toFixed(2) + ' %</td>';
			htmlLines += '<td><i class="fa fa-minus" aria-hidden="true" style="color:#ff3737;"></i> ' + Number(billingLineObj.discountAmount).toFixed(2) + '</td>';
    		htmlLines += '</tr>';
        	
        	$("#mw005_table").append(htmlLines);
		}
	});

	// Show Modal Window
	module_showModalWindow('mw005', true);
} // .end of mw005_updateUI

</script>