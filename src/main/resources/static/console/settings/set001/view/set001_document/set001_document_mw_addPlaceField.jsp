
<!-- Modal Window: Add place's field -->
<div class="modal inmodal fade" id="set001_document_mw_addPlaceField" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">NEW PLACE FIELD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_document_mw_addPlaceField_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Field Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_document_mw_addPlaceField_name">
	                                    	<span id="set001_document_mw_addPlaceField_name_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="set001_document_mw_addPlaceField_name_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>	                            	
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Source</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="set001_document_mw_addPlaceField_fieldType" onchange="set001_document_mw_addPlaceField_onFieldTypeChanged(this);">
	                                    		<option value="place.name">Place Name</option>
	                                    		<option value="place.companyName">Company Name</option>
	                                    		<option value="place.companyRegistrationNo">Company Registration No</option>
	                                    		<option value="place.address">Place Address</option>
	                                    		<option value="place.phone">Place Phone</option>
	                                    		<option value="place.mobile">Place Mobile</option>
	                                    		<option value="place.website">Place Website</option>
	                                    		<option value="place.email">Place Email</option>
	                                    		<option value="place.logo">Place Logo</option>
	                                    		<option value="place.gstNumber">GST Number</option>
	                                    	</select>
	                                    	<span id="set001_document_mw_addPlaceField_fieldType_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div id="set001_document_mw_addPlaceField_preview" style="display:none;">
	                                	<div class="form-group">
		                                	<label class="col-sm-4 control-label">Preview</label>
		                                    <div class="col-sm-8">
		                                    	<input type="text" class="form-control" id="set001_document_mw_addPlaceField_fieldPreview" disabled>
		                                    </div>
		                                </div>
	                                </div>
	                                <div id="set001_document_mw_addPlaceField_logoDimension" style="display:none;">
	                                	<div class="form-group">
		                                	<label class="col-sm-4 control-label">Logo Width (px)</label>
		                                    <div class="col-sm-8">
		                                    	<input type="number" min="1" class="form-control" id="set001_document_mw_addPlaceField_width" oninput="set001_document_mw_addPlaceField_onDimensionChanged('width');">
		                                    	<span id="set001_document_mw_addPlaceField_width_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                	<label class="col-sm-4 control-label">Logo Height (px)</label>
		                                    <div class="col-sm-8">
		                                    	<input type="number" min="1" class="form-control" id="set001_document_mw_addPlaceField_height" oninput="set001_document_mw_addPlaceField_onDimensionChanged('height');">
		                                    	<span id="set001_document_mw_addPlaceField_height_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                	<label class="col-sm-4 control-label">Preview</label>
		                                    <div class="col-sm-8">
		                                    	<img id="set001_document_mw_addPlaceField_imagePreview" src="" style="width:100%; height:100%">
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
		    	<button type="button" class="btn btn-primary" onclick="set001_document_mw_addPlaceField_save();">Add Field</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_document_mw_addPlaceField_initialized = false;
var set001_document_mw_addPlaceField_validInput = false;
var set001_document_mw_addPlaceField_saveCallbackFn;

function set001_document_mw_addPlaceField_isOpen()
{
	return ($("#set001_document_mw_addPlaceField").data('bs.modal') || {}).isShown;	
} // .end of set001_document_mw_addPlaceField_isOpen

function set001_document_mw_addPlaceField_init()
{
    if (set001_document_mw_addPlaceField_initialized == true)
        return false;

    $('.set001_document_mw_addPlaceField_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_document_mw_addPlaceField').on('shown.bs.modal', function () {
	    $("#set001_document_mw_addPlaceField_name").focus();
	    $('#set001_document_mw_addPlaceField_fieldPreview').val('');
	    $('#set001_document_mw_addPlaceField_logoDimension').hide();
	});
    
	set001_document_mw_addPlaceField_initialized = true;
} // .end of set001_document_mw_addPlaceField_init

function set001_document_mw_addPlaceField_show(callbackFn)
{
	set001_document_mw_addPlaceField_saveCallbackFn = callbackFn;
	
    set001_document_mw_addPlaceField_updateUI();
} // .end of set001_document_mw_addPlaceField_show

function set001_document_mw_addPlaceField_updateUI()
{
    set001_document_mw_addPlaceField_init();
    
    // Setup inputs
    $('#set001_document_mw_addPlaceField_name').val( '' );
    $('#set001_document_mw_addPlaceField_fieldType').val( 'place.name' );
    // Reset
    $('.help-block').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('set001_document_mw_addPlaceField', true);
} // .end of set001_document_mw_addPlaceField_updateUI

