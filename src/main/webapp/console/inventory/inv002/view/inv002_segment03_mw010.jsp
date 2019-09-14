<!-- MODAL WINDOW: Image Editor -->
<div class="modal inmodal" id="inv002_segment03_mw010" tabindex="-1" role="dialog"  aria-hidden="true">
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
                         <img id="inv002_segment03_mw010_imageUrl" alt="image" class="img-responsive" src="">
 	                </div>
 	                <div class="col-lg-7">
 	                    <fieldset class="form-horizontal">
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Name:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_imageName" name="Image Name" placeholder="Image Name" value="">
 	                            </div>					
 	                        </div>
	
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Alt Text:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_imageAltText" name="Alternate Text" placeholder="Alt Text" value="">
 	                            </div>					
 	                        </div>
	
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Caption Text:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_imageCaptionText" name="Caption Text" placeholder="Caption Text" value="">
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Sequence No:</label>
 	                            <div class="col-sm-9">
 	                                <input type="number" class="form-control" id="inv002_segment03_mw010_imageSeqno" name="Sequence No" placeholder="Sequence No" value="">
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Is PWS Visible:</label>
 	                            <div class="col-sm-9">
 	                                <div class="onoffswitch">
 	                                	<input id="inv002_segment03_mw010_pwsVisible" type="checkbox" checked class="onoffswitch-checkbox">
 	                                	<label class="onoffswitch-label" for="inv002_segment03_mw010_pwsVisible">
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
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_fileType" name="File Type" placeholder="File Type" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Width:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_imageWidth" name="Image Width" placeholder="Image Width" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Height:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_imageHeight" name="Image Height" placeholder="Image Height" value="" disabled>
 	                            </div>						
 	                        </div>
 	                        
 	                        <div class="form-group">
 	                            <label class="col-sm-3 control-label">Image Size:</label>
 	                            <div class="col-sm-9">
 	                                <input type="text" class="form-control" id="inv002_segment03_mw010_imageSize" name="Image Size" placeholder="Image Size" value="" disabled>
 	                            </div>						
 	                        </div>
 	                    </fieldset>
 	                </div>
 	            </div>
 	        </div>
 	        <div class="modal-footer">
 	            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
 	            <button type="button" class="btn btn-primary" onclick="inv002_segment03_mw010_save()"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button> 
 	        </div>
 	    </div>
    </div>
</div>


<script>

var inv002_segment03_mw010_imageObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function inv002_segment03_mw010_isOpen()
{
	return ($("#inv002_segment03_mw010").data('bs.modal') || {}).isShown;	
} // .end of inv002_segment03_mw010_isOpen

function inv002_segment03_mw010_init()
{
	$('#inv002_segment03_mw010').on('shown.bs.modal', function () {
	    $("#inv002_segment03_mw010_imageName").focus();
	})
} // .end of inv002_segment03_mw010_init

function inv002_segment03_mw010_open(imageObj)
{
    inv002_segment03_mw010_imageObj = imageObj;

    inv002_segment03_mw010_init();
    inv002_segment03_mw010_updateUI();

    module_showModalWindow('inv002_segment03_mw010', true);
} // .end of inv002_segment03_mw010_open

function inv002_segment03_mw010_updateUI()
{
	$('#inv002_segment03_mw010_imageUrl').attr('src', inv002_segment03_mw010_imageObj.base64);
	$('#inv002_segment03_mw010_imageName').val(inv002_segment03_mw010_imageObj.name);
	$('#inv002_segment03_mw010_imageAltText').val(inv002_segment03_mw010_imageObj.altText);
	$('#inv002_segment03_mw010_imageCaptionText').val(inv002_segment03_mw010_imageObj.captionText);
	$('#inv002_segment03_mw010_imageSeqno').val(inv002_segment03_mw010_imageObj.seqno);
	$('#inv002_segment03_mw010_pwsVisible').prop('checked', inv002_segment03_mw010_imageObj.pwsVisible);
	
	$('#inv002_segment03_mw010_fileType').val(inv002_segment03_mw010_imageObj.fileType);
	$('#inv002_segment03_mw010_imageWidth').val(inv002_segment03_mw010_imageObj.width + 'px');
	$('#inv002_segment03_mw010_imageHeight').val(inv002_segment03_mw010_imageObj.height + 'px');
	$('#inv002_segment03_mw010_imageSize').val((Number(inv002_segment03_mw010_imageObj.fileSize)/1000) + 'KB');
} // .end of inv002_segment03_mw010_updateUI

function inv002_segment03_mw010_save()
{
    inv002_segment03_mw010_imageObj.name = $.trim( $('#inv002_segment03_mw010_imageName').val() );
    inv002_segment03_mw010_imageObj.altText = $.trim( $('#inv002_segment03_mw010_imageAltText').val() );
    inv002_segment03_mw010_imageObj.longDesc = $.trim( $('#inv002_segment03_mw010_imageCaptionText').val() );
    inv002_segment03_mw010_imageObj.fileName = inv002_segment03_mw010_imageObj.name + '.' + inv002_segment03_mw010_imageObj.fileExtension;
    inv002_segment03_mw010_imageObj.seqno = $('#inv002_segment03_mw010_imageSeqno').val();
    inv002_segment03_mw010_imageObj.pwsVisible = $('#inv002_segment03_mw010_pwsVisible').prop('checked');
    inv002_segment03_mw010_imageObj.hasChanged = true;
    
	// If current image is logo type, then reset other image object to false.
	if (inv002_segment03_mw010_imageObj.typeLogo) {
		$.each(placeObj.imageList, function(i, imageObj) {
			if (Cached_isDeletedBean(imageObj))
	    		return true;
			if (imageObj.id != inv002_segment03_mw010_imageObj.id)
			{
				imageObj.typeLogo = false;
			}
		});
	}
	
    // Save to localDB
    tycheesIO_saveBean(segment03_itemObj);
    // Update UI
    segment03_updateUI_tab5();
    // hide
    $('#inv002_segment03_mw010').modal('hide');
} // .end of inv002_segment03_mw010_save

</script>