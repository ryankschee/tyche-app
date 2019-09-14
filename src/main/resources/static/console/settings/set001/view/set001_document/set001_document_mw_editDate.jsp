
<!-- Modal Window: Edit Date Component -->
<div class="modal inmodal fade" id="set001_document_mw_editDate" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
		    	<span class="modal-title">EDIT DATE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_editDate_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-7">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editDate_componentName">
	                                    	<span id="set001_document_mw_editDate_componentName_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Object Type</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editDate_objectType" disabled>
											<span id="set001_document_mw_editDate_objectType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div id="set001_document_mw_editDate_attributes_left">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div id="set001_document_mw_editDate_attributes_right">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" onclick="set001_document_mw_editDate_delete();">Delete</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_editDate_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_editDate_initialized = false;
var set001_document_mw_editDate_validInput = false;

var set001_document_mw_editDate_callbackFn;
var set001_document_mw_editDate_templateObj;
var set001_document_mw_editDate_componentObj;

function set001_document_mw_editDate_isOpen()
{
	return ($("#set001_document_mw_editDate").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_editDate_isOpen

function set001_document_mw_editDate_init()
{
    if (set001_document_mw_editDate_initialized == true)
        return false;

    $('#set001_document_mw_editDate').on('shown.bs.modal', function () {
	    
	});
    
	set001_document_mw_editDate_initialized = true;
} // .end of set001_document_mw_editDate_init

function set001_document_mw_editDate_show(templateObj, componentObj, callbackFn)
{
	// Set callback
	set001_document_mw_editDate_callbackFn = callbackFn;
	// Set component
	set001_document_mw_editDate_templateObj = templateObj;
	set001_document_mw_editDate_componentObj = componentObj;
	// Update UI
	set001_document_mw_editDate_updateUI();
} // .end of set001_document_mw_editDate_show

function set001_document_mw_editDate_updateUI()
{
    set001_document_mw_editDate_init();
    
    $('#set001_document_mw_editDate_componentName').val(set001_document_mw_editDate_componentObj.name);
    $('#set001_document_mw_editDate_objectType').val(set001_document_mw_editDate_componentObj.objectType);
    
    if (set001_document_mw_editDate_componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_DATE) {
		var attributesObj = JSON.parse(set001_document_mw_editDate_componentObj.attributes);
		
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-md-6">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_editDate_x1" value="' + attributesObj.x1 + '">';
		htmlLines_x1 += '<span id="set001_document_mw_editDate_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-md-6">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_editDate_y1" value="' + attributesObj.y1 + '">';
		htmlLines_y1 += '<span id="set001_document_mw_editDate_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_width = '';
		htmlLines_width += '<div class="form-group">';
		htmlLines_width += '<label class="col-md-6 control-label">Width of Textbox (px)</label>';
		htmlLines_width += '<div class="col-md-6">';
		htmlLines_width += '<input type="number" class="form-control" id="set001_document_mw_editDate_width" value="' + attributesObj.width + '">';
		htmlLines_width += '<span id="set001_document_mw_editDate_width_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_width += '</div>';
		htmlLines_width += '</div>';

		var htmlLines_padding = '';
		htmlLines_padding += '<div class="form-group">';
		htmlLines_padding += '<label class="col-md-6 control-label">Padding of Textbox</label>';
		htmlLines_padding += '<div class="col-md-6">';
		htmlLines_padding += '<input type="number" class="form-control" id="set001_document_mw_editDate_padding" value="' + attributesObj.padding + '">';
		htmlLines_padding += '<span id="set001_document_mw_editDate_padding_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_padding += '</div>';
		htmlLines_padding += '</div>';

		var htmlLines_fill = '';
		htmlLines_fill += '<div class="form-group">';
		htmlLines_fill += '<label class="col-md-6 control-label">Fill Color (RGB)</label>';
		htmlLines_fill += '<div class="col-md-6">';
		htmlLines_fill += '<input type="text" class="form-control" id="set001_document_mw_editDate_fill" value="' + attributesObj.fill + '">';
		htmlLines_fill += '<span id="set001_document_mw_editDate_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fill += '</div>';
		htmlLines_fill += '</div>';

		var htmlLines_fontFamily = '';
		htmlLines_fontFamily += '<div class="form-group">';
		htmlLines_fontFamily += '<label class="col-md-6 control-label">Font Family</label>';
		htmlLines_fontFamily += '<div class="col-md-6">';
		htmlLines_fontFamily += '<select id="set001_document_mw_editDate_fontFamily" class="form-control">';
		if (attributesObj.fontFamily == 'Arial')
			htmlLines_fontFamily += '<option value="Arial" selected>Arial</option>';
		else
			htmlLines_fontFamily += '<option value="Arial">Arial</option>';
		if (attributesObj.fontFamily == 'Calibri')
			htmlLines_fontFamily += '<option value="Calibri" selected>Calibri</option>';
		else
			htmlLines_fontFamily += '<option value="Calibri">Calibri</option>';
		htmlLines_fontFamily += '</select>';
		htmlLines_fontFamily += '<span id="set001_document_mw_editDate_fontFamily_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontFamily += '</div>';
		htmlLines_fontFamily += '</div>';

		var htmlLines_fontSize = '';
		htmlLines_fontSize += '<div class="form-group">';
		htmlLines_fontSize += '<label class="col-md-6 control-label">Font Size (pt)</label>';
		htmlLines_fontSize += '<div class="col-md-6">';
		htmlLines_fontSize += '<input type="number" class="form-control" id="set001_document_mw_editDate_fontSize" value="' + attributesObj.fontSize + '">';
		htmlLines_fontSize += '<span id="set001_document_mw_editDate_fontSize_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontSize += '</div>';
		htmlLines_fontSize += '</div>';

		var htmlLines_fontStyle = '';
		htmlLines_fontStyle += '<div class="form-group">';
		htmlLines_fontStyle += '<label class="col-md-6 control-label">Font Style</label>';
		htmlLines_fontStyle += '<div class="col-md-6">';
		htmlLines_fontStyle += '<select id="set001_document_mw_editDate_fontStyle" class="form-control">';
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
		htmlLines_fontStyle += '<span id="set001_document_mw_editDate_fontStyle_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontStyle += '</div>';
		htmlLines_fontStyle += '</div>';

		var htmlLines_align = '';
		htmlLines_align += '<div class="form-group">';
		htmlLines_align += '<label class="col-md-6 control-label">Text Alignment</label>';
		htmlLines_align += '<div class="col-md-6">';
		htmlLines_align += '<select id="set001_document_mw_editDate_align" class="form-control">';
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
		htmlLines_align += '<span id="set001_document_mw_editDate_align_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_align += '</div>';
		htmlLines_align += '</div>';
		
		var htmlLines_format = '';
		htmlLines_format += '<div class="form-group">';
		htmlLines_format += '<label class="col-md-4 control-label">Date Format</label>';
		htmlLines_format += '<div class="col-md-8">';
		htmlLines_format += '<select id="set001_document_mw_editDate_format" class="form-control">';
		if (attributesObj.format == 'DD/MM/YYYY')
			htmlLines_format += '<option value="DD/MM/YYYY" selected>' + tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis()) + '</option>';
		else
			htmlLines_format += '<option value="DD/MM/YYYY">' + tycheesDateTime_getFormattedDate_ddMMyyyy(tycheesDateTime_getCurrentTimeInMillis()) + '</option>';
		if (attributesObj.format == 'MM/DD/YYYY')
			htmlLines_format += '<option value="MM/DD/YYYY" selected>' + tycheesDateTime_getFormattedDate_MMddyyyy(tycheesDateTime_getCurrentTimeInMillis()) + '</option>';
		else
			htmlLines_format += '<option value="MM/DD/YYYY">' + tycheesDateTime_getFormattedDate_MMddyyyy(tycheesDateTime_getCurrentTimeInMillis()) + '</option>';
		if (attributesObj.format == 'MMM DD, YYYY')
			htmlLines_format += '<option value="MMM DD, YYYY" selected>' + tycheesDateTime_getFormattedDate_MMMddyyyy(tycheesDateTime_getCurrentTimeInMillis()) + '</option>';
		else
			htmlLines_format += '<option value="MMM DD, YYYY">' + tycheesDateTime_getFormattedDate_MMMddyyyy(tycheesDateTime_getCurrentTimeInMillis()) + '</option>';
		htmlLines_format += '</select>';
		htmlLines_format += '<span id="set001_document_mw_editDate_format_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_format += '</div>';
		htmlLines_format += '</div>';

		$('#set001_document_mw_editDate_attributes_left').empty();
		$('#set001_document_mw_editDate_attributes_left').append(htmlLines_format);
		
		$('#set001_document_mw_editDate_attributes_right').empty();
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_x1);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_y1);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_width);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_padding);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_fill);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_fontFamily);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_fontSize);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_fontStyle);
		$('#set001_document_mw_editDate_attributes_right').append(htmlLines_align);
    }    	
    
	$('.iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
   	
	$('.summernote').summernote({
        toolbar: false
	});
	
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_editDate', true);
} // .end of set001_document_mw_editDate_updateUI

