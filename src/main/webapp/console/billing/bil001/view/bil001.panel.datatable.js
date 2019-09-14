
function bil001_dataTablePanel_show() {
	
} // .end of bil001_dataTablePanel_show

function init_listView(userLoad) {
	// If userLoad=true  > means user click to trigger this method.
	// If userLoad=false > means page load trigger this method.
	if (userLoad) {
		init_listView_postHandler();
	}
	else {
		init_listView_postHandler();
	}
} // .end of init_listView

function init_listView_postHandler() {
	var htmlLines = '';
	htmlLines += '<table id="item_listView_dataTable" class="table table-striped table-bordered table-hover">';
	htmlLines += '<thead>';
	htmlLines += '<tr>';
	htmlLines += '<th>Item ID</th>'; // col1, hidden
	htmlLines += '<th>Item Name</th>'; // col2
	htmlLines += '<th>Label/Tag</th>'; // col3, hidden
	htmlLines += '<th>Grouping</th>'; // col4
	htmlLines += '<th class="text-right">Quantity</th>'; // col5, w80px
	htmlLines += '<th class="text-right">Unit Price</th>'; // col6, w80px
	htmlLines += '</tr>';
	htmlLines += '</thead>';
	htmlLines += '<tbody id="item_listView_dataTable_body">';
	htmlLines += '</tbody>';
	htmlLines += '</table>';

	$('#itemView').empty();
	$('#itemView').append(htmlLines);


	// Get user's preference on page length
 	var dataTable_pageLength = 10; 
 	var foundPropObj;
 	var userObj = tycheesCommon_getCurrentUserObject();
 	
 	$.each(userObj.propertiesList, function(i, propObj) {
 		if (Cached_isDeletedBean(propObj))
 			return true;
 		
 		if (propObj.propKey == UserConstants.PREF_POS_LIST_VIEW_SIZE && 
 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
 			foundPropObj = propObj;
 			dataTable_pageLength = Number(propObj.propValue);
 			if (dataTable_pageLength == NaN)
 				dataTable_pageLength = 10;
 		}
 	});
 	
 	if (foundPropObj == null) {
 		var newPropObj = createNew_UserProperties();
 		newPropObj.userId = userObj.id;
 		newPropObj.groupName = tycheesCommon_getCurrentPlaceId();
 		newPropObj.propSeqno = userObj.propertiesList.length;
 		newPropObj.propKey = UserConstants.PREF_POS_LIST_VIEW_SIZE;
 		newPropObj.propName = UserConstants.PREF_POS_LIST_VIEW_SIZE;
 		newPropObj.propType = 'Number';
 		newPropObj.propContent = '';
 		newPropObj.propValue = dataTable_pageLength;
 		
 		userObj.propertiesList.push(newPropObj);
 		tycheesIO_saveBean(userObj);
 	}
	 	
	// Init dataTable: items 
	$("#item_listView_dataTable").DataTable({
		"columnDefs": [{"targets": [0], "visible": false, "searchable": false}, 
					   {"targets": [2],	"visible": false, "searchable": true}, 
					   {"targets": [4],	"width": 80}, 
					   {"targets": [5],	"width": 80}],
		"order": [[1, 'asc']],
		"pageLength": dataTable_pageLength, // Number of row / page,
		"fixedColumns": true,
		"drawCallback": function(settings) {}
	});
	// Add event handler on page length changed.
	$("#item_listView_dataTable").on('length.dt', function(e, settings, lens) {
    	var userObj = tycheesCommon_getCurrentUserObject();
    	$.each(userObj.propertiesList, function(i, propObj) {
    		if (Cached_isDeletedBean(propObj))
    			return true;
    		
    		if (propObj.propKey == UserConstants.PREF_POS_LIST_VIEW_SIZE && 
   	 			propObj.groupName == tycheesCommon_getCurrentPlaceId()) {
    			propObj.hasChanged = true;
    			propObj.propValue = lens.toString();
    		}
    	});
    	
		tycheesIO_saveBean(userObj);
    });
	
	// Update UI
	init_itemPanel_listView();
	// Set state
	global_currentItemViewType = ITEM_VIEW_TYPE_LIST;
	// Hide progress screen
	tycheesOverlay_stopShortProgress();
} // .end of init_listView_postHandler

/**
 * Insert items (pos-visible) into category panel.
 */
