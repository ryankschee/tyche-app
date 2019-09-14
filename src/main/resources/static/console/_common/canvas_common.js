function commonCanvas_isComponentCollided(x, y, componentObj) {
    // SHAPE: Rectangle
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE) {
        var compX = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'x1'));
        var compY = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'y1'));
        var compWidth = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'width'));
        var compHeight = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'height'));

        var insideHorizontally = false;
        var insideVertically = false;

        if (x > compX && x < (compX + compWidth))
            insideHorizontally = true;

        if (y > compY && y < (compY + compHeight))
            insideVertically = true;

        return insideHorizontally && insideVertically;
    }

    // SHAPE: Rectangle
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE) {
        var compX = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'x1'));
        var compY = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'y1'));
        var compRadius = Number(tycheesCommon_getObjectAttributeValue(componentObj.attributes, 'radius'));

        var distanceSquared = (x - compX) * (x - compX) + (y - compY) * (y - compY);
        return distanceSquared <= compRadius * compRadius;
    }
} // commonCanvas_isComponentCollided

/**
 * Draw layout component into canvas (Settings).
 */
function commonCanvas_settings_drawKonva(layerObj, componentObj) {
    // Add component into Canvas
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_LINE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        var x2 = Number(attributeObj.x2);
        var y2 = Number(attributeObj.y2);
        var stroke = $.trim(attributeObj.stroke);
        var strokeWidth = Number(attributeObj.strokeWidth);
        var rotationDegree = Number(attributeObj.rotationDegree);

        if (x1 == NaN || y1 == NaN || x2 == NaN || y2 == NaN)
            return false;

        var line = new Konva.Line({
            points: [x1, y1, x2, y2],
            stroke: stroke,
            strokeWidth: strokeWidth,
            lineCap: 'round',
            lineJoin: 'round',
            draggable: true
        });
        // add the shape to the layer
        layerObj.add(line);
        
        return line;
    }
    else
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        var z1 = Number(attributeObj.z1);
        var width = Number(attributeObj.width);
        var height = Number(attributeObj.height);
        var fill = $.trim(attributeObj.fill);
        var stroke = $.trim(attributeObj.stroke);
        var strokeWidth = Number(attributeObj.strokeWidth);
        var rotationDegree = Number(attributeObj.rotationDegree);

        if (x1 == NaN || y1 == NaN || width == NaN || height == NaN)
            return false;

        if (z1==null || z1==NaN || z1==0)
        	z1 = 1;
        if (fill==null || fill==NaN || fill==0)
        	fill = 'red';
        if (stroke==null || stroke==NaN || stroke==0)
        	stroke = 'black';
        if (strokeWidth==null || strokeWidth==NaN || strokeWidth==0)
        	strokeWidth = 2;
              
        var group = new Konva.Group({
            draggable: true
        });
        
        var rect = new Konva.Rect({
            x: Math.abs(x1),
            y: Math.abs(y1),
            width: Math.abs(width),
            height: Math.abs(height),
            fill: fill,
            stroke: stroke,
            strokeWidth: Math.abs(strokeWidth)
            //offset: {
                //x: tycheesMath_round(x1 + (width / 2), 0),
                //y: tycheesMath_round(y1 + (height / 2), 0)
                //x: tycheesMath_round(width / 2, 0),
                //y: tycheesMath_round(height / 2, 0)
            //}
        });
        // Add shape to group
        group.add(rect);

        // since this text is inside of a defined area, we can center it using align: 'center'
        var text = new Konva.Text({
            x: Math.abs(x1),
            y: Math.abs(y1) + Math.abs(height/2) - 10,
            text: $.trim(componentObj.name),
            fontSize: 18,
            fontFamily: 'Calibri',
            fill: tycheesColor_invertHEX(fill),
            width: Math.abs(width),
            padding: 0,
            align: 'center'
        });
        // Add shape to group
        group.add(text);

        // Rotation
        //group.rotation(rotationDegree);
        
        // add the shape to the layer
        layerObj.add(group);
        
        return group;
    }
    else
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE) {
        var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        var z1 = Number(attributeObj.z1);
        var radius = Number(attributeObj.radius);
        var fill = $.trim(attributeObj.fill);
        var stroke = $.trim(attributeObj.stroke);
        var strokeWidth = Number(attributeObj.strokeWidth);
        var rotationDegree = Number(attributeObj.rotationDegree);
        
        if (x1 == NaN || y1 == NaN || radius == NaN)
            return false;

        if (z1==null || z1==NaN || z1==0)
        	z1 = 1;
        if (fill==null || fill==NaN || fill==0)
        	fill = 'red';
        if (stroke==null || stroke==NaN || stroke==0)
        	stroke = 'black';
        if (strokeWidth==null || strokeWidth==NaN || strokeWidth==0)
        	strokeWidth = 2;
        
        var group = new Konva.Group({
            draggable: true
        });
        
        var circle = new Konva.Circle({
            x: Math.abs(x1),
            y: Math.abs(y1),
            //zIndex: z1,
            radius: Math.abs(radius),
            fill: fill,
            stroke: stroke,
            strokeWidth: Math.abs(strokeWidth)
        });
        // Add shape to group
        group.add(circle);

        // since this text is inside of a defined area, we can center it using align: 'center'
        var text = new Konva.Text({
            x: Math.abs(x1) - Math.abs(radius),
            y: Math.abs(y1) - 10,
            text: $.trim(componentObj.name),
            fontSize: 18,
            fontFamily: 'Calibri',
            fill: tycheesColor_invertHEX(fill),
            width: Math.abs(radius * 2),
            padding: 0,
            align: 'center'
        });
        // Add shape to group
        group.add(text);
        
        // Rotation
        //group.rotation(rotationDegree);
        
        // add the shape to the layer
        layerObj.add(group);
        
        return group;
    }
} // .end of commonCanvas_settings_drawKonva

