
function inventoryCommon_getQuantityAvailabilityName(availability) {
	if (availability == InventoryConstants.QUANTITY_AVAILABLE)
		return 'Available';
	if (availability == InventoryConstants.QUANTITY_LOW_STOCK)
		return 'Low Stock';
	if (availability == InventoryConstants.QUANTITY_NO_STOCK)
		return 'No Stock';
	if (availability == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND)
		return 'Error: Invalid Item';
	if (availability == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND)
		return 'Error: Loop Found';
} // .end of inventoryCommon_getQuantityAvailabilityName

/**
 * Create html rendering component, based on given itemProp type.
 * 
 * argument @itemProp is Java type InventoryItemFieldBean.
 * 
 * Supported Types: 
 * InventoryConstants.PROP_TYPE_*
 */
function inventoryCommon_createInputComponent_withoutValue(categoryProperties) {
	if (categoryProperties == null)
		return false;

	var required = '';
	var asterisk = '';
	if (categoryProperties.required == true) {
		required = 'required';
		asterisk = '<span style="color:#FF0000;">*</span>';
	}

	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_TEXT) {
		var htmlLines = '';
		htmlLines += '<div class="form-group">';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="col-sm-8 input-group">';
		htmlLines += '<input type="text" class="form-control" id="field-' + categoryProperties.id + '" name="' + categoryProperties.propName + '" placeholder="" maxlength="90" ' + required + '>';
		htmlLines += '<span class="input-group-btn">';
		htmlLines += '<button id="button-' + categoryProperties.id + '" type="button" class="btn btn-primary">';
		htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
		htmlLines += '</button>';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_NUMBER) {
		var htmlLines = '';
		htmlLines += '<div class="form-group">';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="col-sm-8 input-group">';
		htmlLines += '<input type="number" step="any" class="form-control" id="field-' + categoryProperties.id + '" name="' + categoryProperties.propName + '" placeholder="" maxlength="90" ' + required + '>';
		htmlLines += '<span class="input-group-btn">';
		htmlLines += '<button id="button-' + categoryProperties.id + '" type="button" class="btn btn-primary">';
		htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
		htmlLines += '</button>';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_LIST) {
		var optionTextList = categoryProperties.propContent.split(',');
		var htmlLines = '';
		htmlLines += '<div class="form-group">';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="col-sm-8 input-group">';

		htmlLines += '<select class="form-control" id="field-' + categoryProperties.id + '">';
		$.each(optionTextList, function(index, optionText) {
			var trimmedText = $.trim(optionText);
			if (trimmedText.length > 0)
				htmlLines += '<option value="' + trimmedText + '">' + trimmedText + '</option>';
		});
		htmlLines += '</select>';

		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_TAG) {
		var htmlLines = '';
		htmlLines += '<div class="form-group">';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="col-sm-8 input-group">';
		htmlLines += '<input type="text" class="form-control tagsinput" id="field-' + categoryProperties.id + '" name="' + categoryProperties.propName + '" placeholder="separate each tag with comma (,)" data-role="tagsinput" maxlength="180" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_BOOLEAN) {
		var checkedStatus = '';
		if (categoryProperties.required == true) {
			checkedStatus = 'checked';
		}

		var htmlLines = '';
		htmlLines += '<div class="form-group">';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="col-sm-8">';
		htmlLines += '<div class="i-checks"><label> <input id="field-' + categoryProperties.id + '" type="checkbox" ' + checkedStatus + '></label></div>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_DATE) {
		var htmlLines = '';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="form-group date-group">';
		htmlLines += '<div class="col-sm-8 input-group date">';
		htmlLines += '<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input id="field-' + categoryProperties.id + '" type="text" class="form-control" data-mask="99/99/9999" value="" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_TIME) {
		var htmlLines = '';
		htmlLines += '<label class="col-sm-4 control-label">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="form-group">';
		htmlLines += '<div class="col-sm-8 input-group clockpicker" data-autoclose="true">';
		htmlLines += '<input id="field-' + categoryProperties.id + '" type="text" class="form-control" value="" ' + required + '>';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<span class="fa fa-clock-o"></span>';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else {
		tycheesLogger_logError('No propType matched [' + tycheesText_getSafeString(categoryProperties.propType) + ']', 'inventoryCommon_createInputComponent_withoutValue');
	}
} // .end of inventoryCommon_createInputComponent_withoutValue

/**
 * Create html code for given item properties.
 * 
 * @param {Object} categorProperties - InventoryCategoryPropertiesBean object.
 * @param {Object} itemProp - InventoryItemPropertiesBean object.
 * @returns {String} HTML code; otherwise false.
 */
