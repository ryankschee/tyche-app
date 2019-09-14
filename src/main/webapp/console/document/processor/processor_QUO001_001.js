/**
 * Get PDF content of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} BillingBean object.
 * @param {Object} UserBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_QUO001_001_getPDF(documentObj, placeDocumentObj, userObj, billingObj) {
	// 0. Get objects
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);

	// 0.5. Get user-keyin input objects
	var l_customerName;
	var propObj_customerName = documentCommon_getPropObjectByKey(placeDocumentObj, '$_CUSTOMER_NAME_$');
	if (propObj_customerName == null) {
		l_customerName = $.trim(billingObj.customerName);
	} else {
		if ($.trim(propObj_customerName.userInput)=='')
			l_customerName = $.trim(billingObj.customerName);
		else
			l_customerName = $.trim(propObj_customerName.userInput);
	}
	var l_quotationDate;
	var propObj_quotationDate = documentCommon_getPropObjectByKey(placeDocumentObj, '$_QUOTATION_DATE_$');
	if (propObj_quotationDate == null) {
		l_quotationDate = tycheesDateTime_getFormattedDate_ddMMyyyy(billingObj.quotationDate);
	} else {
		if ($.trim(propObj_quotationDate.userInput) == '')
			l_quotationDate = tycheesDateTime_getFormattedDate_ddMMyyyy(billingObj.quotationDate);
		else 
		if ($.trim(propObj_quotationDate.userInput) == 'TODAY')
			l_quotationDate = tycheesDateTime_getFormattedDate_ddMMyyyy(new Date().getTime());
		else
			l_quotationDate = $.trim(propObj_quotationDate.userInput);
	}
	
	// 0.5. Get system-settings input objects
	var l_footerNotes;
	var propObj_footerNotes = documentCommon_getPropObjectByKey(placeDocumentObj, '$_FOOTER_NOTES_$');
	if (propObj_footerNotes == null) {
		l_footerNotes = '-';
	} else {
		l_footerNotes = $.trim(propObj_footerNotes.propValue);
	}
	
	var l_terms;
	var propObj_terms = documentCommon_getPropObjectByKey(placeDocumentObj, '$_TERMS_$');
	if (propObj_terms == null) {
		l_terms = '-';
	} else {
		l_terms = $.trim(propObj_terms.propValue);
	}
	
	// 1. Prepare local variables to be display on PDF document
	const c_currency = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY).propValue;
	var l_gstNumber = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GST_TAX_INVOICE_NUMBER).propValue;
	var l_officeAddress = placeUtil_getDefaultAddress(placeObj);
	var l_officeAddressList = l_officeAddress.split(".");
	var l_officePhone = placeUtil_getDefaultContact(placeObj, AppConstants.CONTACT_TYPE_OFFICE);
	var l_mobilePhone = placeUtil_getDefaultContact(placeObj, AppConstants.CONTACT_TYPE_MOBILE);
	var l_invoiceNo = $.trim(billingObj.invoiceNo) == '' ? consoleCommon_getNextInvoiceNo() : $.trim(billingObj.invoiceNo);
	var l_billingNo = $.trim(billingObj.billingNo);
	var l_companyName = $.trim(placeObj.companyName);
	var l_companyRegistrationNo = $.trim(placeObj.companyRegistrationNo);
	//var l_companyLogoUrl = $.trim(placeObj.logoImageUrl);
	var l_companyLogoBase64 = companyLogoImageObj == null ? '' : $.trim(companyLogoImageObj.base64);

	//-------------------
	// 2.0 Prepare PDF doc
	var pdfDoc = new jsPDF('portrait', 'pt', 'a4');
	// Optional - set properties on the document
	pdfDoc.setProperties({
		title: 'Quotation for Billing ' + billingObj.quotationNo,
		subject: billingObj.quotationNo,
		author: l_companyName,
		keywords: '',
		creator: l_companyName
	});

	// Header Title
	pdfDoc.setFontSize(18);
	pdfDoc.setFontType('bold');
	pdfDoc.text(250, 40, 'QUOTATION');
	// Header line break
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(30, 50, 565, 50);
	// Company Logo
	if ($.trim(l_companyLogoBase64) != '')
		pdfDoc.addImage(l_companyLogoBase64, 'JPEG', 30, 60, 180, 60)
	// Tax Invoice Number
	pdfDoc.setFontSize(14);
	pdfDoc.setFontType('normal');
	pdfDoc.text('Quotation No', 565, 70, 'right');
	pdfDoc.setFontSize(16);
	pdfDoc.setTextColor(255, 0, 0);
	pdfDoc.text(billingObj.quotationNo, 565, 90, 'right');
	// Office Phone
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text(30, 150, 'T/F:');
	pdfDoc.setFontType('normal');
	pdfDoc.text(60, 150, l_officePhone);
	// Mobile Phone
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text(30, 165, 'M:');
	pdfDoc.setFontType('normal');
	pdfDoc.text(60, 165, l_mobilePhone);
	// Office Address
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text(180, 150, 'ADDR:');
	pdfDoc.setFontType('normal');
	$.each(l_officeAddressList, function(i, addressLine) {
		if ($.trim(addressLine) == '')
			return true;
		pdfDoc.text($.trim(addressLine) + '.', 225, 150 + i * 15);
	});
	// Company Name & Registration No
	pdfDoc.setFontSize(15);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text(30, 215, l_companyName + ' (' + l_companyRegistrationNo + ')');
	// GST Number
	pdfDoc.setFontSize(15);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('GST: ' + l_gstNumber, 565, 215, 'right');
	// Line Break
	pdfDoc.setLineWidth(0.05);
	pdfDoc.line(30, 220, 565, 220);

	// Customer Name
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('TO:', 30, 245);
	pdfDoc.setFontType('normal');
	pdfDoc.text(l_customerName, 70, 245);
	// Date of Invoice
	pdfDoc.setFontSize(12);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('DATE:', 500, 245, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(l_quotationDate, 565, 245, 'right');

	// Billing Lines: Table header
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('ITEM', 30, 275);
	pdfDoc.text('QUANTITY', 350, 275, 'right');
	pdfDoc.text('UNIT PRICE', 450, 275, 'right');
	pdfDoc.text('AMOUNT (' + c_currency.toUpperCase() + ')', 565, 275, 'right');
	// Billing Lines: Line Break
	pdfDoc.setLineWidth(0.05);
	pdfDoc.line(30, 280, 565, 280);
	// Billing Lines: Table Content
	pdfDoc.setFontSize(12);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('normal');
	// Billing Lines: variables
	var billingTable_yOffset = 280;
	var billingSubTotalAmount = 0;
	var billingTotalTaxAmount = 0;
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_RAW) {
			var taxInclusive = false;
			$.each(lineObj.lineList, function(j, childLineObj) {
				if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
					taxInclusive = childLineObj.taxInclusive;
				}
			});

			billingTable_yOffset += 15;

			pdfDoc.text(lineObj.itemName, 30, billingTable_yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 350, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.billableAmount).toFixed(2), 450, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.billableAmount * lineObj.quantity).toFixed(2), 565, billingTable_yOffset, 'right');
			
			// Line Break
			billingTable_yOffset += 5;
			pdfDoc.setLineWidth(0.02);
			pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);

			// Prepare data for summary
			billingSubTotalAmount += (lineObj.billableAmount * lineObj.quantity);
			billingTotalTaxAmount += (lineObj.taxAmount * lineObj.quantity);
		}
	});

	// Billing Table: Discount Items
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {

			billingTable_yOffset += 15;

			pdfDoc.text(lineObj.itemName, 30, billingTable_yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 350, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.discountAmount).toFixed(2), 450, billingTable_yOffset, 'right');
			pdfDoc.text(Number(lineObj.discountAmount * lineObj.quantity).toFixed(2), 565, billingTable_yOffset, 'right');
			// Line break
			billingTable_yOffset += 5;
			pdfDoc.setLineWidth(0.05);
			pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);

			// Prepare data for Summary
			billingSubTotalAmount -= (lineObj.discountAmount * lineObj.quantity);
		}
	});

	// Summary: Sub Total
	billingTable_yOffset += 40;
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('SUB TOTAL:', 450, billingTable_yOffset, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(Number(billingSubTotalAmount).toFixed(2), 565, billingTable_yOffset, 'right');

	// Summary: Add GST 6%
	billingTable_yOffset += 20;
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('ADD GST 6%:', 450, billingTable_yOffset, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(Number(billingObj.taxAmount).toFixed(2), 565, billingTable_yOffset, 'right');

	// Summary: TOTAL
	billingTable_yOffset += 20;
	pdfDoc.setFontSize(11);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('TOTAL:', 450, billingTable_yOffset, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(Number(billingObj.totalAmount).toFixed(2), 565, billingTable_yOffset, 'right');

	// Footer
	billingTable_yOffset += 40;
	pdfDoc.roundedRect(30, billingTable_yOffset, 535, 140, 5, 5);
	// Footer
	billingTable_yOffset += 20;
	var l_footerNotes_result = [];
	documentCommon_parseHTML4jsPDF(l_footerNotes, l_footerNotes_result);
	$.each(l_footerNotes_result, function(i, parsedObj) {

		pdfDoc.setFontSize(parsedObj.fontSize);
		pdfDoc.setTextColor(parsedObj.textColor_R, parsedObj.textColor_G, parsedObj.textColor_B);
		pdfDoc.setFontType(parsedObj.fontType);
		pdfDoc.text($.trim(parsedObj.text), 45, billingTable_yOffset);

		billingTable_yOffset += 15;
	});
	// Terms
	billingTable_yOffset += 10;
	var lastRow = -1;
	var l_terms_result = [];
	documentCommon_parseHTML4jsPDF(l_terms, l_terms_result);
	$.each(l_terms_result, function(i, parsedObj) {

		pdfDoc.setFontSize(parsedObj.fontSize);
		pdfDoc.setTextColor(parsedObj.textColor_R, parsedObj.textColor_G, parsedObj.textColor_B);
		pdfDoc.setFontType(parsedObj.fontType);

		if (parsedObj.tablecell) {
			if (parsedObj.newRow)
				billingTable_yOffset += 15;
			if (parsedObj.row > 0 && lastRow != parsedObj.row)
				billingTable_yOffset += 15;

			var x_pos = 45 + (parsedObj.col * 120);
			pdfDoc.text($.trim(parsedObj.text), x_pos, billingTable_yOffset);
			lastRow = parsedObj.row;
		}
		else {
			pdfDoc.text($.trim(parsedObj.text), 45, billingTable_yOffset);
			billingTable_yOffset += 15;
		}
	});

	return pdfDoc;
} // .end of processDocument_QUO001_001_getPDF

