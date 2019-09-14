
<!-- Modal Window: Add Template Component -->
<div class="modal inmodal fade" id="set001_document_mw_addShape" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
		    	<span class="modal-title">ADD COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_addShape_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-7">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_addShape_componentName">
	                                    	<span id="set001_document_mw_addShape_componentName_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Object Type</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_addShape_objectType" disabled>
											<span id="set001_document_mw_addShape_objectType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div id="set001_document_mw_addShape_componentAttributes_left_top">
	                            	</div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div id="set001_document_mw_addShape_componentAttributes_left_bottom">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-5">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div id="set001_document_mw_addShape_componentAttributes_right">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" onclick="set001_document_mw_addShape_cancel();">Cancel</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_addShape_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_addShape_initialized = false;
var set001_document_mw_addShape_validInput = false;

var set001_document_mw_addShape_callbackFn;
var set001_document_mw_addShape_templateObj;
var set001_document_mw_addShape_componentType;

function set001_document_mw_addShape_isOpen()
{
	return ($("#set001_document_mw_addShape").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_addShape_isOpen

function set001_document_mw_addShape_init()
{
    if (set001_document_mw_addShape_initialized == true)
        return false;

    $('#set001_document_mw_addShape').on('shown.bs.modal', function () {
        // Set focus
        $('#set001_document_mw_addShape_componentName').focus();	    
	});
    
	set001_document_mw_addShape_initialized = true;
} // .end of set001_document_mw_addShape_init

function set001_document_mw_addShape_show(templateObj, componentType, callbackFn)
{
	// Set callback
	set001_document_mw_addShape_callbackFn = callbackFn;
	// Set component
	set001_document_mw_addShape_templateObj = templateObj;
	set001_document_mw_addShape_componentType = componentType;
	// Update UI
	set001_document_mw_addShape_updateUI();
} // .end of set001_document_mw_addShape_show

function set001_document_mw_addShape_updateUI()
{
    set001_document_mw_addShape_init();
    
    $('#set001_document_mw_addShape_componentName').val('');
    $('#set001_document_mw_addShape_objectType').val(set001_document_mw_addShape_componentType);
    
    if (set001_document_mw_addShape_componentType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {
    	// https://konvajs.github.io/api/Konva.Text.html
    	var attributesObj = new Object();
    	attributesObj.x1 = 50;
    	attributesObj.y1 = 50;
    	attributesObj.text = 'Sample Text';
    	attributesObj.fill = '#555';
    	attributesObj.fontFamily = 'Arial';
    	attributesObj.fontSize = 16;
    	attributesObj.fontStyle = 'normal';		
    	attributesObj.width = 100;
    	attributesObj.padding = 0;
    	attributesObj.align = 'left';
    	
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-md-6">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_addShape_x1" value="' + attributesObj.x1 + '">';
		htmlLines_x1 += '<span id="set001_document_mw_addShape_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-md-6">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_addShape_y1" value="' + attributesObj.y1 + '">';
		htmlLines_y1 += '<span id="set001_document_mw_addShape_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_width = '';
		htmlLines_width += '<div class="form-group">';
		htmlLines_width += '<label class="col-md-6 control-label">Width of Textbox (px)</label>';
		htmlLines_width += '<div class="col-md-6">';
		htmlLines_width += '<input type="number" class="form-control" id="set001_document_mw_addShape_width" value="' + attributesObj.width + '">';
		htmlLines_width += '<span id="set001_document_mw_addShape_width_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_width += '</div>';
		htmlLines_width += '</div>';

		var htmlLines_padding = '';
		htmlLines_padding += '<div class="form-group">';
		htmlLines_padding += '<label class="col-md-6 control-label">Padding of Textbox</label>';
		htmlLines_padding += '<div class="col-md-6">';
		htmlLines_padding += '<input type="number" class="form-control" id="set001_document_mw_addShape_padding" value="' + attributesObj.padding + '">';
		htmlLines_padding += '<span id="set001_document_mw_addShape_padding_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_padding += '</div>';
		htmlLines_padding += '</div>';

		var htmlLines_fill = '';
		htmlLines_fill += '<div class="form-group">';
		htmlLines_fill += '<label class="col-md-6 control-label">Fill Color (RGB)</label>';
		htmlLines_fill += '<div class="col-md-6">';
		htmlLines_fill += '<input type="text" class="form-control" id="set001_document_mw_addShape_fill" value="' + attributesObj.fill + '">';
		htmlLines_fill += '<span id="set001_document_mw_addShape_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fill += '</div>';
		htmlLines_fill += '</div>';

		var htmlLines_fontFamily = '';
		htmlLines_fontFamily += '<div class="form-group">';
		htmlLines_fontFamily += '<label class="col-md-6 control-label">Font Family</label>';
		htmlLines_fontFamily += '<div class="col-md-6">';
		htmlLines_fontFamily += '<select id="set001_document_mw_addShape_fontFamily" class="form-control">';
		if (attributesObj.fontFamily == 'Arial')
			htmlLines_fontFamily += '<option value="Arial" selected>Arial</option>';
		else
			htmlLines_fontFamily += '<option value="Arial">Arial</option>';
		if (attributesObj.fontFamily == 'Calibri')
			htmlLines_fontFamily += '<option value="Calibri" selected>Calibri</option>';
		else
			htmlLines_fontFamily += '<option value="Calibri">Calibri</option>';
		htmlLines_fontFamily += '</select>';
		htmlLines_fontFamily += '<span id="set001_document_mw_addShape_fontFamily_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontFamily += '</div>';
		htmlLines_fontFamily += '</div>';

		var htmlLines_fontSize = '';
		htmlLines_fontSize += '<div class="form-group">';
		htmlLines_fontSize += '<label class="col-md-6 control-label">Font Size (pt)</label>';
		htmlLines_fontSize += '<div class="col-md-6">';
		htmlLines_fontSize += '<input type="number" class="form-control" id="set001_document_mw_addShape_fontSize" value="' + attributesObj.fontSize + '">';
		htmlLines_fontSize += '<span id="set001_document_mw_addShape_fontSize_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontSize += '</div>';
		htmlLines_fontSize += '</div>';

		var htmlLines_fontStyle = '';
		htmlLines_fontStyle += '<div class="form-group">';
		htmlLines_fontStyle += '<label class="col-md-6 control-label">Font Style</label>';
		htmlLines_fontStyle += '<div class="col-md-6">';
		htmlLines_fontStyle += '<select id="set001_document_mw_addShape_fontStyle" class="form-control">';
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
		htmlLines_fontStyle += '<span id="set001_document_mw_addShape_fontStyle_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fontStyle += '</div>';
		htmlLines_fontStyle += '</div>';

		var htmlLines_align = '';
		htmlLines_align += '<div class="form-group">';
		htmlLines_align += '<label class="col-md-6 control-label">Text Alignment</label>';
		htmlLines_align += '<div class="col-md-6">';
		htmlLines_align += '<select id="set001_document_mw_addShape_align" class="form-control">';
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
		htmlLines_align += '<span id="set001_document_mw_addShape_align_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_align += '</div>';
		htmlLines_align += '</div>';

		var htmlLines_text = '';
		htmlLines_text += '<div class="form-group" style="height:300px;">';
		htmlLines_text += '<div class="col-md-12" style="height:100%;">';
		htmlLines_text += '<textarea rows="4" cols="50" class="form-control" id="set001_document_mw_addShape_text" style="height:100%;">' + attributesObj.text + '</textarea>';
		htmlLines_text += '<span id="set001_document_mw_addShape_text_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_text += '</div>';
		htmlLines_text += '</div>';
		
		var htmlLines_requireUserInput = '';
		htmlLines_requireUserInput += '<div class="form-group">';
		htmlLines_requireUserInput += '<label class="col-sm-4 control-label">';
		htmlLines_requireUserInput += 'Require User Input? <br>';
		htmlLines_requireUserInput += '</label>';
		htmlLines_requireUserInput += '<div class="col-sm-8">';
		htmlLines_requireUserInput += '<div class="iCheck">';
		htmlLines_requireUserInput += '<label>';
		htmlLines_requireUserInput += '<input type="checkbox" id="set001_document_mw_addShape_requireUserInput">'; 
		htmlLines_requireUserInput += '</label>';
		htmlLines_requireUserInput += '</div>';
		htmlLines_requireUserInput += '</div>';
		htmlLines_requireUserInput += '</div>';

		var htmlLines_afterComponent = '';
		htmlLines_afterComponent += '<div class="form-group">';
		htmlLines_afterComponent += '<label class="col-sm-4 control-label">';
		htmlLines_afterComponent += 'Position Vertically After <br>';
		htmlLines_afterComponent += '</label>';
		htmlLines_afterComponent += '<div class="col-sm-8">';
		htmlLines_afterComponent += '<select id="set001_document_mw_addShape_afterComponent" class="form-control">';
		htmlLines_afterComponent += '<option value="absolute">-- ABSOLUTE POSITION --</option>';
		
		$.each(set001_document_mw_addShape_templateObj.componentList, function(i, componentObj) {
	    	if (Cached_isDeletedBean(componentObj))
	    		return true;
	    	
	    	var htmlLines = '';
	    	htmlLines += '<option value="' + componentObj.id + '">';
	    	htmlLines += componentObj.name;
	    	htmlLines += '</option>';
	    	
	    	htmlLines_afterComponent += htmlLines;
	    });
		
		htmlLines_afterComponent += '</select>';
		htmlLines_afterComponent += '</div>';
		htmlLines_afterComponent += '</div>';
		
		$('#set001_document_mw_addShape_componentAttributes_left_top').empty();
		$('#set001_document_mw_addShape_componentAttributes_left_top').append(htmlLines_requireUserInput);
		$('#set001_document_mw_addShape_componentAttributes_left_top').append(htmlLines_afterComponent);
		$('#set001_document_mw_addShape_componentAttributes_left_bottom').empty();
		$('#set001_document_mw_addShape_componentAttributes_left_bottom').append(htmlLines_text);
		
		$('#set001_document_mw_addShape_componentAttributes_right').empty();
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_x1);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_y1);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_width);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_padding);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_fill);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_fontFamily);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_fontSize);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_fontStyle);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_align);
    }    	
    
    if (set001_document_mw_addShape_componentType == DocumentConstants.COMPONENT_OBJECT_TYPE_LINE) {
    	// https://konvajs.github.io/api/Konva.Line.html
    	var attributesObj = new Object();
    	attributesObj.x1 = 50;
    	attributesObj.y1 = 50;
    	attributesObj.x2 = set001_document_documentTemplateObj.width - 50;
    	attributesObj.y2 = 50;
    	attributesObj.stroke = '#555';
    	attributesObj.strokeWidth = '2';
    	attributesObj.lineCap = 'butt'; 		// butt, round, square
    	attributesObj.dashEnabled = false;
    	
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-md-6">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_addShape_x1" value="' + attributesObj.x1 + '">';
		htmlLines_x1 += '<span id="set001_document_mw_addShape_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-md-6">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_addShape_y1" value="' + attributesObj.y1 + '">';
		htmlLines_y1 += '<span id="set001_document_mw_addShape_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_x2 = '';
		htmlLines_x2 += '<div class="form-group">';
		htmlLines_x2 += '<label class="col-md-6 control-label">Position X2 (px)</label>';
		htmlLines_x2 += '<div class="col-md-6">';
		htmlLines_x2 += '<input type="number" class="form-control" id="set001_document_mw_addShape_x2" value="' + attributesObj.x2 + '">';
		htmlLines_x2 += '<span id="set001_document_mw_addShape_x2_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x2 += '</div>';
		htmlLines_x2 += '</div>';
    
		var htmlLines_y2 = '';
		htmlLines_y2 += '<div class="form-group">';
		htmlLines_y2 += '<label class="col-md-6 control-label">Position Y2 (px)</label>';
		htmlLines_y2 += '<div class="col-md-6">';
		htmlLines_y2 += '<input type="number" class="form-control" id="set001_document_mw_addShape_y2" value="' + attributesObj.y2 + '">';
		htmlLines_y2 += '<span id="set001_document_mw_addShape_y2_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y2 += '</div>';
		htmlLines_y2 += '</div>';

		var htmlLines_stroke = '';
		htmlLines_stroke += '<div class="form-group">';
		htmlLines_stroke += '<label class="col-md-6 control-label">Stroke Color</label>';
		htmlLines_stroke += '<div class="col-md-6">';
		htmlLines_stroke += '<input type="text" class="form-control" id="set001_document_mw_addShape_stroke" value="' + attributesObj.stroke + '">';
		htmlLines_stroke += '<span id="set001_document_mw_addShape_stroke_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_stroke += '</div>';
		htmlLines_stroke += '</div>';

		var htmlLines_strokeWidth = '';
		htmlLines_strokeWidth += '<div class="form-group">';
		htmlLines_strokeWidth += '<label class="col-md-6 control-label">Stroke Width (px)</label>';
		htmlLines_strokeWidth += '<div class="col-md-6">';
		htmlLines_strokeWidth += '<input type="number" class="form-control" id="set001_document_mw_addShape_strokeWidth" value="' + attributesObj.strokeWidth + '">';
		htmlLines_strokeWidth += '<span id="set001_document_mw_addShape_strokeWidth_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_strokeWidth += '</div>';
		htmlLines_strokeWidth += '</div>';

		var htmlLines_lineCap = '';
		htmlLines_lineCap += '<div class="form-group">';
		htmlLines_lineCap += '<label class="col-md-6 control-label">Line Cap</label>';
		htmlLines_lineCap += '<div class="col-md-6">';
		htmlLines_lineCap += '<select id="set001_document_mw_addShape_lineCap" class="form-control">';
		if (attributesObj.lineCap == 'butt')
			htmlLines_lineCap += '<option value="butt" selected>Butt</option>';
		else
			htmlLines_lineCap += '<option value="butt">Butt</option>';
		if (attributesObj.lineCap == 'round')
			htmlLines_lineCap += '<option value="round" selected>Round</option>';
		else
			htmlLines_lineCap += '<option value="round">Round</option>';
		if (attributesObj.lineCap == 'square')
			htmlLines_lineCap += '<option value="square" selected>Square</option>';
		else
			htmlLines_lineCap += '<option value="square">Square</option>';
		htmlLines_lineCap += '</select>';
		htmlLines_lineCap += '<span id="set001_document_mw_addShape_lineCap_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_lineCap += '</div>';
		htmlLines_lineCap += '</div>';

		var htmlLines_dashEnabled = '';
		htmlLines_dashEnabled += '<div class="form-group">';
		htmlLines_dashEnabled += '<label class="col-sm-6 control-label">Dash Enabled</label>';
		htmlLines_dashEnabled += '<div class="col-sm-6 iCheck">';
		htmlLines_dashEnabled += '<label>';
		htmlLines_dashEnabled += '<input type="checkbox" id="set001_document_mw_addShape_dashEnabled" ' + (attributesObj.dashEnabled ? 'checked' : '') + '>';
		htmlLines_dashEnabled += '</label>';
		htmlLines_dashEnabled += '</div>';
		htmlLines_dashEnabled += '</div>';

		$('#set001_document_mw_addShape_componentAttributes_left_top').empty();
		$('#set001_document_mw_addShape_componentAttributes_left_bottom').empty();
		
		$('#set001_document_mw_addShape_componentAttributes_right').empty();
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_x1);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_y1);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_x2);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_y2);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_stroke);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_strokeWidth);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_lineCap);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_dashEnabled);
    }  
    

    if (set001_document_mw_addShape_componentType == DocumentConstants.COMPONENT_OBJECT_TYPE_BOX) {
    	// https://konvajs.github.io/api/Konva.Rect.html
    	var attributesObj = new Object();
    	attributesObj.x1 = 50;
    	attributesObj.y1 = 50;
    	attributesObj.width = 100;
    	attributesObj.height = 100;
    	attributesObj.fill = '#FFF';
    	attributesObj.fillEnabled = true;
    	attributesObj.stroke = '#555';
    	attributesObj.strokeWidth = '2';	
    	attributesObj.strokeEnabled = true;
    	attributesObj.cornerRadius = 0;
    	
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-md-6 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-md-6">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_document_mw_addShape_x1" value="' + attributesObj.x1 + '">';
		htmlLines_x1 += '<span id="set001_document_mw_addShape_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-md-6 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-md-6">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_document_mw_addShape_y1" value="' + attributesObj.y1 + '">';
		htmlLines_y1 += '<span id="set001_document_mw_addShape_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_width = '';
		htmlLines_width += '<div class="form-group">';
		htmlLines_width += '<label class="col-md-6 control-label">Width (px)</label>';
		htmlLines_width += '<div class="col-md-6">';
		htmlLines_width += '<input type="number" class="form-control" id="set001_document_mw_addShape_width" value="' + attributesObj.width + '">';
		htmlLines_width += '<span id="set001_document_mw_addShape_width_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_width += '</div>';
		htmlLines_width += '</div>';
    
		var htmlLines_height = '';
		htmlLines_height += '<div class="form-group">';
		htmlLines_height += '<label class="col-md-6 control-label">Height Y2 (px)</label>';
		htmlLines_height += '<div class="col-md-6">';
		htmlLines_height += '<input type="number" class="form-control" id="set001_document_mw_addShape_height" value="' + attributesObj.height + '">';
		htmlLines_height += '<span id="set001_document_mw_addShape_height_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_height += '</div>';
		htmlLines_height += '</div>';

		var htmlLines_fillEnabled = '';
		htmlLines_fillEnabled += '<div class="form-group">';
		htmlLines_fillEnabled += '<label class="col-sm-6 control-label">Fill Enabled</label>';
		htmlLines_fillEnabled += '<div class="col-sm-6 iCheck">';
		htmlLines_fillEnabled += '<label>';
		htmlLines_fillEnabled += '<input type="checkbox" id="set001_document_mw_addShape_fillEnabled" ' + (attributesObj.fillEnabled ? 'checked' : '') + '>';
		htmlLines_fillEnabled += '</label>';
		htmlLines_fillEnabled += '</div>';
		htmlLines_fillEnabled += '</div>';
		
		var htmlLines_fill = '';
		htmlLines_fill += '<div class="form-group">';
		htmlLines_fill += '<label class="col-md-6 control-label">Fill Color</label>';
		htmlLines_fill += '<div class="col-md-6">';
		htmlLines_fill += '<input type="text" class="form-control" id="set001_document_mw_addShape_fill" value="' + attributesObj.fill + '">';
		htmlLines_fill += '<span id="set001_document_mw_addShape_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fill += '</div>';
		htmlLines_fill += '</div>';

		var htmlLines_strokeEnabled = '';
		htmlLines_strokeEnabled += '<div class="form-group">';
		htmlLines_strokeEnabled += '<label class="col-sm-6 control-label">Stroke Enabled</label>';
		htmlLines_strokeEnabled += '<div class="col-sm-6 iCheck">';
		htmlLines_strokeEnabled += '<label>';
		htmlLines_strokeEnabled += '<input type="checkbox" id="set001_document_mw_addShape_strokeEnabled" ' + (attributesObj.strokeEnabled ? 'checked' : '') + '>';
		htmlLines_strokeEnabled += '</label>';
		htmlLines_strokeEnabled += '</div>';
		htmlLines_strokeEnabled += '</div>';
		
		var htmlLines_stroke = '';
		htmlLines_stroke += '<div class="form-group">';
		htmlLines_stroke += '<label class="col-md-6 control-label">Stroke Color</label>';
		htmlLines_stroke += '<div class="col-md-6">';
		htmlLines_stroke += '<input type="text" class="form-control" id="set001_document_mw_addShape_stroke" value="' + attributesObj.stroke + '">';
		htmlLines_stroke += '<span id="set001_document_mw_addShape_stroke_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_stroke += '</div>';
		htmlLines_stroke += '</div>';

		var htmlLines_strokeWidth = '';
		htmlLines_strokeWidth += '<div class="form-group">';
		htmlLines_strokeWidth += '<label class="col-md-6 control-label">Stroke Width (px)</label>';
		htmlLines_strokeWidth += '<div class="col-md-6">';
		htmlLines_strokeWidth += '<input type="number" class="form-control" id="set001_document_mw_addShape_strokeWidth" value="' + attributesObj.strokeWidth + '">';
		htmlLines_strokeWidth += '<span id="set001_document_mw_addShape_strokeWidth_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_strokeWidth += '</div>';
		htmlLines_strokeWidth += '</div>';

		var htmlLines_cornerRadius = '';
		htmlLines_cornerRadius += '<div class="form-group">';
		htmlLines_cornerRadius += '<label class="col-md-6 control-label">Corner Radius</label>';
		htmlLines_cornerRadius += '<div class="col-md-6">';
		htmlLines_cornerRadius += '<input type="number" class="form-control" id="set001_document_mw_addShape_cornerRadius" value="' + attributesObj.cornerRadius + '">';
		htmlLines_cornerRadius += '<span id="set001_document_mw_addShape_cornerRadius_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_cornerRadius += '</div>';
		htmlLines_cornerRadius += '</div>';

		$('#set001_document_mw_addShape_componentAttributes_left_top').empty();
		$('#set001_document_mw_addShape_componentAttributes_left_bottom').empty();
		
		$('#set001_document_mw_addShape_componentAttributes_right').empty();
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_x1);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_y1);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_width);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_height);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_fillEnabled);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_fill);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_strokeEnabled);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_stroke);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_strokeWidth);
		$('#set001_document_mw_addShape_componentAttributes_right').append(htmlLines_cornerRadius);
    }  
    
    $('.iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
   	
	$('.summernote').summernote({
        toolbar: false
	});
	
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_addShape', true);
 
    // Set focus
    $('#set001_document_mw_addShape_componentName').focus();
} // .end of set001_document_mw_addShape_updateUI

