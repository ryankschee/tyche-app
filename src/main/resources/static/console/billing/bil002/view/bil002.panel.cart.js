function bil002_cartPanel_show() {
	$('#bil002_tablePanel').hide();
	$('#bil002_cartPanel').show();
	$('#bil002_paymentPanel').hide();

	// Programmatically Click TAB 1
	$('#tabId-1').click();
	
	bil002_cartPanel_updateUI_bucketList();
} // .end of bil002_cartPanel_show

function bil002_cartPanel_updateUI_bucketList() {
	// Update name of bucket
	$('#bil002_cartPanel_bucketList_header_name').html(global_billingBucketObj.bucketName);
	// Show Progress Icon
	$('#bil002_cartPanel_bucketList_spinner').show();
	$('#bil002_cartPanel_bucketList_content').hide();

	$("#bil002_cartPanel_bucketList_dataTable").DataTable().clear().draw();
	if (global_billingBucketObj != null) {
		var totalAmount = 0;
		$.each(global_billingBucketObj.lineList, function(i, lineObj) {

			if (Cached_isDeletedBean(lineObj))
				return true;

			// Calculate amount
			totalAmount = totalAmount + (lineObj.billableAmount * lineObj.quantity);
			
			// COL #1
			var htmlLines_col1 = '';
			if (lineObj.addToBilling) {
				htmlLines_col1 += '<span style="text-decoration: line-through;">';
				htmlLines_col1 += lineObj.itemName;
				htmlLines_col1 += '</span>';
			}
			else {
				htmlLines_col1 += lineObj.itemName;
			}

			// COL #2
			var htmlLines_col2 = '';
			htmlLines_col2 += lineObj.billableAmount;

			// COL #3
			var htmlLines_col3 = '';
			htmlLines_col3 += lineObj.quantity;

			// COL #4
			var htmlLines_col4 = '';
			if (lineObj.addToBilling) {
				htmlLines_col4 += '<span class="pull-right" style="font-style:italic;">Added to Bill</span>';
			}
			else {
				htmlLines_col4 += '<span class="pull-right">';
				htmlLines_col4 += '<button class="btn btn-xs btn-info ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_incrementBucketLine(this,\'' + lineObj.id + '\');" style="margin-right:2px;"><i class="fa fa-plus-circle fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-info ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_decrementBucketLine(this,\'' + lineObj.id + '\');" style="margin-right:2px;"><i class="fa fa-minus-circle fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-danger ladda-button" data-style="zoom-in"  onclick="bil002_removeBucketLine(this,\'' + lineObj.id + '\');"><i class="fa fa-times fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '</span>';
			}

			var rowSet = [];
			rowSet.push(htmlLines_col1);
			rowSet.push(htmlLines_col2);
			rowSet.push(htmlLines_col3);
			rowSet.push(htmlLines_col4);

			$('#bil002_cartPanel_bucketList_dataTable').dataTable().fnAddData(rowSet, false);
		});

		$('#bil002_cartPanel_bucketList_dataTable').DataTable().draw();
		
		// Update Total Amount
		$('#bil002_cartPanel_bucketList_header_totalAmount').html(global_currencySign + ' ' + Number(totalAmount).toFixed(2));
	}

	$('#bil002_cartPanel_bucketList_spinner').hide();
	$('#bil002_cartPanel_bucketList_content').show();
} // .end of bil002_cartPanel_updateUI_bucketList


/**
 * Initialize masonry .grid, and detect images loaded event.
 */
function bil002_cartPanel_initMasonry() {
	var gridMasonry =
		$('.grid').masonry({
			// options
			isFitWidth: true,
			isAnimated: true,
			itemSelector: '.grid-item',
			columnWidth: global_billingItemDisplayWidth,
			gutter: 6,
			originLeft: true
		});

	// Detect images loaded (<img>)
	$('.grid').imagesLoaded()
		.always(function(instance) {
			//console.log('all images loaded');				
		})
		.done(function(instance) {
			//console.log('all images successfully loaded');
			gridMasonry.masonry('reloadItems');
			gridMasonry.masonry('layout');
		})
		.fail(function() {
			//console.log('all images loaded, at least one is broken');
		})
		.progress(function(instance, image) {
			//var result = image.isLoaded ? 'loaded' : 'broken';
			//console.log( 'image is ' + result + ' for ' + image.img.src );
		});

	gridMasonry.masonry('layout');
} // .end of bil002_cartPanel_initMasonry

