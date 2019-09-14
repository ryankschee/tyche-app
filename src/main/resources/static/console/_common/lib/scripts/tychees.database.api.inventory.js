
/**
 * Ajax call to retrieve category object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getCategoryById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getCategoryById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCategoryById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getCategoryById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getCategoryById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getCategoryById

/**
 * Ajax call to retrieve category object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_listCategoryByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_listCategoryByPlace', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCategoriesByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_listCategoryByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_listCategoryByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_listCategoryByPlace

/**
 * Ajax call to retrieve category object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_listCategoryByParentCategory(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_listCategoryByParentCategory', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCategoriesByParentCategory',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_listCategoryByParentCategory', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_listCategoryByParentCategory', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_listCategoryByParentCategory

/**
 * Ajax call to retrieve item object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getItemById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getItemById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getItemById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getItemById

/**
 * Ajax call to retrieve item object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getItemCountByCategory(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getItemCountByCategory', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getItemCountByCategory',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemCountByCategory', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, 0, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemCountByCategory', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getItemCountByCategory

/**
 * Ajax call to retrieve list of dependent item object in not full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_listComponentItemsByItemId(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_listComponentItemsByItemId', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/listComponentItemsByItem',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_listComponentItemsByItemId', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_listComponentItemsByItemId', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_listComponentItemsByItemId

/**
 * Ajax call to retrieve list of dependent item object in not full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getDependentItemsByItemId(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getDependentItemsByItemId', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getDependentItemsByItem',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getDependentItemsByItemId', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getDependentItemsByItemId', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getDependentItemsByItemId

/**
 * Ajax call to retrieve list of item object in billing line object. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_listItemsByBillingLine(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_listItemsByBillingLine', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/listItemsByBillingLine',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_listItemsByBillingLine', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_listItemsByBillingLine', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_listItemsByBillingLine

/**
 * Ajax call to retrieve list of item object in billing line object. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_listItemsByBillingBucketLine(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_listItemsByBillingBucketLine', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/listItemsByBillingBucketLine',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_listItemsByBillingBucketLine', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_listItemsByBillingBucketLine', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_listItemsByBillingBucketLine

/**
 * Get list of items, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getItemsByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getItemsByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getItemsByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemsByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemsByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getItemsByPlace

/**
 * Get list of items, by given category ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getItemsByCategory(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getItemsByCategory', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getItemsByCategory',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemsByCategory', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getItemsByCategory', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getItemsByCategory

/**
 * Batch update items.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchUpdateItems(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchUpdateItems', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchUpdateItems',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateItems', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateItems', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchUpdateItems

/**
 * Batch download items.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchDownloadItems(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchDownloadItems', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchDownloadItems',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadItems', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadItems', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchDownloadItems

/**
 * Increase item
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_increaseItem(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_increaseItem', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/increaseItem',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_increaseItem', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_increaseItem', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_increaseItem

/**
 * Decrease item
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_decreaseItem(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_decreaseItem', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/decreaseItem',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_decreaseItem', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_decreaseItem', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_decreaseItem

