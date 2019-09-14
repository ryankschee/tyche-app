
/******************************************************************************* 
 * General
 ******************************************************************************/

function tycheesCommon_onModulePostInit()
{
	if (localStorage.getItem(LOCAL_STORAGE_KEY_RESET_PASSWORD)=='true') {
		localStorage.setItem(LOCAL_STORAGE_KEY_RESET_PASSWORD, false);
		mw_resetPassword_show(true);
	}
	if (localStorage.getItem(LOCAL_STORAGE_KEY_LOGOUT)=='true') {
		localStorage.setItem(LOCAL_STORAGE_KEY_LOGOUT, false);
		tycheesCommon_logout(true);
	}
} // .end of tycheesCommon_onModulePostInit

/******************************************************************************* 
 * Unique ID
 ******************************************************************************/

/**
 * Generate Universally Unique Identifier (UUID).
 * 
 * @returns {string} UUID
 */
function tycheesCommon_generateUUID() {
	var d = new Date().getTime();
	if (window.performance && typeof window.performance.now === "function") {
		d += performance.now(); //use high-precision timer if available
	}
	var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		var r = (d + Math.random() * 16) % 16 | 0;
		d = Math.floor(d / 16);
		return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
	});
	return uuid;
} // .end of tycheesCommon_generateUUID

/**
 * Random version 4. Refer RFC4122
 * 
 * @returns {string} random number
 */
function tycheesCommon_randomVersion4() {
	return Math.floor((1 + Math.random()) * 0x10000)
		.toString(16)
		.substring(1);
} // .end of tycheesCommon_randomVersion4

/**
 * Generate unique ID.
 * 
 * @returns {string} generate Unique ID
 */
function tycheesCommon_getUniqueId() {
	return new Date().getTime() + '-' +
		   tycheesCommon_randomVersion4() + '-' +
		   tycheesCommon_randomVersion4() + '-' +
		   tycheesCommon_randomVersion4() + '-' +
		   tycheesCommon_randomVersion4() + '-' +
		   tycheesCommon_randomVersion4();
} // .end of tycheesCommon_getUniqueId

/**
 * Clone JS object thoroughly.
 * 
 * @param {Object} obj - JS Object to be cloned.
 */
function tycheesCommon_cloneObject(obj) {
	var copy;

	// Handle the 3 simple types, and null or null
	if (null == obj || "object" != typeof obj) return obj;

	// Handle Date
	if (obj instanceof Date) {
		copy = new Date();
		copy.setTime(obj.getTime());
		return copy;
	}

	// Handle Array
	if (obj instanceof Array) {
		copy = [];
		for (var i = 0, len = obj.length; i < len; i++) {
			copy[i] = tycheesCommon_cloneObject(obj[i]);
		}
		return copy;
	}

	// Handle Object
	if (obj instanceof Object) {
		copy = {};
		for (var attr in obj) {
			if (obj.hasOwnProperty(attr)) copy[attr] = tycheesCommon_cloneObject(obj[attr]);
		}
		return copy;
	}

	throw new Error("Unable to copy obj! Its type isn't supported.");
} // .end of tycheesCommon_cloneObject

/******************************************************************************* 
 * Pages control and processing
 ******************************************************************************/

function tycheesCommon_lockScreen() {
	// Set lockscreen flag
	localStorage.setItem(LOCAL_STORAGE_LOCKSCREEN_MODE, true);
	// Re-direct to lock screen page.
	location.href = tycheesCommon_getConsoleBox() + '/landing/lockscreen.jsp';
} // .end of tycheesCommon_lockScreen

function tycheesCommon_checkLockScreen() {
	// Get lockscreen flag
	if (localStorage.getItem(LOCAL_STORAGE_LOCKSCREEN_MODE)) {
		// Re-direct to lock screen page.
		location.href = tycheesCommon_getConsoleBox() + '/landing/lockscreen.jsp';
	}
} // .end of tycheesCommon_lockScreen

