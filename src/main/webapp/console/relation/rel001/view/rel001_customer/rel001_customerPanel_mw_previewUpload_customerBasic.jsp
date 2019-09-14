<!-- Preview Batch Upload: Customer Basic -->
<div class="modal inmodal fade" id="mw_previewUpload_customerBasic" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">BATCH FILE VALIDATION</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger"  onclick="mw_previewUpload_customerBasic_close();">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div id="mw_previewUpload_customerBasic_error" style="padding: 5px 0px; color:#FF0000;">
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> 
					Usage limit exceeded. Please increase limit at Settings &gt; My Place &gt; Account Membership
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="ibox" style="margin-bottom:0px;">
							<div class="ibox-content">
								<table id="mw_previewUpload_customerBasic_dataTable" class="table table-striped table-bordered table-hover">
									<thead>
										<tr id="mw_previewUpload_customerBasic_dataTable_header">
											<th>ACTION</th>
											<th>ID</th>
											<th>Customer No</th>
											<th>First Name</th>
											<th>Last Name</th>
											<th>Gender</th>
											<th>DOB</th>
											<th>Description</th>
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
				<button id="mw_previewUpload_customerBasic_uploadButton" type="button" class="btn btn-primary ladda-button" data-style="expand-right" onclick="mw_previewUpload_customerBasic_confirm();">Confirm Upload</button>
				<button id="mw_previewUpload_customerBasic_closeButton" type="button" class="btn btn-danger" onclick="mw_previewUpload_customerBasic_close();">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_previewUpload_customerBasic_initialized = false;
var mw_previewUpload_customerBasic_listForInsert = [];
var mw_previewUpload_customerBasic_listForUpdate = [];
var mw_previewUpload_customerBasic_listForDelete = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw_previewUpload_customerBasic_isOpen()
{
	return ($("#mw_previewUpload_customerBasic").data('bs.modal') || {}).isShown;	
} // .end of mw_previewUpload_customerBasic_isOpen

/**
 * Initiate components/variables
 */
function mw_previewUpload_customerBasic_init()
{
	if (mw_previewUpload_customerBasic_initialized)
		return false;

	// Init dataTable (customer Modal Dialog)
	$("#mw_previewUpload_customerBasic_dataTable").DataTable();
	
	mw_previewUpload_customerBasic_initialized = true;
} // .end of mw_previewUpload_customerBasic_init

