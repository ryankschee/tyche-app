
<!-- Modal Window: Edit Image -->
<div class="modal inmodal fade" id="set001_document_mw_editImage" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">EDIT IMAGE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_editImage_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Field Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_editImage_name">
	                                    	<span id="set001_document_mw_editImage_name_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="set001_document_mw_editImage_name_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>	                            	
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Source</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_editImage_imageSource" onchange="set001_document_mw_editImage_onImageSourceChanged(this);">
	                                    	</select>
	                                    	<span id="set001_document_mw_editImage_imageSource_notes" class="m-b-none" style="color:#0000FF;">Notes: Only support JPG files.</span>
	                                    	<span id="set001_document_mw_editImage_imageSource_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div id="set001_document_mw_editImage_preview" style="display:none;">
	                                	<div class="form-group">
		                                	<label class="col-sm-4 control-label">Logo Width (px)</label>
		                                    <div class="col-sm-8">
		                                    	<input type="number" min="1" class="form-control" id="set001_document_mw_editImage_width" oninput="set001_document_mw_editImage_onDimensionChanged('width');">
		                                    	<span id="set001_document_mw_editImage_width_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                	<label class="col-sm-4 control-label">Logo Height (px)</label>
		                                    <div class="col-sm-8">
		                                    	<input type="number" min="1" class="form-control" id="set001_document_mw_editImage_height" oninput="set001_document_mw_editImage_onDimensionChanged('height');">
		                                    	<span id="set001_document_mw_editImage_height_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                	<label class="col-sm-4 control-label">Preview</label>
		                                    <div class="col-sm-8">
		                                    	<img id="set001_document_mw_editImage_imagePreview" src="" style="width:100%; height:100%">
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
		    	<button type="button" class="btn btn-danger" onclick="set001_document_mw_editImage_delete();">Delete</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_editImage_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_editImage_initialized = false;
var set001_document_mw_editImage_validInput = false;
var set001_document_mw_editImage_saveCallbackFn;

var set001_document_mw_editImage_callbackFn;
var set001_document_mw_editImage_templateObj;
var set001_document_mw_editImage_componentObj;