function tycheesCommon_logout(silent) {
	
	if (silent == null)
		silent = false;
	
	if (silent) {
		tycheesCommon_processLogout();
	} else {
		swal({
			title: "Are you sure?",
			text: "You will not be able to access some features!",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "Yes, logout now!",
			closeOnConfirm: true
		}, function(confirm) {

			if (confirm) {
				tycheesCommon_processLogout();
			}
		});
	}
} // .end of tycheesCommon_logout

function tycheesCommon_processLogout()
{
	// Hide Screen
	$('#wrapper').hide();

	var sessionId = tycheesCommon_getCurrentSessionId();

	tycheesOverlay_startLongProgress("Log out now... please wait :)");

	tycheesdb_api_logout(new Object(), tycheesCommon_logoutPostHandler, new Object());
} // .end of tycheesCommon_processLogout

function tycheesCommon_logoutPostHandler(success, responseObj, params) {
	if (!success) {
		tycheesOverlay_startLongProgress("Log out ajax error...");
		tycheesLogger_logError("Error in Ajax Call", "tycheesCommon_logoutPostHandler");
		
		$('#wrapper').show();
		tycheesdb_clearLocalCachedData();		
		tycheesOverlay_stopLongProgress();
		location.href = location.origin + tycheesCommon_getConsoleBox() + "/landing/login.jsp";
	}
	
	// Show Message
	tycheesOverlay_startLongProgress('Logout Success...');
	
	// Stop WebWorker
	tycheesWebWorker_stop();
	
	var statusObj = responseObj.status;
	var elapsedTime = responseObj.elapsedTimeInMillis;
	var rememberMeFlag = responseObj.rememberMe;
	var sessionObj = responseObj.currentSessionObj;
	var userObj = responseObj.currentUserObj;
	var placeList = responseObj.placeList;

	// SUCCESS
	if (statusObj.code == 0) {
		// Logout from Google
		if (UserConstants != null &&
			tycheesCommon_getCurrentSsoProvider() == UserConstants.SSO_PROVIDER_GOOGLE) {
			var auth2 = gapi.auth2.getAuthInstance();
			auth2.signOut().then(function() {
				tycheesLogger_logInfo("User signed out from Google Authentication.", "tycheesCommon_logoutPostHandler");
			});
		}

		// Clear IndexedDB, LocalStorage
		tycheesdb_clearLocalCachedData();

		tycheesOverlay_stopLongProgress();
		location.href = location.origin + tycheesCommon_getConsoleBox() + "/landing/login.jsp";
	}
	// EXCEPTION
	else {
		tycheesLogger_logError("Invalid logout status code.", "tycheesCommon_logoutPostHandler");
		// Show Screen
		$('#wrapper').show();
		// Clear IndexedDB, LocalStorage
		tycheesdb_clearLocalCachedData();		
		tycheesOverlay_stopLongProgress();
		location.href = location.origin + tycheesCommon_getConsoleBox() + "/landing/login.jsp";
	}
} // .end of tycheesCommon_logoutPostHandler

/**
 * Check if session value; if no, then logout immediately.
 * 
 * @param {Object} sessionStatusObj - Session object
 */
function tycheesCommon_validateSession(sessionStatusObj) {
	if (sessionStatusObj.code == 4 || sessionStatusObj.name == 'INVALID_SESSION') {
		// logout immediately
		tycheesdb_clearLocalCachedData();
		location.href = location.origin + tycheesCommon_getConsoleBox() + "/landing/login.jsp";
	}
} // .end of tycheesCommon_logoutSilently

/**
 * Validate console session.
 * 
 * @returns {Boolean} true if session valid; otherwise false.
 */
function tycheesCommon_validateConsoleSession() {
	var sessionId = tycheesCommon_getCurrentSessionId();
	if (sessionId == null) {
		location.href = tycheesCommon_getConsoleBox() + '/landing/login.jsp';
		return false;
	}
	return true;
} // .end of tycheesCommon_validateConsoleSession

