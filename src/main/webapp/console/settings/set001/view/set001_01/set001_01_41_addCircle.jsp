<!-- Modal Window: Add Circle Shape -->
<div class="modal inmodal fade" id="set001_01_41_addCircle" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">ADD CIRCLE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_01_41_addCircle_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-6">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_41_addCircle_componentName">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Pax Count</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_01_41_addCircle_paxCount">
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div id="set001_01_41_componentAttributes_left">	                            											
										<div class="form-group">
											<label class="col-sm-4 control-label">Bucket Linked</label>
											<div class="col-sm-8 iCheck">
												<label>
													<input type="checkbox" id="set001_01_41_addCircle_bucketLinked" checked>
												</label>
											</div>
										</div>
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
	                            		<div class="form-group">
											<label class="col-sm-4 control-label">Position X (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addCircle_x1">
												<span id="set001_01_41_addCircle_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Position Y (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addCircle_y1">
												<span id="set001_01_41_addCircle_y1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Position Z (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addCircle_z1">
												<span id="set001_01_41_addCircle_z1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Radius (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addCircle_radius">
												<span id="set001_01_41_addCircle_radius_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Fill Color</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="set001_01_41_addCircle_fill">
												<span id="set001_01_41_addCircle_fill_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Stroke Color</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="set001_01_41_addCircle_stroke">
												<span id="set001_01_41_addCircle_stroke_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Stroke Width (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addCircle_strokeWidth">
												<span id="set001_01_41_addCircle_strokeWidth_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Rotation (degree)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addCircle_rotation">
												<span id="set001_01_41_addCircle_rotation_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_01_41_addCircle_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_41_addCircle_initialized = false;
var set001_01_41_addCircle_validInput = false;

var set001_01_41_addCircle_callbackFn;

function set001_01_41_addCircle_isOpen()
{
	return ($("#set001_01_41_addCircle").data('bs.modal') || {}).isShown;	
} // .end of set001_01_41_addCircle_isOpen

function set001_01_41_addCircle_init()
{
    if (set001_01_41_addCircle_initialized == true)
        return false;
    
    $('#set001_01_41_addCircle').on('shown.bs.modal', function () {

	    $('#set001_01_41_addCircle_componentName').focus();
	});
    
	set001_01_41_addCircle_initialized = true;
} // .end of set001_01_41_addCircle_init

function set001_01_41_addCircle_show(callbackFn)
{
	// Set callback
	set001_01_41_addCircle_callbackFn = callbackFn;
	// Update UI
	set001_01_41_addCircle_updateUI();
} // .end of set001_01_41_addCircle_show

function set001_01_41_addCircle_updateUI()
{
    set001_01_41_addCircle_init();
    
    // Reset
    $('#set001_01_41_addCircle_x1').val('100');
    $('#set001_01_41_addCircle_y1').val('100');
    $('#set001_01_41_addCircle_z1').val('1');
    $('#set001_01_41_addCircle_radius').val('50');
    $('#set001_01_41_addCircle_fill').val('#FFFFFF');
    $('#set001_01_41_addCircle_stroke').val('#000000');
    $('#set001_01_41_addCircle_strokeWidth').val('2');
    $('#set001_01_41_addCircle_rotation').val('0');
    $('#set001_01_41_addCircle_bucketLinked').prop('checked', true);
    
    // Show Modal Window on Top
    module_showModalWindow('set001_01_41_addCircle', true);
} // .end of set001_01_41_addCircle_updateUI

function set001_01_41_addCircle_save()
{
	// reset
    $('.error-msg').hide();
	
    var name = $.trim( $('#set001_01_41_addCircle_componentName').val() );
    var paxCount = $.trim( $('#set001_01_41_addCircle_paxCount').val() );
	var x1 = $.trim( $('#set001_01_41_addCircle_x1').val() );
	var y1 = $.trim( $('#set001_01_41_addCircle_y1').val() );
	var z1 = $.trim( $('#set001_01_41_addCircle_z1').val() );
	var radius = $.trim( $('#set001_01_41_addCircle_radius').val() );
	var fill = $.trim( $('#set001_01_41_addCircle_fill').val() );
	var stroke = $.trim( $('#set001_01_41_addCircle_stroke').val() );
	var strokeWidth = $.trim( $('#set001_01_41_addCircle_strokeWidth').val() );
	var rotation = $.trim( $('#set001_01_41_addCircle_rotation').val() );
	var bucketLinked = $('#set001_01_41_addCircle_bucketLinked').prop('checked');

	if (name == '') {
    	$('#set001_01_41_addCircle_componentName').focus();
		$('#set001_01_41_addCircle_componentName_error').show();
		return false;
	}
	if (paxCount == '') {
    	$('#set001_01_41_addCircle_paxCount').focus();
		$('#set001_01_41_addCircle_paxCount_error').show();
		return false;
	}
	if (x1 == '') {
    	$('#set001_01_41_addCircle_x1').focus();
		$('#set001_01_41_addCircle_x1_error').show();
		return false;
	}
	if (y1 == '') {
    	$('#set001_01_41_addCircle_y1').focus();
		$('#set001_01_41_addCircle_y1_error').show();
		return false;
	}
	if (z1 == '') {
    	$('#set001_01_41_addCircle_z1').focus();
		$('#set001_01_41_addCircle_z1_error').show();
		return false;
	}
	if (radius == '') {
    	$('#set001_01_41_addCircle_radius').focus();
		$('#set001_01_41_addCircle_radius_error').show();
		return false;
	}
	if (fill == '') {
    	$('#set001_01_41_addCircle_fill').focus();
		$('#set001_01_41_addCircle_fill_error').show();
		return false;
	}
	if (stroke == '') {
    	$('#set001_01_41_addCircle_stroke').focus();
		$('#set001_01_41_addCircle_stroke_error').show();
		return false;
	}
	if (strokeWidth == '') {
    	$('#set001_01_41_addCircle_strokeWidth').focus();	
		$('#set001_01_41_addCircle_strokeWidth_error').show();
		return false;
	}
	if (rotation == '') {
    	$('#set001_01_41_addCircle_rotation').focus();
		$('#set001_01_41_addCircle_rotation_error').show();
		return false;
	}
	
	// Create attributes
	var attributesObj = new Object();
	attributesObj.x1 = Math.abs(x1);
	attributesObj.y1 = Math.abs(y1);
	attributesObj.z1 = z1;
	attributesObj.radius = Math.abs(radius);
	attributesObj.fill = fill;
	attributesObj.stroke = stroke;
	attributesObj.strokeWidth = Math.abs(strokeWidth);
	attributesObj.rotationDegree = rotation;
	attributesObj.bucketLinked = bucketLinked;
	
	// New component
	var newComponentObj = createNew_PlaceLayoutComponent();
	newComponentObj.layoutId = ''; // Callback function will assign id
	newComponentObj.bucketId = '';
	newComponentObj.name = name;
	newComponentObj.paxCount = paxCount;
	newComponentObj.objectType = PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE;
	newComponentObj.attributes = JSON.stringify(attributesObj);
	
    // Close Modal Window
    $('#set001_01_41_addCircle').modal('hide');
    // Call back
    if (set001_01_41_addCircle_callbackFn != null)
    	set001_01_41_addCircle_callbackFn(newComponentObj);
} // .end of set001_01_41_addCircle_save

</script>