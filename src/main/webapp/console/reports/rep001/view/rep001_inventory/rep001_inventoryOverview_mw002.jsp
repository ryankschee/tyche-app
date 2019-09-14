
<!-- 
	Modal Window: 	Report Properties
	Report Type:	Zero Sold Items 
-->
<div class="modal inmodal fade" id="rep001_inventoryOverview_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">ZERO SOLD ITEMS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rep001_inventoryOverview_mw002_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<!-- 
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Number of Items</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" id="rep001_inventoryOverview_mw002_itemCount" class="form-control" value="10">
	                                    	<span id="rep001_inventoryOverview_mw002_itemCount_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Key</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                 -->
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Include Item Type</label>
	                                    <div class="col-sm-8 i-check">
	                                    	<div>
	                                    		<input type="checkbox" class="form-control" id="rep001_inventoryOverview_mw002_itemType_raw"> 
	                                    		<label for="rep001_inventoryOverview_mw002_itemType_raw">Raw</label>
	                                    	</div>
	                                    	<div>
	                                    		<input type="checkbox" class="form-control" id="rep001_inventoryOverview_mw002_itemType_product" checked> 
	                                    		<label for="rep001_inventoryOverview_mw002_itemType_product">Product</label>
	                                    	</div>
	                                    	<div>
	                                    		<input type="checkbox" class="form-control" id="rep001_inventoryOverview_mw002_itemType_service" checked>
	                                    		<label for="rep001_inventoryOverview_mw002_itemType_service">Service</label>
	                                    	</div>
	                                    	<div>
	                                    		<input type="checkbox" class="form-control" id="rep001_inventoryOverview_mw002_itemType_event"> 
	                                    		<label for="rep001_inventoryOverview_mw002_itemType_event">Event</label>
	                                    	</div>
	                                    	<div>
	                                    		<input type="checkbox" class="form-control" id="rep001_inventoryOverview_mw002_itemType_discount"> 
	                                    		<label for="rep001_inventoryOverview_mw002_itemType_discount">Discount</label>
	                                    	</div>
	                                    	<div>
	                                    		<input type="checkbox" class="form-control" id="rep001_inventoryOverview_mw002_itemType_tax"> 
	                                    		<label for="rep001_inventoryOverview_mw002_itemType_tax">Tax</label>
	                                    	</div>
	                                    	<span id="rep001_inventoryOverview_mw002_itemType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Please select at least one minimum</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
		    	<button type="button" class="btn btn-primary" onclick="rep001_inventoryOverview_mw002_generate();">Generate Report</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rep001_inventoryOverview_mw002_initialized = false;
var rep001_inventoryOverview_mw002_callback;
var rep001_inventoryOverview_mw002_params;

function rep001_inventoryOverview_mw002_init()
{
    if (rep001_inventoryOverview_mw002_initialized == true)
        return false;
    
    $('.i-check').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
        
    $('#rep001_inventoryOverview_mw002').on('shown.bs.modal', function () {
	    $("#rep001_inventoryOverview_mw002_itemCount").focus();
	});
    
	rep001_inventoryOverview_mw002_initialized = true;
} // .end of rep001_inventoryOverview_mw002_init

function rep001_inventoryOverview_mw002_updateUI(callback, params)
{
    rep001_inventoryOverview_mw002_init();
    
    rep001_inventoryOverview_mw002_callback = callback;
    rep001_inventoryOverview_mw002_params = params;
    
    // Hide error messages
    $('.help-block').hide();
    
    // Show Modal Window
    module_showModalWindow('rep001_inventoryOverview_mw002', true);
} // .end of rep001_inventoryOverview_mw002_updateUI

function rep001_inventoryOverview_mw002_generate()
{
    // Hide error messages
    $('.help-block').hide();
    
    // Get user inputs
    //var itemCount = $('#rep001_inventoryOverview_mw002_itemCount').val();
    var rawChecked = $('#rep001_inventoryOverview_mw002_itemType_raw').prop('checked');
    var productChecked = $('#rep001_inventoryOverview_mw002_itemType_product').prop('checked');
    var serviceChecked = $('#rep001_inventoryOverview_mw002_itemType_service').prop('checked');
    var eventChecked = $('#rep001_inventoryOverview_mw002_itemType_event').prop('checked');
    var discountChecked = $('#rep001_inventoryOverview_mw002_itemType_discount').prop('checked');
    var taxChecked = $('#rep001_inventoryOverview_mw002_itemType_tax').prop('checked');
      
    /*
    if ($.trim(itemCount) === '')
    {
    	$('#rep001_inventoryOverview_mw002_itemCount_error').show();
    	$('#rep001_inventoryOverview_mw002_itemCount').focus();
    	return false;
    }*/
    
    if (!rawChecked && !productChecked && !serviceChecked && !eventChecked && !discountChecked && !taxChecked)
    {
    	$('#rep001_inventoryOverview_mw002_itemType_error').show();
    	return false;
    }
    
    var itemTypeList = [];
    if (rawChecked)
    	itemTypeList.push('raw');
    if (productChecked)
    	itemTypeList.push('product');
    if (serviceChecked)
    	itemTypeList.push('service');
    if (eventChecked)
    	itemTypeList.push('event');
    if (discountChecked)
    	itemTypeList.push('discount');
    if (taxChecked)
    	itemTypeList.push('tax');
    
    // Close Modal Window
    $('#rep001_inventoryOverview_mw002').modal('hide');
        
    rep001_inventoryOverview_mw002_callback(itemTypeList, rep001_inventoryOverview_mw002_params);
} // .end of rep001_inventoryOverview_mw002_generate

</script>