function init_itemPanel_listView() {
	// Clear list
	$('#item_listView_dataTable').DataTable().clear().draw();

	var visibleCategoryList = [];
	$.each(bil001_categoryList, function(i, categoryObj) {
		if (categoryObj.posVisible == true)
			visibleCategoryList.push(categoryObj);
	});

	var visibleItemList = [];
	$.each(visibleCategoryList, function(i, categoryObj) {
		var itemList = Cached_getItemListByCategoryId(categoryObj.id, true, bil001_itemList);
		$.each(itemList, function(j, itemObj) {
			if ($.inArray(itemObj, visibleItemList) == -1 && itemObj.posVisible == true)
				visibleItemList.push(itemObj);
		});
	});

	// Sort items alphabetically
	visibleItemList.sort(function(a, b) {
		if (a.name < b.name) return -1;
		if (a.name > b.name) return 1;
		return 0;
	});

	// Iterate through pos-visible item list
	$.each(visibleItemList, function(i, itemObj) {

		// Validation
		if (itemObj.availability == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND)
			return true;
		if (itemObj.availability == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND)
			return true;

		var categoryObj = Cached_getCategoryById(itemObj.categoryId, bil001_categoryList);
		var rowClickAction = 'page_ctrl_insertItemAsBillingLine(\'' + itemObj.id + '\')';
		var quantity = itemObj.quantity;
		var unitCost = itemObj.unitCost;
		var unitPrice = itemObj.unitPrice;

		var cssVal = 'color:#333;';
		var cssVal_text = '';
		var availabilityCell = '<span class="label label-danger">Unavailable</span>';
		if (itemObj.quantityOptional) {
			cssVal = 'color:#2b9800;';
			cssVal_text = '';
			availabilityCell = '<span class="label label-primary">' + InventoryConstants.QUANTITY_AVAILABLE_DESC + '</span>';
			quantity = 'Available';
		} else {
			if (itemObj.availability == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND) {
				cssVal = 'color:#F00;';
				cssVal_text = 'color:#F00; text-decoration:line-through;';
				availabilityCell = '<span class="label label-danger">' + InventoryConstants.QUANTITY_INVALID_ITEM_FOUND_DESC + '</span>';
			}
			if (itemObj.availability == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND) {
				cssVal = 'color:#F00;';
				cssVal_text = 'color:#F00; text-decoration:line-through;';
				availabilityCell = '<span class="label label-danger">' + InventoryConstants.QUANTITY_ERROR_LOOP_FOUND_DESC + '</span>';
			}
			if (itemObj.availability == InventoryConstants.QUANTITY_NO_STOCK) {
				cssVal = 'color:#F00;';
				cssVal_text = 'color:#F00; text-decoration:line-through;';
				availabilityCell = '<span class="label label-warning">' + InventoryConstants.QUANTITY_NO_STOCK_DESC + '</span>';
				quantity = 'Unavailable';
			}
			if (itemObj.availability == InventoryConstants.QUANTITY_LOW_STOCK) {
				cssVal = 'color:#fb651b;';
				cssVal_text = 'color:#fb651b;';
				availabilityCell = '<span class="label label-warning">' + InventoryConstants.QUANTITY_LOW_STOCK_DESC + '</span>';
			}
			if (itemObj.availability == InventoryConstants.QUANTITY_AVAILABLE) {
				cssVal = 'color:#2b9800;';
				cssVal_text = '';
				availabilityCell = '<span class="label label-primary">' + InventoryConstants.QUANTITY_AVAILABLE_DESC + '</span>';
				if (quantity <= 0)
					quantity = 'Available';
			}
		}

		if (itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT ||
			itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
			if (isNaN(quantity)) {
				quantity = 'Available';
				availabilityCell = '<span class="label label-primary">' + InventoryConstants.QUANTITY_AVAILABLE_DESC + '</span>';
			}

			var percentage = itemObj.taxDiscountPercentage;
			var amount = itemObj.taxDiscountAmount;

			if (percentage > 0) {
				unitPrice = Number(percentage).toFixed(2) + '%';
			}
			else
			if (amount > 0) {
				unitPrice = Number(amount).toFixed(2);
			}
			else {
				unitPrice = Number(0).toFixed(2);
			}
		}

		var imageUrl = 'https://storage.googleapis.com/bucket_common/item-unbox-01.png';
		if (itemObj.imageUrl != null && itemObj.imageUrl.length > 0)
			imageUrl = itemObj.imageUrl;

		var iconCell = '';
		iconCell += '<span class="client-avatar">';
		iconCell += '<a onclick="' + rowClickAction + '">';
		iconCell += '<img alt="image" class="img-circle" src="' + imageUrl + '">';
		iconCell += '</a>'
		iconCell += '</span>';

		var col2_itemName = '';
		col2_itemName += '<div class="i-checks" id="checkbox-' + itemObj.id + '">';
		col2_itemName += '<label>';
		//col2_itemName += iconCell;
		col2_itemName += '<i class="fa fa-archive" aria-hidden="true" style="' + cssVal_text + '"></i> ';
		col2_itemName += '<a id="itemView-list-' + itemObj.id + '" class="client-link" style="' + cssVal_text + '" onclick="' + rowClickAction + '">' + itemObj.name + '</a>';
		col2_itemName += '<i id="itemView-spinner-' + itemObj.id + '" class="fa fa-spinner fa-spin" style="font-size:12px; display:none;" aria-hidden="true"></i>';
		col2_itemName += '</label>';
		col2_itemName += '</div>';

		var groupNameCell = $.trim(itemObj.groupName);
		if (groupNameCell == '')
			groupNameCell = 'NoName';

		var col1_itemId = itemObj.id;
		var col3_labels = itemObj.labels;
		var col4_groupName = groupNameCell;
		var col5_quantity = '<span class="pull-right" id="item-quantity-' + itemObj.id + '" style="' + cssVal + '">' + quantity + '</span>';
		var col6_unitPrice = '<span class="pull-right">' + unitPrice + '</span>';

		// Add to dataTable as row
		$("#item_listView_dataTable").DataTable().row.add([
				col1_itemId,
				col2_itemName,
				col3_labels,
				col4_groupName,
				col5_quantity,
				col6_unitPrice
			])
			.draw(false);
	});
	
	// Set search input's width to fixed 150px.
	$("#mw_billingSearch_dataTable_billing_filter input").css('width', '150px');
} // .end of init_itemPanel_listView

