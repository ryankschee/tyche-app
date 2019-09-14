
<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
   	.grid-item { 
   		width: 200px; 
   	}
	.grid-item--width2 { 
		width: 400px; 
	}
</style>

<!-- SET001_20_04: Manage Images -->
<div id="set001_20_04" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
        IMAGE GALLERY
	</span>
    <div class="ibox-content">
        <div class="row">
            <div class="col-md-2">
                <button class="btn btn-primary" type="button" onclick="set001_20_04_selectFiles();">
            	    <i class="fa fa-upload" aria-hidden="true"></i> Upload
            	</button>
            	<input type="file" id="set001_20_04_fileUpload" multiple style="display:none;">
            </div>
            <div class="col-md-10">
                <div id="set001_20_04_fileUpload_spinner" class="spiner-example" style="padding-top:0px; height:100%; display:none;">
                    <div class="sk-spinner sk-spinner-wave">
                        <div class="sk-rect1"></div>
                        <div class="sk-rect2"></div>
                        <div class="sk-rect3"></div>
                        <div class="sk-rect4"></div>
                        <div class="sk-rect5"></div>
                    </div>
                </div>
            </div>
        </div>
        <div id="set001_20_04_gridTable" class="grid" style="padding-top:20px;">
        </div>
        <div id="set001_20_04_gridTable_spinner" class="spiner-example" style="display:none;">
			<div class="sk-spinner sk-spinner-wave">
			    <div class="sk-rect1"></div>
			    <div class="sk-rect2"></div>
			    <div class="sk-rect3"></div>
			    <div class="sk-rect4"></div>
			    <div class="sk-rect5"></div>
			</div>
		    <div id="set001_20_04_gridTable_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
		</div>            
           
    </div>     
</div>

<!-- MODAL WINDOW: Upload Image -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_04_mw001.jsp" %>
<!-- MODAL WINDOW: Image Editor -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_04_mw002.jsp" %>

<script>

var $masonry;
var set001_20_04_initialized = false;
var set001_20_04_selectedFiles;
var set001_20_04_fileProcessCount = 0;
var set001_20_04_imageFileList = [];

function set001_20_04_init()
{
    if (set001_20_04_initialized == true)
        return false;
    
    $('#set001_20_04_fileUpload').on('click', function () {
		this.value = null;
    });
    $('#set001_20_04_fileUpload').on('change', function () {
		set001_20_04_uploadImage();
    });            

    $masonry = $('.grid').masonry({
   	    // options
   	    itemSelector: '.grid-item',
   	    columnWidth: 200,
		isAnimated: true,
   	    gutter: 25
   	});
    
    $masonry.imagesLoaded()
	    .always(function(instance) {
			//console.log('all images loaded');		
			$masonry.masonry('reloadItems');
	    	$masonry.masonry('layout');		
		})
		.done(function(instance) {
			//console.log('all images successfully loaded');
			$masonry.masonry('reloadItems');
			$masonry.masonry('layout');
		})
		.fail(function() {
			//console.log('all images loaded, at least one is broken');
		})
		.progress(function(instance, image) {
			$masonry.masonry('reloadItems');
	    	$masonry.masonry('layout');
		});
      	
	set001_20_04_initialized = true;
} // .end of set001_20_04_init

function set001_20_04_updateUI()
{
    set001_20_04_init();

    // Show Panel    
    $('#set001_20_04').show();
    // Empty table
    $('#set001_20_04_gridTable').empty();
    // Show progress
    $('#set001_20_04_gridTable').hide();
    $('#set001_20_04_gridTable_spinner').show();
    
    // Prepare Ajax
    var requestBody = new Object();
    requestBody.onlyTypeLogo = false;
    
    var params = new Object();
    
    tycheesdb_api_getPlaceImagesByPlace(requestBody, set001_20_04_updateUI_postHandler, params);    
} // .end of set001_20_04_updateUI

function set001_20_04_updateUI_postHandler(success, responseObj, params) 
{    
	if (!success) {
		$('#set001_20_04_gridTable_spinner').hide();
		swal("Oops", "Something went wrong!", "error");
		return false;
	}

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	placeObj.imageList = responseObj.imageList;
    $.each(placeObj.imageList, function(i, imageObj){
    
    	if (Cached_isDeletedBean(imageObj))
    		return true;
    	
    	var imageExist = $.trim(imageObj.base64) == '' ? false : true;
    	
    	var htmlLines = '';
    	htmlLines += '<div class="grid-item">';
        htmlLines += '<div class="ibox">';
        htmlLines += '<div class="ibox-content product-box">';
        htmlLines += '<div class="product-imitation" style="padding: 0px 0px;" onclick="set001_20_04_editImage(\'' + imageObj.id + '\');">';
        if (imageExist)
            htmlLines += '<img src="' + $.trim(imageObj.base64) + '" style="width:100%; height:100%">';
        else
            htmlLines += '[ NO IMAGE ]';
        htmlLines += '</div>';
        htmlLines += '<div class="product-desc">';
        if (imageObj.typeLogo) {
            htmlLines += '<span class="product-price">LOGO</span>';
        }
        htmlLines += '<small class="text-muted">' + $.trim(imageObj.fileType).toUpperCase() + '</small>';
        htmlLines += '<a href="#" class="product-name" onclick="set001_20_04_editImage(\'' + imageObj.id + '\');"> ' + $.trim(imageObj.name).toUpperCase() + '</a>';
        htmlLines += '<div class="small m-t-xs">';
        htmlLines += $.trim(imageObj.longDesc).toUpperCase();
        htmlLines += '</div>';
        htmlLines += '<div class="m-t text-righ">';
        htmlLines += '<a href="#" class="btn btn-xs btn-outline btn-primary" onclick="set001_20_04_editImage(\'' + imageObj.id + '\');">';
        htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
        htmlLines += ' Edit';
        htmlLines += '</a>';
        htmlLines += '<span style="padding:2px;"></span>';
        htmlLines += '<a href="#" class="btn btn-xs btn-outline btn-danger" onclick="set001_20_04_deleteImage(\'' + imageObj.id + '\');">';
        htmlLines += '<i class="fa fa-times" aria-hidden="true"></i>';
        htmlLines += ' Delete';
        htmlLines += '</a>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        
        $masonry.append(htmlLines);
    });
    
    // Show progress
    $('#set001_20_04_gridTable').show();
    $('#set001_20_04_gridTable_spinner').hide();
    
    $masonry.masonry('reloadItems');
	$masonry.masonry('layout');
} // .end of set001_20_04_updateUI

