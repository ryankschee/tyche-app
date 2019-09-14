<!-- Modal Window: Download File -->
<div class="modal inmodal fade" id="header_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">DOWNLOADING FILE...</span>
		    	
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw001_modalBody" class="modal-body">
			    <div class="spiner-example">
                    <div class="sk-spinner sk-spinner-chasing-dots">
                        <div class="sk-dot1"></div>
                        <div class="sk-dot2"></div>
                    </div>
                </div>
		    </div>
		    <div id="mw001_downloadElement" style="display:none;"></div>
		    <!-- 
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="mw001_save();">Save changes</button>
		    </div>
		     -->
	    </div>
    </div>
</div>

<script>

var header_mw001_initialized = false;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function header_mw001_isOpen()
{
	return ($("#mw001").data('bs.modal') || {}).isShown;	
} // .end of mw001_isOpen

/**
 * Init Panel
 */
function header_mw001_init()
{
    if (header_mw001_initialized == true)
        return false;
    
    $('#mw001').on('shown.bs.modal', function () {
	    
	});
    
    header_mw001_initialized = true;
} // .end of mw001_init

/**
 * Show Panel
 */
function header_mw001_updateUI(requestObj)
{
	header_mw001_init();
    
    var fileBase64 = 'data:application/octet-stream;base64,' + requestObj.base64;
    
    var htmlLines = '';
    htmlLines += '<a id="downloadLink" href="' + fileBase64 + '" download="' + requestObj.fileName + '"/>';    
    $('#mw001_downloadElement').html(htmlLines);
    
    // Programmatically CLICK to download
    document.getElementById('downloadLink').click();
    // Hide Modal Window
	$('#header_mw001').modal('hide');
} // .end of mw001_updateUI

/**
 * Show Panel
 */
function header_mw001_show()
{
    // Show Modal Window on Top
    module_showModalWindow('header_mw001', true);    
} // .end of header_mw001_show


</script>