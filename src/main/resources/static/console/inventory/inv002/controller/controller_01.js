
function onTransactionCompleted(actionName, nextPage, returnArray)
{
	if (actionName==ACTION_MW001_SAVE) 
	{
		// Repaint UI
		mw001_initUI();
	}
	if (actionName==ACTION_MW001_EXECUTE) 
	{
		// Repaint UI
		mw001_initUI();
	} 
	if (actionName==ACTION_MW001_REVERT) 
	{
		// Repaint UI
		mw001_initUI();
	}
} // .end of onTransactionCompleted

function page_executeAction(actionName, params) 
{
	console.log('page_executeAction >> actionName=' + actionName);
	console.log('page_executeAction >> params=' + params);
	
	if (actionName==ACTION_PAGE_REFRESH) 
	{
		page_updateUI();
	} 
	else
	if (actionName==ACTION_PAGE_EDIT_TRANSACTION) 
	{
		var transactionType = params[0];
		var transactionId = params[1];
		
		openModalWindow_byTransactionType(transactionType, transactionId);	
	} 
	else
	if (actionName==ACTION_PAGE_DELETE_TRANSACTION) 
	{
		var transactionType = params[0];
		var transactionId = params[1];		
		var transactionObj = Cached_getTransactionById(transactionId);
		
		if (transactionObj == null) 
		{
			sweetAlert("Data Error", "Invalid transaction id found.", "error");
			return false;
		}
		
		if (transactionObj.executed == true) 
		{
			sweetAlert("Invalid Request", "Unable to delete transaction.", "error");
			return false;
		}		
		
		swal({   
			title: "Are you sure?",   
			text: "You will not be able to recover this transaction!",   
			type: "warning",   
			showCancelButton: true,   
			confirmButtonColor: "#DD6B55",   
			confirmButtonText: "Yes, delete it!",   
			closeOnConfirm: true 
		}, function() {   
			
	  		// Remove from Cached_transactionList
			Cached_deleteTransactionById( transactionId );
	  		// Remove from local DB
	  		Cached_deleteBean(transactionObj);
			tycheesIO_saveBean(transactionObj);
	  		
			// Repaint UI
			page_updateUI();
			
			// Show toast message
	  		tycheesLogger_showToast("success", "Deleted", "Your inventory transaction has been deleted!");
	  		
		});
	}
} // .end of page_executeAction

