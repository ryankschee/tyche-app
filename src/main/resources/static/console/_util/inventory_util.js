/**
 * Util function:
 * Return boolean TRUE if given categoryObj is root system category; 
 * otherwise, return boolean FALSE.
 * 
 * @param   {InventoryCategoryBean} categoryObj - Category object
 * @return  Boolean TRUE or FALSE.
 */
function inventoryUtil_isRootCategory(categoryObj) {
    if (categoryObj == null)
        return false;
    if (categoryObj.id == null)
        return false;

    if (categoryObj.id.startsWith('system-master'))
        return true;
    else
        return false;
} // .end of inventoryUtil_isRootCategory

function inventoryUtil_getAvailabilityDescription(availabilityKey) {
    if (availabilityKey == InventoryConstants.QUANTITY_AVAILABLE)
        return InventoryConstants.QUANTITY_AVAILABLE_DESC;
    if (availabilityKey == InventoryConstants.QUANTITY_LOW_STOCK)
        return InventoryConstants.QUANTITY_LOW_STOCK_DESC;
    if (availabilityKey == InventoryConstants.QUANTITY_NO_STOCK)
        return InventoryConstants.QUANTITY_NO_STOCK_DESC;
    if (availabilityKey == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND)
        return InventoryConstants.QUANTITY_INVALID_ITEM_FOUND_DESC;
    if (availabilityKey == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND)
        return InventoryConstants.QUANTITY_ERROR_LOOP_FOUND_DESC;

    return 'Unknown Status: ' + availabilityKey;
} // .end of inventoryUtil_getAvailabilityDescription

function inventoryUtil_getAvailabilityCSS(availabilityKey) {
    if (availabilityKey == InventoryConstants.QUANTITY_AVAILABLE)
        return 'color:#1ab34a; font-weight:bold;';
    if (availabilityKey == InventoryConstants.QUANTITY_LOW_STOCK)
        return 'color:#b35b1a; font-weight:bold;';
    if (availabilityKey == InventoryConstants.QUANTITY_NO_STOCK)
        return 'color:#ff0000; font-weight:bold;';
    if (availabilityKey == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND)
        return 'color:#ff0000; font-weight:bold;';
    if (availabilityKey == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND)
        return 'color:#ff0000; font-weight:bold;';

    return 'Unknown Status: ' + availabilityKey;
} // .end of inventoryUtil_getAvailabilityCSS

var COLUMN_HEADER = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

/**
 * Process batch upload
 * 
 */
