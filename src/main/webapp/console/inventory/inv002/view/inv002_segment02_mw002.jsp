<!-- Modal Window: Add New Item -->
<div class="modal inmodal fade" id="segment02_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-lg4" id="segment02_mw002_frame">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">NEW ITEM</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
	                <div class="col-lg-12">       
                    	<form role="form" id="segment02_mw002_theForm">
		                    <div id="segment02_mw002_statusMessageList" style="display:none;color: red;">
		                    	<span>
		                    	    Status Messages
		                    	</span>
		                    </div>
		                	<div class="tabs-container">
			                    <ul class="nav nav-tabs">
			                        <li id="segment02_mw002_tab_header_1" class="active">
			                            <a data-toggle="tab" href="#segment02_mw002_tab_1"> 
			                                Basic Info
			                            </a>
			                        </li>
			                        <li id="segment02_mw002_tab_header_2">
			                            <a data-toggle="tab" href="#segment02_mw002_tab_2"> 
			                                Additional
			                            </a>
			                        </li>
			                        <li id="segment02_mw002_tab_header_3">
			                            <a data-toggle="tab" href="#segment02_mw002_tab_3"> 
			                                Accessibility
			                            </a>
			                        </li>
			                    </ul>
		                        <div class="tab-content">
		                            <div id="segment02_mw002_tab_1" class="tab-pane active">
		                                <div class="panel-body">
		                                    <fieldset class="form-horizontal" id="tab1-form">     
		                                    	<div class="form-group">
		                                    		<label class="col-sm-4 control-label">
		                                    		    * Item Type:
		                                    		</label>
		                                            <div class="col-sm-8 input-group">
		                                                <select class="form-control" id="segment02_mw002_itemType" name="Item Type">
		                                                	<option value="0">- SELECT -</option>
		                                                	<option value="product">Product</option>
		                                                	<option value="service">Service</option>
		                                                	<option value="event">Event</option>
		                                                	<option value="raw">Raw Material</option>
		                                                	<option value="tax">Tax</option>
		                                                	<option value="discount">Discount</option>
		                                                </select>
		                                            </div>
		                                        </div> 
						                        <div class="hr-line-dashed"></div>
						                        
						                        <div class="row">
						                        	<div class="col-md-12">
						                        		<div id="segment02_mw002_default_fields" style="display:none;">
					                                        <div class="form-group">
					                                    		<label class="col-sm-4 control-label">
					                                    		    * Category:
					                                    		</label>
					                                            <div class="col-sm-8 input-group">
					                                                <select class="form-control" id="segment02_mw002_category" name="Category">
					                                                </select>
					                                            </div>
					                                        </div> 
					                                        <div class="form-group">
					                                        	<label class="col-sm-4 control-label">
					                                        	    * Item Name:	
					                                        	</label>
					                                            <div class="col-sm-8 input-group">
					                                            	<input type="text" class="form-control" id="segment02_mw002_title" name="Item Name" placeholder="Product name" maxlength="90" required>
					                                            </div>
					                                        </div>  
					                                        <div class="form-group">
					                                        	<label class="col-sm-4 control-label">
					                                        	    Item Group:	
					                                        	</label>
					                                            <div class="col-sm-8 input-group">
					                                            	<input type="text" class="form-control" id="segment02_mw002_group" name="Item Group" placeholder="Product group" maxlength="90">
					                                            </div>
					                                        </div>  
					                                        <div class="form-group">
					                                        	<label class="col-sm-4 control-label">
					                                        	    Barcode No:	
					                                        	</label>
					                                            <div class="col-sm-8 input-group">
					                                            	<input type="number" class="form-control" id="segment02_mw002_barcode" name="Barcode Number" placeholder="Barcode Number" maxlength="12">
					                                            	<span class="help-block" id="bean-barcode-message">
					                                            	    <small><i>Enter 12 digits</i></small>
					                                            	</span>
					                                            </div>
					                                        </div>
					                                        <div class="form-group">
					                                        	<label class="col-sm-4 control-label">
					                                        	    Keywords:
					                                        	</label>
					                                            <div class="col-sm-8 input-group">
					                                            	<input type="text" class="form-control" id="segment02_mw002_labels" name="Keywords" placeholder="labels" data-role="tagsinput" maxlength="180">
					                                            	<span class="help-block">
					                                            	    <small><i>Separate with Comma (,)</i></small>
					                                            	</span>
					                                            </div>
					                                        </div>
					                                        <div class="form-group">
					                                        	<label class="col-sm-4 control-label">
					                                        	    Description:
					                                        	</label>
					                                            <div class="col-sm-8 input-group">
					                                            	<input type="text" class="form-control" id="segment02_mw002_shortDescription" name="Description" placeholder="Description" maxlength="180">
					                                            </div>
					                                        </div>         
					                                    </div>
						                        	</div>
						                        </div>								                        
		                                    </fieldset>
		                                </div>
		                            </div> <!-- .end of tab-1 -->		
		                            
		                            <div id="segment02_mw002_tab_2" class="tab-pane">
		                                <div class="panel-body">
		                                    <fieldset class="form-horizontal" id="tab1-form">    
						                        <div class="row">						                        	
						                        	<div class="col-md-12">
						                        		<div id="segment02_mw002_additional_fields1">
						                        			<div class="form-group non-tax-discount">
																<label class="col-sm-4 control-label">
																	* Measurement Unit
																</label>
																<div class="col-sm-8 input-group">
																	<input type="text" class="form-control" id="mw002_additional_measurementUnit" maxlength="90" value="0" required>
																</div>
															</div>
						                        			<div class="form-group non-tax-discount">
																<label class="col-sm-4 control-label">
																	* Unit Cost
																</label>
																<div class="col-sm-8 input-group">
																	<input type="number" step="any" class="form-control" id="mw002_additional_unitCost" maxlength="90" value="0" required>
																</div>
															</div>
						                        			<div class="form-group non-tax-discount">
																<label class="col-sm-4 control-label">
																	* Unit Price
																</label>
																<div class="col-sm-8 input-group">
																	<input type="number" step="any" class="form-control" id="mw002_additional_unitPrice" maxlength="90" value="0" required>
																</div>
															</div>
						                        			<div class="form-group non-tax-discount">
															    <label class="col-sm-4 control-label">
																	Is Quantity Optional?
																</label>
																<div class="col-sm-8">
																	<div class="i-checks">
																	    <label> 
																	        <input id="mw002_additional_quantityOptional" type="checkbox">
																	    </label>
																	</div>
																</div>
															</div>
															<div class="form-group non-tax-discount">
																<label class="col-sm-4 control-label">
																	Quantity
																</label>
																<div class="col-sm-8 input-group">
																	<input type="number" step="any" class="form-control" id="mw002_additional_quantity" maxlength="90" value="0">
																</div>
															</div>
						                        			<div class="form-group non-tax-discount">
																<label class="col-sm-4 control-label">
																	Minimum Quantity
																</label>
																<div class="col-sm-8 input-group">
																	<input type="number" step="any" class="form-control" id="mw002_additional_minimumQuantity" maxlength="90" value="0">
																</div>
															</div>
															<div class="form-group tax">
															    <label class="col-sm-4 control-label">
																	Is Inclusive Tax?
																</label>
																<div class="col-sm-8">
																	<div class="i-checks">
																	    <label> 
																	        <input id="mw002_additional_taxInclusive" type="checkbox">
																	    </label>
																	</div>
																</div>
															</div>
															<div class="form-group tax-discount">
																<label class="col-sm-4 control-label">
																	Percentage (%)
																</label>
																<div class="col-sm-8 input-group">
																	<input type="number" step="any" class="form-control" id="mw002_additional_taxDiscountPercentage" maxlength="90" value="0" required>
																</div>
															</div>
															<div class="form-group tax-discount">
																<label class="col-sm-4 control-label">
																	Amount
																</label>
																<div class="col-sm-8 input-group">
																	<input type="number" step="any" class="form-control" id="mw002_additional_taxDiscountAmount" maxlength="90" value="0" required>
																</div>
															</div>
						                        		</div>
						                        		<div id="segment02_mw002_additional_fields2">
						                        		</div>
						                        	</div>
						                        </div>								                        
		                                    </fieldset>
		                                </div>
		                            </div> <!-- .end of tab-2 -->	
		                            <div id="segment02_mw002_tab_3" class="tab-pane">
		                                <div class="panel-body">
		                                    <fieldset class="form-horizontal" id="tab1-form"> 
						                        <div class="row">
						                        	<div class="col-md-12">
						                        		<div id="segment02_mw002_accessibility_fields">
						                        			<div class="form-group">
															    <label class="col-sm-4 control-label">
																	POS Visible?
																</label>
																<div class="col-sm-8">
																	<div class="i-checks">
																	    <label> 
																	        <input id="mw002_accessibility_posVisible" type="checkbox">
																	    </label>
																	</div>
																</div>
															</div>
															<div class="form-group">
															    <label class="col-sm-4 control-label">
																	PWS Visible?
																</label>
																<div class="col-sm-8">
																	<div class="i-checks">
																	    <label> 
																	        <input id="mw002_accessibility_pwsVisible" type="checkbox">
																	    </label>
																	</div>
																</div>
															</div>
						                        		</div>
						                        	</div>
						                        </div>								                        
		                                    </fieldset>
		                                </div>
		                            </div> <!-- .end of tab-3 -->			                            				                            
		                        </div><!-- ./end of tab-content -->
		                    </div><!-- end of tab-container -->
                		</form>
	                </div><!--./end of col-lg-12 -->
	            </div><!--./end of row -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
				<button type="button" class="btn btn-primary" onclick="segment02_mw002_create();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Create Item</button>
			</div>
		</div>
	</div>