function mw001_executeAction(actionName, params)
{
	console.log('mw001_executeAction >> actionName=' + actionName);
	console.log('mw001_executeAction >> params=' + params);
	
	// Reset 
	$('#mw001_itemSelection_errorMessage').html('');
	$('#mw001_itemSelection_errorMessage_frame').hide();
	
	if (actionName==ACTION_MW001_ADD_ITEM) 
	{
		var selectedItemId = $('#mw001_itemSelection').chosen().val();
		var quantity = $('#mw001_itemQuantity').val();
		var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
		var itemObj = Cached_getItemById(selectedItemId);
		
		if (selectedItemId == null || itemObj == null) 
		{
			$('#mw001_itemSelection_errorMessage').html('Invalid selection found. Please select an item before continue.');
			$('#mw001_itemSelection_errorMessage_frame').show();
			return false;
		}
		
		if (quantity == null || quantity == '') 
		{
			$('#mw001_itemSelection_errorMessage').html('Invalid quantity found. Please insert a quantity before continue.');
			$('#mw001_itemSelection_errorMessage_frame').show();
			return false;
		}

		var unitPrice = itemObj.unitPrice;
		var totalAmount = quantity * unitPrice;
		
		// Create object OR reuse object
		var found_transactionLineObj;
		found_transactionLineObj = createNew_InventoryTransactionLine();		
		found_transactionLineObj.transactionId = global_transactionObj.id;
		found_transactionLineObj.itemId = itemObj.id;
		found_transactionLineObj.itemSerialCode = itemObj.serialCode;
		found_transactionLineObj.description = itemObj.description;
		found_transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
		found_transactionLineObj.quantity = quantity;
		found_transactionLineObj.unitPrice = unitPrice;
		found_transactionLineObj.totalPrice = totalAmount;
		
		global_transactionObj.lineList.push(found_transactionLineObj);
		
		// Update UI
		mw001_updateUI_dataTable_transactionLine();
	}
	else
	if (actionName==ACTION_MW001_SUB_ITEM) 
	{
		var selectedItemId = $('#mw001_itemSelection').chosen().val();
		var quantity = $('#mw001_itemQuantity').val();
		var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
		var itemObj = Cached_getItemById(selectedItemId);
		
		if (selectedItemId == null || itemObj == null) 
		{
			$('#mw001_itemSelection_errorMessage').html('Invalid selection found. Please select an item before continue.');
			$('#mw001_itemSelection_errorMessage_frame').show();
			return false;
		}
		
		if (quantity == null || quantity == '') 
		{
			$('#mw001_itemSelection_errorMessage').html('Invalid quantity found. Please insert a quantity before continue.');
			$('#mw001_itemSelection_errorMessage_frame').show();
			return false;
		}

		var unitPrice = itemObj.unitPrice;
		var totalAmount = quantity * unitPrice;
		
		// Create object OR reuse object
		var found_transactionLineObj;
		found_transactionLineObj = createNew_InventoryTransactionLine();		
		found_transactionLineObj.transactionId = global_transactionObj.id;
		found_transactionLineObj.itemId = itemObj.id;
		found_transactionLineObj.itemSerialCode = itemObj.serialCode;
		found_transactionLineObj.description = itemObj.description;
		found_transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
		found_transactionLineObj.quantity = quantity;
		found_transactionLineObj.unitPrice = unitPrice;
		found_transactionLineObj.totalPrice = totalAmount;
		
		global_transactionObj.lineList.push(found_transactionLineObj);
		
		// Update UI
		mw001_updateUI_dataTable_transactionLine();
	}	
	else
	if (actionName==ACTION_MW001_REMOVE_ITEM) 
	{
		var trxLineId = params;		
		
		$.each(global_transactionObj.lineList, function(i, lineObj){
			if (lineObj.id == trxLineId)
			{
				Cached_deleteBean(lineObj);
				
				// Update UI
				mw001_updateUI_dataTable_transactionLine();
			}
		});	
	}
	else
	if (actionName==ACTION_MW001_EXECUTE) 
	{		
		// Apply changes to inventory
		var updatedItemList = applyChanges(global_transactionObj);
		localdb_transaction_save(global_transactionObj, updatedItemList);	
		
		// Repaint page's UI
		page_updateUI();
		// Repaint modal window's UI
		mw001_initUI();
	}
	else
	if (actionName==ACTION_MW001_REVERT) 
	{
		var updatedItemList = revertChanges(global_transactionObj);
		localdb_transaction_save(global_transactionObj, updatedItemList);
		
		// Repaint page's UI
		page_updateUI();
		// Repaint modal window's UI
		mw001_initUI();
	}
	else
	if (actionName==ACTION_MW001_SAVE) 
	{		
		global_transactionObj.remarks = $('#mw001_comments').val();
		
		// Add transaction to list, if not exist
		var trxObj = Cached_getTransactionById(global_transactionObj.id);
		if (trxObj==null) {
			Cached_addTransaction( global_transactionObj );
		}
		
		// Save item
		tycheesIO_saveBean(global_transactionObj);
		// Repaint page's UI
		page_updateUI();
		// Show alert window
		sweetAlert("Saved", "Transaction has been saved successfully.", "success");
	}
	else
	if (actionName==ACTION_MW001_PRINT) 
	{
		console.log('ACTION_MW001_PRINT');
	}
	else
	if (actionName==ACTION_MW001_CLOSE) 
	{
		global_transactionObj = null;
		// Close modal window
		$('#mw001').modal('hide');		
	}
} // .end of mw001_executeAction

