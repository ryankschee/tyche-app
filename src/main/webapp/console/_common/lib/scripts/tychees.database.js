
const BEAN_NAME_BILLING 				= "BillingBean";
const BEAN_NAME_BILLING_BUCKET 			= "BillingBucketBean";
const BEAN_NAME_CUSTOMER 				= "CustomerBean";
const BEAN_NAME_EMPLOYEE 				= "EmployeeBean";
const BEAN_NAME_DOCUMENT 				= "DocumentBean";
const BEAN_NAME_INVENTORY_CATEGORY 		= "InventoryCategoryBean";
const BEAN_NAME_INVENTORY_ITEM 			= "InventoryItemBean";
const BEAN_NAME_INVENTORY_TRANSACTION 	= "InventoryTransactionBean";
const BEAN_NAME_PLACE 					= "PlaceBean";
const BEAN_NAME_USER 					= "UserBean";

const BEAN_CLASS_NAME_BILLING 				= "com.tychees.core.bean.billing.BillingBean";
const BEAN_CLASS_NAME_BILLING_BUCKET 		= "com.tychees.core.bean.billing.BillingBucketBean";
const BEAN_CLASS_NAME_CUSTOMER 				= "com.tychees.core.bean.customer.CustomerBean";
const BEAN_CLASS_NAME_EMPLOYEE 				= "com.tychees.core.bean.employee.EmployeeBean";
const BEAN_CLASS_NAME_DOCUMENT 				= "com.tychees.core.bean.document.DocumentBean";
const BEAN_CLASS_NAME_INVENTORY_CATEGORY 	= "com.tychees.core.bean.inventory.InventoryCategoryBean";
const BEAN_CLASS_NAME_INVENTORY_ITEM 		= "com.tychees.core.bean.inventory.InventoryItemBean";
const BEAN_CLASS_NAME_INVENTORY_TRANSACTION = "com.tychees.core.bean.inventory.InventoryTransactionBean";
const BEAN_CLASS_NAME_PLACE 				= "com.tychees.core.bean.place.PlaceBean";
const BEAN_CLASS_NAME_USER 					= "com.tychees.core.bean.user.UserBean";

// LocalStorage
const LOCAL_STORAGE_LAST_SYNCED = 'Tychees.Console.LocalDatabaseLastSynced';

// Session States
const LOCAL_STORAGE_SESSION_ID = "sessionId";
const LOCAL_STORAGE_CURRENT_USER_ID = "currentUserId";
const LOCAL_STORAGE_CURRENT_PLACE_ID = "currentPlaceId";
const LOCAL_STORAGE_CURRENT_SESSION_ID = "currentSessionId";
const LOCAL_STORAGE_LAST_ACCESSED_PAGE = "lastAccessedPage";
const LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID = "lastAccessedPlaceId";
const LOCAL_STORAGE_LAST_ACCESSED_LANGUAGE = "lastAccessedLanguage";
const LOCAL_STORAGE_SSO_PROVIDER = "ssoProvider";
const LOCAL_STORAGE_PLACE_ID_LIST = "placeIdList";
const LOCAL_STORAGE_CURRENT_USER_OBJ = "currentUserObj";
const LOCAL_STORAGE_OFFLINE_MODE = "offlineMode";
const LOCAL_STORAGE_LOCKSCREEN_MODE = "lockScreenMode";
const LOCAL_STORAGE_INIT_CONSOLE = "initConsole";
const LOCAL_STORAGE_INIT_POS = 'initPOS';

// Session Action
const LOCAL_STORAGE_KEY_RESET_PASSWORD = 'resetPassword';
const LOCAL_STORAGE_KEY_LOGOUT = 'logout';

