//function inventoryController_

/**
 * Apply transaction change(s) into inventory set's quantity.
 * Transaction <--> Inventory Item 
 * 
 * @pi_transactionObj	ref to transaction object
 * @return				status of transaction (true or false)
 */
function applyChanges(pi_transactionObj, pi_billingObj) {
	if (pi_transactionObj.executed == true)
		return false;

	var updatedItemList = [];
	var subtotal = 0;
	var tax = 0;
	var discount = 0;

	//console.log('applyChanges >> BEGIN 001-----------------------------------');
	//console.log('applyChanges >> pi_transactionObj.type=' + pi_transactionObj.type);

	$.each(pi_transactionObj.lineList, function(i, lineObj) {

		var itemObj = Cached_getItemById(lineObj.itemId);
		if (itemObj == null)
			return true;

		var skipThisLine = false;
		if (itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT ||
			itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX)
			skipThisLine = true;

		//console.log('applyChanges >> lineObj.itemId=' + lineObj.itemId);
		//console.log('applyChanges >> itemObj.name=' + itemObj.name);
		//console.log('applyChanges >> itemObj.itemType=' + itemObj.itemType);
		//console.log('applyChanges >> skipThisLine=' + skipThisLine);
		//console.log('applyChanges >> lineObj.operator=' + lineObj.operator);

		if (skipThisLine == false) {
			if (lineObj.operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD) {
				if (itemObj == null) {
					tycheesLogger_showToast('error', 'Error', '[applyChanges] Unidentified item id (' + lineObj.itemId + ')');
					return false;
				}

				itemObj.quantity = itemObj.quantity + Number(lineObj.quantity);

				helper_pushItemToDistinctList(updatedItemList, itemObj);

				subtotal = subtotal + (lineObj.quantity * lineObj.unitPrice);
			}
			else
			if (lineObj.operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB) {
				if (itemObj == null) {
					tycheesLogger_showToast('error', 'Error', '[applyChanges] Unidentified item id (' + lineObj.itemId + ')');
					return false;
				}

				itemObj.quantity = itemObj.quantity - Number(lineObj.quantity);

				helper_pushItemToDistinctList(updatedItemList, itemObj);

				subtotal = subtotal + (lineObj.quantity * lineObj.unitPrice);
			}
			else {
				tycheesLogger_showToast('error', 'Error', '[applyChanges] Unidentified operator (' + lineObj.operator + ')');
			}
		}
	});

	// Special Handling for BILLING type
	if (pi_transactionObj.type == InventoryConstants.TRANSACTION_TYPE_BILLING) {

		var billingObj;
		if (pi_billingObj != null)
			billingObj = pi_billingObj;
		else
			billingObj = Cached_getBillingById(pi_transactionObj.thirdPartyId);

		if (billingObj != null) {
			$.each(billingObj.lineList, function(i, level1_lineObj) {

				$.each(level1_lineObj.lineList, function(j, level2_lineObj) {

					var itemObj = Cached_getItemById(level2_lineObj.itemId);
					if (itemObj == null)
						return true;

					var skipThisLine = false;
					if (itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT || itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX)
						skipThisLine = true;

					if (skipThisLine == false) {
						if (itemObj == null) {
							tycheesLogger_showToast('error', 'Error', '[applyChanges] Unidentified item id (' + level2_lineObj.itemId + ')');
							return false;
						}

						itemObj.quantity = itemObj.quantity - Number(level2_lineObj.quantity);

						helper_pushItemToDistinctList(updatedItemList, itemObj);

						subtotal = subtotal + (level2_lineObj.quantity * level2_lineObj.customUnitPrice);
					}
				});
			});
		}
	}

	// Set executed status
	pi_transactionObj.executed = true;
	pi_transactionObj.subTotalAmount = subtotal;
	pi_transactionObj.taxAmount = tax;
	pi_transactionObj.discountAmount = discount;
	pi_transactionObj.totalAmount = subtotal + tax - discount;

	//console.log('applyChanges >> END ----------------------------------------');

	return updatedItemList;
} // .end of applyChanges

/*******************************************************************************
 * Revert transaction change(s) from inventory set's quantity.
 * Transaction <--> Inventory Item 
 * 
 * @pi_transactionObj	ref to transaction object
 * @return				status of transaction (true or false)
 * 
 * Change Logs
 * -----------
 * 20160805 Ryan Chee	Initial
 */
function revertChanges(pi_transactionObj, pi_billingObj) {

	if (pi_transactionObj.executed == false)
		return false;

	var updatedItemList = [];
	var subtotal = 0;
	var tax = 0;
	var discount = 0;

	$.each(pi_transactionObj.lineList, function(i, lineObj) {
		var itemObj = Cached_getItemById(lineObj.itemId);
		if (itemObj == null)
			return true;

		if (lineObj.operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD) {
			if (itemObj == null) {
				tycheesLogger_showToast('error', 'Error', '[revertChanges] Unidentified item id (' + lineObj.itemId + ')');
				return false;
			}

			itemObj.quantity = itemObj.quantity - Number(lineObj.quantity);

			helper_pushItemToDistinctList(updatedItemList, itemObj);

			subtotal = subtotal + (lineObj.quantity * lineObj.unitPrice);
		}
		else
		if (lineObj.operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB) {
			if (itemObj == null) {
				tycheesLogger_showToast('error', 'Error', '[revertChanges] Unidentified item id (' + lineObj.itemId + ')');
				return false;
			}

			itemObj.quantity = itemObj.quantity + Number(lineObj.quantity);

			helper_pushItemToDistinctList(updatedItemList, itemObj);

			subtotal = subtotal + (lineObj.quantity * lineObj.unitPrice);
		}
		else {
			console.log('[revertChanges] Unidentified operator (' + lineObj.operator + ')');
			tycheesLogger_showToast('error', 'Error', '[revertChanges] Unidentified operator (' + lineObj.operator + ')');
		}
	});

	// Special Handling for BILLING type
	if (pi_transactionObj.type == InventoryConstants.TRANSACTION_TYPE_BILLING) {

		var billingObj;
		if (pi_billingObj != null)
			billingObj = pi_billingObj;
		else
			billingObj = Cached_getBillingById(pi_transactionObj.thirdPartyId);

		if (billingObj != null) {
			$.each(billingObj.lineList, function(i, level1_lineObj) {

				$.each(level1_lineObj.lineList, function(j, level2_lineObj) {
					var itemObj = Cached_getItemById(level2_lineObj.itemId);
					if (itemObj == null)
						return true;

					itemObj.quantity = itemObj.quantity + Number(level2_lineObj.quantity);

					helper_pushItemToDistinctList(updatedItemList, itemObj);

					subtotal = subtotal + (level2_lineObj.quantity * level2_lineObj.customUnitPrice);
				});

			});
		}
	}

	// Set executed status
	pi_transactionObj.executed = false;
	pi_transactionObj.subTotalAmount = subtotal;
	pi_transactionObj.taxAmount = tax;
	pi_transactionObj.discountAmount = discount;
	pi_transactionObj.totalAmount = subtotal + tax - discount;

	return updatedItemList;
} // .end of revertChanges

/*******************************************************************************
 * Helper function, to add item into list distinctly (no repeat item with same 
 * id).
 * 
 * @po_saveList			ref to array list
 * @pi_itemObj			item object
 * @return				nil
 * 
 * Change Logs
 * -----------
 * 20160805 Ryan Chee	Initial
 */
function helper_pushItemToDistinctList(po_saveList, pi_itemObj) {

	var found = false;
	$.each(po_saveList, function(i, saveObj) {
		if (saveObj.id == pi_itemObj.id)
			found = true;
	});

	if (found == false)
		po_saveList.push(pi_itemObj);
} // .end of helper_pushItemToDistinctList

/*******************************************************************************
 * Update change(s) of item's quantity into transaction object.
 * Billing <--> Transaction
 * 
 * @pi_itemId			item ID
 * @pi_operator			range of value {OP_ADD, OP_SUB}
 * @pi_changeVal		numeric value represents quantity changed.
 * @po_transactionObj   ref to transaction object.
 * 
 * Change Logs
 * -----------
 * 20160805 Ryan Chee	Initial
 */
function updateTransaction_fromBilling(pi_itemId, pi_operator, pi_changeVal, po_transactionObj) {
	var quantityVal = Number(pi_changeVal);
	var itemObj = Cached_getItemById(pi_itemId);
	var available = itemObj.availability;

	if (itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX || itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT)
		return false;

	if (quantityVal == NaN || quantityVal == 'NaN') {
		tycheesLogger_showToast('error', 'Input Validation Error', 'Invalid numeric variable found [' + pi_changeVal + '].');
		return false;
	}
	else
	if (quantityVal <= 0) {
		tycheesLogger_logInfo('1x pi_changeVal=' + pi_changeVal, 'updateTransaction_fromBilling');
		tycheesLogger_logInfo('2x quantityVal=' + quantityVal, 'updateTransaction_fromBilling');

		tycheesLogger_showToast('error', 'Input Validation Error', 'Invalid changed value found [' + pi_changeVal + ']. Must be minium zero (0).');
		return false;
	}
	else
	if (itemObj == null) {
		tycheesLogger_showToast('error', 'Input Validation Error', 'Invalid item ID found [' + pi_itemId + '].');
		return false;
	}
	else
	if (available == InventoryConstants.QUANTITY_NO_STOCK) {
		tycheesLogger_showToast('error', 'Input Validation Error', 'Item [' + pi_itemId + '] is not available for billing purpose.');
		return false;
	}
	else {
		// ADD item into inventory, by quantity 'changeVal'
		if (pi_operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD) {
			// Check if item has been added into transaction line.
			var transactionLineObj;
			$.each(po_transactionObj.lineList, function(i, lineObj) {
				if (itemObj.id == lineObj.itemId)
					transactionLineObj = lineObj;
			});

			// If item NOT in transaction
			if (transactionLineObj == null) {

				var unitPrice = itemObj.unitPrice;
				var totalAmount = quantityVal * unitPrice;

				// Create object OR reuse object
				transactionLineObj = createNew_InventoryTransactionLine();
				transactionLineObj.id = getNextTransactionId(InventoryConstants.TRANSACTION_TYPE_BILLING);
				transactionLineObj.transactionId = po_transactionObj.id;
				transactionLineObj.itemId = itemObj.id;
				transactionLineObj.itemSerialCode = itemObj.serialCode;
				transactionLineObj.description = itemObj.description;
				transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
				transactionLineObj.quantity = quantityVal;
				transactionLineObj.unitPrice = unitPrice;
				transactionLineObj.totalPrice = totalAmount;
				transactionLineObj.beanName = itemObj.name + ' [' + transactionLineObj.operator + ' ' + transactionLineObj.quantity + ']';
				transactionLineObj.remarks = '';

				// Add transaction line
				po_transactionObj.lineList.push(transactionLineObj);
			}
			else {
				if (transactionLineObj.operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD) {
					transactionLineObj.quantity = Number(transactionLineObj.quantity) + Number(quantityVal);
				}
				else {
					transactionLineObj.quantity = Number(transactionLineObj.quantity) - Number(quantityVal);
				}

				transactionLineObj.beanName = itemObj.name + ' [' + transactionLineObj.operator + ' ' + transactionLineObj.quantity + ']';

				// If no quantity change, means transaction can be void. 
				if (transactionLineObj.quantity == 0) {
					$.each(po_transactionObj.lineList, function(i, lineObj) {
						if (transactionLineObj.id == lineObj.id) {
							Cached_deleteBean(lineObj);
						}
					});
				}
			}
		}
		else
		if (pi_operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB) {
			// Condition: Item with child items, available and quantity is always 0.
			// Action: Do no substract quantity. 
			if (available == true && itemObj.quantity == 0) {

			}
			else {
				var transactionLineObj;
				$.each(po_transactionObj.lineList, function(i, lineObj) {
					if (itemObj.id == lineObj.itemId)
						transactionLineObj = lineObj;
				});

				if (transactionLineObj == null) {

					var unitPrice = itemObj.unitPrice;
					var totalAmount = quantityVal * unitPrice;

					// Create object OR reuse object
					transactionLineObj = createNew_InventoryTransactionLine();
					transactionLineObj.id = getNextTransactionId(InventoryConstants.TRANSACTION_TYPE_BILLING);
					transactionLineObj.transactionId = global_transactionObj.id;
					transactionLineObj.itemId = itemObj.id;
					transactionLineObj.itemSerialCode = itemObj.serialCode;
					transactionLineObj.description = itemObj.description;
					transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
					transactionLineObj.quantity = quantityVal;
					transactionLineObj.unitPrice = unitPrice;
					transactionLineObj.totalPrice = totalAmount;
					transactionLineObj.beanName = itemObj.name + ' [' + transactionLineObj.operator + ' ' + transactionLineObj.quantity + ']';
					transactionLineObj.remarks = '';

					po_transactionObj.lineList.push(transactionLineObj);
				}
				else {
					if (transactionLineObj.operator == InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD) {
						transactionLineObj.quantity = Number(transactionLineObj.quantity) - Number(quantityVal);
					}
					else {
						transactionLineObj.quantity = Number(transactionLineObj.quantity) + Number(quantityVal);
					}

					transactionLineObj.beanName = itemObj.name + ' [' + transactionLineObj.operator + ' ' + transactionLineObj.quantity + ']';

					// If no quantity change, means transaction can be void. 
					if (transactionLineObj.quantity == 0) {
						$.each(po_transactionObj.lineList, function(i, lineObj) {
							if (transactionLineObj.id == lineObj.id) {
								Cached_deleteBean(lineObj);
							}
						});
					}
				}
			}
		}
		else {
			tycheesLogger_showToast('error', 'Error', 'Invalid Operator found [' + pi_operator + '].');
			return false;
		}

		// Update amounts into transaction object
		var subTotalVal = 0.0;
		$.each(po_transactionObj.lineList, function(i, lineObj) {
			subTotalVal += lineObj.totalPrice;
		});
		po_transactionObj.subTotalAmount = subTotalVal;
		po_transactionObj.totalAmount = subTotalVal;

		return true;
	}
} // .end of updateTransaction_fromBilling

/*******************************************************************************
 * Delete item from transaction object (cache memory).
 * Billing <--> Transaction
 * 
 * @pi_itemId			item ID
 * @po_transactionObj   ref to transaction object.
 * 
 * Change Logs
 * -----------
 * 20160805 Ryan Chee	Initial
 */
function deleteTransaction_fromBilling(pi_itemId, po_transactionObj) {
	// Remove from InventoryTransactionBean's lineList
	$.each(po_transactionObj.lineList, function(index, lineObj) {
		if (lineObj.itemId == pi_itemId) {
			Cached_deleteBean(lineObj);

			return false;
		}
	});
} // .end of deleteTransaction_fromBilling
