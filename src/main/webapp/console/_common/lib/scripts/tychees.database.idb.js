//==============================================================================
// Generic functions to access/manipulate indexedDB
//
//==============================================================================

var dbInstance;

//Database Properties
var DATABASE_NAME = 'tychees.indexed.db';
var DATABASE_VERSION = 1;

//Object Stores' Name
const OBJECT_STORE_BILLING = 'Tychees.Console.Billing';
const OBJECT_STORE_BILLING_BUCKET = 'Tychees.Console.BillingBucket';
const OBJECT_STORE_CUSTOMER = 'Tychees.Console.Customer';
const OBJECT_STORE_EMPLOYEE = 'Tychees.Console.Employee';
const OBJECT_STORE_DOCUMENT = 'Tychees.Console.Document';
const OBJECT_STORE_INVENTORY_CATEGORY = 'Tychees.Console.InventoryCategory';
const OBJECT_STORE_INVENTORY_ITEM = 'Tychees.Console.InventoryItem';
const OBJECT_STORE_INVENTORY_TRANSACTION = 'Tychees.Console.InventoryTransaction';
const OBJECT_STORE_PLACE = 'Tychees.Console.Place';
const OBJECT_STORE_USER = 'Tychees.Console.User';

var OBJECT_STORE_LIST = [
	OBJECT_STORE_BILLING,
	OBJECT_STORE_BILLING_BUCKET,
	OBJECT_STORE_CUSTOMER,
	OBJECT_STORE_EMPLOYEE,
	OBJECT_STORE_DOCUMENT,
	OBJECT_STORE_INVENTORY_CATEGORY,
	OBJECT_STORE_INVENTORY_ITEM,
	OBJECT_STORE_INVENTORY_TRANSACTION,
	OBJECT_STORE_PLACE,
	OBJECT_STORE_USER
];

//Object Stores - Generic keypaths
var OS_KEYPATH_ID = 'id';
var OS_KEYPATH_PLACE_ID = 'placeId'; // Differentiate at place level
var OS_KEYPATH_UPDATE_FLAG = 'updateFlag'; // 0 - unchanged; 1 - changed
var OS_KEYPATH_UPDATE_DATE = 'updateDate'; // Use to compare date/time in server
//Object Stores - Custom keypaths
var OS_KEYPATH_BEAN_NAME = 'beanName';

//Object Stores' indexes - Generic
var OS_INDEXNAME_PLACE_ID = 'placeId';
var OS_INDEXNAME_UPDATE_FLAG = 'updateFlag';
var OS_INDEXNAME_UPDATE_DATE = 'updateDate';
var OS_INDEXNAME_BEAN_NAME = 'beanName';

//Object Stores' Flags
var FLAG_RECORD_UPDATED_NO = 0;
var FLAG_RECORD_UPDATED_YES = 1;

/**
 * Init IndexedDB instance.
 */
function tycheesdb_initIDB(appName) {

	// Check if screen locked.
	//tycheesCommon_checkLockScreen();

	if (dbInstance == null) {
		// This works on all devices/browsers, and uses IndexedDBShim as a final fallback 
		var database = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB || window.shimIndexedDB;

		if (!window.indexedDB) {
			tycheesLogger_logError("Your browser does not support a stable version of IndexedDB.", "tycheesdb_initIDB");
			window.location.href = tycheesCommon_getConsoleBox() + '/landing/login.jsp';
		}
		else {
			tycheesLogger_logDebug("IndexedDB, Browser supported", "tycheesdb_getIDB");

			// Open (or create) the database
			var request = database.open(DATABASE_NAME, DATABASE_VERSION);

			// Event Handling: On ERROR
			request.onerror = function(event) {
				tycheesLogger_logError("Unable to open database [" + DATABASE_NAME + "]", "tycheesdb_initIDB");
			}; // end of onerror

			// Event Handling: On UPGRADE NEEDED
			request.onupgradeneeded = function(event) {
				tycheesLogger_logDebug("Upgrading database [" + DATABASE_NAME + "]", "tycheesdb_initIDB");

				dbInstance = request.result;

				syncDatabase_createObjectStore(OBJECT_STORE_BILLING);
				syncDatabase_createObjectStore(OBJECT_STORE_BILLING_BUCKET);
				syncDatabase_createObjectStore(OBJECT_STORE_CUSTOMER);
				syncDatabase_createObjectStore(OBJECT_STORE_EMPLOYEE);
				syncDatabase_createObjectStore(OBJECT_STORE_DOCUMENT);
				syncDatabase_createObjectStore(OBJECT_STORE_INVENTORY_CATEGORY);
				syncDatabase_createObjectStore(OBJECT_STORE_INVENTORY_ITEM);
				syncDatabase_createObjectStore(OBJECT_STORE_INVENTORY_TRANSACTION);
				syncDatabase_createObjectStore(OBJECT_STORE_PLACE);
				syncDatabase_createObjectStore(OBJECT_STORE_USER);
			}; // end of onupgradeneeded

			// Event Handling: On SUCCESS
			request.onsuccess = function() {
				tycheesLogger_logDebug("Opened database [" + DATABASE_NAME + "] SUCCESS.", "tycheesdb_initIDB");

				// Assign database instance
				dbInstance = request.result;
				// Call next step for data initialization
				tycheesdb_initConsole(appName);
			}; // .end of onsuccess
		}
	}
} // .end of tycheesdb_initIDB

