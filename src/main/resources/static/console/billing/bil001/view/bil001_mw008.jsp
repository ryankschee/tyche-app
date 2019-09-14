
<!-- ITEM DIALOG - PRODUCT, SERVICE, EVENT, RAW -->
<div class="modal inmodal fade" id="mw008" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<form id="mw008_form">
				<div class="modal-header">
					<span id="mw008_itemImage" class="client-avatar" style="vertical-align:middle;">						
					</span>
					<span id="mw008_itemName" style="font-size:22pt;vertical-align:middle;"></span>
					<span class="pull-right">
						<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
							<i class="fa fa-times" aria-hidden="true"></i>
						</button>
					</span>
				</div>
				<input type="hidden" id="mw008_itemId" value="">
				<div class="modal-body">
						<div class="row">
							<div class="col-md-5">
								<div class="row">
									<div class="col-md-12">
										<div class="ibox float-e-margins" style="margin-bottom:0px;">
											<div class="ibox-title" style="background-color:#f3f3f3;">
											    <h5>
											        <span>Price Settings</span>
											    </h5> 
											</div>
											<div class="ibox-content">
												<div class="input-group m-b">
											        <span class="input-group-addon" style="width:180px;text-align:left;"> 
											            <input id="mw008_setDefaultPrice" name="mw008_unitPrice" type="radio" class="i-checks"> 
											            Default Price
											        </span> 
											        <input id="mw008_defaultPrice" type="text" class="form-control" style="width:100%;height:40px;font-size:14pt;" disabled>
											    </div>
											    <div class="input-group m-b">
											        <span class="input-group-addon" style="width:180px;text-align:left;"> 
											            <input id="mw008_setCompoundPrice" name="mw008_unitPrice" type="radio" class="i-checks"> 
											            Compound Price 
											        </span> 
											        <input id="mw008_compoundPrice" type="text" class="form-control" style="width:100%;height:40px;font-size:14pt;" disabled>											        
											    </div>
											    <div class="input-group m-b">
											        <span class="input-group-addon" style="width:180px;text-align:left;"> 
											            <input id="mw008_setCustomPrice" name="mw008_unitPrice" type="radio" class="i-checks"> 
											            Custom Price
											        </span> 
											        <input id="mw008_customPrice" type="text" class="form-control" style="width:100%;height:40px;font-size:14pt;" disabled>
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
											        <input id="mw008_remarks" type="text" class="form-control">
											    </div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-7">
								<div class="row">
									<div class="col-md-12" id="mw008_componentList_mandatory">
										<div class="ibox float-e-margins" style="margin-bottom:0px;">
											<div class="ibox-title" style="background-color:#f3f3f3;">
												<h5>Mandatory Components<span class="label label-warning pull-right" id="mw008_mandatoryComponentCount"></span></h5>
												<div id="mw008_mandatoryPanel_toggle" style="text-align:right;">
													<i id="mw008_mandatory_toggler" class="fa fa-chevron-circle-up" aria-hidden="true" style="cursor:pointer;" onclick="mw008_mandatoryPanel_toggleView(this);"></i>
												</div>
											</div>
							        		<div class="ibox-content" id="mw008_mandatoryPanel">
							        		    <div id="mw008_mandatoryPanel_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
                                                    <div class="sk-rect1"></div>
				                                    <div class="sk-rect2"></div>
				                                    <div class="sk-rect3"></div>
				                                    <div class="sk-rect4"></div>
				                                    <div class="sk-rect5"></div>
                                				</div>
								        		<ul id="mw008_componentList_mandatory_list" class="todo-list m-t small-list">
								        		</ul>
							        		</div>
						        		</div>
									</div>
								</div>
								<div class="row" id="mw008_non_mandatory_selections">
									<div class="col-md-12">
										<div class="ibox float-e-margins" style="margin-bottom:0px;">
											<div class="ibox-title" style="background-color:#f3f3f3;">
												<h5>Optional Selections <span class="label label-warning pull-right" id="mw008_optionalComponentCount"></span></h5>
												<div id="mw008_optionalPanel_toggle" style="text-align:right;">
													<i id="mw008_optional_toggler" class="fa fa-chevron-circle-up" aria-hidden="true" style="cursor:pointer;" onclick="mw008_optionalPanel_toggleView(this);"></i>
												</div>
											</div>
							        		<div class="ibox-content" id="mw008_optionalPanel" style="padding:0px 0px 0px 0px;">
								        		<ul class="todo-list m-t small-list" id="mw008_componentList_selectable" style="margin:0;">
								        		</ul>
							        		</div>
						        		</div>
									</div>
								</div>
							</div>
						</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" onclick="mw008_close();">Save Changes</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>

var mw008_initializing = false;
var mw008_initialized = false;

var mw008_billingRowId = '';
var mw008_billingLineId = '';
var mw008_billingLineObj;

var mw008_itemObj;
var mw008_itemList = [];

var mw008_mandatoryComponentCount = 0;
var mw008_optionalComponentCount = 0;

//var mw008_mandatoryComponentCount_done = 0;
var mw008_optionalComponentList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw008_isOpen()
{
	return ($("#mw008").data('bs.modal') || {}).isShown;	
} // .end of mw008_isOpen

