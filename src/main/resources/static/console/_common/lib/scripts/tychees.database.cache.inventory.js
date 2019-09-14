
// Global variables
var Cached_categoryList = [];
var Cached_itemList = [];

//.end of Global Variables

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

