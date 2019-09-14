/**
 * Get PDF content of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} BillingBean object.
 * @param {Object} UserBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_RCP001_001_getPDF(documentObj, placeDocumentObj, userObj, billingObj) {
	// 0. Get objects
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);

	// 0.5. Get system-settings input objects
	var propObj_footerNotes = documentCommon_getPropObjectByKey(placeDocumentObj, '$_FOOTER_NOTES_$');
	var propObj_terms = documentCommon_getPropObjectByKey(placeDocumentObj, '$_TERMS_$');
	
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
	var l_companyLogoBase64 = companyLogoImageObj == null ? '' : $.trim(companyLogoImageObj.base64);
	//var l_customerName = $.trim(propObj_customerName.userInput);
	//var l_tinDate = $.trim(propObj_tinDate.userInput) == 'TODAY' ? tycheesDateTime_getFormattedDate_ddMMyyyy(new Date().getTime()) : $.trim(propObj_tinDate.userInput);
	//var l_footerNotes = $.trim(propObj_footerNotes.propValue);
	//var l_terms = $.trim(propObj_terms.propValue);
	var l_customerName = '-';
	var l_tinDate = tycheesDateTime_getFormattedDate_ddMMyyyy(billingObj.billingDate);
	var l_tinTime = tycheesDateTime_getFormattedDate_hhmm(billingObj.billingDate);
	var l_footerNotes = '-';
	var l_terms = '-';
	

	//-------------------
	// 2.0 Prepare PDF doc
	var pageWidth = 200;
	var pageHeight = processDocument_RCP001_001_getPageHeight(documentObj, placeDocumentObj, billingObj, userObj);	
	if (pageHeight <= pageWidth)
		pageHeight = pageWidth + 1;
	
	var pdfDoc = new jsPDF({
		orientation: 'portrait',
		unit: 'pt',
		format: [pageWidth, pageHeight]
	});
	// Optional - set properties on the document
	pdfDoc.setProperties({
		title: 'Invoice for Billing ' + l_billingNo,
		subject: l_invoiceNo,
		author: l_companyName,
		keywords: '',
		creator: l_companyName
	});

	// Y Axis
	var yOffset = 0;
	
	// HEADER
	// Company Logo
	yOffset = 30;
	var imagePropWidth = 160;
	var imagePropHeight = Math.round( (companyLogoImageObj.height / companyLogoImageObj.width) * imagePropWidth );
	pdfDoc.addImage(l_companyLogoBase64, 'JPEG', 20, yOffset, imagePropWidth, imagePropHeight)
	// Company Name
	yOffset += (imagePropHeight + 30);
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('bold');
	pdfDoc.text(l_companyName, documentCommon_getXOffset(pdfDoc, l_companyName), yOffset);
	// Company Registration No
	yOffset += 15;
	pdfDoc.setFontSize(10);
	pdfDoc.setFontType('normal');
	pdfDoc.text(l_companyRegistrationNo, documentCommon_getXOffset(pdfDoc, l_companyRegistrationNo), yOffset);
	// Company Address
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	$.each(l_officeAddressList, function(i, addressLine) {
		if ($.trim(addressLine) == '')
			return true;
		
		yOffset += 15;
		pdfDoc.text($.trim(addressLine), documentCommon_getXOffset(pdfDoc, $.trim(addressLine)), yOffset);
	});
		
	// Company Phone
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text(l_officePhone, documentCommon_getXOffset(pdfDoc, l_officePhone), yOffset);
		
	// Header line break
	yOffset += 10;
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(10, yOffset, 190, yOffset);
	
	// Invoice Number
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text("Invoice No:", 10, yOffset);
	pdfDoc.text(l_invoiceNo, 190, yOffset, 'right');

	// GST Number
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text("GST No:", 10, yOffset);
	pdfDoc.text(l_gstNumber, 190, yOffset, 'right');

	// Billing Date
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text("Date/Time:", 10, yOffset);
	pdfDoc.text(l_tinDate + ', ' + l_tinTime, 190, yOffset, 'right');

	// Cashier Name
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text("Cashier:", 10, yOffset);
	pdfDoc.text(tycheesCommon_getCurrentUserFullname(), 190, yOffset, 'right');

	// Billing Lines: Table header
	yOffset += 30;
	pdfDoc.setFontSize(8);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('ITEM', 20, yOffset);
	pdfDoc.text('QTY', 120, yOffset, 'right');
	pdfDoc.text('PRICE', 155, yOffset, 'right');
	pdfDoc.text('AMT', 190, yOffset, 'right');
	// Billing Lines: Line Break
	yOffset += 5;
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(10, yOffset, 190, yOffset);
	// Billing Lines: Table Content
	pdfDoc.setFontSize(8);
	pdfDoc.setFontType('normal');
	var billingLineCount = 1;
	var billingSubTotalAmount = 0;
	var billingTotalTaxAmount = 0;
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemTyoe == InventoryConstants.ITEM_TYPE_RAW) {
			
			var taxInclusive = false;
			$.each(lineObj.lineList, function(j, childLineObj) {
				if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
					taxInclusive = childLineObj.taxInclusive;
				}
			});
			
			var unitPrice = 0;
			if (lineObj.unitPriceSource == 'default') {
				unitPrice = lineObj.defaultUnitPrice;
			}
			if (lineObj.unitPriceSource == 'custom') {
				unitPrice = lineObj.customUnitPrice;
			}
			if (lineObj.unitPriceSource == 'compound') {
				unitPrice = lineObj.compoundUnitPrice;
			}

			yOffset += 15;

			pdfDoc.text(billingLineCount.toString(), 10, yOffset);			
			pdfDoc.text(lineObj.itemName, 20, yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 120, yOffset, 'right');
			
			if (taxInclusive) {
				pdfDoc.text(Number(unitPrice - lineObj.taxAmount).toFixed(2), 155, yOffset, 'right');
				pdfDoc.text(Number((unitPrice - lineObj.taxAmount) * lineObj.quantity).toFixed(2), 190, yOffset, 'right');
			}
			else {
				pdfDoc.text(Number(unitPrice).toFixed(2), 155, yOffset, 'right');
				pdfDoc.text(Number(unitPrice * lineObj.quantity).toFixed(2), 190, yOffset, 'right');
			}

			// Line Break
			yOffset += 5;
			pdfDoc.setLineWidth(0.01);
			pdfDoc.line(10, yOffset, 190, yOffset);

			// Prepare data for summary
			billingLineCount++;
			billingSubTotalAmount += (unitPrice * lineObj.quantity);
			billingTotalTaxAmount += (lineObj.taxAmount * lineObj.quantity);
		}
	});

	// Billing Table: Discount Items
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {

			yOffset += 15;

			pdfDoc.text(lineObj.itemName, 20, yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 120, yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalUnitPrice).toFixed(2), 155, yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalPrice).toFixed(2), 155, yOffset, 'right');
			// Line break
			yOffset += 5;
			pdfDoc.setLineWidth(0.01);
			pdfDoc.line(10, yOffset, 190, yOffset);
		}
	});

	// Billing Lines: Tax Item
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {

			yOffset += 15;

			pdfDoc.text(lineObj.itemName, 20, yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 120, yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalUnitPrice).toFixed(2), 155, yOffset, 'right');
			pdfDoc.text(Number(lineObj.totalPrice).toFixed(2), 190, yOffset, 'right');
			// Line Break
			yOffset += 5;
			pdfDoc.setLineWidth(0.01);
			pdfDoc.line(10, yOffset, 190, yOffset);
		}
	});

	// Summary: Sub Total
	yOffset += 30;
	pdfDoc.setFontSize(10);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('SUB TOTAL:', 155, yOffset, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(Number(billingSubTotalAmount).toFixed(2), 190, yOffset, 'right');

	// Summary: Add GST 6%
	yOffset += 15;
	pdfDoc.setFontSize(10);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('ADD GST 6%:', 155, yOffset, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(Number(billingTotalTaxAmount).toFixed(2), 190, yOffset, 'right');

	// Summary: TOTAL
	yOffset += 15;
	pdfDoc.setFontSize(10);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('TOTAL:', 155, yOffset, 'right');
	pdfDoc.setFontType('normal');
	pdfDoc.text(Number(billingObj.totalAmount).toFixed(2), 190, yOffset, 'right');

	// Payment History: Table Header
	yOffset += 30;
	pdfDoc.setFontSize(8);
	pdfDoc.setTextColor(0, 0, 0);
	pdfDoc.setFontType('bold');
	pdfDoc.text('PAYMENT', 10, yOffset);
	pdfDoc.text('METHOD', 155, yOffset, 'right');
	pdfDoc.text('AMT', 190, yOffset, 'right');
	// Payment History: Table Content
	yOffset += 5;
	pdfDoc.setLineWidth(0.01);
	pdfDoc.line(10, yOffset, 190, yOffset);
	if (billingObj.paymentList.length == 0) {
		pdfDoc.setFontSize(8);
		pdfDoc.setTextColor(255, 0, 0);
		pdfDoc.setFontType('italic');

		yOffset += 15;
		pdfDoc.text('- NO PAYMENT RECEIVED -', 30, yOffset);
	}
	else {
		pdfDoc.setFontSize(8);
		pdfDoc.setTextColor(0, 0, 0);
		pdfDoc.setFontType('normal');

		$.each(billingObj.paymentList, function(i, paymentObj) {

			if (Cached_isDeletedBean(paymentObj))
				return true;

			yOffset += 15;

			pdfDoc.text(tycheesDateTime_getFormattedDate_ddMMyyyy(paymentObj.createdOn) + ', ' + tycheesDateTime_getFormattedDate_hhmm(paymentObj.createdOn), 10, yOffset);
			pdfDoc.text(paymentObj.method, 155, yOffset, 'right');
			pdfDoc.text(Number(paymentObj.payingAmount).toFixed(2), 190, yOffset, 'right');
			// Line Break
			yOffset += 5;
			pdfDoc.setLineWidth(0.01);
			pdfDoc.line(10, yOffset, 190, yOffset);
		});
	}
	
	return pdfDoc;
} // .end of processDocument_RCP001_001_getPDF

/**
 * Get Page height of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} BillingBean object.
 * @param {Object} UserBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_RCP001_001_getPageHeight(documentObj, placeDocumentObj, billingObj, userObj) {

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
	
	// Y Axis
	var yOffset = 30;	
	var imagePropWidth = 160;
	var imagePropHeight = Math.round( (companyLogoImageObj.height / companyLogoImageObj.width) * imagePropWidth );
	// Company Name
	yOffset += (imagePropHeight + 30);
	// Company Registration No
	yOffset += 15;
	// Company Address
	var l_officeAddress = placeUtil_getDefaultAddress(placeObj);
	var l_officeAddressList = l_officeAddress.split(".");
	$.each(l_officeAddressList, function(i, addressLine) {
		if ($.trim(addressLine) == '')
			return true;		
		yOffset += 15;
	});
		
	// Company Phone
	yOffset += 15;
	// Header line break
	yOffset += 10;	
	// Invoice Number
	yOffset += 15;
	// GST Number
	yOffset += 15;
	// Billing Date
	yOffset += 15;
	// Cashier Name
	yOffset += 15;
	// Billing Lines: Table header
	yOffset += 30;
	// Billing Lines: Line Break
	yOffset += 5;
	// Billing Lines: Table Content
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemTyoe == InventoryConstants.ITEM_TYPE_RAW) {
			
			// Line content
			yOffset += 15;
			// Line Break
			yOffset += 5;
		}
	});

	// Billing Table: Discount Items
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
			// Line content
			yOffset += 15;
			// Line break
			yOffset += 5;
		}
	});

	// Billing Lines: Tax Item
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
			// Line content
			yOffset += 15;
			// Line break
			yOffset += 5;
		}
	});

	// Summary: Sub Total
	yOffset += 30;
	// Summary: Add GST 6%
	yOffset += 15;
	// Summary: TOTAL
	yOffset += 15;
	
	// Payment History: Table Header
	yOffset += 30;
	// Payment History: Table Content
	yOffset += 5;
	if (billingObj.paymentList.length == 0) {
		yOffset += 15;
	} else {		
		$.each(billingObj.paymentList, function(i, paymentObj) {

			if (Cached_isDeletedBean(paymentObj))
				return true;
			
			// Line Content
			yOffset += 15;
			// Line Break
			yOffset += 5;
		});
	}
	
	return yOffset + 30;
} // .end of processDocument_RCP001_001_getPageHeight
