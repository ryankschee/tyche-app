
function bil002_tablePanel_show() {
	$('#bil002_tablePanel').show();
	$('#bil002_cartPanel').hide();
	$('#bil002_paymentPanel').hide();

	bil002_sw001_slideOut();
} // .end of bil002_tablePanel_show

function bil002_tablePanel_canvas_repaint() {
	
	// first we need to create a stage
	var stage = new Konva.Stage({
	    container: 'bil002_canvas_parent',   // id of container <div>
	    width: global_placeLayoutObj.width,
	    height: global_placeLayoutObj.height
	});
	// then create layer
	var layer = new Konva.Layer();

	// Repaint components into canvas
	$.each(global_placeLayoutObj.componentList, function(i, componentObj) {
		if ($.trim(componentObj.bucketId) == '') {
			var attributesObj = JSON.parse(componentObj.attributes);
			var shapeObj = commonCanvas_pos_drawKonva(layer, componentObj);
			
			if (tycheesUtil_getBooleanValue(attributesObj.bucketLinked)) {
				shapeObj.on('click', function(e) {
					bil002_tablePanel_shapeOnClick(e, componentObj);
			    });
			}
		} else {
			// Check if there is currently open billingBucket object
			// If yes, check if this billingBucket object belong to current component.
			var callAjax = false;
			if (global_billingBucketObj == null) {
				callAjax = true;
			} else {
				if (componentObj.bucketId == global_billingBucketObj.id) {
					var attributesObj = JSON.parse(componentObj.attributes);
					var shapeObj = commonCanvas_pos_drawKonva(layer, componentObj, global_billingBucketObj);
					
					if (tycheesUtil_getBooleanValue(attributesObj.bucketLinked)) {
						shapeObj.on('click', function(e) {
							bil002_tablePanel_shapeOnClick(e, componentObj);
					    });
					}
				} else {
					callAjax = true;
				}
			}
			
			if (callAjax) {
				// Prepare request body
				var requestBody = {
					'appName': APP_NAME_POS,
					'billingBucketId': componentObj.bucketId,
					'fullBean': false
				};
				
				var params = new Object();
				params.layerObj = layer;
				params.componentObj = componentObj;
				
				tycheesdb_api_getBillingBucketById(requestBody, bil002_tablePanel_canvas_repaint_postHanlder, params);
			}
		}
	});
	
	// add the layer to the stage
	stage.add(layer);
	
	$('#bil002_canvas_parent').children().css({'border':'1px solid #d3d3d3'})
} // .end of bil002_tablePanel_canvas_repaint

function bil002_tablePanel_canvas_repaint_postHanlder(success, responseObj, params) {
	if (success) {
		var attributesObj = JSON.parse(params.componentObj.attributes);
		var shapeObj = commonCanvas_pos_drawKonva(params.layerObj, params.componentObj, responseObj.billingBucketObj);

		if (tycheesUtil_getBooleanValue(attributesObj.bucketLinked)) {
			shapeObj.on('click', function(e) {
				bil002_tablePanel_shapeOnClick(e, params.componentObj);
		    });
		}
		
		params.layerObj.draw();
	}
} // .end of bil002_tablePanel_canvas_repaint_postHanlder

function bil002_tablePanel_shapeOnClick(event, componentObj) {
							
	// Find billing with table 
	bil002_sw001_showSpinner(true);
	bil002_sw001_slideOut();

	var params = new Object();
	params.componentObj = componentObj;

	if (componentObj.bucketId == null) {
		bil002_tablePanel_shapeOnClick_postHandler(true, new Object(), params);
	} else {
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_POS,
			'billingBucketId': componentObj.bucketId,
			'fullBean': true
		};

		tycheesdb_api_getBillingBucketById(requestBody, bil002_tablePanel_shapeOnClick_postHandler, params);
	}
} // .end of bil002_tablePanel_shapeOnClick

function bil002_tablePanel_shapeOnClick_postHandler(success, responseObj, params) {
	if (!success)
		return false;

	global_placeLayoutComponentObj = params.componentObj;
	global_billingBucketObj = responseObj.billingBucketObj;

	bil002_sw001_updateUI();
} // .end of bil002_tablePanel_shapeOnClick_postHandler

function bil002_tablePanel_canvasOnClick(event) {
	var canvasOffset = $('#bil002_canvas').offset();
	var xPosInCanvas = event.pageX - canvasOffset.left;
	var yPosInCanvas = event.pageY - canvasOffset.top;

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var placeLayoutObj;
	$.each(placeObj.layoutList, function(i, layoutObj) {
		if (layoutObj.defaultLayout) {
			placeLayoutObj = layoutObj;
		}
	});

	if (placeLayoutObj == null) {
		tycheesLogger_logError('Invalid layout object found.', 'bil002_tablePanel_canvasOnClick');
	}
	else {
		$.each(placeLayoutObj.componentList, function(i, componentObj) {
			var isCollided = commonCanvas_isComponentCollided(xPosInCanvas, yPosInCanvas, componentObj);

			if (isCollided) {				
				// Find billing with table 
				bil002_sw001_showSpinner(true);
				bil002_sw001_slideOut();

				var params = new Object();
				params.componentObj = componentObj;

				if (componentObj.bucketId == null) {
					bil002_canvasOnClick_postHandler(true, new Object(), params);
				} else {
					// Prepare request body
					var requestBody = {
						'appName': APP_NAME_POS,
						'billingBucketId': componentObj.bucketId,
						'fullBean': true
					};
	
					tycheesdb_api_getBillingBucketById(requestBody, bil002_tablePanel_canvasOnClick_postHandler, params);
				}
			}
			else {
				global_billingBucketObj = null;
			}
		});
	}
} // .end of bil002_tablePanel_canvasOnClick

function bil002_tablePanel_canvasOnClick_postHandler(success, responseObj, params) {
	if (!success)
		return false;

	global_placeLayoutComponentObj = params.componentObj;
	global_billingBucketObj = responseObj.billingBucketObj;

	bil002_sw001_updateUI();
} // .end of bil002_tablePanel_canvasOnClick_postHandler
