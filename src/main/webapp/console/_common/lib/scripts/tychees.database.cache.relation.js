
// Global variables
var Cached_customerList = [];
var Cached_employeeList = [];

//.end of Global Variables

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
// EmployeeBean

function Cached_sortEmployee(beanObj) {
	if (beanObj != null) {
		// Get Active-only beans
		beanObj.jobList = Cached_getActiveList(beanObj.jobList);
		beanObj.propertiesList = Cached_getActiveList(beanObj.propertiesList);

		// Sorting
		beanObj.jobList.sort(function(a, b) {
			if (a.jobId < b.jobId) return -1;
			if (a.jobId > b.jobId) return 1;
			return 0;
		});
		beanObj.propertiesList.sort(function(a, b) {
			if (a.propKey < b.propKey) return -1;
			if (a.propKey > b.propKey) return 1;
			return 0;
		});
	}
} // .end of Cached_sortEmployee

function Cached_sortEmployeeList(beanList) {
	beanList.sort(function(a, b) {
		return (a.firstName + ' ' + a.lastName) - (b.firstName + ' ' + b.lastName);
	});

	// Sort child lists
	$.each(beanList, function(i, beanObj) {
		Cached_sortEmployee(beanObj);
	});
} // .end of Cached_sortEmployeeList

function Cached_setEmployeeList(list) {
	Cached_employeeList = Cached_getActiveList(list);
} // .end of Cached_setCustomerList

function Cached_getEmployeeList(sortList) {
	Cached_employeeList = Cached_getActiveList(Cached_employeeList);
	if (sortList == true)
		Cached_sortEmployeeList(Cached_employeeList);

	return Cached_employeeList;
} // .end of Cached_getEmployeeList

function Cached_addEmployee(beanObj) {
	if (Cached_getEmployeeById(beanObj.id) == null) {
		Cached_employeeList.push(beanObj);
		return true;
	}
	return false;
} // .end of Cached_addEmployee

function Cached_updateEmployee(beanObj) {
	var foundIndex = -1;
	$.each(Cached_getEmployeeList(), function(index, obj) {
		if (beanObj.id == obj.id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_employeeList.splice(foundIndex, 1);
		Cached_employeeList.push(beanObj);
		return true;
	}
} // .end of Cached_updateEmployee

function Cached_getEmployeeById(id) {
	var foundObj;
	$.each(Cached_getEmployeeList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundObj = beanObj;
			return false;
		}
	});

	return foundObj;
} // .end of Cached_getEmployeeById

function Cached_deleteEmployeeById(id) {
	var foundIndex = -1;
	$.each(Cached_getEmployeeList(), function(index, beanObj) {
		if (beanObj.id == id) {
			foundIndex = index;
			return false;
		}
	});

	if (foundIndex == -1)
		return false;
	else {
		Cached_employeeList[foundIndex].deletedOn = tycheesDateTime_getCurrentTimeInMillis();
		Cached_employeeList[foundIndex].deletedBy = tycheesCommon_getCurrentUserId();
		return true;
	}
} // .end of Cached_deleteEmployeeById

