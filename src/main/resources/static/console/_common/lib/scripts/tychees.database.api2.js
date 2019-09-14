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
	requestBody.placeId = tycheesCommon_getCurrentPlaceId();
	requestBody.lastSyncedTime = tycheesCommon_getLastSyncedTime();
	
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
 * Pre Authenticate user email, if success then return client salt.
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_preAuthenticate(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_preAuthenticate', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/prelogin',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_preAuthenticate', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_preAuthenticate', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);

			params.syncConsole = true;
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_preAuthenticate

/**
 * Authenticate user email/password -> success then return current active sesison.
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_authenticate(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_authenticate', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/authenticate',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_authenticate', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_authenticate', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);

			params.syncConsole = true;
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_authenticate

/**
 * Reset Password
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_validateUserEmail(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_validateUserEmail', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/validateUserEmail',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_validateUserEmail', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_validateUserEmail', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);

			params.syncConsole = true;
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_validateUserEmail

/**
 * Reset Password
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_resetUserPassword(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_resetUserPassword', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/resetUserPassword',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		dataType: 'json',
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_resetUserPassword', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_resetUserPassword', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);

			params.syncConsole = true;
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_resetUserPassword

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
 * Ajax call to retrieve customer object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getCustomerById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getCustomerById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCustomerById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, textStatus, errorThrown) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomerById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomerById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getCustomerById

/**
 * Ajax call to retrieve customer object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getCustomerByCustomerNo(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getCustomerByCustomerNo', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCustomerByCustomerNo',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, textStatus, errorThrown) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomerByCustomerNo', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomerByCustomerNo', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getCustomerByCustomerNo

/**
 * Ajax call to retrieve employee object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getEmployeeById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getEmployeeById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getEmployeeById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, textStatus, errorThrown) {
			tycheesdb_api_logEnd('tycheesdb_api_getEmployeeById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getEmployeeById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getEmployeeById

/**
 * Ajax call to retrieve document object in full bean mode. 
 * 
 * @param {String} request body - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getDocumentById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getDocumentById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getDocumentById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getDocumentById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getDocumentById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getDocumentById

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
 * Ajax call to retrieve transaction object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getTransactionById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getTransactionById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getTransactionById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getTransactionById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getTransactionById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getTransactionById

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
 * Ajax call to retrieve place object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getPlaceById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getPlaceById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getPlaceById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getPlaceById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getPlaceById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getPlaceById

/**
 * Ajax call to retrieve transaction object in full bean mode. 
 * 
 * @param {String} requestBody - Request Body in JSON
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getUserById(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getUserById', requestBody);

	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getUserById',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getUserById', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getUserById', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getUserById

//------------------------------------------------------------------------------

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

/**
 * Get list of customers, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getCustomersByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getCustomersByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCustomersByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomersByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomersByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getCustomersByPlace

/**
 * Get list of documents, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getEmployeesByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getEmployeesByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getEmployeesByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getEmployeesByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getEmployeesByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getEmployeesByPlace

/**
 * Get list of documents, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getDocumentsByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getDocumentsByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getDocumentsByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getDocumentsByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getDocumentsByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getDocumentsByPlace

/**
 * Get list of users, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getUsersByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getUsersByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getUsersByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getUsersByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getUsersByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getUsersByPlace

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
 * Get list of transactions, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getTransactionsByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getTransactionsByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getTransactionsByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getTransactionsByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getTransactionsByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getTransactionsByPlace

/**
 * Get usage of followings, by given place ID
 * - Active users
 * - Customers
 * - Inventory Category
 * - Inventory Item
 * - Billing Amount (this month)
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getAccountUsagesByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getAccountUsagesByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getAccountUsagesByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getAccountUsagesByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getAccountUsagesByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getAccountUsagesByPlace

/**
 * Get customers's filter criteria (type, state, area, city), by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getCustomerFilterCriteriaByPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getCustomerFilterCriteriaByPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getCustomerFilterCriteriaByPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomerFilterCriteriaByPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getCustomerFilterCriteriaByPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getCustomerFilterCriteriaByPlace

/**
 * Get list of places, by given session ID (mapped to user ID)
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getPlacesBySession(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getPlacesBySession', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getPlacesBySession',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getPlacesBySession', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getPlacesBySession', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getPlacesBySession

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
 * Get list of notifications, by given user ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getPlaceNotificationsByUser(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getPlaceNotificationsByUser', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getPlaceNotificationsByUser',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getPlaceNotificationsByUser', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getPlaceNotificationsByUser', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getPlaceNotificationsByUser

/**
 * Save or update list of notifications.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_saveOrUpdatePlaceNotifications(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_saveOrUpdatePlaceNotifications', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/saveOrUpdatePlaceNotifications',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_saveOrUpdatePlaceNotifications', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_saveOrUpdatePlaceNotifications', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_saveOrUpdatePlaceNotifications

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
 * Batch update customers.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchUpdateCustomers(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchUpdateCustomers', requestBody);

	// Call Ajax to upload customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchUpdateCustomers',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomers', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomers', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchUpdateCustomers

/**
 * Batch update customer's contacts.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchUpdateCustomerContacts(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchUpdateCustomerContacts', requestBody);

	// Call Ajax to upload customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchUpdateCustomerContacts',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomerContacts', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomerContacts', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchUpdateCustomerContacts

/**
 * Batch update customer's emails.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchUpdateCustomerEmails(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchUpdateCustomerEmails', requestBody);

	// Call Ajax to upload customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchUpdateCustomerEmails',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomerEmails', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomerEmails', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchUpdateCustomerEmails

/**
 * Batch update customer's addresses.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchUpdateCustomerAddresses(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchUpdateCustomerAddresses', requestBody);

	// Call Ajax to upload customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchUpdateCustomerAddresses',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomerAddresses', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchUpdateCustomerAddresses', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchUpdateCustomerAddresses

/**
 * Batch download customers.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchDownloadCustomers(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchDownloadCustomers', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchDownloadCustomers',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomers', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomers', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchDownloadCustomers

/**
 * Batch download customer's contacts.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchDownloadCustomerContacts(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchDownloadCustomerContacts', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchDownloadCustomerContacts',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomerContacts', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomerContacts', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchDownloadCustomerContacts

/**
 * Batch download customer's emails.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchDownloadCustomerEmails(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchDownloadCustomerEmails', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchDownloadCustomerEmails',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomerEmails', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomerEmails', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchDownloadCustomerEmails

/**
 * Batch download customer's addresses.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_batchDownloadCustomerAddresses(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_batchDownloadCustomerAddresses', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/batchDownloadCustomerAddresses',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomerAddresses', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_batchDownloadCustomerAddresses', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_batchDownloadCustomerAddresses

/**
 * Get report, by customer overview.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_getReportByCustomerOverview(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_getReportByCustomerOverview', requestBody);

	// Call Ajax to get customers in batch
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/getReportByCustomerOverview',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_getReportByCustomerOverview', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_getReportByCustomerOverview', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_getReportByCustomerOverview

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

