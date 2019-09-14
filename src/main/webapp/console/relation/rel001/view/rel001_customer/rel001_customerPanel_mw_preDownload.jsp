<!-- Modal Window: PRE Download Customer List -->
<div class="modal inmodal fade" id="rel001_02_preDownload" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">SELECT CUSTOMER TYPE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_02_preDownload_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Customer Type</label>
	                                    <div class="col-sm-8">
	                                    	<select id="rel001_02_preDownload_typeList" data-placeholder="Choose..." multiple class="chosen-select form-control">
	                                    	</select>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="rel001_02_preDownload_save();">Confirm Download</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_02_preDownload_initialized = false;
var rel001_02_preDownload_customerTypeList;
var rel001_02_preDownload_postHandlerFn;

/**
 * Init Panel
 */
function rel001_02_preDownload_init()
{
    if (rel001_02_preDownload_initialized == true)
        return false;
    
    $('#rel001_02_preDownload').on('shown.bs.modal', function () {
	    
	})
    
	rel001_02_preDownload_initialized = true;
} // .end of rel001_02_preDownload_init

function rel001_02_preDownload_show(customerTypeList, postHandlerFn)
{
	rel001_02_preDownload_customerTypeList = customerTypeList;
	rel001_02_preDownload_postHandlerFn = postHandlerFn;
	
	rel001_02_preDownload_updateUI();
} // .end of rel001_02_preDownload_show

/**
 * Show Panel
 */
function rel001_02_preDownload_updateUI()
{
    rel001_02_preDownload_init();
        
    // Clear
    $('#rel001_02_preDownload_typeList').val('');
    $('#rel001_02_preDownload_typeList').trigger('chosen:updated');
    
    // Re-Insert Customer Types
    $('#rel001_02_preDownload_typeList').empty();
    $('#rel001_02_preDownload_typeList').append( '<option value="ANY">ANY</option>' );
    $.each(rel001_02_preDownload_customerTypeList, function(i, customerType){
    	var htmlLines = '';
    	htmlLines += '<option value="' + customerType + '">' + customerType + '</option>';
    	$('#rel001_02_preDownload_typeList').append( htmlLines );
    });
    
    $("#rel001_02_preDownload_typeList").chosen({no_results_text: "Oops, nothing found!"}); 
    $('#rel001_02_preDownload_typeList_chosen').css('width', '100%');
    
    module_showModalWindow('rel001_02_preDownload', true);
} // .end of rel001_02_preDownload_updateUI

/**
 * Save changes and hide panel.
 */
function rel001_02_preDownload_save()
{
    var selectedTypeList = $('#rel001_02_preDownload_typeList').val();
    if (selectedTypeList == null) 
    	selectedTypeList = [];
    
    if (selectedTypeList.length == 0) {
    	swal(
   			"Opppss!", 
   			"Please select at least one type for download.", 
   			"warning");
    	return false;
    }
    
    // Close Modal Window
    $('#rel001_02_preDownload').modal('hide');
    // Pass to callback
    rel001_02_preDownload_postHandlerFn(true, selectedTypeList);
} // .end of rel001_02_preDownload_save

</script>