
// Global variables
var Cached_billingList = [];
var Cached_billingBucketList = [];

//.end of Global Variables

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

