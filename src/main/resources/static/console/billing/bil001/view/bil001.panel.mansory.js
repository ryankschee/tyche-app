
function bil001_mansoryPanel_show() {
	
} // .end of bil001_mansoryPanel_show

/**
 * Initialize masonry .grid, and detect images loaded event.
 */
function init_masonry() {
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
} // .end of init_masonry

function post_masonry() {
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
		var itemObj = Cached_getItemById(itemId, bil001_itemList);
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

	init_masonry();
} // .end of post_masonry

function init_blockView(userLoad) {
	var htmlLines = '';
	htmlLines += '<div class="input-group">';
	htmlLines += '<input id="inputSearchItem" type="text" placeholder="Search SKU code, item name, description" class="input form-control">';
	htmlLines += '<span class="input-group-btn">';
	htmlLines += '<button id="buttonSearchItemStart" type="button" class="btn btn btn-primary"> <i class="fa fa-search"></i> Search</button>';
	htmlLines += '<button id="buttonSearchItemReset" type="button" class="btn btn btn-default"> <i class="fa fa-times"></i> Reset</button>';
	htmlLines += '</span>';
	htmlLines += '</div>';
	htmlLines += '<div class="clients-list" style="margin-top:5px;">';
	htmlLines += '<ul class="nav nav-tabs" id="tab-header">';
	htmlLines += '</ul>';
	htmlLines += '<div class="tab-content" id="tab-content">';
	htmlLines += '</div>';
	htmlLines += '</div>';

	$('#itemView').empty();
	$('#itemView').append(htmlLines);

	$("#inputSearchItem").keyup(function() {
		page_executeAction(PAGE_ACTION_FILTER_SEARCH_TEXT);
	});

	$("#buttonSearchItemStart").click(function() {
		page_executeAction(PAGE_ACTION_FILTER_SEARCH_TEXT);
	});

	$("#buttonSearchItemReset").click(function() {
		page_executeAction(PAGE_ACTION_RESET_SEARCH_TEXT);
	});

	init_categoryPanel_blockView();
	init_itemPanel_blockView();

	global_currentItemViewType = ITEM_VIEW_TYPE_BLOCK;
} // .end of init_blockView

/**
 * Setup category TAB panels
 */
function init_categoryPanel_blockView() {
	var isActive = '-';
	$("#tab-header").empty();
	$("#tab-content").empty();

	$.each(bil001_categoryList, function(i, categoryObj) {

		var itemList = Cached_getItemListByCategoryId(categoryObj.id, true, bil001_itemList);

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
				// Set 'active' to first TAB
				if (isActive == '-')
					isActive = 'active';
				else
					isActive = '';

				var htmlLines = '';
				htmlLines += '<li class="' + isActive + '">';
				htmlLines += '<a data-toggle="tab" href="#tab-' + categoryObj.id + '" style="padding: 5px 10px 5px 10px;" onclick="bil001_loadCategoryView(\'' + categoryObj.id + '\')">';
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
} // .end of init_categoryPanel_blockView

function bil001_loadCategoryView(categoryId) {
	bil001_loadCategoryView_postHandler(categoryId);
} // .end of bil001_loadCategoryView

function bil001_loadCategoryView_postHandler(categoryId) {
	$('#tab-' + categoryId).empty();
	$.each(bil001_itemList, function(i, itemObj) {
		if (itemObj.categoryId == categoryId && itemObj.posVisible == true)
			page_updateItemInMasonry(itemObj);
	});

	post_masonry();

	// Hide progress screen
	tycheesOverlay_stopShortProgress();
} // .end of bil001_loadCategoryView_postHandler

/**
 * Insert items (pos-visible) into category panel.
 */
function init_itemPanel_blockView() {
	// Get filtering text
	var filterText = $.trim($("#inputSearchItem").val());
	// Insert each item into designated category panel
	var addedItemIndex = 0;
	$.each(bil001_itemList, function(index, itemObj) {
		if (itemObj.posVisible == true) {
			if (isItemContainsText(itemObj, filterText) == true) {
				page_updateItemInMasonry(itemObj);
			}
		}
	});

	post_masonry();
} // .end of init_itemPanel_blockView

/**
 * Insert/Update item as masonry .grid-item into billing panel. 
 */
function page_updateItemInMasonry(itemObj) {
	var availability = itemObj.availability;
	var settingsObj_selectedCurrency = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
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
			quantityValue = 'Available';
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
		htmlLines += '<div class="grid-item animation_select" id="grid-' + itemObj.id + '" onclick="page_ctrl_insertItemAsBillingLine(\'' + itemObj.id + '\')" data-animation="rollOut">';
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
		htmlLines += '<a href="#" class="product-name item-name" id="' + itemObj.id + 'Name"> ' + $.trim(itemObj.name) + '</a>';
		htmlLines += '<div class="small m-t-xs item-description">';
		htmlLines += $.trim(itemObj.remarks);
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
} // .end of page_updateItemInMasonry
