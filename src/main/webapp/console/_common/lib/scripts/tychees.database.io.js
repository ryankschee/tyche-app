/*
function tycheesIO_saveBeanToIDB(beanObj) {
	if (beanObj == null)
		return false;

	var hasChanges = false;

	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING) {
		IndexedDB_writeBilling(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING_BUCKET) {
		IndexedDB_writeBillingBucket(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_CUSTOMER) {
		IndexedDB_writeCustomer(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_EMPLOYEE) {
		IndexedDB_writeEmployee(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_DOCUMENT) {
		IndexedDB_writeDocument(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_CATEGORY) {
		IndexedDB_writeCategory(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_ITEM) {
		IndexedDB_writeItem(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_TRANSACTION) {
		IndexedDB_writeTransaction(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_PLACE) {
		IndexedDB_writePlace(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_USER) {
		IndexedDB_writeUser(beanObj, FLAG_RECORD_UPDATED_YES);
		hasChanges = true;
	}
} // .end of tycheesIO_saveBeanToIDB
*/
function tycheesIO_saveBean(beanObj, callbackFn) {
	if (beanObj == null)
		return false;

	var requestBody = new Object();
	requestBody.appName = APP_NAME_ALL;
	requestBody.billingList = [];
	requestBody.billingBucketList = [];
	requestBody.customerList = [];
	requestBody.employeeList = [];
	requestBody.documentList = [];
	requestBody.categoryList = [];
	requestBody.itemList = [];
	requestBody.transactionList = [];
	requestBody.placeList = [];
	requestBody.userList = [];

	var hasChanges = false;

	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING) {
		requestBody.billingList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING_BUCKET) {
		requestBody.billingBucketList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_CUSTOMER) {
		requestBody.customerList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_EMPLOYEE) {
		requestBody.employeeList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_DOCUMENT) {
		requestBody.documentList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_CATEGORY) {
		requestBody.categoryList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_ITEM) {
		requestBody.itemList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_PLACE) {
		requestBody.placeList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;
		
		Cached_updatePlace(beanObj);
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_USER) {
		requestBody.userList.push(tycheesIO_trimBean(beanObj));
		hasChanges = true;

		Cached_updateUser(beanObj);
	}
	
	if (hasChanges) {
		// call to sync data
		tycheesIO_syncConsole(requestBody, callbackFn);
	}
} // .end of tycheesIO_saveBean

function tycheesIO_syncConsole(requestBody, callbackFn) {
	
	var params = new Object();
	params.callbackFn = callbackFn;	
	
	tycheesdb_api_syncConsole(requestBody, tycheesIO_syncConsole_postHanlder, params);
} // .end of syncConsole_ajaxCall 

function tycheesIO_syncConsole_postHanlder(success, responseObj, params) {
	
	if (success) {
		
		tycheesLogger_showToast('success', 'System Status', 'Data updated successfully.');

		// Update flags
		localStorage.setItem(LOCAL_STORAGE_KEY_RESET_PASSWORD, responseObj.resetPasswordRequired);
		localStorage.setItem(LOCAL_STORAGE_KEY_LOGOUT, responseObj.logoutRequired);
		
		// Post Init
		tycheesCommon_onModulePostInit();
		// Callback
		if (params.callbackFn != null && tycheesUtil_isFunction(params.callbackFn))
			params.callbackFn();
	}
} // .end of syncConsole_ajaxCall_postHanlder


