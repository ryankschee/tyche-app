
/**
 * Create html code for given item properties.
 * 
 * @param {Object} categorProperties - InventorycustomerPropertiesObjBean object.
 * @param {Object} customerPropertiesObj - InventorycustomerPropertiesObjertiesBean object.
 * @returns {String} HTML code; otherwise false.
 */
function customerCommon_createInputComponent(customerPropertiesObj, showSaveButton) {
	if (customerPropertiesObj == null)
		return '';
	if (showSaveButton == null)
		showSaveButton = true;
	
	var setToDefault = false;
	var required = '';
	var asterisk = '';

	if (tycheesText_getSafeString(customerPropertiesObj.propType) == '') {
		if (setToDefault)
			customerPropertiesObj.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="text" class="form-control" id="' + customerPropertiesObj.id + '" value="' + customerPropertiesObj.propValue + '" placeholder="" ' + required + '>';
		if (showSaveButton) {
			htmlLines += '<span class="input-group-btn">';
			htmlLines += '<button id="button-' + customerPropertiesObj.id + '" type="button" class="btn btn-primary">';
			htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
			htmlLines += '</button>';
			htmlLines += '</span>';
		}
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_TEXT) {
		if (setToDefault)
			customerPropertiesObj.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="text" class="form-control" id="' + customerPropertiesObj.id + '" value="' + customerPropertiesObj.propValue + '" placeholder="" ' + required + '>';
		if (showSaveButton) {
			htmlLines += '<span class="input-group-btn">';
			htmlLines += '<button id="button-' + customerPropertiesObj.id + '" type="button" class="btn btn-primary">';
			htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
			htmlLines += '</button>';
			htmlLines += '</span>';
		}
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_NUMBER) {
		if (setToDefault)
			customerPropertiesObj.propValue = 0;

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px;  padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName + ': ';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="number" step="any" class="form-control" id="' + customerPropertiesObj.id + '" value="' + customerPropertiesObj.propValue + '" placeholder="" ' + required + '>';
		if (showSaveButton) {
			htmlLines += '<span class="input-group-btn">';
			htmlLines += '<button id="button-' + customerPropertiesObj.id + '" type="button" class="btn btn-primary">';
			htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
			htmlLines += '</button>';
			htmlLines += '</span>';
		}
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_LIST) {
		if (setToDefault)
			customerPropertiesObj.propValue = '';

		var optionTextList = customerPropertiesObj.propContent.split(',');
		var htmlLines = '';

		htmlLines += '<div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12">';
		htmlLines += '<select class="form-control" id="' + customerPropertiesObj.id + '">';
		$.each(optionTextList, function(index, optionText) {
			var trimmedText = $.trim(optionText);
			if (trimmedText.length > 0) {
				if (trimmedText == customerPropertiesObj.propValue)
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
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_TAG) {
		if (setToDefault)
			customerPropertiesObj.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12">';
		htmlLines += '<input type="number" step="any" class="form-control tagsinput" id="' + customerPropertiesObj.id + '" value="' + customerPropertiesObj.propValue + '" data-role="tagsinput" placeholder="" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_BOOLEAN) {
		if (setToDefault)
			customerPropertiesObj.propValue = 'false';

		var checkedVal = '';
		if (customerPropertiesObj.propValue == 'true' || customerPropertiesObj.propValue == true)
			checkedVal = 'checked';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="padding-left:36px; padding-right:36px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '<div class="switch">';
		htmlLines += '<div class="onoffswitch">';
		htmlLines += '<input type="checkbox" name="collapsemenu" ' + checkedVal + ' class="onoffswitch-checkbox" id="' + customerPropertiesObj.id + '">';
		htmlLines += '<label class="onoffswitch-label" for="' + customerPropertiesObj.id + '">';
		htmlLines += '<span class="onoffswitch-inner"></span>';
		htmlLines += '<span class="onoffswitch-switch"></span>';
		htmlLines += '</label>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_DATE) {
		if (setToDefault)
			customerPropertiesObj.propValue = tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis());

		var htmlLines = '';
		htmlLines += '<label class="control-label input-field-label">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName + ': ';
		htmlLines += '</label>';
		htmlLines += '<div class="form-group my-form-group date-group">';
		htmlLines += '<div class="col-sm-12 input-group date">';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<i class="fa fa-calendar"></i>';
		htmlLines += '</span>';
		htmlLines += '<input id="' + customerPropertiesObj.id + '" type="text" class="form-control"  data-mask="99/99/9999" value="' + tycheesDateTime_getFormattedDate_MMddyyyy(Number(customerPropertiesObj.propValue)) + '" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(customerPropertiesObj.propType) == InventoryConstants.PROP_TYPE_TIME) {
		if (setToDefault)
			customerPropertiesObj.propValue = tycheesDateTime_getFormattedDate_hhmm(tycheesDateTime_getCurrentTimeInMillis());

		var htmlLines = '';
		htmlLines += '<label class="control-label input-field-label">';
		htmlLines += asterisk + ' ' + customerPropertiesObj.propName;
		htmlLines += '</label>';
		htmlLines += '<div class="form-group my-form-group">';
		htmlLines += '<div class="col-sm-12 input-group clockpicker" data-autoclose="true">';
		htmlLines += '<input id="' + customerPropertiesObj.id + '" type="text" class="form-control" value="' + tycheesDateTime_getFormattedDate_hhmm(Number(customerPropertiesObj.propValue)) + '" ' + required + '>';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<span class="fa fa-clock-o"></span>';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else {
		tycheesLogger_logError('No propType matched [' + tycheesText_getSafeString(customerPropertiesObj.propType) + ']', 'inventoryCommon_createInputComponent_withValue');
	}
} // .end of customerCommon_createInputComponent

function customerCommon_createInputComponent_onEvent(customerPropertiesObj, postHandlerFn)
{
    if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_TEXT)
  	{
  		$('#button-' + customerPropertiesObj.id).on('click', function() {
  			postHandlerFn();
  	    });
  	}
      
    if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_NUMBER)
	{	
  		$('#button-' + customerPropertiesObj.id).on('click', function() {
  			postHandlerFn();
  	    });
	}
  	
	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_LIST)
	{
  		$('#' + customerPropertiesObj.id).on('onchange', function(event) {
  			postHandlerFn();
  		});
	}
  	
	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_TAG)
	{
      	$('#' + customerPropertiesObj.id).on('itemAdded', function(event) {
      		postHandlerFn();
  		});
		
  		$('#' + customerPropertiesObj.id).on('itemRemoved', function(event) {
  			postHandlerFn();
  		});

  		$('#' + customerPropertiesObj.id).tagsinput('add', 'test');	// temp, as buffer for first entry
  		$('#' + customerPropertiesObj.id).tagsinput('add', customerPropertiesObj.propValue);
  		$('#' + customerPropertiesObj.id).tagsinput('refresh');
  		
  		// Override CSS's style - width=100%
  		$('.bootstrap-tagsinput').css('width','100%');
  		$('.bootstrap-tagsinput input').css('width','100%');
	}
  	
	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
	{
      	if (customerPropertiesObj.propValue=='true' || customerPropertiesObj.propValue==true)
      		$('#' + customerPropertiesObj.id).prop('checked', true);
      	else
      		$('#' + customerPropertiesObj.id).prop('checked', false);
      	
  		$('#' + customerPropertiesObj.id).on('change', function(event) {
  			postHandlerFn();
  		});
	}	      	
    
    // init for input component type DATE	
    if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_DATE)
    {
    	$('.date-group .input-group.date').datepicker({
	      	todayBtn: "linked",
	      	keyboardNavigation: false,
	      	forceParse: false,
	      	calendarWeeks: true,
	      	autoclose: true
	    }).on('changeDate', function(e) {
	        // 'e' here contains the extra attributes
	    	postHandlerFn();
	    });
   	}

    // init for input component type TIME	
  	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_TIME)
  	{
  		$('.clockpicker').clockpicker({
  			init: function() { 
            	console.log("clockpicker initiated");
        	},
        	afterDone: function() {
            	console.log("after done");
            	postHandlerFn();
            }
  		});
  	}
} // .end of customerCommon_createInputComponent_onEvent

