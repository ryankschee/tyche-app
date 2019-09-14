
/**
 * Return propObj of matched key.
 */
function billingCommon_getPaymentProperties(paymentObj, propKey) {
	var foundPropObj;
	
	$.each(paymentObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == propKey) {
			foundPropObj = propObj;
			return false;
		}
	});
	
	return foundPropObj;
} // .end of billingCommon_getCreditCardTypeName

/**
 * Return name of credit card.
 */
function billingCommon_getCreditCardTypeName(paymentObj) {
	var creditCardType = '';
	
	if ($.trim(paymentObj.method) == BillingConstants.PAYMENT_METHOD_CREDIT_CARD) {
		var propObj = billingCommon_getPaymentProperties(paymentObj, BillingConstants.PAYMENT_FIELD_CREDIT_CARD_TYPE);
		if (propObj != null) {
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_VISA)
				creditCardType = 'Visa';
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_MASTER)
				creditCardType = 'Master';
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_AMEX)
				creditCardType = 'AMEX';
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_DINERS_CLUB)
				creditCardType = 'Diners Club';
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_DISCOVER)
				creditCardType = 'Discover';
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_JCB)
				creditCardType = 'JCB';
			if (propObj.propValue == BillingConstants.CREDIT_CARD_TYPE_MYDEBIT)
				creditCardType = 'MyDebit';
		}
	}
	
	return creditCardType;
} // .end of billingCommon_getCreditCardTypeName

/**
 * Return billing line by given itemId.
 *  
 * @param	{BillingBean} billingObj - Billing object
 * @param	{String} itemId - Item ID
 * @return	{BillingLineBean} billing line object; null if not found. 
 */
function billingCommon_getBillingLineByRowId(billingObj, rowId) {
	if (billingObj == null)
		return false;

	var foundLineObj;
	$.each(billingObj.lineList, function(index, billingLine) {
		if (billingLine.rowId == rowId) {
			foundLineObj = billingLine;
			return false;
		}
	});

	return foundLineObj;
} // .end of billingCommon_getBillingLineByRowId

/**
 * Create new billing line object, from itemObj, into billingObj.
 * 
 * @param   {BillingBean} billingObj - billing object
 * @param	{ItemBean} itemObj - item object
 * @return	{BillingLineBean} - billing line object
 */