/**
 * Simulate Thread sleep.
 * 
 * @param {Number} milliseconds - Sleep time in milliseconds
 */
function tycheesCommon_sleep(milliseconds) {
	var start = new Date().getTime();
	for (var i = 0; i < 1e7; i++) {
		if ((new Date().getTime() - start) > milliseconds) {
			break;
		}
	}
} // .end of tycheesCommon_sleep

function tycheesCommon_getModulePath(moduleId) {
	var modulePath;
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	$.each(placeObj.moduleList, function(i, moduleObj) {
		if (moduleId == moduleObj.moduleId) {

			modulePath = moduleObj.moduleLayoutPath;
		}
	});

	return modulePath;
} // .end of tycheesCommon_getModulePath

/**
 * On Switch Page, record last accessed page.
 */
function tycheesCommon_gotoModule(moduleId) {
	var modulePath = tycheesCommon_getModulePath(moduleId);
	// Set path to localstorage
	localStorage.setItem(LOCAL_STORAGE_LAST_ACCESSED_PAGE, modulePath);
	// Redirect to path
	location.href = modulePath;
} // .end of tycheesCommon_gotoModule

function tycheesCommon_getCurrentModule() {
	
	var pathname = window.location.pathname;  // Returns path only (e.g. /console/landing/login.jsp)
	var url = window.location.href;           // Returns full URL (e.g. https://console.tychees.com/console/landing/login.jsp)
	
	if (pathname.indexOf('/dashboard/') >= 0)
		return ModuleConstants.MODULE_DASHBOARD;
	if (pathname.indexOf('/calendar/') >= 0)
		return ModuleConstants.MODULE_CALENDAR;
	if (pathname.indexOf('/billing/') >= 0)
		return ModuleConstants.MODULE_BILLING;
	if (pathname.indexOf('/inventory/') >= 0)
		return ModuleConstants.MODULE_INVENTORY;
	if (pathname.indexOf('/relation/') >= 0)
		return ModuleConstants.MODULE_RELATION;
	if (pathname.indexOf('/reports/') >= 0)
		return ModuleConstants.MODULE_REPORTS;
	if (pathname.indexOf('/settings/') >= 0)
		return ModuleConstants.MODULE_SETTINGS;
	
	return null;
} // .end of tycheesCommon_getCurrentModule

/**
 * Response after user select place from header menu. 
 * 
 * @param {String} newPlaceId - Place ID
 */
function tycheesCommon_switchPlace(newPlaceId) {
	var requestBody = new Object();
	requestBody.placeId = newPlaceId;
	
	var params = new Object();
	params.newPlaceId = newPlaceId;
	
	tycheesdb_api_getPlaceById(requestBody, tycheesCommon_switchPlace_postHandler, params);
} // .end of tycheesCommon_switchPlace

function tycheesCommon_switchPlace_postHandler(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Call failure.', 'tycheesCommon_switchPlace_postHandler');
		return false;
	}
	
	// Remove place object
	Cached_clearPlaceList();
	// Add place object into cache
	Cached_updatePlace(responseObj.placeObj);
	
	// Set new placeId into cookies
	localStorage.setItem(LOCAL_STORAGE_CURRENT_PLACE_ID, responseObj.placeObj.id);
	localStorage.setItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID, responseObj.placeObj.id);

	// Go to current module
	var currentModule = tycheesCommon_getCurrentModule();
	if (currentModule != null)
		tycheesCommon_gotoModule(currentModule);
} // .end of tycheesCommon_switchPlace_postHandler

/**
 * Show Common Search modal window.
 */
function tycheesCommon_openSearchWindow() {
	sea001_mw000_show();
} // .end of tycheesCommon_openSearchWindow

/**
 * * Only for Console Use.
 * Append currently accessed 'placeId' as querystring at the end of action URL.
 * 
 * @param {String} actionURL - Relative URL.
 */
