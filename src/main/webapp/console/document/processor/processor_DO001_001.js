/**
 * Get PDF content of this document type.
 * 
 * @param {Object} DocumentBean object.
 * @param {Object} PlaceDocumentBean object
 * @param {Object} BillingBean object.
 * @param {Object} UserBean object.
 * @returns {Object} jsPDF object
 */
function processDocument_DO001_001_getPDF(callbackFn, billingObj, billingDeliveryObj) 
{
	// 0. Get objects
	var placeObj = tycheesCommon_getCurrentPlaceObject();

	//-------------------
	// 2.0 Prepare PDF doc
	var pdfDoc = new jsPDF('portrait', 'pt', 'a4');
	// Optional - set properties on the document
	pdfDoc.setProperties({
		title: 'Delivery Order for ' + $.trim(billingObj.billingNo),
		subject: billingDeliveryObj.refNo,
		author: $.trim(placeObj.companyName),
		keywords: '',
		creator: $.trim(placeObj.companyName)
	});

	// Header Title
	pdfDoc.setFontSize(18);
	pdfDoc.setFontType('bold');
	pdfDoc.text(230, 100, 'DELIVERY ORDER');
	
	// Bill To
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(30, 140, 'BILL TO');
	pdfDoc.text(100, 140, ':');
	pdfDoc.text(110, 140, $.trim(billingDeliveryObj.attentionTo));
	// TEL
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(30, 155, 'TEL');
	pdfDoc.text(100, 155, ':');
	pdfDoc.text(110, 155, $.trim(billingDeliveryObj.contactNo));
	// ADDRESS
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(30, 170, 'ADDRESS');
	pdfDoc.text(100, 170, ':');

	var textDimension;
	var splitTextVal = '';
	var lastTextVal = '';
	var lineCount = 0;
	var addressList = tycheesBean_toString_commonAddressBean(billingDeliveryObj).split(" ");
	for (var i = 0 ; i < addressList.length ; i++) {
		splitTextVal += (addressList[i] + ' ');
		textDimension = pdfDoc.getTextDimensions(splitTextVal);
		
		if (textDimension.w > 250) {
			pdfDoc.text(110, 170 + (15 * lineCount), lastTextVal);
			
			lineCount++;
			splitTextVal = addressList[i] + ' ';
			lastTextVal = splitTextVal;	    				
			
		} else {
			lastTextVal = splitTextVal;
		}
	}
	
	if (lastTextVal != '') {
		pdfDoc.text(110, 170 + (15 * lineCount), lastTextVal);		
	}
	
	
	// Ref No
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(400, 140, 'NO');
	pdfDoc.text(435, 140, ':');
	pdfDoc.text(billingDeliveryObj.refNo, 565, 140, 'right');
	// Date
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(400, 155, 'DATE');
	pdfDoc.text(435, 155, ':');
	pdfDoc.text(tycheesDateTime_getFormattedDate_ddMMyyyy(billingDeliveryObj.dispatchedOn), 565, 155, 'right');

	var rowCount = 1;
	var totalQuantity = 0;
	var billingTable_yOffset = 220;

	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('bold');

	billingTable_yOffset += 15;
	pdfDoc.text('NO', 30, billingTable_yOffset);
	pdfDoc.text('PRODUCT DESCRIPTION', 60, billingTable_yOffset);
	pdfDoc.text('QTY', 565, billingTable_yOffset, 'right');

	billingTable_yOffset += 5;
	pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);

	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	$.each(billingObj.lineList, function(i, lineObj) {

		if (Cached_isDeletedBean(lineObj))
			return true;

		if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
			lineObj.itemType == InventoryConstants.ITEM_TYPE_RAW) {
			
			billingTable_yOffset += 15;

			pdfDoc.text(rowCount.toString(), 30, billingTable_yOffset);
			pdfDoc.text(lineObj.itemName, 60, billingTable_yOffset);
			pdfDoc.text(lineObj.quantity.toString(), 565, billingTable_yOffset, 'right');
			
			// Line Break
			billingTable_yOffset += 5;
			pdfDoc.setLineWidth(0.02);
			pdfDoc.line(30, billingTable_yOffset, 565, billingTable_yOffset);
			
			totalQuantity += lineObj.quantity;
			rowCount++;
		}
	});

	billingTable_yOffset += 15;
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('bold');
	pdfDoc.text('TOTAL', 60, billingTable_yOffset);
	pdfDoc.text(totalQuantity.toString(), 565, billingTable_yOffset, 'right');
	
	// ISSUED BY
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(100, billingTable_yOffset + 60, 'ISSUED BY');
	pdfDoc.line(30, billingTable_yOffset + 120, 230, billingTable_yOffset + 120);
	pdfDoc.text(30, billingTable_yOffset + 140, tycheesCommon_getCurrentUserFullname());
	pdfDoc.text(30, billingTable_yOffset + 155, tycheesDateTime_getFormattedDate_ddMMMMyyyy(tycheesDateTime_getCurrentTimeInMillis()));

	// RECEIVED BY
	pdfDoc.setFontSize(12);
	pdfDoc.setFontType('normal');
	pdfDoc.text(415, billingTable_yOffset + 60, 'RECEIVED BY');
	pdfDoc.line(365, billingTable_yOffset + 120, 555, billingTable_yOffset + 120);
	pdfDoc.text(365, billingTable_yOffset + 140, 'NAME');
	pdfDoc.text(365, billingTable_yOffset + 155, 'IC NO');
	pdfDoc.text(365, billingTable_yOffset + 170, 'DATE');
	pdfDoc.text(365, billingTable_yOffset + 185, 'COMPANY CHOP');
	
	callbackFn(pdfDoc);
} // .end of processDocument_DO001_001_getPDF

function processDocument_DO001_001_getTextY(y, lineHeight, textHeight) {
	return y + lineHeight - (textHeight - lineHeight);
} // .end of documentProcessor_getTextY
