
function documentProcessor_getTextY(y, lineHeight, textHeight) {
	return y + lineHeight - (textHeight - lineHeight);
} // .end of documentProcessor_getTextY

function documentProcessor_preview_preload(callback, documentTemplateObj, billingObj, printRemarks, printComponents)
{
	if (billingObj == null)
		return documentProcessor_preview(callback, documentTemplateObj);
	
	if ($.trim(billingObj.customerId)=='')
		return documentProcessor_preview(callback, documentTemplateObj, billingObj);
	
	var requestBody = {
			'appName': APP_NAME_POS,
			'customerId': $.trim(billingObj.customerId),
			'fullBean': true	
		};	

	var params = new Object();
	params.callback = callback;
	params.documentTemplateObj = documentTemplateObj;
	params.billingObj = billingObj;
	params.printRemarks = printRemarks;
	params.printComponents = printComponents;
	
	tycheesdb_api_getCustomerById(requestBody, documentProcessor_preview_preload_postHandler, params);
} // .end of documentProcessor_preview_preload

function documentProcessor_preview_preload_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
	
	documentProcessor_preview(
			params.callback, 
			params.documentTemplateObj, 
			params.billingObj, 
			responseObj.customerObj,
			params);
} // .end of documentProcessor_preview_preload_postHandler