function mw002_executeAction(actionName)
{
	if (actionName == ACTION_MW002_SHOW_ITEM_LIST) 
	{
		$('#mw002_itemList').show();
        $('#mw002_vendorList').hide();
        $('#mw002_storeList').hide();
	}
	else
	if (actionName == ACTION_MW002_SHOW_VENDOR_LIST) 
	{
		$('#mw002_itemList').hide();
        $('#mw002_vendorList').show();
        $('#mw002_storeList').hide();
	}
	else
	if (actionName == ACTION_MW002_SHOW_STORE_LIST) 
	{
		$('#mw002_itemList').hide();
        $('#mw002_vendorList').hide();
        $('#mw002_storeList').show();
	}
	else
    if (actionName == ACTION_MW002_RESET_VENDOR) 
    {
    	$('#mw002_vendorName').html('');
        $('#mw002_vendorEmail').html('');
        $('#mw002_vendorAddress').html('');
        $('#mw002_vendorContact').html('');
	}
	else
	if (actionName == ACTION_MW002_RESET_STORE) 
	{
		$('#mw002_storeName').html('');
        $('#mw002_storeEmail').html('');
        $('#mw002_storeAddress').html('');
        $('#mw002_storeContact').html('');
	}
	else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL) 
    {
        $('#mw002_topRightPanel').show();
        $('#mw002_topRightPanel_date').hide();
        $('#mw002_topRightPanel_yourRef').hide();
        $('#mw002_topRightPanel_ourRef').hide();
        $('#mw002_topRightPanel_creditTerm').hide();
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_DATE) 
    {
        $('#mw002_topRightPanel').hide();
        $('#mw002_topRightPanel_date').show();
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_YOUR_REF) 
    {
        $('#mw002_topRightPanel').hide();
        $('#mw002_topRightPanel_yourRef').show();
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_OUR_REF) 
    {
        $('#mw002_topRightPanel').hide();
        $('#mw002_topRightPanel_ourRef').show();
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_CREDIT_TERM) 
    {
        $('#mw002_topRightPanel').hide();
        $('#mw002_topRightPanel_creditTerm').show();
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_DATE) 
    {
    	
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_YOUR_REF) 
    {
    	
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_OUR_REF) 
    {
    	
    }
    else
    if (actionName == ACTION_MW002_SHOW_TOP_RIGHT_PANEL_UPDATE_CREDIT_TERM) 
    {
    	
    }
} // .end of executeAction