function bil002_cartPanel_postMasonry() {
	// Item Animation.css
	// Listen to click event of item
	$('.animation_select').click(function() {
		$('#animation_box').removeAttr('class').attr('class', '');
		var animation = $(this).attr("data-animation");
		$('#animation_box').addClass('animated');
		$('#animation_box').addClass(animation);
		return false;
	});

	// Set height for each grid-item element
	$('.grid-item').each(function(index, element) {
		// Get grid-item ID
		var itemId = $.trim($(element).find('.item-id')[0].textContent);
		var itemObj = Cached_getItemById(itemId, bil002_itemList);
		var imageWidth = 620;
		var imageHeight = 336;

		if (itemObj.imageUrl != null && itemObj.imageUrl.length > 0) {
			imageWidth = itemObj.imageWidth;
			imageHeight = itemObj.imageHeight;
		}

		var imageDisplayHeight = tycheesImage_getImageHeightByRatio(imageWidth, imageHeight, global_billingItemDisplayWidth).toFixed(0);
		var imageElements = $(element).find('.product-imitation');
		imageElements[0].style.height = imageDisplayHeight + "px";

		var elementHeight = String(parseInt(imageDisplayHeight) + global_billingItemDisplayWidth) + "px";
		element.style.height = elementHeight;
	});

	bil002_cartPanel_initMasonry();
} // .end of bil002_cartPanel_postMasonry

function bil002_cartPanel_masonryView_updateUI() {	
	var htmlLines = '';
	htmlLines += '<div class="input-group">';
	htmlLines += '<span class="input-group-btn">';
	htmlLines += '<button type="button" class="btn btn btn-danger" onclick="bil002_tablePanel_show();"> <i class="fa fa-chevron-left"></i> BACK</button>';
	htmlLines += '<button type="button" class="btn btn btn-primary" onclick="bil002_paymentPanel_show();"> <i class="fa fa-usd" aria-hidden="true"></i> PAY BILL</button>';
	htmlLines += '</span>';
	htmlLines += '<input id="inputSearchItem" type="text" placeholder="Search SKU code, item name, description" class="input form-control">';
	htmlLines += '<span class="input-group-btn">';
	htmlLines += '<button id="buttonSearchItemStart" type="button" class="btn btn btn-primary"> <i class="fa fa-search"></i> </button>';
	htmlLines += '<button id="buttonSearchItemReset" type="button" class="btn btn btn-default"> <i class="fa fa-times"></i> Reset</button>';
	htmlLines += '</span>';
	htmlLines += '</div>';
	htmlLines += '<div class="clients-list" style="margin-top:5px;">';
	htmlLines += '<ul class="nav nav-tabs" id="tab-header">';
	htmlLines += '</ul>';
	htmlLines += '<div class="tab-content" id="tab-content">';
	htmlLines += '</div>';
	htmlLines += '</div>';

	$('#bil002_cartPanel_itemView').empty();
	$('#bil002_cartPanel_itemView').append(htmlLines);

	$("#inputSearchItem").keyup(function() {
		bil002_ctrl_executeAction(PAGE_ACTION_FILTER_SEARCH_TEXT);
	});

	$("#buttonSearchItemStart").click(function() {
		bil002_ctrl_executeAction(PAGE_ACTION_FILTER_SEARCH_TEXT);
	});

	$("#buttonSearchItemReset").click(function() {
		bil002_ctrl_executeAction(PAGE_ACTION_RESET_SEARCH_TEXT);
	});

	// Update UI - category list
	bil002_cartPanel_masonryView_updateUI_categoryList();
	// Update UI - item list
	bil002_cartPanel_masonryView_updateUI_itemList();

	// Set current VIEW TYPE
	global_currentItemViewType = ITEM_VIEW_TYPE_BLOCK;
} // .end of bil002_cartPanel_masonryView_updateUI

/**
 * Setup category TAB panels
 */