/**
 * Draw layout component into canvas (POS).
 */
function commonCanvas_pos_drawKonva(layerObj, componentObj, billingBucketObj) {
    
	// Add component into Canvas
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_LINE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        var x2 = Number(attributeObj.x2);
        var y2 = Number(attributeObj.y2);
        var stroke = $.trim(attributeObj.stroke);
        var strokeWidth = Number(attributeObj.strokeWidth);
        var rotationDegree = Number(attributeObj.rotationDegree);

        if (x1 == NaN || y1 == NaN || x2 == NaN || y2 == NaN)
            return false;

        if (stroke==null || stroke==NaN || stroke==0)
        	stroke = 'black';
        if (strokeWidth==null || strokeWidth==NaN || strokeWidth==0)
        	strokeWidth = 2;
        
        var group = new Konva.Group({
            draggable: false
        });

    	var line = new Konva.Line({
            points: [x1, y1, x2, y2],
            stroke: stroke,
            strokeWidth: Math.abs(strokeWidth)
        });
        // Add shape to group
        group.add(line);

        // Rotation
        //group.rotation(rotationDegree);
        
        // add the shape to the layer
        layerObj.add(group);
        
        return group;
    }
    else
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        var z1 = Number(attributeObj.z1);
        var width = Number(attributeObj.width);
        var height = Number(attributeObj.height);
        var fill = $.trim(attributeObj.fill);
        var stroke = $.trim(attributeObj.stroke);
        var strokeWidth = Number(attributeObj.strokeWidth);
        var rotationDegree = Number(attributeObj.rotationDegree);

        if (x1 == NaN || y1 == NaN || width == NaN || height == NaN)
            return false;

        if (z1==null || z1==NaN || z1==0)
        	z1 = 1;
        if (fill==null || fill==NaN || fill==0)
        	fill = 'red';
        if (stroke==null || stroke==NaN || stroke==0)
        	stroke = 'black';
        if (strokeWidth==null || strokeWidth==NaN || strokeWidth==0)
        	strokeWidth = 2;
        
        if (billingBucketObj == null) {
            var group = new Konva.Group({
                draggable: false
            });

        	var rect = new Konva.Rect({
                x: Math.abs(x1),
                y: Math.abs(y1),
                width: Math.abs(width),
                height: Math.abs(height),
                fill: fill,
                stroke: stroke,
                strokeWidth: Math.abs(strokeWidth)
            });
            // Add shape to group
            group.add(rect);

            // since this text is inside of a defined area, we can center it using align: 'center'
            var text = new Konva.Text({
                x: Math.abs(x1),
                y: Math.abs(y1) + Math.abs(height/2) - 10,
                text: $.trim(componentObj.name),
                fontSize: 18,
                fontFamily: 'Calibri',
                fill: tycheesColor_invertHEX(fill),
                width: Math.abs(width),
                padding: 0,
                align: 'center'
            });
            // Add shape to group
            group.add(text);

	        // Rotation
	        //group.rotation(rotationDegree);
	        
            // add the shape to the layer
            layerObj.add(group);
            
            return group;
        } else {
        	var fillColor = fill;
        	var textColor = tycheesColor_invertHEX(fill);
        	
        	if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
                fillColor = '#428BCA';
                textColor = '#FFFFFF';
            }
            if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING) {
                fillColor = '#ED5565';
                textColor = '#FFFFFF';
            }
            if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_UNDER_PAID) {
                fillColor = '#F8AC59';
                textColor = '#FFFFFF';
            }
            if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_FULLY_PAID) {
                fillColor = '#1AB394';
                textColor = '#FFFFFF';
            }

            var group = new Konva.Group({
                draggable: false
            });

        	var rect = new Konva.Rect({
                x: Math.abs(x1),
                y: Math.abs(y1),
                width: Math.abs(width),
                height: Math.abs(height),
                fill: fillColor,
                stroke: stroke,
                strokeWidth: Math.abs(strokeWidth)
            });
            // Add shape to group
            group.add(rect);

            // since this text is inside of a defined area, we can center it using align: 'center'
            var text = new Konva.Text({
                x: Math.abs(x1),
                y: Math.abs(y1) + Math.abs(height/2) - 10,
                text: $.trim(componentObj.name),
                fontSize: 18,
                fontFamily: 'Calibri',
                fill: textColor,
                width: Math.abs(width),
                padding: 0,
                align: 'center'
            });
            // Add shape to group
            group.add(text);

            // Rotation
            //group.rotation(rotationDegree);
            
            // add the shape to the layer
            layerObj.add(group);
            
            return group;
        }
    }
    else
    if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        var z1 = Number(attributeObj.z1);
        var radius = Number(attributeObj.radius);
        var fill = $.trim(attributeObj.fill);
        var stroke = $.trim(attributeObj.stroke);
        var strokeWidth = Number(attributeObj.strokeWidth);
        var rotationDegree = Number(attributeObj.rotationDegree);
        
        if (x1 == NaN || y1 == NaN || radius == NaN)
            return false;

        if (z1==null || z1==NaN || z1==0)
        	z1 = 1;
        if (fill==null || fill==NaN || fill==0)
        	fill = 'red';
        if (stroke==null || stroke==NaN || stroke==0)
        	stroke = 'black';
        if (strokeWidth==null || strokeWidth==NaN || strokeWidth==0)
        	strokeWidth = 2;
        
        if (billingBucketObj == null) {

            var group = new Konva.Group({
                draggable: false
            });
            
            var circle = new Konva.Circle({
	            x: Math.abs(x1),
	            y: Math.abs(y1),
	            //zIndex: z1,
	            radius: Math.abs(radius),
	            fill: fill,
	            stroke: stroke,
	            strokeWidth: Math.abs(strokeWidth)
	        });
	        // Add shape to group
	        group.add(circle);
	
	        // since this text is inside of a defined area, we can center it using align: 'center'
	        var text = new Konva.Text({
	            x: Math.abs(x1) - Math.abs(radius),
	            y: Math.abs(y1) - 10,
	            text: $.trim(componentObj.name),
	            fontSize: 18,
	            fontFamily: 'Calibri',
	            fill: tycheesColor_invertHEX(fill),
	            width: Math.abs(radius * 2),
	            padding: 0,
	            align: 'center'
	        });
	        // Add shape to group
	        group.add(text);

	        // Rotation
	        //group.rotation(rotationDegree);
	        
	        // add the shape to the layer
	        layerObj.add(group);
	        
	        return group;     
        } else {
        	var fillColor = fill;
        	var textColor = tycheesColor_invertHEX(fill);
        	if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
                fillColor = '#428BCA';
                textColor = '#FFFFFF';
            }
            if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING) {
                fillColor = '#ED5565';
                textColor = '#FFFFFF';
            }
            if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_UNDER_PAID) {
                fillColor = '#F8AC59';
                textColor = '#FFFFFF';
            }
            if (billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_FULLY_PAID) {
                fillColor = '#1AB394';
                textColor = '#FFFFFF';
            }

            var group = new Konva.Group({
                draggable: false
            });
            
            var circle = new Konva.Circle({
	            x: Math.abs(x1),
	            y: Math.abs(y1),
	            //zIndex: z1,
	            radius: Math.abs(radius),
	            fill: fillColor,
	            stroke: stroke,
	            strokeWidth: Math.abs(strokeWidth)
	        });
	        // Add shape to group
	        group.add(circle);
	
	        // since this text is inside of a defined area, we can center it using align: 'center'
	        var text = new Konva.Text({
	            x: Math.abs(x1) - Math.abs(radius),
	            y: Math.abs(y1) - 10,
	            text: $.trim(componentObj.name),
	            fontSize: 18,
	            fontFamily: 'Calibri',
	            fill: textColor,
	            width: Math.abs(radius * 2),
	            padding: 0,
	            align: 'center'
	        });
	        // Add shape to group
	        group.add(text);

	        // Rotation
	        //group.rotation(rotationDegree);
	        
	        // add the shape to the layer
	        layerObj.add(group);
	        
	        return group;     
        }   
    }
} // .end of commonCanvas_pos_drawKonva