function mw003_executeAction(actionName, params)
{
	console.log('mw003_executeAction >> actionName=' + actionName);
	console.log('mw003_executeAction >> params=' + params);
	
	// Reset 
	$('#mw003_itemSelection_errorMessage').html('');
	$('#mw003_itemSelection_errorMessage_frame').hide();
	
	if (actionName==ACTION_MW003_ADD_ITEM) 
	{
		var selectedItemId = $('#mw003_itemSelection').chosen().val();
		var quantity = $('#mw003_itemQuantity').val();
		var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
		var itemObj = Cached_getItemById(selectedItemId);
		
		if (selectedItemId == null || itemObj == null) 
		{
			$('#mw003_itemSelection_errorMessage').html('Invalid selection found. Please select an item before continue.');
			$('#mw003_itemSelection_errorMessage_frame').show();
			return false;
		}
		
		if (quantity == null || quantity == '') 
		{
			$('#mw003_itemSelection_errorMessage').html('Invalid quantity found. Please insert a quantity before continue.');
			$('#mw003_itemSelection_errorMessage_frame').show();
			return false;
		}

		var unitPrice = itemObj.unitPrice;
		var totalAmount = quantity * unitPrice;
		
		// Create object OR reuse object
		var found_transactionLineObj;
		found_transactionLineObj = createNew_InventoryTransactionLine();	
		found_transactionLineObj.transactionId = global_transactionObj.id;
		found_transactionLineObj.itemId = itemObj.id;
		found_transactionLineObj.itemSerialCode = itemObj.serialCode;
		found_transactionLineObj.description = itemObj.description;
		found_transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
		found_transactionLineObj.quantity = quantity;
		found_transactionLineObj.unitPrice = unitPrice;
		found_transactionLineObj.totalPrice = totalAmount;
		
		global_transactionObj.lineList.push(found_transactionLineObj);
		
		// Update UI
		mw003_updateUI_dataTable_transactionLine();
	}
	else
	if (actionName==ACTION_MW003_SUB_ITEM) 
	{
		var selectedItemId = $('#mw003_itemSelection').chosen().val();
		var quantity = $('#mw003_itemQuantity').val();
		var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
		var itemObj = Cached_getItemById(selectedItemId);
		
		if (selectedItemId == null || itemObj == null) 
		{
			$('#mw003_itemSelection_errorMessage').html('Invalid selection found. Please select an item before continue.');
			$('#mw003_itemSelection_errorMessage_frame').show();
			return false;
		}
		
		if (quantity == null || quantity == '') 
		{
			$('#mw003_itemSelection_errorMessage').html('Invalid quantity found. Please insert a quantity before continue.');
			$('#mw003_itemSelection_errorMessage_frame').show();
			return false;
		}

		var unitPrice = itemObj.unitPrice;
		var totalAmount = quantity * unitPrice;
		
		// Create object OR reuse object
		var found_transactionLineObj;
		found_transactionLineObj = createNew_InventoryTransactionLine();	
		found_transactionLineObj.transactionId = global_transactionObj.id;
		found_transactionLineObj.itemId = itemObj.id;
		found_transactionLineObj.itemSerialCode = itemObj.serialCode;
		found_transactionLineObj.description = itemObj.description;
		found_transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
		found_transactionLineObj.quantity = quantity;
		found_transactionLineObj.unitPrice = unitPrice;
		found_transactionLineObj.totalPrice = totalAmount;
		
		global_transactionObj.lineList.push(found_transactionLineObj);
		
		// Update UI
		mw003_updateUI_dataTable_transactionLine();
	}	
	else
	if (actionName==ACTION_MW003_REMOVE_ITEM) 
	{
		var trxLineId = params;		
		
		$.each(global_transactionObj.lineList, function(i, lineObj){
			if (lineObj.id == trxLineId)
			{
				Cached_deleteBean(lineObj);
				// Update UI
				mw003_updateUI_dataTable_transactionLine();
			}
		});	
	}
	else
	if (actionName==ACTION_MW003_EXECUTE) 
	{		
		// Apply changes to inventory
		var updatedItemList = applyChanges(global_transactionObj);
		localdb_transaction_save(global_transactionObj, updatedItemList);
		
		// Repaint page's UI
		page_updateUI();
		// Repaint modal window's UI
		mw003_initUI();
	}
	else
	if (actionName==ACTION_MW003_REVERT) 
	{
		var updatedItemList = revertChanges(global_transactionObj);
		localdb_transaction_save(global_transactionObj, updatedItemList);
		
		// Repaint page's UI
		page_updateUI();
		// Repaint modal window's UI
		mw003_initUI();
	}
	else
	if (actionName==ACTION_MW003_SAVE) 
	{		
		global_transactionObj.remarks = $('#mw003_comments').val();
		
		// Add transaction to list, if not exist
		var trxObj = Cached_getTransactionById(global_transactionObj.id);
		if (trxObj==null) 
		{
			Cached_addTransaction( global_transactionObj );
		}
		
		// Save item
		tycheesIO_saveBean(global_transactionObj);
		// Repaint page's UI
		page_updateUI();
		// Show alert window
		sweetAlert("Saved", "Transaction has been saved successfully.", "success");
	}
	else
	if (actionName==ACTION_MW003_PRINT) 
	{
		console.log('ACTION_MW003_PRINT');
	}
	else
	if (actionName==ACTION_MW003_CLOSE) 
	{
		global_transactionObj = null;
		// Close modal window
		$('#mw003').modal('hide');		
	}
} // .end of mw003_executeAction