// Module Constant
const LOCAL_STORAGE_KEY_APP_CONSTANTS = 'AppConstants';
const LOCAL_STORAGE_KEY_BEAN_CONSTANTS = 'BeanConstants';
const LOCAL_STORAGE_KEY_MODULE_CONSTANTS = 'ModuleConstants';
const LOCAL_STORAGE_KEY_BILLING_CONSTANTS = 'BillingConstants';
const LOCAL_STORAGE_KEY_CUSTOMER_CONSTANTS = 'CustomerConstants';
const LOCAL_STORAGE_KEY_DOCUMENT_CONSTANTS = 'DocumentConstants';
const LOCAL_STORAGE_KEY_INVENTORY_CONSTANTS = 'InventoryConstants';
const LOCAL_STORAGE_KEY_PLACE_CONSTANTS = 'PlaceConstants';
const LOCAL_STORAGE_KEY_SETTINGS_CONSTANTS = 'SettingsConstants';
const LOCAL_STORAGE_KEY_USER_CONSTANTS = 'UserConstants';

// Bean Object Template
const LOCAL_STORAGE_KEY_NEW_BILLING = 'newBilling';
const LOCAL_STORAGE_KEY_NEW_BILLING_LINE = 'newBillingLine';
const LOCAL_STORAGE_KEY_NEW_BILLING_DELIVERY = 'newBillingDelivery';
const LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT = 'newBillingPayment';
const LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT_PROPERTIES = 'newBillingPaymentProperties';
const LOCAL_STORAGE_KEY_NEW_BILLING_PROPERTIES = 'newBillingProperties';
const LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW = 'newBillingWorkflow';
const LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW_EVENT = 'newBillingWorkflowEvent';
const LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET = 'newBillingTable';
const LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET_LINE = 'newBillingTableLine';
const LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR = 'newCommonCalendar';
const LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR_EVENT = 'newCommonCalendarEvent';
const LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE = 'newCommonTemplate';
const LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE_PROPERTIES = 'newCommonTemplateProperties';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER = 'newCustomer';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER_ADDRESS = 'newCustomerAddress';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER_CONTACT = 'newCustomerContact';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER_EMAIL = 'newCustomerEmail';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROPERTIES = 'newCustomerProperties';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE = 'newCustomerProfile';
const LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE_PROPERTIES = 'newCustomerProfileProperties';
const LOCAL_STORAGE_KEY_NEW_EMPLOYEE = 'newEmployee';
const LOCAL_STORAGE_KEY_NEW_EMPLOYEE_ADDRESS = 'newEmployeeAddress';
const LOCAL_STORAGE_KEY_NEW_EMPLOYEE_CONTACT = 'newEmployeeContact';
const LOCAL_STORAGE_KEY_NEW_EMPLOYEE_EMAIL = 'newEmployeeEmail';
const LOCAL_STORAGE_KEY_NEW_EMPLOYEE_PROPERTIES = 'newEmployeeProperties';
const LOCAL_STORAGE_KEY_NEW_EMPLOYEE_JOB = 'newEmployeeJob';
const LOCAL_STORAGE_KEY_NEW_DOCUMENT = 'newDocument';
const LOCAL_STORAGE_KEY_NEW_DOCUMENT_PROPERTIES = 'newDocumentProperties';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM = 'newInventoryItem';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_PROPERTIES = 'newInventoryItemProperties';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_COMPONENT = 'newInventoryItemComponent';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_IMAGE = 'newInventoryItemImage';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_LABEL = 'newInventoryItemLabel';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY = 'newInventoryCategory';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY_PROPERTIES = 'newInventoryCategoryProperties';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION = 'newInventoryTransaction';
const LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION_LINE = 'newInventoryTransactionLine';
const LOCAL_STORAGE_KEY_NEW_PLACE = 'newPlace';
const LOCAL_STORAGE_KEY_NEW_PLACE_ADDRESS = 'newPlaceAddress';
const LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS = 'newPlaceAccess';
const LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS_PROPERTIES = 'newPlaceAccessProperties';
const LOCAL_STORAGE_KEY_NEW_PLACE_CONTACT = 'newPlaceContact';
const LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT = 'newPlaceDocument';
const LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_PROPERTIES = 'newPlaceDocumentProperties';
const LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE = 'newPlaceDocumentTemplate';
const LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE_COMPONENT = 'newPlaceDocumentTemplateComponent';
const LOCAL_STORAGE_KEY_NEW_PLACE_IMAGE = 'newPlaceImage';
const LOCAL_STORAGE_KEY_NEW_PLACE_LABEL = 'newPlaceLabel';
const LOCAL_STORAGE_KEY_NEW_PLACE_OPERATING_HOUR = 'newPlaceOperatingHour';
const LOCAL_STORAGE_KEY_NEW_PLACE_PROPERTIES = 'newPlaceProperties';
const LOCAL_STORAGE_KEY_NEW_PLACE_ROLE = 'newPlaceRole';
const LOCAL_STORAGE_KEY_NEW_PLACE_SETTINGS = 'newPlaceSettings';
const LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW = 'newPlaceWorkflow';
const LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW_EVENT = 'newPlaceWorkflowEvent';
const LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT = 'newPlaceLayout';
const LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT_COMPONENT = 'newPlaceLayoutComponent';
const LOCAL_STORAGE_KEY_NEW_USER = 'newUser';
const LOCAL_STORAGE_KEY_NEW_USER_ACTION = 'newUserAction';
const LOCAL_STORAGE_KEY_NEW_USER_SESSION = 'newUserSession';
const LOCAL_STORAGE_KEY_NEW_USER_PROPERTIES = 'newUserProperties';
const LOCAL_STORAGE_KEY_NEW_USER_ACCESS_RIGHT = 'newUserAccessRight';
const LOCAL_STORAGE_KEY_NEW_USER_ROLE = 'newUserRole';

