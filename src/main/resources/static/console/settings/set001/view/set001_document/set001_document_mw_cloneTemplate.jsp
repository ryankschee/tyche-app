<!-- Modal Window: Clone Document Template -->
<div class="modal inmodal fade" id="set001_document_mw_cloneTemplate" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">CLONE DOCUMENT TEMPLATE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_cloneTemplate_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Template Type</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_cloneTemplate_templateType" disable>
	                                    		<option value="quotation">Sales Quotation</option>
	                                    		<option value="internal">Sales Order for Internal Use</option>
	                                    		<option value="sales_invoice">Sales Invoice</option>
	                                    		<option value="tax_invoice">Tax Invoice</option>
	                                    		<option value="payment_receipt">Payment Receipt</option>
	                                    		<option value="payment_voucher">Payment Voucher</option>
	                                    		<option value="delivery_order">Delivery Order</option>
	                                    		<option value="footer_notes">Footer Notes</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_cloneTemplate_templateType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">
	                                    		Error: Invalid Value
	                                    	</span>
	                                    	<span id="set001_document_mw_cloneTemplate_name_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">
	                                    		Error: Duplicated Value Found.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">New Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_cloneTemplate_name">
	                                    </div>
	                                </div>                       
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Availability <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="set001_document_mw_cloneTemplate_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_cloneTemplate_available" value=""> 
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
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_cloneTemplate_save();">Clone Now</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_cloneTemplate_initialized = false;
var set001_document_mw_cloneTemplate_validInput = false;
var set001_document_mw_cloneTemplate_templateObj;

function set001_document_mw_cloneTemplate_isOpen()
{
	return ($("#set001_document_mw_cloneTemplate").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_cloneTemplate_isOpen

function set001_document_mw_cloneTemplate_init()
{
    if (set001_document_mw_cloneTemplate_initialized == true)
        return false;

    $('.set001_document_mw_cloneTemplate_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_cloneTemplate').on('shown.bs.modal', function () {
	    $("#set001_document_mw_cloneTemplate_name").focus();
	});
    
	set001_document_mw_cloneTemplate_initialized = true;
} // .end of set001_document_mw_cloneTemplate_init

function set001_document_mw_cloneTemplate_show(templateId)
{
    set001_document_mw_cloneTemplate_updateUI(templateId);
} // .end of set001_document_mw_cloneTemplate_show

function set001_document_mw_cloneTemplate_updateUI(templateId)
{
    set001_document_mw_cloneTemplate_init();
    
	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	// Get layout object
	$.each(placeObj.documentTemplateList, function(i, templateObj) {
	    if (templateObj.id == templateId)
	    	set001_document_mw_cloneTemplate_templateObj = templateObj;
	});
	
	if (set001_document_mw_cloneTemplate_templateObj == null)
	{
	    tycheesLogger_logInfo('Unable to find template with id=' + templateId, 'set001_document_mw_cloneTemplate_updateUI');
	    return false;
	}
	else
    {
        // Setup inputs
        $('#set001_document_mw_cloneTemplate_name').val( set001_document_mw_cloneTemplate_templateObj.name + ' (copy)' );
        $('#set001_document_mw_cloneTemplate_templateType').val( set001_document_mw_cloneTemplate_templateObj.templateType );
        if (set001_document_mw_cloneTemplate_templateObj.available == true)
        	$('#set001_document_mw_cloneTemplate_available').iCheck('check');
        else
        	$('#set001_document_mw_cloneTemplate_available').iCheck('uncheck');
        
        // Reset
        $('.help-block').hide();
            
        // Show Modal Window on Top
        module_showModalWindow('set001_document_mw_cloneTemplate', true);
    }
} // .end of set001_document_mw_cloneTemplate_updateUI

function set001_document_mw_cloneTemplate_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_cloneTemplate_name').val() );
    var templateType = $.trim( $('#set001_document_mw_cloneTemplate_templateType').val() );
    var pageType = $.trim( $('#set001_document_mw_cloneTemplate_pageType').val() );
    var width = parseInt( $('#set001_document_mw_cloneTemplate_width').val() );
    var height = parseInt( $('#set001_document_mw_cloneTemplate_height').val() );
    var available = $('#set001_document_mw_cloneTemplate_available').prop('checked');

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_cloneTemplate_name_error').show();
    	$('#set001_document_mw_cloneTemplate_name').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    set001_document_mw_cloneTemplate_validInput = true;
    $.each(placeObj.documentTemplateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	    
    	if (name == $.trim(templateObj.name))
    	{
    		set001_document_mw_cloneTemplate_validInput = false;
    		return false;
    	}
    });
        
    if ( set001_document_mw_cloneTemplate_validInput==false )
    {
    	$('#set001_document_mw_cloneTemplate_name_error_duplication').show();
    	$('#set001_document_mw_cloneTemplate_name').focus();
    	return false;
    }
    
    var newTemplateObj = JSON.parse(JSON.stringify(set001_document_mw_cloneTemplate_templateObj));
    newTemplateObj.id = tycheesCommon_getUniqueId();
    newTemplateObj.name = name;
    newTemplateObj.available = available;
    newTemplateObj.hasChanged = true;
    
    $.each(newTemplateObj.componentList, function(i, componentObj) {
    	if (Cached_isDeletedBean(componentObj))
    		return false;
    	
    	componentObj.id = tycheesCommon_getUniqueId();;
    	componentObj.placeDocumentTemplateId = newTemplateObj.id;
    });
    
    placeObj.documentTemplateList.push(newTemplateObj);

    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Reload UI
    set001_document_updateUI( newTemplateObj.id );

    // Close Modal Window
    $('#set001_document_mw_cloneTemplate').modal('hide');
} // .end of set001_document_mw_cloneTemplate_save

</script>