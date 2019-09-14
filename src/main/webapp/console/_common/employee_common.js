
/**
 * Create html code for given item properties.
 * 
 * @param {Object} categorProperties - InventoryemployeePropertiesObjBean object.
 * @param {Object} employeePropertiesObj - InventoryemployeePropertiesObjertiesBean object.
 * @returns {String} HTML code; otherwise false.
 */
function employeeCommon_createInputComponent(employeePropertiesObj, showSaveButton) {
	if (employeePropertiesObj == null)
		return '';
	if (showSaveButton == null)
		showSaveButton = true;
	
	var setToDefault = false;
	var required = '';
	var asterisk = '';

	if (tycheesText_getSafeString(employeePropertiesObj.propType) == '') {
		if (setToDefault)
			employeePropertiesObj.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="text" class="form-control" id="' + employeePropertiesObj.id + '" value="' + employeePropertiesObj.propValue + '" placeholder="" ' + required + '>';
		if (showSaveButton) {
			htmlLines += '<span class="input-group-btn">';
			htmlLines += '<button id="button-' + employeePropertiesObj.id + '" type="button" class="btn btn-primary">';
			htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
			htmlLines += '</button>';
			htmlLines += '</span>';
		}
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_TEXT) {
		if (setToDefault)
			employeePropertiesObj.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="text" class="form-control" id="' + employeePropertiesObj.id + '" value="' + employeePropertiesObj.propValue + '" placeholder="" ' + required + '>';
		if (showSaveButton) {
			htmlLines += '<span class="input-group-btn">';
			htmlLines += '<button id="button-' + employeePropertiesObj.id + '" type="button" class="btn btn-primary">';
			htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
			htmlLines += '</button>';
			htmlLines += '</span>';
		}
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_NUMBER) {
		if (setToDefault)
			employeePropertiesObj.propValue = 0;

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px;  padding:0px 35px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px; padding-left:0px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName + ': ';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12 input-group">';
		htmlLines += '<input type="number" step="any" class="form-control" id="' + employeePropertiesObj.id + '" value="' + employeePropertiesObj.propValue + '" placeholder="" ' + required + '>';
		if (showSaveButton) {
			htmlLines += '<span class="input-group-btn">';
			htmlLines += '<button id="button-' + employeePropertiesObj.id + '" type="button" class="btn btn-primary">';
			htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
			htmlLines += '</button>';
			htmlLines += '</span>';
		}
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_LIST) {
		if (setToDefault)
			employeePropertiesObj.propValue = '';

		var optionTextList = employeePropertiesObj.propContent.split(',');
		var htmlLines = '';

		htmlLines += '<div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12">';
		htmlLines += '<select class="form-control" id="' + employeePropertiesObj.id + '">';
		$.each(optionTextList, function(index, optionText) {
			var trimmedText = $.trim(optionText);
			if (trimmedText.length > 0) {
				if (trimmedText == employeePropertiesObj.propValue)
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
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_TAG) {
		if (setToDefault)
			employeePropertiesObj.propValue = '';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">';
		htmlLines += '<div class="col-md-12" style="padding-top:5px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-12">';
		htmlLines += '<input type="number" step="any" class="form-control tagsinput" id="' + employeePropertiesObj.id + '" value="' + employeePropertiesObj.propValue + '" data-role="tagsinput" placeholder="" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_BOOLEAN) {
		if (setToDefault)
			employeePropertiesObj.propValue = 'false';

		var checkedVal = '';
		if (employeePropertiesObj.propValue == 'true' || employeePropertiesObj.propValue == true)
			checkedVal = 'checked';

		var htmlLines = '';
		htmlLines += '<div class="setings-item" style="padding-left:36px; padding-right:36px;">';
		htmlLines += '<span style="font-weight:bold;">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName;
		htmlLines += '</span>';
		htmlLines += '<div class="switch">';
		htmlLines += '<div class="onoffswitch">';
		htmlLines += '<input type="checkbox" name="collapsemenu" ' + checkedVal + ' class="onoffswitch-checkbox" id="' + employeePropertiesObj.id + '">';
		htmlLines += '<label class="onoffswitch-label" for="' + employeePropertiesObj.id + '">';
		htmlLines += '<span class="onoffswitch-inner"></span>';
		htmlLines += '<span class="onoffswitch-switch"></span>';
		htmlLines += '</label>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_DATE) {
		if (setToDefault)
			employeePropertiesObj.propValue = tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis());

		var htmlLines = '';
		htmlLines += '<label class="control-label input-field-label">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName + ': ';
		htmlLines += '</label>';
		htmlLines += '<div class="form-group my-form-group date-group">';
		htmlLines += '<div class="col-sm-12 input-group date">';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<i class="fa fa-calendar"></i>';
		htmlLines += '</span>';
		htmlLines += '<input id="' + employeePropertiesObj.id + '" type="text" class="form-control"  data-mask="99/99/9999" value="' + tycheesDateTime_getFormattedDate_MMddyyyy(Number(employeePropertiesObj.propValue)) + '" ' + required + '>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else
	if (tycheesText_getSafeString(employeePropertiesObj.propType) == InventoryConstants.PROP_TYPE_TIME) {
		if (setToDefault)
			employeePropertiesObj.propValue = tycheesDateTime_getFormattedDate_hhmm(tycheesDateTime_getCurrentTimeInMillis());

		var htmlLines = '';
		htmlLines += '<label class="control-label input-field-label">';
		htmlLines += asterisk + ' ' + employeePropertiesObj.propName;
		htmlLines += '</label>';
		htmlLines += '<div class="form-group my-form-group">';
		htmlLines += '<div class="col-sm-12 input-group clockpicker" data-autoclose="true">';
		htmlLines += '<input id="' + employeePropertiesObj.id + '" type="text" class="form-control" value="' + tycheesDateTime_getFormattedDate_hhmm(Number(employeePropertiesObj.propValue)) + '" ' + required + '>';
		htmlLines += '<span class="input-group-addon">';
		htmlLines += '<span class="fa fa-clock-o"></span>';
		htmlLines += '</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		return htmlLines;
	}
	else {
		tycheesLogger_logError('No propType matched [' + tycheesText_getSafeString(employeePropertiesObj.propType) + ']', 'inventoryCommon_createInputComponent_withValue');
	}
} // .end of employeeCommon_createInputComponent

function employeeCommon_createInputComponent_onEvent(employeePropertiesObj, postHandlerFn)
{
    if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_TEXT)
  	{
  		$('#button-' + employeePropertiesObj.id).on('click', function() {
  			postHandlerFn();
  	    });
  	}
      
    if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_NUMBER)
	{	
  		$('#button-' + employeePropertiesObj.id).on('click', function() {
  			postHandlerFn();
  	    });
	}
  	
	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_LIST)
	{
  		$('#' + employeePropertiesObj.id).on('onchange', function(event) {
  			postHandlerFn();
  		});
	}
  	
	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_TAG)
	{
      	$('#' + employeePropertiesObj.id).on('itemAdded', function(event) {
      		postHandlerFn();
  		});
		
  		$('#' + employeePropertiesObj.id).on('itemRemoved', function(event) {
  			postHandlerFn();
  		});

  		$('#' + employeePropertiesObj.id).tagsinput('add', 'test');	// temp, as buffer for first entry
  		$('#' + employeePropertiesObj.id).tagsinput('add', employeePropertiesObj.propValue);
  		$('#' + employeePropertiesObj.id).tagsinput('refresh');
  		
  		// Override CSS's style - width=100%
  		$('.bootstrap-tagsinput').css('width','100%');
  		$('.bootstrap-tagsinput input').css('width','100%');
	}
  	
	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
	{
      	if (employeePropertiesObj.propValue=='true' || employeePropertiesObj.propValue==true)
      		$('#' + employeePropertiesObj.id).prop('checked', true);
      	else
      		$('#' + employeePropertiesObj.id).prop('checked', false);
      	
  		$('#' + employeePropertiesObj.id).on('change', function(event) {
  			postHandlerFn();
  		});
	}	      	
    
    // init for input component type DATE	
    if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_DATE)
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
  	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_TIME)
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
} // .end of employeeCommon_createInputComponent_onEvent


