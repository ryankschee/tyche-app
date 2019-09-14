
<!-- Modal Window: Add Image -->
<div class="modal inmodal fade" id="set001_document_mw_addImage" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">NEW IMAGE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_addImage_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Field Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_addImage_name">
	                                    	<span id="set001_document_mw_addImage_name_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="set001_document_mw_addImage_name_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>	                            	
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Source</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_addImage_imageSource" onchange="set001_document_mw_addImage_onImageSourceChanged(this);">
	                                    	</select>
	                                    	<span id="set001_document_mw_addImage_imageSource_notes" class="m-b-none" style="color:#0000FF;">Notes: Only support JPG files.</span>
	                                    	<span id="set001_document_mw_addImage_imageSource_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div id="set001_document_mw_addImage_preview" style="display:none;">
	                                	<div class="form-group">
		                                	<label class="col-sm-4 control-label">Logo Width (px)</label>
		                                    <div class="col-sm-8">
		                                    	<input type="number" min="1" class="form-control" id="set001_document_mw_addImage_width" oninput="set001_document_mw_addImage_onDimensionChanged('width');">
		                                    	<span id="set001_document_mw_addImage_width_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                	<label class="col-sm-4 control-label">Logo Height (px)</label>
		                                    <div class="col-sm-8">
		                                    	<input type="number" min="1" class="form-control" id="set001_document_mw_addImage_height" oninput="set001_document_mw_addImage_onDimensionChanged('height');">
		                                    	<span id="set001_document_mw_addImage_height_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                	<label class="col-sm-4 control-label">Preview</label>
		                                    <div class="col-sm-8">
		                                    	<img id="set001_document_mw_addImage_imagePreview" src="" style="width:100%; height:100%">
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
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_addImage_save();">Add Image</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_addImage_initialized = false;
var set001_document_mw_addImage_validInput = false;
var set001_document_mw_addImage_saveCallbackFn;

