<!-- MODAL WINDOW: Image Editor -->
<div class="modal inmodal" id="segment03_mw004" tabindex="-1" role="dialog"  aria-hidden="true">
 	<div class="modal-dialog modal-xl">
 	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">IMAGE PROPERTIES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
 	        <div class="modal-body">
 	            <div class="row">
 	                <div class="col-lg-6">
                         <img id="segment03_mw004_imageUrl" alt="image" class="img-responsive" src="">
 	                </div>
 	                <div class="col-lg-6">
 	                    <input type="hidden" id="segment03_mw004_itemId" value="" />
 	                    <input type="hidden" id="segment03_mw004_imageId" value="" />
 	                
 	                    <fieldset class="form-horizontal">
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Name:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="segment03_mw004_imageName" name="Image Name" placeholder="Image Name" value="">
 	                            </div>					
 	                        </div>
	
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Alt Text:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="segment03_mw004_imageAltText" name="Alternate Text" placeholder="Alt Text" value="">
 	                            </div>					
 	                        </div>
	
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Caption Text:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="segment03_mw004_imageCaptionText" name="Caption Text" placeholder="Caption Text" value="">
 	                            </div>						
 	                        </div>
 	                        
 	                        <hr>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Type:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="segment03_mw004_imageType" name="Caption Text" placeholder="Caption Text" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Width:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="segment03_mw004_imageWidth" name="Caption Text" placeholder="Caption Text" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Height:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="segment03_mw004_imageHeight" name="Caption Text" placeholder="Caption Text" value="" disabled>
 	                            </div>						
 	                        </div>
 	                    </fieldset>
 	                </div>
 	            </div>
 	        </div>
 	        <div class="modal-footer">
 	            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
 	            <button type="button" class="btn btn-primary" onclick="segment03_mw004_onclick_saveImage()"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button> 
 	        </div>
 	    </div>
    </div>
</div>


<script>

var segment03_mw004_imageObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw004_isOpen()
{
	return ($("#segment03_mw004").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw004_isOpen

function segment03_mw004_init()
{
	$('#segment03_mw004').on('shown.bs.modal', function () {
	    $("#segment03_mw004_imageName").focus();
	})
} // .end of segment03_mw004_init

function segment03_mw004_open(imageObj)
{
    segment03_mw004_imageObj = imageObj;

    segment03_mw004_init();
    segment03_mw004_updateUI();

    module_showModalWindow('segment03_mw004', true);
}

function segment03_mw004_updateUI()
{
    $('#segment03_mw004_itemId').val(segment03_mw004_imageObj.itemId);
    $('#segment03_mw004_imageId').val(segment03_mw004_imageObj.id);
	$('#segment03_mw004_imageUrl').attr('src', segment03_mw004_imageObj.url);
	$('#segment03_mw004_imageName').val(segment03_mw004_imageObj.name);
	$('#segment03_mw004_imageAltText').val(segment03_mw004_imageObj.altText);
	$('#segment03_mw004_imageCaptionText').val(segment03_mw004_imageObj.captionText);
	
	$('#segment03_mw004_imageType').val(segment03_mw004_imageObj.type);
	$('#segment03_mw004_imageWidth').val(segment03_mw004_imageObj.width + 'px');
	$('#segment03_mw004_imageHeight').val(segment03_mw004_imageObj.height + 'px');
} // .end of segment03_mw004_updateUI

function segment03_mw004_onclick_saveImage()
{
    var itemId = $('#segment03_mw004_itemId').val();
    var imageId = $('#segment03_mw004_imageId').val();
    
    var itemObj = Cached_getItemById(itemId);
    $.each(itemObj.imageList, function(i, imageObj){
        if (imageObj.id == imageId)
        {
            imageObj.name = $('#segment03_mw004_imageName').val();
            imageObj.altText = $('#segment03_mw004_imageAltText').val();
            imageObj.captionText = $('#segment03_mw004_imageCaptionText').val();
            imageObj.hasChanged = true;
        }
    });
    
    // Save to localDB
    tycheesIO_saveBean(itemObj);
    
    // Update UI
    segment03_updateUI_images(itemId);
    
    $('#segment03_mw004').modal('hide');
} // .end of segment03_mw004_onclick_saveImage

</script>