<!-- MODAL WINDOW: Upload Image -->
<div class="modal inmodal" id="inv002_segment03_mw009" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xl">
    	<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">UPLOAD IMAGES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
               	<div class="wrapper wrapper-content">
     				<div class="row">
         				<div class="col-lg-12">
             				<div class="ibox float-e-margins" style="height:100%;">
              					<div class="ibox-title">
                  					<h5>
                  						Please confirm following image upload.
                  					</h5>												                        
              					</div>
              					<div id="inv002_segment03_mw009_gridTable" class="ibox-content">
				                    
              					</div>
          					</div>
         				</div>											                
     				</div>
			     </div>	
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                	<i class="fa fa-times" aria-hidden="true"></i> Cancel
                </button>
                <button type="button" class="btn btn-primary" onclick="inv002_segment03_mw009_upload();">
                	<i class="fa fa-upload" aria-hidden="true"></i> Upload Now
                </button>
            </div>
        </div>
    </div>
</div>		

<script>

// Local variable declaration
var inv002_segment03_mw009_initialized = false;
var inv002_segment03_mw009_imageList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function inv002_segment03_mw009_isOpen()
{
	return ($("#inv002_segment03_mw009").data('bs.modal') || {}).isShown;	
} // .end of inv002_segment03_mw009_isOpen

/**
 * Init state.
 */
function inv002_segment03_mw009_init()
{
	if (inv002_segment03_mw009_initialized)
		return false;

    inv002_segment03_mw009_initialized = true;
} // .end of inv002_segment03_mw009_init

function inv002_segment03_mw009_updateUI(imageList)
{
	// Init, if haven't
	inv002_segment03_mw009_init();
	// Init list
	inv002_segment03_mw009_imageList = imageList;
	// Update UI
	inv002_segment03_mw009_reloadUI();

	// Show Modal Window
    module_showModalWindow('inv002_segment03_mw009', true);
} // .end of inv002_segment03_mw009_open

function inv002_segment03_mw009_reloadUI()
{
	// Reset
	$('#inv002_segment03_mw009_gridTable').empty();

	$.each(inv002_segment03_mw009_imageList, function(i, imageObj) {
	
    	if (Cached_isDeletedBean(imageObj))
    		return true;
    		
    	var rowNo = Math.ceil((i+1)/4);
    	var rowSelectorId = 'inv002_segment03_mw009_gridTable_' + rowNo;
    	
    	if (i % 6 == 0) {
    	    var row_htmlLines = '';
    	    row_htmlLines += '<div id="' + rowSelectorId + '" class="row">';
    	    row_htmlLines += '</div>';
    	    
    	    $('#inv002_segment03_mw009_gridTable').append( row_htmlLines );
    	}
    	
		var htmlLines = '';
    	htmlLines += '<div class="col-md-2">';
        htmlLines += '<div class="ibox">';
        htmlLines += '<div class="ibox-content product-box">';
        htmlLines += '<div class="product-imitation" style="padding: 0px 0px;">';
        htmlLines += '<img src="' + $.trim(imageObj.base64) + '" style="width:100%; height:100%">';
        htmlLines += '</div>';
        htmlLines += '<div class="product-desc">';
        htmlLines += '<small class="text-muted">' + $.trim(imageObj.fileType).toUpperCase() + '</small>';
        htmlLines += '<div class="m-t text-right">';
        htmlLines += '<a href="#" class="btn btn-xs btn-outline btn-danger" onclick="inv002_segment03_mw009_deleteImage(\'' + imageObj.id + '\');">';
        htmlLines += '<i class="fa fa-times" aria-hidden="true"></i> ';
        htmlLines += 'Delete';
        htmlLines += '</a>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        
        $('#'+rowSelectorId).append( htmlLines );
	});
} // .end of inv002_segment03_mw009_reloadUI

function inv002_segment03_mw009_deleteImage(imageId)
{
	if ($.trim(imageId)=='')
		return false;

	$.each(inv002_segment03_mw009_imageList, function(i, imageObj) {
		if (imageObj.id == imageId) {
			inv002_segment03_mw009_imageList.splice(i, 1);
			return false;
		}
	});
	
	// Reload UI
	inv002_segment03_mw009_reloadUI();
} // .end of inv002_segment03_mw009_deleteImage

function inv002_segment03_mw009_upload()
{
	$.each(inv002_segment03_mw009_imageList, function(i, imageObj) {
		imageObj.hasChanged = true;
		segment03_itemObj.imageList.push(imageObj);
	});
	
	tycheesOverlay_startShortProgress('Uploading images...');
	
    // Save to IndexedDB
    tycheesIO_saveBean(segment03_itemObj);
	// Close modal window
    $("#inv002_segment03_mw009").modal("hide");
    // Update UI
    segment03_updateUI_tab5();
    
    tycheesOverlay_stopShortProgress();
} // .end of inv002_segment03_mw009_upload

</script>