<!-- MODAL WINDOW: Upload Image -->
<div class="modal inmodal" id="set001_20_04_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
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
              					<div id="set001_20_04_mw001_gridTable" class="ibox-content">
				                    
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
                <button type="button" class="btn btn-primary" onclick="set001_02_04_mw001_upload();">
                	<i class="fa fa-upload" aria-hidden="true"></i> Upload Now
                </button>
            </div>
        </div>
    </div>
</div>		

<script>

// Local variable declaration
var set001_20_04_mw001_initialized = false;
var set001_20_04_mw001_imageList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function set001_20_04_mw001_isOpen()
{
	return ($("#set001_20_04_mw001").data('bs.modal') || {}).isShown;	
} // .end of set001_20_04_mw001_isOpen

/**
 * Init state.
 */
function set001_20_04_mw001_init()
{
	if (set001_20_04_mw001_initialized)
		return false;

    set001_20_04_mw001_initialized = true;
} // .end of set001_20_04_mw001_init

function set001_20_04_mw001_updateUI(imageList)
{
	// Init, if haven't
	set001_20_04_mw001_init();
	// Init list
	set001_20_04_mw001_imageList = imageList;
	// Update UI
	set001_20_04_mw001_reloadUI();

    // Show Window
    module_showModalWindow('set001_20_04_mw001', true);
} // .end of set001_20_04_mw001_open

function set001_20_04_mw001_reloadUI()
{
	// Reset
	$('#set001_20_04_mw001_gridTable').empty();

	$.each(set001_20_04_mw001_imageList, function(i, imageObj) {
	
    	if (Cached_isDeletedBean(imageObj))
    		return true;
    		
    	var rowNo = Math.ceil((i+1)/4);
    	var rowSelectorId = 'set001_20_04_mw001_gridTable_' + rowNo;
    	
    	if (i % 6 == 0) {
    	    var row_htmlLines = '';
    	    row_htmlLines += '<div id="' + rowSelectorId + '" class="row">';
    	    row_htmlLines += '</div>';
    	    
    	    $('#set001_20_04_mw001_gridTable').append( row_htmlLines );
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
        htmlLines += '<a href="#" class="btn btn-xs btn-outline btn-danger" onclick="set001_20_04_mw001_deleteImage(\'' + imageObj.id + '\');">';
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
} // .end of set001_20_04_mw001_reloadUI

function set001_20_04_mw001_deleteImage(imageId)
{
	if ($.trim(imageId)=='')
		return false;

	$.each(set001_20_04_mw001_imageList, function(i, imageObj) {
		if (imageObj.id == imageId) {
			set001_20_04_mw001_imageList.splice(i, 1);
			return false;
		}
	});
	
	// Reload UI
	set001_20_04_mw001_reloadUI();
} // .end of set001_20_04_mw001_deleteImage

function set001_02_04_mw001_upload()
{
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	$.each(set001_20_04_mw001_imageList, function(i, imageObj) {
		imageObj.hasChanged = true;
		placeObj.imageList.push(imageObj);
	});
	
	tycheesOverlay_startShortProgress('Uploading images...');
	
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
	// Close modal window
    $("#set001_20_04_mw001").modal("hide");
    // Update UI
    set001_20_04_updateUI();
    
    tycheesOverlay_stopShortProgress();
} // .end of set001_02_04_mw001_upload

</script>