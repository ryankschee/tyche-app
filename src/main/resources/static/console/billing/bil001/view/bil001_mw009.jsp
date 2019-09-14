<!-- ITEM DIALOG - TAX, DISCOUNT -->
<div class="modal inmodal fade" id="mw009" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span id="mw009_itemImage" class="client-avatar" style="vertical-align:middle;">						
				</span>
				<span id="mw009_itemName" style="font-size:22pt;vertical-align:middle;"></span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12">
								<div class="ibox float-e-margins" style="margin-bottom:0px;">
									<div class="ibox-title" style="background-color:#f3f3f3;">
									    <h5>
									        <span id="mw009_settingsTitle">XXX Settings</span>
									    </h5> 
									</div>
									<div class="ibox-content">
										<div id="mw009_taxType_div" class="input-group m-b" style="display:none;">
									        <span id="mw009_taxType_title" class="input-group-addon" style="width:220px;text-align:left;"> 
									            Tax Type
									        </span> 
									        <input id="mw009_taxType" type="text" class="form-control" style="height:40px;font-size:14pt;" disabled>
									    </div>
										<div class="input-group m-b">
									        <span class="input-group-addon" style="width:180px;text-align:left;"> 
									            <input id="mw009_setDefaultValue" name="mw009_percentageOrAmount" type="radio" class="i-checks"> 
									            <span id="mw009_setDefaultValue_title">Default Value</span>
									        </span> 
									        <span class="input-group-addon currency-unit">$</span>
									        <input id="mw009_defaultValue" type="text" class="form-control" style="width:100%;height:40px;font-size:14pt;" disabled>
									        <span class="input-group-addon percentage-unit">%</span>
									    </div>
									    <div class="input-group m-b">
									        <span class="input-group-addon" style="width:180px;text-align:left;"> 
									            <input id="mw009_setCompoundValue" name="mw009_percentageOrAmount" type="radio" class="i-checks"> 
									            <span id="mw009_setCompoundValue_title">Compound Value</span>
									        </span> 
									        <span class="input-group-addon currency-unit">$</span>
									        <input id="mw009_compoundValue" type="text" class="form-control" style="width:100%;height:40px;font-size:14pt;" disabled>	
									        <span class="input-group-addon percentage-unit">%</span>										        
									    </div>
									    <div class="input-group m-b">
									        <span class="input-group-addon" style="width:180px;text-align:left;"> 
									            <input id="mw009_setCustomValue" name="mw009_percentageOrAmount" type="radio" class="i-checks"> 
									            <span id="mw009_setCustomValue_title">Custom Value</span>
									        </span> 
									        <span class="input-group-addon currency-unit">$</span>
									        <input id="mw009_customValue" type="text" class="form-control" style="width:100%;height:40px;font-size:14pt;" disabled>
									        <span class="input-group-addon percentage-unit">%</span>
									    </div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="ibox float-e-margins" style="margin-bottom:0px;">
									<div class="ibox-title" style="background-color:#f3f3f3;">
									    <h5>
									        <span>Notes</span>
									    </h5> 
									</div>
									<div class="ibox-content">
									    <div style="font-size:12pt;padding-bottom:5px;">
									        Remarks:
									    </div>
									    <div class="input-group m-b" style="width:100%;">
									        <input id="mw009_remarks" type="text" class="form-control">
									    </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="mw009_saveChanges();">Save Changes</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw009_initializing = false;
var mw009_initialized = false;

var mw009_billingRowId = '';
var mw009_billingLineId = '';
var mw009_billingLineObj;
var mw009_itemObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw009_isOpen()
{
	return ($("#mw009").data('bs.modal') || {}).isShown;	
} // .end of mw009_isOpen

function mw009_init()
{
	if (mw009_initialized==true)
		return false;
	
	// Setup Event Listener - User CHANGE Custom Value
    $('#mw009_setDefaultValue').on('ifChecked', function(event) {
    	
    	if (mw009_initializing==true)
    		return false;

    	$('#mw009_customValue').attr('disabled', true);
    	
    	var defaultValue = Number($('#mw009_defaultValue').val());
    	mw009_billingLineObj.unitPriceSource = 'default';
    	mw009_billingLineObj.defaultUnitPrice = defaultValue;
    });
	
    $('#mw009_setCompoundValue').on('ifChecked', function(event) {
    	
    	if (mw009_initializing==true)
    		return false;

    	$('#mw009_customValue').attr('disabled', true);
    	
    	var compoundValue = Number($('#mw009_compoundValue').val());
    	mw009_billingLineObj.unitPriceSource = 'compound';
    	mw009_billingLineObj.compoundUnitPrice = compoundValue;
    });

    $('#mw009_setCustomValue').on('ifChecked', function(event) {
    	
    	if (mw009_initializing==true)
    		return false;
    	
    	$('#mw009_customValue').attr('disabled', false);
    	$('#mw009_customValue').focus();
    	$('#mw009_customValue').select();
    	
    	var customValue = Number($('#mw009_customValue').val());
    	mw009_billingLineObj.unitPriceSource = 'custom';
    	mw009_billingLineObj.customUnitPrice = customValue;
    });
	
    $("#mw009_customValue").on("change paste keyup", function() {

    	if (mw009_initializing==true)
    		return false;
    	mw009_billingLineObj.customUnitPrice = Number($(this).val());
    });
    
    mw009_initialized = true;
} // .end of mw009_init