function set001_document_mw_addShape_cancel() 
{
	// Close Modal Window
    $('#set001_document_mw_addShape').modal('hide');
} // .end of set001_document_mw_addShape_cancel

function set001_document_mw_addShape_save()
{
	// reset
    $('.error-msg').hide();
	
	// Init component object
	var componentObj = createNew_PlaceDocumentTemplateComponent(); 
	
    // Shape: TEXT
    if (set001_document_mw_addShape_componentType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {
    	var componentName = $.trim( $('#set001_document_mw_addShape_componentName').val() );
    	var x1 = $.trim( $('#set001_document_mw_addShape_x1').val() );
		var y1 = $.trim( $('#set001_document_mw_addShape_y1').val() );
		var width = $.trim( $('#set001_document_mw_addShape_width').val() );
		var padding = $.trim( $('#set001_document_mw_addShape_padding').val() );
		var fill = $.trim( $('#set001_document_mw_addShape_fill').val() );
		var fontFamily = $.trim( $('#set001_document_mw_addShape_fontFamily').val() );
		var fontSize = $.trim( $('#set001_document_mw_addShape_fontSize').val() );
		var fontStyle = $.trim( $('#set001_document_mw_addShape_fontStyle').val() );
		var align = $.trim( $('#set001_document_mw_addShape_align').val() );
		var complexText = $.trim( $('#set001_document_mw_addShape_text').val() );
		var requireUserInput = $('#set001_document_mw_addShape_requireUserInput').prop('checked');
	    var positionAfterComponent = $('#set001_document_mw_addShape_afterComponent').val();

		if (componentName == '') {
	    	$('#set001_document_mw_addShape_componentName').focus();
			$('#set001_document_mw_addShape_componentName_error').show();
			return false;
		}
		if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_addShape_templateObj.width) {
	    	$('#set001_document_mw_addShape_x1').focus();
			$('#set001_document_mw_addShape_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_addShape_templateObj.height) {
	    	$('#set001_document_mw_addShape_y1').focus();
			$('#set001_document_mw_addShape_y1_error').show();
			return false;
		}
		if (width == '' || Number(width) < 0) {
	    	$('#set001_document_mw_addShape_width').focus();
			$('#set001_document_mw_addShape_width_error').show();
			return false;
		}
		if (fontSize == '' || Number(fontSize) < 1) {
	    	$('#set001_document_mw_addShape_width').focus();
			$('#set001_document_mw_addShape_width_error').show();
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
		attributesObj.text = complexText;
		attributesObj.requireUserInput = requireUserInput;
		attributesObj.afterComponent = positionAfterComponent;

		if (attributesObj.afterComponent == '' || attributesObj.afterComponent == 'absolute') {
			componentObj.seqno = 0;
		} else {
			$.each(set001_document_mw_addShape_templateObj.componentList, function(i, componentObj) {
				if (componentObj.id == attributesObj.afterComponent) {
					componentObj.seqno = componentObj.seqno + 1;
				}
			});
		}
		
		componentObj.name = componentName;
		componentObj.objectType = DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT;
		componentObj.attributes = JSON.stringify(attributesObj);
		componentObj.repaint = true;
    } 
	
 	// Shape: LINE
    if (set001_document_mw_addShape_componentType == DocumentConstants.COMPONENT_OBJECT_TYPE_LINE) {
    	var componentName = $.trim( $('#set001_document_mw_addShape_componentName').val() );
    	var x1 = $.trim( $('#set001_document_mw_addShape_x1').val() );
		var y1 = $.trim( $('#set001_document_mw_addShape_y1').val() );
    	var x2 = $.trim( $('#set001_document_mw_addShape_x2').val() );
		var y2 = $.trim( $('#set001_document_mw_addShape_y2').val() );
		var stroke = $.trim( $('#set001_document_mw_addShape_stroke').val() );
		var strokeWidth = $.trim( $('#set001_document_mw_addShape_strokeWidth').val() );
		var lineCap = $.trim( $('#set001_document_mw_addShape_lineCap').val() );
		var dashEnabled = $('#set001_document_mw_addShape_dashEnabled').prop('checked');

		if (componentName == '') {
	    	$('#set001_document_mw_addShape_componentName').focus();
			$('#set001_document_mw_addShape_componentName_error').show();
			return false;
		}
		if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_addShape_templateObj.width) {
	    	$('#set001_document_mw_addShape_x1').focus();
			$('#set001_document_mw_addShape_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_addShape_templateObj.height) {
	    	$('#set001_document_mw_addShape_y1').focus();
			$('#set001_document_mw_addShape_y1_error').show();
			return false;
		}
		if (x2 == '' || Number(x2) < 0 || Number(x2) > set001_document_mw_addShape_templateObj.width) {
	    	$('#set001_document_mw_addShape_x2').focus();
			$('#set001_document_mw_addShape_x2_error').show();
			return false;
		}
		if (y2 == '' || Number(y2) < 0 || Number(y2) > set001_document_mw_addShape_templateObj.height) {
	    	$('#set001_document_mw_addShape_y2').focus();
			$('#set001_document_mw_addShape_y2_error').show();
			return false;
		}
		if (stroke == '') {
	    	$('#set001_document_mw_addShape_stroke').focus();
			$('#set001_document_mw_addShape_stroke_error').show();
			return false;
		}
		if (strokeWidth == '' || Number(strokeWidth) < 1) {
	    	$('#set001_document_mw_addShape_strokeWidth').focus();
			$('#set001_document_mw_addShape_strokeWidth_error').show();
			return false;
		}
		
		// All valid inputs, so proceed to save.
		var attributesObj = new Object();
		attributesObj.x1 = Math.abs(x1);
		attributesObj.y1 = Math.abs(y1);
		attributesObj.x2 = Math.abs(x2);
		attributesObj.y2 = Math.abs(y2);	
		attributesObj.stroke = stroke;
		attributesObj.strokeWidth = Math.abs(strokeWidth);
		attributesObj.lineCap = lineCap;
		attributesObj.dashEnabled = dashEnabled;

		componentObj.name = componentName;
		componentObj.objectType = DocumentConstants.COMPONENT_OBJECT_TYPE_LINE;
		componentObj.attributes = JSON.stringify(attributesObj);
		componentObj.repaint = true;
    }

 	// Shape: BOX
    if (set001_document_mw_addShape_componentType == DocumentConstants.COMPONENT_OBJECT_TYPE_BOX) {
    	var componentName = $.trim( $('#set001_document_mw_addShape_componentName').val() );
    	var x1 = $.trim( $('#set001_document_mw_addShape_x1').val() );
		var y1 = $.trim( $('#set001_document_mw_addShape_y1').val() );
		var width = $.trim( $('#set001_document_mw_addShape_width').val() );
		var height = $.trim( $('#set001_document_mw_addShape_height').val() );
		var fillEnabled = $('#set001_document_mw_addShape_fillEnabled').prop('checked');
		var fill = $.trim( $('#set001_document_mw_addShape_fill').val() );
		var strokeEnabled = $('#set001_document_mw_addShape_strokeEnabled').prop('checked');
		var stroke = $.trim( $('#set001_document_mw_addShape_stroke').val() );
		var strokeWidth = $.trim( $('#set001_document_mw_addShape_strokeWidth').val() );
		var cornerRadius = $.trim( $('#set001_document_mw_addShape_cornerRadius').val() );

		if (componentName == '') {
	    	$('#set001_document_mw_addShape_componentName').focus();
			$('#set001_document_mw_addShape_componentName_error').show();
			return false;
		}
		if (x1 == '' || Number(x1) < 0 || Number(x1) > set001_document_mw_addShape_templateObj.width) {
	    	$('#set001_document_mw_addShape_x1').focus();
			$('#set001_document_mw_addShape_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) < 0 || Number(y1) > set001_document_mw_addShape_templateObj.height) {
	    	$('#set001_document_mw_addShape_y1').focus();
			$('#set001_document_mw_addShape_y1_error').show();
			return false;
		}
		if (width == '' || Number(width) < 0) {
	    	$('#set001_document_mw_addShape_width').focus();
			$('#set001_document_mw_addShape_width_error').show();
			return false;
		}
		if (height == '' || Number(height) < 0) {
	    	$('#set001_document_mw_addShape_height').focus();
			$('#set001_document_mw_addShape_height_error').show();
			return false;
		}
		if (strokeWidth == '' || Number(strokeWidth) < 1) {
	    	$('#set001_document_mw_addShape_strokeWidth').focus();
			$('#set001_document_mw_addShape_strokeWidth_error').show();
			return false;
		}
		if (cornerRadius == '' || Number(cornerRadius) < 0) {
	    	$('#set001_document_mw_addShape_cornerRadius').focus();
			$('#set001_document_mw_addShape_cornerRadius_error').show();
			return false;
		}
		
		// All valid inputs, so proceed to save.
		var attributesObj = new Object();
		attributesObj.x1 = Math.abs(x1);
		attributesObj.y1 = Math.abs(y1);	
		attributesObj.width = Math.abs(width);
		attributesObj.height = Math.abs(height);
		attributesObj.fillEnabled = fillEnabled;
		attributesObj.fill = fill;
		attributesObj.strokeEnabled = strokeEnabled;
		attributesObj.stroke = stroke;
		attributesObj.strokeWidth = strokeWidth;	
		attributesObj.cornerRadius = cornerRadius;

		componentObj.name = componentName;
		componentObj.objectType = DocumentConstants.COMPONENT_OBJECT_TYPE_BOX;
		componentObj.attributes = JSON.stringify(attributesObj);
		componentObj.repaint = true;
    } 
    
    // Close Modal Window
    $('#set001_document_mw_addShape').modal('hide');
    // Call back
    if (set001_document_mw_addShape_callbackFn != null)
    	set001_document_mw_addShape_callbackFn(componentObj);
} // .end of set001_document_mw_addShape_save

</script>