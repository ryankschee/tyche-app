
// Global variables
var Cached_billingList = [];
var Cached_billingBucketList = [];
var Cached_customerList = [];
var Cached_documentList = [];
var Cached_categoryList = [];
var Cached_itemList = [];
var Cached_transactionList = [];
var Cached_placeList = [];
var Cached_userList = [];

var Cached_userObj;
var Cached_placeObj;

var AppConstants;
var BeanConstants;
var ModuleConstants;
var BillingConstants;
var CustomerConstants;
var DocumentConstants;
var InventoryConstants;
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
	if (initConsole == true)
		tycheesOverlay_startLongProgress('Data loading from IDB...');

	var documentList = [];
	var placeList = [];
	var userList = [];

	var transaction = tycheesdb_getIDB().transaction(OBJECT_STORE_LIST, "readwrite");
	transaction.oncomplete = function() {
		// Variables Initialization
		Cached_setDocumentList(documentList);
		Cached_setPlaceList(placeList);
		Cached_setUserList(userList);

		Cached_userObj = tycheesCommon_getCurrentUserObject();
		Cached_placeObj = tycheesCommon_getCurrentPlaceObject();

		// App Constant variable
		AppConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_APP_CONSTANTS));
		BeanConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_BEAN_CONSTANTS));
		ModuleConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_MODULE_CONSTANTS));
		BillingConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_BILLING_CONSTANTS));
		CustomerConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_CUSTOMER_CONSTANTS));
		DocumentConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_DOCUMENT_CONSTANTS));
		InventoryConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_INVENTORY_CONSTANTS));
		PlaceConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_PLACE_CONSTANTS));
		SettingsConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_SETTINGS_CONSTANTS));
		UserConstants = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_USER_CONSTANTS));

		// Start Webworker
		tycheesWebWorker_start();

		// Init Module - call app-function
		if (initConsole == true)
			module_initApp();
	};

	// Get object stores
	var objectStore_document = transaction.objectStore(OBJECT_STORE_DOCUMENT);
	var objectStore_place = transaction.objectStore(OBJECT_STORE_PLACE);
	var objectStore_user = transaction.objectStore(OBJECT_STORE_USER);

	// Load all records from ObjectStore, into target list.
	getAllObjects(objectStore_document, documentList);
	getAllObjects(objectStore_place, placeList);
	getAllObjects(objectStore_user, userList);
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
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_TRANSACTION)
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
// BillingBucketList


/**
 * Sort billing bucket object.
 * 
 * @param {BillingBucketBean} beanObj - Billing bucket bean.
 */
function Cached_sortBillingBucket(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.lineList = Cached_getActiveList(beanObj.lineList);

		// Sorting
		beanObj.lineList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
	}
} // .end of Cached_sortBillingBucket

/**
 * Sort list of billing bucket object.
 * 
 * @param {List of BillingBucketBean} beanList - List of Billing Bucket bean.
 */
function Cached_sortBillingBucketList(beanList) {
	if (beanList != null) {
		beanList.sort(function(a, b) {
			if (a.bucketName < b.bucketName) return -1;
			if (a.bucketName > b.bucketName) return 1;
			return 0;
		});

		// Sort child lists
		$.each(beanList, function(i, beanObj) {
			Cached_sortBillingBucket(beanObj);
		});
	}
} // .end of Cached_sortBillingBucketList

/**
 * Set list of billing bucket object into cache.
 * 
 * @param {List of BillingBucketBean} list - List of Billing Bucket bean.
 */
function Cached_setBillingBucketList(list) {
	Cached_billingBucketList = Cached_getActiveList(list);
} // .end of Cached_setBillingBucketList

/**
 * Get list of billing bucket object from cache.
 * 
 * @param {boolean} sortList - if true, then sort given list; otherwise false.
 * @param {List of BillingBucketBean} list - List of Billing Bucket Bean
 * @returns {List of BillingBucketBean} filtered list of Billing Bucket Bean.
 */
function Cached_getBillingBucketList(sortList, pi_list) {
	var list;
	if (list == pi_list)
		list = Cached_getActiveList(Cached_billingBucketList);
	else
		list = Cached_getActiveList(pi_list);

	if (sortList == true)
		Cached_sortBillingBucketList(list);
	return list;
} // .end of Cached_getBillingBucketList

/**
 * Add billing bucket object into cache.
 * 
 * @param {BillingBucketBean} beanObj - Billing Bucket object.
 * @param {List of BillingBucketBean} list - List of Billing Bucket Bean
 * @returns {boolean} true if object has been added successfully; otherwise false.
 */
