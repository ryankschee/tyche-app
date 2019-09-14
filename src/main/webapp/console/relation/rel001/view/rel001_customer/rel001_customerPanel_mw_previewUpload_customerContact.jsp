<!-- Preview Batch Upload: Customer Basic -->
<div class="modal inmodal fade" id="mw_previewUpload_customerContact" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">BATCH FILE VALIDATION</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger"  onclick="mw_previewUpload_customerContact_close();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="ibox" style="margin-bottom:0px;">
							<div class="ibox-content">
								<table id="mw_previewUpload_customerContact_dataTable" class="table table-striped table-bordered table-hover">
									<thead>
										<tr id="mw_previewUpload_customerContact_dataTable_header">
											<th>ACTION</th>
											<th>ID</th>
											<th>Customer Name</th>
											<th>Customer ID</th>
											<th>Type</th>
											<th>Country Code</th>
											<th>Area Code</th>
											<th>Number</th>
											<th>Extension</th>
											<th>Default</th>
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
				<button id="mw_previewUpload_customerContact_uploadButton" type="button" class="btn btn-primary ladda-button" data-style="expand-right" onclick="mw_previewUpload_customerContact_confirm();">Confirm Upload</button>
				<button id="mw_previewUpload_customerContact_closeButton" type="button" class="btn btn-danger" onclick="mw_previewUpload_customerContact_close();">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_previewUpload_customerContact_initialized = false;
var mw_previewUpload_customerContact_listForInsert = [];
var mw_previewUpload_customerContact_listForUpdate = [];
var mw_previewUpload_customerContact_listForDelete = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw_previewUpload_customerContact_isOpen()
{
	return ($("#mw_previewUpload_customerContact").data('bs.modal') || {}).isShown;	
} // .end of mw_previewUpload_customerContact_isOpen

/**
 * Initiate components/variables
 */
function mw_previewUpload_customerContact_init()
{
	if (mw_previewUpload_customerContact_initialized)
		return false;

	// Init dataTable (customer Modal Dialog)
	$("#mw_previewUpload_customerContact_dataTable").DataTable();
	
	mw_previewUpload_customerContact_initialized = true;
} // .end of mw_previewUpload_customerContact_init

function mw_previewUpload_customerContact_updateUI(params)
{
	// Init
	mw_previewUpload_customerContact_init();

	mw_previewUpload_customerContact_listForInsert = params.listForInsert;
	mw_previewUpload_customerContact_listForUpdate = params.listForUpdate;
	mw_previewUpload_customerContact_listForDelete = params.listForDelete;
	
	// Clear list
	$('#mw_previewUpload_customerContact_dataTable').DataTable().clear().draw();
	// Update DataTable
	$.each(mw_previewUpload_customerContact_listForInsert, function(i, contactObj) {			
		var rowSet = [];
		rowSet.push( '<span style="font-weight:bold; color:#0d8800;"><i class="fa fa-plus" aria-hidden="true"></i> INSERT</span>' );
		rowSet.push( contactObj.id );
		rowSet.push( contactObj.remarks );
		rowSet.push( contactObj.customerId );
		rowSet.push( contactObj.type );
		rowSet.push( contactObj.countryCode );
		rowSet.push( contactObj.areaCode );
		rowSet.push( contactObj.phoneNumber );
		rowSet.push( contactObj.extension );
		rowSet.push( contactObj.defaultContact );
		$("#mw_previewUpload_customerContact_dataTable").dataTable().fnAddData( rowSet, false );
	});
	
	// Update DataTable
	$.each(mw_previewUpload_customerContact_listForUpdate, function(i, contactObj) {			
		var rowSet = [];
		rowSet.push( '<span style="font-weight:bold; color:#b74500;"><i class="fa fa-pencil" aria-hidden="true"></i> UPDATE</span>' );
		rowSet.push( contactObj.id );
		rowSet.push( contactObj.remarks );
		rowSet.push( contactObj.customerId );
		rowSet.push( contactObj.type );
		rowSet.push( contactObj.countryCode );
		rowSet.push( contactObj.areaCode );
		rowSet.push( contactObj.phoneNumber );
		rowSet.push( contactObj.extension );
		rowSet.push( contactObj.defaultContact );
		$("#mw_previewUpload_customerContact_dataTable").dataTable().fnAddData( rowSet, false );
	});
	// Update DataTable
	$.each(mw_previewUpload_customerContact_listForDelete, function(i, contactObj) {			
		var rowSet = [];
		rowSet.push( '<span style="font-weight:bold; color:#FF0000;"><i class="fa fa-times" aria-hidden="true"></i> DELETE</span>' );
		rowSet.push( contactObj.id );
		rowSet.push( contactObj.remarks );
		rowSet.push( contactObj.customerId );
		rowSet.push( contactObj.type );
		rowSet.push( contactObj.countryCode );
		rowSet.push( contactObj.areaCode );
		rowSet.push( contactObj.phoneNumber );
		rowSet.push( contactObj.extension );
		rowSet.push( contactObj.defaultContact );
		$("#mw_previewUpload_customerContact_dataTable").dataTable().fnAddData( rowSet, false );
	});
	
	// Redraw Table
	$("#mw_previewUpload_customerContact_dataTable").DataTable().draw();
	
	module_showModalWindow('mw_previewUpload_customerContact', true);	
} // .end of mw_previewUpload_customerContact_updateUI

function mw_previewUpload_customerContact_confirm()
{
	$('#mw_previewUpload_customerContact_uploadButton').ladda().ladda('start');
	
	var requestBody = {
		'appName': APP_NAME_RELATION,
		'listForInsert': mw_previewUpload_customerContact_listForInsert,
		'listForUpdate': mw_previewUpload_customerContact_listForUpdate,
		'listForDelete': mw_previewUpload_customerContact_listForDelete
	};
	
	var params = new Object();
	
	// Ajax Call
	tycheesdb_api_batchUpdateCustomerContacts(requestBody, mw_previewUpload_customerContact_confirm_postHandler, params);
	// Show Info
	swal("Batch Update in Progress", "Please check at notification when the task is complete.", "info");
	// Close Modal Window
	mw_previewUpload_customerContact_close();
} // .end of mw_previewUpload_customerContact_confirm

function mw_previewUpload_customerContact_confirm_postHandler(success, responseObj, params)
{
	$('#mw_previewUpload_customerContact_uploadButton').ladda().ladda('stop');
	
	if (!success)
		tycheesLogger_showToast('error', 'Batch Upload Failed', 'Please try again.');
	else
		tycheesLogger_showToast('success', 'Batch Upload Completed', 'Inventory records has been updated.');
} // .end of mw_previewUpload_customerContact_confirm_postHandler

function mw_previewUpload_customerContact_close()
{
	// Close window
	module_closeModalWindow('mw_previewUpload_customerContact');
} // .end of mw_previewUpload_customerContact_close

</script>