function mw004_executeAction(actionName, params)
{
	console.log('mw004_executeAction >> actionName=' + actionName);
	console.log('mw004_executeAction >> params=' + params);
	
	// Reset 
	$('#mw004_itemSelection_errorMessage').html('');
	$('#mw004_itemSelection_errorMessage_frame').hide();
	
	if (actionName==ACTION_MW004_ADD_ITEM) {
		var selectedItemId = $('#mw004_itemSelection').chosen().val();
		var quantity = $('#mw004_itemQuantity').val();
		var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
		var itemObj = Cached_getItemById(selectedItemId);
		
		if (selectedItemId == null || itemObj == null) 
		{
			$('#mw004_itemSelection_errorMessage').html('Invalid selection found. Please select an item before continue.');
			$('#mw004_itemSelection_errorMessage_frame').show();
			return false;
		}
		
		if (quantity == null || quantity == '') 
		{
			$('#mw004_itemSelection_errorMessage').html('Invalid quantity found. Please insert a quantity before continue.');
			$('#mw004_itemSelection_errorMessage_frame').show();
			return false;
		}

		var unitPrice = itemObj.unitPrice;
		var totalAmount = quantity * unitPrice;
		
		// Create object OR reuse object
		var found_transactionLineObj;
		found_transactionLineObj = createNew_InventoryTransactionLine();
		found_transactionLineObj.transactionId = global_transactionObj.id;
		found_transactionLineObj.itemId = itemObj.id;
		found_transactionLineObj.itemSerialCode = itemObj.serialCode;
		found_transactionLineObj.description = itemObj.description;
		found_transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_ADD;
		found_transactionLineObj.quantity = quantity;
		found_transactionLineObj.unitPrice = unitPrice;
		found_transactionLineObj.totalPrice = totalAmount;
		
		global_transactionObj.lineList.push(found_transactionLineObj);
		
		// Update UI
		mw004_updateUI_dataTable_transactionLine();
	}
	else
	if (actionName==ACTION_MW004_SUB_ITEM) 
	{
		var selectedItemId = $('#mw004_itemSelection').chosen().val();
		var quantity = $('#mw004_itemQuantity').val();
		var operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
		var itemObj = Cached_getItemById(selectedItemId);
		
		if (selectedItemId == null || itemObj == null) 
		{
			$('#mw004_itemSelection_errorMessage').html('Invalid selection found. Please select an item before continue.');
			$('#mw004_itemSelection_errorMessage_frame').show();
			return false;
		}
		
		if (quantity == null || quantity == '') 
		{
			$('#mw004_itemSelection_errorMessage').html('Invalid quantity found. Please insert a quantity before continue.');
			$('#mw004_itemSelection_errorMessage_frame').show();
			return false;
		}

		var unitPrice = itemObj.unitPrice;
		var totalAmount = quantity * unitPrice;
		
		// Create object OR reuse object
		var found_transactionLineObj;
		found_transactionLineObj = createNew_InventoryTransactionLine();		
		found_transactionLineObj.transactionId = global_transactionObj.id;
		found_transactionLineObj.itemId = itemObj.id;
		found_transactionLineObj.itemSerialCode = itemObj.serialCode;
		found_transactionLineObj.description = itemObj.description;
		found_transactionLineObj.operator = InventoryConstants.TRANSACTION_LINE_OPERATOR_SUB;
		found_transactionLineObj.quantity = quantity;
		found_transactionLineObj.unitPrice = unitPrice;
		found_transactionLineObj.totalPrice = totalAmount;
		
		global_transactionObj.lineList.push(found_transactionLineObj);
		
		// Update UI
		mw004_updateUI_dataTable_transactionLine();
	}	
	else
	if (actionName==ACTION_MW004_REMOVE_ITEM) 
	{
		var trxLineId = params;	
		
		$.each(global_transactionObj.lineList, function(i, lineObj){
			if (lineObj.id == trxLineId)
			{
				Cached_deleteBean(lineObj);
				// Update UI
				mw004_updateUI_dataTable_transactionLine();
			}
		});			
	}
	else
	if (actionName==ACTION_MW004_EXECUTE) 
	{		
		// Apply changes to inventory
		var updatedItemList = applyChanges(global_transactionObj);
		localdb_transaction_save(global_transactionObj, updatedItemList);
		
		// Repaint page's UI
		page_updateUI();
		// Repaint modal window's UI
		mw004_initUI();
	}
	else
	if (actionName==ACTION_MW004_REVERT) 
	{
		var updatedItemList = revertChanges(global_transactionObj);
		localdb_transaction_save(global_transactionObj, updatedItemList);
		
		// Repaint page's UI
		page_updateUI();
		// Repaint modal window's UI
		mw004_initUI();
	}
	else
	if (actionName==ACTION_MW004_SAVE) 
	{		
		global_transactionObj.remarks = $('#mw004_comments').val();
		
		// Add transaction to list, if not exist
		var trxObj = Cached_getTransactionById(global_transactionObj.id);
		if (trxObj==null) 
		{
			Cached_addTransaction( global_transactionObj );
		}
		
		// Save item
		tycheesIO_saveBean(global_transactionObj);
		// Repaint page's UI
		page_updateUI();
		// Show alert window
		sweetAlert("Saved", "Transaction has been saved successfully.", "success");
	}
	else
	if (actionName==ACTION_MW004_PRINT) 
	{
		console.log('ACTION_MW004_PRINT');
	}
	else
	if (actionName==ACTION_MW004_CLOSE) 
	{
		console.log('ACTION_MW004_CLOSE');
		global_transactionObj = null;
		// Close modal window
		$('#mw004').modal('hide');		
	}
} // .end of mw004_executeAction

