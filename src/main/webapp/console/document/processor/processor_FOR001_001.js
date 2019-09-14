/**
 * Process document content, by inserting values of billing into it.
 * 
 * @param	documentObj	Document object.
 * @param	billingObj	Billing object.
 * @return				New content with inserted values.
 */
function processDocument_FOR001_001(documentObj, placeDocumentObj, billingObj, userObj) {
	var content = documentObj.docContent;
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var customerObj = Cached_getCustomerById(billingObj.customerId);
	var customerName = '-';
	var customerContact = '-';
	if (customerObj != null) {
		customerName = customerObj.firstName + ' ' + customerObj.lastName;
		customerContact = customerObj.contact;
	}

	var newContent = tycheesText_replaceAll(content, '$_BILLING_NO_$', billingObj.billingNo);
	newContent = tycheesText_replaceAll(newContent, '$_SALES_PERSON_$', userObj.firstName + " " + userObj.lastName);
	newContent = tycheesText_replaceAll(newContent, '$_PRINTED_DATE_$', tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss($.now()));
	newContent = tycheesText_replaceAll(newContent, '$_CUSTOMER_NAME_$', customerName);
	newContent = tycheesText_replaceAll(newContent, '$_CUSTOMER_PHONE_NUMBER_$', customerContact);
	newContent = tycheesText_replaceAll(newContent, '$_FOOTER_NOTES_$', billingObj.remarks);

	var tableContent = '';
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		// Item Object
		var itemObj = Cached_getItemById(lineObj.itemId);

		var cellContent = '';
		cellContent += '<span style="padding-left:10px;font-size:12pt;">' + lineObj.itemName + '</span>';
		cellContent += '<br>';

		// Mandatory
		var mandatoryCount = 0;
		var mandatoryRowNo = 1;
		$.each(lineObj.lineList, function(j, childLineObj) {
			if (Cached_isDeletedBean(childLineObj) == true)
				return true;

			if (childLineObj.mandatory == true) {
				mandatoryCount++;

				if (mandatoryCount == 1) {
					cellContent += '<span style="padding-left:10px;font-weight:bold;">Mandatory</span>';
					cellContent += '<br>';
				}

				var textDecoVal = '';
				if (childLineObj.ignored == true)
					textDecoVal = 'text-decoration: line-through; color: #FF0000;';

				cellContent += '<span style="padding-left:20px;font-weight:normal;' + textDecoVal + '">';
				cellContent += (mandatoryRowNo++) + '. ' + childLineObj.itemName + ' (Qty: ' + childLineObj.quantity + ')';
				cellContent += '</span>';
				cellContent += '<br>';
			}
		});

		cellContent += '<br>';

		// Optional
		var optionalCount = 0;
		var optionalRowNo = 1;
		$.each(lineObj.lineList, function(j, childLineObj) {
			if (Cached_isDeletedBean(childLineObj) == true)
				return true;

			if (childLineObj.mandatory == false) {
				optionalCount++;

				if (optionalCount == 1) {
					cellContent += '<span style="padding-left:10px;font-weight:bold;">Optional</span>';
					cellContent += '<br>';
				}
				cellContent += '<span style="padding-left:20px;font-weight:normal;">' + (optionalRowNo++) + '. ' + childLineObj.itemName + ' (Qty: ' + childLineObj.quantity + ')' + '</span>';
				cellContent += '<br>';
			}
		});

		var lineContent = '<tr>';
		lineContent += '<td style="text-align:left;font-size:12pt;">' + (i + 1) + '</td>';
		lineContent += '<td style="text-align:left;">' + cellContent + '</td>';
		lineContent += '<td style="text-align:right;font-size:12pt;">' + lineObj.quantity + '</td>';
		lineContent += '</tr>';

		tableContent += lineContent;
	});

	newContent = tycheesText_replaceAll(newContent, '$_BILLING_LINE_TABLE_$', tableContent);

	$.each(documentObj.propertiesList, function(i, propObj) {
		newContent = tycheesText_replaceAll(newContent, propObj.propKey, propObj.propValue);
	});

	return newContent;
} // .end of processDocument_FOR001_001


/**
 * Get PDF content of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} BillingBean object.
 * @param {Object} UserBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_FOR001_001_getPDF(documentObj, placeDocumentObj, userObj, billingObj) {
	// 0. Get objects
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);

	// 0.5. Get user-keyin input objects
	/*var propObj_customerName = documentCommon_getPropObjectByKey(placeDocumentObj, '$_CUSTOMER_NAME_$');
	if ($.trim(propObj_customerName.userInput) == '') {
		propObj_customerName.userInput = $.trim(billingObj.customerName);
	}
	var propObj_tinDate = documentCommon_getPropObjectByKey(placeDocumentObj, '$_TIN_DATE_$');
	if ($.trim(propObj_tinDate.userInput) == '') {
		propObj_tinDate.userInput = tycheesDateTime_getFormattedDate_ddMMyyyy(new Date().getTime());
	}*/

	// 0.5. Get system-settings input objects
	//var propObj_footerNotes = documentCommon_getPropObjectByKey(placeDocumentObj, '$_FOOTER_NOTES_$');
	//var propObj_terms = documentCommon_getPropObjectByKey(placeDocumentObj, '$_TERMS_$');

	// 1. Prepare local variables to be display on PDF document
	const c_currency = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY).propValue;
	var l_gstNumber = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GST_TAX_INVOICE_NUMBER).propValue;
	//var l_officeAddress = placeUtil_getDefaultAddress(placeObj);
	//var l_officeAddressList = l_officeAddress.split(".");
	//var l_officePhone = placeUtil_getDefaultContact(placeObj, AppConstants.CONTACT_TYPE_OFFICE);
	//var l_mobilePhone = placeUtil_getDefaultContact(placeObj, AppConstants.CONTACT_TYPE_MOBILE);
	var l_invoiceNo = $.trim(billingObj.invoiceNo) == '' ? consoleCommon_getNextInvoiceNo() : $.trim(billingObj.invoiceNo);
	var l_billingNo = $.trim(billingObj.billingNo);
	var l_companyName = $.trim(placeObj.companyName);
	var l_companyRegistrationNo = $.trim(placeObj.companyRegistrationNo);
	//var l_companyLogoUrl = $.trim(placeObj.logoImageUrl);
	//var l_companyLogoBase64 = companyLogoImageObj == null ? '' : $.trim(companyLogoImageObj.base64);
	var l_customerName = $.trim(billingObj.customerName);
	//var l_tinDate = $.trim(propObj_tinDate.userInput) == 'TODAY' ? tycheesDateTime_getFormattedDate_ddMMyyyy(new Date().getTime()) : $.trim(propObj_tinDate.userInput);
	//var l_footerNotes = $.trim(propObj_footerNotes.propValue);
	//var l_terms = $.trim(propObj_terms.propValue);

	//-------------------
	// 2.0 Prepare PDF doc
	var pdfDoc = new jsPDF('portrait', 'pt', 'a4');
	// Optional - set properties on the document
	pdfDoc.setProperties({
		title: 'Internal Billing: ' + l_billingNo,
		subject: l_invoiceNo,
		author: l_companyName,
		keywords: '',
		creator: l_companyName
	});

	// Header Title
	pdfDoc.setFontSize(18);
	pdfDoc.setFontType('bold');
	pdfDoc.text('INTERNAL BILLING', 210, 40);
	// Header line break
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(30, 50, 565, 50);
	// Company Logo
	//pdfDoc.addImage(l_companyLogoBase64, 'JPEG', 30, 60, 180, 60)
	// Tax Invoice Number
	//pdfDoc.setFontSize(14);
	//pdfDoc.setFontType('normal');
	//pdfDoc.text('Tax Invoice No', 565, 70, 'right');
	//pdfDoc.setFontSize(16);
	//pdfDoc.setTextColor(255, 0, 0);
	//pdfDoc.text(l_invoiceNo, 565, 90, 'right');
	// Customer Name
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontSize(14);
	pdfDoc.setFontType('normal');
	pdfDoc.text('Customer', 30, 70);
	pdfDoc.setFontSize(16);
	pdfDoc.text(l_customerName == '' ? '-' : l_customerName, 30, 90);
	// Billing Number
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontSize(14);
	pdfDoc.setFontType('normal');
	pdfDoc.text('Billing No', 565, 70, 'right');
	pdfDoc.setFontSize(16);
	pdfDoc.text(l_billingNo, 565, 90, 'right');
	// Line Break
	//pdfDoc.setLineWidth(0.05);
	//pdfDoc.line(30, 90, 565, 90);

	// Office Phone
	//pdfDoc.setFontSize(11);
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text(30, 150, 'T/F:');
	//pdfDoc.setFontType('normal');
	//pdfDoc.text(60, 150, l_officePhone);
	// Mobile Phone
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text(30, 165, 'M:');
	//pdfDoc.setFontType('normal');
	//pdfDoc.text(60, 165, l_mobilePhone);
	// Office Address
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text(180, 150, 'ADDR:');
	//pdfDoc.setFontType('normal');
	//$.each(l_officeAddressList, function(i, addressLine) {
	//	if ($.trim(addressLine) == '')
	//		return true;
	//	pdfDoc.text($.trim(addressLine) + '.', 225, 150 + i * 15);
	//});
	// Company Name & Registration No
	//pdfDoc.setFontSize(15);
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text(30, 215, l_companyName + ' (' + l_companyRegistrationNo + ')');
	// GST Number
	//pdfDoc.setFontSize(15);
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text('GST: ' + l_gstNumber, 565, 215, 'right');
	// Line Break
	//pdfDoc.setLineWidth(0.05);
	//pdfDoc.line(30, 220, 565, 220);

	// Customer Name
	//pdfDoc.setFontSize(11);
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text('TO:', 30, 245);
	//pdfDoc.setFontType('normal');
	//pdfDoc.text(l_customerName, 70, 245);
	// Date of Invoice
	//pdfDoc.setFontSize(12);
	//pdfDoc.setTextColor(0, 0, 0);
	//pdfDoc.setFontType('bold');
	//pdfDoc.text('DATE:', 500, 245, 'right');
	//pdfDoc.setFontType('normal');
	//pdfDoc.text(l_tinDate, 565, 245, 'right');

	// Billing Lines: variables
	var billingTable_yOffset = 120;
	// Billing Lines: Table header
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('ITEM', 30, billingTable_yOffset);
	pdfDoc.text('QUANTITY', 250, billingTable_yOffset, 'right');
	pdfDoc.text('REMARKS', 565, billingTable_yOffset, 'right');
	// Billing Lines: Line Break
	billingTable_yOffset += 5;
	pdfDoc.setLineWidth(0.05);
	pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);
	// Billing Lines: Table Content
	pdfDoc.setFontSize(12);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('normal');
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemTyoe == InventoryConstants.ITEM_TYPE_RAW) {

			billingTable_yOffset += 15;

			pdfDoc.text(lineObj.itemName, 30, billingTable_yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 250, billingTable_yOffset, 'right');
			pdfDoc.text(lineObj.remarks, 565, billingTable_yOffset, 'right');

			// Mandatory line(s)
			var mandatoryCount = 0;
			var mandatoryRowNo = 1;
			$.each(lineObj.lineList, function(j, childLineObj) {
				if (Cached_isDeletedBean(childLineObj) == true)
					return true;

				if (childLineObj.mandatory == true) {
					mandatoryCount++;

					if (mandatoryCount == 1) {
						billingTable_yOffset += 15;
						pdfDoc.setFontSize(11);
						pdfDoc.setTextColor(0, 0, 0);
						pdfDoc.setFontType('bold');
						pdfDoc.text('MANDATORY', 45, billingTable_yOffset);
					}

					// Set text style
					pdfDoc.setFontSize(11);
					pdfDoc.setTextColor(0, 0, 0);
					pdfDoc.setFontType('normal');
					// If line is ignored, show strike through
					if (childLineObj.ignored == true) {
						pdfDoc.setLineWidth(0.02);
						pdfDoc.line(30, billingTable_yOffset + 7, 200, billingTable_yOffset + 7);
					}

					// Increment y-axis
					billingTable_yOffset += 15;
					// Prepare printout line
					var htmlLines = '';
					htmlLines += mandatoryRowNo + '. ' + childLineObj.itemName + ' (Qty: ' + childLineObj.quantity + ')';
					// Print to PDF
					pdfDoc.text(htmlLines, 45, billingTable_yOffset);
				}
			});

			// Optional line(s)
			var optionalCount = 0;
			var optionalRowNo = 1;
			$.each(lineObj.lineList, function(j, childLineObj) {
				if (Cached_isDeletedBean(childLineObj) == true)
					return true;

				if (childLineObj.mandatory == false) {
					optionalCount++;

					if (optionalCount == 1) {
						billingTable_yOffset += 15;
						pdfDoc.setFontSize(11);
						pdfDoc.setTextColor(0, 0, 0);
						pdfDoc.setFontType('bold');
						pdfDoc.text('OPTIONAL', 45, billingTable_yOffset);
					}

					// Set text style
					pdfDoc.setFontSize(11);
					pdfDoc.setTextColor(0, 0, 0);
					pdfDoc.setFontType('normal');
					// If line is ignored, show strike through
					if (childLineObj.ignored == true) {
						pdfDoc.setLineWidth(0.02);
						pdfDoc.line(30, billingTable_yOffset + 7, 200, billingTable_yOffset + 7);
					}

					// Increment y-axis
					billingTable_yOffset += 15;
					// Prepare printout line
					var htmlLines = '';
					htmlLines += optionalRowNo + '. ' + childLineObj.itemName + ' (Qty: ' + childLineObj.quantity + ')';
					// Print to PDF
					pdfDoc.text(htmlLines, 45, billingTable_yOffset);
				}
			});

			// Line Break
			billingTable_yOffset += 5;
			pdfDoc.setLineWidth(0.02);
			pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);
		}
	});

	// Billing Table: Discount Items
	/*$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {

			billingTable_yOffset += 15;

			pdfDoc.text(lineObj.itemName, 30, billingTable_yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 350, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalUnitPrice).toFixed(2), 450, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalPrice).toFixed(2), 565, billingTable_yOffset, 'right');
			// Line break
			billingTable_yOffset += 5;
			pdfDoc.setLineWidth(0.05);
			pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);
		}
	});*/

	// Billing Lines: Tax Item
	/*$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {

			billingTable_yOffset += 15;

			pdfDoc.text(lineObj.itemName, 30, billingTable_yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 350, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalUnitPrice).toFixed(2), 450, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalPrice).toFixed(2), 565, billingTable_yOffset, 'right');
			// Line Break
			billingTable_yOffset += 5;
			pdfDoc.setLineWidth(0.05);
			pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);
		}
	});*/

	// Footer
	//billingTable_yOffset += 40;
	//pdfDoc.roundedRect(30, billingTable_yOffset, 535, 140, 5, 5);
	// Footer
	//billingTable_yOffset += 20;
	//var l_footerNotes_result = [];
	//documentCommon_parseHTML4jsPDF(l_footerNotes, l_footerNotes_result);
	//$.each(l_footerNotes_result, function(i, parsedObj) {
	//	pdfDoc.setFontSize(parsedObj.fontSize);
	//	pdfDoc.setTextColor(parsedObj.textColor_R, parsedObj.textColor_G, parsedObj.textColor_B);
	//	pdfDoc.setFontType(parsedObj.fontType);
	//	pdfDoc.text($.trim(parsedObj.text), 45, billingTable_yOffset);
	//	billingTable_yOffset += 15;
	//});
	// Terms
	//billingTable_yOffset += 10;
	//var lastRow = -1;
	//var l_terms_result = [];
	//documentCommon_parseHTML4jsPDF(l_terms, l_terms_result);
	//$.each(l_terms_result, function(i, parsedObj) {
	//	pdfDoc.setFontSize(parsedObj.fontSize);
	//	pdfDoc.setTextColor(parsedObj.textColor_R, parsedObj.textColor_G, parsedObj.textColor_B);
	//	pdfDoc.setFontType(parsedObj.fontType);

	//	if (parsedObj.tablecell) {
	//		if (parsedObj.newRow)
	//			billingTable_yOffset += 15;
	//		if (parsedObj.row > 0 && lastRow != parsedObj.row)
	//			billingTable_yOffset += 15;

	//		var x_pos = 45 + (parsedObj.col * 120);
	//		pdfDoc.text($.trim(parsedObj.text), x_pos, billingTable_yOffset);
	//		lastRow = parsedObj.row;
	//	}
	//	else {
	//		pdfDoc.text($.trim(parsedObj.text), 45, billingTable_yOffset);
	//		billingTable_yOffset += 15;
	//	}
	//});

	return pdfDoc;
} // .end of processDocument_FOR001_001_getPDF