function tycheesCommon_gotoConsolePage(actionUrl) {
	var currentPlaceId = localStorage.getItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID);

	if (actionUrl.indexOf('placeId=') == -1) {
		if (actionUrl.indexOf('?') == -1)
			location.href = actionUrl + '?placeId=' + currentPlaceId;
		else
			location.href = actionUrl + '&placeId=' + currentPlaceId;
	}
	else {
		location.href = actionUrl;
	}
} // .end of tycheesCommon_gotoConsolePage

/**
 * On page start, set last accessed page.
 */
function tycheesCommon_setPageStart() {
	localStorage.setItem(LOCAL_STORAGE_LAST_ACCESSED_PAGE, window.location.pathname);
} // .end of tycheesCommon_setPageStart

/**
 * Initialize language internationalization.
 * Ref URL: http://i18next.com/
 * 
 * @param {String} path - Path to I18N resources.
 */
function tycheesCommon_initI18N(path) {
	if (path == null)
		path = 'i18n/__lng__.json';
	else
		path = path + 'i18n/__lng__.json';

	// i18n ext
	// initialiase i18n plugin
	$.i18n.init({
		resGetPath: path,
		load: 'unspecific',
		fallbackLng: false,
		lng: 'en'
	}, function(t) {
		//('#page-body').i18n();
		tycheesLogger_logInfo("i18n initialized.", "tycheesCommon_initI18N");
	});

	var defaultLanguage = $.trim(localStorage.getItem(LOCAL_STORAGE_LAST_ACCESSED_LANGUAGE));
	if (defaultLanguage == '')
		defaultLanguage = 'en';

	tycheesCommon_switchLanguage(defaultLanguage);
} // .end of tycheesCommon_initI18N

/**
 * Switch to other language.
 * 
 * @param {String} languageCode - Language Code
 */
function tycheesCommon_switchLanguage(languageCode) {
	tycheesLogger_logInfo("languageCode=" + languageCode, "tycheesCommon_switchLanguage");

	// Set new language code into cookies
	localStorage.setItem(LOCAL_STORAGE_LAST_ACCESSED_LANGUAGE, languageCode);

	i18n.setLng(languageCode, function() {
		$('#page-body').i18n();
	});
} // .end of tycheesCommon_switchLanguage

/**
 * Clean cache from browser.
 */
function tycheesCommon_cleanCache() {
	tycheesdb_clearLocalCachedData();
} // .end of tycheesCommon_cleanCache

/**
 * Return true if current user agent is on Mobile device.
 */
function tycheesCommon_isMobileDevice() {
	return navigator.userAgent.indexOf('Mobile') >= 0;
} // .end of tycheesCommon_isMobileDevice

/**
 * Get TycheCore remote URL
 * 
 * @returns {String} remote server URL.
 */
function tycheesCommon_isProduction() {
	return true;
} // .end of tycheesCommon_isProduction

/**
 * Get TycheCore remote URL
 * 
 * @returns {String} remote server URL.
 */
function tycheesCommon_getRemoteServerURL() {
	if (tycheesCommon_isProduction())
		return 'https://tyche-core-ws-prod.appspot.com';
	else
		return 'https://tyche-core-dev.appspot.com';
} // .end of tycheesCommon_getRemoteServerURL

/**
 * Get TycheCore remote URL
 * 
 * @returns {String} remote server URL.
 */
function tycheesCommon_getConsoleBox() {
	return '/console';
} // .end of tycheesCommon_getRemoteServerURL

/**
 * Getter for last accessed page URL.
 * 
 * @returns {String} last accessed page.
 */
function tycheesCommon_getLastAccessedPage() {
	return localStorage.getItem(LOCAL_STORAGE_LAST_ACCESSED_PAGE);
} // .end of tycheesCommon_getLastAccessedPage

/**
 * Getter for current user object.
 * 
 * @returns {String} User object.
 */
