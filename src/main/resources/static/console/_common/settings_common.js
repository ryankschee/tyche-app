/**
 * Get properties object from place settingsList.
 * 
 * @param {PlaceBean} placeObj - Place Object
 * @param {String} moduleId - Module ID
 * @param {String} subModuleId - Sub module ID
 * @param {String} propKey - Properties Key
 * @returns {String} properties value; otherwise empty string.
 */
function settingsCommon_getSettingsValue(moduleId, subModuleId, propKey) {
    var placeObj = tycheesCommon_getCurrentPlaceObject();

    var foundObj;
    $.each(placeObj.settingsList, function(i, settingsObj) {
        if (settingsObj.moduleId == moduleId &&
            settingsObj.subModuleId == subModuleId &&
            settingsObj.propKey == propKey) {
            foundObj = settingsObj;
            return false;
        }
    });

    if (foundObj == null) {
        tycheesLogger_logError(
            'Unable to find matching settings object for {moduleId:' + moduleId + ', subModuleId:' + subModuleId + ', propKey:' + propKey + '}',
            'settingsCommon_getSettingsObjBy');

        return '';
    }

    if (foundObj.propType == InventoryConstants.PROP_TYPE_BOOLEAN)
        return tycheesUtil_getBooleanValue(foundObj.propValue);
    if (foundObj.propType == InventoryConstants.PROP_TYPE_NUMBER)
        return Number(foundObj.propValue);

    return foundObj.propValue;
} // .end of settingsCommon_getSettingsValue

/**
 * Get html content of input component for given properties object.
 * 
 * @param {CommonPropertiesBean} propertiesObj - Properties Object
 * @param {Array list of string} selectOptionList - option list e.g. ['option1','option2']
 */
function settingsCommon_getInputComponent(propertiesObj, selectOptionList) {
    if (propertiesObj == null)
        return '';

    if (propertiesObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_TEXT) {
        var disabledVal = '';
        if (propertiesObj.editable == false)
            disabledVal = 'disabled';

        var htmlLines = '';
        htmlLines += '<div class="input-group">';
        htmlLines += '<input type="text" class="form-control" id="' + propertiesObj.id + '" name="' + propertiesObj.propName + '" value="' + propertiesObj.propValue + '" ' + disabledVal + '>';
        htmlLines += '<span class="input-group-btn">';
        htmlLines += '<button id="button-' + propertiesObj.id + '" type="button" class="btn btn-primary">';
        htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
        htmlLines += '</button>';
        htmlLines += '</span>';
        htmlLines += '</div>';

        return htmlLines;
    }

    if (propertiesObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_TEXTAREA) {
        var htmlLines = '';
        htmlLines += '<div class="input-group">';
        htmlLines += '<textarea class="form-control" id="' + propertiesObj.id + '" rows="4" cols="50">';
        htmlLines += propertiesObj.propValue;
        htmlLines += '</textarea>';
        htmlLines += '<span style="padding-left:5px; vertical-align:top;" class="input-group-btn">';
        htmlLines += '<button id="button-' + propertiesObj.id + '" class="btn btn-primary" type="submit">';
        htmlLines += '<i class="fa fa-floppy-o" aria-hidden="true"></i>';
        htmlLines += '</button>';
        htmlLines += '</span>';
        htmlLines += '</div>';

        return htmlLines;
    }

    if (propertiesObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_DATE) {
        var dateVal = tycheesDateTime_getFormattedDate_ddMMyyyy((new Date()).getTime());
        if (propertiesObj.propValue == 'TODAY')
            dateVal = 'TODAY';
        else
        if (tycheesDateTime_isValidDate_ddmmyyyy(propertiesObj.propValue) == true)
            dateVal = propertiesObj.propValue;

        var htmlLines = '';
        htmlLines += '<div class="form-group" id="' + propertiesObj.id + '" style="margin-bottom:0px;">';
        htmlLines += '<div class="input-group date">';
        htmlLines += '<span class="input-group-addon">';
        htmlLines += '<i class="fa fa-calendar"></i>';
        htmlLines += '</span>';
        htmlLines += '<input id="datepicker-' + propertiesObj.id + '" type="text" class="form-control" style="height:36px;" value="' + dateVal + '">';
        htmlLines += '<span class="input-group-addon checkbox-inline">';
        htmlLines += '<input id="datepicker-checkbox-' + propertiesObj.id + '" type="checkbox"> ';
        htmlLines += 'Set TODAY only';
        htmlLines += '</span>';
        htmlLines += '</div>';
        htmlLines += '</div>';

        return htmlLines;
    }

    if (propertiesObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_BOOLEAN) {
        var checked = '';
        if (tycheesUtil_getSafeBoolean(propertiesObj.propValue) == true)
            checked = 'checked';

        var htmlLines = '';
        htmlLines += '<div class="onoffswitch">';
        htmlLines += '<input id="' + propertiesObj.id + '" type="checkbox" ' + checked + ' class="onoffswitch-checkbox">';
        htmlLines += '<label class="onoffswitch-label" for="' + propertiesObj.id + '">';
        htmlLines += '<span class="onoffswitch-inner"></span>';
        htmlLines += '<span class="onoffswitch-switch"></span>';
        htmlLines += '</label>';
        htmlLines += '</div>';

        return htmlLines;
    }

    if (propertiesObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_SELECT) {
    	
    	if (selectOptionList == null) {
	        var optionTextList = propertiesObj.propContent.split(',');
	        		
	        var htmlLines = '';
	        htmlLines += '<select id="' + propertiesObj.id + '" class="form-control chosen-select">';
	        htmlLines += '<option value="0">-- SELECT --</option>';

	        $.each(optionTextList, function(index, optionText) {
	            var trimmedText = $.trim(optionText);
	            if (trimmedText.length > 0) {
	                if (trimmedText == $.trim(propertiesObj.propValue))
	                    htmlLines += '<option value="' + trimmedText + '" selected>' + trimmedText + '</option>';
	                else
	                    htmlLines += '<option value="' + trimmedText + '">' + trimmedText + '</option>';
	            }
	        });
	        htmlLines += '</select>';
	
	        return htmlLines;
	        
    	} else {
    		
    		var htmlLines = '';
	        htmlLines += '<select id="' + propertiesObj.id + '" class="form-control chosen-select">';
	        htmlLines += '<option value="0">-- SELECT --</option>';
	        
	        $.each(selectOptionList, function(index, optionObj) {
	            if ($.trim(optionObj.name) != '') {
	                if (optionObj.id == $.trim(propertiesObj.propValue))
	                    htmlLines += '<option value="' + optionObj.id + '" selected>' + optionObj.name + '</option>';
	                else
	                    htmlLines += '<option value="' + optionObj.id + '">' + optionObj.name + '</option>';
	            }
	        });
	        htmlLines += '</select>';
	
	        return htmlLines;
    	}
    }

    if (propertiesObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_SELECT_MULTIPLE) {
        var optionTextList = $.trim(propertiesObj.propContent).split(',');
        var selectedValues = $.trim(propertiesObj.propValue).split(',');

        var htmlLines = '';
        htmlLines += '<select id="' + propertiesObj.id + '" class="form-control chosen-select" multiple>';
        $.each(optionTextList, function(index, optionText) {
            var trimmedText = $.trim(optionText);
            if (trimmedText.length > 0) {
                if ($.inArray(trimmedText, selectedValues) >= 0)
                    htmlLines += '<option value="' + trimmedText + '" selected>' + trimmedText + '</option>';
                else
                    htmlLines += '<option value="' + trimmedText + '">' + trimmedText + '</option>';
            }
        });
        htmlLines += '</select>';

        return htmlLines;
    }
} // .end of settingsCommon_getInputComponent