function bil002_cartPanel_masonryView_updateUI_categoryList() {
	var isActive = '-';
	$("#tab-header").empty();
	$("#tab-content").empty();

	var tabCount = 0;
	$.each(bil002_categoryList, function(i, categoryObj) {

		var itemList = Cached_getItemListByCategoryId(categoryObj.id, true, bil002_itemList);

		// Proceed to setup category TAB, if
		// - Category.posVisible IS TRUE, and
		// - Category has minimum 1 item inside. 
		if (categoryObj.posVisible == true && itemList.length > 0) {
			// Get filtering text from user input text
			var userFilterText = $.trim($("#inputSearchItem").val());

			// IF item in selected list (as compared with user input text)
			var itemsInThisCategory = false;
			$.each(itemList, function(j, itemObj) {
				if (isItemContainsText(itemObj, userFilterText) == true) {
					itemsInThisCategory = true;
					return false;
				}
			});

			var posVisibleItemCount = 0;
			$.each(itemList, function(j, itemObj) {
				if (itemObj.posVisible == true)
					posVisibleItemCount++;
			});


			// IF There is minimum 1 item in this category	
			if (itemsInThisCategory == true && posVisibleItemCount > 0) {
				// Increment TAB count
				tabCount++;
				// Set 'active' to first TAB
				if (isActive == '-')
					isActive = 'active';
				else
					isActive = '';

				var htmlLines = '';
				htmlLines += '<li class="' + isActive + '">';
				htmlLines += '<a data-toggle="tab" id="tabId="-' + tabCount + '" href="#tab-' + categoryObj.id + '" style="padding:5px 10px;" onclick="bil002_cartPanel_masonryView_onclick_category(\'' + categoryObj.id + '\')">';
				//htmlLines += '<i class="fa fa-shopping-cart"></i>';
				htmlLines += categoryObj.name;
				htmlLines += '</a>';
				htmlLines += '</li>';

				$("#tab-header").append(htmlLines);

				htmlLines = '';
				htmlLines += '<div id="tab-' + categoryObj.id + '" class="grid tab-pane ' + isActive + '" style="margin:10px auto;">';
				htmlLines += '</div>';

				$("#tab-content").append(htmlLines);
			} // .end of IF
		}
	});
} // .end of bil002_cartPanel_masonryView_updateUI_categoryList

/**
 * Event Listener: User click on Category tab menu
 */
function bil002_cartPanel_masonryView_onclick_category(categoryId) {
	$('#tab-' + categoryId).empty();
	$.each(bil002_itemList, function(i, itemObj) {
		if (itemObj.categoryId == categoryId && itemObj.posVisible == true)
			bil002_updateItemInMasonry(itemObj);
	});

	bil002_cartPanel_postMasonry();
} // .end of bil002_cartPanel_masonryView_onclick_category

/**
 * Insert items (pos-visible) into category panel.
 */
function bil002_cartPanel_masonryView_updateUI_itemList() {
	// Get filtering text
	var filterText = $.trim($("#inputSearchItem").val());
	// Insert each item into designated category panel
	var addedItemIndex = 0;
	$.each(bil002_itemList, function(index, itemObj) {
		if (itemObj.posVisible == true) {
			if (isItemContainsText(itemObj, filterText) == true) {
				bil002_updateItemInMasonry(itemObj);
			}
		}
	});

	bil002_cartPanel_postMasonry();
} // .end of bil002_cartPanel_masonryView_updateUI_itemList

/**
 * Insert/Update item as masonry .grid-item into billing panel. 
 */