function inventoryUtil_processBatchUpload(base64) {

    var excelDoc = new ExcelPlus();
    excelDoc.open(base64.substr(base64.indexOf(",")), {
        type: 'base64'
    });
    // Select Sheet
    excelDoc.selectSheet('ITEMS');

    // Read Cells
    var cellVal_categoryId = excelDoc.read("B2");
    var cellVal_categoryName = excelDoc.read("D2");
    var cellVal_itemType = excelDoc.read("F2");

    // Validation: item type
    if (cellVal_itemType != InventoryConstants.ITEM_TYPE_PRODUCT &&
        cellVal_itemType != InventoryConstants.ITEM_TYPE_SERVICE &&
        cellVal_itemType != InventoryConstants.ITEM_TYPE_RAW &&
        cellVal_itemType != InventoryConstants.ITEM_TYPE_SERVICE &&
        cellVal_itemType != InventoryConstants.ITEM_TYPE_TAX &&
        cellVal_itemType != InventoryConstants.ITEM_TYPE_DISCOUNT)
        return false;

    var categoryObj = Cached_getCategoryById(cellVal_categoryId);
    if (categoryObj == null)
        return false;

    var result = new Object();
    result.itemListForInsert = [];
    result.itemListForUpdate = [];
    result.itemListForDelete = [];

    // BEGIN from row #4 (row 1-4 are system defined)
    for (var i = 5; i < 10000; i++) {

        var cellVal_action = excelDoc.read("A" + i);
        var cellVal_ID = excelDoc.read("B" + i);
        var cellVal_groupName = excelDoc.read("C" + i);
        var cellVal_itemName = excelDoc.read("D" + i);
        var cellVal_keywords = excelDoc.read("E" + i);
        var cellVal_posVisible = excelDoc.read("F" + i);
        var cellVal_pwsVisible = excelDoc.read("G" + i);
        var cellVal_measurementUnit = excelDoc.read("H" + i);
        var cellVal_quantityOptional = excelDoc.read("I" + i);
        var cellVal_minimumQuantity = excelDoc.read("J" + i);
        var cellVal_quantity = excelDoc.read("K" + i);
        var cellVal_unitCost = excelDoc.read("L" + i);
        var cellVal_unitPrice = excelDoc.read("M" + i);
        
        var cellVal_taxInclusive = excelDoc.read("H" + i);
        var cellVal_taxDiscountInPercentage = excelDoc.read("I" + i);
        var cellVal_taxDiscountInAmount = excelDoc.read("J" + i);
        var cellVal_taxDiscountPercentage = excelDoc.read("K" + i);
        var cellVal_taxDiscountAmount = excelDoc.read("L" + i);

        if ($.trim(cellVal_action).toUpperCase() == 'DEL' && $.trim(cellVal_ID) != '') {
            var newItemObj = createNew_InventoryItem();
            newItemObj.id = $.trim(cellVal_ID);
            newItemObj.categoryId = $.trim(cellVal_categoryId);
            newItemObj.categoryName = $.trim(cellVal_categoryName);
            newItemObj.itemType = $.trim(cellVal_itemType).toLowerCase();
            newItemObj.groupName = $.trim(cellVal_groupName);
            newItemObj.name = $.trim(cellVal_itemName);
            newItemObj.seqnoInGroup = 0;
            newItemObj.labels = $.trim(cellVal_keywords);
            newItemObj.availability = '';
            newItemObj.posVisible = $.trim(cellVal_posVisible) == 'Y' ? true : false;
            newItemObj.pwsVisible = $.trim(cellVal_pwsVisible) == 'Y' ? true : false;
            newItemObj.scmVisible = false;
            newItemObj.imageUrl = '';

            if (cellVal_itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
                cellVal_itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
                cellVal_itemType == InventoryConstants.ITEM_TYPE_EVENT ||
                cellVal_itemType == InventoryConstants.ITEM_TYPE_RAW) {
                newItemObj.measurementUnit = $.trim(cellVal_measurementUnit);
                newItemObj.quantityOptional = $.trim(cellVal_quantityOptional) == 'Y' ? true : false;
                newItemObj.minimumQuantity = Number(cellVal_minimumQuantity) == NaN ? 0 : Number(cellVal_minimumQuantity);
                newItemObj.quantity = Number(cellVal_quantity) == NaN ? 0 : Number(cellVal_quantity);
                newItemObj.unitCost = Number(cellVal_unitCost) == NaN ? 0 : Number(cellVal_unitCost);
                newItemObj.unitPrice = Number(cellVal_unitPrice) == NaN ? 0 : Number(cellVal_unitPrice);
                newItemObj.taxInclusive = false;
                newItemObj.taxDiscountInPercentage = false;
                newItemObj.taxDiscountInAmount = false;
                newItemObj.taxDiscountPercentage = 0;
                newItemObj.taxDiscountAmount = 0;
            }
            else {
                newItemObj.measurementUnit = 0;
                newItemObj.quantityOptional = false;
                newItemObj.minimumQuantity = 0;
                newItemObj.quantity = 0;
                newItemObj.unitCost = 0;
                newItemObj.unitPrice = 0;
                newItemObj.taxInclusive = $.trim(cellVal_taxInclusive) == 'Y' ? true : false;;
                newItemObj.taxDiscountInPercentage = $.trim(cellVal_taxDiscountInPercentage) == 'Y' ? true : false;;
                newItemObj.taxDiscountInAmount = $.trim(cellVal_taxDiscountInAmount) == 'Y' ? true : false;;
                newItemObj.taxDiscountPercentage = Number(cellVal_taxDiscountPercentage) == NaN ? 0 : Number(cellVal_taxDiscountPercentage);;
                newItemObj.taxDiscountAmount = Number(cellVal_taxDiscountAmount) == NaN ? 0 : Number(cellVal_taxDiscountAmount);;
            }

            result.itemListForDelete.push(newItemObj);
        }

        if ($.trim(cellVal_action).toUpperCase() == 'UPD') {

            if ($.trim(cellVal_ID) == '') {
                var newItemObj = createNew_InventoryItem();
                newItemObj.categoryId = $.trim(cellVal_categoryId);
                newItemObj.categoryName = $.trim(cellVal_categoryName);
                newItemObj.itemType = $.trim(cellVal_itemType).toLowerCase();
                newItemObj.groupName = $.trim(cellVal_groupName);
                newItemObj.name = $.trim(cellVal_itemName);
                newItemObj.seqnoInGroup = 0;
                newItemObj.labels = $.trim(cellVal_keywords);
                newItemObj.availability = '';
                newItemObj.posVisible = $.trim(cellVal_posVisible) == 'Y' ? true : false;
                newItemObj.pwsVisible = $.trim(cellVal_pwsVisible) == 'Y' ? true : false;
                newItemObj.scmVisible = false;
                newItemObj.imageUrl = '';

                if (cellVal_itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
                    cellVal_itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
                    cellVal_itemType == InventoryConstants.ITEM_TYPE_EVENT ||
                    cellVal_itemType == InventoryConstants.ITEM_TYPE_RAW) {
                    newItemObj.measurementUnit = $.trim(cellVal_measurementUnit);
                    newItemObj.quantityOptional = $.trim(cellVal_quantityOptional) == 'Y' ? true : false;
                    newItemObj.minimumQuantity = Number(cellVal_minimumQuantity) == NaN ? 0 : Number(cellVal_minimumQuantity);
                    newItemObj.quantity = Number(cellVal_quantity) == NaN ? 0 : Number(cellVal_quantity);
                    newItemObj.unitCost = Number(cellVal_unitCost) == NaN ? 0 : Number(cellVal_unitCost);
                    newItemObj.unitPrice = Number(cellVal_unitPrice) == NaN ? 0 : Number(cellVal_unitPrice);
                    newItemObj.taxInclusive = false;
                    newItemObj.taxDiscountInPercentage = false;
                    newItemObj.taxDiscountInAmount = false;
                    newItemObj.taxDiscountPercentage = 0;
                    newItemObj.taxDiscountAmount = 0;

                    // "O" starts from index 13
                    for (var j = 13; j < COLUMN_HEADER.length; j++) {
                        var cellVal_propValue = excelDoc.read(COLUMN_HEADER[j] + i);
                        if ($.trim(cellVal_propValue) != '') {
                            var cellVal_propName = $.trim(excelDoc.read(COLUMN_HEADER[j] + '3'));
                            var cellVal_propType = $.trim(excelDoc.read(COLUMN_HEADER[j] + '4'));

                            $.each(categoryObj.propertiesList, function(k, categoryPropObj) {
                                if (categoryPropObj.propName == cellVal_propName) {
                                    var newItemPropObj = createNew_InventoryItemProperties();
                                    newItemPropObj.itemId = newItemObj.id;
                                    newItemPropObj.categoryPropertiesId = categoryPropObj.id;
                                    newItemPropObj.seqno = categoryPropObj.seqno;
                                    newItemPropObj.required = categoryPropObj.required;
                                    newItemPropObj.visible = categoryPropObj.visible;
                                    newItemPropObj.groupName = categoryPropObj.groupName;
                                    newItemPropObj.propSeqno = categoryPropObj.propSeqno;
                                    newItemPropObj.propKey = categoryPropObj.propKey;
                                    newItemPropObj.propName = categoryPropObj.propName;
                                    newItemPropObj.propType = categoryPropObj.propType;
                                    newItemPropObj.propContent = categoryPropObj.propContent;

                                    if (newItemPropObj.propType == 'Text')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Number')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Boolean')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue) == 'Y' ? true : false;
                                    if (newItemPropObj.propType == 'List')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);

                                    if (newItemObj.propertiesList == null)
                                        newItemObj.propertiesList = [];
                                    newItemObj.propertiesList.push(newItemPropObj);
                                }
                            });
                        }
                    }
                }
                else {
                    newItemObj.measurementUnit = 0;
                    newItemObj.quantityOptional = false;
                    newItemObj.minimumQuantity = 0;
                    newItemObj.quantity = 0;
                    newItemObj.unitCost = 0;
                    newItemObj.unitPrice = 0;
                    newItemObj.taxInclusive = $.trim(cellVal_taxInclusive) == 'Y' ? true : false;;
                    newItemObj.taxDiscountInPercentage = $.trim(cellVal_taxDiscountInPercentage) == 'Y' ? true : false;;
                    newItemObj.taxDiscountInAmount = $.trim(cellVal_taxDiscountInAmount) == 'Y' ? true : false;;
                    newItemObj.taxDiscountPercentage = Number(cellVal_taxDiscountPercentage) == NaN ? 0 : Number(cellVal_taxDiscountPercentage);;
                    newItemObj.taxDiscountAmount = Number(cellVal_taxDiscountAmount) == NaN ? 0 : Number(cellVal_taxDiscountAmount);

                    // "N" starts from index 12
                    for (var j = 12; j < COLUMN_HEADER.length; j++) {
                        var cellVal_propValue = excelDoc.read(COLUMN_HEADER[j] + i);
                        if ($.trim(cellVal_propValue) != '') {
                            var cellVal_propName = excelDoc.read(COLUMN_HEADER[j] + '3');
                            var cellVal_propType = excelDoc.read(COLUMN_HEADER[j] + '4');

                            $.each(categoryObj.propertiesList, function(k, categoryPropObj) {
                                if (categoryPropObj.propName == cellVal_propName) {
                                    var newItemPropObj = createNew_InventoryItemProperties();
                                    newItemPropObj.itemId = newItemObj.id;
                                    newItemPropObj.categoryPropertiesId = categoryPropObj.id;
                                    newItemPropObj.seqno = categoryPropObj.seqno;
                                    newItemPropObj.required = categoryPropObj.required;
                                    newItemPropObj.visible = categoryPropObj.visible;
                                    newItemPropObj.groupName = categoryPropObj.groupName;
                                    newItemPropObj.propSeqno = categoryPropObj.propSeqno;
                                    newItemPropObj.propKey = categoryPropObj.propKey;
                                    newItemPropObj.propName = categoryPropObj.propName;
                                    newItemPropObj.propType = categoryPropObj.propType;
                                    newItemPropObj.propContent = categoryPropObj.propContent;

                                    if (newItemPropObj.propType == 'Text')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Number')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Boolean')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue) == 'Y' ? true : false;
                                    if (newItemPropObj.propType == 'List')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);

                                    if (newItemObj.propertiesList == null)
                                        newItemObj.propertiesList = [];
                                    newItemObj.propertiesList.push(newItemPropObj);
                                }
                            });
                        }
                    }
                }

                result.itemListForInsert.push(newItemObj);
            }
            else {
                var newItemObj = createNew_InventoryItem();
                newItemObj.id = $.trim(cellVal_ID);
                newItemObj.categoryId = $.trim(cellVal_categoryId);
                newItemObj.categoryName = $.trim(cellVal_categoryName);
                newItemObj.itemType = $.trim(cellVal_itemType).toLowerCase();
                newItemObj.groupName = $.trim(cellVal_groupName);
                newItemObj.name = $.trim(cellVal_itemName);
                newItemObj.seqnoInGroup = 0;
                newItemObj.labels = $.trim(cellVal_keywords);
                newItemObj.availability = '';
                newItemObj.posVisible = $.trim(cellVal_posVisible) == 'Y' ? true : false;
                newItemObj.pwsVisible = $.trim(cellVal_pwsVisible) == 'Y' ? true : false;
                newItemObj.scmVisible = false;
                newItemObj.imageUrl = '';
                if (cellVal_itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
                    cellVal_itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
                    cellVal_itemType == InventoryConstants.ITEM_TYPE_EVENT ||
                    cellVal_itemType == InventoryConstants.ITEM_TYPE_RAW) {
                    newItemObj.measurementUnit = $.trim(cellVal_measurementUnit);
                    newItemObj.quantityOptional = $.trim(cellVal_quantityOptional) == 'Y' ? true : false;
                    newItemObj.minimumQuantity = Number(cellVal_minimumQuantity) == NaN ? 0 : Number(cellVal_minimumQuantity);
                    newItemObj.quantity = Number(cellVal_quantity) == NaN ? 0 : Number(cellVal_quantity);
                    newItemObj.unitCost = Number(cellVal_unitCost) == NaN ? 0 : Number(cellVal_unitCost);
                    newItemObj.unitPrice = Number(cellVal_unitPrice) == NaN ? 0 : Number(cellVal_unitPrice);
                    newItemObj.taxInclusive = false;
                    newItemObj.taxDiscountInPercentage = false;
                    newItemObj.taxDiscountInAmount = false;
                    newItemObj.taxDiscountPercentage = 0;
                    newItemObj.taxDiscountAmount = 0;

                    // "O" starts from 14
                    for (var j = 14; j < COLUMN_HEADER.length; j++) {
                        var cellVal_propValue = excelDoc.read(COLUMN_HEADER[j] + i);
                        if ($.trim(cellVal_propValue) != '') {
                            var cellVal_propName = excelDoc.read(COLUMN_HEADER[j] + '3');
                            var cellVal_propType = excelDoc.read(COLUMN_HEADER[j] + '4');

                            $.each(categoryObj.propertiesList, function(k, categoryPropObj) {
                                if (categoryPropObj.propName == cellVal_propName) {
                                    var newItemPropObj = createNew_InventoryItemProperties();
                                    newItemPropObj.itemId = newItemObj.id;
                                    newItemPropObj.categoryPropertiesId = categoryPropObj.id;
                                    newItemPropObj.seqno = categoryPropObj.seqno;
                                    newItemPropObj.required = categoryPropObj.required;
                                    newItemPropObj.visible = categoryPropObj.visible;
                                    newItemPropObj.groupName = categoryPropObj.groupName;
                                    newItemPropObj.propSeqno = categoryPropObj.propSeqno;
                                    newItemPropObj.propKey = categoryPropObj.propKey;
                                    newItemPropObj.propName = categoryPropObj.propName;
                                    newItemPropObj.propType = categoryPropObj.propType;
                                    newItemPropObj.propContent = categoryPropObj.propContent;

                                    if (newItemPropObj.propType == 'Text')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Number')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Boolean')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue) == 'Y' ? true : false;
                                    if (newItemPropObj.propType == 'List')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);

                                    if (newItemObj.propertiesList == null)
                                        newItemObj.propertiesList = [];
                                    newItemObj.propertiesList.push(newItemPropObj);
                                }
                            });
                        }
                    }
                }
                else {
                    newItemObj.measurementUnit = 0;
                    newItemObj.quantityOptional = false;
                    newItemObj.minimumQuantity = 0;
                    newItemObj.quantity = 0;
                    newItemObj.unitCost = 0;
                    newItemObj.unitPrice = 0;
                    newItemObj.taxInclusive = $.trim(cellVal_taxInclusive) == 'Y' ? true : false;;
                    newItemObj.taxDiscountInPercentage = $.trim(cellVal_taxDiscountInPercentage) == 'Y' ? true : false;;
                    newItemObj.taxDiscountInAmount = $.trim(cellVal_taxDiscountInAmount) == 'Y' ? true : false;;
                    newItemObj.taxDiscountPercentage = Number(cellVal_taxDiscountPercentage) == NaN ? 0 : Number(cellVal_taxDiscountPercentage);;
                    newItemObj.taxDiscountAmount = Number(cellVal_taxDiscountAmount) == NaN ? 0 : Number(cellVal_taxDiscountAmount);

                    // "N" starts from 13
                    for (var j = 13; j < COLUMN_HEADER.length; j++) {
                        var cellVal_propValue = excelDoc.read(COLUMN_HEADER[j] + i);
                        if ($.trim(cellVal_propValue) != '') {
                            var cellVal_propName = excelDoc.read(COLUMN_HEADER[j] + '3');
                            var cellVal_propType = excelDoc.read(COLUMN_HEADER[j] + '4');

                            $.each(categoryObj.propertiesList, function(k, categoryPropObj) {
                                if (categoryPropObj.propName == cellVal_propName) {
                                    var newItemPropObj = createNew_InventoryItemProperties();
                                    newItemPropObj.itemId = newItemObj.id;
                                    newItemPropObj.categoryPropertiesId = categoryPropObj.id;
                                    newItemPropObj.seqno = categoryPropObj.seqno;
                                    newItemPropObj.required = categoryPropObj.required;
                                    newItemPropObj.visible = categoryPropObj.visible;
                                    newItemPropObj.groupName = categoryPropObj.groupName;
                                    newItemPropObj.propSeqno = categoryPropObj.propSeqno;
                                    newItemPropObj.propKey = categoryPropObj.propKey;
                                    newItemPropObj.propName = categoryPropObj.propName;
                                    newItemPropObj.propType = categoryPropObj.propType;
                                    newItemPropObj.propContent = categoryPropObj.propContent;

                                    if (newItemPropObj.propType == 'Text')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Number')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);
                                    if (newItemPropObj.propType == 'Boolean')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue) == 'Y' ? true : false;
                                    if (newItemPropObj.propType == 'List')
                                        newItemPropObj.propValue = $.trim(cellVal_propValue);

                                    if (newItemObj.propertiesList == null)
                                        newItemObj.propertiesList = [];
                                    newItemObj.propertiesList.push(newItemPropObj);
                                }
                            });
                        }
                    }
                }

                result.itemListForUpdate.push(newItemObj);
            }
        }
    }

    return result;
} // .end of inventoryUtil_processBatchUpload
