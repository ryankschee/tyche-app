
// Global variables
var Cached_placeList = [];
var Cached_placeObj;

//.end of Global Variables

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
		Cached_addPlace(beanObj);
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

function Cached_clearPlaceList() {
	Cached_placeList = [];
} // .end of Cached_clearPlaceList

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
				beanObj.hasChanged = true;
				return false;
			}
		});
	}
} // .end of Cached_setSettingsByKey