function bil002_updateItemInMasonry(itemObj) {
	var availability = itemObj.availability;
	var quantity = itemObj.quantity;
	var showingUnit = 0;

	// Validation
	if (availability == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND)
		return false;
	if (availability == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND)
		return false;

	if (itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX ||
		itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT)
		showingUnit = itemObj.taxDiscountPercentage + ' %';
	else
		showingUnit = Number(itemObj.unitPrice).toFixed(2);

	var quantityValue = Number(quantity);
	if (availability == InventoryConstants.QUANTITY_NO_STOCK)
		quantityValue = 'Unavailable';
	else
	if (availability == InventoryConstants.QUANTITY_INVALID_ITEM_FOUND)
		quantityValue = 'Invalid Item';
	else
	if (availability == InventoryConstants.QUANTITY_ERROR_LOOP_FOUND)
		quantityValue = 'Error Loop';
	else {
		if (quantity <= 0 || quantity == null)
			quantityValue = 'Available (-)';
		else
			quantityValue = 'Available (' + quantity + ')';
	}

	var iboxOpacity = 1;
	if (availability == InventoryConstants.QUANTITY_NO_STOCK)
		iboxOpacity = 0.4;

	var itemImageUrl = itemObj.imageUrl;
	if (itemObj.imageUrl == null || itemObj.imageUrl.length == 0)
		itemImageUrl = "https://storage.googleapis.com/bucket_directme/public/Product-Image-Coming-Soon.png";

	var gridElement = $('#grid-' + itemObj.id);
	if (gridElement.html() == null) {
		var htmlLines = '';
		htmlLines += '<div class="grid-item animation_select" id="grid-' + itemObj.id + '" onclick="bil002_cartPanel_insertItemAsBucketLine(\'' + itemObj.id + '\')" data-animation="rollOut">';
		htmlLines += '<div class="item-id" style="display:none;">' + itemObj.id + '</div>';
		htmlLines += '<div class="ibox" id="ibox-' + itemObj.id + '" style="opacity:' + iboxOpacity + ';">';
		htmlLines += '<div class="ibox-content product-box">';
		htmlLines += '<div id="imagebox" class="product-imitation" style="padding: 0;background:url(' + itemImageUrl + ');background-size:100%;">';
		htmlLines += '</div>';
		htmlLines += '<div class="product-desc" style="width:' + global_billingItemDisplayWidth + 'px;">';
		htmlLines += '<span id="item-price-' + itemObj.id + '" class="product-price">';
		htmlLines += showingUnit;
		htmlLines += '</span>';
		htmlLines += '<span id="item-quantity-' + itemObj.id + '" class="product-quantity">';
		htmlLines += quantityValue;
		htmlLines += '</span>';
		//htmlLines += '<small class="text-muted item-barcode">' + itemObj.barcode + '</small>';
		htmlLines += '<a href="#" class="product-name item-name" id="' + itemObj.id + 'Name"> ' + itemObj.name + '</a>';
		htmlLines += '<div class="small m-t-xs item-description">';
		htmlLines += itemObj.remarks;
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';

		$("#tab-" + itemObj.categoryId).append(htmlLines);
	}
	else {
		$('#ibox-' + itemObj.id).css('opacity', iboxOpacity);
		$('#item-quantity-' + itemObj.id).html(quantityValue);
	}
} // .end of bil002_updateItemInMasonry


/**
 * Event Listener: Add new row of billing line into billable panel.
 */
function bil002_cartPanel_insertItemAsBucketLine(itemId) {

	tycheesOverlay_startShortProgress('loading item...');

	// Prepare request object
	var requestBody = {
		'appName': APP_NAME_POS,
		'itemId': itemId,
		'fullBean': true
	};

	var params = new Object();
	params.itemId = itemId;

	tycheesdb_api_getItemById(requestBody, bil002_cartPanel_insertItemAsBucketLine_step1, params);
} // .end of bil002_cartPanel_insertItemAsBucketLine

function bil002_cartPanel_insertItemAsBucketLine_step1(successFlag, responseObj, params) {
	var defaultMinUnit = 1;
	var itemObj = responseObj.itemObj;

	// Prepare Ajax data
	var requestBody = {
		'appName': APP_NAME_POS,
		'itemId': itemObj.id,
		'mandatory': true,
		'optional': false,
		'fullBean': true
	};

	params.itemObj = itemObj;

	// Ajax Call
	tycheesOverlay_startShortProgress('loading component items...');
	tycheesdb_api_listComponentItemsByItemId(requestBody, bil002_cartPanel_insertItemAsBucketLine_step2, params);
} // .end of bil002_cartPanel_insertItemAsBucketLine_step1

