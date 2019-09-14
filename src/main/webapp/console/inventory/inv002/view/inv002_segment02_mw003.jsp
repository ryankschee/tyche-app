<!-- Modal Window: Show Dependent Item in tabular form -->
<div class="modal inmodal fade" id="segment02_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content animated fadeIn">
		<div class="modal-header">
			<span class="modal-title">ITEM DEPENDENCY</span>
			<span class="pull-right">
				<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
					<i class="fa fa-times" aria-hidden="true"></i>
				</button>
			</span>
		</div>
			<div class="modal-body">
				<div class="ibox-title" style="color:#ff0000;height:80px;">
					<h5>
						<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
						Unable to delete item [<span id="segment02_mw003_itemName"></span>]. 
						<br><br>
						<span style="padding-left:16px;">Please remove dependency from following items before proceed.</span>
					</h5>
				</div>
				<div class="ibox-content">
					<table class="table table-striped table-bordered table-hover " id="segment02_mw003_dataTable" >
      	                    <thead>
      	                        <tr>
      	                            <th>No</th>
      	                            <th>Category</th>
      	                            <th>Item Name</th>
      	                        </tr>
      	                    </thead>
      	                    <tbody>
      	                    </tbody>
      	                </table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>					
			</div>
		</div>
	</div>
</div>

<script>

var segment02_mw003_initialized = false;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment02_mw003_isOpen()
{
	return ($("#segment02_mw003").data('bs.modal') || {}).isShown;	
} // .end of segment02_mw003_isOpen

/**
 * Modal Window Init.
 */
function segment02_mw003_init()
{
	if (segment02_mw003_initialized==true)
		return false;
	
	$('#segment02_mw003_dataTable').dataTable();
	segment02_mw003_initialized = true;
} // .end of segment02_mw003_init

/**
 * Open Modal Window
 */
function segment02_mw003_open(itemObj, itemList)
{
	segment02_mw003_init();
	
	$('#segment02_mw003_itemName').html(itemObj.name);
	
	$('#segment02_mw003_dataTable').DataTable().clear().draw();
	
	$.each(itemList, function(i, itemObj){
		
		var categoryObj = Cached_getCategoryById(itemObj.categoryId);
		
		$('#segment02_mw003_dataTable').dataTable().fnAddData( 
			[
			 String(i+1),
			 categoryObj.name,
			 itemObj.name
	        ], false);
	});
	
	$('#segment02_mw003_dataTable').DataTable().draw();
	
	// Show Modal Window
	module_showModalWindow('segment02_mw003', true);
} // .end of segment02_mw003_open

</script>