function documentProcessor_preview(callback, documentTemplateObj, billingObj, customerObj, params)
{
	if (documentTemplateObj == null) 
		return false;
	
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var c_currency = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY).propValue;
	
	var pdfDoc = new jsPDF({
		//orientation: 'portrait',
		unit: 'pt',
		format: [documentTemplateObj.width, documentTemplateObj.height]
	});
	// Optional - set properties on the document
	pdfDoc.setProperties({
		title: documentTemplateObj.name,
		subject: documentTemplateObj.name,
		author: placeObj.name,
		keywords: '',
		creator: placeObj.name
	});
	pdfDoc.setDisplayMode(3);	// zoom 3x

	// Sorting
	documentTemplateObj.componentList.sort(function(a, b) {
 		if (a.seqno < b.seqno) return -1;
		if (a.seqno > b.seqno) return 1;
		return 0;
 	});
	
	$.each(documentTemplateObj.componentList, function(i, componentObj) {
		
		if (Cached_isDeletedBean(componentObj))
			return true;
		
		var attributesObj = JSON.parse(componentObj.attributes);
		
		// Component: TEXT
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {

			var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
			pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
			pdfDoc.setFont(attributesObj.fontFamily, attributesObj.fontStyle);
			pdfDoc.setFontSize(attributesObj.fontSize);
			
			var textDimension = pdfDoc.getTextDimensions(attributesObj.text);
			var textVal = $.trim(attributesObj.text);
			
			if (attributesObj.requireUserInput) {
				var billingAttributesObj = new Object();
				if (billingObj != null && $.trim(billingObj.attributes) != '')
					billingAttributesObj = JSON.parse(billingObj.attributes);
				
				var userInputVal = $.trim(billingAttributesObj[componentObj.name]);
				textVal = userInputVal;				
			}
						
			// Calculate Y-Position
			var yPos = documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight(), textDimension.h);
			if ($.trim(attributesObj.afterComponent) != '' && attributesObj.afterComponent != 'absolute')	{
				$.each(documentTemplateObj.componentList, function(i, componentObj) {
					if (componentObj.id == attributesObj.afterComponent) {
						var otherAttributesObj = JSON.parse(componentObj.attributes);
						if (otherAttributesObj.y2 != null) {
							yPos = otherAttributesObj.y2 + 50;
						}
					}
				});
			}
			
			pdfDoc.writeText(
				attributesObj.x1, 
				yPos,
				textVal, 
				{
					align: attributesObj.align, 
					width: attributesObj.width
				});			
			
			attributesObj.y2 = yPos;
			componentObj.attributes = JSON.stringify(attributesObj);
		}
		
		// Component: LINE
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_LINE) {

			var strokeRGB = tycheesColor_rgbToNumber(attributesObj.stroke);
			pdfDoc.setDrawColor(strokeRGB.r, strokeRGB.g, strokeRGB.b);
			pdfDoc.setLineWidth(attributesObj.strokeWidth);
			pdfDoc.setLineCap(attributesObj.lineCap);
			
			pdfDoc.line(
				attributesObj.x1, 
				attributesObj.y1, 
				attributesObj.x2, 
				attributesObj.y2);
		}
		
		// Component: BOX
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BOX) {

			var strokeRGB = tycheesColor_rgbToNumber(attributesObj.stroke);
			var fillRGB = tycheesColor_rgbToNumber(attributesObj.fill);

			var style = '';
			if (attributesObj.strokeEnabled && !attributesObj.fillEnabled) {
				pdfDoc.setDrawColor(strokeRGB.r, strokeRGB.g, strokeRGB.b);
				style = 'S';
			}
			if (!attributesObj.strokeEnabled && attributesObj.fillEnabled) {
				pdfDoc.setFillColor(fillRGB.r, fillRGB.g, fillRGB.b);
				style = 'F';
			}
			if (attributesObj.strokeEnabled && attributesObj.fillEnabled) {
				pdfDoc.setDrawColor(strokeRGB.r, strokeRGB.g, strokeRGB.b);
				pdfDoc.setFillColor(fillRGB.r, fillRGB.g, fillRGB.b);
				style = 'FD';
			}
			
			pdfDoc.setLineWidth(attributesObj.strokeWidth);
			
			if (attributesObj.cornerRadius > 0) {
				pdfDoc.roundedRect(
					attributesObj.x1, 
					attributesObj.y1, 
					attributesObj.width, 
					attributesObj.height, 
					attributesObj.cornerRadius, 
					attributesObj.cornerRadius, 
					style);
			} else {
				pdfDoc.rect(
					attributesObj.x1, 
					attributesObj.y1, 
					attributesObj.width, 
					attributesObj.height, 
					style);
			}
			
			attributesObj.y2 = attributesObj.y1 + attributesObj.height;
			componentObj.attributes = JSON.stringify(attributesObj);
		}
		
		// Component: DATE
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_DATE) {

			var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
			pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
			pdfDoc.setFont(attributesObj.fontFamily, attributesObj.fontStyle);
			pdfDoc.setFontSize(attributesObj.fontSize);

	        var textVal = attributesObj.text;
	        if (attributesObj.defaultValue == 'today') {
	        	if (attributesObj.format == 'DD/MM/YYYY')
	        		textVal = tycheesDateTime_getFormattedDate_ddMMyyyy( tycheesDateTime_getCurrentTimeInMillis() );
	        	if (attributesObj.format == 'YYYY/MM/DD')
	        		textVal = tycheesDateTime_getFormattedDate_yyyyMMdd( tycheesDateTime_getCurrentTimeInMillis() );
	        	if (attributesObj.format == 'MMM DD, YYYY')
	        		textVal = tycheesDateTime_getFormattedDate_MMMddyyyy( tycheesDateTime_getCurrentTimeInMillis() );        	 
	        }
	        
			var textDimension = pdfDoc.getTextDimensions(textVal);
			
			pdfDoc.writeText(
				attributesObj.x1, 
				documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight(), textDimension.h),
				textVal, 
				{
					align: attributesObj.align, 
					width: attributesObj.width
				});
			
			attributesObj.y2 = documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight(), textDimension.h);
			componentObj.attributes = JSON.stringify(attributesObj);
		}
		
		// Component: IMAGE 
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_IMAGE) {
			
			var x1 = Number(attributesObj.x1);
	        var y1 = Number(attributesObj.y1);

	        if (x1 == NaN || y1 == NaN)
	            return false;

	        if (placeObj == null)
	        	placeObj = tycheesCommon_getCurrentPlaceObject();
	                
	        $.each(placeObj.imageList, function(i, imageObj) {
	        	if (imageObj.id == attributesObj.imageId) {
	        		if (imageObj != null && $.trim(imageObj.base64) != '') {
	        			
	        			var imageFormat = '';
	        			if (imageObj.fileType.toUpperCase() == 'IMAGE/PNG')
	        				imageFormat = 'PNG';
	        			if (imageObj.fileType.toUpperCase() == 'IMAGE/JPEG')
	        				imageFormat = 'JPEG';
	        			
	        			if (imageFormat == '')
	        				return true;   
	        			if (attributesObj.x1 == null || attributesObj.x1 < 0)
	        				return true;   
	        			if (attributesObj.y1 == null || attributesObj.y1 < 0)
	        				return true;   
	        			if (attributesObj.imageWidth == null || attributesObj.imageWidth <= 0)
	        				return true;   
	        			if (attributesObj.imageHeight == null || attributesObj.imageHeight <= 0)
	        				return true;   
	        			
	            		pdfDoc.addImage(
	            			imageObj.base64, 
	            			imageFormat, 
	        				attributesObj.x1, 
	        				attributesObj.y1, 
	        				attributesObj.imageWidth, 
	        				attributesObj.imageHeight);
	        		}
	        		
	            	attributesObj.y2 = attributesObj.y1 + attributesObj.imageHeight;
	            	componentObj.attributes = JSON.stringify(attributesObj);
	        	}
	        });
		}

		// Component: PLACE FIELD
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_PLACE_FIELD) {
			
			var x1 = Number(attributesObj.x1);
	        var y1 = Number(attributesObj.y1);

	        if (x1 == NaN || y1 == NaN)
	            return false;

	        if (placeObj == null)
	        	placeObj = tycheesCommon_getCurrentPlaceObject();
	        
	        if (attributesObj.fieldType == 'place.logo') {
	        	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
	        	
	        	if (companyLogoImageObj != null && $.trim(companyLogoImageObj.base64) != '')
	        	
	        		var imageFormat = '';
	    			if (companyLogoImageObj.fileType.toUpperCase() == 'IMAGE/PNG')
	    				imageFormat = 'PNG';
	    			if (companyLogoImageObj.fileType.toUpperCase() == 'IMAGE/JPEG')
	    				imageFormat = 'JPEG';
	    			
	    			if (imageFormat == '')
	    				return true;   
	    			if (attributesObj.x1 == null || attributesObj.x1 < 0)
	    				return true;   
	    			if (attributesObj.y1 == null || attributesObj.y1 < 0)
	    				return true;   
	    			if (attributesObj.imageWidth == null || attributesObj.imageWidth <= 0)
	    				return true;   
	    			if (attributesObj.imageHeight == null || attributesObj.imageHeight <= 0)
	    				return true;   
	    	    			
	        		pdfDoc.addImage(
        				companyLogoImageObj.base64, 
        				imageFormat, 
        				attributesObj.x1, 
        				attributesObj.y1, 
        				attributesObj.imageWidth, 
        				attributesObj.imageHeight);
	        	
	        	attributesObj.y2 = attributesObj.y1 + attributesObj.imageHeight;
	        	componentObj.attributes = JSON.stringify(attributesObj);
	        } else {

				var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
				pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
	    		pdfDoc.setFont(attributesObj.fontFamily, attributesObj.fontStyle);
				pdfDoc.setFontSize(attributesObj.fontSize);
				
	        	var textVal = '';
	        	
	        	if (attributesObj.fieldType == 'place.name')
	        		textVal = placeObj.name;
	    		if (attributesObj.fieldType == 'place.companyName')
	        		textVal = placeObj.companyName;
	    		if (attributesObj.fieldType == 'place.companyRegistrationNo')
	        		textVal = placeObj.companyRegistrationNo;
	    		if (attributesObj.fieldType == 'place.address')
	        		textVal = placeObj.address;
	    		if (attributesObj.fieldType == 'place.phone')
	        		textVal = placeObj.phone;
	    		if (attributesObj.fieldType == 'place.mobile')
	        		textVal = placeObj.mobile;
	    		if (attributesObj.fieldType == 'place.website')
	        		textVal = placeObj.website;
	    		if (attributesObj.fieldType == 'place.email')
	        		textVal = placeObj.email;
	    		if (attributesObj.fieldType == 'place.gstNumber')
	        		textVal = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GST_TAX_INVOICE_NUMBER).propValue;
	    		
	    		var textDimension;
	    		var splitTextVal = '';
	    		var lastTextVal = '';
	    		var splitTextArray = textVal.split(' ');
	    		var lineCount = 1;
	    		
	    		for (var i = 0 ; i < splitTextArray.length ; i++) {
	    			splitTextVal += (splitTextArray[i] + ' ');
	    			textDimension = pdfDoc.getTextDimensions(splitTextVal);
	    			
	    			if (textDimension.w > attributesObj.width) {
	    				
	    				pdfDoc.writeText(
    						attributesObj.x1, 
    						documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount),
    						lastTextVal, 
    						{
    							align: attributesObj.align, 
    							width: attributesObj.width
    						});
	    				
	    				lineCount++;
	    				splitTextVal = splitTextArray[i] + ' ';
	    				lastTextVal = splitTextVal;	    				
	    				
	    			} else {
	    				lastTextVal = splitTextVal;
	    			}
	    		}
	    		
	    		if (lastTextVal != '') {
	    			pdfDoc.writeText(
						attributesObj.x1, 
						documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount),
						lastTextVal, 
						{
							align: attributesObj.align, 
							width: attributesObj.width
						});
	    		}
	    		
	    		attributesObj.y2 = attributesObj.y1 + pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount;
	    		componentObj.attributes = JSON.stringify(attributesObj);
	        }
		}
		
		// Component: CUSTOMER FIELD
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_CUSTOMER_FIELD) {
			if (customerObj == null)
				return true;
			
			var attributesObj = JSON.parse(componentObj.attributes); 
			
			var x1 = Number(attributesObj.x1);
	        var y1 = Number(attributesObj.y1);

	        if (x1 == NaN || y1 == NaN)
	            return false;

			var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
			pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
    		pdfDoc.setFont(attributesObj.fontFamily, attributesObj.fontStyle);
			pdfDoc.setFontSize(attributesObj.fontSize);
			
        	var textVal = '';
        	
        	if (attributesObj.fieldType == 'customer.name') {
        		textVal = tycheesBean_person_getFullName(customerObj);
        		
        		// Get user input
        		var billingAttributesObj = JSON.parse(billingObj.attributes);
        		if (billingAttributesObj != null) {
        			textVal = $.trim(billingAttributesObj[componentObj.name]);        			
        		}
        	}
    		if (attributesObj.fieldType == 'customer.customerNo')
        		textVal = customerObj.customerNo;
    		if (attributesObj.fieldType == 'customer.salespersonName')
        		textVal = customerObj.employeeName;
    		if (attributesObj.fieldType == 'customer.contact')
        		textVal = $.trim(customerObj.contact);
    		if (attributesObj.fieldType == 'customer.email')
        		textVal = $.trim(customerObj.email);
    		if (attributesObj.fieldType == 'customer.address')
        		textVal = $.trim(customerObj.address);

    		var textDimension;
    		var splitTextVal = '';
    		var lastTextVal = '';
    		var splitTextArray = textVal.split(' ');
    		var lineCount = 1;
    		
    		for (var i = 0 ; i < splitTextArray.length ; i++) {
    			splitTextVal += (splitTextArray[i] + ' ');
    			textDimension = pdfDoc.getTextDimensions(splitTextVal);
    			
    			if (textDimension.w > attributesObj.width) {
    				pdfDoc.writeText(
						attributesObj.x1, 
						documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount),
						lastTextVal, 
						{
							align: attributesObj.align, 
							width: attributesObj.width
						});
    				
    				lineCount++;
    				splitTextVal = splitTextArray[i] + ' ';
    				lastTextVal = splitTextVal;	    				
    				
    			} else {
    				lastTextVal = splitTextVal;
    			}
    		}
    		
    		if (lastTextVal != '') {
    			pdfDoc.writeText(
					attributesObj.x1, 
					documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount),
					lastTextVal, 
					{
						align: attributesObj.align, 
						width: attributesObj.width
					});
    		}
    		
    		attributesObj.y2 = attributesObj.y1 + pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount;
    		componentObj.attributes = JSON.stringify(attributesObj);
		}
		
		// Component: BILLING FIELD
		if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BILLING_FIELD) {
			if (billingObj == null)
				return true;
			
			var attributesObj = JSON.parse(componentObj.attributes); 
			
			var x1 = Number(attributesObj.x1);
	        var y1 = Number(attributesObj.y1);

	        if (x1 == NaN || y1 == NaN)
	            return false;

			var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
			pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
    		pdfDoc.setFont(attributesObj.fontFamily, attributesObj.fontStyle);
			pdfDoc.setFontSize(attributesObj.fontSize);
			
        	var textVal = '';
        	
        	if (attributesObj.fieldType == 'billing.billingNo')
        		textVal = $.trim(billingObj.billingNo);
    		if (attributesObj.fieldType == 'billing.billingDate')
        		textVal = tycheesDateTime_getFormattedDate_ddMMyyyy(billingObj.billingDate);
    		if (attributesObj.fieldType == 'billing.invoiceNo')
    			textVal = $.trim(billingObj.invoiceNo);
    		if (attributesObj.fieldType == 'billing.invoiceDate')
    			textVal = tycheesDateTime_getFormattedDate_ddMMyyyy(billingObj.invoiceDate);
    		if (attributesObj.fieldType == 'billing.quotationNo')
    			textVal = $.trim(billingObj.quotationNo);
    		if (attributesObj.fieldType == 'billing.quotationDate')
    			textVal = tycheesDateTime_getFormattedDate_ddMMyyyy(billingObj.quotationDate);
    		if (attributesObj.fieldType == 'billing.customerName')
        		textVal = $.trim(billingObj.customerName);
    		if (attributesObj.fieldType == 'billing.salesPersonName')
    			textVal = $.trim(billingObj.employeeName);
    		
    		if (textVal != '') {
	    		var textDimension;
	    		var splitTextVal = '';
	    		var lastTextVal = '';
	    		var splitTextArray = textVal.split(' ');
	    		var lineCount = 1;
	    		
	    		for (var i = 0 ; i < splitTextArray.length ; i++) {
	    			splitTextVal += (splitTextArray[i] + ' ');
	    			textDimension = pdfDoc.getTextDimensions(splitTextVal);
	    			
	    			if (textDimension.w > attributesObj.width) {
	    				pdfDoc.writeText(
							attributesObj.x1, 
							documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount),
							lastTextVal, 
							{
								align: attributesObj.align, 
								width: attributesObj.width
							});
	    				
	    				lineCount++;
	    				splitTextVal = splitTextArray[i] + ' ';
	    				lastTextVal = splitTextVal;	    				
	    				
	    			} else {
	    				lastTextVal = splitTextVal;
	    			}
	    		}
	    		
	    		if (lastTextVal != '') {
	    			pdfDoc.writeText(
						attributesObj.x1, 
						documentProcessor_getTextY(attributesObj.y1, pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount),
						lastTextVal, 
						{
							align: attributesObj.align, 
							width: attributesObj.width
						});
	    		}
	    		
	    		attributesObj.y2 = attributesObj.y1 + pdfDoc.getLineHeight() * lineCount + ((lineCount-1) * 3), textDimension.h * lineCount;
	    		componentObj.attributes = JSON.stringify(attributesObj);
    		}
    		
    		if (attributesObj.fieldType == 'billing.billingLines')
        	{
    			var tableWidth = attributesObj.width;
    			var headerColumns = JSON.parse(attributesObj.headerColumns);
    			
    			// Billing Lines: Table header
    			var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
    			pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
    			pdfDoc.setFontSize(attributesObj.fontSize);
    			pdfDoc.setFontType(attributesObj.fontStyle);
    			
    			var containItemNameColumn = false;
    			$.each(headerColumns, function(i, column) {    				
    				if (column == 'itemName') {
    					containItemNameColumn = true;
    				}
    			});
    			
    			var averageColumnWidth = (tableWidth - 280) / (headerColumns.length - 1);
    			
    			// Get X-Position
    			var xPos = attributesObj.x1;
    			// Calculate Y-Position
    			var yPos = attributesObj.y1;
				if ($.trim(attributesObj.afterComponent) != '' && attributesObj.afterComponent != 'absolute')	{
					$.each(documentTemplateObj.componentList, function(i, componentObj) {
						if (componentObj.id == attributesObj.afterComponent) {
							var otherAttributesObj = JSON.parse(componentObj.attributes);
							if (otherAttributesObj.y2 != null) {
								yPos = otherAttributesObj.y2 + 50;
							}
						}
					});
				}
    			
				// Print Table Header
    			var columnWidth = 0;
    			$.each(headerColumns, function(i, column) {
    				
    				if (column == 'itemName') {
    	    			pdfDoc.writeText(xPos, yPos, 'ITEM', {align: 'left', width: 280});
    	    			columnWidth = 280;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'quantity') {
    	    			pdfDoc.writeText(xPos, yPos, 'QUANTITY', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'unitPrice') {
    	    			pdfDoc.writeText(xPos, yPos, 'UNIT PRICE', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'amount') {
    	    			pdfDoc.writeText(xPos, yPos, 'AMOUNT (' + c_currency.toUpperCase() + ')', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'taxAmount') {
    	    			pdfDoc.writeText(xPos, yPos, 'TAX (' + c_currency.toUpperCase() + ')', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'taxPercentage') {
    	    			pdfDoc.writeText(xPos, yPos, 'TAX (%)', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'discountAmount') {
    	    			pdfDoc.writeText(xPos, yPos, 'DSC (' + c_currency.toUpperCase() + ')', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'discountPercentage') {
    	    			pdfDoc.writeText(xPos, yPos, 'DSC (%)', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    			});
    			
    			// Billing Lines: Line Break
    			pdfDoc.setLineWidth(0.05);
    			pdfDoc.line(attributesObj.x1, yPos + 5, attributesObj.x1 + tableWidth, yPos + 5);

    			// Billing Lines: Print Table Content    			
    			yPos = yPos + 5;
    			var billingSubTotalAmount = 0;
    			var billingTotalTaxAmount = 0;
    			var componentPrintedCount = 0;
    			
    			$.each(billingObj.lineList, function(i, lineObj) {

    				if (Cached_isDeletedBean(lineObj))
    					return true;

    				if (lineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
    					lineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
    					lineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
    					lineObj.itemType == InventoryConstants.ITEM_TYPE_RAW) 
    				{
    					// increment y-position to next line
    	    			yPos += 15;
    	    			
    	    			// reset count
    	    			componentPrintedCount = 0;
    	    			
    					var xPos = attributesObj.x1;
    	    			var columnWidth = 0;
    	    			$.each(headerColumns, function(i, column) {
    	    				
    	    				if (column == 'itemName') {
    	    	    			pdfDoc.writeText(xPos, yPos, lineObj.itemName, {align: 'left', width: 280});
    	    	    			
    	    	    			var yPosOffset = 0;
    	    	    			if (params.printRemarks) { 
    	    	    				yPosOffset += 15;
    	    	    				pdfDoc.writeText(xPos + 5, yPos + yPosOffset, '- ' + lineObj.remarks, {align: 'left', width: 280});
    	    	    			}
    	    	    			
    	    	    			if (params.printComponents) {
    	    	    				$.each(lineObj.lineList, function(j, childLineObj) {
    	    	    					yPosOffset += 15;
    	    	    					
    	    	    					if (childLineObj.mandatory) {
    	    	    						pdfDoc.writeText(xPos + 5, yPos + yPosOffset, '* Mandatory: ' + childLineObj.itemName, {align: 'left', width: 280});
    	    	    					} else {
    	    	    						pdfDoc.writeText(xPos + 5, yPos + yPosOffset, '* Optional: ' + childLineObj.itemName, {align: 'left', width: 280});
    	    	    					}
    	    	    					
    	    	    					componentPrintedCount++;
    	    	    				});
    	    	    			}
    	    	    			
    	    	    			columnWidth = 280;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'quantity') {
    	    	    			pdfDoc.writeText(xPos, yPos, lineObj.quantity.toString(), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'unitPrice') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.billableAmount).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'amount') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.billableAmount * lineObj.quantity).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'taxAmount') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.taxAmount * lineObj.quantity).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'taxPercentage') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.taxPercentage).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'discountAmount') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.discountAmount * lineObj.quantity).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'discountPercentage') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.discountPercentage).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    			});

    					// Line Break
    	    			if (params.printRemarks || params.printComponents) {
    	    			
    	    				if (params.printRemarks) {
    	    					yPos += 25;
    	    				}
    	    				
    	    				if (params.printComponents) {
    	    					yPos += (20 * componentPrintedCount);
    	    				}
    	    				
    	    				pdfDoc.setLineWidth(0.02);
	    					pdfDoc.line(attributesObj.x1, yPos, attributesObj.x1 + tableWidth, yPos);
    	    			} else {
    	    				
	    	    			yPos += 5;
		    				pdfDoc.setLineWidth(0.02);
		    				pdfDoc.line(attributesObj.x1, yPos, attributesObj.x1 + tableWidth, yPos);
    	    			}
    	    			
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

    					yPos += 15;
    	    			
    					var xPos = attributesObj.x1;
    	    			var columnWidth = 0;
    	    			$.each(headerColumns, function(i, column) {
    	    				
    	    				if (column == 'itemName') {
    	    	    			pdfDoc.writeText(xPos, yPos, lineObj.itemName, {align: 'left', width: 280});
    	    	    			columnWidth = 280;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'quantity') {
    	    	    			pdfDoc.writeText(xPos, yPos, lineObj.quantity.toString(), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'unitPrice') {
    	    	    			pdfDoc.writeText(xPos, yPos, '- ' + Number(lineObj.discountAmount).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'amount') {
    	    	    			pdfDoc.writeText(xPos, yPos, '- ' + Number(lineObj.discountAmount * lineObj.quantity).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'taxAmount') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.taxAmount * lineObj.quantity).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'taxPercentage') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.taxPercentage).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'discountAmount') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.discountAmount * lineObj.quantity).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    				if (column == 'discountPercentage') {
    	    	    			pdfDoc.writeText(xPos, yPos, Number(lineObj.discountPercentage).toFixed(2), {align: 'right', width: averageColumnWidth});
    	    	    			columnWidth = averageColumnWidth;
    	    	    			xPos = xPos + columnWidth;
    	    				}
    	    			});

    					// Line Break
    	    			yPos += 5;
    					pdfDoc.setLineWidth(0.02);
    					pdfDoc.line(attributesObj.x1, yPos, attributesObj.x1 + tableWidth, yPos);

    					// Prepare data for summary
    					billingSubTotalAmount -= (lineObj.discountAmount * lineObj.quantity);
    				}
    			});
    			
    			// Summary: Sub Total
    			//yPos += 30;
    			//pdfDoc.setFontType('bold');
    			//pdfDoc.text('SUB TOTAL:', 450, yPos, 'right');
    			//pdfDoc.setFontType('normal');
    			//pdfDoc.text(Number(billingSubTotalAmount).toFixed(2), attributesObj.x1 + tableWidth, yPos, 'right');

    			// Summary: Add GST 6%
    			//yPos += 15;
    			//pdfDoc.setFontType('bold');
    			//pdfDoc.text('ADD GST 6%:', 450, yPos, 'right');
    			//pdfDoc.setFontType('normal');
    			//pdfDoc.text(Number(billingObj.taxAmount).toFixed(2), attributesObj.x1 + tableWidth, yPos, 'right');

    			// Summary: TOTAL
    			yPos += 30;
    			pdfDoc.setFontType('bold');
    			pdfDoc.text('TOTAL:', 450, yPos, 'right');
    			pdfDoc.setFontType('normal');
    			pdfDoc.text(Number(billingObj.totalAmount).toFixed(2), attributesObj.x1 + tableWidth, yPos, 'right');
    			
    			attributesObj.y2 = yPos;
    			componentObj.attributes = JSON.stringify(attributesObj);
        	}
    		
    		if (attributesObj.fieldType == 'billing.paymentList')
        	{
    			var tableWidth = attributesObj.width;
    			var headerColumns = JSON.parse(attributesObj.headerColumns);
    			
    			// Payment List: Table header
    			var colorRGB = tycheesColor_rgbToNumber(attributesObj.fill);
    			pdfDoc.setTextColor(colorRGB.r, colorRGB.g, colorRGB.b);
    			pdfDoc.setFontSize(attributesObj.fontSize);
    			pdfDoc.setFontType(attributesObj.fontStyle);
    			
    			var containItemNameColumn = false;
    			$.each(headerColumns, function(i, column) {    				
    				if (column == 'itemName') {
    					containItemNameColumn = true;
    				}
    			});
    			
    			// Get X-Position
    			var xPos = attributesObj.x1;
				
    			// Calculate Y-Position
    			var yPos = attributesObj.y1;
				if ($.trim(attributesObj.afterComponent) != '' && attributesObj.afterComponent != 'absolute')	{
					$.each(documentTemplateObj.componentList, function(i, componentObj) {
						if (componentObj.id == attributesObj.afterComponent) {
							var otherAttributesObj = JSON.parse(componentObj.attributes);
							if (otherAttributesObj.y2 != null) {
								yPos = otherAttributesObj.y2 + 50;
							}
						}
					});
				}	

				// Calculate Column Width
    			var averageColumnWidth = (tableWidth - 280) / (headerColumns.length - 1);    			
    			var columnWidth = 0;
    			$.each(headerColumns, function(i, column) {
    				
    				if (column == 'paymentDate') {
    	    			pdfDoc.writeText(xPos, yPos, 'PAYMENT DATE', {align: 'left', width: 280});
    	    			columnWidth = 280;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'paymentMethod') {
    	    			pdfDoc.writeText(xPos, yPos, 'METHOD', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    				if (column == 'paymentAmount') {
    	    			pdfDoc.writeText(xPos, yPos, 'AMOUNT (' + c_currency.toUpperCase() + ')', {align: 'right', width: averageColumnWidth});
    	    			columnWidth = averageColumnWidth;
    	    			xPos = xPos + columnWidth;
    				}
    			});
    			
    			// Payment List: Line Break
    			yPos = yPos + 5;
    			pdfDoc.setLineWidth(0.05);
    			pdfDoc.line(attributesObj.x1, yPos, attributesObj.x1 + tableWidth, yPos);

    			// Payment List: variables
    			$.each(billingObj.paymentList, function(i, paymentObj) {

    				if (Cached_isDeletedBean(paymentObj))
    					return true;
    				if (paymentObj.status == 'void')
    					return true;
    				
	    			yPos += 15;
	    			
					var xPos = attributesObj.x1;
	    			var columnWidth = 0;
	    			$.each(headerColumns, function(i, column) {
	    				
	    				if (column == 'paymentDate') {
	    	    			pdfDoc.writeText(xPos, yPos, tycheesDateTime_getFormattedDate_ddMMyyyy(paymentObj.paymentDate), {align: 'left', width: 280});
	    	    			columnWidth = 280;
	    	    			xPos = xPos + columnWidth;
	    				}
	    				if (column == 'paymentMethod') {
	    					if ($.trim(paymentObj.methodDesc) == '')
	    						pdfDoc.writeText(xPos, yPos, paymentObj.method, {align: 'right', width: averageColumnWidth});
	    					else
	    						pdfDoc.writeText(xPos, yPos, paymentObj.method + ' (' + paymentObj.methodDesc + ')', {align: 'right', width: averageColumnWidth});
	    	    			columnWidth = averageColumnWidth;
	    	    			xPos = xPos + columnWidth;
	    				}
	    				if (column == 'paymentAmount') {
	    	    			pdfDoc.writeText(xPos, yPos, Number(paymentObj.payingAmount).toFixed(2), {align: 'right', width: averageColumnWidth});
	    	    			columnWidth = averageColumnWidth;
	    	    			xPos = xPos + columnWidth;
	    				}
	    			});

					// Line Break
	    			yPos += 5;
					pdfDoc.setLineWidth(0.02);
					pdfDoc.line(attributesObj.x1, yPos, attributesObj.x1 + tableWidth, yPos);
    			});
    			
    			attributesObj.y2 = yPos;
    			componentObj.attributes = JSON.stringify(attributesObj);
        	}
		}
	});
	
	if (callback == null)
		return pdfDoc;
	else
		callback(pdfDoc);
} // .end of documentProcessor_preview