function bil002_cartPanel_insertItemAsBucketLine_step2(successFlag, responseObj, params) {
	var defaultMinUnit = 1;

	// VALIDATION
	// #1 - Is Billing Bucket Object in editable state (SERVING, RESERVED)
	if (global_billingBucketObj.bucketStatus != 'SERVING' &&
		global_billingBucketObj.bucketStatus != 'RESERVED') {
		tycheesLogger_showToast('warning', 'Warning', 'This table is not editable anymore. [' + global_billingBucketObj.bucketStatus + ']');
		return false;
	}

	// #2 - Is item available in stock?
	if (params.itemObj.availability == InventoryConstants.QUANTITY_NO_STOCK) {
		tycheesLogger_showToast('warning', 'Warning', 'Stock unavailable.');
		return false;
	}
	// .end of VALIDATION

	// Create new Billing Line (LEVEL 1)   
	var bucketLineObj = billingBucketCommon_createBillingBucketLine(global_billingBucketObj, params.itemObj);
	if (bucketLineObj != null) {
		// Push line object into billing object
		global_billingBucketObj.lineList.push(bucketLineObj);

		// Prepare Ajax data
		var requestBody = {
			'appName': APP_NAME_POS,
			'billingBucketId': global_billingBucketObj.id,
			'billingBucketLineId': bucketLineObj.id,
			'fullBean': true
		};

		params.bucketLineObj = bucketLineObj;
		params.itemList = responseObj.itemList;

		// Ajax Call
		tycheesOverlay_startShortProgress('loading component items...');
		tycheesdb_api_listItemsByBillingBucketLine(requestBody, bil002_cartPanel_insertItemAsBucketLine_postHandler, params);
	}
} // .end of bil002_cartPanel_insertItemAsBucketLine_step2

function bil002_cartPanel_insertItemAsBucketLine_postHandler(successFlag, responseObj, params) {
	if (successFlag == false)
		return false;

	var itemObj = params.itemObj;
	var bucketLineObj = params.bucketLineObj;

	$.each(responseObj.itemList, function(i, obj) {
		params.itemList.push(obj);
	});

	// Push to global
	$.each(responseObj.itemList, function(i, obj) {
		global_componentItemList.push(obj);
	});

	// Add mandatory components as Billing Line
	$.each(itemObj.componentList, function(i, componentObj) {
		if (componentObj.selectable == false) {
			var itemIdsList = componentObj.itemIds.split(',');
			$.each(itemIdsList, function(j, component_itemId) {
				if ($.trim(component_itemId) == '')
					return true;

				var component_itemObj = Cached_getItemById(component_itemId, params.itemList);
				var component_billingBucketLineObj = billingBucketCommon_createBillingBucketLine(global_billingBucketObj, component_itemObj);
				if (component_billingBucketLineObj == null)
					return true;

				component_billingBucketLineObj.parentLineId = bucketLineObj.id;
				component_billingBucketLineObj.componentId = componentObj.id;
				component_billingBucketLineObj.mandatory = true;
				component_billingBucketLineObj.quantity = componentObj.defaultQuantity;

				if (bucketLineObj.lineList == null)
					bucketLineObj.lineList = [];
				bucketLineObj.lineList.push(component_billingBucketLineObj);
			});
		}

		if (componentObj.selectable == true) {
			var defaultItemIdList = $.trim(componentObj.defaultItemIds).split(',');
			$.each(defaultItemIdList, function(i, defaultItemId) {
				if (defaultItemId == '')
					return true;

				var component_itemObj = Cached_getItemById(defaultItemId, params.itemList);
				var component_billingBucketLineObj = billingBucketCommon_createBillingBucketLine(global_billingBucketObj, component_itemObj);
				if (component_billingBucketLineObj == null)
					return true;

				component_billingBucketLineObj.parentLineId = bucketLineObj.id;
				component_billingBucketLineObj.componentId = componentObj.id;
				component_billingBucketLineObj.mandatory = false;
				component_billingBucketLineObj.quantity = componentObj.defaultQuantity;

				if (bucketLineObj.lineList == null)
					bucketLineObj.lineList = [];
				bucketLineObj.lineList.push(component_billingBucketLineObj);
			});
		}
	});

	// Set last item ordered time
	global_billingBucketObj.orderedOn = tycheesDateTime_getCurrentTimeInMillis();
	
	// Auto-save Billing Bucket
	bil002_saveBucket();

	// Update UI
	bil002_sw001_updateUI();
	bil002_cartPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_bucketList();

	// Hide progress
	tycheesOverlay_stopShortProgress();
} // .end of bil002_cartPanel_insertItemAsBucketLine_postHandler