function set001_document_mw_addImage_isOpen()
{
	return ($("#set001_document_mw_addImage").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_addImage_isOpen

function set001_document_mw_addImage_init()
{
    if (set001_document_mw_addImage_initialized == true)
        return false;

    $('.set001_document_mw_addImage_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_addImage').on('shown.bs.modal', function () {
	    $("#set001_document_mw_addImage_name").focus();
	});
    
	set001_document_mw_addImage_initialized = true;
} // .end of set001_document_mw_addImage_init

function set001_document_mw_addImage_show(callbackFn)
{
	set001_document_mw_addImage_saveCallbackFn = callbackFn;
	
    set001_document_mw_addImage_updateUI();
} // .end of set001_document_mw_addImage_show

function set001_document_mw_addImage_updateUI()
{
    set001_document_mw_addImage_init();

    var placeObj = tycheesCommon_getCurrentPlaceObject(); 
    
    $('#set001_document_mw_addImage_imageSource').empty();
    $('#set001_document_mw_addImage_imageSource').append('<option val="0" selected>-- SELECT IMAGE --</option>');
    
    $.each(placeObj.imageList, function(i, imageObj) {

    	if (imageObj.fileType != 'image/jpg' && imageObj.fileType != 'image/jpeg')
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + imageObj.id + '">';
    	htmlLines += imageObj.fileName;
    	htmlLines += '</option>';
    	
    	$('#set001_document_mw_addImage_imageSource').append(htmlLines);
    });
    
    // Setup inputs
    $('#set001_document_mw_addImage_name').val('');
    $('#set001_document_mw_addImage_imageSource').val('0');
    $('#set001_document_mw_addImage_preview').hide();
    $('#set001_document_mw_addImage_width').val('');
    $('#set001_document_mw_addImage_height').val('');
    $('#set001_document_mw_addImage_imagePreview').prop('src','');
    // Reset
    $('.help-block').hide();

    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_addImage', true);
} // .end of set001_document_mw_addImage_updateUI

function set001_document_mw_addImage_onImageSourceChanged(element)
{
	var selectedValue = $.trim($(element).val());	
    var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	if (selectedValue == '') {		
	    $('#set001_document_mw_addImage_preview').hide();	    
	} else {
		var selectedImageObj;
		$.each(placeObj.imageList, function(i, imageObj) {
	        if (imageObj.id == selectedValue) {
	        	selectedImageObj = imageObj;
	        }
	    });
		
		if (selectedImageObj == null) {
			$('#set001_document_mw_addImage_preview').hide();
		} else {
		    $('#set001_document_mw_addImage_width').val(selectedImageObj.width);
		    $('#set001_document_mw_addImage_height').val(selectedImageObj.height);
		    $('#set001_document_mw_addImage_imagePreview').prop('src', selectedImageObj.base64);
			$('#set001_document_mw_addImage_preview').show();
		}		
	}
} //.end of set001_document_mw_addImage_onImageSourceChanged

function set001_document_mw_addImage_onDimensionChanged(edge)
{
    var placeObj = tycheesCommon_getCurrentPlaceObject();    
	var selectedImageId = $.trim($('#set001_document_mw_addImage_imageSource').val());	
	var selectedImageObj;
	$.each(placeObj.imageList, function(i, imageObj) {
        if (imageObj.id == selectedImageId) {
        	selectedImageObj = imageObj;
        }
    });
	
	if (selectedImageObj != null && edge == 'width') {		
		var imageWidth = $('#set001_document_mw_addImage_width').val();
		var imageHeight = tycheesImage_getImageHeightByRatio(selectedImageObj.width, selectedImageObj.height, imageWidth);
		$('#set001_document_mw_addImage_height').val(tycheesMath_round(imageHeight, 0));
	}
	
	if (selectedImageObj != null && edge == 'height') {
		var imageHeight = $('#set001_document_mw_addImage_height').val();
		var imageWidth = tycheesImage_getImageWidthByRatio(selectedImageObj.width, selectedImageObj.height, imageHeight);			
		$('#set001_document_mw_addImage_width').val(tycheesMath_round(imageWidth, 0));
	}
} // .end of set001_document_mw_addImage_onDimensionChanged

function set001_document_mw_addImage_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_addImage_name').val() );
    var imageId = $.trim( $('#set001_document_mw_addImage_imageSource').val() );
    var width = parseInt( $('#set001_document_mw_addImage_width').val() );
    var height = parseInt( $('#set001_document_mw_addImage_height').val() );

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_addImage_name_error').show();
    	$('#set001_document_mw_addImage_name').focus();
    	return false;
    }
    // Validation #2: if empty value
    if (imageId == '0' || imageId == '')
    {
    	$('#set001_document_mw_addImage_imageSource_error').show();
    	return false;
    }	
    // Validation #3: non-integer width
    if (width == NaN || width <= 0)
    {
    	$('#set001_document_mw_addImage_width_error').show();
    	$('#set001_document_mw_addImage_width').focus();
    	return false;
    }    
    // Validation #4: non-integer height
    if (height == NaN || height <= 0)
    {
    	$('#set001_document_mw_addImage_height_error').show();
    	$('#set001_document_mw_addImage_height').focus();
    	return false;
    }

	// https://konvajs.github.io/api/Konva.Text.html
	var attributesObj = new Object();
	attributesObj.imageId = imageId;		
	attributesObj.x1 = 50;
	attributesObj.y1 = 50;
	attributesObj.imageWidth = width;	
	attributesObj.imageHeight = height;
	
	var componentObj = createNew_PlaceDocumentTemplateComponent();
	componentObj.name = name;
	componentObj.objectType = DocumentConstants.COMPONENT_OBJECT_TYPE_IMAGE;
	componentObj.attributes = JSON.stringify(attributesObj);
    	
    // Close Modal Window
    $('#set001_document_mw_addImage').modal('hide');
    
    if (set001_document_mw_addImage_saveCallbackFn != null)
    	set001_document_mw_addImage_saveCallbackFn(componentObj);
} // .end of set001_document_mw_addImage_save

</script>