function mw005_executeAction(actionName, params)
{
	console.log('mw005_executeAction >> actionName=' + actionName);
	console.log('mw005_executeAction >> params=' + params);
		
	if (actionName==ACTION_MW005_CLOSE) 
	{
		console.log('ACTION_MW005_CLOSE');
		global_transactionObj = null;
		// Close modal window
		$('#mw005').modal('hide');
	}
} // .end of mw005_executeAction

function openModalWindow_byTransactionType(transactionType, transactionId)
{
	console.log('openModalWindow_byTransactionType >> transactionType='+transactionType);
	console.log('openModalWindow_byTransactionType >> transactionId='+transactionId);
	
	if (transactionType==InventoryConstants.TRANSACTION_TYPE_ADJUSTMENT)
	{
		if (transactionId==null) 
		{
			// Instantiate object
			global_transactionObj = createNew_InventoryTransaction();
			global_transactionObj.id = getNextTransactionId( transactionType );
			global_transactionObj.placeId = tycheesCommon_getCurrentPlaceId();
			global_transactionObj.type = transactionType;
		} 
		else 
		{	
			global_transactionObj = Cached_getTransactionById(transactionId);
		}
				
		if (global_transactionObj==null)
			tycheesLogger_showToast('error','Invalid data','Invalid transaction id found. [' + transactionId + ']');
		else
			mw001_initUI();
	}
	
	if (transactionType==InventoryConstants.TRANSACTION_TYPE_PURCHASE)
	{
		if (transactionId==null) 
		{
			// Instantiate object
			global_transactionObj = createNew_InventoryTransaction();
			global_transactionObj.id = getNextTransactionId( transactionType );
			global_transactionObj.placeId = tycheesCommon_getCurrentPlaceId();
			global_transactionObj.type = transactionType;
		} 
		else 
		{	
			global_transactionObj = Cached_getTransactionById(transactionId);
		}
				
		if (global_transactionObj==null)
			tycheesLogger_showToast('error','Invalid data','Invalid transaction id found. [' + transactionId + ']');
		else
			mw002_initUI();
	}

	if (transactionType==InventoryConstants.TRANSACTION_TYPE_TRANSFER)
	{
		if (transactionId==null) 
		{
			// Instantiate object
			global_transactionObj = createNew_InventoryTransaction();
			global_transactionObj.id = getNextTransactionId( transactionType );
			global_transactionObj.placeId = tycheesCommon_getCurrentPlaceId();
			global_transactionObj.type = transactionType;
		} 
		else 
		{	
			global_transactionObj = Cached_getTransactionById(transactionId);
		}
				
		if (global_transactionObj==null)
			tycheesLogger_showToast('error','Invalid data','Invalid transaction id found. [' + transactionId + ']');
		else
			mw003_initUI();
	}

	if (transactionType==InventoryConstants.TRANSACTION_TYPE_LOST)
	{
		if (transactionId==null) 
		{
			// Instantiate object
			global_transactionObj = createNew_InventoryTransaction();
			global_transactionObj.id = getNextTransactionId( transactionType );
			global_transactionObj.placeId = tycheesCommon_getCurrentPlaceId();
			global_transactionObj.type = transactionType;
		} 
		else 
		{	
			global_transactionObj = Cached_getTransactionById(transactionId);
		}
				
		if (global_transactionObj==null)
			tycheesLogger_showToast('error','Invalid data','Invalid transaction id found. [' + transactionId + ']');
		else
			mw004_initUI();		
	}
	
	if (transactionType==InventoryConstants.TRANSACTION_TYPE_BILLING)
	{
		if (transactionId==null) 
		{
			// Instantiate object
			global_transactionObj = createNew_InventoryTransaction();
			global_transactionObj.id = getNextTransactionId( transactionType );
			global_transactionObj.placeId = tycheesCommon_getCurrentPlaceId();
			global_transactionObj.type = transactionType;
		} 
		else 
		{	
			global_transactionObj = Cached_getTransactionById(transactionId);
		}
				
		if (global_transactionObj==null)
			tycheesLogger_showToast('error','Invalid data','Invalid transaction id found. [' + transactionId + ']');
		else
			mw005_initUI();		
	}
} // .end of openModalWindow_byTransactionType


