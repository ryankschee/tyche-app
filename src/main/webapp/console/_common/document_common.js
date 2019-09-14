/**
 * Get X Offset to justify text at center of pdfDoc page.
 */
function documentCommon_getXOffset(pdfDoc, text) { 
	xOffset = (pdfDoc.internal.pageSize.width / 2) - (pdfDoc.getStringUnitWidth(text) * pdfDoc.internal.getFontSize() / 2); 
	return xOffset;
} // .end of documentCommon_getXOffset

/**
 * Process document content, based on document code.
 * 
 * @param	documentObj		Document content in string.
 * @param	billingObj	    Billing object.
 * @return				    New content with inserted values.
 */
function documentCommon_getPDF(documentObj, placeDocumentObj, userObj, contentObj) {
	
	// DOC Type: BackOffice > Food Order
	if (documentObj.docCode == 'FOD001_001')
		return processDocument_FOD001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);

	// DOC Type: BackOffice > Drink Order
	if (documentObj.docCode == 'DRK001_001')
		return processDocument_DRK001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);
	
	// DOC Type: FULL ORDER
	if (documentObj.docCode == 'FOR001_001')
		return processDocument_FOR001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);

	// DOC Type: Invoice
	if (documentObj.docCode == 'INV001_001')
		return processDocument_INV001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);

	// DOC Type: Quotation
	if (documentObj.docCode == 'QUO001_001')
		return processDocument_QUO001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);

	// DOC Type: RECEIPT
	if (documentObj.docCode == 'RCP001_001')
		return processDocument_RCP001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);

	// DOC Type: DELIVERY ORDER
	//if (documentObj.docCode == 'DO001_001')
	//	return processDocument_DO001_001_getPDF(documentObj, placeDocumentObj, userObj, contentObj);
} // .end of documentCommon_getPDF

function documentCommon_async_getPDF(callbackFn, documentObj, placeDocumentObj, userObj, contentObj) {
	
	// DOC Type: DELIVERY ORDER
	if (documentObj.docCode == 'DO001_001')
		processDocument_DO001_001_getPDF(callbackFn, documentObj, placeDocumentObj, userObj, contentObj);
} // .end of documentCommon_getPDF


function documentCommon_getPropObjectByKey(placeDocObj, propKey) {
	var foundPropObj;

	if (placeDocObj == null)
		return foundPropObj;

	$.each(placeDocObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == propKey) {
			foundPropObj = propObj;
			return true;
		}
	});

	return foundPropObj;
} // .end of documentCommon_getPropObjectByKey

function documentCommon_getPropValueByKey(placeDocObj, propKey) {
	var foundPropVal = 'N/A';

	if (placeDocObj == null)
		return foundPropVal;

	$.each(placeDocObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == propKey) {
			foundPropVal = propObj.propValue;
			return true;
		}
	});

	if (foundPropVal == null)
		foundPropVal = 'N/A';

	return foundPropVal;
} // .end of documentCommon_getPropertiesObjectByKey

function documentCommon_getUserInputByKey(placeDocObj, propKey) {
	var foundPropUserInput;

	if (placeDocObj == null)
		return foundPropUserInput;

	$.each(placeDocObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == propKey) {
			foundPropUserInput = propObj.userInput;
			return true;
		}
	});

	return foundPropUserInput;
} // .end of documentCommon_getUserInputByKey

//------------------------------------------------------------------------------
// HTML PARSER (convert to HTML)

/**
 * Convert htmlText into jsPDF-readable objects in result.
 */
function documentCommon_parseHTML4jsPDF(htmlText, result) {
	if (result == null)
		result = [];

	var parsedHTML = $.parseHTML($.trim(htmlText));
	var row = 0;

	$.each(parsedHTML, function(i, el) {
		var nodeName = el.nodeName;
		if (nodeName == '#text') {
			if ($.trim(el.data) == '')
				return true;

			var obj = new Object();
			obj.fontType = 'normal';
			obj.fontSize = '11';
			obj.textColor_R = 0;
			obj.textColor_G = 0;
			obj.textColor_B = 0;
			obj.text = $.trim(el.data);
			result.push(obj);
		}

		if (nodeName == 'B') {
			var obj = new Object();
			obj.fontType = 'bold';
			obj.fontSize = '11';
			obj.textColor_R = 0;
			obj.textColor_G = 0;
			obj.textColor_B = 0;
			obj.text = $.trim(el.innerText);
			result.push(obj);
		}

		if (nodeName == 'I') {
			var obj = new Object();
			obj.fontType = 'italic';
			obj.fontSize = '11';
			obj.textColor_R = 0;
			obj.textColor_G = 0;
			obj.textColor_B = 0;
			obj.text = $.trim(el.innerText);
			result.push(obj);
		}

		if (nodeName == 'TABLE') {
			documentCommon_parseHTML4jsPDF(el.innerHTML, result);
		}
		if (nodeName == 'TBODY') {
			documentCommon_parseHTML4jsPDF(el.innerHTML, result);
		}
		if (nodeName == 'TR') {
			var col = 0;
			$.each(el.childNodes, function(j, childNodeEl) {
				if (childNodeEl.nodeName == 'TD') {
					documentCommon_parseTableCell4jsPDF(childNodeEl.innerHTML, result, row, col++);
				}
			});

			row++;
		}
	});
} // .end of documentCommon_parseHTML4jsPDF

/**
 * Convert htmlText of table into jsPDF-readable objects in result.
 */
function documentCommon_parseTableCell4jsPDF(htmlText, result, row, col) {
	if (result == null)
		result = [];

	var parsedHTML = $.parseHTML($.trim(htmlText));

	var newRow = false;
	$.each(parsedHTML, function(i, el) {
		var nodeName = el.nodeName;
		if (nodeName == '#text') {
			if ($.trim(el.data) == '')
				return true;

			var obj = new Object();
			obj.fontType = 'normal';
			obj.fontSize = '11';
			obj.textColor_R = 0;
			obj.textColor_G = 0;
			obj.textColor_B = 0;
			obj.text = $.trim(el.data);
			obj.tablecell = true;
			obj.newRow = newRow;
			obj.row = row;
			obj.col = col;
			result.push(obj);
		}

		if (nodeName == 'B') {
			var obj = new Object();
			obj.fontType = 'bold';
			obj.fontSize = '11';
			obj.textColor_R = 0;
			obj.textColor_G = 0;
			obj.textColor_B = 0;
			obj.text = $.trim(el.innerText);
			obj.tablecell = true;
			obj.newRow = newRow;
			obj.row = row;
			obj.col = col;
			result.push(obj);
		}

		if (nodeName == 'I') {
			var obj = new Object();
			obj.fontType = 'italic';
			obj.fontSize = '11';
			obj.textColor_R = 0;
			obj.textColor_G = 0;
			obj.textColor_B = 0;
			obj.text = $.trim(el.innerText);
			obj.tablecell = true;
			obj.newRow = newRow;
			obj.row = row;
			obj.col = col;
			result.push(obj);
		}

		if (nodeName == 'BR')
			newRow = true;
		else
			newRow = false;
	});
} // .end of documentCommon_parseTableCell4jsPDF