function tycheesCommon_getCurrentUserObject() {
	return Cached_getUserById(tycheesCommon_getCurrentUserId());
} // .end of tycheesCommon_getCurrentUserObject

/**
 * Getter for current user id.
 * 
 * @returns {String} User id.
 */
function tycheesCommon_getCurrentUserId() {
	return localStorage.getItem(LOCAL_STORAGE_CURRENT_USER_ID);
} // .end of tycheesCommon_getCurrentUserId

/**
 * Getter for current user short name.
 * 
 * @returns {String} User short name.
 */
function tycheesCommon_getCurrentUserShortName() {
	var userObj = tycheesCommon_getCurrentUserObject();
	return userObj.firstName;
} // .end of tycheesCommon_getCurrentUserShortName

/**
 * Getter for current user full name.
 * 
 * @returns {String} User full name.
 */
function tycheesCommon_getCurrentUserFullname() {
	var userObj = tycheesCommon_getCurrentUserObject();
	return $.trim(userObj.firstName) + ' ' + $.trim(userObj.lastName);
} // .end of tycheesCommon_getCurrentUserFullname

/**
 * Getter for current user profile URL.
 * 
 * @returns {String} User Profile URL.
 */
function tycheesCommon_getCurrentUserProfileUrl() {
	var userObj = tycheesCommon_getCurrentUserObject();
	return userObj.profileImageUrl;
} // .end of tycheesCommon_getCurrentUserProfileUrl

/**
 * Getter for current place ID.
 * 
 * @returns {String} Place ID.
 */
function tycheesCommon_getCurrentPlaceId() {
	return localStorage.getItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID);
} // .end of tycheesCommon_getCurrentPlaceId

/**
 * Getter for current place ID.
 * 
 * @returns {String} Place ID.
 */
function tycheesCommon_getCurrentPlaceObject() {
	return Cached_getPlaceById(tycheesCommon_getCurrentPlaceId());
} // .end of tycheesCommon_getCurrentPlaceId

/**
 * Getter for current session ID.
 * 
 * @returns {String} Session ID.
 */
function tycheesCommon_getCurrentSessionId() {
	return localStorage.getItem(LOCAL_STORAGE_SESSION_ID);
} // .end of tycheesCommon_getCurrentSessionId

/**
 * Getter for current last synced time in milliseconds.
 * 
 * @returns {String} Time in milliseconds.
 */
function tycheesCommon_getLastSyncedTime() {
	var time = localStorage.getItem(LOCAL_STORAGE_LAST_SYNCED);
	if (time == null)
		return 0;
	else
		return time;
} // .end of tycheesCommon_getLastSyncedTime

/**
 * Getter for SSO Provider.
 * 
 * @returns {String} SSO Provider.
 */
function tycheesCommon_getCurrentSsoProvider() {
	return localStorage.getItem(LOCAL_STORAGE_SSO_PROVIDER);
} // .end of tycheesCommon_getCurrentSsoProvider

/**
 * Called on each app module, before page fully loaded.
 */
function tycheesCommon_loadUI_preloadPage() {
	if (tycheesCommon_getCurrentSessionId() != '' && tycheesCommon_getCurrentPlaceId() == '') {
		location.href = '/pages/user/store-selector.jsp';
	}

	// Set Page Start's settings into browser
	tycheesCommon_setPageStart();

	// File: header_main.jsp
	$("#sidebar-toggler").click();

	// Reposition when a modal is shown
	$('.modal').on('show.bs.modal', tycheesCommon_reposition);
	// Reposition when the window is resized
	$(window).on('resize', function() {
		$('.modal:visible').each(tycheesCommon_reposition);
	});

	tycheesCommon_initCheckBox();
	tycheesCommon_initDatePicker();
	tycheesCommon_initClockPicker();
} // .end of tycheesCommon_loadUI_preloadPage

/**
 * Center modal window, vertically & horizontally. 
 */
