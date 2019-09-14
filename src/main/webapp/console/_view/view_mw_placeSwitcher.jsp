
<!-- 
    Title:			PLACE SWITCHER 
    Desc:			- Show place list, under current logon user id.
    Author:			Ryan Chee
    Last Modified:	20170921
-->

<div class="modal inmodal fade" id="mw_placeSwitcher" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-lg4" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">AVAILABLE PLACES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body modal-body-xl">
				<div id="mw_placeSwitcher_placeList" class="row" style="height:100%;margin:0px;">
					<div class="col-lg-12 ibox-content" style="height:100%;">
						<table id="mw_placeSwitcher_dataTable" class="table table-striped table-bordered table-hover">
	                        <thead>
		                        <tr>
		                            <th>Place ID</th>
		                            <th>Place Name</th>
		                            <th></th>
		                        </tr>
	                        </thead>
	                        <tbody id="mw_placeSwitcher_tableBody">
							</tbody>
						</table>
					</div>
				</div><!-- .end of row -->
				
				<div id="mw_placeSwitcher_placeList_spinner" class="row" style="height:100%; margin-top:20px; display:none;">
					<div class="col-lg-12 ibox-content" style="height:100%;">
						<div class="spiner-example" style="padding-top:0px;">
		                    <div class="sk-spinner sk-spinner-wave">
		                        <div class="sk-rect1"></div>
		                        <div class="sk-rect2"></div>
		                        <div class="sk-rect3"></div>
		                        <div class="sk-rect4"></div>
		                        <div class="sk-rect5"></div>
		                    </div>
		                </div>
					</div>
				</div>
				
			</div>
			<div class="modal-footer" style="padding-top:10px; padding-bottom:10px;">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" onclick="mw_placeSwitcher_createNewPlace();">Create New Place</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_placeSwitcher_initialized = false;

function mw_placeSwitcher_isOpen()
{
	return ($("#mw_placeSwitcher").data('bs.modal') || {}).isShown;	
} // .end of mw_placeSwitcher_isOpen

function mw_placeSwitcher_init()
{
	if (mw_placeSwitcher_initialized)
		return false;

	$('#mw_placeSwitcher').on('shown.bs.modal', function () {
	    $("#mw_placeSwitcher_searchKeywords").focus();
	})
	
	// Init dataTable (customer Modal Dialog)
	$("#mw_placeSwitcher_table").DataTable({
		  "columnDefs": [{ "width": "120px", "targets": 0 }]
	});
	// Remove padding of DataTable
	$('#mw_placeSwitcher_dataTable_wrapper').css('padding', '0px');
	
	mw_placeSwitcher_initialized = true;
} // .end of mw_placeSwitcher_init

function mw_placeSwitcher_showSpinner()
{
	$('#mw_placeSwitcher_placeList').hide();
	$('#mw_placeSwitcher_placeList_spinner').show();
} // .end of mw_placeSwitcher_showSpinner

function mw_placeSwitcher_hideSpinner()
{
	$('#mw_placeSwitcher_placeList').show();
	$('#mw_placeSwitcher_placeList_spinner').hide();
} // .end of mw_placeSwitcher_hideSpinner

function mw_placeSwitcher_show() 
{
	mw_placeSwitcher_updateUI();
} // .end of mw_placeSwitcher_show

function mw_placeSwitcher_updateUI()
{			
	// Init, if any
	mw_placeSwitcher_init();
	// Show window
	module_showModalWindow('mw_placeSwitcher', true);
	// Show Spinner
	mw_placeSwitcher_showSpinner();
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_ALL
	};
	
	var params = new Object();
	params.placeId = tycheesCommon_getCurrentPlaceId();
	
	// Call API
	tycheesdb_api_getPlacesBySession(requestBody, mw_placeSwitcher_updateUI_postHandler, params);
} // .end of mw_placeSwitcher_updateUI

function mw_placeSwitcher_updateUI_postHandler(success, responseObj, params)
{
	if (!success)
		return false;

	// Clear list
	$('#mw_placeSwitcher_dataTable').DataTable().clear().draw();
	
	$.each(responseObj.placeList, function(i, placeObj){
		if (Cached_isDeletedBean(placeObj))
			return true;
	
		var selectButton = '';
		if (placeObj.id != tycheesCommon_getCurrentPlaceId()) {
			selectButton += '<button class="btn btn-primary btn-xs ladda-button" data-style="zoom-in" id="selectBtn-' + placeObj.id + '" onclick="mw_placeSwitcher_selectPlace(\'' + placeObj.id + '\');" style="vertical-align:middle;">';
			selectButton += '<i class="fa fa-hand-pointer-o" aria-hidden="true"></i> Select';
			selectButton += '</button>';
		}
		
		var rowSet = [];
		rowSet.push(placeObj.id);
		rowSet.push(placeObj.name);
		rowSet.push('<span class="pull-right">' + selectButton + '</span>');
		
		$("#mw_placeSwitcher_dataTable").dataTable().fnAddData( rowSet, false );
	});

	$('#mw_placeSwitcher_dataTable').DataTable().draw();
	
	mw_placeSwitcher_hideSpinner();	
} // .end of mw_placeSwitcher_updateUI_postHandler

function mw_placeSwitcher_selectPlace(placeId)
{
	if ($.trim(placeId)=='')
		return false;
	
	// Start ladda button
	$('#selectBtn-'+placeId).ladda().ladda('start');
	// Switch starts
	tycheesCommon_switchPlace(placeId);
} // .end of mw_placeSwitcher_selectPlace

function mw_placeSwitcher_close()
{
	$('#mw_placeSwitcher').hide();
} // .end of mw_placeSwitcher_close

function mw_placeSwitcher_createNewPlace()
{
	mw_placeCreator_show(mw_placeSwitcher_createNewPlace_callbackFn);
} // .end of mw_placeSwitcher_createNewPlace

function mw_placeSwitcher_createNewPlace_callbackFn()
{
	mw_placeSwitcher_updateUI();
} // .end of mw_placeSwitcher_createNewPlace_callbackFn

</script>