/**
 * Get IndexedDB instance
 * 
 * @author	Ryan Chee
 * @version	1.0
 */
function tycheesdb_getIDB() {
	if (dbInstance == null)
		tycheesLogger_logError('IndexedDB instance has not initialized yet. Please call tycheesdb_initIDB() for initialization.', 'tycheesdb_getIDB');

	return dbInstance;
} // .end of tycheesdb_getIDB

/**
 * *** USE with CAUTIONS ***
 * The deleteDatabase() method of the IDBFactory interface requests the deletion 
 * of a database. The method returns an IDBOpenDBRequest object immediately, and 
 * performs the deletion operation asynchronously
 */
function deleteDatabase() {
	var req = window.indexedDB.deleteDatabase(DATABASE_NAME);
	req.onsuccess = function() {
		tycheesLogger_logDebug("Deleted database successfully.", "deleteDatabase")
	};
	req.onerror = function() {
		tycheesLogger_logDebug("Couldn't delete database.", "deleteDatabase");
	};
	req.onblocked = function() {
		tycheesLogger_logDebug("Couldn't delete database due to the operation being blocked.", "deleteDatabase");
	};
} // .end of deleteDatabase

function tycheesIDB_clearAll() {
	// Clear IndexedDB
	var tx = getIDBTransaction();
	$.each(OBJECT_STORE_LIST, function(i, objectStoreName) {
		tx.objectStore(objectStoreName).clear();
	});
} // .end of clearIDB

function getIDBTransaction(customStoreList) {
	try {
		if (customStoreList == null)
			return tycheesdb_getIDB().transaction(OBJECT_STORE_LIST, "readwrite");
		else
			return tycheesdb_getIDB().transaction(customStoreList, "readwrite");
	} catch (err) {
		tycheesLogger_logError('Error: ' + err, 'getIDBTransaction');
		tycheesCommon_logout(true);
	}
} // .end of getIDBTransaction

/**
 * This function create object store and related indexes. 
 * When: (1) on opening database request, if upgrade needed event triggered. 
 */
function syncDatabase_createObjectStore(objectStoreName) {
	if (tycheesdb_getIDB() == null)
		return false;

	// Create object store
	var objectStore = tycheesdb_getIDB().createObjectStore(objectStoreName, {
		keyPath: OS_KEYPATH_ID
	});
	// Create index from Object Stores
	objectStore.createIndex(OS_INDEXNAME_PLACE_ID, OS_KEYPATH_PLACE_ID, {
		unique: false
	});
	objectStore.createIndex(OS_INDEXNAME_UPDATE_FLAG, OS_KEYPATH_UPDATE_FLAG, {
		unique: false
	});
	objectStore.createIndex(OS_INDEXNAME_UPDATE_DATE, OS_KEYPATH_UPDATE_DATE, {
		unique: false
	});
	objectStore.createIndex(OS_INDEXNAME_BEAN_NAME, OS_KEYPATH_BEAN_NAME, {
		unique: false
	});

	return objectStore;
} // .end of syncDatabase_createObjectStore

/**
 * Get objectStore by given Id.
 */
function getObjectStoreById(objectStoreId) {
	var transactionObj = getIDBTransaction(objectStoreId);
	transactionObj.oncomplete = function() {};
	transactionObj.onerror = function(event) {
		tycheesLogger_logError('IDB Transaction failure: ' + event, 'getObjectStoreById');
	};

	var objectStore = transactionObj.objectStore(objectStoreId);
	return objectStore;
} // .end of getObjectStoreById

/**
 * Get all object from objectStore, and insert into targetList.
 */
function getAllObjects(objectStore, targetList) {
	objectStore.openCursor().onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			// Each record in objectStore, has one standard keypath 'bean'.
			// This keypath 'bean' stores bean object in json format as whole. 
			targetList.push(cursor.value.bean);
			cursor.continue();
		}
		else {
			// error handling
		}
	};
} // .end of getAllObjects

