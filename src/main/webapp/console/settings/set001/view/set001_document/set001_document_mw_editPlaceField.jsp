
<!-- Modal Window: Edit Place Field Component -->
<div class="modal inmodal fade" id="set001_document_mw_editPlaceField" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
		    	<span class="modal-title">EDIT PLACE FIELD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_editPlaceField_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-7">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editPlaceField_componentName">
	                                    	<span id="set001_document_mw_editPlaceField_componentName_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Object Type</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editPlaceField_objectType" disabled>
											<span id="set001_document_mw_editPlaceField_objectType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div id="set001_document_mw_editPlaceField_attributes_left">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div id="set001_document_mw_editPlaceField_attributes_right">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" onclick="set001_document_mw_editPlaceField_delete();">Delete</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_editPlaceField_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_editPlaceField_initialized = false;
var set001_document_mw_editPlaceField_validInput = false;

var set001_document_mw_editPlaceField_callbackFn;
var set001_document_mw_editPlaceField_templateObj;
var set001_document_mw_editPlaceField_componentObj;

function set001_document_mw_editPlaceField_isOpen()
{
	return ($("#set001_document_mw_editPlaceField").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_editPlaceField_isOpen

function set001_document_mw_editPlaceField_init()
{
    if (set001_document_mw_editPlaceField_initialized == true)
        return false;

    $('#set001_document_mw_editPlaceField').on('shown.bs.modal', function () {
	    
	});
    
	set001_document_mw_editPlaceField_initialized = true;
} // .end of set001_document_mw_editPlaceField_init

function set001_document_mw_editPlaceField_show(templateObj, componentObj, callbackFn)
{
	// Set callback
	set001_document_mw_editPlaceField_callbackFn = callbackFn;
	// Set component
	set001_document_mw_editPlaceField_templateObj = templateObj;
	set001_document_mw_editPlaceField_componentObj = componentObj;
	// Update UI
	set001_document_mw_editPlaceField_updateUI();
} // .end of set001_document_mw_editPlaceField_show

function set001_document_mw_editPlaceField_updateUI()
{
    set001_document_mw_editPlaceField_init();
    
    $('#set001_document_mw_editPlaceField_componentName').val(set001_document_mw_editPlaceField_componentObj.name);
    $('#set001_document_mw_editPlaceField_objectType').val(set001_document_mw_editPlaceField_componentObj.objectType);
    
    if (set001_document_mw_editPlaceField_componentObj.objectType != DocumentConstants.COMPONENT_OBJECT_TYPE_PLACE_FIELD) {
    	tycheesLogger_showToast('error', 'Invalid Object Type', 'Unable to process object type (' + set001_document_mw_editPlaceField_componentObj.objectType + ')');
    	return false;
    }

	var attributesObj = JSON.parse(set001_document_mw_editPlaceField_componentObj.attributes);
	
    if (attributesObj.fieldType == 'place.logo') {
    	var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-md-6">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_x1" value="' + attributesObj.x1 + '">';
		htmlLines_x1 += '<span id="set001_document_mw_editPlaceField_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-md-6">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_y1" value="' + attributesObj.y1 + '">';
		htmlLines_y1 += '<span id="set001_document_mw_editPlaceField_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_width = '';
		htmlLines_width += '<div class="form-group">';
		htmlLines_width += '<label class="col-md-6 control-label">Width of Image (px)</label>';
		htmlLines_width += '<div class="col-md-6">';
		htmlLines_width += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_width" value="' + attributesObj.imageWidth + '" oninput="set001_document_mw_editPlaceField_onDimensionChanged(\'width\');">';
		htmlLines_width += '<span id="set001_document_mw_editPlaceField_width_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_width += '</div>';
		htmlLines_width += '</div>';

		var htmlLines_height = '';
		htmlLines_height += '<div class="form-group">';
		htmlLines_height += '<label class="col-md-6 control-label">Height of Image (px)</label>';
		htmlLines_height += '<div class="col-md-6">';
		htmlLines_height += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_height" value="' + attributesObj.imageHeight + '" oninput="set001_document_mw_editPlaceField_onDimensionChanged(\'height\');">';
		htmlLines_height += '<span id="set001_document_mw_editPlaceField_height_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_height += '</div>';
		htmlLines_height += '</div>';

		var htmlLines_fieldType = '';
		htmlLines_fieldType += '<div class="form-group">';
		htmlLines_fieldType += '<label class="col-md-4 control-label">Field Type</label>';
		htmlLines_fieldType += '<div class="col-md-8">';
		htmlLines_fieldType += '<input type="text" class="form-control" id="set001_document_mw_editPlaceField_fieldType" value="' + attributesObj.fieldType + '" disabled>';
		htmlLines_fieldType += '<span id="set001_document_mw_editPlaceField_fieldType_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fieldType += '</div>';
		htmlLines_fieldType += '</div>';
		
		$('#set001_document_mw_editPlaceField_attributes_left').empty();
		$('#set001_document_mw_editPlaceField_attributes_left').append(htmlLines_fieldType);
		
		$('#set001_document_mw_editPlaceField_attributes_right').empty();
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_x1);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_y1);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_width);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_height);

    } else {
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-md-6">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_x1" value="' + attributesObj.x1 + '">';
		htmlLines_x1 += '<span id="set001_document_mw_editPlaceField_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-md-6">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_y1" value="' + attributesObj.y1 + '">';
		htmlLines_y1 += '<span id="set001_document_mw_editPlaceField_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_width = '';
		htmlLines_width += '<div class="form-group">';
		htmlLines_width += '<label class="col-md-6 control-label">Width of Textbox (px)</label>';
		htmlLines_width += '<div class="col-md-6">';
		htmlLines_width += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_width" value="' + attributesObj.width + '">';
		htmlLines_width += '<span id="set001_document_mw_editPlaceField_width_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_width += '</div>';
		htmlLines_width += '</div>';

		var htmlLines_padding = '';
		htmlLines_padding += '<div class="form-group">';
		htmlLines_padding += '<label class="col-md-6 control-label">Padding of Textbox</label>';
		htmlLines_padding += '<div class="col-md-6">';
		htmlLines_padding += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_padding" value="' + attributesObj.padding + '">';
		htmlLines_padding += '<span id="set001_document_mw_editPlaceField_padding_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_padding += '</div>';
		htmlLines_padding += '</div>';

		var htmlLines_fill = '';
		htmlLines_fill += '<div class="form-group">';
		htmlLines_fill += '<label class="col-md-6 control-label">Fill Color (RGB)</label>';
		htmlLines_fill += '<div class="col-md-6">';
		htmlLines_fill += '<input type="text" class="form-control" id="set001_document_mw_editPlaceField_fill" value="' + attributesObj.fill + '">';
		htmlLines_fill += '<span id="set001_document_mw_editPlaceField_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fill += '</div>';
		htmlLines_fill += '</div>';

		var htmlLines_fontFamily = '';
		htmlLines_fontFamily += '<div class="form-group">';
		htmlLines_fontFamily += '<label class="col-md-6 control-label">Font Family</label>';
		htmlLines_fontFamily += '<div class="col-md-6">';
		htmlLines_fontFamily += '<select id="set001_document_mw_editPlaceField_fontFamily" class="form-control">';
		if (attributesObj.fontFamily == 'Arial')
			htmlLines_fontFamily += '<option value="Arial" selected>Arial</option>';
		else
			htmlLines_fontFamily += '<option value="Arial">Arial</option>';
		if (attributesObj.fontFamily == 'Calibri')
			htmlLines_fontFamily += '<option value="Calibri" selected>Calibri</option>';
		else
			htmlLines_fontFamily += '<option value="Calibri">Calibri</option>';
		htmlLines_fontFamily += '</select>';
		htmlLines_fontFamily += '<span id="set001_document_mw_editPlaceField_fontFamily_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontFamily += '</div>';
		htmlLines_fontFamily += '</div>';

		var htmlLines_fontSize = '';
		htmlLines_fontSize += '<div class="form-group">';
		htmlLines_fontSize += '<label class="col-md-6 control-label">Font Size (pt)</label>';
		htmlLines_fontSize += '<div class="col-md-6">';
		htmlLines_fontSize += '<input type="number" class="form-control" id="set001_document_mw_editPlaceField_fontSize" value="' + attributesObj.fontSize + '">';
		htmlLines_fontSize += '<span id="set001_document_mw_editPlaceField_fontSize_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontSize += '</div>';
		htmlLines_fontSize += '</div>';

		var htmlLines_fontStyle = '';
		htmlLines_fontStyle += '<div class="form-group">';
		htmlLines_fontStyle += '<label class="col-md-6 control-label">Font Style</label>';
		htmlLines_fontStyle += '<div class="col-md-6">';
		htmlLines_fontStyle += '<select id="set001_document_mw_editPlaceField_fontStyle" class="form-control">';
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
		htmlLines_fontStyle += '<span id="set001_document_mw_editPlaceField_fontStyle_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontStyle += '</div>';
		htmlLines_fontStyle += '</div>';

		var htmlLines_align = '';
		htmlLines_align += '<div class="form-group">';
		htmlLines_align += '<label class="col-md-6 control-label">Text Alignment</label>';
		htmlLines_align += '<div class="col-md-6">';
		htmlLines_align += '<select id="set001_document_mw_editPlaceField_align" class="form-control">';
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
		htmlLines_align += '<span id="set001_document_mw_editPlaceField_align_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_align += '</div>';
		htmlLines_align += '</div>';
		
		var htmlLines_fieldType = '';
		htmlLines_fieldType += '<div class="form-group">';
		htmlLines_fieldType += '<label class="col-md-4 control-label">Field Type</label>';
		htmlLines_fieldType += '<div class="col-md-8">';
		htmlLines_fieldType += '<input type="text" class="form-control" id="set001_document_mw_editPlaceField_fieldType" value="' + attributesObj.fieldType + '" disabled>';
		htmlLines_fieldType += '<span id="set001_document_mw_editPlaceField_fieldType_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fieldType += '</div>';
		htmlLines_fieldType += '</div>';
		
		$('#set001_document_mw_editPlaceField_attributes_left').empty();
		$('#set001_document_mw_editPlaceField_attributes_left').append(htmlLines_fieldType);
		
		$('#set001_document_mw_editPlaceField_attributes_right').empty();
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_x1);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_y1);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_width);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_padding);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_fill);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_fontFamily);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_fontSize);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_fontStyle);
		$('#set001_document_mw_editPlaceField_attributes_right').append(htmlLines_align);
    }    	
    
	$('.iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
   	
	$('.summernote').summernote({
        toolbar: false
	});
	
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_editPlaceField', true);
} // .end of set001_document_mw_editPlaceField_updateUI