function Cached_addBillingBucket(beanObj, pi_list) {
	var billingBucketObj;

	if (pi_list != null) {
		billingBucketObj = Cached_getBillingBucketById(beanObj.id, pi_list);
		if (billingBucketObj == null) {
			pi_list.push(beanObj);
			return true;
		}
	}
	else {
		billingBucketObj = Cached_getBillingBucketById(beanObj.id);
		if (billingBucketObj == null) {
			Cached_billingBucketList.push(beanObj);
			return true;
		}
	}

	return false;
} // .end of Cached_addBillingBucket

/**
 * Update billing bucket object.
 * 
 * @param {BillingBucketBean} beanObj - Billing Bucket object.
 * @returns {boolean} true if object has been added successfully; otherwise false.
 */
function Cached_updateBillingBucket(beanObj, pi_list) {

	if (pi_list != null) {
		var foundIndex = -1;
		$.each(pi_list, function(i, obj) {
			if (beanObj.id == obj.id) {
				foundIndex = i;
				return false;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			pi_list.splice(foundIndex, 1);
			pi_list.push(beanObj);
			return true;
		}
	}
	else {
		var foundIndex = -1;
		$.each(Cached_billingBucketList, function(i, obj) {
			if (beanObj.id == obj.id) {
				foundIndex = i;
				return false;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			Cached_billingBucketList.splice(foundIndex, 1);
			Cached_billingBucketList.push(beanObj);
			return true;
		}
	}
} // .end of Cached_updateBillingBucket

/**
 * Get billing bucket object by bucket id.
 * 
 * @param {string} id - Billing Bucket ID
 * @param {List of BillingBucketBean} pi_list - List of BillingBean
 * @returns {BillingBucketBean} Billing bucket object or null.
 */
function Cached_getBillingBucketById(id, pi_list) {
	var list = pi_list;
	if (list == null)
		list = Cached_getBillingBucketList();

	var foundObj;
	$.each(list, function(i, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getBillingBucketById

/**
 * Delete billing bucket object by id.
 * 
 * @param {string} id - Billing Bucket ID
 * @param {List of BillingBucketBean} pi_list - List of BillingBucketBean
 * @returns {boolean} true if billing bucket object has been deleted; otherwise false.
 */
function Cached_deleteBillingBucketById(id, pi_list) {

	if (pi_list != null) {
		var foundIndex = -1;
		$.each(pi_list, function(i, beanObj) {
			if (beanObj.id == id) {
				foundIndex = i;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			pi_list[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
			pi_list[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
			return true;
		}
	}
	else {
		var foundIndex = -1;
		$.each(Cached_billingBucketList, function(i, beanObj) {
			if (beanObj.id == id) {
				foundIndex = i;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			Cached_billingBucketList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
			Cached_billingBucketList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
			return true;
		}
	}
} // .end of Cached_deleteBillingBucketById


//------------------------------------------------------------------------------
// BillingList

/**
 * Sort billing object.
 * 
 * @param {BillingBean} beanObj - Billing bean.
 */
function Cached_sortBilling(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.deliveryList = Cached_getActiveList(beanObj.deliveryList);
		beanObj.lineList = Cached_getActiveList(beanObj.lineList);
		beanObj.paymentList = Cached_getActiveList(beanObj.paymentList);
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);
		beanObj.workflowList = Cached_getActiveList(beanObj.workflowList);
		$.each(beanObj.workflowList, function(i, workflowObj) {
			workflowObj.eventList = Cached_getActiveList(workflowObj.eventList);
		});

		// Sorting
		beanObj.deliveryList.sort(function(a, b) {
			return a.dispatchedOn - b.dispatchedOn;
		});
		beanObj.lineList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		beanObj.paymentList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		beanObj.propertiesList.sort(function(a, b) {
			if (a.propKey < b.propKey) return -1;
			if (a.propKey > b.propKey) return 1;
			return 0;
		});
		beanObj.workflowList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		$.each(beanObj.workflowList, function(i, workflowObj) {
			workflowObj.eventList.sort(function(a, b) {
				return a.seqno - b.seqno;
			});
		});
	}
} // .end of Cached_sortBilling

/**
 * Sort list of billing object.
 * 
 * @param {List of BillingBean} beanList - List of Billing bean.
 */
function Cached_sortBillingList(beanList) {
	if (beanList != null) {
		beanList.sort(function(a, b) {
			if (a.billingNo < b.billingNo) return -1;
			if (a.billingNo > b.billingNo) return 1;
			return 0;
		});

		// Sort child lists
		$.each(beanList, function(i, beanObj) {
			Cached_sortBilling(beanObj);
		});
	}
} // .end of Cached_sortBillingList

/**
 * Set list of billing object into cache.
 * 
 * @param {List of BillingBean} list - List of Billing bean.
 */
function Cached_setBillingList(list) {
	Cached_billingList = Cached_getActiveList(list);
} // .end of Cached_setBillingList

/**
 * Get list of billing object from cache.
 * 
 * @param {boolean} sortList - if true, then sort given list; otherwise false.
 * @param {List of BillingBean} list - List of Billing Bean
 * @returns {List of BillingBean} filtered list of Billing Bean.
 */
function Cached_getBillingList(sortList, pi_list) {
	var list = Cached_getActiveList(pi_list);
	if (list == null)
		list = Cached_getActiveList(Cached_billingList);
	if (sortList == true)
		Cached_sortBillingList(list);
	return list;
} // .end of Cached_getBillingList

/**
 * Add billing object into cache.
 * 
 * @param {BillingBean} beanObj - Billing object.
 * @param {List of BillingBean} list - List of Billing Bean
 * @returns {boolean} true if object has been added successfully; otherwise false.
 */
function Cached_addBilling(beanObj, pi_list) {
	var billingObj;

	if (pi_list != null) {
		billingObj = Cached_getBillingById(beanObj.id, pi_list);
		if (billingObj == null) {
			pi_list.push(beanObj);
			return true;
		}
	}
	else {
		billingObj = Cached_getBillingById(beanObj.id);
		if (billingObj == null) {
			Cached_billingList.push(beanObj);
			return true;
		}
	}

	return false;
} // .end of Cached_addBilling

/**
 * Update billing object.
 * 
 * @param {BillingBean} beanObj - Billing object.
 * @returns {boolean} true if object has been added successfully; otherwise false.
 */
function Cached_updateBilling(beanObj, pi_list) {

	if (pi_list == null) {		
		var foundIndex = -1;
		$.each(Cached_billingList, function(i, obj) {
			if (beanObj.id == obj.id) {
				foundIndex = i;
				return false;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			Cached_billingList.splice(foundIndex, 1);
			Cached_billingList.push(beanObj);
			return true;
		}
	}
	else {
		var foundIndex = -1;
		$.each(pi_list, function(i, obj) {
			if (beanObj.id == obj.id) {
				foundIndex = i;
				return false;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			pi_list.splice(foundIndex, 1);
			pi_list.push(beanObj);
			return true;
		}
	}
} // .end of Cached_updateBilling

/**
 * Get billing object by billing id.
 * 
 * @param {string} id - Billing ID
 * @param {List of BillingBean} pi_list - List of BillingBean
 * @returns {BillingBean} Billing object or null.
 */
function Cached_getBillingById(id, pi_list) {
	var list = pi_list;
	if (list == null)
		list = Cached_getBillingList();

	var foundObj;
	$.each(list, function(i, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getBillingById

/**
 * Get billing object by billing no.
 * 
 * @param {string} id - Billing ID
 * @param {List of BillingBean} pi_list - List of BillingBean
 * @returns {BillingBean} Billing object or null.
 */
function Cached_getBillingByBillingNo(billingNo, pi_list) {
	var list = pi_list;
	if (list == null)
		list = Cached_getBillingList();

	var foundObj;
	$.each(list, function(i, beanObj) {
		if (beanObj.billingNo == billingNo) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getBillingByBillingNo

/**
 * Delete billing object by id.
 * 
 * @param {string} id - Billing ID
 * @param {List of BillingBean} pi_list - List of BillingBean
 * @returns {boolean} true if biling object has been deleted; otherwise false.
 */
function Cached_deleteBillingById(id, pi_list) {

	if (pi_list == null) {		
		var foundIndex = -1;
		$.each(Cached_billingList, function(i, beanObj) {
			if (beanObj.id == id) {
				foundIndex = i;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			Cached_billingList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
			Cached_billingList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
			return true;
		}
	}
	else {
		var foundIndex = -1;
		$.each(pi_list, function(i, beanObj) {
			if (beanObj.id == id) {
				foundIndex = i;
			}
		});

		if (foundIndex == -1)
			return false;
		else {
			pi_list[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
			pi_list[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
			return true;
		}
	}
} // .end of Cached_deleteBillingById

/**
 * Get dependent billing objects in list from component, by given item id. 
 * 
 * @param {string} componentId	Component ID
 * @param {List of BillingBean} pi_list - List of BillingBean
 * @returns	{List of BillingBean} List of Billing object
 */
function Cached_getDepenedentBillingListByComponentId(componentId, pi_list) {
	var list = pi_list;
	if (list == null) {
		list = Cached_getBillingList();
	}

	var dependentBillingList = [];
	$.each(list, function(i, billingObj) {

		var isDependent = false;
		$.each(billingObj.lineList, function(j, lineObj) {
			if (lineObj.componentId == componentId) {
				isDependent = true;
				return false;
			}
		});

		if (isDependent == true) {
			dependentBillingList.push(billingObj);
			return false;
		}
	});

	return dependentBillingList;
} // .end of getDepenedentBillingListByComponentId

//------------------------------------------------------------------------------
// CustomerBean

function Cached_sortCustomer(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.addressList = Cached_getActiveList(beanObj.addressList);
		beanObj.contactList = Cached_getActiveList(beanObj.contactList);
		beanObj.emailList = Cached_getActiveList(beanObj.emailList);
		beanObj.profileList = Cached_getActiveList(beanObj.profileList);
		$.each(beanObj.profileList, function(i, profileObj) {
			profileObj.propertiesList = Cached_getActiveList(profileObj.propertiesList);
		});
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);

		// Sorting
		beanObj.addressList.sort(function(a, b) {
			if (a.type < b.type) return -1;
			if (a.type > b.type) return 1;
			return 0;
		});
		beanObj.contactList.sort(function(a, b) {
			if (a.type < b.type) return -1;
			if (a.type > b.type) return 1;
			return 0;
		});
		beanObj.emailList.sort(function(a, b) {
			if (a.emailAddress < b.emailAddress) return -1;
			if (a.emailAddress > b.emailAddress) return 1;
			return 0;
		});
		beanObj.profileList.sort(function(a, b) {
			if (a.profileName < b.profileName) return -1;
			if (a.profileName > b.profileName) return 1;
			return 0;
		});
		beanObj.propertiesList.sort(function(a, b) {
			if (a.propKey < b.propKey) return -1;
			if (a.propKey > b.propKey) return 1;
			return 0;
		});
	}
} // .end of Cached_sortCustomer

function Cached_sortCustomerList(beanList) {
	beanList.sort(function(a, b) {
		return (a.firstName + ' ' + a.lastName) - (b.firstName + ' ' + b.lastName);
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortCustomer(beanObj);
	});
} // .end of Cached_sortCustomerList

function Cached_setCustomerList(list) {
	Cached_customerList = Cached_getActiveList(list);
} // .end of Cached_setCustomerList

function Cached_getCustomerList(sortList) {
	Cached_customerList = Cached_getActiveList(Cached_customerList);
	if (sortList == true)
		Cached_sortCustomerList(Cached_customerList);

	return Cached_customerList;
} // .end of Cached_getCustomerList

function Cached_addCustomer(beanObj) {
	if (Cached_getCustomerById(beanObj.id) == null) {
		Cached_customerList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addCustomer

function Cached_updateCustomer(beanObj) {
	var foundIndex = -1;
	$.each(Cached_getCustomerList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_customerList.splice(foundIndex, 1);
		Cached_customerList.push(beanObj);
		return true;
	}
} // .end of Cached_updateCustomer

function Cached_getCustomerById(id) {
	var foundObj;
	$.each(Cached_getCustomerList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getCustomerById

function Cached_deleteCustomerById(id) {
	var foundIndex = -1;
	$.each(Cached_getCustomerList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_customerList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_customerList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deleteCustomerById

function Cached_getCustomerProfileById(customerId, profileId) {
	var customerObj = Cached_getCustomerById(customerId);

	var foundObj;
	$.each(customerObj.profileList, function(i, profileObj) {
		if (profileObj.id == profileId) {
			foundObj = profileObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getCustomerProfileById

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

//------------------------------------------------------------------------------
// CategoryList

function Cached_sortCategory(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);

		// Sorting
		beanObj.propertiesList.sort(function(a, b) {
			return a.seqno - b.seqno;
		});
	}
} // .end of Cached_sortCategory

function Cached_sortCategoryList(beanList) {
	beanList.sort(function(a, b) {
		return a.seqno - b.seqno;
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortCategory(beanObj);
	});
} // .end of Cached_sortCategoryList

function Cached_setCategoryList(list) {
	// #1. Unstructured List
	Cached_categoryList = Cached_getActiveList(list);
} // .end of Cached_setCategoryList

function Cached_getCategoryList(sortList) {
	Cached_categoryList = Cached_getActiveList(Cached_categoryList);
	if (sortList == true)
		Cached_sortCategoryList(Cached_categoryList);
	return Cached_categoryList;
} // .end of Cached_getCategoryList

function Cached_getSystemCategoryList(sortList) {
	var list = Cached_getActiveList(Cached_categoryList);
	var filteredList = [];

	$.each(list, function(i, categoryObj) {
		if (categoryObj.systemDefined == true) {
			filteredList.push(categoryObj);
		}
	});

	if (sortList == true)
		Cached_sortCategoryList(filteredList);
	return filteredList;
} // .end of Cached_getCategoryList

function Cached_addCategory(beanObj) {
	if (Cached_getCategoryById(beanObj.id) == null) {
		// #1. Unstructured List
		Cached_categoryList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addCategory

function Cached_updateCategory(beanObj) {
	// #1. Unstructured List
	var foundIndex = -1;
	$.each(Cached_getCategoryList(), function(i, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = i;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_categoryList.splice(foundIndex, 1);
		Cached_categoryList.push(beanObj);
	}
} // .end of Cached_updateCategory

function Cached_getCategoryById(id, alist) {
	var categoryList = alist;
	if (categoryList == null)
		categoryList = Cached_getCategoryList();
	if (categoryList == null)
		categoryList = [];

	var foundObj;
	$.each(categoryList, function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getCategoryById

function Cached_getCategoryByName(name, alist) {
	var categoryList = alist;
	if (categoryList == null)
		categoryList = Cached_getCategoryList();
	if (categoryList == null)
		categoryList = [];

	var foundObj;
	$.each(categoryList, function(index, beanObj) {
		if (beanObj.name == name) {
			Cached_sortCategory(foundObj);
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getCategoryByName

function Cached_getCategoryListByParentId(parentId, sortList, alist) {
	var categoryList = alist;
	if (categoryList == null)
		categoryList = Cached_getCategoryList();
	if (categoryList == null)
		categoryList = [];

	var alist = [];
	$.each(categoryList, function(index, categoryObj) {
		if (categoryObj.parentCategoryId == parentId)
			alist.push(categoryObj);
	});

	// Sort with seqno in ascending order
	if (sortList == true)
		Cached_sortCategoryList(alist);

	return alist;
} // .end of Cached_getCategoryListByParentId

function Cached_deleteCategoryById(id) {
	// #1. Unstructured List
	var foundIndex = -1;
	$.each(Cached_getCategoryList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_categoryList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_categoryList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
	}
} // .end of Cached_deleteCategoryById

//------------------------------------------------------------------------------
// ItemList

function Cached_sortItem(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);
		beanObj.componentList = Cached_getActiveList(beanObj.componentList);
		beanObj.imageList = Cached_getActiveList(beanObj.imageList);

		// Sorting
		beanObj.propertiesList.sort(function(a, b) {
			return a.seqno - b.seqno;
		});
		beanObj.componentList.sort(function(a, b) {
			return a.seqno - b.seqno;
		});
		beanObj.imageList.sort(function(a, b) {
			if (a.name < b.name) return -1;
			if (a.name > b.name) return 1;
			return 0;
		});
	}
} // .end of Cached_sortItem

function Cached_sortItemList(beanList) {
	beanList.sort(function(a, b) {
		return a.seqnoInGroup - b.seqnoInGroup;
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortItem(beanObj);
	});
} // .end of Cached_sortItemList

function Cached_clearItemList() {
	// #1: Unstructured list
	Cached_itemList = [];
} // .end of Cached_setItemList

function Cached_setItemList(list) {
	// #1: Unstructured list
	Cached_itemList = Cached_getActiveList(list);
} // .end of Cached_setItemList

function Cached_getItemList(sortList) {
	Cached_itemList = Cached_getActiveList(Cached_itemList);
	if (sortList == true)
		Cached_sortItemList(Cached_itemList);
	return Cached_itemList;
} // .end of Cached_getItemList

function Cached_addItem(beanObj) {
	if (Cached_getItemById(beanObj.id) == null) {
		// #1: Unstructured List
		Cached_itemList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addItem

function Cached_addItemList(beanList) {
	$.each(beanList, function(i, beanObj) {
		if (beanObj == null || beanObj.id == null)
			return true;

		Cached_addItem(beanObj);
	});
} // .end of Cached_addItem

function Cached_updateItem(beanObj) {
	// #1: Unstructured List
	var foundIndex = -1;
	$.each(Cached_getItemList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_itemList.splice(foundIndex, 1);
		Cached_itemList.push(beanObj);
	}
} // .end of Cached_updateItem

function Cached_getItemById(id, itemList) {
	if (itemList == null)
		itemList = Cached_getItemList();
	if (itemList == null)
		itemList = [];

	var foundObj;
	$.each(itemList, function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getItemById

function Cached_deleteItemById(id) {
	var itemObj = Cached_getItemById(id);
	if (itemObj == null)
		return false;

	// #1. Unstructured List
	var foundIndex = -1;
	$.each(Cached_getItemList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_itemList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_itemList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
	}
} // .end of Cached_deleteItemById

function Cached_getItemListByCategoryId(categoryId, sortList, alist) {
	var itemList = alist;
	if (itemList == null)
		itemList = Cached_getItemList();
	if (itemList == null)
		itemList = [];

	var alist = [];
	$.each(itemList, function(i, itemObj) {
		if (itemObj.categoryId == categoryId) {
			// Check if duplicate item found.
			var added = false;
			$.each(alist, function(j, addedObj) {
				if (addedObj.id == itemObj.id)
					added = true;
			});

			if (added == false)
				alist.push(itemObj);
		}
	});

	// Sort 
	if (sortList == true)
		Cached_sortItemList(alist);

	return alist;
} // .end of Cached_getItemListByCategoryId

function Cached_getItemListByComponent(componentObj, sortList, pi_itemList) {
	var itemList = [];
	var idList = $.trim(componentObj.itemIds) == '' ? [] : componentObj.itemIds.split(',');
	var tagList = $.trim(componentObj.tags) == '' ? [] : componentObj.tags.split(',');

	$.each(idList, function(i, itemId) {
		itemList.push(Cached_getItemById(itemId, pi_itemList));
	});

	// extract item id from componentObj.tags
	$.each(tagList, function(i, tagVal) {

		var trimmedTagVal = $.trim(tagVal);
		var tagItemList = Cached_getItemListByTag(trimmedTagVal, sortList, pi_itemList);

		$.each(tagItemList, function(j, tagItemObj) {
			if ($.inArray(tagItemObj, itemList) == -1)
				itemList.push(tagItemObj);
		});
	});

	// Sort with seqno in ascending order
	if (sortList == true)
		Cached_sortItemList(itemList);

	return itemList;
} // .end of Cached_getItemListByComponent

function Cached_getItemListByTag(tagVal, sortList, pi_itemList) {
	if (pi_itemList == null)
		pi_itemList = Cached_getItemList();
	if (pi_itemList == null)
		pi_itemList = [];

	var itemList = [];
	$.each(pi_itemList, function(i, itemObj) {
		if ($.trim(itemObj.labels).indexOf(tagVal) >= 0)
			itemList.push(itemObj);
	});

	// Sort with seqno in ascending order
	if (sortList == true)
		Cached_sortItemList(itemList);

	return itemList;
} // .end of Cached_getItemListByTag

function Cached_getItemListInSameGroup(itemObj, sortList) {
	var itemList = [];
	$.each(Cached_getItemList(), function(i, curItemObj) {
		if (itemObj.groupName == curItemObj.groupName && itemObj.categoryId == curItemObj.categoryId) {
			itemList.push(curItemObj);
		}
	});

	// Sort with seqno in ascending order
	if (sortList == true)
		Cached_sortItemList(itemList);

	return itemList;
} // .end of Cached_getItemListInSameGroup

/*******************************************************************************
 * Get dependent item objects in list from component, by given item id. 
 * 
 * @cateoryId	Item ID
 * @return		Item object in list. 
 * 
 * Change Logs
 * -----------
 * 20160928	Ryan Chee	Initial
 */
function Cached_getDependentItemListByItemId(itemId, sortList) {
	var itemObj = Cached_getItemById(itemId);
	var dependentItemList = [];

	$.each(Cached_getItemList(), function(i, l_itemObj) {

		$.each(l_itemObj.componentList, function(j, l_componentObj) {

			var isDependent = false;

			var idList = l_componentObj.itemIds.split(',');
			$.each(idList, function(k, id) {

				if (id != '') {
					if (itemId == id) {
						isDependent = true;
						return false;
					}
				}
			});
			/*
			if (isDependent==false && itemObj.labels != '')
			{
				var tagList = l_componentObj.tags.split(',');
				$.each(tagList, function(k, tag){
					
					if (tag != '')
					{
						if (itemObj.labels.indexOf(tag) >= 0)
						{
							isDependent = true;
							return false;
						}
					}					
				});
			}	
			*/

			if (isDependent == true) {
				dependentItemList.push(l_itemObj);
				return false;
			}
		});
	});

	// Sort with seqno in ascending order
	if (sortList == true)
		Cached_sortItemList(dependentItemList);

	return dependentItemList;
} // .end of Cached_getDependentItemListByItemId

function Cached_getGroupListByCategoryId(categoryId, includeItems) {
	var groupList = [];
	var itemList = Cached_getItemListByCategoryId(categoryId);

	$.each(itemList, function(i, itemObj) {
		var isGroupExist = false;
		$.each(groupList, function(j, groupObj) {
			if (groupObj.groupName == itemObj.groupName) {
				if (includeItems)
					groupObj.itemList.push(itemObj);

				isGroupExist = true;
				return false;
			}
		});

		if (isGroupExist == false) {
			var groupObj = new Object();
			groupObj.groupName = itemObj.groupName;

			if (includeItems) {
				groupObj.itemList = [];
				groupObj.itemList.push(itemObj);
			}

			groupList.push(groupObj);
		}
	});

	// Sort by name asc
	groupList.sort(function(a, b) {
		if (a.groupName < b.groupName) return -1;
		if (a.groupName > b.groupName) return 1;
		return 0;
	});
	// Sort itemList within
	$.each(groupList, function(i, groupObj) {
		groupObj.itemList.sort(function(a, b) {
			if (a.name < b.name) return -1;
			if (a.name > b.name) return 1;
			return 0;
		});
	});

	return groupList;
} // .end of Cached_getGroupListByCategoryId

//------------------------------------------------------------------------------
// TransactionList

function Cached_sortTransaction(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.lineList = Cached_getActiveList(beanObj.lineList);

		// Sorting
		beanObj.lineList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
	}
} // .end of Cached_sortTransaction

function Cached_sortTransactionList(beanList) {
	beanList.sort(function(a, b) {
		return a.createdOn - b.createdOn;
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortTransaction(beanObj);
	});
} // .end of Cached_sortTransactionList

function Cached_setTransactionList(list) {
	Cached_transactionList = Cached_getActiveList(list);
} // .end of Cached_setTransactionList

function Cached_getTransactionList(sortList) {
	Cached_transactionList = Cached_getActiveList(Cached_transactionList);
	if (sortList == true)
		Cached_sortTransactionList(Cached_transactionList);
	return Cached_transactionList;
} // .end of Cached_getTransactionList

function Cached_addTransaction(beanObj) {
	if (Cached_getTransactionById(beanObj.id) == null) {
		Cached_transactionList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addTransaction

function Cached_updateTransaction(beanObj) {
	var foundIndex = -1;
	$.each(Cached_getTransactionList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_transactionList.splice(foundIndex, 1);
		Cached_transactionList.push(beanObj);
		return true;
	}
} // .end of Cached_updateTransaction

function Cached_getTransactionById(id) {
	var foundObj;
	$.each(Cached_getTransactionList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getTransactionById

function Cached_getTransactionByBillingId(billingId) {
	var foundObj;
	$.each(Cached_getTransactionList(), function(index, beanObj) {
		if (beanObj.thirdPartyId == billingId) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getTransactionByBillingId

function Cached_deleteTransactionById(id) {
	var foundIndex = -1;
	$.each(Cached_getTransactionList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_transactionList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_transactionList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deleteTransactionById

function Cached_deleteTransactionByBillingId(billingId) {
	var foundIndex = -1;
	$.each(Cached_getTransactionList(), function(index, beanObj) {
		if (beanObj.thirdPartyId == billingId) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_transactionList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_transactionList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deleteTransactionByBillingId

//------------------------------------------------------------------------------
// PlaceList

function Cached_sortPlace(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.addressList = Cached_getActiveList(beanObj.addressList);
		beanObj.operatingHourList = Cached_getActiveList(beanObj.operatingHourList);
		beanObj.labelList = Cached_getActiveList(beanObj.labelList);
		beanObj.imageList = Cached_getActiveList(beanObj.imageList);
		beanObj.documentList = Cached_getActiveList(beanObj.documentList);
		beanObj.roleList = Cached_getActiveList(beanObj.roleList);
		beanObj.settingsList = Cached_getActiveList(beanObj.settingsList);
		beanObj.templateList = Cached_getActiveList(beanObj.templateList);
		$.each(beanObj.templateList, function(i, templateObj) {
			templateObj.propertiesList = Cached_getActiveList(templateObj.propertiesList);
		});
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);
		beanObj.calendarList = Cached_getActiveList(beanObj.calendarList);
		$.each(beanObj.calendarList, function(i, calendarObj) {
			calendarObj.eventList = Cached_getActiveList(calendarObj.eventList);
		});
		beanObj.workflowList = Cached_getActiveList(beanObj.workflowList);
		$.each(beanObj.workflowList, function(i, workflowObj) {
			workflowObj.eventList = Cached_getActiveList(workflowObj.eventList);
		});

		// Sorting
		beanObj.addressList.sort(function(a, b) {
			if (a.type < b.type) return -1;
			if (a.type > b.type) return 1;
			return 0;
		});
		beanObj.operatingHourList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		beanObj.labelList.sort(function(a, b) {
			return a.position - b.position;
		});
		beanObj.imageList.sort(function(a, b) {
			if (a.name < b.name) return -1;
			if (a.name > b.name) return 1;
			return 0;
		});
		beanObj.documentList.sort(function(a, b) {
			if (a.docName < b.docName) return -1;
			if (a.docName > b.docName) return 1;
			return 0;
		});
		beanObj.roleList.sort(function(a, b) {
			if (a.userId < b.userId) return -1;
			if (a.userId > b.userId) return 1;
			return 0;
		});
		beanObj.settingsList.sort(function(a, b) {
			if (a.moduleId < b.moduleId) return -1;
			if (a.moduleId > b.moduleId) return 1;
			return 0;
		});
		beanObj.templateList.sort(function(a, b) {
			if (a.moduleId < b.moduleId) return -1;
			if (a.moduleId > b.moduleId) return 1;
			return 0;
		});
		beanObj.propertiesList.sort(function(a, b) {
			if (a.propKey < b.propKey) return -1;
			if (a.propKey > b.propKey) return 1;
			return 0;
		});
		beanObj.calendarList.sort(function(a, b) {
			if (a.calendarName < b.calendarName) return -1;
			if (a.calendarName > b.calendarName) return 1;
			return 0;
		});
		beanObj.workflowList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		$.each(beanObj.workflowList, function(i, workflowObj) {
			workflowObj.eventList.sort(function(a, b) {
				return a.seqno - b.seqno;
			});
		});
	}
} // .end of Cached_sortPlace

function Cached_sortPlaceList(beanList) {
	beanList.sort(function(a, b) {
		if (a.name < b.name) return -1;
		if (a.name > b.name) return 1;
		return 0;
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortPlace(beanObj);
	});
} // .end of Cached_sortPlaceList

function Cached_setPlaceList(list) {
	Cached_placeList = Cached_getActiveList(list);
} // .end of Cached_setPlaceList

function Cached_getPlaceList(sortList) {
	Cached_placeList = Cached_getActiveList(Cached_placeList);
	if (sortList == true)
		Cached_sortPlaceList(Cached_placeList);
	return Cached_placeList;
} // .end of Cached_getPlaceList

function Cached_addPlace(beanObj) {
	if (Cached_getPlaceById(beanObj.id) == null) {
		Cached_placeList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addPlace

function Cached_updatePlace(beanObj) {
	var foundIndex = -1;
	$.each(Cached_getPlaceList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_placeList.splice(foundIndex, 1);
		Cached_placeList.push(beanObj);
		return true;
	}
} // .end of Cached_updatePlace

function Cached_getPlaceById(id) {
	var foundObj;
	$.each(Cached_getPlaceList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getPlaceById

function Cached_deletePlaceById(id) {
	var foundIndex = -1;
	$.each(Cached_getPlaceList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_placeList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_placeList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deletePlaceById

function Cached_getSettingsByKey(key) {
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	if (placeObj != null) {
		var foundObj;
		$.each(placeObj.settingsList, function(index, beanObj) {
			if (beanObj.propKey == key) {
				foundObj = beanObj;
				return false;
			}
		});

		return foundObj;
	}
} // .end of Cached_getSettingsByKey


function Cached_getSettingsListByModule(moduleId, subModuleId) {
	var list = [];
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	if (placeObj != null) {
		$.each(placeObj.settingsList, function(index, beanObj) {
			if (beanObj.moduleId == moduleId && beanObj.subModuleId == subModuleId)
				list.push(beanObj);
		});
	}

	return list;
} // .end of Cached_getSettingsListByGroup

function Cached_setSettingsByKey(key, value) {
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	if (placeObj != null) {
		$.each(placeObj.settingsList, function(index, beanObj) {
			if (beanObj.propKey == key) {
				beanObj.propValue = value;
				return false;
			}
		});
	}
} // .end of Cached_setSettingsByKey

//------------------------------------------------------------------------------
// UserList

function Cached_sortUser(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.actionList = Cached_getActiveList(beanObj.actionList);
		beanObj.sessionList = Cached_getActiveList(beanObj.sessionList);
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);
		beanObj.calendarList = Cached_getActiveList(beanObj.calendarList);
		$.each(beanObj.calendarList, function(i, calendarObj) {
			calendarObj.eventList = Cached_getActiveList(calendarObj.eventList);
		});

		// Sorting
		beanObj.actionList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		beanObj.sessionList.sort(function(a, b) {
			return a.createdOn - b.createdOn;
		});
		beanObj.propertiesList.sort(function(a, b) {
			if (a.propKey < b.propKey) return -1;
			if (a.propKey > b.propKey) return 1;
			return 0;
		});
		beanObj.calendarList.sort(function(a, b) {
			if (a.calendarName < b.calendarName) return -1;
			if (a.calendarName > b.calendarName) return 1;
			return 0;
		});
	}
} // .end of Cached_sortUser

function Cached_sortUserList(beanList) {
	beanList.sort(function(a, b) {
		return (a.firstName + ' ' + a.lastName) - (b.firstName + ' ' + b.lastName);
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortUser(beanObj);
	});
} // .end of Cached_sortUserList

function Cached_setUserList(list) {
	Cached_userList = Cached_getActiveList(list);
} // .end of Cached_setUserList

function Cached_getUserList(sortList) {
	Cached_userList = Cached_getActiveList(Cached_userList);
	if (sortList == true)
		Cached_sortUserList(Cached_userList);
	return Cached_userList;
} // .end of Cached_getUserList

function Cached_addUser(beanObj) {
	if (Cached_getUserById(beanObj.id) == null) {
		Cached_userList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addUser

function Cached_updateUser(beanObj) {
	var foundIndex = -1;
	$.each(Cached_getUserList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_userList.splice(foundIndex, 1);
		Cached_userList.push(beanObj);
		return true;
	}
} // .end of Cached_updateUser

function Cached_getUserById(id) {
	var foundObj;
	$.each(Cached_getUserList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getUserById

function Cached_getUserById(id, alist) {
	if (alist == null)
		alist = Cached_getUserList();
	
	var foundObj;
	$.each(alist, function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getUserById

function Cached_deleteUserById(id) {
	var foundIndex = -1;
	$.each(Cached_getUserList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_userList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_userList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deleteUserById
