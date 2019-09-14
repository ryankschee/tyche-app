
<!-- 
    Modal Window: Adjust Quantity of Item 
-->
<div class="modal inmodal fade" id="mw_adjustQuantity" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">ADJUST QUANTITY</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw_adjustQuantity_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-12 col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Item Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_adjustQuantity_itemName" disabled>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Current Quantity</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_adjustQuantity_currentQuantity" disabled>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">To Be Quantity</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_adjustQuantity_futureQuantity" disabled>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Adjustment</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="mw_adjustQuantity_operator" onchange="mw_adjustQuantity_onOperatorChanged();">
	                                    		<option value="add">ADD INTO STOCK</option>
	                                    		<option value="sub">REMOVE FROM STOCK</option>
	                                    	</select>	                                    	
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Quantity</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="mw_adjustQuantity_newQuantity" oninput="mw_adjustQuantity_onQuantityChanged()">
	                                    	<span id="mw_adjustQuantity_newQuantity_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Reason</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="mw_adjustQuantity_reason">
	                                    		<option value="Adhoc Adjustment">Adhoc Adjustment</option>
	                                    		<option value="Stock In">Stock In</option>
	                                    		<option value="Lost">Lost</option>
	                                    		<option value="Transfer">Transfer</option>
	                                    	</select>
	                                    </div>
	                                </div>	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Remarks</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="mw_adjustQuantity_remarks">
	                                    	<span id="mw_adjustQuantity_newBillingNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button id="mw_adjustQuantity_closeButton" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button id="mw_adjustQuantity_saveButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_adjustQuantity_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw_adjustQuantity_initialized = false;
var mw_adjustQuantity_validInput = false;
var mw_adjustQuantity_itemObj;
var mw_adjustQuantity_saveCallbackFn;

function mw_adjustQuantity_isOpen()
{
	return ($("#mw_adjustQuantity").data('bs.modal') || {}).isShown;	
} // .end of mw_adjustQuantity_isOpen

function mw_adjustQuantity_init()
{
    if (mw_adjustQuantity_initialized == true)
        return false;
    
    $('#mw_adjustQuantity').on('shown.bs.modal', function () {
	    //$("#mw_adjustQuantity_newBillingNo").focus();
	});
    
	mw_adjustQuantity_initialized = true;
} // .end of mw_adjustQuantity_init

function mw_adjustQuantity_show(itemObj, saveCallbackFn)
{
	mw_adjustQuantity_itemObj = itemObj;
	mw_adjustQuantity_saveCallbackFn = saveCallbackFn;
	
    mw_adjustQuantity_updateUI();
} // .end of mw_adjustQuantity_show

function mw_adjustQuantity_updateUI()
{
    mw_adjustQuantity_init();
    
    // Setup inputs
    $('#mw_adjustQuantity_itemName').val( mw_adjustQuantity_itemObj.name );
    $('#mw_adjustQuantity_currentQuantity').val( mw_adjustQuantity_itemObj.quantity );
    $('#mw_adjustQuantity_futureQuantity').val( mw_adjustQuantity_itemObj.quantity );
    $('#mw_adjustQuantity_operator').val('add');
    $('#mw_adjustQuantity_newQuantity').val('0')
    $('#mw_adjustQuantity_reason').val('Adhoc Adjustment');
    $('#mw_adjustQuantity_remarks').val('');
        
    // Show Modal Window on Top
    module_showModalWindow('mw_adjustQuantity', true);
} // .end of mw_adjustQuantity_updateUI

function mw_adjustQuantity_onQuantityChanged()
{
	var operator = $('#mw_adjustQuantity_operator').val();
	var quantity = Number($('#mw_adjustQuantity_newQuantity').val());
	var futureQuantity = Number($('#mw_adjustQuantity_currentQuantity').val());
	
	if (operator == 'add') {
		futureQuantity += quantity;
	} else
	if (operator == 'sub') {
		futureQuantity -= quantity;
	}
	
	$('#mw_adjustQuantity_futureQuantity').val(futureQuantity);	
} // .end of mw_adjustQuantity_onQuantityChanged

function mw_adjustQuantity_onOperatorChanged()
{
	var operator = $('#mw_adjustQuantity_operator').val();
	var quantity = Number($('#mw_adjustQuantity_newQuantity').val());
	var futureQuantity = Number($('#mw_adjustQuantity_currentQuantity').val());
	
	if (operator == 'add') {
		futureQuantity += quantity;
	} else
	if (operator == 'sub') {
		futureQuantity -= quantity;
	}
	
	$('#mw_adjustQuantity_futureQuantity').val(futureQuantity);
} // .end of mw_adjustQuantity_onOperatorChanged

function mw_adjustQuantity_save()
{
	// Reset error messages
	$('#mw_adjustQuantity_newQuantity_error').hide();
	
	// Get user inputs
	var operator = $.trim( $('#mw_adjustQuantity_operator').val() );
	var quantity = Number($.trim($('#mw_adjustQuantity_newQuantity').val())=='' ? 0 : $('#mw_adjustQuantity_newQuantity').val());
	var reason = $.trim( $('#mw_adjustQuantity_reason').val() );
	var remarks = $.trim( $('#mw_adjustQuantity_remarks').val() );
		
	if (quantity == 0) {
		$('#mw_adjustQuantity_newQuantity_error').show();
		return false;
	}
	
	$('#mw_adjustQuantity_saveButton').ladda().ladda('start');
	if (operator == 'add') {
		var requestBody = new Object();
		requestBody.appName = APP_NAME_INVENTORY;
		requestBody.itemId = mw_adjustQuantity_itemObj.id;
		requestBody.quantity = quantity;
		requestBody.reason = reason;
		requestBody.remarks = remarks;
		
		var params = new Object();
		params.operator = operator;
		params.newQuantity = mw_adjustQuantity_itemObj.quantity + quantity;
		
		tycheesdb_api_increaseItem(requestBody, mw_adjustQuantity_save_postHander, params);
	} else
	if (operator == 'sub') {
		var requestBody = new Object();
		requestBody.appName = APP_NAME_INVENTORY;
		requestBody.itemId = mw_adjustQuantity_itemObj.id;
		requestBody.quantity = quantity;
		requestBody.reason = reason;
		requestBody.remarks = remarks;
		
		var params = new Object();
		params.operator = operator;
		params.newQuantity = mw_adjustQuantity_itemObj.quantity - quantity;
		
		tycheesdb_api_decreaseItem(requestBody, mw_adjustQuantity_save_postHander, params);
	}
} // .end of mw_adjustQuantity_save

function mw_adjustQuantity_save_postHander(success, responseObj, params)
{
	$('#mw_adjustQuantity_saveButton').ladda().ladda('stop');
	
	if (!success) {
		return false;
	}
	  
    // Close Modal Window
    $('#mw_adjustQuantity').modal('hide');
    // Pass to callback function
    mw_adjustQuantity_saveCallbackFn(mw_adjustQuantity_itemObj.id, mw_adjustQuantity_itemObj.name, params.operator, params.newQuantity);    
} // .end of mw_adjustQuantity_save_postHander

</script>