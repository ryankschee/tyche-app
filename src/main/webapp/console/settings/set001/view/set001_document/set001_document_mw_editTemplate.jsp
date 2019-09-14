<!-- Modal Window: Edit Document Template -->
<div class="modal inmodal fade" id="set001_document_mw_editTemplate" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">EDIT DOCUMENT TEMPLATE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_editTemplate_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editTemplate_name">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Template Type</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_editTemplate_templateType">
	                                    		<option value="quotation">Sales Quotation</option>
	                                    		<option value="internal">Sales Order for Internal Use</option>
	                                    		<option value="sales_invoice">Sales Invoice</option>
	                                    		<option value="tax_invoice">Tax Invoice</option>
	                                    		<option value="payment_receipt">Payment Receipt</option>
	                                    		<option value="payment_voucher">Payment Voucher</option>
	                                    		<option value="delivery_order">Delivery Order</option>
	                                    		<option value="footer_notes">Footer Notes</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_editTemplate_templateType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Page Type</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_editTemplate_pageType" onchange="set001_document_mw_editTemplate_onPageTypeChanged(this);">
	                                    		<option value="a4">A4</option>
	                                    		<option value="custom">Custom</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_editTemplate_pageType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Width (px)</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_document_mw_editTemplate_width">
	                                    	<span id="set001_document_mw_editTemplate_width_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Height (px)</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_document_mw_editTemplate_height">
	                                    	<span id="set001_document_mw_editTemplate_height_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>	                                
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Availability <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="set001_document_mw_editTemplate_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_editTemplate_available" value=""> 
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
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_editTemplate_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_editTemplate_initialized = false;
var set001_document_mw_editTemplate_validInput = false;
var set001_document_mw_editTemplate_templateObj;

function set001_document_mw_editTemplate_isOpen()
{
	return ($("#set001_document_mw_editTemplate").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_editTemplate_isOpen

function set001_document_mw_editTemplate_init()
{
    if (set001_document_mw_editTemplate_initialized == true)
        return false;

    $('.set001_document_mw_editTemplate_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_editTemplate').on('shown.bs.modal', function () {
	    $("#set001_document_mw_editTemplate_name").focus();
	});
    
	set001_document_mw_editTemplate_initialized = true;
} // .end of set001_document_mw_editTemplate_init

function set001_document_mw_editTemplate_show(templateId)
{
    set001_document_mw_editTemplate_updateUI(templateId);
} // .end of set001_document_mw_editTemplate_show

function set001_document_mw_editTemplate_updateUI(templateId)
{
    set001_document_mw_editTemplate_init();
    
	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	// Get layout object
	$.each(placeObj.documentTemplateList, function(i, templateObj) {
	    if (templateObj.id == templateId)
	    	set001_document_mw_editTemplate_templateObj = templateObj;
	});
	
	if (set001_document_mw_editTemplate_templateObj == null)
	{
	    tycheesLogger_logInfo('Unable to find template with id=' + templateId, 'set001_document_mw_editTemplate_updateUI');
	    return false;
	}
	else
    {
        // Setup inputs
        $('#set001_document_mw_editTemplate_name').val( set001_document_mw_editTemplate_templateObj.name );
        $('#set001_document_mw_editTemplate_templateType').val( set001_document_mw_editTemplate_templateObj.templateType );
        $('#set001_document_mw_editTemplate_pageType').val( set001_document_mw_editTemplate_templateObj.pageType );
        $('#set001_document_mw_editTemplate_width').val( set001_document_mw_editTemplate_templateObj.width );
        $('#set001_document_mw_editTemplate_height').val( set001_document_mw_editTemplate_templateObj.height );
        if (set001_document_mw_editTemplate_templateObj.available == true)
        	$('#set001_document_mw_editTemplate_available').iCheck('check');
        else
        	$('#set001_document_mw_editTemplate_available').iCheck('uncheck');
        
        if (set001_document_mw_editTemplate_templateObj.pageType == 'custom') {
        	$('#set001_document_mw_editTemplate_width').attr('disabled', false);
     	    $('#set001_document_mw_editTemplate_height').attr('disabled', false);
        } else {
        	$('#set001_document_mw_editTemplate_width').attr('disabled', true);
    	    $('#set001_document_mw_editTemplate_height').attr('disabled', true);    	    
        }
        
        // Reset
        $('.help-block').hide();
            
        // Show Modal Window on Top
        module_showModalWindow('set001_document_mw_editTemplate', true);
    }
} // .end of set001_document_mw_editTemplate_updateUI

function set001_document_mw_editTemplate_onPageTypeChanged(element)
{
	var selectedValue = $.trim($(element).val());	
	
	if (selectedValue == 'custom') {
	    $('#set001_document_mw_editTemplate_width').attr('disabled', false);
	    $('#set001_document_mw_editTemplate_height').attr('disabled', false);
		
	} else {
	    $('#set001_document_mw_editTemplate_width').attr('disabled', true);
	    $('#set001_document_mw_editTemplate_height').attr('disabled', true);
	    
	    if (selectedValue == 'a4') {
	        $('#set001_document_mw_editTemplate_width').val( '595' );
	        $('#set001_document_mw_editTemplate_height').val( '894' );
	    }
	}
} //.end of set001_document_mw_addTemplate_onPageTypeChanged

function set001_document_mw_editTemplate_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_editTemplate_name').val() );
    var templateType = $.trim( $('#set001_document_mw_editTemplate_templateType').val() );
    var pageType = $.trim( $('#set001_document_mw_editTemplate_pageType').val() );
    var width = parseInt( $('#set001_document_mw_editTemplate_width').val() );
    var height = parseInt( $('#set001_document_mw_editTemplate_height').val() );
    var available = $('#set001_document_mw_editTemplate_available').prop('checked');

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_editTemplate_name_error').show();
    	$('#set001_document_mw_editTemplate_name').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    set001_document_mw_editTemplate_validInput = true;
    $.each(placeObj.documentTemplateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
        if (set001_document_mw_editTemplate_templateObj.id == templateObj.id)
            return true;
    
    	if (name == $.trim(templateObj.name))
    	{
    		set001_document_mw_editTemplate_validInput = false;
    		return false;
    	}
    });
        
    if ( set001_document_mw_editTemplate_validInput==false )
    {
    	$('#set001_document_mw_editTemplate_name_error_duplication').show();
    	$('#set001_document_mw_editTemplate_name').focus();
    	return false;
    }
    
    // Validation #3: non-integer width
    if (width == NaN)
    {
    	$('#set001_document_mw_editTemplate_width_error').show();
    	$('#set001_document_mw_editTemplate_width').focus();
    	return false;
    }
    
    // Validation #4: non-integer height
    if (height == NaN)
    {
    	$('#set001_document_mw_editTemplate_height_error').show();
    	$('#set001_document_mw_editTemplate_height').focus();
    	return false;
    }
    
    // Create layout object    
    set001_document_mw_editTemplate_templateObj.name = name;
    set001_document_mw_editTemplate_templateObj.templateType = templateType;
    set001_document_mw_editTemplate_templateObj.pageType = pageType;
    set001_document_mw_editTemplate_templateObj.width = width;
    set001_document_mw_editTemplate_templateObj.height = height;
    set001_document_mw_editTemplate_templateObj.available = available;
    set001_document_mw_editTemplate_templateObj.hasChanged = true;
    
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Reload UI
    set001_document_updateUI( set001_document_mw_editTemplate_templateObj.id );
    
    // Close Modal Window
    $('#set001_document_mw_editTemplate').modal('hide');
} // .end of set001_document_mw_editTemplate_save

</script>