/**
 * Initiate data into modal window.
 */
function mw009_open(itemId, billingRowId, billingLineId)
{	
	tycheesOverlay_startShortProgress('loading item...');
	
	mw009_init();	
	mw009_initializing = true;
	mw009_billingRowId = billingRowId;
	mw009_billingLineId = billingLineId;
	
	// Prepare request object
	var requestBody = {
		'appName': APP_NAME_POS,
		'itemId': itemId,
		'fullBean': true
	};
	
	var params = new Object();
	params.itemId = itemId;
	
	tycheesdb_api_getItemById(requestBody, mw009_open_postHandler, params);
} // .end of mw009_open

function mw009_open_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false) 
	{
		tycheesOverlay_stopShortProgress();
		return false;
	}
		
	// Get Item object
	mw009_itemObj = responseObj.itemObj;
	// Get selected billing line object
	mw009_billingLineObj = billingCommon_getBillingLineByRowId(global_billingObj, mw009_billingRowId);
	
	// Perform calculation on Billing Line
	billingCommon_calculateBillingLine(mw009_billingLineObj);

	// Item object is not null & line object is not null
	if (mw009_itemObj != null && mw009_billingLineObj != null)
	{
		// Set values
		$("#mw009_itemName").html( tycheesText_getDisplayText(mw009_billingLineObj.itemName, 0) );
		$('#mw009_remarks').val(mw009_billingLineObj.remarks);
		var imageUrl = $.trim( mw009_itemObj.imageUrl );
        if (imageUrl.length==0)
            imageUrl = 'http://www.ithsc.com/ciscohardwaremaintenance/images/no_product_image_large.png';
		$("#mw009_itemImage").html('<img alt="image" src="' + imageUrl + '">');
		
		$('#mw009_defaultValue').val( tycheesUtil_getSafeNumber(mw009_billingLineObj.defaultUnitPrice, 2) );
		$('#mw009_compoundValue').val( tycheesUtil_getSafeNumber(mw009_billingLineObj.compoundUnitPrice, 2) );
		$('#mw009_customValue').val( tycheesUtil_getSafeNumber(mw009_billingLineObj.customUnitPrice, 2) );
		
		if (mw009_billingLineObj.unitPriceSource=='default')
		{
			$('#mw009_setDefaultValue').iCheck('check');
			$('#mw009_customValue').attr('disabled', true);
		}
		else
		if (mw009_billingLineObj.unitPriceSource=='compound')
		{
			$('#mw009_setCompoundValue').iCheck('check');
			$('#mw009_customValue').attr('disabled', true);
		}
		else
		if (mw009_billingLineObj.unitPriceSource=='custom')
		{
			$('#mw009_setCustomValue').iCheck('check');
			$('#mw009_customValue').attr('disabled', false);
		}		
		
		// Initialize for ItemType=Discount
		if (mw009_itemObj.itemType==InventoryConstants.ITEM_TYPE_DISCOUNT) 
		{
			if (mw009_itemObj.taxDiscountPercentage > 0)
			{
				$('#mw009_settingsTitle').html( 'Discount Percentage' );

				$('.currency-unit').hide();
			    $('.percentage-unit').show();
			}
			else
			{
				$('#mw009_settingsTitle').html( 'Discount Amount' );
				
				var currencyObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);  
			    $('.currency-unit').html( currencyObj.propValue );
			    $('.currency-unit').show();
			    $('.percentage-unit').hide();
			}			
		}
		// Initialize for ItemType=Tax
		if (mw009_itemObj.itemType==InventoryConstants.ITEM_TYPE_TAX)
		{
			if (mw009_itemObj.taxDiscountPercentage > 0)
			{
				$('#mw009_settingsTitle').html( 'Tax Percentage' );	
				
				$('.currency-unit').hide();
			    $('.percentage-unit').show();
			}
			else
			{
				$('#mw009_settingsTitle').html( 'Tax Amount' );
				
				var currencyObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);  
			    $('.currency-unit').html( currencyObj.propValue );
			    $('.currency-unit').show();
			    $('.percentage-unit').hide();
			}	
			
			$('#mw009_taxType').val(mw009_itemObj.taxInclusive ? 'Inclusive' : 'Exclusive');
			$('#mw009_taxType_div').show();
		}
		
		mw009_initializing = false;
		
		// Show Modal Window
		module_showModalWindow('mw009', true);
	}	
	else
	{
		// Error
		tycheesLogger_showToast('error','Unexpected System Error','Please contact us to fix this.')
	}
	
	// Hide progress overlay
	tycheesOverlay_stopShortProgress();
} // .end of mw009_open_postHandler

