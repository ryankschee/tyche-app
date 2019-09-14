
/**
 * Ajax call to retrieve billing object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingById

/**
 * Ajax call to retrieve billing object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingByBillingNo(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingByBillingNo', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingByBillingNo',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingByBillingNo', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingByBillingNo', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingByBillingNo

/**
 * Ajax call to retrieve billing object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingByQuotationNo(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingByQuotationNo', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingByQuotationNo',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingByQuotationNo', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingByQuotationNo', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingByQuotationNo

/**
 * Ajax call to retrieve billing object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingBucketById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingBucketById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingBucketById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingBucketById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingBucketById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingBucketById

/**
 * Get list of billings, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingsByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingsByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingsByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingsByPlace

/**
 * Get list of billing buckets, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingBucketsByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingBucketsByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingBucketsByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingBucketsByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingBucketsByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingBucketsByPlace

/**
 * Get list of billings, by given customer ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingsByCustomer(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingsByCustomer', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingsByCustomer',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByCustomer', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByCustomer', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingsByCustomer

/**
 * Get list of billings, by given customer ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingsByEmployee(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingsByEmployee', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingsByEmployee',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByEmployee', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByEmployee', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingsByEmployee

/**
 * Get list of billings, by given bucket ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingsByBucket(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingsByBucket', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingsByBucket',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByBucket', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByBucket', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingsByBucket

/**
 * Get list of billings, by given customer ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingsByTimePeriod(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingsByTimePeriod', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingsByTimePeriod',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByTimePeriod', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByTimePeriod', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingsByTimePeriod

/**
 * Get list of billings, by given customer ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBillingsByPaymentTimePeriod(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBillingsByPaymentTimePeriod', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBillingsByPaymentTimePeriod',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByPaymentTimePeriod', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBillingsByPaymentTimePeriod', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBillingsByPaymentTimePeriod
