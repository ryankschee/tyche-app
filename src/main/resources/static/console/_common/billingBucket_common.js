/**
 * Create new bucket line object, from itemObj, into bucketObj.
 * 
 * @param   {BillingBucketBean} billingBucketObj - billing bucket object
 * @param	{ItemBean} itemObj - item object
 * @return	{BillingBucketLineBean} - billing bucket line object
 */
function billingBucketCommon_createBillingBucketLine(p_billingBucketObj, p_itemObj) {
	if (p_billingBucketObj == null || p_itemObj == null)
		return null;

	var defaultMinUnit = 1;
	var bucketLineObj = createNew_BillingBucketLine();
	bucketLineObj.bucketId = p_billingBucketObj.id;
	bucketLineObj.itemId = p_itemObj.id;
	bucketLineObj.itemName = p_itemObj.name;
	bucketLineObj.itemType = p_itemObj.itemType;
	bucketLineObj.itemGroupName = p_itemObj.groupName;
	bucketLineObj.itemLabels = p_itemObj.labels;
	bucketLineObj.itemImageUrl = p_itemObj.imageUrl;
	bucketLineObj.rowId = tycheesCommon_generateUUID();
	bucketLineObj.quantity = Number(defaultMinUnit);
	bucketLineObj.quantityOptional = p_itemObj.quantityOptional;
	bucketLineObj.unitPriceSource = 'default';
	bucketLineObj.mandatory = false;
	bucketLineObj.ignored = false;
	bucketLineObj.remarks = '';

	if (p_itemObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
		p_itemObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
		p_itemObj.itemType == InventoryConstants.ITEM_TYPE_EVENT ||
		p_itemObj.itemType == InventoryConstants.ITEM_TYPE_RAW) {

		bucketLineObj.taxInclusive = false;
		bucketLineObj.taxDiscountInPercentage = false;
		bucketLineObj.taxDiscountInAmount = false;
		bucketLineObj.taxAmount = 0;
		bucketLineObj.taxPercentage = 0;
		bucketLineObj.discountAmount = 0;
		bucketLineObj.discountPercentage = 0;
		bucketLineObj.itemPrice = Number(p_itemObj.unitPrice);
		bucketLineObj.billableAmount = Number(p_itemObj.unitPrice);
		bucketLineObj.defaultUnitPrice = p_itemObj.unitPrice;
		bucketLineObj.compoundUnitPrice = 0;
		bucketLineObj.customUnitPrice = 0;
	}
	else
	if (p_itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {

		bucketLineObj.itemPrice = 0;
		bucketLineObj.billableAmount = 0;
		bucketLineObj.taxInclusive = p_itemObj.taxInclusive;

		if (p_itemObj.taxDiscountPercentage > 0) {
			bucketLineObj.taxDiscountInPercentage = true;
			bucketLineObj.taxDiscountInAmount = false;
			bucketLineObj.taxAmount = 0;
			bucketLineObj.taxPercentage = p_itemObj.taxDiscountPercentage;
			bucketLineObj.discountAmount = 0;
			bucketLineObj.discountPercentage = 0;
			bucketLineObj.defaultUnitPrice = p_itemObj.taxDiscountPercentage;
			bucketLineObj.compoundUnitPrice = 0;
			bucketLineObj.customUnitPrice = 0;
		}
		if (p_itemObj.taxDiscountAmount > 0) {
			bucketLineObj.taxDiscountInPercentage = false;
			bucketLineObj.taxDiscountInAmount = true;
			bucketLineObj.taxAmount = p_itemObj.taxDiscountAmount;
			bucketLineObj.taxPercentage = 0;
			bucketLineObj.discountAmount = 0;
			bucketLineObj.discountPercentage = 0;
			bucketLineObj.defaultUnitPrice = p_itemObj.taxDiscountAmount;
			bucketLineObj.compoundUnitPrice = 0;
			bucketLineObj.customUnitPrice = 0;
		}
	}
	else
	if (p_itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {

		bucketLineObj.itemPrice = 0;
		bucketLineObj.billableAmount = 0;
		bucketLineObj.taxInclusive = false;

		if (p_itemObj.taxDiscountPercentage > 0) {
			bucketLineObj.taxDiscountInPercentage = true;
			bucketLineObj.taxDiscountInAmount = false;
			bucketLineObj.taxAmount = 0;
			bucketLineObj.taxPercentage = 0;
			bucketLineObj.discountAmount = 0;
			bucketLineObj.discountPercentage = p_itemObj.taxDiscountPercentage;
			bucketLineObj.defaultUnitPrice = p_itemObj.taxDiscountPercentage;
			bucketLineObj.compoundUnitPrice = 0;
			bucketLineObj.customUnitPrice = 0;
		}
		if (p_itemObj.taxDiscountAmount > 0) {
			bucketLineObj.taxDiscountInPercentage = false;
			bucketLineObj.taxDiscountInAmount = true;
			bucketLineObj.taxAmount = 0;
			bucketLineObj.taxPercentage = 0;
			bucketLineObj.discountAmount = p_itemObj.taxDiscountAmount;
			bucketLineObj.discountPercentage = 0;
			bucketLineObj.defaultUnitPrice = p_itemObj.taxDiscountAmount;
			bucketLineObj.compoundUnitPrice = 0;
			bucketLineObj.customUnitPrice = 0;
		}
	}

	// Return newly created billingLine.
	return bucketLineObj;
} // .end of billingBucketCommon_createBillingBucketLine

/**
 * Create new billing line object, from itemObj, into billingObj.
 * 
 * @param   {BillingBean} billingObj - billing object
 * @param	{ItemBean} itemObj - item object
 * @return	{BillingLineBean} - billing line object
 */
function billingBucketCommon_createBillingLine(billingObj, bucketLineObj) {
	if (billingObj == null || bucketLineObj == null)
		return null;

	var billingLineObj = createNew_BillingLine();
	billingLineObj.billingId = billingObj.id;
	billingLineObj.parentLineId = bucketLineObj.parentLineId;
	billingLineObj.componentId = bucketLineObj.componentId;
	billingLineObj.itemId = bucketLineObj.itemId;
	billingLineObj.itemName = bucketLineObj.itemName;
	billingLineObj.itemType = bucketLineObj.itemType;
	billingLineObj.itemGroupName = bucketLineObj.itemGroupName;
	billingLineObj.itemImageUrl = bucketLineObj.itemImageUrl;
	billingLineObj.rowId = bucketLineObj.rowId;
	billingLineObj.selected = bucketLineObj.selected;
	billingLineObj.mandatory = bucketLineObj.mandatory;
	billingLineObj.ignored = bucketLineObj.ignored;
	billingLineObj.quantity = bucketLineObj.quantity;
	billingLineObj.quantityOptional = bucketLineObj.quantityOptional;
	billingLineObj.unitPriceSource = bucketLineObj.unitPriceSource;
	billingLineObj.defaultUnitPrice = bucketLineObj.defaultUnitPrice;
	billingLineObj.compoundUnitPrice = bucketLineObj.compoundUnitPrice;
	billingLineObj.customUnitPrice = bucketLineObj.customUnitPrice;
	billingLineObj.compoundUnitCost = bucketLineObj.compoundUnitCost;
	billingLineObj.itemUnitPrice = bucketLineObj.itemUnitPrice;
	billingLineObj.billableAmount = bucketLineObj.billableAmount;
	billingLineObj.taxInclusive = bucketLineObj.taxInclusive;
	billingLineObj.taxDiscountInPercentage = bucketLineObj.taxDiscountInPercentage;
	billingLineObj.taxDiscountInAmount = bucketLineObj.taxDiscountInAmount;
	billingLineObj.taxAmount = bucketLineObj.taxAmount;
	billingLineObj.taxPercentage = bucketLineObj.taxPercentage;
	billingLineObj.discountAmount = bucketLineObj.discountAmount;
	billingLineObj.discountPercentage = bucketLineObj.discountPercentage;
	billingLineObj.remarks = bucketLineObj.remarks;

	if (bucketLineObj.lineList != null) {
		$.each(bucketLineObj.lineList, function(i, childBucketLineObj) {
			var childBillingLineObj = billingBucketCommon_createBillingLine(billingObj, childBucketLineObj);
			billingLineObj.lineList.push(childBillingLineObj);
		});
	}

	// Calculate billing line, based on current settings. 
	billingCommon_calculateBillingLine(billingLineObj);

	// Return newly created billingLine.
	return billingLineObj;
} // .end of billingBucketCommon_createBillingLine