// Global Variables
const APP_NAME_ALL = "ALL";
const APP_NAME_CALENDAR = "CALENDAR";
const APP_NAME_INVENTORY = "INVENTORY";
const APP_NAME_POS = "POS";
const APP_NAME_DASHBOARD = "DASHBOARD";
const APP_NAME_RELATION = "RELATION";
const APP_NAME_REPORTS = "REPORTS";
const APP_NAME_SETTINGS = "SETTINGS";
const APP_NAME_PLACE = "PLACE";

// Web Workers
var webWorker_autoSyncTimer;

//==============================================================================

/**
 * *** USE with CAUTIONS ***
 * Clearing an object store consists of removing all records from the object store 
 * and removing all records in indexes that reference the object store.
 * 
 */
function tycheesdb_clearLocalCachedData(useSameSession) {

	if (useSameSession == true) {
		localStorage.removeItem(LOCAL_STORAGE_CURRENT_PLACE_ID);
		localStorage.removeItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID);
		localStorage.removeItem(LOCAL_STORAGE_OFFLINE_MODE);
	}
	else {
		// Clear localStorage
		localStorage.removeItem(LOCAL_STORAGE_SESSION_ID);
		localStorage.removeItem(LOCAL_STORAGE_CURRENT_USER_ID);
		localStorage.removeItem(LOCAL_STORAGE_CURRENT_PLACE_ID);
		localStorage.removeItem(LOCAL_STORAGE_CURRENT_SESSION_ID);
		localStorage.removeItem(LOCAL_STORAGE_LAST_ACCESSED_PAGE);
		localStorage.removeItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID);
		localStorage.removeItem(LOCAL_STORAGE_LAST_ACCESSED_LANGUAGE);
		localStorage.removeItem(LOCAL_STORAGE_SSO_PROVIDER);
		localStorage.removeItem(LOCAL_STORAGE_PLACE_ID_LIST);
		localStorage.removeItem(LOCAL_STORAGE_OFFLINE_MODE);
		localStorage.removeItem(LOCAL_STORAGE_INIT_CONSOLE);
		localStorage.removeItem(LOCAL_STORAGE_INIT_POS);
		localStorage.removeItem(LOCAL_STORAGE_LAST_SYNCED);

		localStorage.removeItem(LOCAL_STORAGE_KEY_APP_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_BEAN_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_MODULE_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_BILLING_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_CUSTOMER_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_DOCUMENT_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_INVENTORY_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_PLACE_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_SETTINGS_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_USER_CONSTANTS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_LINE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_DELIVERY);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW_EVENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET_LINE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR_EVENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_ADDRESS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_CONTACT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_EMAIL);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_ADDRESS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_CONTACT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_EMAIL);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_JOB);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_DOCUMENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_DOCUMENT_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_COMPONENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_IMAGE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_LABEL);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION_LINE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_ADDRESS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_CONTACT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE_COMPONENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_IMAGE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_LABEL);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_OPERATING_HOUR);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_ROLE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_SETTINGS);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW_EVENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT_COMPONENT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_USER);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_USER_ACTION);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_USER_SESSION);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_USER_PROPERTIES);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_USER_ACCESS_RIGHT);
		localStorage.removeItem(LOCAL_STORAGE_KEY_NEW_USER_ROLE);
		localStorage.removeItem(LOCAL_STORAGE_KEY_RESET_PASSWORD);
		localStorage.removeItem(LOCAL_STORAGE_KEY_LOGOUT);
	}
} // .end of tycheesdb_clearLocalCachedData

