
<!-- Modal Window: Edit Billing Field Component -->
<div class="modal inmodal fade" id="set001_document_mw_editBillingField" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
		    	<span class="modal-title">EDIT BILLING FIELD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_editBillingField_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-7">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editBillingField_componentName">
	                                    	<span id="set001_document_mw_editBillingField_componentName_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Object Type</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editBillingField_objectType" disabled>
											<span id="set001_document_mw_editBillingField_objectType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Show Container Box <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="icheck">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_editBillingField_showContainer" value=""> 
	                                        	</label>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div id="set001_document_mw_editBillingField_requireUserInput_component" class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Require User Input <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="icheck">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_document_mw_editBillingField_requireUserInput" value=""> 
	                                        	</label>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Position Vertically After <br>
	                                	</label>
	                                    <div class="col-sm-8">
                                       		<select id="set001_document_mw_editBillingField_afterComponent" class="form-control">
                                       		</select> 
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div id="set001_document_mw_editBillingField_attributes_left">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div id="set001_document_mw_editBillingField_attributes_right">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" onclick="set001_document_mw_editBillingField_delete();">Delete</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_editBillingField_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_editBillingField_initialized = false;
var set001_document_mw_editBillingField_validInput = false;

var set001_document_mw_editBillingField_callbackFn;
var set001_document_mw_editBillingField_templateObj;
var set001_document_mw_editBillingField_componentObj;

