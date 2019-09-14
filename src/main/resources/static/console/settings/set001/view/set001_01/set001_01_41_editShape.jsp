<!-- Modal Window: Edit Layout Component -->
<div class="modal inmodal fade" id="set001_01_41_editShape" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
		    	<span class="modal-title">EDIT COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_01_41_editShape_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-6">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_41_editShape_componentName" disabled>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Pax Count</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_01_41_editShape_paxCount">
											<span id="set001_01_41_editShape_paxCount_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div id="set001_01_41_componentAttributes_left">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-6">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div id="set001_01_41_componentAttributes_right">
	                            	</div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" onclick="set001_01_41_editShape_delete();">Delete</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_01_41_editShape_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_41_editShape_initialized = false;
var set001_01_41_editShape_validInput = false;

var set001_01_41_editShape_callbackFn;
var set001_01_41_editShape_layoutObj;
var set001_01_41_editShape_componentObj;

function set001_01_41_editShape_isOpen()
{
	return ($("#set001_01_41_editShape").data('bs.modal') || {}).isShown;	
} // .end of set001_01_41_editShape_isOpen

function set001_01_41_editShape_init()
{
    if (set001_01_41_editShape_initialized == true)
        return false;

    $('.set001_01_41_editShape_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_01_41_editShape').on('shown.bs.modal', function () {
	    
	});
    
	set001_01_41_editShape_initialized = true;
} // .end of set001_01_41_editShape_init

function set001_01_41_editShape_show(layoutObj, componentObj, callbackFn)
{
	// Set callback
	set001_01_41_editShape_callbackFn = callbackFn;
	// Set component
	set001_01_41_editShape_layoutObj = layoutObj;
	set001_01_41_editShape_componentObj = componentObj;
	// Update UI
	set001_01_41_editShape_updateUI();
} // .end of set001_01_41_editShape_show

