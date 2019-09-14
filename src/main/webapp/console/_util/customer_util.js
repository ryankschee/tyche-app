
var COLUMN_HEADER = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

/**
 * genderVal: male/female (case-insensitive)
 */
function customerUtil_getGenderValue(genderVal) 
{
	if (genderVal.toUpperCase()==AppConstants.GENDER_MALE.toUpperCase()) {
		return AppConstants.GENDER_MALE;
	}
	if (genderVal.toUpperCase()==AppConstants.GENDER_FEMALE.toUpperCase()) {
		return AppConstants.GENDER_FEMALE;
	}
	
	return null;
} // .end of customerUtil_getGenderValue

/**
 * dobVal: dd/MM/yyyy
 * return: milliseconds
 */
function customerUtil_getDobValue(dobVal) 
{
	if (tycheesDateTime_isValidDate_ddmmyyyy(dobVal))
		return tycheesDateTime_toMilliseconds_ddMMyyyy(dobVal);
	else
		return null;
} // .end of customerUtil_getDobValue

/**
 * Process batch upload (Customer Basic)
 */
function customerUtil_processBatchUpload_customerBasic(base64) {

	var fileFormatValid = true;
	var excelDoc = new ExcelPlus();
    
	try {
		excelDoc.open(base64.substr(base64.indexOf(",")), {
	        type: 'base64'
	    });
	    // Select Sheet
	    excelDoc.selectSheet('CUSTOMERS');

	    // Read Cells
	    var cellVal_templateName = excelDoc.read("B2");
	    
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    var customerTemplateObj;
	    $.each(placeObj.templateList, function(i, templateObj){
	    	if (Cached_isDeletedBean(templateObj))
	    		return true;
	    	
	    	if (templateObj.moduleId == ModuleConstants.MODULE_RELATION &&
	    		templateObj.templateType == PlaceConstants.TEMPLATE_TYPE_CUSTOMER)
	    	{
	    		if (templateObj.templateName == cellVal_templateName)
	    			customerTemplateObj = templateObj;
	    	}
	    });

	    var result = new Object();
	    result.listForInsert = [];
	    result.listForUpdate = [];
	    result.listForDelete = [];
	
	    // BEGIN from row #4 (row 1-4 are system defined)
	    for (var i = 5; i < 10000; i++) {
	
	        var cellVal_action = $.trim(excelDoc.read("A" + i));
	        var cellVal_ID = $.trim(excelDoc.read("B" + i));
	        var cellVal_customerNo = $.trim(excelDoc.read("C" + i));
	        var cellVal_firstName = $.trim(excelDoc.read("D" + i));
	        var cellVal_lastName = $.trim(excelDoc.read("E" + i));
	        var cellVal_gender = $.trim(excelDoc.read("F" + i));
	        var cellVal_dob = $.trim(excelDoc.read("G" + i));
	        var cellVal_description = $.trim(excelDoc.read("H" + i));
	        
	        if ($.trim(cellVal_action).toUpperCase() == 'DEL' && $.trim(cellVal_ID) != '') {
	            var newCustomerObj = createNew_Customer();
	            newCustomerObj.id = cellVal_ID;
	            newCustomerObj.customerNo = cellVal_customerNo;
	            newCustomerObj.firstName = cellVal_firstName;
	            newCustomerObj.lastName = cellVal_lastName;
	            newCustomerObj.gender = customerUtil_getGenderValue(cellVal_gender);
	            newCustomerObj.dob = customerUtil_getDobValue(cellVal_dob);
	            newCustomerObj.description = cellVal_description;
		
	            result.listForDelete.push(newCustomerObj);
	        }
	
	        if ($.trim(cellVal_action).toUpperCase() == 'UPD') {
	
	            if ($.trim(cellVal_ID) == '') {
	                var newCustomerObj = createNew_Customer();
		            newCustomerObj.customerNo = cellVal_customerNo;
		            newCustomerObj.firstName = cellVal_firstName;
		            newCustomerObj.lastName = cellVal_lastName;
		            newCustomerObj.gender = customerUtil_getGenderValue(cellVal_gender);
		            newCustomerObj.dob = customerUtil_getDobValue(cellVal_dob);
		            newCustomerObj.description = cellVal_description;
		
		            if (customerTemplateObj != null) {
			            // "O" starts from index 8
	                    for (var j = 8; j < COLUMN_HEADER.length; j++) {
	                        var cellVal_propValue = excelDoc.read(COLUMN_HEADER[j] + i);
	                        if ($.trim(cellVal_propValue) != '') {
	                            var cellVal_propName = $.trim(excelDoc.read(COLUMN_HEADER[j] + '3'));
	                            var cellVal_propType = $.trim(excelDoc.read(COLUMN_HEADER[j] + '4'));
	
	                            $.each(customerTemplateObj.propertiesList, function(k, propObj) {
	                                if (propObj.propName == cellVal_propName) {
	                                    var newPropObj = createNew_CustomerProperties();
	                                    newPropObj.customerId = newCustomerObj.id;
	                                    newPropObj.groupName = propObj.groupName;
	                                    newPropObj.propSeqno = propObj.propSeqno;
	                                    newPropObj.propKey = propObj.propKey;
	                                    newPropObj.propName = propObj.propName;
	                                    newPropObj.propType = propObj.propType;
	                                    newPropObj.propContent = propObj.propContent;
	
	                                    if (newPropObj.propType == 'Text')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue);
	                                    if (newPropObj.propType == 'Number')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue);
	                                    if (newPropObj.propType == 'Boolean')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue) == 'Y' ? true : false;
	                                    if (newPropObj.propType == 'List')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue);
	
	                                    if (newCustomerObj.propertiesList == null)
	                                    	newCustomerObj.propertiesList = [];
	                                    newCustomerObj.propertiesList.push(newPropObj);
	                                }
	                            });
	                        }
	                    }
		            }
		            
	                result.listForInsert.push(newCustomerObj); 
	            }
	            else {
	                var newCustomerObj = createNew_Customer();
	                newCustomerObj.id = cellVal_ID;
		            newCustomerObj.customerNo = cellVal_customerNo;
		            newCustomerObj.firstName = cellVal_firstName;
		            newCustomerObj.lastName = cellVal_lastName;
		            newCustomerObj.gender = customerUtil_getGenderValue(cellVal_gender);
		            newCustomerObj.dob = customerUtil_getDobValue(cellVal_dob);
		            newCustomerObj.description = cellVal_description;

		            if (customerTemplateObj != null) {
			            // "O" starts from index 8
	                    for (var j = 8; j < COLUMN_HEADER.length; j++) {
	                        var cellVal_propValue = excelDoc.read(COLUMN_HEADER[j] + i);
	                        if ($.trim(cellVal_propValue) != '') {
	                            var cellVal_propName = $.trim(excelDoc.read(COLUMN_HEADER[j] + '3'));
	                            var cellVal_propType = $.trim(excelDoc.read(COLUMN_HEADER[j] + '4'));
	
	                            $.each(customerTemplateObj.propertiesList, function(k, propObj) {
	                                if (propObj.propName == cellVal_propName) {
	                                    var newPropObj = createNew_CustomerProperties();
	                                    newPropObj.customerId = newCustomerObj.id;
	                                    newPropObj.groupName = propObj.groupName;
	                                    newPropObj.propSeqno = propObj.propSeqno;
	                                    newPropObj.propKey = propObj.propKey;
	                                    newPropObj.propName = propObj.propName;
	                                    newPropObj.propType = propObj.propType;
	                                    newPropObj.propContent = propObj.propContent;
	
	                                    if (newPropObj.propType == 'Text')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue);
	                                    if (newPropObj.propType == 'Number')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue);
	                                    if (newPropObj.propType == 'Boolean')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue) == 'Y' ? true : false;
	                                    if (newPropObj.propType == 'List')
	                                    	newPropObj.propValue = $.trim(cellVal_propValue);
	
	                                    if (newCustomerObj.propertiesList == null)
	                                    	newCustomerObj.propertiesList = [];
	                                    newCustomerObj.propertiesList.push(newPropObj);
	                                }
	                            });
	                        }
	                    }
		            }
		            
	                result.listForUpdate.push(newCustomerObj);
	            }
	        }
	    }
    } catch (err) {
    	tycheesLogger_logError('error: ' + err.message, 'customerUtil_processBatchUpload_customerBasic');
    	return false;
    }

    return result;
} // .end of customerUtil_processBatchUpload_customerBasic