/**
 * Get bean record from given objectStore, with keypath=keyPathValue.
 * 
 * Parameter 'targetList' is an array, and found bean record will be pushed 
 * into element at index 0. 
 */
function getObjectByKey(objectStore, keyPathValue, targetList) {
	var request = objectStore.get(keyPathValue);
	request.onerror = function(event) {
		// Handle errors! >> request.error
		tycheesLogger_logError("Error [" + request.error + "] in reading value from key (" + keyPathValue + ")", "getObjectByKey");
	};
	request.onsuccess = function(event) {
		// Do something with the request.result!
		if (request.result != null)
			targetList.push(request.result.bean);
	};
} // .end of getObjectByKey


/**
 * Get list of objects from objectStoreName, where indexName==indexValue. 
 * Copy matched object into targetList.
 */
function getObjectListByIndex(txObj, objectStoreName, indexName, indexValue, targetList) {
	var objectStore = txObj.objectStore(objectStoreName);
	var index = objectStore.index(indexName);

	var getAllRequest = index.getAll(indexValue);
	getAllRequest.onsuccess = function(event) {

		var resultList = event.target.result;

		$.each(resultList, function(i, result) {
			if (result.bean != null)
				targetList.push(result.bean);
		});
	};
} // .end of getObjectListByIndex


//==============================================================================        
// ** Functions below will be phase out soon.         

/**
 * Add new object record into specified dataStore
 */
function addObject(objectStoreName, recordData) {
	if (tycheesdb_getIDB() == null)
		return false;

	var transaction = getIDBTransaction();
	// Do something when all the data is added to the database.
	transaction.oncomplete = function(event) {
		// on transaction complete
	};
	transaction.onerror = function(event) {
		tycheesLogger_logError("Transaction error, " + event, "addObject");
	};

	var objectStore = transaction.objectStore(objectStoreName);
	var request = objectStore.add({
		id: recordData.id,
		placeId: recordData.id,
		updateFlag: 0,
		updateDate: recordData.updatedOn,
		beanName: '',
		bean: recordData
	});
	request.onsuccess = function(event) {
		// on request success
	};
	request.onerror = function(event) {
		// Handle errors!
		tycheesLogger_logError("Request error, " + event, "addObject");
	};
} // .end of addObject

/**
 * Update object record into specified dataStore
 */
function updateObject(objectStoreName, recordData) {
	if (tycheesdb_getIDB() == null)
		return false;

	var transaction = getIDBTransaction();

	// Do something when all the transaction has been completed.
	transaction.oncomplete = function(event) {
		// on transaction complete
	};
	transaction.onerror = function(event) {
		tycheesLogger_logError("Transaction error, " + event, "updateObject");
	};

	var objectStore = transaction.objectStore(objectStoreName);
	var request = objectStore.put({
		id: recordData.id,
		placeId: recordData.id,
		updateFlag: 1,
		updateDate: recordData.updatedOn,
		beanName: '',
		bean: recordData
	});
	request.onsuccess = function(event) {
		// on request success
	};
	request.onerror = function(event) {
		// Handle errors!
		tycheesLogger_logError("Request error, " + event, "updateObject");
	};
} // .end of updateObject

function deleteObject(objectStoreName, recordData) {
	if (tycheesdb_getIDB() == null)
		return false;

	var transaction = getIDBTransaction();
	// Do something when all the transaction has been completed.
	transaction.oncomplete = function(event) {
		// on transaction complete
	};
	transaction.onerror = function(event) {
		tycheesLogger_logError("Transaction error, " + event, "deleteObject");
	};

	var objectStore = transaction.objectStore(objectStoreName);
	var request = objectStore.delete(objectStoreName.id);
	request.onsuccess = function(event) {
		// on request success
	};
	request.onerror = function(event) {
		// Handle errors!
		tycheesLogger_logError("Request error, " + event, "deleteObject");
	};
} // .end of deleteObject

//-----------------------------------------------------------------------------
// BEAN RELATED 