</div>

<script>

var segment02_mw002_callbackFn;
var segment02_mw002_callbackFnParams;
var segment02_mw002_categoryId;
var segment02_mw002_categoryName;
var segment02_mw002_groupName;
var segment02_mw002_itemGroupingList;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment02_mw002_isOpen()
{
	return ($("#segment02_mw002").data('bs.modal') || {}).isShown;	
} // .end of segment02_mw002_isOpen

/**
 * Segment Init.
 */
function segment02_mw002_init()
{
	$("#segment02_mw002_category").empty();
	
    //******
   	// Setup Category options
  	$("#segment02_mw002_category").append('<option value="0">- Select Parent Class -</option>');
  	
	$.each(Cached_getCategoryList(), function(index, categoryObj) {
		
		var systemDefinedClass = '';
		if (categoryObj.id.startsWith('system-'))
			systemDefinedClass = ' (System Defined)';
		
		htmlLines = '<option value="' + categoryObj.id + '">' + categoryObj.name + systemDefinedClass + '</option>';
		$("#segment02_mw002_category").append(htmlLines);
	});
	// .end of Setup Category options
	
    $(".chosen-select").chosen({
    	width: "100%",
    	allow_single_deselect: true,
    	search_contains: true
    });
    
    // On value changes - Item Type
	$( "#segment02_mw002_itemType" ).change(function() {
		var selectedItemType = $(this).val();
		segment02_mw002_onchange_itemType(selectedItemType);
	});
	
	// On value changes - Category
	$( "#segment02_mw002_category" ).change(function() {
		var selectedCategoryId = $(this).val();
		segment02_mw002_onchange_category(selectedCategoryId);
	});
	
	// EVENT LISTENER: On key typed
    $("#segment02_mw002_title").keyup(function() {
    	
    });

	// Reset states and values
	$('#segment02_mw002_itemType').prop('selectedIndex', 0);
	$("#segment02_mw002_category").prop('selectedIndex', 0);
	$("#segment02_mw002_title").val('');
	$("#segment02_mw002_group").val('');
	$("#segment02_mw002_barcode").val('');
	$("#segment02_mw002_labels").tagsinput('removeAll');
	$("#segment02_mw002_shortDescription").val('');	
	
	$('#segment02_mw002_theForm :input').each(function() {
 		// reset to white
 		if(this.type=="text" || this.type=="number" || this.type=="textarea" || this.type=="select-one")
 			$(this).css('background-color','#FFFFFF'); 		
	});
	$("#segment02_mw002_statusMessageList").empty();
	$("#segment02_mw002_statusMessageList").hide();
	
	// Hide inherited fields panel
	$('#segment02_mw002_additional_fields2').empty();
	$('#segment02_mw002_additional_fields2').hide();
	
	segment02_mw002_onchange_itemType('0');

	$('#segment02_mw002').on('shown.bs.modal', function () {
	    $("#segment02_mw002_title").focus();
	})
} // .end of segment02_mw001_init

