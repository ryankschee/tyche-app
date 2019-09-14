
<!-- 
    Title:			PRINT PREVIEW
    Desc:			- Show printout preview in PDF.
    Author:			Ryan Chee
    Last Modified:	20170810
-->

<div class="modal inmodal fade" id="mw_pdfPreview" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
		    <div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
		    	<span class="modal-title">PRINT PREVIEW</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" onclick="mw_pdfPreview_close();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="mw015_modalBody" class="modal-body">
			    <iframe id="mw_pdfPreview_previewArea" frameborder="0" style="border:0" allowfullscreen>
				</iframe>
		    </div>
	    </div>
    </div>
</div>

<script>

var mw_pdfPreview_initialized = false;
var mw_pdfPreview_base64_data;
var mw_pdfPreview_modalWindowSelectorId;

function mw_pdfPreview_isOpen()
{
	return ($("#mw_pdfPreview").data('bs.modal') || {}).isShown;	
} // .end of mw015_isOpen

function mw_pdfPreview_init()
{
    if (mw_pdfPreview_initialized == true)
        return false;
    
    $('#mw_pdfPreview').on('shown.bs.modal', function () {
	    //$("#mw015_newBillingNo").focus();
	});
    
    mw_pdfPreview_initialized = true;
} // .end of mw_pdfPreview_init

function mw_pdfPreview_show(base64, selectorId)
{
	mw_pdfPreview_base64_data = base64;
	mw_pdfPreview_modalWindowSelectorId = selectorId;
	
	mw_pdfPreview_updateUI();
} // .end of mw_pdfPreview_show

function mw_pdfPreview_updateUI()
{
	mw_pdfPreview_init();

	// Hide caller modal window
	if (mw_pdfPreview_modalWindowSelectorId != '')
		$('#'+mw_pdfPreview_modalWindowSelectorId).modal('hide');
	
	$("#mw_pdfPreview_previewArea").attr("height", "480px");
    $("#mw_pdfPreview_previewArea").attr("width", "100%");
    $("#mw_pdfPreview_previewArea").attr("src", mw_pdfPreview_base64_data);
    
    // Show Modal Window on Top
    module_showModalWindow('mw_pdfPreview', true);
} // .end of mw_pdfPreview_updateUI

function mw_pdfPreview_close() 
{
	$("#mw_pdfPreview_previewArea").attr("height", "");
    $("#mw_pdfPreview_previewArea").attr("width", "");
    $("#mw_pdfPreview_previewArea").attr("src", "");
    
    $('#mw_pdfPreview').modal('hide');
} // .end of mw_pdfPreview_close

</script>