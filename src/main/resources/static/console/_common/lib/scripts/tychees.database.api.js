/**
 * Logger before ajax call.
 * 
 * @param {string} fnName - Function Name
 * @param {Object} requestBody - Request body
 * @returns {Date} log start date time.
 */
function tycheesdb_api_logStart(fnName, requestBody) {
	var output =
		'Request Body: ' + JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)) + ', ' +
		'Request Size: ' + Math.round(JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)).length / 8 / 1000 * 100) / 100 + ' KB';

	tycheesLogger_logDebug(output, fnName);

	return new Date();
} // .end of tycheesdb_api_logStart

/**
 * Logger for ajax end.
 * 
 * @param {string} fnName - Function Name
 * @param {Object} data - response object
 * @param {string} status - success or failure
 * @param {Object} xhr - XMLHttpRequest
 */
function tycheesdb_api_logEnd(fnName, data, status, xhr, timeStart, timeEnd) {

	if (status == 'success') {
		var serverProcessTime = '';
		if (data.elapsedTimeInMillis <= 1000)
			serverProcessTime = data.elapsedTimeInMillis + ' ms';
		else
			serverProcessTime = data.elapsedTimeInMillis / 1000 + ' s';

		var totalProcessTime = timeEnd.getTime() - timeStart.getTime();
		if (totalProcessTime <= 1000)
			totalProcessTime = totalProcessTime + ' ms';
		else
			totalProcessTime = totalProcessTime / 1000 + ' s';

		var output =
			'Status: ' + status.toUpperCase() + ' ' + xhr.status + ', ' +
			'Process Time (Server): ' + serverProcessTime + ', ' +
			'Process Time (Total): ' + totalProcessTime + ', ' +
			'Data Size :' + Math.round(JSON.stringify(data).length / 8 / 1000 * 100) / 100 + ' KB, ' +
			'XHR Size :' + Math.round(JSON.stringify(xhr).length / 8 / 1000 * 100) / 100 + ' KB';

		tycheesLogger_logDebug(output, fnName);
	}
	else {
		var totalProcessTime = timeEnd.getTime() - timeStart.getTime();
		if (totalProcessTime <= 1000)
			totalProcessTime = totalProcessTime + ' ms';
		else
			totalProcessTime = totalProcessTime / 1000 + ' s';

		var output =
			'Status: ' + status.toUpperCase() + ' ' + xhr.status + ', ' +
			'Error Code: ' + data.code + ' (' + data.name + '), ' +
			'Error Message: ' + data.message + ', ' +
			'Process Time (Total): ' + totalProcessTime + ', ' +
			'XHR Size :' + Math.round(JSON.stringify(xhr).length / 8 / 1000 * 100) / 100 + ' KB';
		
		tycheesLogger_logDebug(output, fnName);
	}
} // .end of tycheesdb_api_logEnd

function tycheesdb_api_prepareRequestBody(requestBody) {
	if (requestBody == null)
		requestBody = {};
	
	requestBody.sessionId = tycheesCommon_getCurrentSessionId();
	requestBody.lastSyncedTime = tycheesCommon_getLastSyncedTime();
	
	if ($.trim(requestBody.placeId)=='')
		requestBody.placeId = tycheesCommon_getCurrentPlaceId();
	
	return requestBody;
} // .end of tycheesdb_api_prepareRequestBody

//------------------------------------------------------------------------------

/**
 * Common Search
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_commonSearch(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_commonSearch', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/commonSearch',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_commonSearch', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_commonSearch', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_commonSearch

/**
 * Init Console
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_initConsole(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_initConsole', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/initConsole',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_initConsole', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_initConsole', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_initConsole

/**
 * Sync Console
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_syncConsole(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_syncConsole', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/syncConsole',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_syncConsole', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_syncConsole', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);

			params.syncConsole = true;
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_syncConsole

/**
 * Sync Session - just update session.
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_syncSession(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_syncSession', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/syncSession',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_syncSession', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_syncSession', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);

			params.syncConsole = true;
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_syncSession

/**
 * Ajax call to retrieve item object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getBatchRequestById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getBatchRequestById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getBatchRequestById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getBatchRequestById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, [], params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getBatchRequestById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getBatchRequestById

/**
 * Ajax call to retrieve opportunity object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getOpportunityById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getOpportunityById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getOpportunityById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getOpportunityById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getOpportunityById', error, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getOpportunityById

/**
 * Get list of opportunities, by given customer ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getOpportunitiesByCustomer(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getOpportunitiesByCustomer', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getOpportunitiesByCustomer',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getOpportunitiesByCustomer', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getOpportunitiesByCustomer', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getOpportunitiesByCustomer

/**
 * Get list of opportunities, by given employee ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getOpportunitiesByEmployee(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getOpportunitiesByEmployee', requestBody);

	// Call Ajax to get billings, with given customer
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getOpportunitiesByEmployee',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getOpportunitiesByEmployee', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getOpportunitiesByEmployee', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getOpportunitiesByEmployee