/**
 * Process batch upload (Customer Contact)
 */
function customerUtil_processBatchUpload_customerContact(base64) {

	var fileFormatValid = true;
	var excelDoc = new ExcelPlus();
    
	try {
		excelDoc.open(base64.substr(base64.indexOf(",")), {
	        type: 'base64'
	    });
	    // Select Sheet
	    excelDoc.selectSheet('CUSTOMER CONTACTS');
	
	    var result = new Object();
	    result.listForInsert = [];
	    result.listForUpdate = [];
	    result.listForDelete = [];

	    // BEGIN from row #4 (row 1-4 are system defined)
	    for (var i = 5; i < 10000; i++) {
	
	        var cellVal_action = $.trim(excelDoc.read("A" + i));
	        var cellVal_ID = $.trim(excelDoc.read("B" + i));
	        var cellVal_customerId = $.trim(excelDoc.read("C" + i));
	        var cellVal_customerName = $.trim(excelDoc.read("D" + i));
	        var cellVal_type = $.trim(excelDoc.read("E" + i));
	        var cellVal_countryCode = $.trim(excelDoc.read("F" + i));
	        var cellVal_areaCode = $.trim(excelDoc.read("G" + i));
	        var cellVal_number = $.trim(excelDoc.read("H" + i));
	        var cellVal_extension = $.trim(excelDoc.read("I" + i));
	        var cellVal_defaultContact = $.trim(excelDoc.read("J" + i));
	        
	        if ($.trim(cellVal_action).toUpperCase() == 'DEL' && $.trim(cellVal_ID) != '') {
	            var newContactObj = createNew_CustomerContact();
	            newContactObj.id = cellVal_ID;
	            newContactObj.customerId = cellVal_customerId;
	            newContactObj.type = cellVal_type;
	            newContactObj.countryCode = cellVal_countryCode;
	            newContactObj.areaCode = cellVal_areaCode;
	            newContactObj.phoneNumber = cellVal_number;
	            newContactObj.extension = cellVal_extension;
	            newContactObj.defaultContact = cellVal_defaultContact=='Y' ? true : false;
	            newContactObj.remarks = cellVal_customerName;
		
	            result.listForDelete.push(newContactObj);
	        }
	
	        if ($.trim(cellVal_action).toUpperCase() == 'UPD') {
	
	            if ($.trim(cellVal_ID) == '') {
	                var newContactObj = createNew_CustomerContact();
		            newContactObj.customerId = cellVal_customerId;
		            newContactObj.type = cellVal_type;
		            newContactObj.countryCode = cellVal_countryCode;
		            newContactObj.areaCode = cellVal_areaCode;
		            newContactObj.phoneNumber = cellVal_number;
		            newContactObj.extension = cellVal_extension;
		            newContactObj.defaultContact = cellVal_defaultContact=='Y' ? true : false;
		            newContactObj.remarks = cellVal_customerName;
		
	                result.listForInsert.push(newContactObj);
	            }
	            else {
	            	var newContactObj = createNew_CustomerContact();
		            newContactObj.id = cellVal_ID;
		            newContactObj.customerId = cellVal_customerId;
		            newContactObj.type = cellVal_type;
		            newContactObj.countryCode = cellVal_countryCode;
		            newContactObj.areaCode = cellVal_areaCode;
		            newContactObj.phoneNumber = cellVal_number;
		            newContactObj.extension = cellVal_extension;
		            newContactObj.defaultContact = cellVal_defaultContact=='Y' ? true : false;
		            newContactObj.remarks = cellVal_customerName;
	               	
	                result.listForUpdate.push(newContactObj);
	            }
	        }
	    }
    } catch (err) {
    	tycheesLogger_logError('error: ' + err.message, 'customerUtil_processBatchUpload_customerContact');
    	return false;
    }

    return result;
} // .end of customerUtil_processBatchUpload_customerContact