function billingCommon_createBillingLine(billingObj, itemObj) {
	if (billingObj == null || itemObj == null)
		return null;

	var defaultMinUnit = 1;
	var billingLineObj = createNew_BillingLine();
	billingLineObj.billingId = billingObj.id;
	billingLineObj.itemId = itemObj.id;
	billingLineObj.itemName = itemObj.name;
	billingLineObj.itemType = itemObj.itemType;
	billingLineObj.itemGroupName = itemObj.groupName;
	billingLineObj.itemImageUrl = itemObj.imageUrl;
	billingLineObj.rowId = tycheesCommon_generateUUID();
	billingLineObj.quantity = Number(defaultMinUnit);
	billingLineObj.quantityOptional = itemObj.quantityOptional;
	billingLineObj.unitPriceSource = 'default';
	billingLineObj.mandatory = false;
	billingLineObj.ignored = false;
	billingLineObj.remarks = '';

	if (itemObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
		itemObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
		itemObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
		itemObj.itemType == InventoryConstants.ITEM_TYPE_RAW) {

		billingLineObj.taxInclusive = false;
		billingLineObj.taxDiscountInPercentage = false;
		billingLineObj.taxDiscountInAmount = false;
		billingLineObj.taxAmount = 0;
		billingLineObj.taxPercentage = 0;
		billingLineObj.discountAmount = 0;
		billingLineObj.discountPercentage = 0;
		billingLineObj.itemPrice = Number(itemObj.unitPrice);
		billingLineObj.billableAmount = Number(itemObj.unitPrice);
		billingLineObj.defaultUnitPrice = itemObj.unitPrice;
		billingLineObj.compoundUnitPrice = 0;
		billingLineObj.customUnitPrice = 0;
	}
	else
	if (itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {

		billingLineObj.itemPrice = 0;
		billingLineObj.billableAmount = 0;
		billingLineObj.taxInclusive = itemObj.taxInclusive;

		if (itemObj.taxDiscountPercentage > 0) {
			billingLineObj.taxDiscountInPercentage = true;
			billingLineObj.taxDiscountInAmount = false;
			billingLineObj.taxAmount = 0;
			billingLineObj.taxPercentage = itemObj.taxDiscountPercentage;
			billingLineObj.discountAmount = 0;
			billingLineObj.discountPercentage = 0;
			billingLineObj.defaultUnitPrice = itemObj.taxDiscountPercentage;
			billingLineObj.compoundUnitPrice = 0;
			billingLineObj.customUnitPrice = 0;
		}
		if (itemObj.taxDiscountAmount > 0) {
			billingLineObj.taxDiscountInPercentage = false;
			billingLineObj.taxDiscountInAmount = true;
			billingLineObj.taxAmount = itemObj.taxDiscountAmount;
			billingLineObj.taxPercentage = 0;
			billingLineObj.discountAmount = 0;
			billingLineObj.discountPercentage = 0;
			billingLineObj.defaultUnitPrice = itemObj.taxDiscountAmount;
			billingLineObj.compoundUnitPrice = 0;
			billingLineObj.customUnitPrice = 0;
		}
	}
	else
	if (itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {

		billingLineObj.itemPrice = 0;
		billingLineObj.billableAmount = 0;
		billingLineObj.taxInclusive = false;

		if (itemObj.taxDiscountPercentage > 0) {
			billingLineObj.taxDiscountInPercentage = true;
			billingLineObj.taxDiscountInAmount = false;
			billingLineObj.taxAmount = 0;
			billingLineObj.taxPercentage = 0;
			billingLineObj.discountAmount = 0;
			billingLineObj.discountPercentage = itemObj.taxDiscountPercentage;
			billingLineObj.defaultUnitPrice = itemObj.taxDiscountPercentage;
			billingLineObj.compoundUnitPrice = 0;
			billingLineObj.customUnitPrice = 0;
		}
		if (itemObj.taxDiscountAmount > 0) {
			billingLineObj.taxDiscountInPercentage = false;
			billingLineObj.taxDiscountInAmount = true;
			billingLineObj.taxAmount = 0;
			billingLineObj.taxPercentage = 0;
			billingLineObj.discountAmount = itemObj.taxDiscountAmount;
			billingLineObj.discountPercentage = 0;
			billingLineObj.defaultUnitPrice = itemObj.taxDiscountAmount;
			billingLineObj.compoundUnitPrice = 0;
			billingLineObj.customUnitPrice = 0;
		}
	}

	// Calculate billing line, based on current settings. 
	billingCommon_calculateBillingLine(billingLineObj);

	// Return newly created billingLine.
	return billingLineObj;
} // .end of billingCommon_createBillingLine


/**
 * Calculate amounts of billing object:
 * 
 * #1. Calculate amounts from summation of each billing line object. 
 * #2. Handle Level 1 DISCOUNT-typed billing item.
 *     #2.1. Deduct from discount (if any).
 * #3. Handle Level 1 TAX-typed billing item.
 *     #3.1. Add taxes (if any)
 * #4. Calculate payment(s), if any.
 * #5. Create associated workflow event, if any.
 * #6. Update calculated amounts into billing object.
 *  
 * @param	{BillingBean} billingObj - billing object.
 */
function billingCommon_calculateBilling(billingObj) {
	if (billingObj == null) {
		tycheesLogger_showToast('error', 'Invalid Billing', 'Billing object is null.');
		return false;
	}

	//var l1_taxAmount = 0.0;
	var l1_discountAmount = 0.0;

	var uniqueTaxPercentage = 0.0;
	var hasMultipleTaxPercentage = false;

	var taxAmount = 0.0;
	var taxPercentage = 0.0;
	var discountAmount = 0.0;
	var discountPercentage = 0.0;

	var subTotalAmount = 0.0;
	var totalAmount = 0.0;
	var totalPayment = 0.0;
	var hasPaymentRecord = false;

	if (billingObj != null) {
		//-----
		// #1. Calculate amounts from summation of each billing line object.
		$.each(billingObj.lineList, function(i, billingLineObj) {

			if (Cached_isDeletedBean(billingLineObj) == true)
				return true;

			if (billingLineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
				billingLineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
				billingLineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
				billingLineObj.itemTyoe == InventoryConstants.ITEM_TYPE_RAW) {
				// Re-calculate amounts inside billing line
				billingCommon_calculateBillingLine(billingLineObj);

				// Add amounts from billing line to billing object.
				discountAmount += billingLineObj.discountAmount;
				discountPercentage += billingLineObj.discountPercentage;
				taxAmount += billingLineObj.taxAmount;
				taxPercentage += billingLineObj.taxPercentage;
				// Price (Exclude Tax only)
				subTotalAmount += (billingLineObj.billableAmount) * billingLineObj.quantity;

				// Set first tax percentage
				if (uniqueTaxPercentage == 0)
					uniqueTaxPercentage = billingLineObj.taxPercentage;
				if (uniqueTaxPercentage != billingLineObj.taxPercentage)
					hasMultipleTaxPercentage = true;
			}
		});

		billingObj.subTotalAmount = tycheesMath_round(subTotalAmount, 2);

		//-----
		// #2. Handle Level 1 DISCOUNT-typed billing item.
		$.each(billingObj.lineList, function(i, billingLineObj) {

			if (Cached_isDeletedBean(billingLineObj) == true)
				return true;

			if (billingLineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
				var amount = billingCommon_calculateBillingLine_discountType(billingLineObj);
				l1_discountAmount += amount;
			}
		});

		// #2.1. Deduct from discount (if any)
		if (l1_discountAmount == 0)
			totalAmount = subTotalAmount + taxAmount;
		else {
			subTotalAmount = subTotalAmount - l1_discountAmount;

			taxAmount = subTotalAmount * (uniqueTaxPercentage / 100);
			totalAmount = subTotalAmount + taxAmount;
		}

		//-----
		// #3. Handle Level 1 TAX-typed billing item
		/*$.each(billingObj.lineList, function(i, billingLineObj) {

			if (Cached_isDeletedBean(billingLineObj) == true)
				return true;

			if (billingLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
				var amount = billingCommon_calculateBillingLine_taxType(billingLineObj);
				l1_taxAmount += amount;
			}
		});*/

		// #3.1. Add taxes (if any)
		//totalAmount = totalAmount + l1_taxAmount;

		//-----
		// #4. Calculate payment(s), if any.
		$.each(billingObj.paymentList, function(i, paymentObj) {

			if (Cached_isDeletedBean(paymentObj) == true)
				return true;

			if (paymentObj.status == 'void')
				return true;
			
			hasPaymentRecord = true;

			// if changeAmount is ZERO or NEGATIVE
			if (paymentObj.changeAmount <= 0)
				totalPayment += paymentObj.payingAmount;
			// if changeAmount is POSITIVE
			else
				totalPayment += (paymentObj.payingAmount - paymentObj.changeAmount);
		});
	} // .end of if	

	totalAmount = tycheesMath_round(totalAmount, 2);
	totalPayment = tycheesMath_round(totalPayment, 2);
	
	//----
	// #5. Create associated workflow event, if any.
	if (billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_PAID || billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_OVERPAID) {
		
	} else {
		
		if (billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_NEW) {
			// Get billing workflow object
			var billingWorkflowObj;
			$.each(billingObj.workflowList, function(i, workflowObj) {
				if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
					billingWorkflowObj = workflowObj;
			});

			if (billingWorkflowObj == null) {
				billingWorkflowObj = createNew_BillingWorkflow();
				billingWorkflowObj.billingId = billingObj.id;
				billingWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
				billingWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
				billingObj.workflowList.push(billingWorkflowObj);
			} else {
				billingWorkflowObj.hasChanged = true;
			}
			
			// Create new workflow event (deleted)
			var workflowEventObj = createNew_BillingWorkflowEvent();
			workflowEventObj.workflowId = billingWorkflowObj.id;
			workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
			workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
			workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
			workflowEventObj.eventDescription = "Billing is open and unpaid.";
			workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
			workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
			billingWorkflowObj.eventList.push(workflowEventObj);

			// Set billing state
			billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_OPEN;
			billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_OPEN;
		} else {
		
			if (hasPaymentRecord) {
				
				if (totalPayment > totalAmount) {
					billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_OVERPAID;
					billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_OVERPAID;
					
					// Get billing workflow object
					var billingWorkflowObj;
					$.each(billingObj.workflowList, function(i, workflowObj) {
						if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
							billingWorkflowObj = workflowObj;
					});
			
					if (billingWorkflowObj == null) {
						billingWorkflowObj = createNew_BillingWorkflow();
						billingWorkflowObj.billingId = billingObj.id;
						billingWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
						billingWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
						billingObj.workflowList.push(billingWorkflowObj);
					} else {
						billingWorkflowObj.hasChanged = true;
					}
					
					// Create new workflow event (deleted)
					var workflowEventObj = createNew_BillingWorkflowEvent();
					workflowEventObj.workflowId = billingWorkflowObj.id;
					workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
					workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_OVERPAID;
					workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_OVERPAID;
					workflowEventObj.eventDescription = 'BILLING FULLY PAID.';
					workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
					workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
					billingWorkflowObj.eventList.push(workflowEventObj);
				}
				
				if (totalPayment == totalAmount) {
					billingObj.state = BillingConstants.WORKFLOW_EVENTKEY_PAID;
					billingObj.stateDesc = BillingConstants.WORKFLOW_EVENTDESC_PAID;
			
					// Get billing workflow object
					var billingWorkflowObj;
					$.each(billingObj.workflowList, function(i, workflowObj) {
						if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
							billingWorkflowObj = workflowObj;
					});
	
					if (billingWorkflowObj == null) {
						billingWorkflowObj = createNew_BillingWorkflow();
						billingWorkflowObj.billingId = billingObj.id;
						billingWorkflowObj.moduleId = ModuleConstants.MODULE_BILLING;
						billingWorkflowObj.subModuleId = ModuleConstants.MODULE_BILLING_SUB_WORKFLOW;
						billingObj.workflowList.push(billingWorkflowObj);
					} else {
						billingWorkflowObj.hasChanged = true;
					}
					
					// Create new workflow event (deleted)
					var workflowEventObj = createNew_BillingWorkflowEvent();
					workflowEventObj.workflowId = billingWorkflowObj.id;
					workflowEventObj.seqno = billingWorkflowObj.eventList.length + 1;
					workflowEventObj.eventKey = BillingConstants.WORKFLOW_EVENTKEY_PAID;
					workflowEventObj.eventTitle = BillingConstants.WORKFLOW_EVENTDESC_PAID;
					workflowEventObj.eventDescription = 'BILLING FULLY PAID.';
					workflowEventObj.trackedOn = tycheesDateTime_getCurrentTimeInMillis();
					workflowEventObj.trackedBy = tycheesCommon_getCurrentUserId();
					billingWorkflowObj.eventList.push(workflowEventObj);
				}
			}
		}
	}
	
	//-----
	// #6. Update calculated amounts into billing object.
	billingObj.taxAmount = tycheesMath_round(taxAmount, 2);
	billingObj.taxPercentage = tycheesMath_round(taxPercentage, 2);
	billingObj.discountAmount = tycheesMath_round(discountAmount, 2);
	billingObj.discountPercentage = tycheesMath_round(discountPercentage, 2);
	billingObj.subTotalAmount = tycheesMath_round(subTotalAmount, 2);
	billingObj.totalAmount = tycheesMath_round(totalAmount, 2);
	billingObj.totalPayment = tycheesMath_round(totalPayment, 2);
	
	// #7. Round off total amount, if required
	var roundToMultipleFive = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_ROUND_TO_MULTIPLE_FIVE); 
	if (roundToMultipleFive != null && roundToMultipleFive.propValue=='true') {
		
		var totalAmountInText = Number(billingObj.totalAmount * 100).toFixed(0);
		var lastIndex = totalAmountInText.length - 1;		
		
		if (totalAmountInText.charAt(lastIndex) == '0' || 
			totalAmountInText.charAt(lastIndex) == '1' ||  
			totalAmountInText.charAt(lastIndex) == '2' ||
			totalAmountInText.charAt(lastIndex) == '8' ||
			totalAmountInText.charAt(lastIndex) == '9')
			totalAmountInText = totalAmountInText.substr(0, lastIndex) + '0';
		
		if (totalAmountInText.charAt(lastIndex) == '3' || 
			totalAmountInText.charAt(lastIndex) == '4' || 
			totalAmountInText.charAt(lastIndex) == '5' || 
			totalAmountInText.charAt(lastIndex) == '6' || 
			totalAmountInText.charAt(lastIndex) == '7' )
			totalAmountInText = totalAmountInText.substr(0, lastIndex) + '5';
		
		var totalAmountInNum = Number(totalAmountInText) / 100;
		var roundOffAmount = tycheesMath_round(billingObj.totalAmount - totalAmountInNum, 2);
		
		billingObj.roundOffAmount = roundOffAmount;
		billingObj.totalAmount = billingObj.totalAmount - billingObj.roundOffAmount;
	}
	
} // .end of billingCommon_calculateBilling

/**
 * Calculate amounts of billing line.
 *  
 * @param	{BillingLineBean} billingLineObj - billing line object.
 */
function billingCommon_calculateBillingLine(billingLineObj) {
	if (billingLineObj == null) {
		tycheesLogger_showToast('error', 'Invalid Billing Line', 'Billing line object is null.');
		return false;
	}

	if (billingLineObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
		billingLineObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
		billingLineObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
		billingLineObj.itemType == InventoryConstants.ITEM_TYPE_RAW) {
		// Calculation begins.
		billingCommon_calculateBillingLine_stepOne(billingLineObj);
		return false;
	}

	if (billingLineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
		billingCommon_calculateBillingLine_discountType(billingLineObj);
		return false;
	}
} // .end of billingCommon_calculateBillingLine

function billingCommon_calculateBillingLine_discountType(billingLineObj) {
	if (billingLineObj.itemType != InventoryConstants.ITEM_TYPE_DISCOUNT)
		return 0;
	// Only for Discount item at Level 1
	if (billingLineObj.parentLineId != '')
		return 0;

	var discountPercentage = billingLineObj.discountPercentage;
	var discountAmount = billingLineObj.discountAmount;

	if (billingLineObj.taxDiscountInPercentage) {
		if (billingLineObj.unitPriceSource == 'default')
			discountPercentage = billingLineObj.defaultUnitPrice;
		if (billingLineObj.unitPriceSource == 'compound')
			discountPercentage = billingLineObj.compoundUnitPrice;
		if (billingLineObj.unitPriceSource == 'custom')
			discountPercentage = billingLineObj.customUnitPrice;

		discountAmount = (global_billingObj.subTotalAmount * (discountPercentage / 100));
	}
	if (billingLineObj.taxDiscountInAmount) {
		if (billingLineObj.unitPriceSource == 'default')
			discountAmount = billingLineObj.defaultUnitPrice;
		if (billingLineObj.unitPriceSource == 'compound')
			discountAmount = billingLineObj.compoundUnitPrice;
		if (billingLineObj.unitPriceSource == 'custom')
			discountAmount = billingLineObj.customUnitPrice;
	}

	billingLineObj.hasChanged = true;
	billingLineObj.discountPercentage = tycheesMath_round(discountPercentage, 2);
	billingLineObj.discountAmount = tycheesMath_round(discountAmount, 2);

	return billingLineObj.discountAmount;
} // .end of billingCommon_calculateBillingLine_discountType

function billingCommon_calculateBillingLine_taxType(billingLineObj) {

	if (billingLineObj.itemType != InventoryConstants.ITEM_TYPE_TAX)
		return 0;
	// Only for Tax item at Level 1
	if (billingLineObj.parentLineId != '')
		return 0;

	var taxPercentage = billingLineObj.taxPercentage;
	var taxAmount = billingLineObj.taxAmount;

	if (billingLineObj.taxDiscountInAmount) {
		// tax amount stay the same
		if (billingLineObj.unitPriceSource == 'default')
			taxAmount = billingLineObj.defaultUnitPrice;
		if (billingLineObj.unitPriceSource == 'compound')
			taxAmount = billingLineObj.compoundUnitPrice;
		if (billingLineObj.unitPriceSource == 'custom')
			taxAmount = billingLineObj.customUnitPrice;
	}
	if (billingLineObj.taxDiscountInPercentage) {
		if (billingLineObj.unitPriceSource == 'default')
			taxPercentage = billingLineObj.defaultUnitPrice;
		if (billingLineObj.unitPriceSource == 'compound')
			taxPercentage = billingLineObj.compoundUnitPrice;
		if (billingLineObj.unitPriceSource == 'custom')
			taxPercentage = billingLineObj.customUnitPrice;

		if (billingLineObj.taxInclusive == true) {
			var taxInDecimal = Number(billingLineObj.taxPercentage) / 100;
			var calculatedTaxAmount = Number(global_billingObj.subTotalAmount) - (Number(global_billingObj.subTotalAmount) / (taxInDecimal + 1));
			taxAmount = Math.round(calculatedTaxAmount * 100) / 100;
		}
		else {
			var calculatedTaxAmount = Number(global_billingObj.subTotalAmount) * (Number(billingLineObj.taxPercentage) / 100);
			taxAmount = Math.round(calculatedTaxAmount * 100) / 100;
		}
	}

	billingLineObj.hasChanged = true;
	billingLineObj.taxPercentage = tycheesMath_round(taxPercentage, 2);
	billingLineObj.taxAmount = tycheesMath_round(taxAmount, 2);

	return billingLineObj.taxAmount;
} // .end of billingCommon_calculateBillingLine_taxType

/**
 * Calculate amounts of billing line.
 * - Process all item types, except TAX.
 * 
 * @param	{BillingLineBean} billingLineObj Ref to billing line object.
 */
function billingCommon_calculateBillingLine_stepOne(billingLineObj) {

	var billingLine_unitPrice = billingLineObj.defaultUnitPrice;
	if (billingLineObj.unitPriceSource == 'compound')
		billingLine_unitPrice = billingLineObj.compoundUnitPrice;
	if (billingLineObj.unitPriceSource == 'custom')
		billingLine_unitPrice = billingLineObj.customUnitPrice;

	var totalExclusiveTaxAmount = 0;
	var totalDiscountAmount = 0;
	var totalDiscountPercentage = 0;
	var totalCompoundUnitCost = 0;
	var totalCompoundUnitPrice = 0;

	// Check if this item is tax-inclusive
	// IF yes, then recalculate the billable amount of this item line
	$.each(billingLineObj.lineList, function(i, childLineObj) {
		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
			if (childLineObj.taxInclusive) {
				var taxInDecimal = Number(childLineObj.taxPercentage) / 100;
				var taxAmount = Number(billingLine_unitPrice) - (Number(billingLine_unitPrice) / (taxInDecimal + 1));
				var roundedTaxAmount = Math.round(taxAmount * 100) / 100;

				billingLine_unitPrice = billingLine_unitPrice - roundedTaxAmount;
			}
		}
	});

	// Mandatory Components
	$.each(billingLineObj.lineList, function(i, childLineObj) {

		if (Cached_isDeletedBean(childLineObj) == true)
			return true;
		if (childLineObj.mandatory == false)
			return true;

		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
			// Process Tax item(s) in step 2 later.
		}
		else
		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
			if (childLineObj.taxDiscountInAmount) {
				totalDiscountAmount += childLineObj.discountAmount;
			}

			if (childLineObj.taxDiscountInPercentage) {
				totalDiscountPercentage += Number(childLineObj.discountPercentage);

				var calculatedDiscountAmount = Number(billingLine_unitPrice * billingLineObj.quantity) * (childLineObj.discountPercentage / 100);
				var roundedDiscountAmount = Math.round(calculatedDiscountAmount * 100) / 100;
				totalDiscountAmount += Number(roundedDiscountAmount);
			}
		}
		else {
			// ITEM TYPE: Product, Service, Event, Raw
			var roundedUnitCost = Math.round(childLineObj.unitCost * childLineObj.quantity * 100) / 100;
			totalCompoundUnitCost += roundedUnitCost;

			var roundedUnitPrice = Math.round(childLineObj.unitPrice * childLineObj.quantity * 100) / 100;
			totalCompoundUnitPrice += roundedUnitPrice;
		}
	});

	// Non-Mandatory Components
	$.each(billingLineObj.lineList, function(i, childLineObj) {

		if (Cached_isDeletedBean(childLineObj) == true)
			return true;
		if (childLineObj.mandatory == true)
			return true;

		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
			// Do nothing here, process TAX in step two later.
		}
		else
		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
			if (childLineObj.taxDiscountInAmount) {
				totalDiscountAmount += childLineObj.discountAmount;
			}

			if (childLineObj.taxDiscountInPercentage) {
				totalDiscountPercentage += Number(childLineObj.discountPercentage);

				var calculatedDiscountAmount = Number(billingLine_unitPrice * billingLineObj.quantity) * (childLineObj.discountPercentage / 100);
				var roundedDiscountAmount = Math.round(calculatedDiscountAmount * 100) / 100;
				totalDiscountAmount += Number(roundedDiscountAmount);
			}
		}
		else {
			// ITEM TYPE: Product, Service, Event, Raw
			var roundedUnitCost = Math.round(childLineObj.unitCost * childLineObj.quantity * 100) / 100;
			totalCompoundUnitCost += roundedUnitCost;

			var roundedUnitPrice = Math.round(childLineObj.unitPrice * childLineObj.quantity * 100) / 100;
			totalCompoundUnitPrice += roundedUnitPrice;
		}
	}); // .end of Non-Mandatory Components


	billingLineObj.hasChanged = true;
	
	// Summary of value
	billingLineObj.discountAmount = tycheesMath_round(totalDiscountAmount, 2);
	billingLineObj.discountPercentage = tycheesMath_round(totalDiscountPercentage, 2);
	// Add up unit price with total taxable amount.
	billingLineObj.billableAmount = tycheesMath_round(Number(billingLine_unitPrice) - Number(totalDiscountAmount), 2);
	// Total compound cost/price from containing items
	billingLineObj.compoundUnitCost = tycheesMath_round(totalCompoundUnitCost, 2);
	billingLineObj.compoundUnitPrice = tycheesMath_round(totalCompoundUnitPrice, 2);

	// Continue Tax Calculation in Step 2
	billingCommon_calculateBillingLine_stepTwo(billingLineObj);
} // .end of billingCommon_calculateBillingLine_stepOne

