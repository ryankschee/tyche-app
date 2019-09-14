
// Global variables
var Cached_documentList = [];

var AppConstants;
var BeanConstants;
var BillingConstants;
var CustomerConstants;
var DocumentConstants;
var InventoryConstants;
var ModuleConstants;
var PlaceConstants;
var SettingsConstants;
var UserConstants;

//.end of Global Variables

//------------------------------------------------------------------------------

/**
 * 1. Load required record sets from IDB, into local browser cache. 
 * 2. Init app module, if initConsole=true.
 * 
 * @param {boolean} initConsole - true if console first get initialized; 
 *                                otherwise false.
 */
function Cached_loadAllFromIndexedDB(initConsole) {
	if (initConsole == true) {
		tycheesOverlay_startLongProgress('Data loading from IDB...');
		
		// App Constant variable
		AppConstants 		= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_APP_CONSTANTS));
		BeanConstants 		= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_BEAN_CONSTANTS));
		ModuleConstants 	= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_MODULE_CONSTANTS));
		BillingConstants 	= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_BILLING_CONSTANTS));
		CustomerConstants 	= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_CUSTOMER_CONSTANTS));
		DocumentConstants 	= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_DOCUMENT_CONSTANTS));
		InventoryConstants 	= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_INVENTORY_CONSTANTS));
		PlaceConstants 		= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_PLACE_CONSTANTS));
		SettingsConstants 	= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_SETTINGS_CONSTANTS));
		UserConstants 		= JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_USER_CONSTANTS));

		// Start Webworker
		tycheesWebWorker_start();
		// Call module-level init
		module_initApp();
	}
} // .end of Cached_loadAllFromIndexedDB

/**
 * Returns true if bean has been deleted.
 * 
 * @param {BeanSuperClass} beanObj - Object of bean 
 * @returns {boolean} true if bean is deleted; otherwise false.
 */
function Cached_isDeletedBean(beanObj) {
	if (beanObj.deletedOn != null && beanObj.deletedBy != '')
		return true;
	return false;
} // .end of Cached_isDeletedBean

/**
 * Returns true if bean has been changed.
 * 
 * @param {BeanSuperClass} beanObj - Object of bean 
 * @returns {boolean} true if bean has changed; otherwise false.
 */
function Cached_hasPendingChanges(beanObj) {
	if (beanObj.hasChanged == true)
		return true;
	return false;
} // .end of Cached_isDeletedBean

/**
 * Return true if bean is valid, by fulfilling followings:
 * 1. From current placeId
 * 
 * @param {BeanSuperClass} beanObj - Object of bean 
 * @returns {boolean} true if bean is valid; otherwise false.
 */
function Cached_isValidBean(beanObj) {
	if (beanObj == null || beanObj == null)
		return false;

	var validatePlaceId = false;
	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING)
		validatePlaceId = true;
	if (beanObj.beanName == BEAN_CLASS_NAME_CUSTOMER)
		validatePlaceId = true;
	if (beanObj.beanName == BEAN_CLASS_NAME_EMPLOYEE)
		validatePlaceId = true;
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_CATEGORY)
		validatePlaceId = true;
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_ITEM)
		validatePlaceId = true;

	if (validatePlaceId)
		if (beanObj.placeId != tycheesCommon_getCurrentPlaceId())
			return false;
	return true;
} // .end of Cached_isValidBean

/**
 * Filter out deleted bean from list.
 * 
 * @param {List of bean} list - List of bean
 * @returns {boolean} true if list is active; otherwise false.
 */
function Cached_isActiveList(list) {
	var filteredList = [];
	if (list != null) {
		$.each(list, function(i, beanObj) {
			if (Cached_isValidBean(beanObj) == false) {
				// do nothing
			}
			else
			if (Cached_isDeletedBean(beanObj) == true && Cached_hasPendingChanges(beanObj) == false) {
				// do nothing
			}
			else {
				filteredList.push(beanObj);
			}
		});
	}

	return filteredList.length > 0;
} // .end of Cached_isActiveList

/**
 * Filter out deleted bean from list.
 * 
 * @param {List of bean} list - List of bean
 * @returns {List of bean} filtered list, which contains only active bean.
 */
function Cached_getActiveList(list) {
	var filteredList = [];
	if (list != null) {
		$.each(list, function(i, beanObj) {
			if (Cached_isValidBean(beanObj) == false) {
				// do nothing
			}
			else
			if (Cached_isDeletedBean(beanObj) == true && Cached_hasPendingChanges(beanObj) == false) {
				// do nothing
			}
			else {
				filteredList.push(beanObj);
			}
		});
	}
	return filteredList;
} // .end of Cached_getActiveList

/**
 * Delete bean, by:
 * 1. set beanObj.deletedBy = current user id
 * 2. set beanObj.deletedOn = current timestamp in milliseconds
 * 
 * @param {BeanSuperClass} beanObj - Bean object
 * @returns {boolean} true if bean has been set to deleted; otherwise false.
 */
function Cached_deleteBean(beanObj) {
	if (beanObj != null) {
		beanObj.hasChanged = true;
		beanObj.deletedBy = tycheesCommon_getCurrentUserId();
		beanObj.deletedOn = tycheesDateTime_getCurrentTimeInMillis();

		return true;
	}

	return false;
} // .end of Cached_deleteBean

//------------------------------------------------------------------------------
// DocumentList

function Cached_sortDocument(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);

		// Sorting
		beanObj.propertiesList.sort(function(a, b) {
			if (a.propKey < b.propKey) return -1;
			if (a.propKey > b.propKey) return 1;
			return 0;
		});
	}
} // .end of Cached_sortDocument

function Cached_sortDocumentList(beanList) {
	beanList.sort(function(a, b) {
		if (a.docName < b.docName) return -1;
		if (a.docName > b.docName) return 1;
		return 0;
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortDocument(beanObj);
	});
} // .end of Cached_sortDocumentList

function Cached_setDocumentList(list) {
	Cached_documentList = Cached_getActiveList(list);
} // .end of Cached_setDocumentList

function Cached_getDocumentList(sortList) {
	Cached_documentList = Cached_getActiveList(Cached_documentList);
	if (sortList == true)
		Cached_sortDocumentList(Cached_documentList);
	return Cached_documentList;
} // .end of Cached_getDocumentList

function Cached_addDocument(beanObj) {
	if (Cached_getDocumentById(beanObj.id) == null) {
		Cached_documentList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addDocument

function Cached_updateDocument(beanObj) {
	var foundIndex = -1;
	$.each(Cached_getDocumentList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_documentList.splice(foundIndex, 1);
		Cached_documentList.push(beanObj);
		return true;
	}
} // .end of Cached_updateDocument

function Cached_getDocumentById(id) {
	var foundObj;
	$.each(Cached_getDocumentList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getDocumentById

function Cached_getDocumentByCode(code) {
	var foundObj;
	$.each(Cached_getDocumentList(), function(index, beanObj) {
		if (beanObj.docCode == code) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getDocumentByCode

function Cached_deleteDocumentById(id) {
	var foundIndex = -1;
	$.each(Cached_getDocumentList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_documentList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_documentList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deleteDocumentById