/**
 * Process batch upload (Customer Email)
 */
function customerUtil_processBatchUpload_customerEmail(base64) {

	var fileFormatValid = true;
	var excelDoc = new ExcelPlus();
    
	try {
		excelDoc.open(base64.substr(base64.indexOf(",")), {
	        type: 'base64'
	    });
	    // Select Sheet
	    excelDoc.selectSheet('CUSTOMER EMAILS');
	
	    var result = new Object();
	    result.listForInsert = [];
	    result.listForUpdate = [];
	    result.listForDelete = [];

	    // BEGIN from row #4 (row 1-4 are system defined)
	    for (var i = 5; i < 10000; i++) {
	
	        var cellVal_action = $.trim(excelDoc.read("A" + i));
	        var cellVal_ID = $.trim(excelDoc.read("B" + i));
	        var cellVal_customerId = $.trim(excelDoc.read("C" + i));
	        var cellVal_customerName = $.trim(excelDoc.read("D" + i));
	        var cellVal_type = $.trim(excelDoc.read("E" + i));
	        var cellVal_email = $.trim(excelDoc.read("F" + i));
	        var cellVal_defaultEmail = $.trim(excelDoc.read("G" + i));
	        
	        if ($.trim(cellVal_action).toUpperCase() == 'DEL' && $.trim(cellVal_ID) != '') {
	            var newEmailObj = createNew_CustomerEmail();
	            newEmailObj.id = cellVal_ID;
	            newEmailObj.customerId = cellVal_customerId;
	            newEmailObj.type = cellVal_type;
	            newEmailObj.emailAddress = cellVal_email;
	            newEmailObj.defaultEmail = cellVal_defaultEmail=='Y' ? true : false;
	            newEmailObj.remarks = cellVal_customerName;
		
	            result.listForDelete.push(newEmailObj);
	        }
	
	        if ($.trim(cellVal_action).toUpperCase() == 'UPD') {
	
	            if ($.trim(cellVal_ID) == '') {
	                var newEmailObj = createNew_CustomerEmail();
	                newEmailObj.customerId = cellVal_customerId;
	                newEmailObj.type = cellVal_type;
	                newEmailObj.emailAddress = cellVal_email;
	                newEmailObj.defaultEmail = cellVal_defaultEmail=='Y' ? true : false;
	                newEmailObj.remarks = cellVal_customerName;
		
	                result.listForInsert.push(newEmailObj);
	            }
	            else {
	            	var newEmailObj = createNew_CustomerEmail();
	            	newEmailObj.id = cellVal_ID;
	            	newEmailObj.customerId = cellVal_customerId;
	            	newEmailObj.type = cellVal_type;
	            	newEmailObj.emailAddress = cellVal_email;
	            	newEmailObj.defaultEmail = cellVal_defaultEmail=='Y' ? true : false;
	            	newEmailObj.remarks = cellVal_customerName;
	               	
	                result.listForUpdate.push(newEmailObj);
	            }
	        }
	    }
    } catch (err) {
    	tycheesLogger_logError('error: ' + err.message, 'customerUtil_processBatchUpload_customerEmail');
    	return false;
    }

    return result;
} // .end of customerUtil_processBatchUpload_customerEmail