function customerCommon_getInputComponentValue(customerPropertiesObj)
{
    if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_TEXT)
  	{
  		return $.trim( $('#'+customerPropertiesObj.id).val() );
  	}
      
    if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_NUMBER)
	{	
    	return $.trim( $('#'+customerPropertiesObj.id).val() );
	}
  	
	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_LIST)
	{
		return $.trim( $('#'+customerPropertiesObj.id).val() );
	}
  	
	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_TAG)
	{
      	$('#' + customerPropertiesObj.id).on('itemAdded', function(event) {
      		postHandlerFn();
  		});
		
  		$('#' + customerPropertiesObj.id).on('itemRemoved', function(event) {
  			postHandlerFn();
  		});

  		$('#' + customerPropertiesObj.id).tagsinput('add', 'test');	// temp, as buffer for first entry
  		$('#' + customerPropertiesObj.id).tagsinput('add', customerPropertiesObj.propValue);
  		$('#' + customerPropertiesObj.id).tagsinput('refresh');
  		
  		// Override CSS's style - width=100%
  		$('.bootstrap-tagsinput').css('width','100%');
  		$('.bootstrap-tagsinput input').css('width','100%');
	}
  	
	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
	{
		return $('#' + customerPropertiesObj.id).prop('checked');
	}	      	
    
    // init for input component type DATE	
    if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_DATE)
    {
    	return $.trim( $('#'+customerPropertiesObj.id).val() );
   	}

    // init for input component type TIME	
  	if (customerPropertiesObj.propType==InventoryConstants.PROP_TYPE_TIME)
  	{
  		return $.trim( $('#'+customerPropertiesObj.id).val() );
  	}
} // .end of customerCommon_getInputComponentValue