function set001_document_mw_editImage_isOpen()
{
	return ($("#set001_document_mw_editImage").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_editImage_isOpen

function set001_document_mw_editImage_init()
{
    if (set001_document_mw_editImage_initialized == true)
        return false;

    $('.set001_document_mw_editImage_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_editImage').on('shown.bs.modal', function () {
	    $("#set001_document_mw_editImage_name").focus();
	});
    
	set001_document_mw_editImage_initialized = true;
} // .end of set001_document_mw_editImage_init

function set001_document_mw_editImage_show(templateObj, componentObj, callbackFn)
{
	// Set callback
	set001_document_mw_editImage_callbackFn = callbackFn;
	// Set component
	set001_document_mw_editImage_templateObj = templateObj;
	set001_document_mw_editImage_componentObj = componentObj;
	
    set001_document_mw_editImage_updateUI();
} // .end of set001_document_mw_editImage_show

function set001_document_mw_editImage_updateUI()
{
    set001_document_mw_editImage_init();

    var attributesObj = JSON.parse(set001_document_mw_editImage_componentObj.attributes);    
    var placeObj = tycheesCommon_getCurrentPlaceObject(); 
    var selectedImageObj;
    
    $('#set001_document_mw_editImage_imageSource').empty();
    $('#set001_document_mw_editImage_imageSource').append('<option val="">-- SELECT IMAGE --</option>');
    
    $.each(placeObj.imageList, function(i, imageObj) {
        
    	if (imageObj.fileType != 'image/jpg' && imageObj.fileType != 'image/jpeg')
    		return true;
    	
    	if (attributesObj.imageId == imageObj.id)
    		selectedImageObj = imageObj;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + imageObj.id + '">';
    	htmlLines += imageObj.fileName;
    	htmlLines += '</option>';
    	
    	$('#set001_document_mw_editImage_imageSource').append(htmlLines);
    });
    
    // Setup inputs
    $('#set001_document_mw_editImage_name').val( set001_document_mw_editImage_componentObj.name );
    $('#set001_document_mw_editImage_imageSource').val( attributesObj.imageId );
    $('#set001_document_mw_editImage_width').val( attributesObj.imageWidth );
    $('#set001_document_mw_editImage_height').val( attributesObj.imageHeight );
    if (selectedImageObj != null)
    	$('#set001_document_mw_editImage_imagePreview').prop('src', selectedImageObj.base64);
    $('#set001_document_mw_editImage_preview').show();
    
    // Reset
    $('.help-block').hide();

    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_editImage', true);
} // .end of set001_document_mw_editImage_updateUI

function set001_document_mw_editImage_onImageSourceChanged(element)
{
	var selectedValue = $.trim($(element).val());	
    var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	if (selectedValue == '') {		
	    $('#set001_document_mw_editImage_preview').hide();	    
	} else {
		var selectedImageObj;
		$.each(placeObj.imageList, function(i, imageObj) {
	        if (imageObj.id == selectedValue) {
	        	selectedImageObj = imageObj;
	        }
	    });
		
		if (selectedImageObj == null) {
			$('#set001_document_mw_editImage_preview').hide();
		} else {
			var base64content = 'iVBORw0KGgoAAAANSUhEUgAAANwAAADDCAMAAADeBI/9AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAOFQTFRFhoaGnJyclpaWx8fHsrKy2NjYkZGRi4uLoaGhvLy8t7e3rKyswsLCzc3N0tLSmpqap6enm5ub3NzckJCQtbW1oqKira2tiYmJmZmZkpKSj4+PxsbGv7+/tLS0qKiol5eXzMzMioqKubm5pqamqqqqjIyMnZ2d2trayMjIsLCws7Oznp6ejY2N19fXu7u7tra21NTU2dnZiIiIvb29w8PDq6ur0dHRn5+fwcHBlJSUysrKjo6OycnJxMTEwMDAurq61dXVpKSkz8/Prq6u29vb1tbWvr6+mJiYsbGxh4eH3d3dRA4j6QAABIlJREFUeNrs24dy4zYQBuAFe5OOkeVzt8/tcjXXa3qP8f4PFCxAirCSuagkOS7mx4xlayXK/AYggAUo0gEXAg444IADDjjggAMOOOCAAw444IADDjjggAMOOOCAAw444IADDjjggAMOOOCAAw444IAbIW6e3WxYsvnYcXdvtih3x42rbrYq1ahxO9vhslHj3Dl+iNYuH9yRo8edH29y5PGeCNz+ZoeeicCpzQ69A5wY3PPy0cn7NEjcizfX/O7DKkBceqcf3E7Dw+0OQ/dJaLgjb15y/Tww3Kk/67oIDHfm4y4Dwx34uN3AcPs+7jQwXO3jXgWGu+fZdp5y5AuxuNnsE+sRv8ke504ODq/SJe6Pve2R7BnKGxv+cin6VWSie+pI9tzywtVQsdw0Zw+O398TnvLEe137a8PL56bDitjD0HAv/OH6U2vKEoeCy1sLk+Vwwf0qH7e0BL33bRf/uJ/vpsJxr5fXlM8fuGGAO5n7v4jG/XT9lxXzJ9z5/+FlA1Jx6dnf7Ad8/ey7xRLDlWBc8Y87Hw/F4n5eYV9nLhT3aqVdq+9F4j7mK+FevhaI++FgxQ3H/BtxuNn9lbdTn0yk4a7W2CzeectHKDG4i7W2wqOnknBHa270c5YupVm+PVz3NgaTpcvAvZv9vv5NGpf6sQjc43qTW1Dm70TgXm52g825CNw2BTjggAMOOPG4oG8mDfo24KBv4NZ6vnHL3Hmmx44bUwEOOOCAAw444IADDjjggAMOOOCAAw444IADDjjggPtPSqkmWitlvxhRKftNkEJN7UtNRBQlWk+ULQJxCcXm04m/eZXmlDDXPdM1ZUkSFVrHlAnGxURkqq4iMhStcpWbZ1Oy1ZkyLhHaLB2u5fPPWjLVM6G6oZIrruneIh2XFHna0IRxLU10HpkKXPxL1yxLubiYqkJpxjGsNkCH40fZuIYqnWWmLRpYyZLIdClcgz1OcrPkH4OylIK4Z8xzE2iDwaWqYkpKkRsGGm2qL44ji1OJKVO5OO2usMq0UM1dZmG4xEXbkcKUOKzpVxqbgrklcMABB1wgOFX3j3XBmUxt07NGJfbvqXtS9pHunYsUro/WZvLSlovD7fN/Yda5LY5U/6hc0mY/MCOacnZqB+6C/3aR/p390X1UmblZTvXiJUWjw1HVnV1MBU8b3ZTLPnaRJdwiypE0Iw83imbp49o+oSkojfhe7NbVXzlEbuMWUYfLx4xLs8ie1tQ00Irz7YZbWpSnQ+QWbojaZpmXS81yVDjOYfjs+IRTewVmmRG0fsTHDVHGRLy2MmIcL2wRdxOcuXGTTKjh5NuL+LghaiOcOIyrWfKFYhKZtrtucpPKTOzqQcTdi6kXXl3wIh7Oi9pIYzqXceESKuIm4pzMnlBpcG55y3WVLQ0LXjbicDZH9aKK4rjMzKd0L7lfn30oMCdOxF3BsPCT511XOOE+g3tDL9INGpyjelEbcR2Kfcn9Up8dx5nn1p8xMcnrBHNL4IADDjjggAMOOOCAAw444IADDjjggAMOOOCAAw444IADDrj/v/wpwAAur1CW2e6L0QAAAABJRU5ErkJggg==';
			if (selectedImageObj.base64 != null)
				base64content = selectedImageObj.base64;
			
		    $('#set001_document_mw_editImage_width').val(selectedImageObj.width);
		    $('#set001_document_mw_editImage_height').val(selectedImageObj.height);
		    $('#set001_document_mw_editImage_imagePreview').prop('src', base64content);
			$('#set001_document_mw_editImage_preview').show();
		}		
	}
} //.end of set001_document_mw_editImage_onImageSourceChanged

function set001_document_mw_editImage_onDimensionChanged(edge)
{
    var placeObj = tycheesCommon_getCurrentPlaceObject();    
	var selectedImageId = $.trim($('#set001_document_mw_editImage_imageSource').val());	
	var selectedImageObj;
	$.each(placeObj.imageList, function(i, imageObj) {
        if (imageObj.id == selectedImageId) {
        	selectedImageObj = imageObj;
        }
    });
	
	if (selectedImageObj != null && edge == 'width') {		
		var imageWidth = $('#set001_document_mw_editImage_width').val();
		var imageHeight = tycheesImage_getImageHeightByRatio(selectedImageObj.width, selectedImageObj.height, imageWidth);
		$('#set001_document_mw_editImage_height').val(tycheesMath_round(imageHeight, 0));
	}
	
	if (selectedImageObj != null && edge == 'height') {
		var imageHeight = $('#set001_document_mw_editImage_height').val();
		var imageWidth = tycheesImage_getImageWidthByRatio(selectedImageObj.width, selectedImageObj.height, imageHeight);			
		$('#set001_document_mw_editImage_width').val(tycheesMath_round(imageWidth, 0));
	}
} // .end of set001_document_mw_editImage_onDimensionChanged

function set001_document_mw_editImage_delete()
{
	swal({
		title: "Are you sure?",
		text: "You will lose this component (" + set001_document_mw_editImage_componentObj.name + ")",
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
			Cached_deleteBean(set001_document_mw_editImage_componentObj);
		    // Close Modal Window
		    $('#set001_document_mw_editImage').modal('hide');
		    // Call back
		    if (set001_document_mw_editImage_callbackFn != null)
		    	set001_document_mw_editImage_callbackFn();
		}
	});
} // .end of set001_document_mw_editImage_delete

function set001_document_mw_editImage_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_editImage_name').val() );
    var imageId = $.trim( $('#set001_document_mw_editImage_imageSource').val() );
    var width = parseInt( $('#set001_document_mw_editImage_width').val() );
    var height = parseInt( $('#set001_document_mw_editImage_height').val() );

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_editImage_name_error').show();
    	$('#set001_document_mw_editImage_name').focus();
    	return false;
    }
    // Validation #2: if empty value
    if (imageId == '')
    {
    	$('#set001_document_mw_editImage_imageSource_error').show();
    	return false;
    }	
    // Validation #3: non-integer width
    if (width == NaN || width <= 0)
    {
    	$('#set001_document_mw_editImage_width_error').show();
    	$('#set001_document_mw_editImage_width').focus();
    	return false;
    }    
    // Validation #4: non-integer height
    if (height == NaN || height <= 0)
    {
    	$('#set001_document_mw_editImage_height_error').show();
    	$('#set001_document_mw_editImage_height').focus();
    	return false;
    }

	// https://konvajs.github.io/api/Konva.Text.html
    var attributesObj = JSON.parse(set001_document_mw_editImage_componentObj.attributes); 
	attributesObj.imageId = imageId;
	attributesObj.imageWidth = width;	
	attributesObj.imageHeight = height;
	
	set001_document_mw_editImage_componentObj.name = name;
	set001_document_mw_editImage_componentObj.attributes = JSON.stringify(attributesObj);
    	
    // Close Modal Window
    $('#set001_document_mw_editImage').modal('hide');
    
    if (set001_document_mw_editImage_saveCallbackFn != null)
    	set001_document_mw_editImage_saveCallbackFn();
} // .end of set001_document_mw_editImage_save

</script>