/**
 * This function get distinct values of item group name from list of provided 
 * items.
 */
function initItemGroup(itemList, itemGroupList)
{
	itemGroupList = [];
	$.each(itemList, function(i, itemObj){
		if (itemObj.groupName != null && itemObj.groupName.length>0)
		{
			var inList = false;
			$.each(itemGroupList, function(j, itemGroupObj){
				if (itemObj.categoryId==itemGroupObj.categoryId && itemObj.groupName==itemGroupObj.name)
				{
					inList = true;
				}
			});
			
			if (inList==false)
			{
				var newItemGroupObj = createNew_InventoryItemGroup();
				newItemGroupObj.categoryId = itemObj.categoryId;
				newItemGroupObj.name = newItemGroupObj.groupName;
				itemGroupList.push(newItemGroupObj);
			}
		}	
	});
} // .end of initItemGroup

/**
 * Open Modal Window.
 */
function segment02_mw002_open(categoryId, groupName, postHandlerFn, postHandlerFnParams)
{
	// Set callback function/params
	segment02_mw002_callbackFn = postHandlerFn;
	segment02_mw002_callbackFnParams = postHandlerFnParams;
	segment02_mw002_categoryId = categoryId;
	segment02_mw002_groupName = groupName;
	
	// Init
	segment02_mw002_init();
	// Reset to Tab 1
	$('#segment02_mw002_tab_header_1').addClass('active');
	$('#segment02_mw002_tab_1').addClass('active');
	$('#segment02_mw002_tab_header_2').removeClass('active');
	$('#segment02_mw002_tab_2').removeClass('active');
	$('#segment02_mw002_tab_header_3').removeClass('active');
	$('#segment02_mw002_tab_3').removeClass('active');
	// Get category object
	var categoryObj = Cached_getCategoryById(categoryId);
	
	$('#segment02_mw002_itemType').val(categoryObj.itemType);
	segment02_mw002_onchange_itemType(categoryObj.itemType);
	$('#segment02_mw002_itemType').prop('disabled',true);
	
	$('#segment02_mw002_category').val(categoryId);
	segment02_mw002_onchange_category(categoryId);
	$('#segment02_mw002_category').prop('disabled',true);
	
	if (groupName == null || groupName == '')
	{
		$('#segment02_mw002_group').val('');
		$('#segment02_mw002_group').prop('disabled',false);		
	}
	else
	{
		$('#segment02_mw002_group').val(groupName);
		$('#segment02_mw002_group').prop('disabled',true);	
	}
	
	// TAB 2
	if (categoryObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
	    categoryObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
	    categoryObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
	    categoryObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT)
	{
		$('.non-tax-discount').show();
		$('.tax-discount').hide();
		$('.tax').hide();
	}
	else
    if (categoryObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT)
    {
    	$('.non-tax-discount').hide();
		$('.tax-discount').show();
		$('.tax').hide();
    }
    else
    if (categoryObj.itemType == InventoryConstants.ITEM_TYPE_TAX)
    {
    	$('.non-tax-discount').hide();
		$('.tax-discount').show();
		$('.tax').show();
    }
	
	// Show Modal Window
	module_showModalWindow('segment02_mw002', true);	
} // .end of segment02_mw002_open