function mw008_init()
{
	if (mw008_initialized==true)
		return false;
	
	// Setup Event Listener
	$('#mw008_setDefaultPrice').on('ifChecked', function(event) {
    	
    	if (mw008_initializing==true)
    		return false;

    	$('#mw008_customPrice').attr('disabled', true);
    	
    	var defaultPrice = Number($('#mw008_defaultPrice').val());
    	mw008_billingLineObj.unitPriceSource = 'default';
    	mw008_billingLineObj.defaultUnitPrice = defaultPrice;
    	//mw008_billingLineObj.subUnitPrice = defaultPrice;
    });
	
    $('#mw008_setCompoundPrice').on('ifChecked', function(event) {
    	
    	if (mw008_initializing==true)
    		return false;

    	$('#mw008_customPrice').attr('disabled', true);
    	
    	var compoundPrice = Number($('#mw008_compoundPrice').val());
    	mw008_billingLineObj.unitPriceSource = 'compound';
    	mw008_billingLineObj.compoundUnitPrice = compoundPrice;
    	//mw008_billingLineObj.subUnitPrice = compoundPrice;
    });

    $('#mw008_setCustomPrice').on('ifChecked', function(event) {
    	
    	if (mw008_initializing==true)
    		return false;
    	
    	$('#mw008_customPrice').attr('disabled', false);
    	$('#mw008_customPrice').focus();
    	$('#mw008_customPrice').select();
    	
    	var customPrice = Number($('#mw008_customPrice').val());
    	mw008_billingLineObj.unitPriceSource = 'custom';
    	mw008_billingLineObj.customUnitPrice = customPrice;
    	//mw008_billingLineObj.subUnitPrice = customPrice;
    });
	
    $("#mw008_customPrice").on("change paste keyup", function() {

    	if (mw008_initializing==true)
    		return false;
    	mw008_billingLineObj.customUnitPrice = Number($(this).val());
    	//mw008_billingLineObj.subUnitPrice = Number($(this).val());
    });
    
    mw008_initialized = true;
} // .end of mw008_init

/**
 * Initiate data into modal window.
 */
function mw008_open(itemId, billingLineRowId, billingLineId)
{	
	if (bil001_isBillingEditable()==false)
		return false;
	
	tycheesOverlay_startShortProgress('loading item...');
	
	mw008_init();	
	mw008_initializing = true;
	mw008_billingRowId = billingLineRowId;
	mw008_billingLineId = billingLineId;
	
	// Reset states
	$('#mw008_mandatory_toggler').removeClass('fa-chevron-circle-up');
	$('#mw008_mandatory_toggler').addClass('fa-chevron-circle-down');
	$('#mw008_mandatoryPanel').hide();
	
	$('#mw008_optional_toggler').removeClass('fa-chevron-circle-up');
	$('#mw008_optional_toggler').addClass('fa-chevron-circle-down');
	$('#mw008_optionalPanel').hide();
							        		
	//$('#mw008_mandatoryPanel_spinner').hide();
	$('.mw008_optionalPanel_spinner').hide();
	
	mw008_mandatoryComponentCount = 0;
    mw008_optionalComponentCount = 0;
    mw008_mandatoryComponentCount_done = 0;
	mw008_optionalComponentList = [];
	
	// Prepare request object
	var requestBody = {
		'appName': APP_NAME_POS,
		'itemId': itemId,
		'fullBean': true
	};
	
	var params = new Object();
	params.itemId = itemId;
	
	tycheesdb_api_getItemById(requestBody, mw008_open_postHandler, params);
} // .end of mw008_open