/**
 * Save/update billing bucket object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {BillingBucketBean} billingBucketObj - Billing Bucket object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeBillingBucket(billingBucketObj, flagVal) {
	if (billingBucketObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_BILLING_BUCKET);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: billingBucketObj.id,
		placeId: billingBucketObj.placeId,
		updateFlag: flagVal,
		updateDate: billingBucketObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_BILLING_BUCKET, billingBucketObj),
		bean: billingBucketObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeBillingBucket');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeBillingBucket');
	};
} // .end of IndexedDB_writeBillingBucket

/**
 * Save/update list of billing bucket object into IDB. 
 * 
 * @param {Array of BillingBucketBean} billingBucketList - List of Billing bucket object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeBillingBucketList(billingBucketList, flagVal) {
	if (billingBucketList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(billingBucketList, function(i, beanObj) {
		IndexedDB_writeBillingBucket(beanObj, flagVal);
	});
} // .end of IndexedDB_writeBillingBucketList

/**
 * Save/update billing object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {BillingBean} billingObj - Billing object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeBilling(billingObj, flagVal) {
	if (billingObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_BILLING);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: billingObj.id,
		placeId: billingObj.placeId,
		updateFlag: flagVal,
		updateDate: billingObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_BILLING, billingObj),
		bean: billingObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeBilling');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeBilling');
	};
} // .end of IndexedDB_writeBilling

/**
 * Save/update list of billing object into IDB. 
 * 
 * @param {Array of BillingBean} billingList - List of Billing object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeBillingList(billingList, flagVal) {
	if (billingList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(billingList, function(i, beanObj) {
		IndexedDB_writeBilling(beanObj, flagVal);
	});
} // .end of IndexedDB_writeBillingList

/**
 * Save/update customer object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {CustomerBean} customerObj - Customer object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeCustomer(customerObj, flagVal) {
	if (customerObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_CUSTOMER);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: customerObj.id,
		placeId: customerObj.placeId,
		updateFlag: flagVal,
		updateDate: customerObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_CUSTOMER, customerObj),
		bean: customerObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeCustomer');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeCustomer');
	};
} // .end of IndexedDB_writeCustomer

/**
 * Save/update list of customer object into IDB. 
 * 
 * @param {Array of CustomerBean} customerList - List of Customer object. 
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeCustomerList(customerList, flagVal) {
	if (customerList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(customerList, function(i, beanObj) {
		IndexedDB_writeCustomer(beanObj, flagVal);
	});
} // .end of IndexedDB_writeCustomerList

/**
 * Save/update employee object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {CustomerBean} employeeObj - Employee object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeEmployee(employeeObj, flagVal) {
	if (employeeObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_EMPLOYEE);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: employeeObj.id,
		placeId: employeeObj.placeId,
		updateFlag: flagVal,
		updateDate: employeeObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_EMPLOYEE, employeeObj),
		bean: employeeObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeEmployee');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeEmployee');
	};
} // .end of IndexedDB_writeEmployee

/**
 * Save/update list of employee object into IDB. 
 * 
 * @param {Array of EmployeeBean} employeeList - List of Employee object. 
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeEmployeeList(employeeList, flagVal) {
	if (employeeList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(employeeList, function(i, beanObj) {
		IndexedDB_writeEmployee(beanObj, flagVal);
	});
} // .end of IndexedDB_writeEmployeeList

/**
 * Save/update document object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {DocumentBean} documentObj - Document object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeDocument(documentObj, flagVal) {
	if (documentObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_DOCUMENT);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: documentObj.id,
		placeId: documentObj.placeId,
		updateFlag: flagVal,
		updateDate: documentObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_DOCUMENT, documentObj),
		bean: documentObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeDocument');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeDocument');
	};
} // .end of IndexedDB_writeDocument

/**
 * Save/update list of document object into IDB. 
 * 
 * @param {Array of DocumentBean} documentList - List of Document object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeDocumentList(documentList, flagVal) {
	if (documentList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(documentList, function(i, beanObj) {
		IndexedDB_writeDocument(beanObj, flagVal);
	});
} // .end of IndexedDB_writeDocumentList

/**
 * Save/update category object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {InventoryCategoryBean} categoryObj - Category object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeCategory(categoryObj, flagVal) {
	if (categoryObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_INVENTORY_CATEGORY);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: categoryObj.id,
		placeId: categoryObj.placeId,
		updateFlag: flagVal,
		updateDate: categoryObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_INVENTORY_CATEGORY, categoryObj),
		bean: categoryObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeCategory');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeCategory');
	};
} // .end of IndexedDB_writeCategory

/**
 * Save/update list of category object into IDB. 
 * 
 * @param {Array of InventoryCategoryBean} categoryList - List of Category object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeCategoryList(categoryList, flagVal) {
	if (categoryList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(categoryList, function(i, beanObj) {
		IndexedDB_writeCategory(beanObj, flagVal);
	});
} // .end of IndexedDB_writeCategoryList

/**
 * Save/update item object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {InventoryItemBean} itemObj - Item object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeItem(itemObj, flagVal) {
	if (itemObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_INVENTORY_ITEM);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore	
	var request = objectStore.put({
		id: itemObj.id,
		placeId: itemObj.placeId,
		updateFlag: flagVal,
		updateDate: itemObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_INVENTORY_ITEM, itemObj),
		bean: itemObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeItem');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeItem');
	};
} // .end of IndexedDB_writeItem

/**
 * Save/update list of item object into IDB. 
 * 
 * @param {Array of InventoryItemBean} itemList - List of Item object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeItemList(itemList, flagVal) {
	if (itemList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(itemList, function(i, beanObj) {
		IndexedDB_writeItem(beanObj, flagVal);
	});
} // .end of IndexedDB_writeItemList

/**
 * Save/update transaction object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {InventoryTransactionBean} transactionObj - Transaction object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeTransaction(transactionObj, flagVal) {
	if (transactionObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_INVENTORY_TRANSACTION);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: transactionObj.id,
		placeId: transactionObj.placeId,
		updateFlag: flagVal,
		updateDate: transactionObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_INVENTORY_TRANSACTION, transactionObj),
		bean: transactionObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeTransaction');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeTransaction');
	};
} // .end of IndexedDB_writeTransaction

/**
 * Save/update list of transaction object into IDB. 
 * 
 * @param {Array of InventoryTransactionBean} transactionList - List of Transaction object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeTransactionList(transactionList, flagVal) {
	if (transactionList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(transactionList, function(i, beanObj) {
		IndexedDB_writeTransaction(beanObj, flagVal);
	});
} // .end of IndexedDB_writeTransactionList

/**
 * Save/update place object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {PlaceBean} placeObj - Place object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writePlace(placeObj, flagVal) {
	if (placeObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_PLACE);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: placeObj.id,
		placeId: placeObj.placeId,
		updateFlag: flagVal,
		updateDate: placeObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_PLACE, placeObj),
		bean: placeObj
	});
	request.onsuccess = function(event) {
		//tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writePlace');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writePlace');
	};
} // .end of IndexedDB_writePlace

/**
 * Save/update list of place object into IDB. 
 * 
 * @param {Array of PlaceBean} placeList - List of Place object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writePlaceList(placeList, flagVal) {
	if (placeList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(placeList, function(i, beanObj) {
		IndexedDB_writePlace(beanObj, flagVal);
	});
} // .end of IndexedDB_writePlaceList

/**
 * Save/update user object into IDB, with flag=1 for next-batch auto sync. 
 * 
 * @param {UserBean} userObj - User object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeUser(userObj, flagVal) {
	if (userObj == null)
		return false;

	var objectStore = getObjectStoreById(OBJECT_STORE_USER);
	if (flagVal == null)
		flagVal = FLAG_RECORD_UPDATED_YES;

	// Put updated objects into ObjectStore
	var request = objectStore.put({
		id: userObj.id,
		placeId: userObj.placeId,
		updateFlag: flagVal,
		updateDate: userObj.updatedOn,
		beanName: getBeanName(BEAN_NAME_USER, userObj),
		bean: userObj
	});
	request.onsuccess = function(event) {
		tycheesLogger_logInfo('Request executed successfully.', 'IndexedDB_writeUser');
	};
	request.onerror = function(event) {
		tycheesLogger_logError('Request failed: ' + event, 'IndexedDB_writeUser');
	};
} // .end of IndexedDB_writeUser

/**
 * Save/update list of user object into IDB. 
 * 
 * @param {Array of UserBean} userList - List of User object.
 * @param {int} flagVal - FLAG_RECORD_UPDATED_YES (1) or FLAG_RECORD_UPDATED_NO (0)
 */
function IndexedDB_writeUserList(userList, flagVal) {
	if (userList == null)
		return false;
	// Put updated objects into ObjectStore
	$.each(userList, function(i, beanObj) {
		IndexedDB_writeUser(beanObj, flagVal);
	});
} // .end of IndexedDB_writeUserList



//------------------------------------------------------------------------------
// UTIL FUNCTIONS

/**
 * Reset all records' flag to 0 for given objectStoreId
 * 
 * @param {string} objectStoreId - refer to tychees.database.js
 */
function IndexedDB_resetUpdateFlag(objectStoreId) {
	var objectStore_getAll = getObjectStoreById(objectStoreId);
	objectStore_getAll.getAll().onsuccess = function(event) {
		var list = event.target.result;
		$.each(list, function(i, record) {
			record.updateFlag = FLAG_RECORD_UPDATED_NO;

			var objectStore_forUpdate = getObjectStoreById(objectStoreId);
			objectStore_forUpdate.put(record);
		});
	};
} // .end of IndexedDB_resetUpdateFlag