/**
 * Draw layout component into canvas (Settings).
 */
function commonCanvas_documents_drawKonva(layerObj, componentObj, postDrawingFn) {
    
	// If redraw required, then continue.
	//if (componentObj.repaint == false)
	//	return false;
	
	// Reset to false
	//componentObj.repaint = false; 
	
	// Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);

        if (x1 == NaN || y1 == NaN)
            return false;

        var text = new Konva.Text({
            x: x1,
            y: y1,
            text: attributeObj.text,
            fontSize: attributeObj.fontSize,
            fontFamily: attributeObj.fontFamily,
            fill: attributeObj.fill,
            width: attributeObj.width,
            padding: attributeObj.padding,
            align: attributeObj.align,
            draggable: true
        });
                
        // add the shape to the layer
        layerObj.add(text);
        
        postDrawingFn(componentObj, text);
    }
    
    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_LINE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);	
        var x2 = Number(attributeObj.x2);
        var y2 = Number(attributeObj.y2);

        if (x1 == NaN || y1 == NaN || x2 == NaN || y2 == NaN)
            return false;

        var line = new Konva.Line({
            points: [x1, y1, x2, y2],
            stroke: attributeObj.stroke,
            strokeWidth: attributeObj.strokeWidth,
            lineCap: attributeObj.lineCap,
            dash: [10,5],
            dashEnabled: attributeObj.dashEnabled,
            draggable: true
        });
                
        // add the shape to the layer
        layerObj.add(line);
        
        postDrawingFn(componentObj, line);
    }

    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BOX) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);	
        var width = Number(attributeObj.width);
        var height = Number(attributeObj.height);

        if (x1 == NaN || y1 == NaN || width == NaN || height == NaN)
            return false;

        var rect = new Konva.Rect({
            x: x1,
            y: y1,
            width: width,
            height: height,
            fill: attributeObj.fill,
            stroke: attributeObj.stroke,
            strokeWidth: attributeObj.strokeWidth,
            cornerRadius: attributeObj.cornerRadius,
            draggable: true
        });
                
        // add the shape to the layer
        layerObj.add(rect);
        
        postDrawingFn(componentObj, rect);
    }
 
    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_DATE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);

        if (x1 == NaN || y1 == NaN)
            return false;

        var textVal = '';
    	if (attributeObj.format == 'DD/MM/YYYY')
    		textVal = tycheesDateTime_getFormattedDate_ddMMyyyy( tycheesDateTime_getCurrentTimeInMillis() );
    	if (attributeObj.format == 'YYYY/MM/DD')
    		textVal = tycheesDateTime_getFormattedDate_yyyyMMdd( tycheesDateTime_getCurrentTimeInMillis() );
    	if (attributeObj.format == 'MMM DD, YYYY')
    		textVal = tycheesDateTime_getFormattedDate_MMMddyyyy( tycheesDateTime_getCurrentTimeInMillis() );
        
        var text = new Konva.Text({
            x: x1,
            y: y1,
            text: textVal,
            fontSize: attributeObj.fontSize,
            fontFamily: attributeObj.fontFamily,
            fill: attributeObj.fill,
            width: attributeObj.width,
            padding: attributeObj.padding,
            align: attributeObj.align,
            draggable: true
        });
                
        // add the shape to the layer
        layerObj.add(text);
        
        postDrawingFn(componentObj, text);
    }
 
    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_IMAGE) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);
        
        if (x1 == NaN || y1 == NaN)
            return false;

        if (attributeObj.imageId == '') {
        	
        } else {
        	var placeObj = tycheesCommon_getCurrentPlaceObject();
        	$.each(placeObj.imageList, function(i, placeImageObj) {
        		if (placeImageObj.id == attributeObj.imageId) {
        			
        			var imageObj = new Image();
        	        imageObj.onload = function() {            
        	        	var konvaImage = new Konva.Image({
        	        		x: attributeObj.x1,
        	        		y: attributeObj.y1,
        	        		image: imageObj,
        	        		width: placeImageObj == null ? 100 : attributeObj.imageWidth,
        	        		height: placeImageObj == null ? 97 : attributeObj.imageHeight,
        		            draggable: true            		
        	        	});
        	        	// add the shape to the layer
        	        	layerObj.add(konvaImage);
        	        	
        	        	konvaImage.draw();
        	        	
        	        	postDrawingFn(componentObj, konvaImage);
        	        };
        	        
        	        if (placeImageObj == null)
        	        	imageObj.src = '/resources/images/misc/noPhotoFound.png';
        	        else 
        	        	imageObj.src = placeImageObj.base64;
        		}
        	});            
        } 
    } // .end of draw image
    
    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_PLACE_FIELD) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);

        if (x1 == NaN || y1 == NaN)
            return false;

        if (attributeObj.fieldType == 'place.logo') {
        	var placeObj = tycheesCommon_getCurrentPlaceObject();
        	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
        	
	    	var imageObj = new Image();
	        imageObj.onload = function() {            
	        	var konvaImage = new Konva.Image({
	        		x: attributeObj.x1,
	        		y: attributeObj.y1,
	        		image: imageObj,
	        		width: companyLogoImageObj == null ? 100 : attributeObj.imageWidth,
	        		height: companyLogoImageObj == null ? 97 : attributeObj.imageHeight,
		            draggable: true            		
	        	});
	        	// add the shape to the layer
	        	layerObj.add(konvaImage);
	        	
	        	konvaImage.draw();
	        	
	        	postDrawingFn(componentObj, konvaImage);
	        };
	        if (companyLogoImageObj == null)
	        	imageObj.src = '/resources/images/misc/noPhotoFound.png';
	        else 
	        	imageObj.src = companyLogoImageObj.base64;
            
        } else {
        	var textVal = '';
        	var placeObj = tycheesCommon_getCurrentPlaceObject();
        	
        	if (attributeObj.fieldType == 'place.name')
        		textVal = placeObj.name;
    		if (attributeObj.fieldType == 'place.companyName')
        		textVal = placeObj.companyName;
    		if (attributeObj.fieldType == 'place.companyRegistrationNo')
        		textVal = placeObj.companyRegistrationNo;
    		if (attributeObj.fieldType == 'place.address')
        		textVal = placeObj.address;
    		if (attributeObj.fieldType == 'place.phone')
        		textVal = placeObj.phone;
    		if (attributeObj.fieldType == 'place.mobile')
        		textVal = placeObj.mobile;
    		if (attributeObj.fieldType == 'place.website')
        		textVal = placeObj.website;
    		if (attributeObj.fieldType == 'place.email')
        		textVal = placeObj.email;
    		if (attributeObj.fieldType == 'place.gstNumber')
        		textVal = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GST_TAX_INVOICE_NUMBER).propValue;

            var group = new Konva.Group({
                draggable: true
            });
            
	        var text = new Konva.Text({
	            x: attributeObj.x1,
	            y: attributeObj.y1,
	            text: textVal,
	            fontSize: attributeObj.fontSize,
	            fontFamily: attributeObj.fontFamily,
	            fill: attributeObj.fill,
	            width: attributeObj.width,
	            padding: attributeObj.padding,
	            align: attributeObj.align,
	            draggable: true
	        });
	               
	        var rect = new Konva.Rect({
                x: Math.abs(attributeObj.x1),
                y: Math.abs(attributeObj.y1),
                width: Math.abs(attributeObj.width),
                height: Math.abs(text.getHeight()),
                stroke: '#555',
                strokeWidth: Math.abs(1)
            });
	        
            // Add shape to group
            //group.add(text);
            //group.add(rect);
	        
	        // add the shape to the layer
	        layerObj.add(text);
	        
	        postDrawingFn(componentObj, text);
        }
    }
    
    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_CUSTOMER_FIELD) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);

        if (x1 == NaN || y1 == NaN)
            return false;

    	var textVal = '$' + attributeObj.fieldType;
    	var placeObj = tycheesCommon_getCurrentPlaceObject();
    	
        var group = new Konva.Group({
            draggable: true
        });
        
        var text = new Konva.Text({
            x: attributeObj.x1,
            y: attributeObj.y1,
            text: textVal,
            fontSize: attributeObj.fontSize,
            fontFamily: attributeObj.fontFamily,
            fill: attributeObj.fill,
            width: attributeObj.width,
            padding: attributeObj.padding,
            align: attributeObj.align,
            draggable: true
        });
               
        var rect = new Konva.Rect({
            x: Math.abs(attributeObj.x1),
            y: Math.abs(attributeObj.y1),
            width: Math.abs(attributeObj.width),
            height: Math.abs(text.getHeight()),
            stroke: '#555',
            strokeWidth: Math.abs(1)
        });
        
        // Add shape to group
        //group.add(text);
        //group.add(rect);
        
        // add the shape to the layer
        layerObj.add(text);
        
        postDrawingFn(componentObj, text);
    }
    

    // Add component into Canvas
    if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BILLING_FIELD) {
    	var attributeObj = JSON.parse(componentObj.attributes);    	
        var x1 = Number(attributeObj.x1);
        var y1 = Number(attributeObj.y1);

        if (x1 == NaN || y1 == NaN)
            return false;

    	var textVal = '$' + attributeObj.fieldType;
    	var placeObj = tycheesCommon_getCurrentPlaceObject();
    	
    	if (attributeObj.showContainer) {
	        var group = new Konva.Group({
	            draggable: true
	        });
	        
	        var text = new Konva.Text({
	            x: attributeObj.x1,
	            y: attributeObj.y1,
	            text: textVal,
	            fontSize: attributeObj.fontSize,
	            fontFamily: attributeObj.fontFamily,
	            fill: attributeObj.fill,
	            width: attributeObj.width,
	            padding: attributeObj.padding,
	            align: attributeObj.align,
	            draggable: true
	        });
	               
	        var rect = new Konva.Rect({
	            x: Math.abs(attributeObj.x1),
	            y: Math.abs(attributeObj.y1),
	            width: Math.abs(attributeObj.width),
	            height: Math.abs(text.getHeight()),
	            stroke: '#aaa',
	            strokeWidth: Math.abs(1),
	            dash: [5, 5]
	        });
	        
	        // Add shape to group
	        group.add(text);
	        group.add(rect);
	        
	        // add the shape to the layer
	        layerObj.add(group);
	        
	        postDrawingFn(componentObj, group);
    	} else {	        
	        var text = new Konva.Text({
	            x: attributeObj.x1,
	            y: attributeObj.y1,
	            text: textVal,
	            fontSize: attributeObj.fontSize,
	            fontFamily: attributeObj.fontFamily,
	            fill: attributeObj.fill,
	            width: attributeObj.width,
	            padding: attributeObj.padding,
	            align: attributeObj.align,
	            draggable: true
	        });
	        
	        // add the shape to the layer
	        layerObj.add(text);
	        
	        postDrawingFn(componentObj, text);
    	}
    }
} // .end of commonCanvas_documents_drawKonva