function mw_previewUpload_customerBasic_updateUI(params)
{
	// Init
	mw_previewUpload_customerBasic_init();

	mw_previewUpload_customerBasic_listForInsert = params.listForInsert;
	mw_previewUpload_customerBasic_listForUpdate = params.listForUpdate;
	mw_previewUpload_customerBasic_listForDelete = params.listForDelete;
	
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var customerMaxCount = 0;
	var customerUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_CUSTOMER_MAX_COUNT) {
			customerMaxCount = Number(propObj.propValue);
			customerUsageCount = Number(propObj.propContent);
		}
	});
	
	var futureCustomerUsageCount = customerUsageCount + mw_previewUpload_customerBasic_listForInsert.length - mw_previewUpload_customerBasic_listForDelete.length;
	if (mw_previewUpload_customerBasic_listForInsert.length > 0 && futureCustomerUsageCount >= customerMaxCount)	{
		$('#mw_previewUpload_customerBasic_error').show();
		$('#mw_previewUpload_customerBasic_uploadButton').hide();
	} else {
		$('#mw_previewUpload_customerBasic_error').hide();
		$('#mw_previewUpload_customerBasic_uploadButton').show();
	}
		
	// Clear list
	$('#mw_previewUpload_customerBasic_dataTable').DataTable().clear().draw();
	// Update DataTable
	$.each(mw_previewUpload_customerBasic_listForInsert, function(i, customerObj) {			
		var rowSet = [];
		rowSet.push( '<span style="font-weight:bold; color:#0d8800;"><i class="fa fa-plus" aria-hidden="true"></i> INSERT</span>' );
		rowSet.push( customerObj.id );
		rowSet.push( customerObj.customerNo );
		rowSet.push( customerObj.firstName );
		rowSet.push( customerObj.lastName );
		rowSet.push( customerObj.gender );
		rowSet.push( tycheesDateTime_getFormattedDate_MMddyyyy(customerObj.dob) );
		rowSet.push( customerObj.description );
		$("#mw_previewUpload_customerBasic_dataTable").dataTable().fnAddData( rowSet, false );
	});
	
	// Update DataTable
	$.each(mw_previewUpload_customerBasic_listForUpdate, function(i, customerObj) {			
		var rowSet = [];
		rowSet.push( '<span style="font-weight:bold; color:#b74500;"><i class="fa fa-pencil" aria-hidden="true"></i> UPDATE</span>' );
		rowSet.push( customerObj.id );
		rowSet.push( customerObj.customerNo );
		rowSet.push( customerObj.firstName );
		rowSet.push( customerObj.lastName );
		rowSet.push( customerObj.gender );
		rowSet.push( tycheesDateTime_getFormattedDate_MMddyyyy(customerObj.dob) );
		rowSet.push( customerObj.description );
		$("#mw_previewUpload_customerBasic_dataTable").dataTable().fnAddData( rowSet, false );
	});
	// Update DataTable
	$.each(mw_previewUpload_customerBasic_listForDelete, function(i, customerObj) {			
		var rowSet = [];
		rowSet.push( '<span style="font-weight:bold; color:#FF0000;"><i class="fa fa-times" aria-hidden="true"></i> DELETE</span>' );
		rowSet.push( customerObj.id );
		rowSet.push( customerObj.customerNo );
		rowSet.push( customerObj.firstName );
		rowSet.push( customerObj.lastName );
		rowSet.push( customerObj.gender );
		rowSet.push( tycheesDateTime_getFormattedDate_MMddyyyy(customerObj.dob) );
		rowSet.push( customerObj.description );
		$("#mw_previewUpload_customerBasic_dataTable").dataTable().fnAddData( rowSet, false );
	});
	
	// Redraw Table
	$("#mw_previewUpload_customerBasic_dataTable").DataTable().draw();
	
	module_showModalWindow('mw_previewUpload_customerBasic', true);	
} // .end of mw_previewUpload_customerBasic_updateUI

function mw_previewUpload_customerBasic_confirm()
{
	$('#mw_previewUpload_customerBasic_uploadButton').ladda().ladda('start');
	
	var requestBody = {
		'appName': APP_NAME_RELATION,
		'listForInsert': mw_previewUpload_customerBasic_listForInsert,
		'listForUpdate': mw_previewUpload_customerBasic_listForUpdate,
		'listForDelete': mw_previewUpload_customerBasic_listForDelete
	};
	
	var params = new Object();
	
	// Ajax Call
	tycheesdb_api_batchUpdateCustomers(requestBody, mw_previewUpload_customerBasic_confirm_postHandler, params);
	// Show Info
	swal("Batch Update in Progress", "Please check at notification when the task is complete.", "info");
	// Close Modal Window
	mw_previewUpload_customerBasic_close();
} // .end of mw_previewUpload_customerBasic_confirm

function mw_previewUpload_customerBasic_confirm_postHandler(success, responseObj, params)
{
	$('#mw_previewUpload_customerBasic_uploadButton').ladda().ladda('stop');
	
	if (!success)
		tycheesLogger_showToast('error', 'Batch Upload Failed', 'Please try again.');
	else
		tycheesLogger_showToast('success', 'Batch Upload Completed', 'Inventory records has been updated.');
} // .end of mw_previewUpload_customerBasic_confirm_postHandler

function mw_previewUpload_customerBasic_close()
{
	// Close window
	module_closeModalWindow('mw_previewUpload_customerBasic');
} // .end of mw_previewUpload_customerBasic_close

</script>