function set001_document_mw_editDate_delete()
{
	swal({
		title: "Are you sure?",
		text: "You will lose this component (" + set001_document_mw_editDate_componentObj.name + ")",
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
			Cached_deleteBean(set001_document_mw_editDate_componentObj);
		    // Close Modal Window
		    $('#set001_document_mw_editDate').modal('hide');
		    // Call back
		    if (set001_document_mw_editDate_callbackFn != null)
		    	set001_document_mw_editDate_callbackFn();
		}
	});
} // .end of set001_document_mw_editDate_delete

function set001_document_mw_editDate_save()
{
	// reset
    $('.error-msg').hide();
	
    // Shape: DATE
    if (set001_document_mw_editDate_componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_DATE) {
    	var componentName = $.trim( $('#set001_document_mw_editDate_componentName').val() );
    	var x1 = $.trim( $('#set001_document_mw_editDate_x1').val() );
		var y1 = $.trim( $('#set001_document_mw_editDate_y1').val() );
		var width = $.trim( $('#set001_document_mw_editDate_width').val() );
		var padding = $.trim( $('#set001_document_mw_editDate_padding').val() );
		var fill = $.trim( $('#set001_document_mw_editDate_fill').val() );
		var fontFamily = $.trim( $('#set001_document_mw_editDate_fontFamily').val() );
		var fontSize = $.trim( $('#set001_document_mw_editDate_fontSize').val() );
		var fontStyle = $.trim( $('#set001_document_mw_editDate_fontStyle').val() );
		var align = $.trim( $('#set001_document_mw_editDate_align').val() );
		//var complexText = $.trim( $('#set001_document_mw_editDate_text').val() );

		var format = $.trim( $('#set001_document_mw_editDate_format').val() );
		var userInputEnabled = $('#set001_document_mw_editShape_userInputEnabled').prop('checked');
		var defaultValue = $.trim( $('#set001_document_mw_editDate_defaultValue').val() );
		
		if (componentName == '') {
	    	$('#set001_document_mw_editDate_componentName').focus();
			$('#set001_document_mw_editDate_componentName_error').show();
			return false;
		}
		if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_editDate_templateObj.width) {
	    	$('#set001_document_mw_editDate_x1').focus();
			$('#set001_document_mw_editDate_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_editDate_templateObj.height) {
	    	$('#set001_document_mw_editDate_y1').focus();
			$('#set001_document_mw_editDate_y1_error').show();
			return false;
		}
		if (width == '' || Number(width) < 0) {
	    	$('#set001_document_mw_editDate_width').focus();
			$('#set001_document_mw_editDate_width_error').show();
			return false;
		}
		if (fontSize == '' || Number(fontSize) < 1) {
	    	$('#set001_document_mw_editDate_width').focus();
			$('#set001_document_mw_editDate_width_error').show();
			return false;
		}
		
		// All valid inputs, so proceed to save.
		var attributesObj = new Object();
		attributesObj.x1 = Math.abs(x1);
		attributesObj.y1 = Math.abs(y1);	
		attributesObj.width = Math.abs(width);
		attributesObj.padding = Math.abs(padding);
		attributesObj.fill = fill;
		attributesObj.fontFamily = fontFamily;
		attributesObj.fontSize = fontSize;
		attributesObj.fontStyle = fontStyle;	
		attributesObj.align = align;
		attributesObj.format = format;
		
		set001_document_mw_editDate_componentObj.name = componentName;
		set001_document_mw_editDate_componentObj.attributes = JSON.stringify(attributesObj);
    } 
	
    // Close Modal Window
    $('#set001_document_mw_editDate').modal('hide');
    // Call back
    if (set001_document_mw_editDate_callbackFn != null)
    	set001_document_mw_editDate_callbackFn();
} // .end of set001_document_mw_editDate_save

</script>