function mw008_open_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false) 
	{
		tycheesOverlay_stopShortProgress();
		return false;
	}
		
	// Get Item object
	mw008_itemObj = responseObj.itemObj;	
	// Get selected billing line object
	mw008_billingLineObj = billingCommon_getBillingLineByRowId(global_billingObj, mw008_billingRowId);	
	// Perform calculation on Billing Line
	billingCommon_calculateBillingLine(mw008_billingLineObj);
	
	// Item object is not null & line object is not null
	if (mw008_itemObj != null && mw008_billingLineObj != null)
	{
		// Reset
		$('#mw008_defaultPrice').val('');
		$('#mw008_customPrice').val('');
		$('#mw008_finalPrice').val('');
		$('#mw008_remarks').val('');

		// Clear list
		$("#mw008_componentList_mandatory_list").empty();
		$("#mw008_componentList_mandatory_tab").empty();
		$("#mw008_componentList_selectable").empty();
		
		// Hide
		$("#mw008_mandatory_selections").hide();
		
		// Set Values
		$("#mw008_itemName").html(tycheesText_getDisplayText(mw008_billingLineObj.itemName, 0));
		$("#mw008_itemId").val(mw008_billingLineObj.itemId);
		$('#mw008_defaultPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.defaultUnitPrice, 2));
		
		if (mw008_billingLineObj.unitPriceSource=='default')
		{
			$('#mw008_setDefaultPrice').iCheck('check');
			$('#mw008_defaultPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.defaultUnitPrice, 2));
			$('#mw008_compoundPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.compoundUnitPrice, 2));
			$('#mw008_customPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.customUnitPrice, 2));
	    	$('#mw008_customPrice').attr('disabled', true);
		}
		else
		if (mw008_billingLineObj.unitPriceSource=='compound')
		{
			$('#mw008_setCompoundPrice').iCheck('check');
			$('#mw008_defaultPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.defaultUnitPrice, 2));
			$('#mw008_compoundPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.compoundUnitPrice, 2));
			$('#mw008_customPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.customUnitPrice, 2));
	    	$('#mw008_customPrice').attr('disabled', true);
		}
		else
		if (mw008_billingLineObj.unitPriceSource=='custom')
		{
			$('#mw008_setCustomPrice').iCheck('check');
			$('#mw008_defaultPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.defaultUnitPrice, 2));
			$('#mw008_compoundPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.compoundUnitPrice, 2));
			$('#mw008_customPrice').val(tycheesUtil_getSafeNumber(mw008_billingLineObj.customUnitPrice, 2));
	    	$('#mw008_customPrice').attr('disabled', false);
		}
				
		$('#mw008_remarks').val(mw008_billingLineObj.remarks);
		
		var imageUrl = $.trim( mw008_billingLineObj.imageUrl );
        if (imageUrl.length==0)
            imageUrl = 'http://www.ithsc.com/ciscohardwaremaintenance/images/no_product_image_large.png';
		$("#mw008_itemImage").html('<img alt="image" src="' + imageUrl + '">');
		
		// Sort componentList
		mw008_itemObj.componentList.sort(function(a, b){
			return a.seqno - b.seqno;
		});
		
		var totalTaxAmount = 0;
				
		// MANDATORY COMPONENTS ONLY
		$.each(mw008_billingLineObj.lineList, function(k, childLineObj){
    		if (Cached_isDeletedBean(childLineObj)==true)
    			return true;

    		if (childLineObj.mandatory==false)
   				return true;
    		
    		mw008_mandatoryComponentCount++;	
    		
    		var params = new Object();
            params.billingLineObj = childLineObj;
            		
            $.each(mw008_itemObj.componentList, function(i, componentObj) {
            	if (Cached_isDeletedBean(componentObj))
    				return true;
            	if (childLineObj.componentId==componentObj.id)
            	{
                    params.componentObj = componentObj;
                    return false;
            	}
            });
            
            mw008_populateMandatoryItem_postHandler(params);	
        });
        
		// OPTIONAL COMPONENTS ONLY
		var boxNo = 1;
		$.each(mw008_itemObj.componentList, function(i, componentObj){
			
			if (Cached_isDeletedBean(componentObj))
				return true;
			
			if (componentObj.selectable==true)
			{
				tycheesOverlay_startShortProgress('populating optional components...');
			
				// Increment component count
				mw008_optionalComponentCount++;
				
				// Make selector Id compliance with chosen-select
				var selectorId = tycheesText_replaceAll(componentObj.id, '-', '_');
				
				// Init component box
				var htmlLines = '';
				htmlLines += '<div class="ibox float-e-margins" style="margin:0;">';
		        htmlLines += '<div class="ibox-content">';
		        
		        htmlLines += '<div style="font-size:14pt;">';
		        htmlLines += (boxNo++) + '. ' + componentObj.helpText;
		        htmlLines += '<span style="font-size:9pt; color:#337ab7; padding-left:10px; cursor:pointer;" onclick="mw008_toggleOptions(this, \'' + componentObj.id + '\');">';
		        htmlLines += '[SHOW OPTIONS]';
		        htmlLines += '</span>';
		        htmlLines += '</div>';
		        
		        htmlLines += '<span id="component_options_' + selectorId + '" style="display:none;">';
		        htmlLines += '<select id="component_itemGroup_' + selectorId + '" class="chosen-select" style="margin-bottom:5px;" data-placeholder="--- SELECT ITEM GROUP ---">';
		        htmlLines += '<option value="0" selected>--- SELECT ITEM GROUP ---</option>';
		        
		        var component_categoryObj = Cached_getCategoryById(componentObj.categoryId, bil001_categoryList);	
		        // Sort alphabetically, in ascending order
				component_categoryObj.itemGroupList.sort(function(a, b){
					if(a < b) return -1;
			    	if(a > b) return 1;
			    	return 0;
				});
		        
		        var selectedItemGroupList = [];
		        if ($.trim(componentObj.itemGroupList) != '')
		        	selectedItemGroupList = componentObj.itemGroupList.split(',');
		        $.each(component_categoryObj.itemGroupList, function(i, groupName) {
		        	
		            var showItemGroup = false;
		            if (selectedItemGroupList.length == 0)
		            	showItemGroup = true;
		            else
		            {
		            	// If item group found
		            	if ($.inArray($.trim(groupName), selectedItemGroupList) >= 0)
		            		showItemGroup = true;
		            	else
		            		showItemGroup = false;
		            }
		            
		            if (showItemGroup) 
		        		htmlLines += '<option value="' + groupName + '">' + groupName + '</option>';		        		
		        });
		        htmlLines += '</select>';

		        htmlLines += '<div id="component_itemGroup_spinner_' + selectorId + '" class="spiner-example" style="display:none; padding-top:0px; height:30px;">';
	        	htmlLines += '<div class="sk-spinner sk-spinner-wave">';
	        	htmlLines += '<div class="sk-rect1"></div>';
       			htmlLines += '<div class="sk-rect2"></div>';
       			htmlLines += '<div class="sk-rect3"></div>';
				htmlLines += '<div class="sk-rect4"></div>';
				htmlLines += '<div class="sk-rect5"></div>';
				htmlLines += '</div>';
				htmlLines += '</div>';

				htmlLines += '<div id="div_component_itemList_' + selectorId + '" style="display:none;">';
		        htmlLines += '<select id="component_itemList_' + selectorId + '" class="chosen-select" data-placeholder="-- SELECT ITEM --"></select>';
				htmlLines += '<div style="font-size:9pt; color:#337ab7; padding-left:10px; cursor:pointer; padding-top:5px;" onclick="mw008_addOptionalItem(\'' + componentObj.id + '\');">';
		        htmlLines += '<i class="fa fa-plus" aria-hidden="true"></i> ADD ITEM';
		        htmlLines += '</div>';		        
				htmlLines += '</div>';
		        
				htmlLines += '</span>';
		        
		        htmlLines += '<div id="mw008_optionalPanel_spinner_' + selectorId + '" class="sk-spinner sk-spinner-wave mw008_optionalPanel_spinner" style="display:none;">';
                htmlLines += '<div class="sk-rect1"></div>';
				htmlLines += '<div class="sk-rect2"></div>';
				htmlLines += '<div class="sk-rect3"></div>';
				htmlLines += '<div class="sk-rect4"></div>';
				htmlLines += '<div class="sk-rect5"></div>';
                htmlLines += '</div>';
		        
				htmlLines += '<ul id="component_selected_itemList_' + selectorId + '" class="todo-list m-t small-list" style="display:none;">';
		        htmlLines += '</ul>';
		        
		        htmlLines += '</div>';
		        htmlLines += '</div>';
		        
		        // Add component box into modal window
				$('#mw008_componentList_selectable').append(htmlLines);

				// Init Chosen-Select component
	            $('#component_itemGroup_'+selectorId).chosen({
	            	width:"100%",
	            	allow_single_deselect:true, 
	            	search_contains: true
	            });
	            $('#component_itemList_'+selectorId).chosen({
	            	width:"100%",
	            	allow_single_deselect:true, 
	            	search_contains: true
	            });
	            
				// Event Listener:
			    // triggered when user select/deselect item group from list.
		        $('#component_itemGroup_'+selectorId).on('change', function(evt, params) {
		        	mw008_onItemGroupChanged(componentObj.id, componentObj.categoryId, params);
		        });
		        
	            // List out selected item(s)
		        var billingLineObj;
	            var selectedItemCount = 0;
            	$.each(mw008_billingLineObj.lineList, function(k, childLineObj){
            		if (Cached_isDeletedBean(childLineObj)==true)
	        			return true;

            		if (componentObj.id != childLineObj.componentId)
           				return true;
            		
            		selectedItemCount ++;
            		
            		var params = new Object();
            		params.selectorId = selectorId;
            		params.componentObj = componentObj;
            		params.billingLineObj = childLineObj;
            		
            		mw008_populateOptionalItem_postHandler(params);
	        	});
				
				var optionalComponentState = new Object();
				optionalComponentState.selectorId = selectorId;
				optionalComponentState.selectedItemCount = selectedItemCount;
				optionalComponentState.loadCompletedCount = 0;
				
				mw008_optionalComponentList.push(optionalComponentState);
				
            	if (selectedItemCount > 0)
            	{
            		$('#component_selected_itemList_'+selectorId).show();
            		// Show Spinner
            		//$('#mw008_optionalPanel_spinner_'+selectorId).show();
            	}
			}
		});
		
		$('#mw008_mandatoryComponentCount').html(mw008_mandatoryComponentCount);
		$('#mw008_optionalComponentCount').html(mw008_optionalComponentCount);
		
		if (mw008_mandatoryComponentCount > 0) 
		{
			//$('#mw008_mandatoryPanel_spinner').show();
			$('#mw008_mandatory_toggler').click();
		}
		
		if (mw008_optionalComponentCount > 0) 
		{
			$('#mw008_optional_toggler').click();
		}
		
	    // set state
		mw008_initializing = false;
		
		// Show Modal Window
		module_showModalWindow('mw008', true);
	}	
	else
	{
		// Error
		tycheesLogger_showToast('error','Unexpected System Error','Please contact us to fix this.')
	}
	
	tycheesOverlay_stopShortProgress();
} // .end of mw008_open_postHandler

function mw008_populateMandatoryItem_postHandler(params)
{
	if (params.billingLineObj != null)
	{
		// Init component box
		var htmlLines = mw008_getSelectableComponentHtml(params.componentObj, params.billingLineObj, false);			    
	    $('#mw008_componentList_mandatory_list').append(htmlLines);
		// Calculate total price
		if (params.componentObj != null)
			mw008_onQuantityChanged(params.componentObj.id, params.billingLineObj.itemId);	

		// Init checkbox 
		// (CAUTIOUS: do not call tycheesCommon_initCheckBox second time, it may invalidate previously set event handlers).
		$('.mandatory-component-checkbox').iCheck({
	        checkboxClass: 'icheckbox_square-green',
	        radioClass: 'iradio_square-green'
	    });		

		// Event Listeners
		$('.mandatory-component-checkbox').on('ifChecked', function(event){
			mw008_onMandatoryItemChecked(this, true);
	    });
	    $('.mandatory-component-checkbox').on('ifUnchecked', function(event){
			mw008_onMandatoryItemChecked(this, false);
	    });
	}
} // .end of mw008_populateMandatoryItem_postHandler

function mw008_populateOptionalItem_postHandler(params)
{
	var htmlLines = mw008_getSelectableComponentHtml(params.componentObj, params.billingLineObj, false);			    
    $('#component_selected_itemList_'+params.selectorId).append(htmlLines);
} // .end of mw008_populateOptionalItem_postHandler

/**
 * Show/Hide options of selected component. 
 */
function mw008_toggleOptions(selector, componentId)
{
	var selectorId = tycheesText_replaceAll(componentId, '-', '_');
	var cssDisplay = $('#component_options_'+selectorId).css('display');
	if (cssDisplay=='none') 
	{
		$('#component_options_'+selectorId).show();
		$(selector).html('[HIDE OPTIONS]');
	}
	else
	{
		$('#component_options_'+selectorId).hide();
		$(selector).html('[SHOW OPTIONS]');
	}
} // .end of mw008_toggleOptions

/**
 * Expand / Collapse mandatory view
 *
 * @param showing	true if show; false if hide. 
 */
function mw008_mandatoryPanel_toggleView(element)
{
	var expand;
	
	if ( $(element).hasClass('fa-chevron-circle-up') )
		expand = false;
	else
		expand = true;
	
	if (expand)
	{
		var  htmlLines = '<i id="mw008_mandatory_toggler" class="fa fa-chevron-circle-up" aria-hidden="true" style="cursor:pointer;" onclick="mw008_mandatoryPanel_toggleView(this);"></i>';
		
		$('#mw008_mandatoryPanel_toggle').html(htmlLines);
		$('#mw008_mandatoryPanel').show();
	}
	else
	{
		var  htmlLines = '<i id="mw008_mandatory_toggler" class="fa fa-chevron-circle-down" aria-hidden="true" style="cursor:pointer;" onclick="mw008_mandatoryPanel_toggleView(this);"></i>';
	
		$('#mw008_mandatoryPanel_toggle').html(htmlLines);
		$('#mw008_mandatoryPanel').hide();
	}	
	
} // .end of mw008_mandatoryPanel_toggleView

/**
 * Expand / Collapse optional view
 */
function mw008_optionalPanel_toggleView(element)
{
	var expand;
	
	if ( $(element).hasClass('fa-chevron-circle-up') )
		expand = false;
	else
		expand = true;
	
	if (expand)
	{
		var  htmlLines = '<i id="mw008_optional_toggler" class="fa fa-chevron-circle-up" aria-hidden="true" style="cursor:pointer;" onclick="mw008_optionalPanel_toggleView(this);"></i>';
		
		$('#mw008_optionalPanel_toggle').html(htmlLines);
		$('#mw008_optionalPanel').show();
	}
	else
	{
		var  htmlLines = '<i id="mw008_optional_toggler" class="fa fa-chevron-circle-down" aria-hidden="true" style="cursor:pointer;" onclick="mw008_optionalPanel_toggleView(this);"></i>';
	
		$('#mw008_optionalPanel_toggle').html(htmlLines);
		$('#mw008_optionalPanel').hide();
	}		
} // .end of mw008_optionalPanel_toggleView

/**
 * Update data on Modal Window.
 */
function mw008_updateUI()
{
	// Re-calculate billing line.
	billingCommon_calculateBillingLine( mw008_billingLineObj );
	
	// Compound Unit Price
	$('#mw008_compoundPrice').val( tycheesUtil_getSafeNumber(mw008_billingLineObj.compoundUnitPrice, 2) );
} // .end of mw008_updateUI

/**
 * Event Listener: item group name changed in selected component. 
 */
function mw008_onItemGroupChanged(componentId, categoryId, params)
{
	var selectorId = tycheesText_replaceAll(componentId, '-', '_');
	// Show loading spinner
	$('#component_itemGroup_spinner_' + selectorId).show(); 
    // Hide Chosen-select of component
    $("#component_itemList_" + selectorId + '_chosen').hide();
    
	var selectedItemGroup = params.selected;
	var deselectedItemGroup = params.deselected;
	
	if (selectedItemGroup != null)
	{
		if (selectedItemGroup=='0')
		{
			// hide loading spinner
			$('#component_itemGroup_spinner_' + selectorId).hide(); 
			// hide item list
			$("#div_component_itemList_" + selectorId).hide();
			return false;
		}
		
		var requestBody = {
			'appName': APP_NAME_POS,
			'categoryId': categoryId,
			'filterByGroupName': true,
			'groupName': selectedItemGroup,
			'fullBean': false,
			'viewBean': true
		};
	
		var params = new Object();
		params.componentId = componentId;
		params.categoryId = categoryId;
		params.itemGroupName = selectedItemGroup;
	
		// Ajax Call
		tycheesdb_api_getItemsByCategory(requestBody, mw008_onItemGroupChanged_postHandler, params);
	}
	
	if (deselectedItemGroup != null)
	{
		
	}
} // .end of mw008_onItemGroupChanged

function mw008_onItemGroupChanged_postHandler(successFlag, responseObj, params)
{
	// Sort alphabetically, in ascending order
	responseObj.itemViewList.sort(function(a, b){
		if(a.name < b.name) return -1;
    	if(a.name > b.name) return 1;
    	return 0;
	});

    // Add to cache
	Cached_addItemList( responseObj.itemViewList );
    
    // Generate selector Id
    var selectorId = tycheesText_replaceAll(params.componentId, '-', '_');
    
    // Remove all item from list
	$("#component_itemList_" + selectorId).empty();
	$("#component_itemList_" + selectorId).append('<option value="0">--- SELECT ITEM GROUP ---</option>');
	
	// Iterate each item object inside selected (category, itemGroup), perform:
	// 1. Set item as selected, if current item in iteration exists in billing line, OR
	// 2. otherwise, set it as deselected. 
    $.each(responseObj.itemViewList, function(j, childItemObj) {	       
    	
    	if (childItemObj==null)
    		return true;
    		        	
    	// check if this item selected
    	var itemSelected = false;
    	var selectedBillingLineObj;
    	$.each(mw008_billingLineObj.lineList, function(k, childBillingLineObj){
    		if (Cached_isDeletedBean(childBillingLineObj)==true)
    			return true;
    		
    		if (params.componentId==childBillingLineObj.componentId && 
    			childItemObj.id==childBillingLineObj.itemId)
    		{
    			itemSelected = true;
    			selectedBillingLineObj = childBillingLineObj;
    		}
    	});
    	
    	$("#component_itemList_"+selectorId).append('<option value="' + childItemObj.id + '">' + childItemObj.name + '</option>');
    });
	$('#component_itemList_'+selectorId).trigger('chosen:updated');
    
	// Hide loading spinner
	$('#component_itemGroup_spinner_' + selectorId).hide(); 
    // Show Chosen-select of component
    $("#component_itemList_" + selectorId + '_chosen').show();
    // Show item list
    $('#div_component_itemList_' + selectorId).show();
} // .end of mw008_onItemGroupChanged_postHandler

function mw008_addOptionalItem(componentId)
{
	// Generate selector ID
	var selectorId = tycheesText_replaceAll(componentId, '-', '_');
	// Get selected Item from list
	var selectedItemId = $('#component_itemList_'+selectorId).val();
	if (selectedItemId=='0')
	{
		return false;
	}
	
	$.each(mw008_itemObj.componentList, function(i, componentObj) {
		if (componentObj.id == componentId)
		{
			tycheesOverlay_startShortProgress('loading item...');
						
			var requestBody = {
				'appName': APP_NAME_POS,
				'itemId': selectedItemId,
				'fullBean': true
			};
			
			var params = new Object();
			params.itemId = selectedItemId;
			params.componentObj = componentObj;
			
			tycheesdb_api_getItemById(requestBody, mw008_addOptionalItem_postHandler, params);
		}
	});
	
} // .end of mw008_addOptionalItem

/**
 * Add selected item as billing line. 
 */
function mw008_addOptionalItem_postHandler(successFlag, responseObj, params)
{
	tycheesOverlay_stopShortProgress();
	
	if (responseObj.itemObj != null)
	{
		mw008_itemList.push(responseObj.itemObj);
		
		var newBillingLineObj = billingCommon_createBillingLine(global_billingObj, responseObj.itemObj);

		var selectorId = tycheesText_replaceAll(params.componentObj.id, '-', '_');
		
		var htmlLines = mw008_getSelectableComponentHtml(params.componentObj, newBillingLineObj, true);	    
	    $('#component_selected_itemList_' + selectorId).append(htmlLines);
	    $('#component_selected_itemList_' + selectorId).show();
		
		// Create selectable component panel
		mw008_processSelectableComponents(responseObj.itemObj, params.componentObj, responseObj.itemObj, 0);
	    // Calculate total price
		mw008_onQuantityChanged(params.componentObj.id, responseObj.itemObj.id);		
	}
} // .end of mw008_addOptionalItem_postHandler

function mw008_removeOptionalItem(componentId, itemId, billingLineId)
{
	// Remove from object
	$.each(mw008_billingLineObj.lineList, function(i, childLineObj) {
		if (billingLineId != null)
		{
			if (childLineObj.id == billingLineId)
			{
				Cached_deleteBean(childLineObj);
				return false;
			}
		}
		else
		{
			if (childLineObj.componentId == componentId && childLineObj.itemId == itemId)
			{
				Cached_deleteBean(childLineObj);
				return false;
			}
		}
	});
	
	// Remove from UI
	var selectorId = 'selectable-component-item-' + componentId + '-' + itemId;
	$('#'+selectorId).remove();
} // .end of mw008_removeOptionalItem

function mw008_onQuantityChanged(componentId, itemId)
{
	var newQuantityVal = $("#quantity-"+componentId+"-"+itemId).val();
	var totalVal = 0;	
	
	$.each(mw008_billingLineObj.lineList, function(i, lineObj){
		
		if (lineObj.componentId==componentId && lineObj.itemId==itemId)	{
			lineObj.quantity = Number(newQuantityVal);
			$("#totalPrice-"+componentId+"-"+itemId).val( tycheesUtil_getSafeNumber(lineObj.quantity * lineObj.totalUnitPrice, 2) );
		}
		
		totalVal = totalVal + (lineObj.quantity * lineObj.totalUnitPrice);
	});

	// Update total unit price for root billing line
	mw008_billingLineObj.totalUnitPrice = Number(totalVal);
	// Update total unit price on screen.
	$("#mw008_billingAmount").html('$' + tycheesUtil_getSafeNumber(totalVal, 2));
}

/**
 * Event Listener: When user check/uncheck item in mandatory component list.
 */
function mw008_onMandatoryItemChecked(element, isChecked)
{
	var billingLineId = $(element).attr('id');
	
	if (isChecked)
	{
		$('#mandatory-checkbox-'+billingLineId).css('text-decoration','none');
	}
	else
	{
		$('#mandatory-checkbox-'+billingLineId).css('text-decoration','line-through');
	}
	 
	$.each(mw008_billingLineObj.lineList, function(i, childLineObj){
		if (childLineObj.id == billingLineId)
			childLineObj.ignored = !isChecked;
	});	
} // .end of mw008_onMandatoryItemChecked

/**
 * Show/hide modal window.
 *
 * @param showing		true if show; false if hide. 
 */
function mw008_processSelectableComponents(rootItemObj, rootComponentObj, itemObj, componentCount)
{
	$.each(itemObj.componentList, function(i, componentObj){
		
		// Show Selectable, means selectable=true
		if (componentObj.selectable==true)
		{
			componentCount = componentCount + 1;
			mw008_addSelectableComponent(rootItemObj, rootComponentObj, itemObj, componentObj, componentCount);
		}
		
		// Recursive call: Check components of sub item
        var itemList = Cached_getItemListByComponent( componentObj );
		$.each(itemList, function(index, subItemObj){
	  		componentCount = mw008_processSelectableComponents(rootItemObj, rootComponentObj, subItemObj, componentCount);
	  	});
	});
	
	return componentCount;
} // .end of mw008_processSelectableComponents 

/**
 * Add selectable components as chosen-select
 */
function mw008_addSelectableComponent(rootItemObj, rootComponentObj, itemObj, componentObj, componentCount)
{/*
	var selectorId = tycheesText_replaceAll(componentObj.id, '-', '_');
	
	var chosenSelect = '<select id="component_itemList_' + selectorId + '" data-placeholder="-- SELECT --" class="chosen-select" tabindex="' + componentCount + '"><option value=""></option></select>';
	if (componentObj.selectionMode=='multiple')
		chosenSelect = '<select id="component_itemList_' + selectorId + '" data-placeholder="-- SELECT --" class="chosen-select" tabindex="' + componentCount + '" multiple><option value=""></option></select>';
				
	var htmlLines = '';
	htmlLines += '<div class="selectionBox">';
	htmlLines += '<h4>' + componentCount + '. ' + componentObj.helpText + '</h4>';
    htmlLines += chosenSelect;
    htmlLines += '<ul class="todo-list m-t small-list" id="component_selected_itemList_' + selectorId + '">';
    htmlLines += '</ul>';
	htmlLines += '</div>';
    
    $('#tab-'+mw008_billingRowId+'-'+rootComponentObj.id+'-'+rootItemObj.id).append(htmlLines);
    */
    // Build list of selection into component box's chosen-select
    /*var itemList = Cached_getItemListByComponent( componentObj );
    $.each(itemList, function(j, childItemObj) {	       
    		        	
    	// check if this item selected
    	var itemSelected = false;
    	var selectedBillingLineObj;
    	$.each(mw008_billingLineObj.lineList, function(k, childBillingLineObj){
    		if (componentObj.id==childBillingLineObj.componentId && childItemObj.id==childBillingLineObj.itemId)
    		{
    			itemSelected = true;
    			selectedBillingLineObj = childBillingLineObj;
    		}
    	});
    	
    	if (itemSelected==true) 
    	{	        		
            $("#component_itemList_" + selectorId).append('<option value="' + childItemObj.id + '" selected>' + childItemObj.name + '</option>');
            // Add item entry
    		mw008_addSelectedItem(childItemObj.id, componentObj, selectedBillingLineObj);
    	}
    	else
    	{
    		$("#component_itemList_" + selectorId).append('<option value="' + childItemObj.id + '">' + childItemObj.name + '</option>');
    	}
    });
    
    // Init Chosen-Select component
    $('#component_itemList_' + selectorId).chosen({
    	width:"100%",
    	allow_single_deselect:true,
    	search_contains: true
    });*/
} // .end of mw008_addSelectableComponent

/**
 * Recursive call to check if any optional selection within this itemObj.
 */
function mw008_countOptionalSelectionsInItem(itemObj, checkList)
{
	var count = 0;
	if (checkList==null)
		checkList = [];
	
	var repeatItemFound = false;
	if ($.inArray(itemObj.id, checkList) >= 0)
		repeatItemFound = true;
	
	if (repeatItemFound)
		return 0;
	
	checkList.push(itemObj.id);
	
	if (itemObj != null && itemObj.componentList != null)
	{
		$.each(itemObj.componentList, function(i, componentObj){
	
			// Show Selectable, means selectable=true
			if (componentObj.selectable==true)
				count = count + 1;
			
			// Recursive call: Check components of sub item
	        var itemList = Cached_getItemListByComponent( componentObj );
			$.each(itemList, function(index, subItemObj){
				count = count + mw008_countOptionalSelectionsInItem(subItemObj, checkList);
		  	});
		});
	}
	
	return count;
} // .end of mw008_countOptionalSelectionsInItem

/**
 * Get selectable components as selection in html. 
 */
function mw008_getSelectableComponentHtml(componentObj, billingLineObj, isNewItem)
{
	var componentId = '';
	var componentDefaultQuantity = 1;
	var componentAllowDefaultQuantityOnly = true;
	var componentSelectable = false;
	
	if (componentObj == null) {
		componentId = tycheesCommon_generateUUID();
		componentDefaultQuantity = 1;
		componentAllowDefaultQuantityOnly = true;
		componentSelectable = false;
	} else {
		componentId = componentObj.id;
		componentDefaultQuantity = componentObj.defaultQuantity;
		componentAllowDefaultQuantityOnly = componentObj.allowDefaultQuantityOnly;
		componentSelectable = componentObj.selectable;
	}
	
	// Prepare to populate data on div element
	var quantityVal = componentDefaultQuantity;
	var taxVal = 0;
	var discountVal = 0;
	var selectorId = tycheesText_replaceAll(componentId, '-', '_');
	
	if (billingLineObj != null) 
	{		
		quantityVal = billingLineObj.quantity;
	}

    var quantityInput = '<input type="number" id="quantity-' + componentId + '-' + billingLineObj.itemId + '" step="any" min="0.001" required value="' + quantityVal + '" style="width:60px;text-align:center;" onchange="mw008_onQuantityChanged(\'' + componentId + '\',\'' + billingLineObj.itemId + '\');">';
    if (componentAllowDefaultQuantityOnly==true)
    	quantityInput = '<input type="number" id="quantity-' + componentId + '-' + billingLineObj.itemId + '" value="' + quantityVal + '" style="width:60px;text-align:center;" disabled>';
	
	var taxOrDiscountInput = '';
	if (billingLineObj.itemType==InventoryConstants.ITEM_TYPE_TAX)
	{
		taxOrDiscountInput = '<input type="number" id="taxOrDiscount-' + componentId + '-' + billingLineObj.itemId + '" value="' + taxVal + '" style="width:60px;text-align:center;" disabled>';
	}
	if (billingLineObj.itemType==InventoryConstants.ITEM_TYPE_DISCOUNT)
	{
		taxOrDiscountInput = '<input type="number" id="taxOrDiscount-' + componentId + '-' + billingLineObj.itemId + '" value="' + discountVal + '" style="width:60px;text-align:center;" disabled>';
	}
	
	var unitPriceVal = 0;
	if (billingLineObj.unitPriceSource=='default')
		unitPriceVal = billingLineObj.defaultUnitPrice;
	if (billingLineObj.unitPriceSource=='compound')
		unitPriceVal = billingLineObj.compoundUnitPrice;
	if (billingLineObj.unitPriceSource=='custom')
		unitPriceVal = billingLineObj.customUnitPrice;
	
	var unitPriceInput = '<input type="number" id="unitprice-' + componentId + '-' + billingLineObj.itemId + '" step="any" min="0.01" required value="' + unitPriceVal + '" style="width:80px;text-align:center;" onchange="mw008_onQuantityChanged(\'' + componentId + '\',\'' + billingLineObj.itemId + '\');">';
    if (componentAllowDefaultQuantityOnly==true)
    	unitPriceInput = '<input type="number" id="unitprice-' + componentId + '-' + billingLineObj.itemId + '" value="' + unitPriceVal + '" style="width:80px;text-align:center;" disabled>';
	
	var totalPriceVal = Number(quantityVal) * Number(unitPriceVal);
	var totalPriceInput = '<input type="number" id="totalPrice-' + componentId + '-' + billingLineObj.itemId + '" value="' + tycheesUtil_getSafeNumber(totalPriceVal, 2) + '" style="width:80px;text-align:center;" disabled>';
	
	// Set new item flag
	var newItemClass = '';
	if (isNewItem)
		newItemClass = 'newItem';
		
	// Init component box
	var htmlLines = '';
    if (componentSelectable==true)
    	htmlLines += '<li class="selectable ' + newItemClass + '" id="selectable-component-item-' + componentId + '-' + billingLineObj.itemId + '">';
    else
    	htmlLines += '<li id="selectable-component-item-' + componentId + '-' + billingLineObj.itemId + '">';
    htmlLines += '<input type="hidden" id="itemId" value="' + billingLineObj.itemId + '">';
    htmlLines += '<input type="hidden" id="itemName" value="' + billingLineObj.itemName + '">';
    htmlLines += '<input type="hidden" id="componentId" value="' + componentId + '">';
    htmlLines += '<div class="row">';
    htmlLines += '<div class="col-md-6" align="left">';
    
    if (billingLineObj != null)
    {
    	if (billingLineObj.mandatory == true)
    	{
		    var checkedVal = '';
		    var textDecor = 'text-decoration:line-through';
		  	if (billingLineObj.ignored == false)
		  	{
		  		checkedVal = 'checked';
		  		textDecor = '';
		  	}
		  		
		  	htmlLines += '<input type="checkbox" class="i-checks mandatory-component-checkbox" id="' + billingLineObj.id + '" ' + checkedVal +' /> ';
		    htmlLines += '<span class="m-l-xs" id="mandatory-checkbox-' + billingLineObj.id + '" style="font-size:16px;' + textDecor + '">';    
		    htmlLines += billingLineObj.itemName;
		    htmlLines += '</span>';
    	}
    	else
    	{
    		htmlLines += '<span class="m-l-xs" style="font-size:16px;">';   
    	    htmlLines += '<i class="fa fa-times" aria-hidden="true" style="color:#FF0000; cursor: pointer;" onclick="mw008_removeOptionalItem(\'' + componentId + '\',\'' + billingLineObj.itemId + '\',\'' + billingLineObj.id +  '\');"></i> ';
    	    htmlLines += billingLineObj.itemName;
    	    htmlLines += '</span>';
    	}
    }
    else
   	{
	    htmlLines += '<span class="m-l-xs" style="font-size:16px;">';   
	    htmlLines += '<i class="fa fa-times" aria-hidden="true" style="color:#FF0000; cursor: pointer;" onclick="mw008_removeOptionalItem(\'' + componentId + '\',\'' + billingLineObj.itemId + '\');"></i> ';
	    htmlLines += billingLineObj.itemName;
	    htmlLines += '</span>';
   	}    
    
    //htmlLines += selectableFlag;
    htmlLines += '</div>';
    htmlLines += '<div class="col-md-6" align="right">';
    
	if (billingLineObj.itemType==InventoryConstants.ITEM_TYPE_TAX || 
	    billingLineObj.itemType==InventoryConstants.ITEM_TYPE_DISCOUNT)
	{
    	htmlLines += 'Amount: ';
    	htmlLines += taxOrDiscountInput;
	}
    
    htmlLines += ' Quantity: ';
    htmlLines += quantityInput;
    htmlLines += '</div>';
    htmlLines += '</div>';
    htmlLines += '</li>';			    
    
    return htmlLines;
} // .end of mw008_getSelectableComponentHtml

function mw008_save()
{
	mw008_billingLineObj.hasChanged = true;
	
	// Craete billing line objects based on user selection
	mw008_build_billingLine_from_userSelection();
    // Auto-save Billing
	bil001_menuPanel_save();
	// Reload Billing lines panel
	bil001_cartPanel_updateUI();
} // .end of mw008_save

function mw008_close()
{
	// If validation failed, then do not continue.
	if($("#mw008_form")[0].checkValidity() == false)
	{
		tycheesLogger_showToast('error', 'Missing Value(s)', 'Please fill out the field(s).');
		return false;
	}

	// Set Remarks
	mw008_billingLineObj.remarks = $('#mw008_remarks').val();

	// Save
	mw008_save();
	// Hide modal window
    module_closeModalWindow('mw008');
} // .end of mw008_close

/**
 * Helper function.
 * - Create new billing line for each required item(s) under this Billing Line 
 *   (Item)
 */
function mw008_build_billingLine_from_userSelection()
{
	// During modal window initialization, do not read any user selection.
	if (mw008_initializing == false)
	{
		// Step 1: extract selected item from OPTIONAL components
		$('#mw008').find('.newItem').each(function(i){ 		

			var childItemId = $.trim( $(this).find('#itemId').val() );
			var childItemName = $.trim( $(this).find('#itemName').val() );
			var componentId = $.trim( $(this).find('#componentId').val() );
			var childItemObj = Cached_getItemById(childItemId, mw008_itemList);
			
			// Create new billingLine object.
			var currentBillingLineObj = billingCommon_createBillingLine(global_billingObj, childItemObj);	
			currentBillingLineObj.componentId = componentId;
			currentBillingLineObj.parentLineId = mw008_billingLineObj.id;
			currentBillingLineObj.mandatory = false;

			if (currentBillingLineObj == null)	{
				tycheesLogger_showToast('error','System Error','Unable to set value into billing lines.');
			}
			else {
				currentBillingLineObj.selected = true; ///$(this).find('.i-checks').is(":checked");
				currentBillingLineObj.quantity = Number( $.trim( $(this).find('#quantity-'+componentId+'-'+childItemId).val() ) );
				
				mw008_billingLineObj.lineList.push(currentBillingLineObj);
			}
			
			$(this).removeClass('newItem');
		});		
	}	 
	
	mw008_updateUI();
} // .end of mw008_build_billingLine_from_userSelection

</script>