/**
 * Response to user action on button 'Create Item' at item modal window. 
 */ 
function segment02_mw002_create()
{
	// Clear status message
 	$("#segment02_mw002_statusMessageList").empty();
 	$("#segment02_mw002_statusMessageList").hide();

    // Form Validation Check
 	var inputValidity = true;
    $('#segment02_mw002_theForm :input').each(function()
	{
 		// reset to white
 		if(this.type=="text" || this.type=="number" || this.type=="textarea" || this.type=="select-one")
 			$(this).css('background-color','#FFFFFF');
 		
 		if(this.id=='bean-class' && $(this).val()=='0')
 		{
 	 		inputValidity = false;
 	        $(this).css('background-color','#F6CECE');
  	      	$("#segment02_mw002_statusMessageList").append("Invalid Field: " + this.name + "<br/>");  			
 		}
 		
 		// Field with invalid value
  	    if(this.validity.valid==false)
  	    {
  	    	// Set flag to false
  	    	inputValidity = false;
  	    	
  	        //$(this).focus();
  	        $(this).css('background-color','#F6CECE');  	        
  	      	$("#segment02_mw002_statusMessageList").append("Invalid Field: " + this.name + "<br/>");
  	      	
  	        console.log("Invalid Field=" + this.name + " [" + this.id + "]");       
  	    }
	});
    // Form Validation Check - END
	    
    if (inputValidity==false)
    {
        // Print fields with error validation
 		$("#segment02_mw002_statusMessageList").show();
    	return false;
    }
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    // Primary Item Bean
    var newItemObj = createNew_InventoryItem();
    newItemObj.placeId 		= placeObj.id;
    newItemObj.categoryId 	= tycheesText_getSafeString(segment02_mw002_categoryId);
    newItemObj.categoryName = tycheesText_getSafeString(segment02_mw002_categoryName);
    newItemObj.itemType 	= tycheesText_getSafeString($('#segment02_mw002_itemType').val());
    newItemObj.name 		= tycheesText_getSafeString($("#segment02_mw002_title").val());
    newItemObj.groupName 	= tycheesText_getSafeString($("#segment02_mw002_group").val());
    newItemObj.labels 		= tycheesText_getSafeString($("#segment02_mw002_labels").val());
    newItemObj.remarks 		= tycheesText_getSafeString($("#segment02_mw002_shortDescription").val());
    newItemObj.latitude 	= placeObj.latitude;
    newItemObj.longitude 	= placeObj.longitude;
    
    newItemObj.measurementUnit          = $.trim( $('#mw002_additional_measurementUnit').val() );
    newItemObj.unitCost					= Number( $('#mw002_additional_unitCost').val() );
    newItemObj.unitPrice				= Number( $('#mw002_additional_unitPrice').val() );
    newItemObj.quantityOptional			= $('#mw002_additional_quantityOptional').prop('checked')
    newItemObj.quantity					= Number( $('#mw002_additional_quantity').val() );
    newItemObj.minimumQuantity			= Number( $('#mw002_additional_minimumQuantity').val() );
    newItemObj.taxInclusive				= $('#mw002_additional_taxInclusive').prop('checked');
    newItemObj.taxDiscountPercentage	= Number( $('#mw002_additional_taxDiscountPercentage').val() );
    newItemObj.taxDiscountAmount		= Number( $('#mw002_additional_taxDiscountAmount').val() );
    newItemObj.taxDiscountInPercentage  = newItemObj.taxDiscountPercentage > 0 ? true : false;
    newItemObj.taxDiscountInAmount  	= newItemObj.taxDiscountAmount > 0 ? true : false;
    
    newItemObj.posVisible	= $('#mw002_accessibility_posVisible').prop('checked');
    newItemObj.pwsVisible	= $('#mw002_accessibility_pwsVisible').prop('checked');
    
    var itemListInGroup = Cached_getItemListInSameGroup(newItemObj);
    newItemObj.seqnoInGroup = itemListInGroup.length + 1;
    
    //-----
    // Inherited fields
    var selectedCategoryObj;
    $.each(Cached_getCategoryList(), function(index, categoryObj) {
		if (categoryObj.id==newItemObj.categoryId)
		{
			selectedCategoryObj = categoryObj;
		}
	});
    
    if (selectedCategoryObj == null)
    {
    	tycheesLogger_showToast("error","Save Failure","Unable to save item. Please contact us to resolve this problem.");
    }
    else
   	{    	
    	// Field List
	    newItemObj.propertiesList = [];
	    $.each(selectedCategoryObj.propertiesList, function(index, propObj) {
	    	
	    	// Transition to InventoryItemBean
			if (propObj.propKey == InventoryConstants.PROP_KEY_MEASUREMENT_UNIT)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_UNIT_COST)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_UNIT_PRICE)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_QUANTITY)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_MINIMUM_QUANTITY)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_IS_QUANTITY_OPTIONAL)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_PERCENTAGE)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_AMOUNT)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_INCLUSIVE)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_POS_VISIBLE)
				return true;
			if (propObj.propKey == InventoryConstants.PROP_KEY_PWS_VISIBLE)
				return true;
	    	
    		var fieldVal = $("#field-"+propObj.id).val();				
			if (propObj.propType==InventoryConstants.PROP_TYPE_NUMBER)
			{
				// If empty string, then set it to 0
				if ($.trim(fieldVal).length==0)
				{
					fieldVal = '0';
				}
			}
			else
			if (propObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
			{
				if ($("#field-"+propObj.id).prop('checked')==true)
					fieldVal = 'true';
				else
					fieldVal = 'false';
			}						
			
			if (fieldVal==null)
				fieldVal = '';
			
    	    var newItemField = createNew_InventoryItemProperties();
    	    newItemField.itemId = tycheesText_getSafeString(newItemObj.id);
    	    newItemField.categoryId = tycheesText_getSafeString(selectedCategoryObj.id);
			newItemField.categoryPropertiesId = tycheesText_getSafeString(propObj.id);
			newItemField.seqno = propObj.seqno;
			newItemField.propName = tycheesText_getSafeString(propObj.propName);
			newItemField.propKey = tycheesText_getSafeString(propObj.propKey);
			newItemField.propType = tycheesText_getSafeString(propObj.propType);
			newItemField.propValue = tycheesText_getSafeString(fieldVal);
			newItemField.visible = propObj.visible;
				
			newItemObj.propertiesList.push(newItemField);
		});
    
	    // Push to Cache memory
	    Cached_addItem( newItemObj );
	    // Save item to localDB
		tycheesIO_saveBean(newItemObj);
		
		// Close modal window
		$('#segment02_mw002').modal('hide');

		// Invoke Callback
		segment02_mw002_callbackFnParams.newItemObj = newItemObj;
		segment02_mw002_callbackFn(true, segment02_mw002_callbackFnParams);
   	}    
} // .end of segment02_mw002_create