function tycheesdb_initConsole(appName) {
	var initConsole = localStorage.getItem(LOCAL_STORAGE_INIT_CONSOLE);
	if (initConsole) {
		
		tycheesOverlay_startLongProgress('Synchronizing session... 1 of 2');

		var requestBody = new Object();
		requestBody.appName = appName;

		var params = new Object();
		params.appName = appName;
		
		tycheesdb_api_syncSession(requestBody, tycheesdb_api_syncSession_postHandler, params);
	}
	else {
		
		tycheesOverlay_startLongProgress('Initializing session... ');

		var requestBody = {
			'appName': appName,
			'loadBillingList': false,
			'loadCustomerList': false,
			'loadDocumentList': false,
			'loadCategoryList': false,
			'loadItemList': false,
			'loadTransactionList': false,
			'loadPlaceList': true,
			'loadUserList': true
		};

		var params = new Object();
		params.appName = appName;

		tycheesdb_api_initConsole(requestBody, tycheesdb_initConsole_postHandler, params);
	}
} // .end of tycheesdb_initConsole

function tycheesdb_api_syncSession_postHandler(success, responseObj, params)
{
	if (!success)
		return false;

	// Show Message
	tycheesOverlay_startLongProgress('Synchronizing session... 2 of 2');
	
	// Actions that require attention
	localStorage.setItem(LOCAL_STORAGE_KEY_RESET_PASSWORD, responseObj.resetPasswordRequired);
	localStorage.setItem(LOCAL_STORAGE_KEY_LOGOUT, responseObj.logoutRequired);
	localStorage.setItem(LOCAL_STORAGE_LAST_SYNCED, new Date().getTime());
	
	if (responseObj.placeObj != null) {
		Cached_updatePlace(responseObj.placeObj);
		localStorage.setItem(LOCAL_STORAGE_CURRENT_PLACE_ID, responseObj.placeObj.id);
	}
	if (responseObj.userObj != null) {
		Cached_updateUser(responseObj.userObj);
		localStorage.setItem(LOCAL_STORAGE_CURRENT_USER_ID, responseObj.userObj.id);
	}
	
	// Finalize
	Cached_loadAllFromIndexedDB(true);
} // .end of tycheesdb_api_syncSession_postHandler

/**
 * After ajax call, load data into local DB & Caches. 
 */
