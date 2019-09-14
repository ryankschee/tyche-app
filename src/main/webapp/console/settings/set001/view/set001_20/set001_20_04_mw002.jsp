<!-- MODAL WINDOW: Image Editor -->
<div class="modal inmodal" id="set001_02_04_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
 	<div class="modal-dialog modal-lg4">
 	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">IMAGE EDITOR</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
 	        <div class="modal-body">
 	            <div class="row">
 	                <div class="col-lg-5">
                         <img id="set001_20_04_mw002_imageUrl" alt="image" class="img-responsive" src="">
 	                </div>
 	                <div class="col-lg-7">
 	                    <fieldset class="form-horizontal">
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Name:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_imageName" name="Image Name" placeholder="Image Name" value="">
 	                            </div>					
 	                        </div>
	
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Alt Text:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_imageAltText" name="Alternate Text" placeholder="Alt Text" value="">
 	                            </div>					
 	                        </div>
	
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Caption Text:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_imageCaptionText" name="Caption Text" placeholder="Caption Text" value="">
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Sequence No:</label>
 	                            <div class="col-sm-9">
 	                                <input type="number" class="form-control" id="set001_20_04_mw002_imageSeqno" name="Sequence No" placeholder="Sequence No" value="">
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Is Company Logo:</label>
 	                            <div class="col-sm-9">
 	                                <div class="onoffswitch">
 	                                	<input id="set001_20_04_mw002_typeLogo" type="checkbox" checked class="onoffswitch-checkbox">
 	                                	<label class="onoffswitch-label" for="set001_20_04_mw002_typeLogo">
 	                                		<span class="onoffswitch-inner"></span>
 	                                		<span class="onoffswitch-switch"></span>
 	                                	</label>
 	                                </div>
 	                            </div>						
 	                        </div>
 	                        
 	                        <hr>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">File Type:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_fileType" name="File Type" placeholder="File Type" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Width:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_imageWidth" name="Image Width" placeholder="Image Width" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Height:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_imageHeight" name="Image Height" placeholder="Image Height" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Size:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="set001_20_04_mw002_imageSize" name="Image Size" placeholder="Image Size" value="" disabled>
 	                            </div>						
 	                        </div>
 	                    </fieldset>
 	                </div>
 	            </div>
 	        </div>
 	        <div class="modal-footer">
 	            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
 	            <button type="button" class="btn btn-primary" onclick="set001_20_04_mw002_save()"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button> 
 	        </div>
 	    </div>
    </div>
</div>


<script>

var set001_20_04_mw002_imageObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function set001_20_04_mw002_isOpen()
{
	return ($("#set001_02_04_mw002").data('bs.modal') || {}).isShown;	
} // .end of set001_20_04_mw002_isOpen

function set001_20_04_mw002_init()
{
	$('#set001_02_04_mw002').on('shown.bs.modal', function () {
	    $("#set001_20_04_mw002_imageName").focus();
	})
} // .end of set001_20_04_mw002_init

function set001_20_04_mw002_open(imageObj)
{
    set001_20_04_mw002_imageObj = imageObj;

    set001_20_04_mw002_init();
    set001_20_04_mw002_updateUI();

    module_showModalWindow('set001_02_04_mw002', true);
} // .end of set001_20_04_mw002_open

function set001_20_04_mw002_updateUI()
{
	$('#set001_20_04_mw002_imageUrl').attr('src', set001_20_04_mw002_imageObj.base64);
	$('#set001_20_04_mw002_imageName').val(set001_20_04_mw002_imageObj.name);
	$('#set001_20_04_mw002_imageAltText').val(set001_20_04_mw002_imageObj.altText);
	$('#set001_20_04_mw002_imageCaptionText').val(set001_20_04_mw002_imageObj.captionText);
	$('#set001_20_04_mw002_imageSeqno').val(set001_20_04_mw002_imageObj.seqno);
	$('#set001_20_04_mw002_typeLogo').prop('checked', set001_20_04_mw002_imageObj.typeLogo);
	
	$('#set001_20_04_mw002_fileType').val(set001_20_04_mw002_imageObj.fileType);
	$('#set001_20_04_mw002_imageWidth').val(set001_20_04_mw002_imageObj.width + 'px');
	$('#set001_20_04_mw002_imageHeight').val(set001_20_04_mw002_imageObj.height + 'px');
	$('#set001_20_04_mw002_imageSize').val((Number(set001_20_04_mw002_imageObj.fileSize)/1000) + 'KB');
} // .end of set001_20_04_mw002_updateUI

function set001_20_04_mw002_save()
{
    set001_20_04_mw002_imageObj.name = $.trim( $('#set001_20_04_mw002_imageName').val() );
    set001_20_04_mw002_imageObj.altText = $.trim( $('#set001_20_04_mw002_imageAltText').val() );
    set001_20_04_mw002_imageObj.longDesc = $.trim( $('#set001_20_04_mw002_imageCaptionText').val() );
    set001_20_04_mw002_imageObj.seqno = $('#set001_20_04_mw002_imageSeqno').val();
    set001_20_04_mw002_imageObj.typeLogo = $('#set001_20_04_mw002_typeLogo').prop('checked');
    set001_20_04_mw002_imageObj.fileName = set001_20_04_mw002_imageObj.name + '.' + set001_20_04_mw002_imageObj.fileExtension;
    set001_20_04_mw002_imageObj.hasChanged = true;        
   
	// Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
	// If current image is logo type, then reset other image object to false.
	if (set001_20_04_mw002_imageObj.typeLogo) {
		$.each(placeObj.imageList, function(i, imageObj) {
			if (Cached_isDeletedBean(imageObj))
	    		return true;
			if (imageObj.id != set001_20_04_mw002_imageObj.id)
			{
				imageObj.typeLogo = false;
				imageObj.hasChanged = true;
			}
		});
	}
	
    // Save to localDB
    tycheesIO_saveBean(placeObj);
    
    // Update UI
    set001_20_04_updateUI();
    
    $('#set001_02_04_mw002').modal('hide');
} // .end of set001_20_04_mw002_save

</script>