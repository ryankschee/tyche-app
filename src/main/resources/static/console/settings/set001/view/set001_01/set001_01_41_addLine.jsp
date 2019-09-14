<!-- Modal Window: Add Line Shape -->
<div class="modal inmodal fade" id="set001_01_41_addLine" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg4">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">ADD LINE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_01_41_addLine_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-md-6">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Component Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_41_addLine_componentName">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Pax Count</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_01_41_addLine_paxCount">
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
	                            		<div class="form-group">
											<label class="col-sm-4 control-label">Position X1 (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addLine_x1">
												<span id="set001_01_41_addLine_x1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Position Y1 (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addLine_y1">
												<span id="set001_01_41_addLine_y1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Position X2 (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addLine_x2">
												<span id="set001_01_41_addLine_x2_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Position Y2 (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addLine_y2">
												<span id="set001_01_41_addLine_y2_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Stroke Color</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="set001_01_41_addLine_stroke">
												<span id="set001_01_41_addLine_stroke_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Stroke Width (px)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addLine_strokeWidth">
												<span id="set001_01_41_addLine_strokeWidth_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label">Rotation (degree)</label>
											<div class="col-sm-8">
												<input type="number" class="form-control" id="set001_01_41_addLine_rotation">
												<span id="set001_01_41_addLine_rotation_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_01_41_addLine_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_41_addLine_initialized = false;
var set001_01_41_addLine_validInput = false;

var set001_01_41_addLine_callbackFn;

function set001_01_41_addLine_isOpen()
{
	return ($("#set001_01_41_addLine").data('bs.modal') || {}).isShown;	
} // .end of set001_01_41_addLine_isOpen

function set001_01_41_addLine_init()
{
    if (set001_01_41_addLine_initialized == true)
        return false;
    
    $('#set001_01_41_addLine').on('shown.bs.modal', function () {

	    $('#set001_01_41_addLine_componentName').focus();
	});
    
	set001_01_41_addLine_initialized = true;
} // .end of set001_01_41_addLine_init

function set001_01_41_addLine_show(callbackFn)
{
	// Set callback
	set001_01_41_addLine_callbackFn = callbackFn;
	// Update UI
	set001_01_41_addLine_updateUI();
} // .end of set001_01_41_addLine_show

function set001_01_41_addLine_updateUI()
{
    set001_01_41_addLine_init();
    
    // Reset
    $('#set001_01_41_addLine_x1').val('100');
    $('#set001_01_41_addLine_y1').val('100');
    $('#set001_01_41_addLine_x2').val('100');
    $('#set001_01_41_addLine_y2').val('200');
    $('#set001_01_41_addLine_stroke').val('#000000');
    $('#set001_01_41_addLine_strokeWidth').val('2');
    $('#set001_01_41_addLine_rotation').val('0');
    
    // Show Modal Window on Top
    module_showModalWindow('set001_01_41_addLine', true);
} // .end of set001_01_41_addLine_updateUI

function set001_01_41_addLine_save()
{
	// reset
    $('.error-msg').hide();
	
    var name = $.trim( $('#set001_01_41_addLine_componentName').val() );
    var paxCount = $.trim( $('#set001_01_41_addLine_paxCount').val() );
	var x1 = $.trim( $('#set001_01_41_addLine_x1').val() );
	var y1 = $.trim( $('#set001_01_41_addLine_y1').val() );
	var x2 = $.trim( $('#set001_01_41_addLine_x2').val() );
	var y2 = $.trim( $('#set001_01_41_addLine_y2').val() );
	var stroke = $.trim( $('#set001_01_41_addLine_stroke').val() );
	var strokeWidth = $.trim( $('#set001_01_41_addLine_strokeWidth').val() );
	var rotation = $.trim( $('#set001_01_41_addLine_rotation').val() );

	if (name == '') {
    	$('#set001_01_41_addLine_componentName').focus();
		$('#set001_01_41_addLine_componentName_error').show();
		return false;
	}
	if (paxCount == '') {
    	$('#set001_01_41_addLine_paxCount').focus();
		$('#set001_01_41_addLine_paxCount_error').show();
		return false;
	}
	if (x1 == '') {
    	$('#set001_01_41_addLine_x1').focus();
		$('#set001_01_41_addLine_x1_error').show();
		return false;
	}
	if (y1 == '') {
    	$('#set001_01_41_addLine_y1').focus();
		$('#set001_01_41_addLine_y1_error').show();
		return false;
	}
	if (x2 == '') {
    	$('#set001_01_41_addLine_x2').focus();
		$('#set001_01_41_addLine_x2_error').show();
		return false;
	}
	if (y2 == '') {
    	$('#set001_01_41_addLine_y2').focus();
		$('#set001_01_41_addLine_y2_error').show();
		return false;
	}
	if (stroke == '') {
    	$('#set001_01_41_addLine_stroke').focus();
		$('#set001_01_41_addLine_stroke_error').show();
		return false;
	}
	if (strokeWidth == '') {
    	$('#set001_01_41_addLine_strokeWidth').focus();
		$('#set001_01_41_addLine_strokeWidth_error').show();
		return false;
	}
	if (rotation == '') {
    	$('#set001_01_41_addLine_rotation').focus();
		$('#set001_01_41_addLine_rotation_error').show();
		return false;
	}
	
	// Create attributes
	var attributesObj = new Object();
	attributesObj.x1 = Math.abs(x1);
	attributesObj.y1 = Math.abs(y1);
	attributesObj.x2 = Math.abs(x2);
	attributesObj.y2 = Math.abs(y2);
	attributesObj.stroke = stroke;
	attributesObj.strokeWidth = Math.abs(strokeWidth);
	attributesObj.rotationDegree = rotation;
	
	// New component
	var newComponentObj = createNew_PlaceLayoutComponent();
	newComponentObj.layoutId = ''; // Callback function will assign id
	newComponentObj.bucketId = '';
	newComponentObj.name = name;
	newComponentObj.paxCount = paxCount;
	newComponentObj.objectType = PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_LINE;
	newComponentObj.attributes = JSON.stringify(attributesObj);
	
    // Close Modal Window
    $('#set001_01_41_addLine').modal('hide');
    // Call back
    if (set001_01_41_addLine_callbackFn != null)
    	set001_01_41_addLine_callbackFn(newComponentObj);
} // .end of set001_01_41_addLine_save

</script>