function set001_document_mw_editBillingField_isOpen()
{
	return ($("#set001_document_mw_editBillingField").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_editBillingField_isOpen

function set001_document_mw_editBillingField_init()
{
    if (set001_document_mw_editBillingField_initialized == true)
        return false;

    $('.icheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_editBillingField').on('shown.bs.modal', function () {
	    
	});
    
	set001_document_mw_editBillingField_initialized = true;
} // .end of set001_document_mw_editBillingField_init

function set001_document_mw_editBillingField_show(templateObj, componentObj, callbackFn)
{
	// Set callback
	set001_document_mw_editBillingField_callbackFn = callbackFn;
	// Set component
	set001_document_mw_editBillingField_templateObj = templateObj;
	set001_document_mw_editBillingField_componentObj = componentObj;
	// Update UI
	set001_document_mw_editBillingField_updateUI();
} // .end of set001_document_mw_editBillingField_show

function set001_document_mw_editBillingField_updateUI()
{
    set001_document_mw_editBillingField_init();
    
    if (set001_document_mw_editBillingField_componentObj.objectType != DocumentConstants.COMPONENT_OBJECT_TYPE_BILLING_FIELD) {
    	tycheesLogger_showToast('error', 'Invalid Object Type', 'Unable to process object type (' + set001_document_mw_editBillingField_componentObj.objectType + ')');
    	return false;
    }

	var attributesObj = JSON.parse(set001_document_mw_editBillingField_componentObj.attributes);

    $('#set001_document_mw_editBillingField_componentName').val(set001_document_mw_editBillingField_componentObj.name);
    $('#set001_document_mw_editBillingField_objectType').val(set001_document_mw_editBillingField_componentObj.objectType);
    if (attributesObj.showContainer)
    	$('#set001_document_mw_editBillingField_showContainer').iCheck('check');
    else
    	$('#set001_document_mw_editBillingField_showContainer').iCheck('uncheck');
    if (attributesObj.requireUserInput)
    	$('#set001_document_mw_editBillingField_requireUserInput').iCheck('check');
    else
    	$('#set001_document_mw_editBillingField_requireUserInput').iCheck('uncheck');
    
 	// Sorting
 	set001_document_mw_editBillingField_templateObj.componentList.sort(function(a, b) {
 		if (a.name < b.name) return -1;
		if (a.name > b.name) return 1;
		return 0;
 	});
    
    $('#set001_document_mw_editBillingField_afterComponent').empty();
    $('#set001_document_mw_editBillingField_afterComponent').append('<option value="absolute">-- ABSOLUTE POSITION --</option>');
    
    $.each(set001_document_mw_editBillingField_templateObj.componentList, function(i, componentObj) {
    	if (Cached_isDeletedBean(componentObj))
    		return true;
    	
    	if (componentObj.id == set001_document_mw_editBillingField_componentObj.id)
    		return true;
    	
    	var otherAttributesObj = JSON.parse(componentObj.attributes);
    	if (otherAttributesObj.afterComponent == set001_document_mw_editBillingField_componentObj.id) {
    		return true;
		}
    	
    	var selected = '';
    	var afterComponentId = $.trim(attributesObj.afterComponent);
    	if (componentObj.id == afterComponentId)
    		selected = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + componentObj.id + '" ' + selected + '>';
    	htmlLines += componentObj.name;
    	htmlLines += '</option>';
    	
    	$('#set001_document_mw_editBillingField_afterComponent').append(htmlLines);
    });
    
    
	var htmlLines_x1 = '';
	htmlLines_x1 += '<div class="form-group">';
	htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
	htmlLines_x1 += '<div class="col-md-6">';
	htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_editBillingField_x1" value="' + attributesObj.x1 + '">';
	htmlLines_x1 += '<span id="set001_document_mw_editBillingField_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_x1 += '</div>';
	htmlLines_x1 += '</div>';
   
	var htmlLines_y1 = '';
	htmlLines_y1 += '<div class="form-group">';
	htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
	htmlLines_y1 += '<div class="col-md-6">';
	htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_editBillingField_y1" value="' + attributesObj.y1 + '">';
	htmlLines_y1 += '<span id="set001_document_mw_editBillingField_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_y1 += '</div>';
	htmlLines_y1 += '</div>';

	var htmlLines_width = '';
	htmlLines_width += '<div class="form-group">';
	htmlLines_width += '<label class="col-md-6 control-label">Width of Textbox (px)</label>';
	htmlLines_width += '<div class="col-md-6">';
	htmlLines_width += '<input type="number" class="form-control" id="set001_document_mw_editBillingField_width" value="' + attributesObj.width + '">';
	htmlLines_width += '<span id="set001_document_mw_editBillingField_width_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_width += '</div>';
	htmlLines_width += '</div>';

	var htmlLines_padding = '';
	htmlLines_padding += '<div class="form-group">';
	htmlLines_padding += '<label class="col-md-6 control-label">Padding of Textbox</label>';
	htmlLines_padding += '<div class="col-md-6">';
	htmlLines_padding += '<input type="number" class="form-control" id="set001_document_mw_editBillingField_padding" value="' + attributesObj.padding + '">';
	htmlLines_padding += '<span id="set001_document_mw_editBillingField_padding_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_padding += '</div>';
	htmlLines_padding += '</div>';

	var htmlLines_fill = '';
	htmlLines_fill += '<div class="form-group">';
	htmlLines_fill += '<label class="col-md-6 control-label">Fill Color (RGB)</label>';
	htmlLines_fill += '<div class="col-md-6">';
	htmlLines_fill += '<input type="text" class="form-control" id="set001_document_mw_editBillingField_fill" value="' + attributesObj.fill + '">';
	htmlLines_fill += '<span id="set001_document_mw_editBillingField_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_fill += '</div>';
	htmlLines_fill += '</div>';

	var htmlLines_fontFamily = '';
	htmlLines_fontFamily += '<div class="form-group">';
	htmlLines_fontFamily += '<label class="col-md-6 control-label">Font Family</label>';
	htmlLines_fontFamily += '<div class="col-md-6">';
	htmlLines_fontFamily += '<select id="set001_document_mw_editBillingField_fontFamily" class="form-control">';
	if (attributesObj.fontFamily == 'Arial')
		htmlLines_fontFamily += '<option value="Arial" selected>Arial</option>';
	else
		htmlLines_fontFamily += '<option value="Arial">Arial</option>';
	if (attributesObj.fontFamily == 'Calibri')
		htmlLines_fontFamily += '<option value="Calibri" selected>Calibri</option>';
	else
		htmlLines_fontFamily += '<option value="Calibri">Calibri</option>';
	htmlLines_fontFamily += '</select>';
	htmlLines_fontFamily += '<span id="set001_document_mw_editBillingField_fontFamily_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_fontFamily += '</div>';
	htmlLines_fontFamily += '</div>';

	var htmlLines_fontSize = '';
	htmlLines_fontSize += '<div class="form-group">';
	htmlLines_fontSize += '<label class="col-md-6 control-label">Font Size (pt)</label>';
	htmlLines_fontSize += '<div class="col-md-6">';
	htmlLines_fontSize += '<input type="number" class="form-control" id="set001_document_mw_editBillingField_fontSize" value="' + attributesObj.fontSize + '">';
	htmlLines_fontSize += '<span id="set001_document_mw_editBillingField_fontSize_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_fontSize += '</div>';
	htmlLines_fontSize += '</div>';

	var htmlLines_fontStyle = '';
	htmlLines_fontStyle += '<div class="form-group">';
	htmlLines_fontStyle += '<label class="col-md-6 control-label">Font Style</label>';
	htmlLines_fontStyle += '<div class="col-md-6">';
	htmlLines_fontStyle += '<select id="set001_document_mw_editBillingField_fontStyle" class="form-control">';
	if (attributesObj.fontStyle == 'normal')
		htmlLines_fontStyle += '<option value="normal" selected>Normal</option>';
	else
		htmlLines_fontStyle += '<option value="normal">Normal</option>';
	if (attributesObj.fontStyle == 'bold')
		htmlLines_fontStyle += '<option value="bold" selected>Bold</option>';
	else
		htmlLines_fontStyle += '<option value="bold">Bold</option>';
	if (attributesObj.fontStyle == 'italic')
		htmlLines_fontStyle += '<option value="italic" selected>Italic</option>';
	else
		htmlLines_fontStyle += '<option value="italic">Italic</option>';
	htmlLines_fontStyle += '</select>';
	htmlLines_fontStyle += '<span id="set001_document_mw_editBillingField_fontStyle_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_fontStyle += '</div>';
	htmlLines_fontStyle += '</div>';

	var htmlLines_align = '';
	htmlLines_align += '<div class="form-group">';
	htmlLines_align += '<label class="col-md-6 control-label">Text Alignment</label>';
	htmlLines_align += '<div class="col-md-6">';
	htmlLines_align += '<select id="set001_document_mw_editBillingField_align" class="form-control">';
	if (attributesObj.align == 'left')
		htmlLines_align += '<option value="left" selected>Left</option>';
	else
		htmlLines_align += '<option value="left">Left</option>';
	if (attributesObj.align == 'center')
		htmlLines_align += '<option value="center" selected>Center</option>';
	else
		htmlLines_align += '<option value="center">Center</option>';
	if (attributesObj.align == 'right')
		htmlLines_align += '<option value="right" selected>Right</option>';
	else
		htmlLines_align += '<option value="right">Right</option>';
	htmlLines_align += '</select>';
	htmlLines_align += '<span id="set001_document_mw_editBillingField_align_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_align += '</div>';
	htmlLines_align += '</div>';
	
	var htmlLines_fieldType = '';
	htmlLines_fieldType += '<div class="form-group">';
	htmlLines_fieldType += '<label class="col-md-4 control-label">Field Type</label>';
	htmlLines_fieldType += '<div class="col-md-8">';
	htmlLines_fieldType += '<input type="text" class="form-control" id="set001_document_mw_editBillingField_fieldType" value="' + attributesObj.fieldType + '" disabled>';
	htmlLines_fieldType += '<span id="set001_document_mw_editBillingField_fieldType_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
	htmlLines_fieldType += '</div>';
	htmlLines_fieldType += '</div>';
	
	$('#set001_document_mw_editBillingField_attributes_left').empty();
	$('#set001_document_mw_editBillingField_attributes_left').append(htmlLines_fieldType);
	
	$('#set001_document_mw_editBillingField_attributes_right').empty();
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_x1);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_y1);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_width);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_padding);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_fill);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_fontFamily);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_fontSize);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_fontStyle);
	$('#set001_document_mw_editBillingField_attributes_right').append(htmlLines_align);
    
	var attributesObj = JSON.parse(set001_document_mw_editBillingField_componentObj.attributes);
	if (attributesObj.fieldType == 'billing.billingLines') 
	{
		var tableColumns = attributesObj.headerColumns==null ? [] : JSON.parse(attributesObj.headerColumns);
		var columnTypes = ['itemName','quantity','unitPrice','amount','taxAmount','discountAmount','discountAmount','discountPercentage'];
		var columnNames = ['ITEM NAME','QUANTITY','UNIT PRICE','AMOUNT','TAX AMOUNT','TAX PERCENTAGE','DISCOUNT AMOUNT','DISCOUNT PERCENTAGE'];
		
		var htmlLines = '';
		htmlLines += '<div class="row">';
		htmlLines += '<div class="col-md-6" style="padding:0px;">';
		htmlLines += '<div class="ibox">';
		htmlLines += '<div class="ibox-content" style="padding:0px 10px;">';
        htmlLines += '<h3>Hidden Columns</h3>';
       	htmlLines += '<p class="small">';
   		htmlLines += '<i class="fa fa-hand-o-up"></i> Drag task between list';
		htmlLines += '</p>';
		htmlLines += '<ul class="sortable-list connectList agile-list ui-sortable" style="min-height:20px;" id="set001_document_mw_editBillingField_billingLines_leftColumn">';   
		$.each(columnTypes, function(i, columnType) {
			if (tableColumns.indexOf(columnType) == -1) {
				htmlLines += '<li class="success-element" id="' + columnType + '">';
				htmlLines += columnNames[i];	                        
				htmlLines += '</li>';
			}
		});		
		htmlLines += '</ul>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-6" style="padding:0px;">';
		htmlLines += '<div class="ibox">';
		htmlLines += '<div class="ibox-content" style="padding:0px 10px;">';
        htmlLines += '<h3>Selected Columns</h3>';
       	htmlLines += '<p class="small">';
   		htmlLines += '<i class="fa fa-hand-o-up"></i> Drag task between list';
		htmlLines += '</p>';
		htmlLines += '<ul class="sortable-list connectList agile-list ui-sortable" style="min-height:20px;" id="set001_document_mw_editBillingField_billingLines_rightColumn">';                    
		$.each(tableColumns, function(i, tableColumn) {
			var index = columnTypes.indexOf(tableColumn);
			if (index == -1)
				return true;
			
			htmlLines += '<li class="success-element" id="' + columnTypes[index] + '">';
			htmlLines += columnNames[index];	                        
			htmlLines += '</li>';
		});	                 
		htmlLines += '</ul>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		
		$('#set001_document_mw_editBillingField_attributes_left').append(htmlLines);
		
		$("#set001_document_mw_editBillingField_billingLines_leftColumn, #set001_document_mw_editBillingField_billingLines_rightColumn").sortable({
            connectWith: ".connectList",
            update: function( event, ui ) {

                var leftColumn = $( "#set001_document_mw_editBillingField_billingLines_leftColumn" ).sortable( "toArray" );
                var rightColumn = $( "#set001_document_mw_editBillingField_billingLines_rightColumn" ).sortable( "toArray" );
            }
        }).disableSelection();
	}
	if (attributesObj.fieldType == 'billing.paymentList') {
		
		var tableColumns = attributesObj.headerColumns==null ? [] : JSON.parse(attributesObj.headerColumns);
		var columnTypes = ['paymentDate','paymentMethod','paymentAmount'];
		var columnNames = ['PAYMENT DATE','METHOD','AMOUNT'];
		
		var htmlLines = '';
		htmlLines += '<div class="row">';
		htmlLines += '<div class="col-md-6" style="padding:0px;">';
		htmlLines += '<div class="ibox">';
		htmlLines += '<div class="ibox-content" style="padding:0px 10px;">';
        htmlLines += '<h3>Hidden Columns</h3>';
       	htmlLines += '<p class="small">';
   		htmlLines += '<i class="fa fa-hand-o-up"></i> Drag task between list';
		htmlLines += '</p>';
		htmlLines += '<ul class="sortable-list connectList agile-list ui-sortable" style="min-height:20px;" id="set001_document_mw_editBillingField_paymentList_leftColumn">';   
		$.each(columnTypes, function(i, columnType) {
			if (tableColumns.indexOf(columnType) == -1) {
				htmlLines += '<li class="success-element" id="' + columnType + '">';
				htmlLines += columnNames[i];	                        
				htmlLines += '</li>';
			}
		});		
		htmlLines += '</ul>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '<div class="col-md-6" style="padding:0px;">';
		htmlLines += '<div class="ibox">';
		htmlLines += '<div class="ibox-content" style="padding:0px 10px;">';
        htmlLines += '<h3>Selected Columns</h3>';
       	htmlLines += '<p class="small">';
   		htmlLines += '<i class="fa fa-hand-o-up"></i> Drag task between list';
		htmlLines += '</p>';
		htmlLines += '<ul class="sortable-list connectList agile-list ui-sortable" style="min-height:20px;" id="set001_document_mw_editBillingField_paymentList_rightColumn">';                    
		$.each(tableColumns, function(i, tableColumn) {
			var index = columnTypes.indexOf(tableColumn);
			if (index == -1)
				return true;
			
			htmlLines += '<li class="success-element" id="' + columnTypes[index] + '">';
			htmlLines += columnNames[index];	                        
			htmlLines += '</li>';
		});	                 
		htmlLines += '</ul>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		
		$('#set001_document_mw_editBillingField_attributes_left').append(htmlLines);
		
		$("#set001_document_mw_editBillingField_paymentList_leftColumn, #set001_document_mw_editBillingField_paymentList_rightColumn").sortable({
            connectWith: ".connectList",
            update: function( event, ui ) {

                var leftColumn = $( "#set001_document_mw_editBillingField_paymentList_leftColumn" ).sortable( "toArray" );
                var rightColumn = $( "#set001_document_mw_editBillingField_paymentList_rightColumn" ).sortable( "toArray" );
            }
        }).disableSelection();
	}

	if (attributesObj.fieldType == 'billing.quotationDate' ||
		attributesObj.fieldType == 'billing.invoiceDate' ||
		attributesObj.fieldType == 'billing.billingDate') {		
		$('#set001_document_mw_editBillingField_requireUserInput_component').show();
	} else {		
		$('#set001_document_mw_editBillingField_requireUserInput_component').hide();
	}
	
	$('.iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
   	
	$('.summernote').summernote({
        toolbar: false
	});
	
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_editBillingField', true);
} // .end of set001_document_mw_editBillingField_updateUI

