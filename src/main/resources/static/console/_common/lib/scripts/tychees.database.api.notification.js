
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