function set001_document_mw_editPlaceField_onDimensionChanged(edge)
{
	if (edge == 'width') {
		var placeObj = tycheesCommon_getCurrentPlaceObject();
		var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
		
		var imageWidth = $('#set001_document_mw_editPlaceField_width').val();
		var imageHeight = tycheesImage_getImageHeightByRatio(companyLogoImageObj.width, companyLogoImageObj.height, imageWidth);
		
		$('#set001_document_mw_editPlaceField_height').val(tycheesMath_round(imageHeight, 0));
	}
	
	if (edge == 'height') {
		var placeObj = tycheesCommon_getCurrentPlaceObject();
		var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
		
		var imageHeight = $('#set001_document_mw_editPlaceField_height').val();
		var imageWidth = tycheesImage_getImageWidthByRatio(companyLogoImageObj.width, companyLogoImageObj.height, imageHeight);
		
		$('#set001_document_mw_editPlaceField_width').val(tycheesMath_round(imageWidth, 0));
	}
} // .end of set001_document_mw_editPlaceField_onDimensionChanged

function set001_document_mw_editPlaceField_delete()
{
	swal({
		title: "Are you sure?",
		text: "You will lose this component (" + set001_document_mw_editPlaceField_componentObj.name + ")",
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
			Cached_deleteBean(set001_document_mw_editPlaceField_componentObj);
		    // Close Modal Window
		    $('#set001_document_mw_editPlaceField').modal('hide');
		    // Call back
		    if (set001_document_mw_editPlaceField_callbackFn != null)
		    	set001_document_mw_editPlaceField_callbackFn();
		}
	});
} // .end of set001_document_mw_editPlaceField_delete

