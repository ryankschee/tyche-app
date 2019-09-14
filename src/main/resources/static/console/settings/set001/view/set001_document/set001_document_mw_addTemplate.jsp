
<!-- Modal Window: New Document Template -->
<div class="modal inmodal fade" id="set001_document_mw_addTemplate" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">NEW DOCUMENT TEMPLATE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_addTemplate_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Template Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_addTemplate_name">
	                                    	<span id="set001_document_mw_addTemplate_name_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="set001_document_mw_addTemplate_name_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div> 	                            	
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Template Type</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_addTemplate_templateType">
	                                    		<option value="quotation">Sales Quotation</option>
	                                    		<option value="internal">Sales Order for Internal Use</option>
	                                    		<option value="sales_invoice">Sales Invoice</option>
	                                    		<option value="tax_invoice">Tax Invoice</option>
	                                    		<option value="payment_receipt">Payment Receipt</option>
	                                    		<option value="payment_voucher">Payment Voucher</option>
	                                    		<option value="delivery_order">Delivery Order</option>
	                                    		<option value="footer_notes">Footer Notes</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_addTemplate_templateType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>       
	                            	<div class="hr-line-dashed"></div>	                    	
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Page Type</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_addTemplate_pageType" onchange="set001_document_mw_addTemplate_onPageTypeChanged(this);">
	                                    		<option value="a4">A4</option>
	                                    		<option value="custom">Custom</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_addTemplate_pageType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Width (px)</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_document_mw_addTemplate_width">
	                                    	<span id="set001_document_mw_addTemplate_width_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Height (px)</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_document_mw_addTemplate_height">
	                                    	<span id="set001_document_mw_addTemplate_height_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Availability <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="set001_document_mw_addTemplate_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_addTemplate_available" value=""> 
	                                        		<i></i> Check it to make it available for selection. 
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
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_addTemplate_save();">
		    		Create Template
		    	</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_addTemplate_initialized = false;
var set001_document_mw_addTemplate_validInput = false;

function set001_document_mw_addTemplate_isOpen()
{
	return ($("#set001_document_mw_addTemplate").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_addTemplate_isOpen

function set001_document_mw_addTemplate_init()
{
    if (set001_document_mw_addTemplate_initialized == true)
        return false;

    $('.set001_document_mw_addTemplate_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_addTemplate').on('shown.bs.modal', function () {
	    $("#set001_document_mw_addTemplate_name").focus();
	});
    
	set001_document_mw_addTemplate_initialized = true;
} // .end of set001_document_mw_addTemplate_init

function set001_document_mw_addTemplate_show()
{
    set001_document_mw_addTemplate_updateUI();
} // .end of set001_document_mw_addTemplate_show

function set001_document_mw_addTemplate_updateUI()
{
    set001_document_mw_addTemplate_init();
    
    // Setup inputs
    $('#set001_document_mw_addTemplate_name').val( '' );
    $('#set001_document_mw_addTemplate_tempplateType').val( 'quotation' );
    $('#set001_document_mw_addTemplate_pageType').val( 'a4' );
    $('#set001_document_mw_addTemplate_width').val( '595' );
    $('#set001_document_mw_addTemplate_height').val( '894' );
    $('#set001_document_mw_addTemplate_available').iCheck('uncheck');
    // Reset
    $('.help-block').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_addTemplate', true);
} // .end of set001_document_mw_addTemplate_updateUI

function set001_document_mw_addTemplate_onPageTypeChanged(element)
{
	var selectedValue = $.trim($(element).val());	
	
	if (selectedValue == 'custom') {
	    $('#set001_document_mw_addTemplate_width').attr('disabled', false);
	    $('#set001_document_mw_addTemplate_height').attr('disabled', false);
		
	} else {
	    $('#set001_document_mw_addTemplate_width').attr('disabled', true);
	    $('#set001_document_mw_addTemplate_height').attr('disabled', true);
	    
	    if (selectedValue == 'a4') {
	        $('#set001_document_mw_addTemplate_width').val( '595' );
	        $('#set001_document_mw_addTemplate_height').val( '894' );
	    }
	}
} //.end of set001_document_mw_addTemplate_onPageTypeChanged

function set001_document_mw_addTemplate_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_addTemplate_name').val() );
    var templateType = $.trim( $('#set001_document_mw_addTemplate_templateType').val() );
    var pageType = $.trim( $('#set001_document_mw_addTemplate_pageType').val() );
    var width = parseInt( $('#set001_document_mw_addTemplate_width').val() );
    var height = parseInt( $('#set001_document_mw_addTemplate_height').val() );
    var available = $('#set001_document_mw_addTemplate_available').prop('checked');
    
	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_addTemplate_name_error').show();
    	$('#set001_document_mw_addTemplate_name').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    set001_document_mw_addTemplate_validInput = true;
    $.each(placeObj.documentTemplateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
    	if (name == $.trim(templateObj.name))
    	{
    		set001_document_mw_addTemplate_validInput = false;
    		return false;
    	}
    });
        
    if ( set001_document_mw_addTemplate_validInput==false )
    {
    	$('#set001_document_mw_addTemplate_name_error_duplication').show();
    	$('#set001_document_mw_addTemplate_name').focus();
    	return false;
    }
    
    // Validation #3: non-integer width
    if (width == NaN)
    {
    	$('#set001_document_mw_addTemplate_width_error').show();
    	$('#set001_document_mw_addTemplate_width').focus();
    	return false;
    }
    
    // Validation #4: non-integer height
    if (height == NaN)
    {
    	$('#set001_document_mw_addTemplate_height_error').show();
    	$('#set001_document_mw_addTemplate_height').focus();
    	return false;
    }
    
    // Create layout object
    var documentTemplateObj = createNew_PlaceDocumentTemplate();     
    documentTemplateObj.name = name;
    documentTemplateObj.templateType = templateType;
    documentTemplateObj.pageType = pageType;
    documentTemplateObj.width = width;
    documentTemplateObj.height = height;
    documentTemplateObj.available = available;    
    // Add to place
    placeObj.documentTemplateList.push( documentTemplateObj );
    
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Reload UI
    set001_document_updateUI( documentTemplateObj.id );
    
    // Close Modal Window
    $('#set001_document_mw_addTemplate').modal('hide');
} // .end of set001_document_mw_addTemplate_save

</script>