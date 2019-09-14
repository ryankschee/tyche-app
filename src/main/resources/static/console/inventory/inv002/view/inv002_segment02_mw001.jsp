<!-- Modal Window: Clone Item -->
<div class="modal inmodal fade" id="segment02_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">CLONE ITEM</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
				<div class="modal-body">
					<div class="ibox-title">
						<h5>Please enter new name for clone item.</h5>
					</div>
					<div class="ibox-content">
						<div class="form-group">
							<label>New Item Name:</label> 
							<input id="segment02_mw001_itemName" type="text" placeholder="Enter item name" class="form-control">
						</div>
					</div>
					<div class="ibox-content">
						<div class="form-group">
							<label>Clone from Item:</label> 
							<input id="segment02_mw001_cloneFromItem" type="text" class="form-control" disabled>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
					<button type="button" class="btn btn-primary" onclick="segment02_mw001_create();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Clone Now</button>
				</div>
			</div>
		</div>
	</div>

<script>

var segment02_mw001_callbackFn;
var segment02_mw001_callbackFnParams;
var segment02_mw001_itemObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment02_mw001_isOpen()
{
	return ($("#segment02_mw001").data('bs.modal') || {}).isShown;	
} // .end of segment02_mw001_isOpen

/**
 * Modal Window Init.
 */
function segment02_mw001_init()
{
	$('#segment02_mw001').on('shown.bs.modal', function () {
	    $("#segment02_mw001_itemName").focus();
	})
} // .end of segment02_mw001_init

/**
 * Open Modal Window
 */
function segment02_mw001_open(postHandlerFn, params)
{
	tycheesOverlay_startShortProgress('loading...');
	
	// Callback
	segment02_mw001_callbackFn 		 = postHandlerFn;
	segment02_mw001_callbackFnParams = params;
	
	// Init
	segment02_mw001_init();
	
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_INVENTORY,
			'itemId': segment02_mw001_callbackFnParams.itemId,
			'fullBean': true
		};

	var params = new Object();
	params.itemId = segment02_mw001_callbackFnParams.itemId;
	params.newItemName = $("#segment02_mw001_itemName").val();
	
	tycheesdb_api_getItemById(requestBody, segment02_mw001_open_postHandler, params);
	
} // .end of segment02_mw001_open

function segment02_mw001_open_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false)
		return false;
		
	segment02_mw001_itemObj = responseObj.itemObj;
		
	// Reset
	$('#segment02_mw001_itemName').val('');
	$('#segment02_mw001_cloneFromItem').val( responseObj.itemObj.name );

	tycheesOverlay_stopShortProgress();
	
	// Show Modal Window
	module_showModalWindow('segment02_mw001', true);
} // .end of segment02_mw001_open_postHandler

/**
 * Clone Item
 */
function segment02_mw001_create()
{
	//var itemList = Cached_getItemListByCategoryId( segment02_mw001_itemObj.categoryId );
	var categoryObj = Cached_getCategoryById( segment02_mw001_itemObj.categoryId );
	var newItemName = $.trim( $('#segment02_mw001_itemName').val() );
	
	// Validation
	var validationFlag = true;
	if ($.trim(newItemName)=='')
	{
		validationFlag = false;
		tycheesLogger_showToast('error','Invalid Name', 'The name must be at least one character.')
	}
	
	if (newItemName==segment02_mw001_itemObj.name)
	{
		validationFlag = false;
		tycheesLogger_showToast('error','Invalid Name', 'The name must be different from current item.')
	}
	
	// Cloning starts
	if (validationFlag==true)
	{
		// Hide window
		$("#segment02_mw001").modal("hide");
		
		// Clone new object
		var newItemObj = tycheesCommon_cloneObject(segment02_mw001_itemObj);
		newItemObj.id = tycheesCommon_getUniqueId();
		newItemObj.name = tycheesText_getSafeString(newItemName);
		//newItemObj.seqnoInGroup = itemList.length + 1;
		newItemObj.seqnoInGroup = categoryObj.itemSize + 1;
		
		$.each(newItemObj.propertiesList, function(i, propObj) {
			propObj.id = 'FIELD-' + tycheesCommon_getUniqueId() + '-' + i;
			propObj.hasChanged = true;
		});
		
		$.each(newItemObj.componentList, function(i, componentObj) {
			componentObj.id = 'COMPONENT-' + tycheesCommon_getUniqueId() + '-' + i;
			componentObj.hasChanged = true;
		});
		
		$.each(newItemObj.imageList, function(i, imageObj){
			imageObj.id = 'IMAGE-' + tycheesCommon_getUniqueId() + '-' + i;
			imageObj.hasChanged = true;
		});

		// ADD to current itemList
		Cached_addItem( newItemObj );
		// Write to IDB
		tycheesIO_saveBean(newItemObj);
	}
	
	// Invoke Callback
	segment02_mw001_callbackFnParams.newItemObj = newItemObj;
	segment02_mw001_callbackFn(true, segment02_mw001_callbackFnParams);
} // .end of segment02_mw001_create_postHandler

</script>