function set001_document_mw_editPlaceField_save()
{
	// reset
    $('.error-msg').hide();
	
	var fieldType = $('#set001_document_mw_editPlaceField_fieldType').val();
	
    // Shape: LOGO
    if (fieldType == 'place.logo') {

    	var componentName = $.trim( $('#set001_document_mw_editPlaceField_componentName').val() );
    	var x1 = $.trim( $('#set001_document_mw_editPlaceField_x1').val() );
		var y1 = $.trim( $('#set001_document_mw_editPlaceField_y1').val() );
		var imageWidth = $.trim( $('#set001_document_mw_editPlaceField_width').val() );
		var imageHeight = $.trim( $('#set001_document_mw_editPlaceField_height').val() );
		
		if (componentName == '') {
	    	$('#set001_document_mw_editPlaceField_componentName').focus();
			$('#set001_document_mw_editPlaceField_componentName_error').show();
			return false;
		}
		if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_editPlaceField_templateObj.width) {
	    	$('#set001_document_mw_editPlaceField_x1').focus();
			$('#set001_document_mw_editPlaceField_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_editPlaceField_templateObj.height) {
	    	$('#set001_document_mw_editPlaceField_y1').focus();
			$('#set001_document_mw_editPlaceField_y1_error').show();
			return false;
		}
		if (imageWidth == '' || Number(imageWidth) < 0) {
	    	$('#set001_document_mw_editPlaceField_width').focus();
			$('#set001_document_mw_editPlaceField_width_error').show();
			return false;
		}
		if (imageHeight == '' || Number(imageHeight) < 0) {
	    	$('#set001_document_mw_editPlaceField_height').focus();
			$('#set001_document_mw_editPlaceField_height_error').show();
			return false;
		}

		// All valid inputs, so proceed to save.
		var attributesObj = new Object();
		attributesObj.fieldType = fieldType;
		attributesObj.x1 = Math.abs(x1);
		attributesObj.y1 = Math.abs(y1);	
		attributesObj.imageWidth = Math.abs(imageWidth);
		attributesObj.imageHeight = Math.abs(imageHeight);
		
		set001_document_mw_editPlaceField_componentObj.name = componentName;
		set001_document_mw_editPlaceField_componentObj.attributes = JSON.stringify(attributesObj);
		
    } else {
    	
    	var componentName = $.trim( $('#set001_document_mw_editPlaceField_componentName').val() );
    	var x1 = $.trim( $('#set001_document_mw_editPlaceField_x1').val() );
		var y1 = $.trim( $('#set001_document_mw_editPlaceField_y1').val() );
		var width = $.trim( $('#set001_document_mw_editPlaceField_width').val() );
		var padding = $.trim( $('#set001_document_mw_editPlaceField_padding').val() );
		var fill = $.trim( $('#set001_document_mw_editPlaceField_fill').val() );
		var fontFamily = $.trim( $('#set001_document_mw_editPlaceField_fontFamily').val() );
		var fontSize = $.trim( $('#set001_document_mw_editPlaceField_fontSize').val() );
		var fontStyle = $.trim( $('#set001_document_mw_editPlaceField_fontStyle').val() );
		var align = $.trim( $('#set001_document_mw_editPlaceField_align').val() );

		if (componentName == '') {
	    	$('#set001_document_mw_editPlaceField_componentName').focus();
			$('#set001_document_mw_editPlaceField_componentName_error').show();
			return false;
		}
		if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_editPlaceField_templateObj.width) {
	    	$('#set001_document_mw_editPlaceField_x1').focus();
			$('#set001_document_mw_editPlaceField_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_editPlaceField_templateObj.height) {
	    	$('#set001_document_mw_editPlaceField_y1').focus();
			$('#set001_document_mw_editPlaceField_y1_error').show();
			return false;
		}
		if (width == '' || Number(width) < 0) {
	    	$('#set001_document_mw_editPlaceField_width').focus();
			$('#set001_document_mw_editPlaceField_width_error').show();
			return false;
		}
		if (fontSize == '' || Number(fontSize) < 1) {
	    	$('#set001_document_mw_editPlaceField_width').focus();
			$('#set001_document_mw_editPlaceField_width_error').show();
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

		set001_document_mw_editPlaceField_componentObj.name = componentName;
		set001_document_mw_editPlaceField_componentObj.attributes = JSON.stringify(attributesObj);
    } 
	
    // Close Modal Window
    $('#set001_document_mw_editPlaceField').modal('hide');
    // Call back
    if (set001_document_mw_editPlaceField_callbackFn != null)
    	set001_document_mw_editPlaceField_callbackFn();
} // .end of set001_document_mw_editPlaceField_save

</script>