function tycheesCommon_reposition() {
	var modal = $(this),
		dialog = modal.find('.modal-dialog');
	modal.css('display', 'block');

	// Dividing by two centers the modal exactly, but dividing by three 
	// or four works better for larger screens.
	dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
} // .end of tycheesCommon_reposition

/**
 * Check access right.
 * 
 * @param {Object} accessPropObj - PlaceAccessBean object.
 * @returns {Boolean} true if function visible; otherwise false.
 */
function tycheesCommon_isFunctionVisible(accessPropObj) {
	if ($.trim(accessPropObj.propValue) == 'No Access')
		return false;
	if ($.trim(accessPropObj.propValue) == 'Readable')
		return true;
	if ($.trim(accessPropObj.propValue) == 'Writable')
		return true;
	return false;
} // .end of tycheesCommon_isFunctionVisible

/**
 * Show place list (under current logon user id) in Modal Window.
 */
function tycheesCommon_openPlaceList() {
	mw_placeSwitcher_show();
} // .end of tycheesCommon_openPlaceList

/**
 * Load info into standard header.
 * 
 * @param {Object} user - User object.
 * @param {String} selectedPlaceId - Place ID
 * @param {Array} placeList - List of place object.
 */
function tycheesCommon_loadUI_header() {
	var userObj = tycheesCommon_getCurrentUserObject();
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	// Show User's Image
	var profileImage = userObj.profileImageUrl;
	if ($.trim(profileImage) == '')
		profileImage = 'http://cdn.photoaffections.com/images/icon-profile.png';

	// Feed data into html elements
	$("#user-name").html(tycheesBean_person_getFullName(userObj));
	$("#user-profileImage").attr('src', profileImage);
	
	// Populate user's designation
	$("#headerMain_placeMenu").empty();
	$.each(placeObj.roleList, function(i, roleObj) {
		if (roleObj.userId == userObj.id) {
			$("#user-position").html(roleObj.designation);
		}
	});
	
	// Show place name
	$('#headerMain_placeName').html(placeObj.name);

	// Show Header
	$("#header-place-menu").show();
	$("#header-lang-menu").show();
	$("#header-lock-screen").show();
	$("#header-logout").show();
	$("#header-task").show();
} // .end of tycheesCommon_loadUI_header

/**
 * Load UI of main Sidebar.
 */