function set001_document_mw_addPlaceField_onFieldTypeChanged(element)
{
	var selectedValue = $.trim($(element).val());	
    var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	if (selectedValue == 'place.logo') {		
		if (placeObj.imageList.length == 0) {
			var requestBody = new Object();
		    requestBody.onlyTypeLogo = true;
		    
		    var params = new Object();
		    
		    tycheesdb_api_getPlaceImagesByPlace(requestBody, set001_document_mw_addPlaceField_afterImagesLoaded, params); 
		} else {
	    	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);

	    	if (companyLogoImageObj == null) {
	    		var imageWidth = 100;
				var imageHeight = tycheesImage_getImageHeightByRatio(1000, 970, imageWidth);
		    	
			    $('#set001_document_mw_addPlaceField_width').val(tycheesMath_round(imageWidth, 0));
			    $('#set001_document_mw_addPlaceField_height').val(tycheesMath_round(imageHeight, 0));
			    $('#set001_document_mw_addPlaceField_imagePreview').prop('src', '/resources/images/misc/noPhotoFound.png');
	    	} else {
		    	var imageWidth = 100;
		    	var imageHeight = tycheesImage_getImageHeightByRatio(companyLogoImageObj.width, companyLogoImageObj.height, imageWidth);
		    	
			    $('#set001_document_mw_addPlaceField_width').val(tycheesMath_round(imageWidth, 0));
			    $('#set001_document_mw_addPlaceField_height').val(tycheesMath_round(imageHeight, 0));
			    $('#set001_document_mw_addPlaceField_imagePreview').prop('src', $.trim(companyLogoImageObj.base64));
	    	}
	    	
		    $('#set001_document_mw_addPlaceField_preview').hide();
			$('#set001_document_mw_addPlaceField_logoDimension').show();
		}
	    
	} else {
		if (selectedValue == 'place.name')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.name);
		if (selectedValue == 'place.companyName')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.companyName);
		if (selectedValue == 'place.companyRegistrationNo')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.companyRegistrationNo);
		if (selectedValue == 'place.address')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.address);
		if (selectedValue == 'place.phone')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.phone);
		if (selectedValue == 'place.mobile')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.mobile);
		if (selectedValue == 'place.website')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.website);
		if (selectedValue == 'place.email')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(placeObj.email);
		if (selectedValue == 'place.gstNumber')
			$('#set001_document_mw_addPlaceField_fieldPreview').val(
					Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GST_TAX_INVOICE_NUMBER).propValue);
		
	    $('#set001_document_mw_addPlaceField_width').val('0');
	    $('#set001_document_mw_addPlaceField_height').val('0');
	    $('#set001_document_mw_addPlaceField_preview').show();
		$('#set001_document_mw_addPlaceField_logoDimension').hide();
	}
} //.end of set001_document_mw_addPlaceField_onPageTypeChanged

function set001_document_mw_addPlaceField_afterImagesLoaded(success, responseObj, params) 
{
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'set001_document_mw_addPlaceField_afterImageLoaded');
		return false;
	}

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	placeObj.imageList = responseObj.imageList;
	
	Cached_updatePlace(placeObj);

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
	
	if (companyLogoImageObj == null) {
		var imageWidth = 100;
		var imageHeight = tycheesImage_getImageHeightByRatio(1000, 970, imageWidth);
		
	    $('#set001_document_mw_addPlaceField_width').val(tycheesMath_round(imageWidth, 0));
	    $('#set001_document_mw_addPlaceField_height').val(tycheesMath_round(imageHeight, 0));
	    $('#set001_document_mw_addPlaceField_imagePreview').prop('src', '/resources/images/misc/noPhotoFound.png');
	} else {
		var imageWidth = 100;
		var imageHeight = tycheesImage_getImageHeightByRatio(companyLogoImageObj.width, companyLogoImageObj.height, imageWidth);
		
	    $('#set001_document_mw_addPlaceField_width').val(tycheesMath_round(imageWidth, 0));
	    $('#set001_document_mw_addPlaceField_height').val(tycheesMath_round(imageHeight, 0));
	    $('#set001_document_mw_addPlaceField_imagePreview').prop('src', $.trim(companyLogoImageObj.base64));	    
	}
	
    $('#set001_document_mw_addPlaceField_preview').hide();
	$('#set001_document_mw_addPlaceField_logoDimension').show();
} // .end of set001_document_mw_addPlaceField_afterImageLoaded