function tycheesdb_initConsole_postHandler(successFlag, responseObj, params) {
	

	// If status code IS NOT SUCCESS (0)
	// - REQUEST_SUCCESS(0, "Request success."),
	// - UNKNOWN_EXCEPTION(1, "Unknown exception found."),
	// - AUTHENTICATION_FAILURE(2, "Authentication failure."),
	// - LOGOUT_FAILURE(3, "Logout failure."),
	// - INVALID_SESSION(4, "Invalid session found."),
	// - INVALID_USER(5, "Invalid user found.");
	if (successFlag == false || responseObj.status.code != 0) {
		// Set Ajax loading message
		tycheesOverlay_startLongProgress('Error found during initializing session... 2 of 2');
		// Clean browser storage
		tycheesdb_clearLocalCachedData();
		// Goto login page
		location.href = location.origin + tycheesCommon_getConsoleBox() + '/landing/login.jsp';
		// Stop Webworker
		tycheesWebWorker_stop();
	}
	else {
		// Set Message
		tycheesOverlay_startLongProgress('Initializing session... 2 of 2');
		
		// Set States
		localStorage.setItem(LOCAL_STORAGE_CURRENT_SESSION_ID, responseObj.sessionId);
		localStorage.setItem(LOCAL_STORAGE_CURRENT_PLACE_ID, responseObj.placeId);

		// Set flag to localStorage
		localStorage.setItem(LOCAL_STORAGE_INIT_CONSOLE, true);
		localStorage.setItem(LOCAL_STORAGE_LAST_SYNCED, new Date().getTime());

		// Session Actions
		localStorage.setItem(LOCAL_STORAGE_KEY_RESET_PASSWORD, responseObj.resetPasswordRequired);
		localStorage.setItem(LOCAL_STORAGE_KEY_LOGOUT, responseObj.logoutRequired);
		
		// Set new beans into LocalStorage as template bean.
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING, JSON.stringify(responseObj.newBilling));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_LINE, JSON.stringify(responseObj.newBillingLine));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_DELIVERY, JSON.stringify(responseObj.newBillingDelivery));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT, JSON.stringify(responseObj.newBillingPayment));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT_PROPERTIES, JSON.stringify(responseObj.newBillingPaymentProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_PROPERTIES, JSON.stringify(responseObj.newBillingProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW, JSON.stringify(responseObj.newBillingWorkflow));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW_EVENT, JSON.stringify(responseObj.newBillingWorkflowEvent));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET, JSON.stringify(responseObj.newBillingBucket));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET_LINE, JSON.stringify(responseObj.newBillingBucketLine));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR, JSON.stringify(responseObj.newCommonCalendar));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR_EVENT, JSON.stringify(responseObj.newCommonCalendarEvent));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE, JSON.stringify(responseObj.newCommonTemplate));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE_PROPERTIES, JSON.stringify(responseObj.newCommonTemplateProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER, JSON.stringify(responseObj.newCustomer));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_ADDRESS, JSON.stringify(responseObj.newCustomerAddress));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_CONTACT, JSON.stringify(responseObj.newCustomerContact));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_EMAIL, JSON.stringify(responseObj.newCustomerEmail));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROPERTIES, JSON.stringify(responseObj.newCustomerProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE, JSON.stringify(responseObj.newCustomerProfile));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE_PROPERTIES, JSON.stringify(responseObj.newCustomerProfileProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE, JSON.stringify(responseObj.newEmployee));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_ADDRESS, JSON.stringify(responseObj.newEmployeeAddress));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_CONTACT, JSON.stringify(responseObj.newEmployeeContact));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_EMAIL, JSON.stringify(responseObj.newEmployeeEmail));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_PROPERTIES, JSON.stringify(responseObj.newEmployeeProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_JOB, JSON.stringify(responseObj.newEmployeeJob));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_DOCUMENT, JSON.stringify(responseObj.newDocument));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_DOCUMENT_PROPERTIES, JSON.stringify(responseObj.newDocumentProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE, JSON.stringify(responseObj.newPlace));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS, JSON.stringify(responseObj.newPlaceAccess));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS_PROPERTIES, JSON.stringify(responseObj.newPlaceAccessProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_ADDRESS, JSON.stringify(responseObj.newPlaceAddress));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_CONTACT, JSON.stringify(responseObj.newPlaceContact));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT, JSON.stringify(responseObj.newPlaceDocument));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_PROPERTIES, JSON.stringify(responseObj.newPlaceDocumentProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE, JSON.stringify(responseObj.newPlaceDocumentTemplate));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE_COMPONENT, JSON.stringify(responseObj.newPlaceDocumentTemplateComponent));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_IMAGE, JSON.stringify(responseObj.newPlaceImage));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_LABEL, JSON.stringify(responseObj.newPlaceLabel));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_OPERATING_HOUR, JSON.stringify(responseObj.newPlaceOperatingHour));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_PROPERTIES, JSON.stringify(responseObj.newPlaceProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_ROLE, JSON.stringify(responseObj.newPlaceRole));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_SETTINGS, JSON.stringify(responseObj.newPlaceSettings));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW, JSON.stringify(responseObj.newPlaceWorkflow));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW_EVENT, JSON.stringify(responseObj.newPlaceWorkflowEvent));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT, JSON.stringify(responseObj.newPlaceLayout));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT_COMPONENT, JSON.stringify(responseObj.newPlaceLayoutComponent));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM, JSON.stringify(responseObj.newItem));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_PROPERTIES, JSON.stringify(responseObj.newItemProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_COMPONENT, JSON.stringify(responseObj.newItemComponent));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_IMAGE, JSON.stringify(responseObj.newItemImage));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_LABEL, JSON.stringify(responseObj.newItemLabel));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY, JSON.stringify(responseObj.newCategory));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY_PROPERTIES, JSON.stringify(responseObj.newCategoryProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION, JSON.stringify(responseObj.newTransaction));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION_LINE, JSON.stringify(responseObj.newTransactionLine));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_USER, JSON.stringify(responseObj.newUser));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_USER_SESSION, JSON.stringify(responseObj.newUserSession));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_USER_ACTION, JSON.stringify(responseObj.newUserAction));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_USER_PROPERTIES, JSON.stringify(responseObj.newUserProperties));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_USER_ACCESS_RIGHT, JSON.stringify(responseObj.newUserAccessRight));
		localStorage.setItem(LOCAL_STORAGE_KEY_NEW_USER_ROLE, JSON.stringify(responseObj.newUserRole));

		// Set constants beans into LocalStorage.
		localStorage.setItem(LOCAL_STORAGE_KEY_APP_CONSTANTS, JSON.stringify(responseObj.appConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_BEAN_CONSTANTS, JSON.stringify(responseObj.beanConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_MODULE_CONSTANTS, JSON.stringify(responseObj.moduleConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_BILLING_CONSTANTS, JSON.stringify(responseObj.billingConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_CUSTOMER_CONSTANTS, JSON.stringify(responseObj.customerConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_DOCUMENT_CONSTANTS, JSON.stringify(responseObj.documentConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_INVENTORY_CONSTANTS, JSON.stringify(responseObj.inventoryConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_PLACE_CONSTANTS, JSON.stringify(responseObj.placeConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_SETTINGS_CONSTANTS, JSON.stringify(responseObj.settingsConstants));
		localStorage.setItem(LOCAL_STORAGE_KEY_USER_CONSTANTS, JSON.stringify(responseObj.userConstants));
		
		if (responseObj.placeList != null) {
			$.each(responseObj.placeList, function(i, placeObj) {
				Cached_updatePlace(placeObj);
			});
		}
		if (responseObj.userList != null) {
			$.each(responseObj.userList, function(i, userObj) {
				Cached_updateUser(userObj);
				localStorage.setItem(LOCAL_STORAGE_CURRENT_USER_ID, userObj.id);
			});
		}
		
		// Load caches
		Cached_loadAllFromIndexedDB(true);
	}
} // .end of tycheesdb_initConsole_postHandler