/**
 * Hide Panel
 */
function set001_20_04_hide()
{
    $('#set001_20_04').hide();
} // .end of set001_20_04_hide

function set001_20_04_selectFiles()
{
	// Reset
	set001_20_04_selectedFiles = [];
	// Programmatically trigger file selector
	$('#set001_20_04_fileUpload').click();
} // ,end of set001_20_04_selectFiles

/**
 * Validate & Process image upload.
 */
function set001_20_04_uploadImage()
{
    set001_20_04_selectedFiles = $('#set001_20_04_fileUpload')[0].files;
    
    if (set001_20_04_selectedFiles != null) 
    {
        // Show Spinner
        $('#set001_20_04_fileUpload_spinner').show();
        // Reset
        set001_20_04_fileProcessCount = 0;
        set001_20_04_imageFileList = [];
        
        // iterate each file object to get base64 representation
	    $.each(set001_20_04_selectedFiles, function(i, fileObj) {
	        tycheesFile_getBase64(fileObj, set001_20_04_uploadImage_postHandler);
	    });
	}
} // .end of set001_20_04_uploadImage

function set001_20_04_uploadImage_postHandler(successFlag, base64, fileName, fileType, fileSize, width, height) 
{
    if (successFlag==false)
        return false;
    
    var imageObj = createNew_PlaceImage();    
    imageObj.placeId = tycheesCommon_getCurrentPlaceId();
    imageObj.name = fileName.substring(0, fileName.indexOf('.'));
    imageObj.url = '';
    imageObj.type = '';
    imageObj.altText = '';
    imageObj.longDesc = '';
    imageObj.width = width==null ? 0 : width;
    imageObj.height = height==null ? 0 : height;
    imageObj.base64 = base64;
    imageObj.fileName = fileName;
    imageObj.fileType = fileType;
    imageObj.fileExtension = fileName.substring(fileName.indexOf('.') + 1);
    imageObj.fileSize = fileSize;
    imageObj.typeLogo = false;
    
    set001_20_04_imageFileList.push(imageObj);
    
    // Increment process count
    set001_20_04_fileProcessCount++;
    
    // If all file image(s) have been converted to base64
    if (set001_20_04_fileProcessCount >= set001_20_04_selectedFiles.length)
    {
        // Hide spinner
        $('#set001_20_04_fileUpload_spinner').hide();
        
        // Show modal window
        set001_20_04_mw001_updateUI(set001_20_04_imageFileList);
    }
} // .end of set001_20_04_uploadImage_postHandler

/**
 * Edit given image.
 *
 * @param {String} imageId - Image ID
 */
function set001_20_04_editImage(imageId)
{
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
	var selectedImageObj; 
    $.each(placeObj.imageList, function(i, imageObj){    
    	if (Cached_isDeletedBean(imageObj))
    		return true;
    	
    	if (imageId == imageObj.id)
    		selectedImageObj = imageObj;
    });
    
    set001_20_04_mw002_open(selectedImageObj);
} // .end of set001_20_04_editImage

/**
 * Confirm & Delete given image.
 *
 * @param {String} imageId - Image ID
 */
function set001_20_04_deleteImage(imageId)
{
	if (imageId==null || imageId=='') {
		tycheesLogger_showToast('warning','No image selected','Please select a image.');
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this image record!",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  confirmButtonText: "Yes, delete it!",
		  cancelButtonText: "No, cancel plx!",
		  closeOnConfirm: true,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  	if (isConfirm) 
		  	{
		  		var placeObj = tycheesCommon_getCurrentPlaceObject();
		  		$.each(placeObj.imageList, function(i, imageObj){
		  			if (imageObj.id == imageId)
		  			{
		  				Cached_deleteBean(imageObj);
				  		// Save to IndexedDB
				    	tycheesIO_saveBean(placeObj);
				  		// Refresh UI
				    	set001_20_04_updateUI();
		  			}
		  		});
		  	}
		});
} // .end of set001_20_04_deleteImage

</script>