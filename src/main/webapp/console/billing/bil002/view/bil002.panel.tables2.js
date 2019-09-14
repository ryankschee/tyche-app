
function bil002_tablePanel_show() {
	$('#bil002_tablePanel').show();
	$('#bil002_cartPanel').hide();
	$('#bil002_paymentPanel').hide();

	bil002_sw001_slideOut();
} // .end of bil002_tablePanel_show

function bil002_tablePanel_canvas_repaint() {
	// Repaint canvas dimension
	var htmlLines = '';
	htmlLines += '<canvas id="bil002_canvas" width="' + global_placeLayoutObj.width + '" height="' + global_placeLayoutObj.height + '" ';
	htmlLines += 'style="border:1px solid #d3d3d3;" onclick="bil002_tablePanel_canvasOnClick(event);">';

	$('#bil002_canvas_parent').empty();
	$('#bil002_canvas_parent').html(htmlLines);

	// Get canvas object
	var canvasObj = document.getElementById("bil002_canvas");
		
	// Repaint components into canvas
	$.each(global_placeLayoutObj.componentList, function(i, componentObj) {
		if ($.trim(componentObj.bucketId) == '') {
			commonCanvas_pos_draw(canvasObj, componentObj);
		} else {
			var callAjax = false;
			if (global_billingBucketObj == null) {
				callAjax = true;
			} else {
				if (componentObj.bucketId == global_billingBucketObj.id) {
					commonCanvas_pos_draw(canvasObj, componentObj, global_billingBucketObj);
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
				params.canvasObj = canvasObj;
				params.componentObj = componentObj;
				
				tycheesdb_api_getBillingBucketById(requestBody, bil002_tablePanel_canvas_repaint_postHanlder, params);
			}
		}
	});
} // .end of bil002_tablePanel_canvas_repaint

function bil002_tablePanel_canvas_repaint_postHanlder(success, responseObj, params) {
	if (success) {
		commonCanvas_pos_draw(params.canvasObj, params.componentObj, responseObj.billingBucketObj);
	}
} // .end of bil002_tablePanel_canvas_repaint_postHanlder

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
