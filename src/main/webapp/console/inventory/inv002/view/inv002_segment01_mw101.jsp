<!-- Modal Window: Add Category Field -->
<div class="modal inmodal fade" id="segment01_mw101" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">NEW CATEGORY FIELD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
                <div class="form-group">
                	<label>Field Name</label> 
                	<input id="segment01_mw101_propName" type="text" placeholder="Enter the name for this custom field" class="form-control">
                	
					<br/>
                	<label>Field Type</label> 
                	<select id="segment01_mw101_propType" class="form-control" onchange="segment01_mw101_onChange_propType(this);">
					  <option value="Text">Text</option>
					  <option value="Number">Number</option>
					  <option value="List">List</option>
					  <option value="Tag">Tags Input</option>
					  <option value="Boolean">Yes/No</option>
					  <option value="Date">Date</option>
					  <option value="Time">Time</option>
					</select>
					<div id="segment01_mw101_propContent_tags" style="display:none;">
						<br/>
						<label id="segment01_mw101_propContent_label">Selection List <small>(separate each selection with comma)</small></label> 
						<br/>
	                	<input id="segment01_mw101_propContent" type="text" placeholder="" class="form-control" data-role="tagsinput" disabled/>
                	</div>
                	
                	<span id="segment01_mw101_fieldDefaultValueElement">                		
						<br/>
                		<label>Default Value</label> 
                		<input id="segment01_mw101_fieldDefaultValue" type="text" placeholder="Enter the default value." class="form-control">
                	</span>
                	
					<br/>
					<label>Visibility</label> 
					<br/>
					<input type='checkbox' id='segment01_mw101_fieldRequired' class="i-checks" checked /> 
					<label for='segment01_mw101_fieldRequired'>Is this mandatory field?</label>			
					
					<hr style="height:3px;border:none;background-color:#D5D8DC;">
					
					<input type='checkbox' id='segment01_mw101_applyToSubCategories' class="i-checks" /> 
					<label for='segment01_mw101_applyToSubCategories'>Add to Sub Categories and Items</label>	
                	
					
					<input type="hidden" id="segment01_mw101_categoryId" value="" />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment01_mw101_saveChanges();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Add Field</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment01_mw101_callbackFn;
