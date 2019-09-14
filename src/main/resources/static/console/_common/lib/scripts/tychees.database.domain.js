function createNew_Billing() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING));
	obj.id = tycheesCommon_getUniqueId();
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.deliveryList = [];
	obj.lineList = [];
	obj.paymentList = [];
	obj.propertiesList = [];
	obj.workflowList = [];
	obj.calendarList = [];

	return obj;
} // .end of createNew_Billing

function createNew_BillingLine() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_LINE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_BillingLine

function createNew_BillingDelivery() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_DELIVERY));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_BillingDelivery

function createNew_BillingPayment() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.propertiesList = [];

	return obj;
} // .end of createNew_BillingPayment

function createNew_BillingPaymentProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_PAYMENT_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_BillingPaymentProperties

function createNew_BillingProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_BillingProperties

function createNew_BillingWorkflow() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.eventList = [];

	return obj;
} // .end of createNew_BillingWorkflow

function createNew_BillingWorkflowEvent() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_WORKFLOW_EVENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_BillingWorkflowEvent

function createNew_BillingBucket() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET));
	obj.id = tycheesCommon_getUniqueId();
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.lineList = [];

	return obj;
} // .end of createNew_BillingBucket

function createNew_BillingBucketLine() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_BILLING_BUCKET_LINE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_BillingBucketLine


//------------------------------------------------------------------------------

function createNew_CommonCalendar() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.eventList = [];

	return obj;
} // .end of createNew_CommonCalendar

function createNew_CommonCalendarEvent() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_COMMON_CALENDAR_EVENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CommonCalendarEvent

function createNew_CommonTemplate() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.propertiesList = [];

	return obj;
} // .end of createNew_CommonTemplate

function createNew_CommonTemplateProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_COMMON_TEMPLATE_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CommonTemplateProperties

//------------------------------------------------------------------------------

function createNew_Customer() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER));
	obj.id = tycheesCommon_getUniqueId();
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.addressList = [];
	obj.contactList = [];
	obj.emailList = [];
	obj.profileList = [];
	obj.propertiesList = [];

	return obj;
} // .end of createNew_Customer

function createNew_CustomerAddress() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_ADDRESS));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CustomerAddress

function createNew_CustomerContact() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_CONTACT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CustomerContact

function createNew_CustomerEmail() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_EMAIL));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CustomerEmail

function createNew_CustomerProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CustomerProperties

function createNew_CustomerProfile() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.propertiesList = [];

	return obj;
} // .end of createNew_CustomerProfile

function createNew_CustomerProfileProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_CUSTOMER_PROFILE_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_CustomerProfileProperties
//------------------------------------------------------------------------------

function createNew_Employee() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE));
	obj.id = tycheesCommon_getUniqueId();
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.addressList = [];
	obj.contactList = [];
	obj.emailList = [];
	obj.jobList = [];
	obj.propertiesList = [];

	return obj;
} // .end of createNew_Employee

function createNew_EmployeeAddress() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_ADDRESS));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_EmployeeAddress

function createNew_EmployeeContact() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_CONTACT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_EmployeeContact

function createNew_EmployeeEmail() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_EMAIL));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_EmployeeEmail

function createNew_EmployeeProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_EmployeeProperties

function createNew_EmployeeJob() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_EMPLOYEE_JOB));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_EmployeeJob

//------------------------------------------------------------------------------

function createNew_Document() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_DOCUMENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.propertiesList = [];

	return obj;
} // .end of createNew_Document


function createNew_DocumentProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_DOCUMENT_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_DocumentProperties

//------------------------------------------------------------------------------

function createNew_InventoryItem() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.propertiesList = [];
	obj.componentList = [];
	obj.imageList = [];

	return obj;
} // .end of createNew_InventoryItem

function createNew_InventoryItemProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_InventoryItemProperties

function createNew_InventoryItemComponent() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_COMPONENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_InventoryItemComponent

function createNew_InventoryItemImage() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_IMAGE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_InventoryItemImage

function createNew_InventoryItemLabel() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_ITEM_LABEL));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_InventoryItemLabel

function createNew_InventoryCategory() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY));
	obj.id = tycheesCommon_getUniqueId();
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.propertiesList = [];

	return obj;
} // .end of createNew_InventoryCategory

function createNew_InventoryCategoryProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_CATEGORY_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_InventoryCategoryProperties

function createNew_InventoryTransaction() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION));
	obj.id = tycheesCommon_getUniqueId();
	obj.placeId = tycheesCommon_getCurrentPlaceId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.lineList = [];

	return obj;
} // .end of createNew_InventoryTransaction

function createNew_InventoryTransactionLine() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_INVENTORY_TRANSACTION_LINE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_InventoryTransactionLine

//------------------------------------------------------------------------------

function createNew_Place() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.accessList = [];
	obj.propertiesList = [];
	obj.addressList = [];
	obj.operatingHourList = [];
	obj.labelList = [];
	obj.imageList = [];
	obj.documentList = [];
	obj.roleList = [];
	obj.settingsList = [];
	obj.templateList = [];
	obj.calendarList = [];
	obj.workflowList = [];

	return obj;
} // .end of createNew_Place

function createNew_PlaceAccess() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceAccess

function createNew_PlaceAccessProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_ACCESS_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceAccessProperties

function createNew_PlaceAddress() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_ADDRESS));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceAddress

function createNew_PlaceContact() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_CONTACT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceContact

function createNew_PlaceDocument() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceDocument

function createNew_PlaceDocumentProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceDocumentProperties

function createNew_PlaceDocumentTemplate() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceDocumentTemplate

function createNew_PlaceDocumentTemplateComponent() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_DOCUMENT_TEMPLATE_COMPONENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceDocumentTemplateComponent

function createNew_PlaceImage() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_IMAGE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceImage

function createNew_PlaceLabel() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_LABEL));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceLabel

function createNew_PlaceOperatingHours() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_OPERATING_HOUR));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceOperatingHour

function createNew_PlaceProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceProperties

function createNew_PlaceRole() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_ROLE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceRole

function createNew_PlaceSettings() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_SETTINGS));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceSettings

function createNew_PlaceWorkflow() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.eventList = [];

	return obj;
} // .end of createNew_PlaceWorkflow

function createNew_PlaceWorkflowEvent() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_WORKFLOW_EVENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceWorkflowEvent

function createNew_PlaceLayout() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceLayout

function createNew_PlaceLayoutComponent() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_PLACE_LAYOUT_COMPONENT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_PlaceLayoutComponent

//------------------------------------------------------------------------------

function createNew_User() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_USER));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	obj.actionList = [];
	obj.sessionList = [];
	obj.propertiesList = [];
	obj.calendarList = [];
	obj.accessRightList = [];
	obj.roleList = [];

	return obj;
} // .end of createNew_User

function createNew_UserAction() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_USER_ACTION));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_UserAction

function createNew_UserProperties() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_USER_PROPERTIES));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_UserProperties

function createNew_UserSession() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_USER_SESSION));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_UserSession

function createNew_UserAccessRight() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_USER_ACCESS_RIGHT));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_UserAccessRight

function createNew_UserRole() {
	var obj = JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY_NEW_USER_ROLE));
	obj.id = tycheesCommon_getUniqueId();
	obj.hasChanged = true;
	obj.createdOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.createdBy = tycheesCommon_getCurrentUserId();
	obj.updatedOn = tycheesDateTime_getCurrentTimeInMillis();
	obj.updatedBy = tycheesCommon_getCurrentUserId();

	return obj;
} // .end of createNew_UserRole