function set001_document_mw_addPlaceField_onDimensionChanged(edge)
{
	if (edge == 'width') {
		var placeObj = tycheesCommon_getCurrentPlaceObject();
		var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);
		
		if (companyLogoImageObj == null) {
			var imageWidth = $('#set001_document_mw_addPlaceField_width').val();
			var imageHeight = tycheesImage_getImageHeightByRatio(1000, 970, imageWidth);
			$('#set001_document_mw_addPlaceField_height').val(tycheesMath_round(imageHeight, 0));
		} else {
			var imageWidth = $('#set001_document_mw_addPlaceField_width').val();
			var imageHeight = tycheesImage_getImageHeightByRatio(companyLogoImageObj.width, companyLogoImageObj.height, imageWidth);
			$('#set001_document_mw_addPlaceField_height').val(tycheesMath_round(imageHeight, 0));
		}
	}
	
	if (edge == 'height') {
		var placeObj = tycheesCommon_getCurrentPlaceObject();
		var companyLogoImageObj = placeUtil_getDefaultCompanyLogoImage(placeObj);

		if (companyLogoImageObj == null) {
			var imageHeight = $('#set001_document_mw_addPlaceField_height').val();
			var imageWidth = tycheesImage_getImageWidthByRatio(1000, 970, imageHeight);			
			$('#set001_document_mw_addPlaceField_width').val(tycheesMath_round(imageWidth, 0));
		} else {
			var imageHeight = $('#set001_document_mw_addPlaceField_height').val();
			var imageWidth = tycheesImage_getImageWidthByRatio(companyLogoImageObj.width, companyLogoImageObj.height, imageHeight);			
			$('#set001_document_mw_addPlaceField_width').val(tycheesMath_round(imageWidth, 0));
		}
	}
} // .end of set001_document_mw_addPlaceField_onDimensionChanged

function set001_document_mw_addPlaceField_save()
{
	// reset
    $('.help-block').hide();
    
    // Get user input
    var name = $.trim( $('#set001_document_mw_addPlaceField_name').val() );
    var fieldType = $.trim( $('#set001_document_mw_addPlaceField_fieldType').val() );
    var width = parseInt( $('#set001_document_mw_addPlaceField_width').val() );
    var height = parseInt( $('#set001_document_mw_addPlaceField_height').val() );

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (name == '')
    {
    	$('#set001_document_mw_addPlaceField_name_error').show();
    	$('#set001_document_mw_addPlaceField_name').focus();
    	return false;
    }
    
	if (fieldType == 'place.logo') {
	    // Validation #3: non-integer width
	    if (width == NaN || width <= 0)
	    {
	    	$('#set001_document_mw_addPlaceField_width_error').show();
	    	$('#set001_document_mw_addPlaceField_width').focus();
	    	return false;
	    }
	    
	    // Validation #4: non-integer height
	    if (height == NaN || height <= 0)
	    {
	    	$('#set001_document_mw_addPlaceField_height_error').show();
	    	$('#set001_document_mw_addPlaceField_height').focus();
	    	return false;
	    }
	}

	// https://konvajs.github.io/api/Konva.Text.html
	var attributesObj = new Object();
	attributesObj.fieldType = fieldType;
	
	if (fieldType == 'place.logo') {		
		attributesObj.x1 = 50;
		attributesObj.y1 = 50;
		attributesObj.imageWidth = width;	
		attributesObj.imageHeight = height;
	} else {
		attributesObj.x1 = 50;
		attributesObj.y1 = 50;
		attributesObj.fill = '#555';
		attributesObj.fontFamily = 'Arial';
		attributesObj.fontSize = 16;
		attributesObj.fontStyle = 'normal';		
		attributesObj.width = 100;
		attributesObj.padding = 0;
		attributesObj.align = 'left';	
	}
	
	var componentObj = createNew_PlaceDocumentTemplateComponent();
	componentObj.name = name;
	componentObj.objectType = DocumentConstants.COMPONENT_OBJECT_TYPE_PLACE_FIELD;
	componentObj.attributes = JSON.stringify(attributesObj);
    	
    // Close Modal Window
    $('#set001_document_mw_addPlaceField').modal('hide');
    
    if (set001_document_mw_addPlaceField_saveCallbackFn != null)
    	set001_document_mw_addPlaceField_saveCallbackFn(componentObj);
} // .end of set001_document_mw_addPlaceField_save

</script>