/**
 * Response to user action on selecting item type.  
 */ 
function segment02_mw002_onchange_itemType(itemType)
{	
	console.log('segment02_mw002_onchange_itemType');
	
	if (itemType=='0') 
	{
		$('#segment02_mw002_default_fields').hide();
	} 
	else 
	{	
		$('#segment02_mw002_frame').css('margin-top', '10px');
		
	    //******
	   	// Setup Category options
		$("#segment02_mw002_category").empty();
	  	$("#segment02_mw002_category").append('<option value="0">- Select Parent Class -</option>');
	  	
		$.each(Cached_getCategoryList(), function(index, categoryObj) {
			
			if (categoryObj.itemType==itemType) {
				var systemDefinedClass = '';
				if (categoryObj.id.startsWith('system-'))
					systemDefinedClass = ' (System Defined)';
				
				var htmlLines = '<option value="' + categoryObj.id + '">' + categoryObj.name + systemDefinedClass + '</option>';
				$("#segment02_mw002_category").append(htmlLines);
			}		
		});
		
		$("#segment02_mw002_category").prop('selectedIndex', 0);
		$("#segment02_mw002_title").val('');
		$("#segment02_mw002_group").val('');
		$("#segment02_mw002_barcode").val('');
		$("#segment02_mw002_labels").tagsinput('removeAll');
		$("#segment02_mw002_shortDescription").val('');	
		
		$('#segment02_mw002_theForm :input').each(function() {
	 		// reset to white
	 		if(this.type=="text" || this.type=="number" || this.type=="textarea" || this.type=="select-one")
	 			$(this).css('background-color','#FFFFFF'); 		
		});
		$("#segment02_mw002_statusMessageList").empty();
		$("#segment02_mw002_statusMessageList").hide();

		$('#segment02_mw002_default_fields').show();
		$('#segment02_mw002_additional_fields2').show();
	}
} // .end of segment02_mw002_onchange_itemType

