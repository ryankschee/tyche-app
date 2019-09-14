/**
 * Get PDF content of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} UserBean object.
 * @param {Object} BillingBucketBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_DRK001_001_getPDF(documentObj, placeDocumentObj, userObj, billingBucketObj) {
	// 0. Get objects
	var placeObj = tycheesCommon_getCurrentPlaceObject();

	// 0.5. Get system-settings input objects
	var drinkOrderLabel = settingsCommon_getSettingsValue(
							ModuleConstants.MODULE_BILLING, 
							ModuleConstants.MODULE_BILLING_SUB_BACKOFFICE, 
							SettingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_LABEL);
	
	// 1. Prepare local variables to be display on PDF document
	const c_currency = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY).propValue;
	var l_companyName = $.trim(placeObj.companyName);
	var l_orderedDate = tycheesDateTime_getFormattedDate_ddMMyyyy(billingBucketObj.orderedOn);
	var l_orderedTime = tycheesDateTime_getFormattedDate_hhmm(billingBucketObj.orderedOn);
	

	//-------------------
	// 2.0 Prepare PDF doc
	var pageWidth = 200;
	var pageHeight = processDocument_DRK001_001_getPageHeight(documentObj, placeDocumentObj, userObj, billingBucketObj);	
	if (pageHeight <= pageWidth)
		pageHeight = pageWidth + 1;
	
	var pdfDoc = new jsPDF({
		orientation: 'portrait',
		unit: 'pt',
		format: [pageWidth, pageHeight]
	});
	// Optional - set properties on the document
	pdfDoc.setProperties({
		title: 'Drink Order for ' + billingBucketObj.bucketName,
		subject: 'Drink Order',
		author: l_companyName,
		keywords: '',
		creator: l_companyName
	});
	pdfDoc.setDisplayMode(3);	// zoom 3x

	// Y Axis
	var yOffset = 30;
	pdfDoc.text('DRINK ORDER', documentCommon_getXOffset(pdfDoc, 'DRINK ORDER'), yOffset);

	// Header line break
	yOffset += 10;
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(10, yOffset, 190, yOffset);

	// Table Name
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text('Table:', 10, yOffset);
	pdfDoc.text(billingBucketObj.bucketName, 190, yOffset, 'right');
	
	// Ordered Date
	yOffset += 15;
	pdfDoc.setFontSize(9);
	pdfDoc.setFontType('normal');
	pdfDoc.text("Date/Time:", 10, yOffset);
	pdfDoc.text(l_orderedDate + ', ' + l_orderedTime, 190, yOffset, 'right');

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
	pdfDoc.text('QTY', 190, yOffset, 'right');
	// Billing Lines: Line Break
	yOffset += 5;
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(10, yOffset, 190, yOffset);
	// Billing Lines: Table Content
	pdfDoc.setFontSize(8);
	pdfDoc.setFontType('normal');
	var billingLineCount = 1;
	$.each(billingBucketObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		var labelList = lineObj.itemLabels.split(',');
		if ($.inArray(drinkOrderLabel, labelList) == -1)
			return true;
		
		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemTyoe == InventoryConstants.ITEM_TYPE_RAW) {
			
			yOffset += 15;

			pdfDoc.text(billingLineCount.toString(), 10, yOffset);			
			pdfDoc.text(lineObj.itemName, 20, yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 190, yOffset, 'right');
			
			// Line Break
			yOffset += 5;
			pdfDoc.setLineWidth(0.01);
			pdfDoc.line(10, yOffset, 190, yOffset);

			// Prepare data for summary
			billingLineCount++;
		}
	});
	
	return pdfDoc;
} // .end of processDocument_FOD001_001_getPDF

/**
 * Get Page height of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} UserBean object.
 * @param {Object} BillingBucketBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_DRK001_001_getPageHeight(documentObj, placeDocumentObj, userObj, billingBucketObj) {

	var drinkOrderLabel = settingsCommon_getSettingsValue(
							ModuleConstants.MODULE_BILLING, 
							ModuleConstants.MODULE_BILLING_SUB_BACKOFFICE, 
							SettingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_LABEL);
	
	var yOffset = 30;
	// Header line break
	yOffset += 10;
	// Table Name
	yOffset += 15;	
	// Ordered Date
	yOffset += 15;
	// Cashier Name
	yOffset += 15;	
	// Billing Lines: Table header
	yOffset += 30;
	// Billing Lines: Line Break
	yOffset += 5;
	// Billing Lines: Table Content
	$.each(billingBucketObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		var labelList = lineObj.itemLabels.split(',');
		if ($.inArray(drinkOrderLabel, labelList) == -1)
			return true;
		
		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemTyoe == InventoryConstants.ITEM_TYPE_RAW) {
			
			// Content Line
			yOffset += 15;
			// Line Break
			yOffset += 5;
		}
	});
	
	return yOffset + 20;
} // .end of processDocument_FOD001_001_getPageHeight