/**
 * Register created UI component (represents settingsObj) to event listener. 
 * Once value changes detected, it will write into IDB immediately. 
 * 
 * @param {PlaceSettingsBean} settingsObj Object reference of Setting Object.
 */
function settingsCommon_addEventListeners(settingsObj, placeObj) {
    if (settingsObj == null)
        return false;

    // Get current place object
    if (placeObj == null)
    	placeObj = tycheesCommon_getCurrentPlaceObject();

    // LISTENER: Text 
    if (settingsObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_TEXT) {
        $('#button-' + settingsObj.id).on('click', function() {
            settingsObj.propValue = $('#' + settingsObj.id).val();
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        return false;
    }

    // LISTENER: Text Area
    if (settingsObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_TEXTAREA) {
        //$('#' + settingsObj.id).on('input propertychange paste', function() {
        $('#button-' + settingsObj.id).on('click', function() {
            settingsObj.propValue = $('#' + settingsObj.id).val();
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        return false;
    }

    // LISTENER: Date
    if (settingsObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_DATE) {
        $('#datepicker-' + settingsObj.id).datepicker({
            format: 'dd/mm/yyyy',
            todayBtn: "linked",
            keyboardNavigation: false,
            forceParse: false,
            calendarWeeks: true,
            autoclose: true
        });

        $('#datepicker-' + settingsObj.id).datepicker().on('input change', function(e) {
            $('#datepicker-' + settingsObj.id).iCheck('uncheck');

            settingsObj.propValue = $('#datepicker-' + settingsObj.id).val();
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        $('#datepicker-checkbox-' + settingsObj.id).iCheck({
            checkboxClass: 'icheckbox_square-green'
        });

        if (settingsObj.propValue == 'TODAY')
            $('#datepicker-checkbox-' + settingsObj.id).iCheck('check');

        $('#datepicker-checkbox-' + settingsObj.id).on('ifChecked', function(event) {
            $('#datepicker-' + settingsObj.id).val('TODAY');

            settingsObj.propValue = 'TODAY';
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });
        $('#datepicker-checkbox-' + settingsObj.id).on('ifUnchecked', function(event) {
            var dateVal = tycheesDateTime_getFormattedDate_ddMMyyyy((new Date()).getTime());
            $('#datepicker-' + settingsObj.id).val(dateVal);
            settingsObj.propValue = dateVal;
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        return false;
    }

    // LISTENER: Boolean type
    if (settingsObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_BOOLEAN) {
        $('#' + settingsObj.id).on('change', function() {
            settingsObj.propValue = $('#' + settingsObj.id).prop('checked').toString();
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        return false;
    }

    // LISTENER: Select type
    if (settingsObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_SELECT) {
        $('#' + settingsObj.id).chosen({
            width: '100%',
            search_contains: true
        });

        $('#' + settingsObj.id).on('change', function() {
            settingsObj.propValue = $('#' + settingsObj.id).val();
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        return false;
    }

    // LISTENER: Select multiple type
    if (settingsObj.propType == AppConstants.COMMON_PROPERTIES_TYPE_SELECT_MULTIPLE) {
        $('#' + settingsObj.id).chosen({
            width: '100%',
            search_contains: true
        });

        $('#' + settingsObj.id).on('change', function(event, params) {
            settingsObj.propValue = $('#' + settingsObj.id).val().toString();
            settingsObj.hasChanged = true;
            
            tycheesIO_saveBean(placeObj);
        });

        return false;
    }
} // .end of settingsCommon_addEventListeners