/**
 * Calculate amounts of billing line with tax
 * - Process only item with type TAX.
 * 
 * @param {BillingLineBean} billingLineObj - billing line object.
 */
function billingCommon_calculateBillingLine_stepTwo(billingLineObj) {

	var billingLine_unitPrice = billingLineObj.billableAmount;
	var totalInclusiveTaxAmount = 0;
	var totalExclusiveTaxAmount = 0;
	var totalTaxPercentage = 0;

	// Mandatory Components
	$.each(billingLineObj.lineList, function(i, childLineObj) {

		if (Cached_isDeletedBean(childLineObj) == true)
			return true;
		if (childLineObj.mandatory == true)
			return true;
		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {

			totalTaxPercentage += Number(childLineObj.taxPercentage);
			// Calculate tax by using exclusive method
			var taxAmount = Number(billingLine_unitPrice * billingLineObj.quantity) * (Number(childLineObj.taxPercentage) / 100);
			var roundedTaxAmount = Math.round(taxAmount * 100) / 100;
			totalExclusiveTaxAmount += Number(roundedTaxAmount);
		}
	}); // .end of Non-Mandatory Components

	// Non-Mandatory Components
	$.each(billingLineObj.lineList, function(i, childLineObj) {

		if (Cached_isDeletedBean(childLineObj) == true)
			return true;
		if (childLineObj.mandatory == false)
			return true;
		if (childLineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {

			totalTaxPercentage += Number(childLineObj.taxPercentage);
			// Calculate tax by using exclusive method
			var taxAmount = Number(billingLine_unitPrice * billingLineObj.quantity) * (Number(childLineObj.taxPercentage) / 100);
			var roundedTaxAmount = Math.round(taxAmount * 100) / 100;
			totalExclusiveTaxAmount += Number(roundedTaxAmount);
		}
	}); // .end of Non-Mandatory Components

	billingLineObj.hasChanged = true;
	
	// Summary of value
	billingLineObj.taxAmount = tycheesMath_round(totalExclusiveTaxAmount + totalInclusiveTaxAmount, 2);
	billingLineObj.taxPercentage = tycheesMath_round(totalTaxPercentage, 2);
} // .end of billingCommon_calculateBillingLine_stepTwo

function billingCommon_openBilling(billingId, callbackFn) {
	
	var currentPageUrl = window.location.pathname;

	if (currentPageUrl.indexOf('billing') >= 0) {
		var requestBody = {
			'appName': APP_NAME_ALL,
			'billingId': billingId,
			'fullBean': true	
		};	

		var params = new Object();
		params.billingId = billingId;
		params.callbackFn = callbackFn;
		// Ajax call to get full bean of billing
		tycheesdb_api_getBillingById(requestBody, billingCommon_openBilling_postHandler, params);
	}
	else {
		// Set billing ID to localstorage
		localStorage.setItem(OPEN_FROM_SEARCH_BILLING_ID, billingId);
		// Go to POS page
		var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING);
		window.open(location, '_self');
	}
} // .end of billingCommon_openBilling

function billingCommon_openBilling_postHandler(success, responseObj, params) {
	if (success==false)
		return false;
	
	if (responseObj.billingObj != null) {
		// Assign objects to global scope
		global_billingObj = responseObj.billingObj;		
		// Update page UI
		bil001_show();
	} else {
		tycheesLogger_showToast("error", "Error", "Invalid billing object found.")
	}
} // .end of billingCommon_openBilling_postHandler