function set001_01_41_editShape_updateUI()
{
    set001_01_41_editShape_init();
    
    $('#set001_01_41_editShape_componentName').val(set001_01_41_editShape_componentObj.name);
    $('#set001_01_41_editShape_paxCount').val(set001_01_41_editShape_componentObj.paxCount);
    
    if (set001_01_41_editShape_componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_LINE) {
		var attributesObj = JSON.parse(set001_01_41_editShape_componentObj.attributes);
		
		var x1 	   		 = Number(attributesObj.x1);
        var y1 			 = Number(attributesObj.y1);
        var x2 			 = Number(attributesObj.x2);
        var y2   		 = Number(attributesObj.y2);
        var stroke 		 = $.trim(attributesObj.stroke);
        var strokeWidth	 = Number(attributesObj.strokeWidth);
        var rotation	 = Number(attributesObj.rotationDegree);
        var bucketLinked = tycheesUtil_getBooleanValue(attributesObj.bucketLinked);
		
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-sm-4 control-label">Position X1 (px)</label>';
		htmlLines_x1 += '<div class="col-sm-8">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_01_41_editShape_x1" value="' + Math.abs(x1) + '">';
		htmlLines_x1 += '<span id="set001_01_41_editShape_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-sm-4 control-label">Position Y1 (px)</label>';
		htmlLines_y1 += '<div class="col-sm-8">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_01_41_editShape_y1" value="' + Math.abs(y1) + '">';
		htmlLines_y1 += '<span id="set001_01_41_editShape_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_x2 = '';
		htmlLines_x2 += '<div class="form-group">';
		htmlLines_x2 += '<label class="col-sm-4 control-label">Position X2 (px)</label>';
		htmlLines_x2 += '<div class="col-sm-8">';
		htmlLines_x2 += '<input type="number" class="form-control" id="set001_01_41_editShape_x2" value="' + Math.abs(x2) + '">';
		htmlLines_x2 += '<span id="set001_01_41_editShape_x2_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x2 += '</div>';
		htmlLines_x2 += '</div>';

		var htmlLines_y2 = '';
		htmlLines_y2 += '<div class="form-group">';
		htmlLines_y2 += '<label class="col-sm-4 control-label">Position Y2 (px)</label>';
		htmlLines_y2 += '<div class="col-sm-8">';
		htmlLines_y2 += '<input type="number" class="form-control" id="set001_01_41_editShape_y2" value="' + Math.abs(y2) + '">';
		htmlLines_y2 += '<span id="set001_01_41_editShape_y2_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y2 += '</div>';
		htmlLines_y2 += '</div>';

		var htmlLines_stroke = '';
		htmlLines_stroke += '<div class="form-group">';
		htmlLines_stroke += '<label class="col-sm-4 control-label">Stroke Color</label>';
		htmlLines_stroke += '<div class="col-sm-8">';
		htmlLines_stroke += '<input type="text" class="form-control" id="set001_01_41_editShape_stroke" value="' + stroke + '">';
		htmlLines_stroke += '<span id="set001_01_41_editShape_stroke_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_stroke += '</div>';
		htmlLines_stroke += '</div>';

		var htmlLines_strokeWidth = '';
		htmlLines_strokeWidth += '<div class="form-group">';
		htmlLines_strokeWidth += '<label class="col-sm-4 control-label">Stroke Width (px)</label>';
		htmlLines_strokeWidth += '<div class="col-sm-8">';
		htmlLines_strokeWidth += '<input type="number" class="form-control" id="set001_01_41_editShape_strokeWidth" value="' + Math.abs(strokeWidth) + '">';
		htmlLines_strokeWidth += '<span id="set001_01_41_editShape_strokeWidth_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_strokeWidth += '</div>';
		htmlLines_strokeWidth += '</div>';

		var htmlLines_rotation = '';
		htmlLines_rotation += '<div class="form-group">';
		htmlLines_rotation += '<label class="col-sm-4 control-label">Rotation (degree)</label>';
		htmlLines_rotation += '<div class="col-sm-8">';
		htmlLines_rotation += '<input type="number" class="form-control" id="set001_01_41_editShape_rotation" value="' + rotation + '">';
		htmlLines_rotation += '<span id="set001_01_41_editShape_rotation_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_rotation += '</div>';
		htmlLines_rotation += '</div>';
		
		var htmlLines_bucketLinked = '';
		htmlLines_bucketLinked += '<div class="form-group">';
		htmlLines_bucketLinked += '<label class="col-sm-4 control-label">Bucket Linked</label>';
		htmlLines_bucketLinked += '<div class="col-sm-8 iCheck">';
		htmlLines_bucketLinked += '<label>';
		htmlLines_bucketLinked += '<input type="checkbox" id="set001_01_41_editShape_bucketLinked" ' + (bucketLinked ? 'checked' : '') + '>';
		//htmlLines_bucketLinked += '<i></i> Check to link';
		htmlLines_bucketLinked += '</label>';
		htmlLines_bucketLinked += '</div>';
		htmlLines_bucketLinked += '</div>';
		
		$('#set001_01_41_componentAttributes_left').empty();
		$('#set001_01_41_componentAttributes_left').append(htmlLines_bucketLinked);
		
		$('#set001_01_41_componentAttributes_right').empty();
		$('#set001_01_41_componentAttributes_right').append(htmlLines_x1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_y1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_x2);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_y2);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_stroke);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_strokeWidth);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_rotation);
    }    	
    
	if (set001_01_41_editShape_componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE) {
		
		var attributesObj = JSON.parse(set001_01_41_editShape_componentObj.attributes);
		
		var x1 	   		 = Number(attributesObj.x1);
        var y1 			 = Number(attributesObj.y1);
        var z1 			 = Number(attributesObj.z1);
        var width 		 = Number(attributesObj.width);
        var height 		 = Number(attributesObj.height);
        var fill 		 = $.trim(attributesObj.fill);
        var stroke 		 = $.trim(attributesObj.stroke);
        var strokeWidth	 = Number(attributesObj.strokeWidth);
        var rotation	 = Number(attributesObj.rotationDegree);
        var bucketLinked = tycheesUtil_getBooleanValue(attributesObj.bucketLinked);
		
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-sm-4 control-label">Position X (px)</label>';
		htmlLines_x1 += '<div class="col-sm-8">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_01_41_editShape_x1" value="' + Math.abs(x1) + '">';
		htmlLines_x1 += '<span id="set001_01_41_editShape_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-sm-4 control-label">Position Y (px)</label>';
		htmlLines_y1 += '<div class="col-sm-8">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_01_41_editShape_y1" value="' + Math.abs(y1) + '">';
		htmlLines_y1 += '<span id="set001_01_41_editShape_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_z1 = '';
		htmlLines_z1 += '<div class="form-group">';
		htmlLines_z1 += '<label class="col-sm-4 control-label">Position Z (px)</label>';
		htmlLines_z1 += '<div class="col-sm-8">';
		htmlLines_z1 += '<input type="number" class="form-control" id="set001_01_41_editShape_z1" value="' + z1 + '">';
		htmlLines_z1 += '<span id="set001_01_41_editShape_z1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_z1 += '</div>';
		htmlLines_z1 += '</div>';
		
		var htmlLines_width = '';
		htmlLines_width += '<div class="form-group">';
		htmlLines_width += '<label class="col-sm-4 control-label">Width (px)</label>';
		htmlLines_width += '<div class="col-sm-8">';
		htmlLines_width += '<input type="number" class="form-control" id="set001_01_41_editShape_width" value="' + Math.abs(width) + '">';
		htmlLines_width += '<span id="set001_01_41_editShape_width_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_width += '</div>';
		htmlLines_width += '</div>';

		var htmlLines_height = '';
		htmlLines_height += '<div class="form-group">';
		htmlLines_height += '<label class="col-sm-4 control-label">Height (px)</label>';
		htmlLines_height += '<div class="col-sm-8">';
		htmlLines_height += '<input type="number" class="form-control" id="set001_01_41_editShape_height" value="' + Math.abs(height) + '">';
		htmlLines_height += '<span id="set001_01_41_editShape_height_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_height += '</div>';
		htmlLines_height += '</div>';

		var htmlLines_fill = '';
		htmlLines_fill += '<div class="form-group">';
		htmlLines_fill += '<label class="col-sm-4 control-label">Fill Color</label>';
		htmlLines_fill += '<div class="col-sm-8">';
		htmlLines_fill += '<input type="text" class="form-control" id="set001_01_41_editShape_fill" value="' + fill + '">';
		htmlLines_fill += '<span id="set001_01_41_editShape_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fill += '</div>';
		htmlLines_fill += '</div>';

		var htmlLines_stroke = '';
		htmlLines_stroke += '<div class="form-group">';
		htmlLines_stroke += '<label class="col-sm-4 control-label">Stroke Color</label>';
		htmlLines_stroke += '<div class="col-sm-8">';
		htmlLines_stroke += '<input type="text" class="form-control" id="set001_01_41_editShape_stroke" value="' + stroke + '">';
		htmlLines_stroke += '<span id="set001_01_41_editShape_stroke_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_stroke += '</div>';
		htmlLines_stroke += '</div>';

		var htmlLines_strokeWidth = '';
		htmlLines_strokeWidth += '<div class="form-group">';
		htmlLines_strokeWidth += '<label class="col-sm-4 control-label">Stroke Width (px)</label>';
		htmlLines_strokeWidth += '<div class="col-sm-8">';
		htmlLines_strokeWidth += '<input type="number" class="form-control" id="set001_01_41_editShape_strokeWidth" value="' + Math.abs(strokeWidth) + '">';
		htmlLines_strokeWidth += '<span id="set001_01_41_editShape_strokeWidth_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_strokeWidth += '</div>';
		htmlLines_strokeWidth += '</div>';

		var htmlLines_rotation = '';
		htmlLines_rotation += '<div class="form-group">';
		htmlLines_rotation += '<label class="col-sm-4 control-label">Rotation (degree)</label>';
		htmlLines_rotation += '<div class="col-sm-8">';
		htmlLines_rotation += '<input type="number" class="form-control" id="set001_01_41_editShape_rotation" value="' + rotation + '">';
		htmlLines_rotation += '<span id="set001_01_41_editShape_rotation_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_rotation += '</div>';
		htmlLines_rotation += '</div>';
		
		var htmlLines_bucketLinked = '';
		htmlLines_bucketLinked += '<div class="form-group">';
		htmlLines_bucketLinked += '<label class="col-sm-4 control-label">Bucket Linked</label>';
		htmlLines_bucketLinked += '<div class="col-sm-8 iCheck">';
		htmlLines_bucketLinked += '<label>';
		htmlLines_bucketLinked += '<input type="checkbox" id="set001_01_41_editShape_bucketLinked" ' + (bucketLinked ? 'checked' : '') + '>';
		//htmlLines_bucketLinked += '<i></i> Check to link';
		htmlLines_bucketLinked += '</label>';
		htmlLines_bucketLinked += '</div>';
		htmlLines_bucketLinked += '</div>';
		
		$('#set001_01_41_componentAttributes_left').empty();
		$('#set001_01_41_componentAttributes_left').append(htmlLines_bucketLinked);
		
		$('#set001_01_41_componentAttributes_right').empty();		
		$('#set001_01_41_componentAttributes_right').append(htmlLines_x1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_y1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_z1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_width);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_height);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_fill);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_stroke);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_strokeWidth);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_rotation);
	}
		
	if (set001_01_41_editShape_componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE) {
		var attributesObj = JSON.parse(set001_01_41_editShape_componentObj.attributes);
		
		var x1 	   		 = Number(attributesObj.x1);
        var y1 			 = Number(attributesObj.y1);
        var z1 			 = Number(attributesObj.z1);
        var radius 		 = Number(attributesObj.radius);
        var height 		 = Number(attributesObj.height);
        var fill 		 = $.trim(attributesObj.fill);
        var stroke 		 = $.trim(attributesObj.stroke);
        var strokeWidth	 = Number(attributesObj.strokeWidth);
        var rotation	 = Number(attributesObj.rotationDegree);
        var bucketLinked = tycheesUtil_getBooleanValue(attributesObj.bucketLinked);
		
		var htmlLines_x1 = '';
		htmlLines_x1 += '<div class="form-group">';
		htmlLines_x1 += '<label class="col-sm-4 control-label">Position X (px)</label>';
		htmlLines_x1 += '<div class="col-sm-8">';
		htmlLines_x1 += '<input type="number" class="form-control" id="set001_01_41_editShape_x1" value="' + Math.abs(x1) + '">';
		htmlLines_x1 += '<span id="set001_01_41_editShape_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_x1 += '</div>';
		htmlLines_x1 += '</div>';
    
		var htmlLines_y1 = '';
		htmlLines_y1 += '<div class="form-group">';
		htmlLines_y1 += '<label class="col-sm-4 control-label">Position Y (px)</label>';
		htmlLines_y1 += '<div class="col-sm-8">';
		htmlLines_y1 += '<input type="number" class="form-control" id="set001_01_41_editShape_y1" value="' + Math.abs(y1) + '">';
		htmlLines_y1 += '<span id="set001_01_41_editShape_y1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_y1 += '</div>';
		htmlLines_y1 += '</div>';

		var htmlLines_z1 = '';
		htmlLines_z1 += '<div class="form-group">';
		htmlLines_z1 += '<label class="col-sm-4 control-label">Position Z (px)</label>';
		htmlLines_z1 += '<div class="col-sm-8">';
		htmlLines_z1 += '<input type="number" class="form-control" id="set001_01_41_editShape_z1" value="' + z1 + '">';
		htmlLines_z1 += '<span id="set001_01_41_editShape_z1_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_z1 += '</div>';
		htmlLines_z1 += '</div>';
		
		var htmlLines_radius = '';
		htmlLines_radius += '<div class="form-group">';
		htmlLines_radius += '<label class="col-sm-4 control-label">Radius (px)</label>';
		htmlLines_radius += '<div class="col-sm-8">';
		htmlLines_radius += '<input type="number" class="form-control" id="set001_01_41_editShape_radius" value="' + Math.abs(radius) + '">';
		htmlLines_radius += '<span id="set001_01_41_editShape_radius_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_radius += '</div>';
		htmlLines_radius += '</div>';

		var htmlLines_fill = '';
		htmlLines_fill += '<div class="form-group">';
		htmlLines_fill += '<label class="col-sm-4 control-label">Fill Color</label>';
		htmlLines_fill += '<div class="col-sm-8">';
		htmlLines_fill += '<input type="text" class="form-control" id="set001_01_41_editShape_fill" value="' + fill + '">';
		htmlLines_fill += '<span id="set001_01_41_editShape_fill_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_fill += '</div>';
		htmlLines_fill += '</div>';

		var htmlLines_stroke = '';
		htmlLines_stroke += '<div class="form-group">';
		htmlLines_stroke += '<label class="col-sm-4 control-label">Stroke Color</label>';
		htmlLines_stroke += '<div class="col-sm-8">';
		htmlLines_stroke += '<input type="text" class="form-control" id="set001_01_41_editShape_stroke" value="' + stroke + '">';
		htmlLines_stroke += '<span id="set001_01_41_editShape_stroke_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_stroke += '</div>';
		htmlLines_stroke += '</div>';

		var htmlLines_strokeWidth = '';
		htmlLines_strokeWidth += '<div class="form-group">';
		htmlLines_strokeWidth += '<label class="col-sm-4 control-label">Stroke Width (px)</label>';
		htmlLines_strokeWidth += '<div class="col-sm-8">';
		htmlLines_strokeWidth += '<input type="number" class="form-control" id="set001_01_41_editShape_strokeWidth" value="' + Math.abs(strokeWidth) + '">';
		htmlLines_strokeWidth += '<span id="set001_01_41_editShape_strokeWidth_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_strokeWidth += '</div>';
		htmlLines_strokeWidth += '</div>';

		var htmlLines_rotation = '';
		htmlLines_rotation += '<div class="form-group">';
		htmlLines_rotation += '<label class="col-sm-4 control-label">Rotation (degree)</label>';
		htmlLines_rotation += '<div class="col-sm-8">';
		htmlLines_rotation += '<input type="number" class="form-control" id="set001_01_41_editShape_rotation" value="' + rotation + '">';
		htmlLines_rotation += '<span id="set001_01_41_editShape_rotation_error" class="help-block m-b-none error-msg" style="display:none; color:#FF0000;">Error: Invalid Value</span>';
		htmlLines_rotation += '</div>';
		htmlLines_rotation += '</div>';

		var htmlLines_bucketLinked = '';
		htmlLines_bucketLinked += '<div class="form-group">';
		htmlLines_bucketLinked += '<label class="col-sm-4 control-label">Bucket Linked</label>';
		htmlLines_bucketLinked += '<div class="col-sm-8 iCheck">';
		htmlLines_bucketLinked += '<label>';
		htmlLines_bucketLinked += '<input type="checkbox" id="set001_01_41_editShape_bucketLinked" ' + (bucketLinked ? 'checked' : '') + '>';
		//htmlLines_bucketLinked += '<i></i> Check to link';
		htmlLines_bucketLinked += '</label>';
		htmlLines_bucketLinked += '</div>';
		htmlLines_bucketLinked += '</div>';
		
		$('#set001_01_41_componentAttributes_left').empty();
		$('#set001_01_41_componentAttributes_left').append(htmlLines_bucketLinked);
		
		$('#set001_01_41_componentAttributes_right').empty();
		$('#set001_01_41_componentAttributes_right').append(htmlLines_x1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_y1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_z1);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_radius);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_fill);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_stroke);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_strokeWidth);
		$('#set001_01_41_componentAttributes_right').append(htmlLines_rotation);
	}	
    
	$('.iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
   	
    // Show Modal Window on Top
    module_showModalWindow('set001_01_41_editShape', true);
} // .end of set001_01_41_editShape_updateUI