function tycheesIO_trimBean(beanObj)
{
	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.calendarList = [];
		$.each(beanObj.calendarList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.calendarList.push(childObj);
			}
		});
		newBeanObj.deliveryList = [];
		$.each(beanObj.deliveryList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.deliveryList.push(childObj);
			}
		});
		newBeanObj.lineList = [];
		$.each(beanObj.lineList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.lineList.push(childObj);
			}
		});
		newBeanObj.paymentList = [];
		$.each(beanObj.paymentList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.paymentList.push(childObj);
			}
		});
		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		newBeanObj.workflowList = [];
		$.each(beanObj.workflowList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.workflowList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_BILLING_BUCKET) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.lineList = [];
		$.each(beanObj.lineList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.lineList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_CUSTOMER) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.addressList = [];
		$.each(beanObj.addressList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.addressList.push(childObj);
			}
		});
		newBeanObj.contactList = [];
		$.each(beanObj.contactList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.contactList.push(childObj);
			}
		});
		newBeanObj.emailList = [];
		$.each(beanObj.emailList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.emailList.push(childObj);
			}
		});
		newBeanObj.profileList = [];
		$.each(beanObj.profileList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.profileList.push(childObj);
			}
		});
		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_EMPLOYEE) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.addressList = [];
		$.each(beanObj.addressList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.addressList.push(childObj);
			}
		});
		newBeanObj.contactList = [];
		$.each(beanObj.contactList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.contactList.push(childObj);
			}
		});
		newBeanObj.emailList = [];
		$.each(beanObj.emailList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.emailList.push(childObj);
			}
		});
		newBeanObj.jobList = [];
		$.each(beanObj.jobList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.jobList.push(childObj);
			}
		});
		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_DOCUMENT) {
		return beanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_CATEGORY) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_INVENTORY_ITEM) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		newBeanObj.componentList = [];
		$.each(beanObj.componentList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.componentList.push(childObj);
			}
		});
		newBeanObj.imageList = [];
		$.each(beanObj.imageList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.imageList.push(childObj);
			}
		});
		newBeanObj.ruleList = [];
		$.each(beanObj.ruleList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.ruleList.push(childObj);
			}
		});
		newBeanObj.transactionList = [];
		$.each(beanObj.transactionList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.transactionList.push(childObj);
			}
		});
		
		return newBeanObj;
	}	
	if (beanObj.beanName == BEAN_CLASS_NAME_PLACE) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.accessList = [];
		$.each(beanObj.accessList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.accessList.push(childObj);
			}
		});
		newBeanObj.addressList = [];
		$.each(beanObj.addressList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.addressList.push(childObj);
			}
		});
		newBeanObj.documentList = [];
		$.each(beanObj.documentList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.documentList.push(childObj);
			}
		});
		newBeanObj.contactList = [];
		$.each(beanObj.contactList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.contactList.push(childObj);
			}
		});
		newBeanObj.imageList = [];
		$.each(beanObj.imageList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.imageList.push(childObj);
			}
		});
		newBeanObj.labelList = [];
		$.each(beanObj.labelList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.labelList.push(childObj);
			}
		});
		newBeanObj.moduleList = [];
		$.each(beanObj.moduleList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.moduleList.push(childObj);
			}
		});
		newBeanObj.operatingHourList = [];
		$.each(beanObj.operatingHourList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.operatingHourList.push(childObj);
			}
		});
		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		newBeanObj.roleList = [];
		$.each(beanObj.roleList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.roleList.push(childObj);
			}
		});
		newBeanObj.settingsList = [];
		$.each(beanObj.settingsList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.settingsList.push(childObj);
			}
		});
		newBeanObj.workflowList = [];
		$.each(beanObj.workflowList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.workflowList.push(childObj);
			}
		});
		newBeanObj.templateList = [];
		$.each(beanObj.templateList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.templateList.push(childObj);
			}
		});
		newBeanObj.calendarList = [];
		$.each(beanObj.calendarList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.calendarList.push(childObj);
			}
		});
		newBeanObj.layoutList = [];
		$.each(beanObj.layoutList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.layoutList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
	if (beanObj.beanName == BEAN_CLASS_NAME_USER) {
		var newBeanObj = JSON.parse(JSON.stringify(beanObj));

		newBeanObj.actionList = [];
		$.each(beanObj.actionList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.actionList.push(childObj);
			}
		});
		newBeanObj.sessionList = [];
		$.each(beanObj.sessionList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.sessionList.push(childObj);
			}
		});
		newBeanObj.propertiesList = [];
		$.each(beanObj.propertiesList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.propertiesList.push(childObj);
			}
		});
		newBeanObj.accessRightList = [];
		$.each(beanObj.accessRightList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.accessRightList.push(childObj);
			}
		});
		newBeanObj.calendarList = [];
		$.each(beanObj.calendarList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.calendarList.push(childObj);
			}
		});
		newBeanObj.roleList = [];
		$.each(beanObj.roleList, function(i, childObj) {
			if (childObj.hasChanged) {
				childObj.hasChanged = false;
				newBeanObj.roleList.push(childObj);
			}
		});
		
		return newBeanObj;
	}
} // .end of tycheesIO_trimBean

/**
 * Save/update list of bean into IDB, based on attr beanName.
 * 
 * @param {BeanSuperClass} beanObj - Bean object
 * @param {boolean} syncNow - true if sync with remote server immediately; otherwise false.
 */
function tycheesIO_saveBeanList(beanList, syncNow) {
	if (beanList == null)
		return false;

	var hasChanges = false;
	$.each(beanList, function(i, beanObj) {
		tycheesIO_saveBean(beanObj, false);
		hasChanges = true;
	});

	if (syncNow == null)
		syncNow = true;

	if (hasChanges && syncNow && !tycheesDB_isSyncConsoleInProgress())
		module_sync();

	return true;
} // .end of tycheesIO_saveBeanList

/**
 * Helper function.
 * Get readable name for this bean object
 */
function getBeanName(beanType, beanObj) {
	if (beanType == BEAN_NAME_BILLING)
		return beanObj.billingNo;
	if (beanType == BEAN_NAME_BILLING_BUCKET)
		return beanObj.bucketName;
	if (beanType == BEAN_NAME_CUSTOMER)
		return beanObj.firstName + ' ' + beanObj.lastName;
	if (beanType == BEAN_NAME_EMPLOYEE)
		return beanObj.firstName + ' ' + beanObj.lastName;
	if (beanType == BEAN_NAME_DOCUMENT)
		return beanObj.docName;
	if (beanType == BEAN_NAME_INVENTORY_CATEGORY)
		return beanObj.name;
	if (beanType == BEAN_NAME_INVENTORY_ITEM)
		return beanObj.name;
	if (beanType == BEAN_NAME_INVENTORY_TRANSACTION)
		return beanObj.type + ' (' + beanObj.thirdPartyId + ')';
	if (beanType == BEAN_NAME_PLACE)
		return beanObj.name;
	if (beanType == BEAN_NAME_USER)
		return beanObj.firstName + ' ' + beanObj.lastName;
	return 'Unknown BeanType - [' + beanType + ']';
} //.end of getBeanName