function set001_document_mw_editBillingField_delete()
{
	swal({
		title: "Are you sure?",
		text: "You will lose this component (" + set001_document_mw_editBillingField_componentObj.name + ")",
		type: "warning",
		showCancelButton: true,
		confirmButtonColor: "#DD6B55",
		confirmButtonText: "Yes, delete this component!",
		cancelButtonText: "No, cancel please!",
		closeOnConfirm: true,
		closeOnCancel: true
	},
	function(isConfirm) {

		if (isConfirm) {
			// Delete bean
			Cached_deleteBean(set001_document_mw_editBillingField_componentObj);
		    // Close Modal Window
		    $('#set001_document_mw_editBillingField').modal('hide');
		    // Call back
		    if (set001_document_mw_editBillingField_callbackFn != null)
		    	set001_document_mw_editBillingField_callbackFn();
		}
	});
} // .end of set001_document_mw_editBillingField_delete

function set001_document_mw_editBillingField_save()
{
	// reset
    $('.error-msg').hide();
	
	var fieldType = $('#set001_document_mw_editBillingField_fieldType').val();	    	
   	var componentName = $.trim( $('#set001_document_mw_editBillingField_componentName').val() );
   	var x1 = $.trim( $('#set001_document_mw_editBillingField_x1').val() );
	var y1 = $.trim( $('#set001_document_mw_editBillingField_y1').val() );
	var width = $.trim( $('#set001_document_mw_editBillingField_width').val() );
	var padding = $.trim( $('#set001_document_mw_editBillingField_padding').val() );
	var fill = $.trim( $('#set001_document_mw_editBillingField_fill').val() );
	var fontFamily = $.trim( $('#set001_document_mw_editBillingField_fontFamily').val() );
	var fontSize = $.trim( $('#set001_document_mw_editBillingField_fontSize').val() );
	var fontStyle = $.trim( $('#set001_document_mw_editBillingField_fontStyle').val() );
	var align = $.trim( $('#set001_document_mw_editBillingField_align').val() );
    var showContainer = $('#set001_document_mw_editBillingField_showContainer').prop('checked');
    var requireUserInput = $('#set001_document_mw_editBillingField_requireUserInput').prop('checked');
    var positionAfterComponent = $('#set001_document_mw_editBillingField_afterComponent').val();
    
    var selectedColumns = [];
    if (fieldType == 'billing.billingLines')
    	selectedColumns = $( "#set001_document_mw_editBillingField_billingLines_rightColumn" ).sortable( "toArray" );
    if (fieldType == 'billing.paymentList')
    	selectedColumns = $( "#set001_document_mw_editBillingField_paymentList_rightColumn" ).sortable( "toArray" );
    
	if (componentName == '') {
    	$('#set001_document_mw_editBillingField_componentName').focus();
		$('#set001_document_mw_editBillingField_componentName_error').show();
		return false;
	}
	if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_editBillingField_templateObj.width) {
    	$('#set001_document_mw_editBillingField_x1').focus();
		$('#set001_document_mw_editBillingField_x1_error').show();
		return false;
	}
	if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_editBillingField_templateObj.height) {
    	$('#set001_document_mw_editBillingField_y1').focus();
		$('#set001_document_mw_editBillingField_y1_error').show();
		return false;
	}
	if (width == '' || Number(width) < 0) {
    	$('#set001_document_mw_editBillingField_width').focus();
		$('#set001_document_mw_editBillingField_width_error').show();
		return false;
	}
	if (fontSize == '' || Number(fontSize) < 1) {
    	$('#set001_document_mw_editBillingField_width').focus();
		$('#set001_document_mw_editBillingField_width_error').show();
		return false;
	}
	
	// All valid inputs, so proceed to save.
	var attributesObj = new Object();
	attributesObj.fieldType = fieldType;
	attributesObj.x1 = Math.abs(x1);
	attributesObj.y1 = Math.abs(y1);	
	attributesObj.width = Math.abs(width);
	attributesObj.padding = Math.abs(padding);
	attributesObj.fill = fill;
	attributesObj.fontFamily = fontFamily;
	attributesObj.fontSize = fontSize;
	attributesObj.fontStyle = fontStyle;	
	attributesObj.align = align;
	attributesObj.showContainer = showContainer;
	attributesObj.requireUserInput = requireUserInput;
	attributesObj.headerColumns = JSON.stringify(selectedColumns);
	attributesObj.afterComponent = positionAfterComponent;

	if (attributesObj.afterComponent == '' || attributesObj.afterComponent == 'absolute') {
		set001_document_mw_editBillingField_componentObj.seqno = 0;
	} else {
		$.each(set001_document_mw_editBillingField_templateObj.componentList, function(i, componentObj) {
			if (componentObj.id == attributesObj.afterComponent) {
				set001_document_mw_editBillingField_componentObj.seqno = componentObj.seqno + 1;
			}
		});
	}
	
	set001_document_mw_editBillingField_componentObj.name = componentName;
	set001_document_mw_editBillingField_componentObj.attributes = JSON.stringify(attributesObj);
    	
    // Close Modal Window
    $('#set001_document_mw_editBillingField').modal('hide');
    // Call back
    if (set001_document_mw_editBillingField_callbackFn != null)
    	set001_document_mw_editBillingField_callbackFn();
} // .end of set001_document_mw_editBillingField_save

</script>