var segment01_mw101_callbackFnParams;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment01_mw101_isOpen()
{
	return ($("#segment01_mw101").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw101_isOpen

/**
 * Triggered by: button 'Add Field' (main screen) was clicked.
 * Action: open Modal Window.
 */ 
function segment01_mw101_init(categoryId) 
{
	// Reset Value
	$("#segment01_mw101_propName").val('');
	$("#segment01_mw101_propType").val('Text');
	$('#segment01_mw101_fieldDefaultValue').val('');
	$("#segment01_mw101_propContent").tagsinput('removeAll');
	$("#segment01_mw101_propContent").prop('disabled', false);
	$("#segment01_mw101_applyToSubCategories").prop('disabled', false);
	// Hidden values
	$('#segment01_mw101_categoryId').val(categoryId);
	
	$('#segment01_mw101').on('shown.bs.modal', function () {
	    $("#segment01_mw101_propName").focus();
	})
}

/**
 * Triggered by: button 'Add Field' (main screen) was clicked.
 * Action: open Modal Window.
 */ 
function segment01_mw101_open(categoryObj, postHandlerFn, postHandlerFnParams) 
{
	segment01_mw101_callbackFn = postHandlerFn;
	segment01_mw101_callbackFnParams = postHandlerFnParams;
	 
	// Init	
	segment01_mw101_init(categoryObj.id);
	// Show Modal Window
	module_showModalWindow('segment01_mw101', false);
} // .end of segment01_mw101_open


/**
 * Get default value, based on user selected field type. 
 */ 
function segment01_mw101_getDefaultValue()
{
	var propType = $('#segment01_mw101_propType').val();
	
	if (propType == InventoryConstants.PROP_TYPE_BOOLEAN)
	{
		return $('#segment01_mw101_fieldDefaultValue').is(":checked");
	}
	else
	if (propType == InventoryConstants.PROP_TYPE_TEXT)
	{
		return $('#segment01_mw101_fieldDefaultValue').val();
	}
	else
	if (propType == InventoryConstants.PROP_TYPE_NUMBER)
	{
		return $('#segment01_mw101_fieldDefaultValue').val();
	}
	else
	if (propType == InventoryConstants.PROP_TYPE_DATE)
	{
		return tycheesDateTime_getCurrentTimeInMillis();
	}
	else
	if (propType == InventoryConstants.PROP_TYPE_TIME)
	{
		return tycheesDateTime_getCurrentTimeInMillis();
	}
	else
	if (propType == InventoryConstants.PROP_TYPE_LIST)
	{
		return $('#segment01_mw101_fieldDefaultValue').val();
	}
	else
	if (propType == InventoryConstants.PROP_TYPE_TAG)
	{
		return $('#segment01_mw101_fieldDefaultValue').val();;
	}
	else
	{
		return "";
	}
} // .end of segment01_mw101_getDefaultValue

/**
 * Response to user selection change on field type.
 */ 
function segment01_mw101_onChange_propType(element)
{
	var selectedValue = $(element).val();
	var htmlLines = '';
	htmlLines += '<br>';
	htmlLines += '<label>Default Value</label>';
	
	if (selectedValue == InventoryConstants.PROP_TYPE_BOOLEAN)
	{
		$('#segment01_mw101_propContent_tags').hide();
		
		// Add input for Default Value
		htmlLines += '<br>';
		htmlLines += '<input type="checkbox" id="segment01_mw101_fieldDefaultValue" class="i-checks" />'; 
		htmlLines += '<br>';
		
		$('#segment01_mw101_fieldDefaultValueElement').empty();
		$('#segment01_mw101_fieldDefaultValueElement').append(htmlLines);
		
		tycheesCommon_initCheckBox();
	}
	else
	if (selectedValue == InventoryConstants.PROP_TYPE_TEXT)
	{
		$('#segment01_mw101_propContent_tags').hide();
		
		// Add input for Default Value
		htmlLines += '<input id="segment01_mw101_fieldDefaultValue" type="text" placeholder="Enter the default value." class="form-control">';
		
		$('#segment01_mw101_fieldDefaultValueElement').empty();
		$('#segment01_mw101_fieldDefaultValueElement').append(htmlLines);
	}
	else
	if (selectedValue == InventoryConstants.PROP_TYPE_NUMBER)
	{
		$('#segment01_mw101_propContent_tags').hide();
		
		// Add input for Default Value
		htmlLines += '<input id="segment01_mw101_fieldDefaultValue" type="number" placeholder="Enter the default value." class="form-control">';
		
		$('#segment01_mw101_fieldDefaultValueElement').empty();
		$('#segment01_mw101_fieldDefaultValueElement').append(htmlLines);
	}
	else
	if (selectedValue == InventoryConstants.PROP_TYPE_DATE)
	{
		$('#segment01_mw101_propContent_tags').hide();
		
		// Add input for Default Value
		$('#segment01_mw101_fieldDefaultValueElement').empty();
	}
	else
	if (selectedValue == InventoryConstants.PROP_TYPE_TIME)
	{
		$('#segment01_mw101_propContent_tags').hide();

		// Add input for Default Value
		$('#segment01_mw101_fieldDefaultValueElement').empty();
	}
	else
	if (selectedValue == InventoryConstants.PROP_TYPE_LIST)
	{
		$('#segment01_mw101_propContent_tags').show();

		// Add input for Default Value
		$('#segment01_mw101_fieldDefaultValueElement').empty();
	}
	else
	if (selectedValue == InventoryConstants.PROP_TYPE_TAG)
	{
		$('#segment01_mw101_propContent_tags').show();

		// Add input for Default Value
		htmlLines += '<br>';
		htmlLines += '<input id="segment01_mw101_fieldDefaultValue" type="text" placeholder="" class="form-control" data-role="tagsinput" />';
		htmlLines += '<br>';
		
		$('#segment01_mw101_fieldDefaultValueElement').empty();
		$('#segment01_mw101_fieldDefaultValueElement').append(htmlLines);
		
		$('#segment01_mw101_fieldDefaultValue').tagsinput();
		
	}
} // .end of segment01_mw101_onChange_propType

/**
 * Save new Field into category.
 */ 
function segment01_mw101_saveChanges()
{
	tycheesOverlay_startShortProgress('Saving...');
	
    // Get values from currently open ModalWindow (Add Field)
    var categoryId =  $('#segment01_mw101_categoryId').val();
	var propName = $("#segment01_mw101_propName").val();
	var propType = $("#segment01_mw101_propType").val();
	var propContent = $("#segment01_mw101_propContent").val();
	var fieldRequired = $("#segment01_mw101_fieldRequired").is(":checked");
	var applyToSub = $('#segment01_mw101_applyToSubCategories').is(":checked");
	var defaultValue = segment01_mw101_getDefaultValue();
    var categoryObj = Cached_getCategoryById(categoryId);
    
	// CHECK #1: If propName is empty
	var errorFound = false;
	if ( $.trim(propName).length==0)
	{
		errorFound = true;
	}
	
	if (errorFound==true) 
	{
		swal({
        	title: 'Invalid Field Name',
            text: 'Please enter a valid Field Name',
            type: "error"
	        },
  	    function(){
  	    });	
		
	    return "ERROR";
	}
	
	// CHECK #2: if name duplication
	var duplicateNameFound = false;
	$.each(categoryObj.propertiesList, function(i, propObj){
	    if (propObj.propName == propName)
	        duplicateNameFound = true;
	});
	
	if (duplicateNameFound==true)
	{		
		swal({
       	   title: 'Duplicated Field Name found',
           text: 'Please enter different field name.',
           type: "error"
	        },
 	    function(){
 	    });	
		
	    return "ERROR";
	}
	
	// NO ERROR, proceed to set value
	var checkedVal = '';
	if (fieldRequired == true)
		checkedVal = 'checked';
	
	var maxSeqno = 0;
	$.each(categoryObj.propertiesList, function(i, propObj){
		if (propObj.seqno > maxSeqno)
			maxSeqno = propObj.seqno;
	});
	
    var newCategoryPropObj = createNew_InventoryCategoryProperties();
    newCategoryPropObj.categoryId = tycheesText_getSafeString(categoryId);
    newCategoryPropObj.seqno = maxSeqno + 1;
    newCategoryPropObj.propName = tycheesText_getSafeString(propName);
    newCategoryPropObj.propKey = tycheesText_getSafeString('propKey' + tycheesText_getSafeString_withoutSpace(propName));
    newCategoryPropObj.propType = tycheesText_getSafeString(propType);
    newCategoryPropObj.propContent = tycheesText_getSafeString(propContent);
    newCategoryPropObj.required = fieldRequired;
    newCategoryPropObj.inherited = false;
    newCategoryPropObj.inheritedCategoryId = '';
    	
    // Push newly created	
    categoryObj.propertiesList.push(newCategoryPropObj);
    // Save to localDB
    tycheesIO_saveBean(categoryObj);
	// Hide modalWindow
	$('#segment01_mw101').modal('hide');
	// Callback
	segment01_mw101_callbackFnParams.categoryObj = categoryObj;
	segment01_mw101_callbackFn(true, segment01_mw101_callbackFnParams);
} // .end of segment01_mw101_saveChanges

/**
 * Add new 'Category Properties' into child category and items. 
 */ 
function segment01_applyToSub(categoryId, rootCategoryPropObj, defaultValue)
{
	// Get list of child category
	var childCategoryList = Cached_getCategoryListByParentId(categoryId);
	
	$.each(childCategoryList, function(i, childCategoryObj){
		
	    var newCategoryPropObj			= createNew_InventoryCategoryProperties();
	    newCategoryPropObj.seqno		= childCategoryObj.propertiesList.length + 1;
	    newCategoryPropObj.propName		= tycheesText_getSafeString(rootCategoryPropObj.propName);
	    newCategoryPropObj.propKey		= tycheesText_getSafeString(rootCategoryPropObj.propKey);
	    newCategoryPropObj.propType		= tycheesText_getSafeString(rootCategoryPropObj.propType);
	    newCategoryPropObj.propContent	= tycheesText_getSafeString(rootCategoryPropObj.propContent);
	    newCategoryPropObj.required		= rootCategoryPropObj.required;
	    	
	    // Push newly created field
	    childCategoryObj.propertiesList.push(newCategoryPropObj);
	    // Save to localDB
	    tycheesIO_saveBean(childCategoryObj);
		
	    // Child items
		var childItemList = Cached_getItemListByCategoryId(childCategoryObj.id);
		$.each(childItemList, function(j, childItemObj) {
			
			var newItemPropObj 					= createNew_InventoryItemProperties();
			newItemPropObj.itemId 				= tycheesText_getSafeString(childItemObj.id);
			newItemPropObj.categoryPropertiesId	= tycheesText_getSafeString(newCategoryPropObj.id);
			newItemPropObj.seqno				= childItemObj.propertiesList.length + 1;
		    newItemPropObj.propName				= tycheesText_getSafeString(newCategoryPropObj.propName);
		    newItemPropObj.propKey				= tycheesText_getSafeString(newCategoryPropObj.propKey);
		    newItemPropObj.propType				= tycheesText_getSafeString(newCategoryPropObj.propType);
		    newItemPropObj.propContent			= tycheesText_getSafeString(newCategoryPropObj.propContent);
	    	newItemPropObj.required				= newCategoryPropObj.required;
	    	newItemPropObj.propValue			= tycheesText_getSafeString(defaultValue);
	    	
	    	childItemObj.propertiesList.push(newItemPropObj);
			
			tycheesIO_saveBean(childItemObj);
		});
		
		// Recursive Call
		segment01_applyToSub(childCategoryObj.id, rootCategoryPropObj);
	});
	
} // .end of segment01_applyToSub

</script>