function set001_01_41_editShape_delete()
{
	swal({
		title: "Are you sure?",
		text: "You will lose this component (" + set001_01_41_editShape_componentObj.name + ")",
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
			Cached_deleteBean(set001_01_41_editShape_componentObj);
		    // Close Modal Window
		    $('#set001_01_41_editShape').modal('hide');
		    // Call back
		    if (set001_01_41_editShape_callbackFn != null)
		    	set001_01_41_editShape_callbackFn();
		}
	});
} // .end of set001_01_41_editShape_delete

function set001_01_41_editShape_save()
{
	// reset
    $('.error-msg').hide();
	
	// Get User Inputs
    var paxCount = $.trim( $('#set001_01_41_editShape_paxCount').val() );
    if (paxCount == '') {
    	$('#set001_01_41_editShape_paxCount').focus();
		$('#set001_01_41_editShape_paxCount_error').show();
		return false;
	}
    
    // Shape: LINE
    if (set001_01_41_editShape_componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_LINE) {
    	var x1 = $.trim( $('#set001_01_41_editShape_x1').val() );
		var y1 = $.trim( $('#set001_01_41_editShape_y1').val() );
		var x2 = $.trim( $('#set001_01_41_editShape_x2').val() );
		var y2 = $.trim( $('#set001_01_41_editShape_y2').val() );
		var stroke = $.trim( $('#set001_01_41_editShape_stroke').val() );
		var strokeWidth = $.trim( $('#set001_01_41_editShape_strokeWidth').val() );
		var rotationDegree = $.trim( $('#set001_01_41_editShape_rotation').val() );
		
		if (x1 == '' || Number(x1) > set001_01_41_editShape_layoutObj.width) {
	    	$('#set001_01_41_editShape_x1').focus();
			$('#set001_01_41_editShape_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) > set001_01_41_editShape_layoutObj.height) {
	    	$('#set001_01_41_editShape_y1').focus();
			$('#set001_01_41_editShape_y1_error').show();
			return false;
		}
		if (x2 == '' || Number(x2) > set001_01_41_editShape_layoutObj.width) {
	    	$('#set001_01_41_editShape_x2').focus();
			$('#set001_01_41_editShape_x2_error').show();
			return false;
		}
		if (y2 == '' || Number(y2) > set001_01_41_editShape_layoutObj.height) {
	    	$('#set001_01_41_editShape_y2').focus();
			$('#set001_01_41_editShape_y2_error').show();
			return false;
		}
		if (stroke == '') {
	    	$('#set001_01_41_editShape_stroke').focus();
			$('#set001_01_41_editShape_stroke_error').show();
			return false;
		}
		if (strokeWidth == '') {
	    	$('#set001_01_41_editShape_strokeWidth').focus();
			$('#set001_01_41_editShape_strokeWidth_error').show();
			return false;
		}
		if (rotationDegree == '') {
	    	$('#set001_01_41_editShape_rotation').focus();
			$('#set001_01_41_editShape_rotation_error').show();
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
		attributesObj.rotationDegree = rotationDegree;
		
		set001_01_41_editShape_componentObj.attributes = JSON.stringify(attributesObj);
    }    	
    
    // Shape: RECTANGLE
	if (set001_01_41_editShape_componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE) {
		var x1 = $.trim( $('#set001_01_41_editShape_x1').val() );
		var y1 = $.trim( $('#set001_01_41_editShape_y1').val() );
		var z1 = $.trim( $('#set001_01_41_editShape_z1').val() );
		var width = $.trim( $('#set001_01_41_editShape_width').val() );
		var height = $.trim( $('#set001_01_41_editShape_height').val() );
		var fill = $.trim( $('#set001_01_41_editShape_fill').val() );
		var stroke = $.trim( $('#set001_01_41_editShape_stroke').val() );
		var strokeWidth = $.trim( $('#set001_01_41_editShape_strokeWidth').val() );
		var rotationDegree = $.trim( $('#set001_01_41_editShape_rotation').val() );
		var bucketLinked = $('#set001_01_41_editShape_bucketLinked').prop('checked');
		
		if (x1 == '' || Number(x1) > set001_01_41_editShape_layoutObj.width) {
	    	$('#set001_01_41_editShape_x1').focus();
			$('#set001_01_41_editShape_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) > set001_01_41_editShape_layoutObj.height) {
	    	$('#set001_01_41_editShape_y1').focus();
			$('#set001_01_41_editShape_y1_error').show();
			return false;
		}
		if (z1 == '') {
	    	$('#set001_01_41_editShape_z1').focus();
			$('#set001_01_41_editShape_z1_error').show();
			return false;
		}
		if (width == '') {
	    	$('#set001_01_41_editShape_width').focus();
			$('#set001_01_41_editShape_width_error').show();
			return false;
		}
		if (height == '') {
	    	$('#set001_01_41_editShape_height').focus();
			$('#set001_01_41_editShape_height_error').show();
			return false;
		}
		if (fill == '') {
	    	$('#set001_01_41_editShape_fill').focus();
			$('#set001_01_41_editShape_fill_error').show();
			return false;
		}
		if (stroke == '') {
	    	$('#set001_01_41_editShape_stroke').focus();
			$('#set001_01_41_editShape_stroke_error').show();
			return false;
		}
		if (strokeWidth == '') {
	    	$('#set001_01_41_editShape_strokeWidth').focus();
			$('#set001_01_41_editShape_strokeWidth_error').show();
			return false;
		}
		if (rotationDegree == '') {
	    	$('#set001_01_41_editShape_rotation').focus();
			$('#set001_01_41_editShape_rotation_error').show();
			return false;
		}
		
		// All valid inputs, so proceed to save.
		var attributesObj = new Object();
		attributesObj.x1 = Math.abs(x1);
		attributesObj.y1 = Math.abs(y1);
		attributesObj.z1 = z1;
		attributesObj.width = Math.abs(width);
		attributesObj.height = Math.abs(height);
		attributesObj.fill = fill;
		attributesObj.stroke = stroke;
		attributesObj.strokeWidth = Math.abs(strokeWidth);
		attributesObj.rotationDegree = rotationDegree;
		attributesObj.bucketLinked = bucketLinked;
		
		set001_01_41_editShape_componentObj.attributes = JSON.stringify(attributesObj);
	}

    // Shape: CIRCLE
	if (set001_01_41_editShape_componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE) {
		var x1 = $.trim( $('#set001_01_41_editShape_x1').val() );
		var y1 = $.trim( $('#set001_01_41_editShape_y1').val() );
		var z1 = $.trim( $('#set001_01_41_editShape_z1').val() );
		var radius = $.trim( $('#set001_01_41_editShape_radius').val() );
		var fill = $.trim( $('#set001_01_41_editShape_fill').val() );
		var stroke = $.trim( $('#set001_01_41_editShape_stroke').val() );
		var strokeWidth = $.trim( $('#set001_01_41_editShape_strokeWidth').val() );
		var rotationDegree = $.trim( $('#set001_01_41_editShape_rotation').val() );
		var bucketLinked = $('#set001_01_41_editShape_bucketLinked').prop('checked');
		
		if (x1 == '' || Number(x1) > set001_01_41_editShape_layoutObj.width) {
	    	$('#set001_01_41_editShape_x1').focus();
			$('#set001_01_41_editShape_x1_error').show();
			return false;
		}
		if (y1 == '' || Number(y1) > set001_01_41_editShape_layoutObj.height) {
	    	$('#set001_01_41_editShape_y1').focus();
			$('#set001_01_41_editShape_y1_error').show();
			return false;
		}
		if (z1 == '') {
	    	$('#set001_01_41_editShape_z1').focus();
			$('#set001_01_41_editShape_z1_error').show();
			return false;
		}
		if (radius == '') {
	    	$('#set001_01_41_editShape_radius').focus();
			$('#set001_01_41_editShape_radius_error').show();
			return false;
		}
		if (fill == '') {
	    	$('#set001_01_41_editShape_fill').focus();
			$('#set001_01_41_editShape_fill_error').show();
			return false;
		}
		if (stroke == '') {
	    	$('#set001_01_41_editShape_stroke').focus();
			$('#set001_01_41_editShape_stroke_error').show();
			return false;
		}
		if (strokeWidth == '') {
	    	$('#set001_01_41_editShape_strokeWidth').focus();
			$('#set001_01_41_editShape_strokeWidth_error').show();
			return false;
		}
		if (rotationDegree == '') {
	    	$('#set001_01_41_editShape_rotation').focus();
			$('#set001_01_41_editShape_rotation_error').show();
			return false;
		}
		
		// All valid inputs, so proceed to save.
		var attributesObj = new Object();
		attributesObj.x1 = Math.abs(x1);
		attributesObj.y1 = Math.abs(y1);
		attributesObj.z1 = z1;
		attributesObj.radius = Math.abs(radius);
		attributesObj.fill = fill;
		attributesObj.stroke = stroke;
		attributesObj.strokeWidth = Math.abs(strokeWidth);
		attributesObj.rotationDegree = rotationDegree;
		attributesObj.bucketLinked = bucketLinked;
		
		set001_01_41_editShape_componentObj.paxCount = paxCount;
		set001_01_41_editShape_componentObj.attributes = JSON.stringify(attributesObj);
	}

    // Close Modal Window
    $('#set001_01_41_editShape').modal('hide');
    // Call back
    if (set001_01_41_editShape_callbackFn != null)
    	set001_01_41_editShape_callbackFn();
} // .end of set001_01_41_editShape_save

</script>