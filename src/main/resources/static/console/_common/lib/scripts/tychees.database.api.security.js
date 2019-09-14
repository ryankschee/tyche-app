
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
 * Get list of users, by given place ID
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_logout(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_logout', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/logout',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_logout', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_logout', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_logout

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
 * Validate place registration.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_validatePlaceRegistration(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_validatePlaceRegistration', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/validatePlaceRegistration',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_validatePlaceRegistration', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_validatePlaceRegistration', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_validatePlaceRegistration

/**
 * Register place account.
 * 
 * @param {JSON} requestBody - Request body in JSON format.
 * @param {String} postHandlerFn - Name of callback function.
 * @param {String} params - parameter for postHandlerFn
 */
function tycheesdb_api_registerNewPlace(requestBody, postHandlerFn, params) {
	var timeStart = tycheesdb_api_logStart('tycheesdb_api_registerNewPlace', requestBody);

	// Call Ajax to get items, with given category ID
	$.ajax({
		type: 'post',
		contentType: 'application/json',
		url: tycheesCommon_getRemoteServerURL() + '/console/registerPlace',
		data: JSON.stringify(tycheesdb_api_prepareRequestBody(requestBody)),
		error: function(xhr, status, error) {
			tycheesdb_api_logEnd('tycheesdb_api_registerNewPlace', error, status, xhr, timeStart, new Date());
			postHandlerFn(false, null, params);
		},
		dataType: 'json',
		timeout: 300000,
		success: function(data, status, xhr) {
			tycheesdb_api_logEnd('tycheesdb_api_registerNewPlace', data, status, xhr, timeStart, new Date());
			tycheesCommon_validateSession(data.status);
			postHandlerFn(true, data, params);
		}
	});
} // .end of tycheesdb_api_registerNewPlace

