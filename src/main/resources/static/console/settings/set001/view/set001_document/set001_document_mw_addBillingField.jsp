
<!-- Modal Window: Add Billing's field -->
<div class="modal inmodal fade" id="set001_document_mw_addBillingField" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">NEW BILLING FIELD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_addBillingField_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Field Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_addBillingField_name">
	                                    	<span id="set001_document_mw_addBillingField_name_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="set001_document_mw_addBillingField_name_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>	                            	
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Source</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_addBillingField_fieldType" onchange="set001_document_mw_addBillingField_onFieldTypeChanged(this);">
	                                    		<option value="billing.billingNo">Billing No</option>
	                                    		<option value="billing.billingDate">Billing Date</option>
	                                    		<option value="billing.invoiceNo">Invoice No</option>
	                                    		<option value="billing.invoiceDate">Invoice Date</option>
	                                    		<option value="billing.quotationNo">Quotation No</option>
	                                    		<option value="billing.quotationDate">Quotation Date</option>
	                                    		<option value="billing.customerName">Customer Name</option>
	                                    		<option value="billing.salesPersonName">Sales Person Name</option>
	                                    		<option value="billing.billingLines">Billing Items</option>
	                                    		<option value="billing.paymentList">Payment List</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_addBillingField_fieldType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div id="set001_document_mw_addBillingField_preview" style="display:none;">
	                                	<div class="form-group">
		                                	<label class="col-sm-4 control-label">Preview</label>
		                                    <div class="col-sm-8">
		                                    	<input type="text" class="form-control" id="set001_document_mw_addBillingField_fieldPreview" disabled>
		                                    </div>
		                                </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Show Container Box <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="icheck">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_addBillingField_showContainer" value=""> 
	                                        	</label>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div id="set001_document_mw_addBillingField_requireUserInput_component" class="form-group" style="display:none;">
	                                	<label class="col-sm-4 control-label">
	                                		Require User Input? <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="icheck">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_addBillingField_requireUserInput"> 
	                                        	</label>
	                                        </div>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">
		    		Close
		    	</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_addBillingField_save();">
		    		Add Field
		    	</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_addBillingField_initialized = false;
var set001_document_mw_addBillingField_validInput = false;
var set001_document_mw_addBillingField_saveCallbackFn;

function set001_document_mw_addBillingField_isOpen()
{
	return ($("#set001_document_mw_addBillingField").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_addBillingField_isOpen

function set001_document_mw_addBillingField_init()
{
    if (set001_document_mw_addBillingField_initialized == true)
        return false;

    $('.icheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_addBillingField').on('shown.bs.modal', function () {
	    $("#set001_document_mw_addBillingField_name").focus();
	});
    
	set001_document_mw_addBillingField_initialized = true;
} // .end of set001_document_mw_addBillingField_init

function set001_document_mw_addBillingField_show(callbackFn)
{
	set001_document_mw_addBillingField_saveCallbackFn = callbackFn;
	
    set001_document_mw_addBillingField_updateUI();
} // .end of set001_document_mw_addBillingField_show

function set001_document_mw_addBillingField_updateUI()
{
    set001_document_mw_addBillingField_init();
    
    // Setup inputs
    $('#set001_document_mw_addBillingField_name').val( '' );
    $('#set001_document_mw_addBillingField_fieldType').val( 'billing.billingNo' );
    $('#set001_document_mw_addBillingField_showContainer').prop('checked', false);
    $('#set001_document_mw_addBillingField_requireUserInput').prop('checked', false);
    // Reset
    $('.help-block').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_addBillingField', true);
} // .end of set001_document_mw_addBillingField_updateUI

function set001_document_mw_addBillingField_onFieldTypeChanged(element)
{
	var selectedValue = $.trim($(element).val());	
    
	if (selectedValue == 'billing.quotationDate' ||
		selectedValue == 'billing.invoiceDate' ||
		selectedValue == 'billing.billingDate') {		
		$('#set001_document_mw_addBillingField_requireUserInput_component').show();
	} else {		
		$('#set001_document_mw_addBillingField_requireUserInput_component').hide();
	}
	
} //.end of set001_document_mw_addBillingField_onPageTypeChanged

function set001_document_mw_addBillingField_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_addBillingField_name').val() );
    var fieldType = $.trim( $('#set001_document_mw_addBillingField_fieldType').val() );
    var showContainer = $('#set001_document_mw_addBillingField_showContainer').prop('checked');
    var requireUserInput = $('#set001_document_mw_addBillingField_requireUserInput').prop('checked');

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_addBillingField_name_error').show();
    	$('#set001_document_mw_addBillingField_name').focus();
    	return false;
    }
    
	// https://konvajs.github.io/api/Konva.Text.html
	var attributesObj = new Object();
	attributesObj.fieldType = fieldType;
	attributesObj.x1 = 50;
	attributesObj.y1 = 50;
	attributesObj.fill = '#555';
	attributesObj.fontFamily = 'Arial';
	attributesObj.fontSize = 16;
	attributesObj.fontStyle = 'normal';		
	attributesObj.width = 100;
	attributesObj.padding = 0;
	attributesObj.align = 'left';	
	attributesObj.showContainer = showContainer;
	attributesObj.requireUserInput = requireUserInput;
		
	var componentObj = createNew_PlaceDocumentTemplateComponent();
	componentObj.name = name;
	componentObj.objectType = DocumentConstants.COMPONENT_OBJECT_TYPE_BILLING_FIELD;
	componentObj.attributes = JSON.stringify(attributesObj);
    	
    // Close Modal Window
    $('#set001_document_mw_addBillingField').modal('hide');
    
    if (set001_document_mw_addBillingField_saveCallbackFn != null)
    	set001_document_mw_addBillingField_saveCallbackFn(componentObj);
} // .end of set001_document_mw_addBillingField_save

</script>