function employeeCommon_getInputComponentValue(employeePropertiesObj)
{
    if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_TEXT)
  	{
  		return $.trim( $('#'+employeePropertiesObj.id).val() );
  	}
      
    if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_NUMBER)
	{	
    	return $.trim( $('#'+employeePropertiesObj.id).val() );
	}
  	
	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_LIST)
	{
		return $.trim( $('#'+employeePropertiesObj.id).val() );
	}
  	
	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_TAG)
	{
      	$('#' + employeePropertiesObj.id).on('itemAdded', function(event) {
      		postHandlerFn();
  		});
		
  		$('#' + employeePropertiesObj.id).on('itemRemoved', function(event) {
  			postHandlerFn();
  		});

  		$('#' + employeePropertiesObj.id).tagsinput('add', 'test');	// temp, as buffer for first entry
  		$('#' + employeePropertiesObj.id).tagsinput('add', employeePropertiesObj.propValue);
  		$('#' + employeePropertiesObj.id).tagsinput('refresh');
  		
  		// Override CSS's style - width=100%
  		$('.bootstrap-tagsinput').css('width','100%');
  		$('.bootstrap-tagsinput input').css('width','100%');
	}
  	
	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
	{
		return $('#' + employeePropertiesObj.id).prop('checked');
	}	      	
    
    // init for input component type DATE	
    if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_DATE)
    {
    	return $.trim( $('#'+employeePropertiesObj.id).val() );
   	}

    // init for input component type TIME	
  	if (employeePropertiesObj.propType==InventoryConstants.PROP_TYPE_TIME)
  	{
  		return $.trim( $('#'+employeePropertiesObj.id).val() );
  	}
} // .end of employeeCommon_getInputComponentValue