/**
 * Update data on Modal Window.
 */
function mw009_updateUI()
{
	// Re-calculate billing line.
	billingCommon_calculateBillingLine(mw009_billingLineObj);
} // .end of mw009_updateUI

/**
 * Triggered when button click at 'Save Changes' at modal window Item Details
 */ 
function mw009_saveChanges()
{
	// Get item id from modal window
	var itemId = mw009_itemObj.id;
	// Set flag
	mw009_billingLineObj.hasChanged = true;
	// Set Remarks
	mw009_billingLineObj.remarks = $('#mw009_remarks').val();
	
	if (mw009_itemObj.itemType==InventoryConstants.ITEM_TYPE_DISCOUNT) 
	{
		// If unit is Percentage (%)
		if (mw009_itemObj.taxDiscountPercentage > 0)
		{
			if (mw009_billingLineObj.unitPriceSource=='default')
				mw009_billingLineObj.discountPercentage = mw009_billingLineObj.defaultUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='compound')
				mw009_billingLineObj.discountPercentage = mw009_billingLineObj.compoundUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='custom')
				mw009_billingLineObj.discountPercentage = mw009_billingLineObj.customUnitPrice;
			
			mw009_billingLineObj.discountAmount = (mw009_billingLineObj.discountPercentage / 100) * global_billingObj.totalAmount;
		}
		// If unit is Amount (currency)
		else 
		{
			if (mw009_billingLineObj.unitPriceSource=='default')
				mw009_billingLineObj.discountAmount = mw009_billingLineObj.defaultUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='compound')
				mw009_billingLineObj.discountAmount = mw009_billingLineObj.compoundUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='custom')
				mw009_billingLineObj.discountAmount = mw009_billingLineObj.customUnitPrice;
						
			mw009_billingLineObj.discountPercentage = 0;
		}
	}
	
	if (mw009_itemObj.itemType==InventoryConstants.ITEM_TYPE_TAX) 
	{
		var taxInclusive = mw009_itemObj.taxInclusive;
		
		// If unit is Percentage (%)
		if (mw009_itemObj.taxDiscountPercentage > 0)
		{
			var taxAmount = 0;
			var taxPercentage = 0;
			
			if (mw009_billingLineObj.unitPriceSource=='default')
				taxPercentage = mw009_billingLineObj.defaultUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='compound')
				taxPercentage = mw009_billingLineObj.compoundUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='custom')
				taxPercentage = mw009_billingLineObj.customUnitPrice;
			
			if (taxInclusive==true)
			{
				var taxInDecimal = Number(taxPercentage) / 100;
				var calculatedTaxAmount = Number(global_billingObj.totalAmount) - ( Number(global_billingObj.totalAmount) / (taxInDecimal + 1) );
				taxAmount = Math.round(calculatedTaxAmount * 100) / 100;
			}
			else
			{
				var calculatedTaxAmount = Number(global_billingObj.totalAmount) * (Number(taxPercentage) / 100);
				taxAmount = Math.round(calculatedTaxAmount * 100) / 100;
			}
			
			mw009_billingLineObj.taxPercentage = taxPercentage;
			mw009_billingLineObj.taxAmount = taxAmount;
		}
		// If unit is Amount (currency)
		else 
		{
			if (mw009_billingLineObj.unitPriceSource=='default')
				mw009_billingLineObj.taxAmount = mw009_billingLineObj.defaultUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='compound')
				mw009_billingLineObj.taxAmount = mw009_billingLineObj.compoundUnitPrice;
			if (mw009_billingLineObj.unitPriceSource=='custom')
				mw009_billingLineObj.taxAmount = mw009_billingLineObj.customUnitPrice;
			
			mw009_billingLineObj.taxPercentage = 0;
		}
	}		
    // Auto-save Billing
	bil001_menuPanel_save();
	// Reload Billing lines panel
	bil001_cartPanel_updateUI();
} // .end of mw009_saveChanges

</script>