/***
 * Update item as list into billing panel (dataTable)
 * 
 * @param itemObj		ref to Item object
 */
function page_updateItemInList(itemObj) {
	var selectedRowIndex = -1;
	$('#item_listView_dataTable').DataTable().rows().every(
		function(rowIndex, tableLoop, columnLoop) {
			var rowItemId = $.trim($('#item_listView_dataTable').DataTable().cell(rowIndex, 0).data());
			if (itemObj.id == rowItemId)
				selectedRowIndex = rowIndex;
		});

	if (selectedRowIndex >= 0) {
		var availability = itemObj.availability;
		var quantity = Number(itemObj.quantity);
		var unitPrice = Number(itemObj.unitPrice).toFixed(2);

		var cssVal = 'color:#333;';
		var availabilityCell = '<span class="label label-danger">' + InventoryConstants.QUANTITY_NO_STOCK_DESC + '</span>';
		if (availability == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND) {
			cssVal = 'color:#F00;';
			availabilityCell = '<span class="label label-danger">' + InventoryConstants.QUANTITY_INVALID_ITEM_FOUND + '</span>';
		}
		if (availability == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND) {
			cssVal = 'color:#F00;';
			availabilityCell = '<span class="label label-danger">' + InventoryConstants.QUANTITY_ERROR_LOOP_FOUND_DESC + '</span>';
		}
		if (availability == InventoryConstants.QUANTITY_NO_STOCK) {
			cssVal = 'color:#F00;';
			availabilityCell = '<span class="label label-warning">' + InventoryConstants.QUANTITY_NO_STOCK_DESC + '</span>';
			quantity = 'Unavailable';
		}
		if (availability == InventoryConstants.QUANTITY_LOW_STOCK) {
			cssVal = 'color:#fb651b;';
			availabilityCell = '<span class="label label-warning">' + InventoryConstants.QUANTITY_LOW_STOCK_DESC + '</span>';
		}
		if (availability == InventoryConstants.QUANTITY_AVAILABLE) {
			cssVal = 'color:#2b9800;';
			availabilityCell = '<span class="label label-primary">' + InventoryConstants.QUANTITY_AVAILABLE_DESC + '</span>';
			if (quantity <= 0)
				quantity = 'Available';
		}

		if (itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT ||
			itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
			if (isNaN(quantity)) {
				quantity = 'Available';
				availabilityCell = '<span class="label label-primary">' + InventoryConstants.QUANTITY_AVAILABLE_DESC + '</span>';
			}

			var percentage = itemObj.taxDiscountPercentage;
			var amount = itemObj.taxDiscountAmount;

			if (percentage > 0) {
				unitPrice = Number(percentage).toFixed(2) + '%';
			}
			else
			if (amount > 0) {
				unitPrice = Number(amount).toFixed(2);
			}
			else {
				unitPrice = Number(0).toFixed(2);
			}
		}

		var rowClickAction = 'page_ctrl_insertItemAsBillingLine(\'' + itemObj.id + '\')';

		var col2_itemName = '';
		col2_itemName += '<div class="i-checks" id="checkbox-' + itemObj.id + '">';
		col2_itemName += '<label>';
		col2_itemName += '<i class="fa fa-archive" aria-hidden="true" style="' + cssVal + '"></i> ';
		col2_itemName += '<a id="itemView-list-' + itemObj.id + '" class="client-link" onclick="' + rowClickAction + '">' + itemObj.name + '</a>';
		col2_itemName += '<i id="itemView-spinner-' + itemObj.id + '" class="fa fa-spinner fa-spin" style="font-size:12px; display:none;" aria-hidden="true"></i>';
		col2_itemName += '</label>';
		col2_itemName += '</div>';
		$('#item_listView_dataTable').DataTable().cell(selectedRowIndex, 1).data(col2_itemName).draw();

		var col5_quantity = '<span class="pull-right" style="' + cssVal + '">' + quantity + '</span>';
		$('#item_listView_dataTable').DataTable().cell(selectedRowIndex, 4).data(col5_quantity).draw();
	}
} // .end of page_updateItemInList