function inventoryCommon_createInputComponent_withValue(categoryProperties, itemProp) {
	if (categoryProperties == null || itemProp == null)
		return false;

	var setToDefault = false;
	if (itemProp.propValue == null || itemProp.propValue == 'null')
		setToDefault = true;

	var required = '';
	var asterisk = '';
	if (categoryProperties.required == true) {
		required = 'required';
		asterisk = '*';
	}

	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_TEXT) {
		if (setToDefault)
			itemProp.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += categoryProperties.propName.toUpperCase();
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="text" class="form-control" id="' + itemProp.id + '" value="' + itemProp.propValue + '" placeholder="" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_NUMBER) {
		if (setToDefault)
			itemProp.propValue = 0;

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px;  padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += categoryProperties.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="number" step="any" class="form-control" id="' + itemProp.id + '" value="' + itemProp.propValue + '" placeholder="" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_LIST) {
		if (setToDefault)
			itemProp.propValue = '';

		var optionTextList = categoryProperties.propContent.split(',');
		var htmlLines = '';

		htmlLines += '<div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += categoryProperties.propName.toUpperCase();
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12">';
		htmlLines += '<select class="form-control" id="' + itemProp.id + '">';
		$.each(optionTextList, function(index, optionText) {
			var trimmedText = $.trim(optionText);
			if (trimmedText.length > 0) {
				if (trimmedText == itemProp.propValue)
					htmlLines += '<option value="' + trimmedText + '" selected>' + trimmedText + '</option>';
				else
					htmlLines += '<option value="' + trimmedText + '">' + trimmedText + '</option>';
			}
		});
		htmlLines += '</select>';

		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_TAG) {
		if (setToDefault)
			itemProp.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += categoryProperties.propName.toUpperCase();
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12">';
		htmlLines += '<input type="number" step="any" class="form-control tagsinput" id="' + itemProp.id + '" value="' + itemProp.propValue + '" data-role="tagsinput" placeholder="" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_BOOLEAN) {
		if (setToDefault)
			itemProp.propValue = 'false';

		var checkedVal = '';
		if (itemProp.propValue == 'true' || itemProp.propValue == true)
			checkedVal = 'checked';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="padding-left:36px; padding-right:36px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += itemProp.propName.toUpperCase();
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</span>';
		htmlLines += '<div class="switch">';
		htmlLines += '<div class="onoffswitch">';
		htmlLines += '<input type="checkbox" name="collapsemenu" ' + checkedVal + ' class="onoffswitch-checkbox" id="' + itemProp.id + '">';
		htmlLines += '<label class="onoffswitch-label" for="' + itemProp.id + '">';
		htmlLines += '<span class="onoffswitch-inner"></span>';
		htmlLines += '<span class="onoffswitch-switch"></span>';
		htmlLines += '</label>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_DATE) {
		if (setToDefault)
			itemProp.propValue = tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis());

		var htmlLines = '';
		htmlLines += '<label class="control-label input-field-label">';
		htmlLines += itemProp.propName.toUpperCase() + ': ';
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="form-group my-form-group date-group">';
		htmlLines += '<div class="col-sm-12 input-group date">';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<i class="fa fa-calendar"></i>';
		htmlLines += '</span>';
		htmlLines += '<input id="' + itemProp.id + '" type="text" class="form-control"  data-mask="99/99/9999" value="' + tycheesDateTime_getFormattedDate_MMddyyyy(Number(itemProp.propValue)) + '" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(categoryProperties.propType) == InventoryConstants.PROP_TYPE_TIME) {
		if (setToDefault)
			itemProp.propValue = tycheesDateTime_getFormattedDate_hhmm(tycheesDateTime_getCurrentTimeInMillis());

		var htmlLines = '';
		htmlLines += '<label class="control-label input-field-label">';
		htmlLines += itemProp.propName.toUpperCase();
		htmlLines += '<span class="mandatory-field"> ' + asterisk + '</span>'
		htmlLines += '</label>';
		htmlLines += '<div class="form-group my-form-group">';
		htmlLines += '<div class="col-sm-12 input-group clockpicker" data-autoclose="true">';
		htmlLines += '<input id="' + itemProp.id + '" type="text" class="form-control" value="' + tycheesDateTime_getFormattedDate_hhmm(Number(itemProp.propValue)) + '" ' + required + '>';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<span class="fa fa-clock-o"></span>';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else {
		tycheesLogger_logError('No propType matched [' + tycheesText_getSafeString(categoryProperties.propType) + ']', 'inventoryCommon_createInputComponent_withValue');
	}
} // .end of inventoryCommon_createInputComponent_withValue

/*******************************************************************************
 * Check if this itemObj contain the text in:
 * - title
 * - description
 * - barcode
 * - groupName
 * 
 * @itemObj		ref to Item object
 * @text		search text
 * @return		true if item contains text in mentioned fields; false otherwise.
 * 
 * Change Logs
 * -----------
 * 20160807	Ryan Chee	Initial
 */
function isItemContainsText(itemObj, text) {
	if (text == null || text.length == 0)
		return true;

	text = text.toLowerCase();

	if (itemObj.name.toLowerCase().indexOf(text) == -1 &&
		itemObj.remarks.toLowerCase().indexOf(text) == -1 &&
		itemObj.groupName.toLowerCase().indexOf(text) == -1)
		return false;
	else
		return true;
} // .end of isItemContainsText

/*******************************************************************************
 * Get item field's value by field key. 
 * 
 * @itemObj		ref to item object.
 * @propKey	Field key
 * @return		value of item field object; else null if not found. 
 * 
 * Change Logs
 * -----------
 * 20160807	Ryan Chee	Initial
 */
function getItemPropertiesValue_byPropKey(itemObj, propKey) {
	if (itemObj == null || itemObj.propertiesList == null)
		return 'Invalid item Found';
	if (propKey == null || propKey == '')
		return 'Invalid propKey found';

	var fieldValue;
	$.each(itemObj.propertiesList, function(index, propObj) {
		if (propObj.propKey == propKey) {
			fieldValue = propObj.propValue;
		}
	});

	return fieldValue;
} // .end of getItemPropertiesValue_byPropKey

