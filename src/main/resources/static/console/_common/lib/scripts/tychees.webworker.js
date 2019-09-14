/**
 * Start WebWorker: run timer thread to notify syncDatabase 
 * in periodic mode.
 */
function tycheesWebWorker_start() {
    if (typeof(Worker) !== 'undefined') {
        if (typeof(webWorker_autoSyncTimer) == 'undefined') {
            tycheesLogger_logDebug('STARTED.', 'tychees_common_startWebWorker_autoSyncTimer');
            webWorker_autoSyncTimer = new Worker(tycheesCommon_getConsoleBox() + '/_webworker/workers/webworker_autoSyncTimer.js');
        }

        if (webWorker_autoSyncTimer == null) {
            tycheesLogger_logError('No WebWorker support. Auto Sync Failed.', 'tychees_common_startWebWorker_autoSyncTimer');
        } else {
	        webWorker_autoSyncTimer.onmessage = function(event) {
	        	tycheesLogger_logDebug('Trigger Ajax Call...[timeout=' + event.data + ']', 'tychees_common_startWebWorker_autoSyncTimer');
	
	            var requestBody = {
	                'appName': APP_NAME_ALL,
	                'userId': tycheesCommon_getCurrentUserId()
	            };
	            var params = new Object();
	            tycheesdb_api_getPlaceNotificationsByUser(requestBody, tycheesWebWorker_getNotifications_postHandler, params);
	        };
        }
    }
    else {
        tycheesLogger_logError('No WebWorker support. Auto Sync Failed.', 'tychees_common_startWebWorker_autoSyncTimer');
    }
} // .end of tycheesWebWorker_start

/**
 * Stop WebWorker: timer thread.
 */
function tycheesWebWorker_stop() {
    if (webWorker_autoSyncTimer == null)
        return false;

    webWorker_autoSyncTimer.terminate();
    webWorker_autoSyncTimer = null;

    tycheesLogger_logDebug('ENDED.', 'tychees_common_startWebWorker_autoSyncTimer');
} // .end of tycheesWebWorker_stop

function tycheesWebWorker_getNotifications_postHandler(success, responseObj, params) {
    if (!success)
        return false;

    headerMain_addNotifications(responseObj.notificationList, 'replace');

} // .end of tycheesWebWorker_getNotifications_postHandler