/**
 * Process batch upload (Customer Address)
 */
function customerUtil_processBatchUpload_customerAddress(base64) {

	var fileFormatValid = true;
	var excelDoc = new ExcelPlus();
    
	try {
		excelDoc.open(base64.substr(base64.indexOf(",")), {
	        type: 'base64'
	    });
	    // Select Sheet
	    excelDoc.selectSheet('CUSTOMER ADDRESSES');
	
	    var result = new Object();
	    result.listForInsert = [];
	    result.listForUpdate = [];
	    result.listForDelete = [];

	    // BEGIN from row #4 (row 1-4 are system defined)
	    for (var i = 5; i < 10000; i++) {
	
	        var cellVal_action = $.trim(excelDoc.read("A" + i));
	        var cellVal_ID = $.trim(excelDoc.read("B" + i));
	        var cellVal_customerId = $.trim(excelDoc.read("C" + i));
	        var cellVal_customerName = $.trim(excelDoc.read("D" + i));
	        var cellVal_type = $.trim(excelDoc.read("E" + i));
	        var cellVal_attentionTo = $.trim(excelDoc.read("F" + i));
	        var cellVal_streetLine1 = $.trim(excelDoc.read("G" + i));
	        var cellVal_streetLine2 = $.trim(excelDoc.read("H" + i));
	        var cellVal_streetLine3 = $.trim(excelDoc.read("I" + i));
	        var cellVal_postalCode = $.trim(excelDoc.read("J" + i));
	        var cellVal_city = $.trim(excelDoc.read("K" + i));
	        var cellVal_state = $.trim(excelDoc.read("L" + i));
	        var cellVal_country = $.trim(excelDoc.read("M" + i));
	        var cellVal_defaultAddress = $.trim(excelDoc.read("N" + i));
	        
	        if ($.trim(cellVal_action).toUpperCase() == 'DEL' && $.trim(cellVal_ID) != '') {
	            var newAddressObj = createNew_CustomerAddress();
	            newAddressObj.id = cellVal_ID;
	            newAddressObj.customerId = cellVal_customerId;
	            newAddressObj.type = cellVal_type;
	            newAddressObj.attentionTo = cellVal_attentionTo;
	            newAddressObj.streetLine1 = cellVal_streetLine1;
	            newAddressObj.streetLine2 = cellVal_streetLine2;
	            newAddressObj.streetLine3 = cellVal_streetLine3;
	            newAddressObj.postalCode = cellVal_postalCode;
	            newAddressObj.city = cellVal_city;
	            newAddressObj.state = cellVal_state;
	            newAddressObj.country = cellVal_country;
	            newAddressObj.defaultAddress = cellVal_defaultAddress=='Y' ? true : false;
	            newAddressObj.remarks = cellVal_customerName;
		
	            result.listForDelete.push(newAddressObj);
	        }
	
	        if ($.trim(cellVal_action).toUpperCase() == 'UPD') {
	
	            if ($.trim(cellVal_ID) == '') {
	            	var newAddressObj = createNew_CustomerAddress();
	            	newAddressObj.customerId = cellVal_customerId;
	            	newAddressObj.type = cellVal_type;
	            	newAddressObj.attentionTo = cellVal_attentionTo;
	            	newAddressObj.streetLine1 = cellVal_streetLine1;
	            	newAddressObj.streetLine2 = cellVal_streetLine2;
	            	newAddressObj.streetLine3 = cellVal_streetLine3;
	            	newAddressObj.postalCode = cellVal_postalCode;
		            newAddressObj.city = cellVal_city;
		            newAddressObj.state = cellVal_state;
		            newAddressObj.country = cellVal_country;
		            newAddressObj.defaultAddress = cellVal_defaultAddress=='Y' ? true : false;
		            newAddressObj.remarks = cellVal_customerName;
		
	                result.listForInsert.push(newAddressObj);
	            }
	            else {
	            	var newAddressObj = createNew_CustomerAddress();
	            	newAddressObj.id = cellVal_ID;
	            	newAddressObj.customerId = cellVal_customerId;
	            	newAddressObj.type = cellVal_type;
	            	newAddressObj.attentionTo = cellVal_attentionTo;
	            	newAddressObj.streetLine1 = cellVal_streetLine1;
		            newAddressObj.streetLine2 = cellVal_streetLine2;
		            newAddressObj.streetLine3 = cellVal_streetLine3;
		            newAddressObj.postalCode = cellVal_postalCode;
		            newAddressObj.city = cellVal_city;
		            newAddressObj.state = cellVal_state;
		            newAddressObj.country = cellVal_country;
		            newAddressObj.defaultAddress = cellVal_defaultAddress=='Y' ? true : false;
		            newAddressObj.remarks = cellVal_customerName;
	               	
	                result.listForUpdate.push(newAddressObj);
	            }
	        }
	    }
    } catch (err) {
    	tycheesLogger_logError('error: ' + err.message, 'customerUtil_processBatchUpload_customerAddress');
    	return false;
    }

    return result;
} // .end of customerUtil_processBatchUpload_customerAddress