/**
 * Response to user action on selecting category. 
 */ 
function segment02_mw002_onchange_category(categoryId)
{
    $('#segment02_mw002_additional_fields2').empty();
	$('#segment02_mw002_additional_fields2').show();

	if (categoryId=='0')
		return false;
	
	var categoryObj = Cached_getCategoryById(categoryId);
	segment02_mw002_categoryId = categoryId;
	segment02_mw002_categoryName = categoryObj.name
	
	if (categoryObj != null) 
	{
		$.each(categoryObj.propertiesList, function(i, propObj) {	
			
			if (propObj.propKey=='propKeyItemType') 
			{
				// do nothing
			} 
			else 
			{			
				// Transition to InventoryItemBean
				if (propObj.propKey == InventoryConstants.PROP_KEY_MEASUREMENT_UNIT)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_UNIT_COST)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_UNIT_PRICE)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_QUANTITY)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_MINIMUM_QUANTITY)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_IS_QUANTITY_OPTIONAL)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_PERCENTAGE)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_AMOUNT)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_INCLUSIVE)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_POS_VISIBLE)
					return true;
				if (propObj.propKey == InventoryConstants.PROP_KEY_PWS_VISIBLE)
					return true;		    	
				
				var htmlLines = inventoryCommon_createInputComponent_withoutValue(propObj);
				$('#segment02_mw002_additional_fields2').append(htmlLines);
				
				// Handling for diff prop type
	  	    	if (propObj.propType==InventoryConstants.PROP_TYPE_DATE)
	  	    	{
	  		    	tycheesCommon_initDatePicker();
	  	    	}
	  	    	if (propObj.propType==InventoryConstants.PROP_TYPE_TIME)
	  	    	{
	  	    		tycheesCommon_initClockPicker();
	  	    	}
	  	    	if (propObj.propType==InventoryConstants.PROP_TYPE_TAG)
	  	    	{
	  	    		$('.tagsinput').tagsinput('refresh');
	  	    	}
			}
		});
		
		// init iCheck
        tycheesCommon_initCheckBox();
        
        // Init autocomplete for item group
        var availableTags = [];
        /*$.each(segment02_mw002_itemGroupingList, function(index, itemGroup){
        	if (itemGroup.categoryId==selectedClassObj.id)
        	{
        		availableTags.push(itemGroup.name);
        	}
        });*/
        
        $( "#segment02_mw002_group" ).autocomplete({
            source: availableTags
        });
	}
} // .end of segment02_mw002_onchange_category

</script>