function tycheesCommon_loadUI_sidebar() {
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	var userPlaceRoleObj;
	$.each(placeObj.roleList, function(i, roleObj) {
		if ($.trim(roleObj.userId) == tycheesCommon_getCurrentUserId()) {
			userPlaceRoleObj = roleObj;
		}
	});
	
	var placeAccessObj;
	$.each(placeObj.accessList, function(i, accessObj) {
		if ($.trim(accessObj.roleName) == $.trim(userPlaceRoleObj.role)) {
			placeAccessObj = accessObj;
		}
	});

	// Reset state
	$("#sidebar-dashboard").hide();
	$("#sidebar-calendar").hide();
	$("#sidebar-billing").hide();
	$("#sidebar-inventory").hide();
	$("#sidebar-relation").hide();
	$("#sidebar-reports").hide();
	$("#sidebar-humanResources").hide();
	$("#sidebar-settings").hide();

	var functionDashboardAccessible = false;
	var functionCalendarAccessible = false;
	var functionBillingAccessible = false;
	var functionInventoryAccessible = false;
	var functionRelationAccessible = false;
	var functionReportsAccessible = false;
	var functionHumanResourcesAccessible = false;
	var functionSettingsAccessible = false;

	$.each(placeAccessObj.propertiesList, function(i, accessPropObj) {
		if (accessPropObj.propKey == ModuleConstants.MODULE_DASHBOARD_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionDashboardAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
		if (accessPropObj.propKey == ModuleConstants.MODULE_CALENDAR_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionCalendarAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
		if (accessPropObj.propKey == ModuleConstants.MODULE_BILLING_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionBillingAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
		if (accessPropObj.propKey == ModuleConstants.MODULE_INVENTORY_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionInventoryAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
		if (accessPropObj.propKey == ModuleConstants.MODULE_RELATION_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionRelationAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
		if (accessPropObj.propKey == ModuleConstants.MODULE_REPORTS_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionReportsAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
		if (accessPropObj.propKey == ModuleConstants.MODULE_SETTINGS_PROP_KEY)
			if (accessPropObj.propValue == 'Readable' || accessPropObj.propValue == 'Writable')
				functionSettingsAccessible = tycheesCommon_isFunctionVisible(accessPropObj);
	});
	
	// Get current URL
	var currentUrl = location.href;

	if (currentUrl.indexOf("/dashboard/") != -1)
		$("#sidebar-dashboard").addClass("active");
	if (currentUrl.indexOf("/calendar/") != -1)
		$("#sidebar-calendar").addClass("active");
	if (currentUrl.indexOf("/billing/") != -1)
		$("#sidebar-billing").addClass("active");
	if (currentUrl.indexOf("/inventory/") != -1)
		$("#sidebar-inventory").addClass("active");
	if (currentUrl.indexOf("/relation/") != -1)
		$("#sidebar-relation").addClass("active");
	if (currentUrl.indexOf("/reports/") != -1)
		$("#sidebar-reports").addClass("active");
	if (currentUrl.indexOf("/humanresources/") != -1)
		$("#sidebar-humanResources").addClass("active");
	if (currentUrl.indexOf("/settings/") != -1)
		$("#sidebar-settings").addClass("active");

	// Show whichever enable
	if (functionDashboardAccessible)
		$("#sidebar-dashboard").show();
	if (functionCalendarAccessible)
		$("#sidebar-calendar").show();
	if (functionBillingAccessible)
		$("#sidebar-billing").show();
	if (functionInventoryAccessible)
		$("#sidebar-inventory").show();
	if (functionRelationAccessible)
		$("#sidebar-relation").show();
	if (functionReportsAccessible)
		$("#sidebar-reports").show();
	if (functionHumanResourcesAccessible)
		$("#sidebar-humanResources").show();
	//if (functionSettingsAccessible)
		$("#sidebar-settings").show();

	$("#sidebar-profile").show();
} // .end of tycheesCommon_loadUI_sidebar

// .end of Pages control and processing

/******************************************************************************* 
 * UI Components Initializer
 ******************************************************************************/
/**
 * Init Date Picker.
 */
function tycheesCommon_initDatePicker() {
	$('.date-group .input-group.date').datepicker({
		todayBtn: "linked",
		keyboardNavigation: false,
		forceParse: false,
		calendarWeeks: true,
		autoclose: true
	});
} // .end of tycheesCommon_initDatePicker

/**
 * Init Clock Picker.
 */
function tycheesCommon_initClockPicker() {
	$('.clockpicker').clockpicker();
} // .end of tycheesCommon_initClockPicker

/**
 * Init iCheck.
 */
function tycheesCommon_initCheckBox() {
	$('.i-checks').iCheck({
		checkboxClass: 'icheckbox_square-green',
		radioClass: 'iradio_square-green'
	});
} // .end of tycheesCommon_initCheckBox

/**
 * Get attribute value of JSON object, by given attribute name.
 */
function tycheesCommon_getObjectAttributeValue(objectJson, attributeName) {
	var object = JSON.parse(objectJson);
	return $.trim(object[attributeName]);
} // .end of tycheesCommon_getObjectAttributeValue

/**
* Set attribute value of JSON object, by given attribute name.
*/
function tycheesCommon_setObjectAttributeValue(objectJson, attributeName, attributeValue) {
	var object = JSON.parse(objectJson);
	object[attributeName] = $.trim(attributeValue);
	
	return JSON.stringify(object);
} // .end of tycheesCommon_setObjectAttributeValue

