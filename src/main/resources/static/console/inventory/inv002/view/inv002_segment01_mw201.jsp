<!-- SEARCH BILLING DIALOG -->
<div class="modal inmodal fade" id="segment01_mw201" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">BATCH FILE VALIDATION</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" onclick="segment01_mw201_close();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div id="segment01_mw201_error" style="padding: 5px 0px; color:#FF0000;">
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> 
					Usage limit exceeded. Please increase limit at Settings &gt; My Place &gt; Account Membership
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="ibox" style="margin-bottom:0px;">
							<div class="ibox-content">
								<table id="segment01_mw201_dataTable" class="table table-striped table-bordered table-hover">
									<thead>
										<tr id="segment01_mw201_dataTable_header">
											<th>ACTION</th>
											<th>ID</th>
											<th>Group Name</th>
											<th>Item Name</th>
										</tr>
									</thead>
									<tbody id="tbody-list">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="segment01_mw201_uploadButton" type="button" class="btn btn-primary ladda-button" data-style="expand-right" onclick="segment01_mw201_confirm();">Confirm Upload</button>
				<button id="segment01_mw201_closeButton" type="button" class="btn btn-danger" onclick="segment01_mw201_close();">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var segment01_mw201_initialized = false;
var segment01_mw201_itemListForInsert = [];
var segment01_mw201_itemListForUpdate = [];
var segment01_mw201_itemListForDelete = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment01_mw201_isOpen()
{
	return ($("#segment01_mw201").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw201_isOpen

/**
 * Initiate components/variables
 */
function segment01_mw201_init()
{
	if (segment01_mw201_initialized)
		return false;

	// Init dataTable (customer Modal Dialog)
	$("#segment01_mw201_dataTable").DataTable();
	
	segment01_mw201_initialized = true;
} // .end of segment01_mw201_init

function segment01_mw201_updateUI(params)
{
	// Init
	segment01_mw201_init();

	segment01_mw201_itemListForInsert = params.itemListForInsert;
	segment01_mw201_itemListForUpdate = params.itemListForUpdate;
	segment01_mw201_itemListForDelete = params.itemListForDelete;
	
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var itemMaxCount = 0;
	var itemUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT) {
			itemMaxCount = Number(propObj.propValue);
			itemUsageCount = Number(propObj.propContent);
		}
	});
	
	var futureItemUsageCount = itemUsageCount + segment01_mw201_itemListForInsert.length - segment01_mw201_itemListForDelete.length;
	if (segment01_mw201_itemListForInsert.length > 0 && futureItemUsageCount >= itemMaxCount)	{
		$('#segment01_mw201_error').show();
		$('#segment01_mw201_uploadButton').hide();
	} else {
		$('#segment01_mw201_error').hide();
		$('#segment01_mw201_uploadButton').show();
	}
	
	// Clear list
	$('#segment01_mw201_dataTable').DataTable().clear().draw();
	// Update DataTable
	$.each(segment01_mw201_itemListForInsert, function(index, itemObj) {			
		var rowSet = [];
		rowSet.push( 'INSERT' );
		rowSet.push( itemObj.id );
		rowSet.push( itemObj.groupName );
		rowSet.push( '<i class="fa fa-plus" aria-hidden="true"></i> ' + itemObj.name );
		$("#segment01_mw201_dataTable").dataTable().fnAddData( rowSet, false );
	});
	
	// Update DataTable
	$.each(segment01_mw201_itemListForUpdate, function(index, itemObj) {			
		var rowSet = [];
		rowSet.push( 'UPDATE' );
		rowSet.push( itemObj.id );
		rowSet.push( itemObj.groupName );
		rowSet.push( '<i class="fa fa-pencil" aria-hidden="true"></i> ' + itemObj.name );
		$("#segment01_mw201_dataTable").dataTable().fnAddData( rowSet, false );
	});
	// Update DataTable
	$.each(segment01_mw201_itemListForDelete, function(index, itemObj) {			
		var rowSet = [];
		rowSet.push( 'DELETE' );
		rowSet.push( itemObj.id );
		rowSet.push( itemObj.groupName );
		rowSet.push( '<i class="fa fa-times" aria-hidden="true"></i> ' + itemObj.name );
		$("#segment01_mw201_dataTable").dataTable().fnAddData( rowSet, false );
	});
	
	// Redraw Table
	$("#segment01_mw201_dataTable").DataTable().draw();
	
	module_showModalWindow('segment01_mw201', true);	
} // .end of segment01_mw201_updateUI

function segment01_mw201_confirm()
{
	//$('#segment01_mw201_uploadButton').ladda().ladda('start');
	
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'itemListForInsert': segment01_mw201_itemListForInsert,
		'itemListForUpdate': segment01_mw201_itemListForUpdate,
		'itemListForDelete': segment01_mw201_itemListForDelete
	};
	
	var params = new Object();
	
	// Ajax Call
	tycheesdb_api_batchUpdateItems(requestBody, segment01_mw201_confirm_postHandler, params);
	// Show Info
	swal("Batch Update in Progress", "Please check at notification when the task is complete.", "info");
	// Close Modal Window
	segment01_mw201_close();
} // .end of segment01_mw201_confirm

function segment01_mw201_confirm_postHandler(success, responseObj, params)
{
	//$('#segment01_mw201_uploadButton').ladda().ladda('stop');
	
	if (!success)
		tycheesLogger_showToast('error', 'Batch Upload Failed', 'Please try again.');
	else
		tycheesLogger_showToast('success', 'Batch Upload Completed', 'Inventory records has been updated.');
	
	//segment01_mw201_close();
	
	//swal("Batch Update in Progress", "Please check at notification when the task is complete.", "info");
} // .end of segment01_mw201_confirm_postHandler

function segment01_mw201_close()
{
	// Close window
	module_closeModalWindow('segment01_mw201');
} // .end of segment01_mw201_close

</script>