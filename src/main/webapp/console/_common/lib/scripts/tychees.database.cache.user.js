
// Global variables
var Cached_userList = [];
var Cached_userObj;

//.end of Global Variables

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
		Cached_addUser(beanObj);
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
