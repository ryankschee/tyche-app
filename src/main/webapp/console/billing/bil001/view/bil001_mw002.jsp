<!-- DELIVERY DIALOG -->
<div class="modal inmodal fade" id="mw002" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xl" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">DELIVERY</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
 
 				<div id="mw002_contentPane_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw002_contentPane_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
				</div>
				
				<div id="mw002_contentPane" sytle="display:none;"> 
 
					<ul class="nav nav-tabs" id="mw002_tabHeader">
						<li class="active">
							<a id="mw002_tabHeader_1" data-toggle="tab" href="#mw002_tab1">
								<i class="fa fa-truck"></i> CREATE / EDIT DELIVERY
							</a>
						</li>
						<li class="">
							<a id="mw002_tabHeader_2" data-toggle="tab" href="#mw002_tab2">
								<i class="fa fa-history"></i> DELIVERY HISTORY
							</a>
						</li>
					</ul>
				
					<div class="tab-content">
						<div id="mw002_tab1" class="tab-pane active">
							<div class="row" style="padding-top:15px;">								
								<div class="col-md-7">
									<form role="form">									
										<div class="form-group">
											<label>Address Options</label>
											<select id="mw002_addressOptions" class="form-control" onchange="mw002_addressOptions_onchanged(this);">
											</select>
										</div>
										<div class="form-group">
											<label><span class="mandatory-field">*</span> Attention to</label> 
											<input id="mw002_inputAttentionTo" type="text" placeholder="Enter name of recipient" class="form-control" autofocus required>
											<span id="mw002_inputAttentionTo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>
										<div class="form-group">
											<label><span class="mandatory-field">*</span> Contact No.</label> 
											<input id="mw002_inputContactNumber" type="text" placeholder="Enter contact of recipient" class="form-control" required>
											<span id="mw002_inputContactNumber_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>
										<div class="form-group">
											<label><span class="mandatory-field">*</span> Street line 1</label> 
											<input id="mw002_inputStreet1" type="text" placeholder="" class="form-control" required>
											<span id="mw002_inputStreet1_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label>Street line 2</label> 
											<input id="mw002_inputStreet2" type="text" placeholder="" class="form-control" required>
											<span id="mw002_inputStreet2_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label>Street line 3</label> 
											<input id="mw002_inputStreet3" type="text" placeholder="" class="form-control" required>
											<span id="mw002_inputStreet3_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label><span class="mandatory-field">*</span> Postal Code</label> 
											<input id="mw002_inputPostalCode" type="text" placeholder="" class="form-control" required>
											<span id="mw002_inputPostalCode_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label>City</label> 
											<input id="mw002_inputCity" type="text" placeholder="" class="form-control">
											<span id="mw002_inputCity_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label>State</label> 
											<input id="mw002_inputState" type="text" placeholder="" class="form-control">
											<span id="mw002_inputState_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label>Country</label> 
											<input id="mw002_inputCountry" type="text" placeholder="" class="form-control">
											<span id="mw002_inputCountry_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
									</form>
								</div>
								<div class="col-md-5">
									<form role="form">
										<div class="form-group">
											<label><span class="mandatory-field">*</span> Delivery Order Reference No.</label> 
											<input id="mw002_inputRefNo" type="text" class="form-control">
											<span id="mw002_inputRefNo_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>
										<div class="form-group">
											<label>Method</label> 
											<input id="mw002_inputMethod" type="text" class="form-control">
											<span id="mw002_inputMethod_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>
										<div class="form-group">
											<label>Terms</label> 
											<input id="mw002_inputTerms" type="text" class="form-control">
											<span id="mw002_inputTerms_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group date-group">
											<label><span class="mandatory-field">*</span> Dispatch Date </label> 
											<div class="input-group date">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
												<input id="mw002_inputDispatchDate" type="text" class="form-control" data-mask="99/99/9999">
											</div>
	                                      	<span class="help-block">MM/dd/yyyy</span>
											<span id="mw002_inputDispatchDate_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
	
										<div class="form-group date-group">
											<label>Receive Date </label> 
											<div class="input-group date">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
												<input id="mw002_inputReceiveDate" type="text" class="form-control" data-mask="99/99/9999">
											</div>
	                                      	<span class="help-block">MM/dd/yyyy</span>
											<span id="mw002_inputReceiveDate_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>	
										<div class="form-group">
											<label>Remarks</label> 
											<input id="mw002_inputRemarks" type="text" placeholder="" class="form-control">
											<span id="mw002_inputRemarks_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Invalid Value</span>
										</div>		
										<div class="form-group">										
											<button type="button" class="btn btn-primary" onclick="mw002_save();">Save Delivery</button>
										</div>	
									</form>
								</div>
							</div>
						</div>
						<div id="mw002_tab2" class="tab-pane">
							<div class="row" style="padding-top:15px;">
								<div class="col-md-12">
									<div class="ibox">
										<div class="ibox-title">
											<h5>Delivery Orders</h5>
										</div>
										<div class="ibox-content">
											<table id="mw002_dataTable_billingDelivery" class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th>DO #</th>
														<th>Attn To:</th>
														<th>Address</th>
														<th class="text-right">Action</th>
													</tr>
												</thead>
												<tbody id="tbody-billing-delivery-list">
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw002_initialized = false;
var mw002_editable = false;
var mw002_customerObj;

function mw002_isOpen()
{
	return ($("#mw002").data('bs.modal') || {}).isShown;	
} // .end of mw002_isOpen

function mw002_init()
{
	if (mw002_initialized)
		return false;
	
	// Init dataTable (billingDelivery, Delivery Modal Dialog)
	$("#mw002_dataTable_billingDelivery").DataTable( {
		  "columnDefs": [
			    { "width": "120px", "targets": 0 },
			    { "width": "150px", "targets": 1 },
			    { "width": "120px", "targets": 3 }
			  ]
			});
	
	mw002_initialized = true;
} // .end of mw002_init
 
function mw002_show(editable)
{
	// Check if billing exists
	if (global_billingObj == null) {
		return false;
		tycheesLogger_showToast('error', 'No billing object selected', 'Please open a billing to view delivery records.');
	}
	// Check if billing line exists
	if (global_billingObj.lineList.length == 0) {
		tycheesLogger_showToast("error", "Delivery not Ready", "Please insert item(s) before proceed to Delivery.");
		return false;
	}
	
	mw012_editable = editable==null ? true : editable;
	
	mw002_updateUI();
} // .end of mw002_show
 
function mw002_updateUI()
{
	// Show Modal WIndow
	module_showModalWindow('mw002', true);
	// Show/Hide Progressing
	$('#mw002_contentPane_spinner').show();
	$('#mw002_contentPane').hide();
	
	if ($.trim(global_billingObj.customerId) == '')
	{
		mw002_updateUI_postHandler(true, null, null);
	}
	else
	{
		var requestBody = {
			'appName': APP_NAME_POS,
			'customerId': global_billingObj.customerId,
			'fullBean': true	
		};	

		var params = new Object();
			
		tycheesdb_api_getCustomerById(requestBody, mw002_updateUI_postHandler, params);
	}	
} // .end of mw002_updateUI
 
function mw002_updateUI_postHandler(success, responseObj, params)
{			
	mw002_init();
	
	if (responseObj != null || responseObj.customerObj != null)
		mw002_customerObj = responseObj.customerObj;
	
	mw002_tab1_updateUI();
	mw002_tab2_updateUI();
	
	// Show/Hide Progressing
	$('#mw002_contentPane_spinner').hide();
	$('#mw002_contentPane').show();
} // .end of mw002_updateUI

function mw002_tab1_updateUI()
{
	if (mw002_customerObj == null) {
		$('#mw002_addressOptions').empty();
		$('#mw002_addressOptions').append('<option value="custom">Custom Address</option>');
		$('#mw002_addressOptions').val('custom');
	} else {
		$('#mw002_addressOptions').empty();
		$.each(mw002_customerObj.addressList, function(i, addressObj) {
			
			var htmlLines = '';
			htmlLines += '<option value="' + addressObj.id + '">';
			htmlLines += tycheesBean_toString_commonAddressBean(addressObj);
			htmlLines += '</option>';
			$('#mw002_addressOptions').append( htmlLines );			
    	});		

		$('#mw002_addressOptions').append('<option value="custom">Custom Address</option>');
		
		if (mw002_customerObj.addressList.length > 0) {
			$('#mw002_addressOptions').val( mw002_customerObj.addressList[0].id );
		}
	}
	
	// Trigger event
	mw002_addressOptions_onchanged();
	
	// Set Delivery Order number
	$('#mw002_inputRefNo').val( consoleCommon_getNextDeliveryOrderNo() );
} // .end of mw002_tab1_updateUI

function mw002_tab2_updateUI()
{
	// Clear list
	$('#mw002_dataTable_billingDelivery').DataTable().clear().draw();
	
	$.each(global_billingObj.deliveryList, function(i, deliveryObj) {
		
		if (Cached_isDeletedBean(deliveryObj))
			return true;
		
		var printButton = '';
		printButton += '<button class="btn btn-primary btn-xs ladda-button" data-style="zoom-in" id="printBtn-' + deliveryObj.id + '" onclick="mw002_printDO(\'' + deliveryObj.id + '\');" style="vertical-align:middle;">';
		printButton += '<i class="fa fa-print" aria-hidden="true"></i> Print';
		printButton += '</button>';

		var deleteButton = '';
		deleteButton += '<button class="btn btn-danger btn-xs ladda-button" data-style="zoom-in" id="deleteBtn-' + deliveryObj.id + '" onclick="mw002_deleteDelivery(\'' + deliveryObj.id + '\');" style="vertical-align:middle;">';
		deleteButton += '<i class="fa fa-trash" aria-hidden="true"></i> Delete';
		deleteButton += '</button>';
		
		var rowSet = [];
		rowSet.push(deliveryObj.refNo);
		rowSet.push(deliveryObj.attentionTo);
		rowSet.push(tycheesBean_toString_commonAddressBean(deliveryObj));
		rowSet.push( '<span class="pull-right">' + printButton + ' ' + deleteButton + '</span>');
		
		$("#mw002_dataTable_billingDelivery").dataTable().fnAddData( rowSet, false );
	});
	
	$('#mw002_dataTable_billingDelivery').DataTable().draw();
} // .end of mw002_tab2_updateUI

function mw002_addressOptions_onchanged()
{
	var selectedOption = $('#mw002_addressOptions').val();
	
	if (selectedOption == 'custom') {
		$("#mw002_inputAttentionTo").val('');
		$("#mw002_inputContactNumber").val('');
		$("#mw002_inputStreet1").val('');
		$("#mw002_inputStreet2").val('');
		$("#mw002_inputStreet3").val('');
		$("#mw002_inputPostalCode").val('');
		$("#mw002_inputCity").val('');
		$("#mw002_inputState").val('');
		$("#mw002_inputCountry").val('');
	} else {
		$.each(mw002_customerObj.addressList, function(i, addressObj) {
			if (selectedOption == addressObj.id) {
				$("#mw002_inputAttentionTo").val(addressObj.attentionTo);
				$("#mw002_inputContactNumber").val(mw002_customerObj.contact);
				$("#mw002_inputStreet1").val(addressObj.streetLine1);
				$("#mw002_inputStreet2").val(addressObj.streetLine2);
				$("#mw002_inputStreet3").val(addressObj.streetLine3);
				$("#mw002_inputPostalCode").val(addressObj.postalCode);
				$("#mw002_inputCity").val(addressObj.city);
				$("#mw002_inputState").val(addressObj.state);
				$("#mw002_inputCountry").val(addressObj.country);
			}
		});
	}
} // .end of mw002_addressOptions_onchanged

function mw002_printDO(deliveryId)
{
	$('#printBtn-'+deliveryId).ladda().ladda('start');
	
	$.each(global_billingObj.deliveryList, function(i, deliveryObj) {
		if (deliveryId == deliveryObj.id)
			processDocument_DO001_001_getPDF(mw002_printDO_callback, global_billingObj, deliveryObj);
	});
	
	$('#printBtn-'+deliveryId).ladda().ladda('stop');			
} // .end of mw002_print

function mw002_printDO_callback(pdfDoc)
{
	if (tycheesCommon_isMobileDevice())
		pdfDoc.output('dataurlnewwindow');
	else
		mw_pdfPreview_show(pdfDoc.output('datauri'), 'mw002');
} // .end of mw002_printDO_callback

function mw002_deleteDelivery(deliveryId)
{
	$('#deleteBtn-'+deliveryId).ladda().ladda('start');
	
	$.each(global_billingObj.deliveryList, function(i, deliveryObj) {
		if (deliveryId == deliveryObj.id)
			Cached_deleteBean(deliveryObj);
	});

   	// Auto-save Billing
	bil001_menuPanel_save();
   	
	$('#deleteBtn-'+deliveryId).ladda().ladda('stop');
	
	// Load UI from delivery object
	mw002_tab2_updateUI();
} // .end of mw002_delete

function mw002_save()
{    
	// Reset
	$('.help-block').hide();
	
	var attentionTo = $.trim( $("#mw002_inputAttentionTo").val() );
	var contactNo = $.trim( $("#mw002_inputContactNumber").val() );
	var streetLine1 = $.trim( $("#mw002_inputStreet1").val() );
	var streetLine2 = $.trim( $("#mw002_inputStreet2").val() );
	var streetLine3 = $.trim( $("#mw002_inputStreet3").val() );
	var postalCode = $.trim( $("#mw002_inputPostalCode").val() );
	var city = $.trim( $("#mw002_inputCity").val() );
	var state = $.trim( $("#mw002_inputState").val() );
	var country = $.trim( $("#mw002_inputCountry").val() );
	var refNo = $.trim( $("#mw002_inputRefNo").val() );
	var method = $.trim( $("#mw002_inputMethod").val() );
	var terms = $.trim( $("#mw002_inputTerms").val() );
	var dispatchDate = $.trim( $("#mw002_inputDispatchDate").val() );
	var receiveDate = $.trim( $("#mw002_inputReceiveDate").val() );
	var remarks = $.trim( $("#mw002_inputRemarks").val() );
	
	// VALIDATION
	if (attentionTo == '') {
		$("#mw002_inputAttentionTo_error").show();
		return false;
	}
	if (contactNo == '') {
		$("#mw002_inputContactNumber_error").show();
		return false;
	}
	if (streetLine1 == '') {
		$("#mw002_inputStreet1_error").show();
		return false;
	}
	if (postalCode == '') {
		$("#mw002_inputPostalCode_error").show();
		return false;
	}
	if (refNo == '') {
		$("#mw002_inputRefNo_error").show();
		return false;
	}
	if (dispatchDate == '' || !tycheesDateTime_isValidDate_ddmmyyyy(dispatchDate)) {
		$("#mw002_inputDispatchDate_error").show();
		return false;
	}
	if (receiveDate != '' && !tycheesDateTime_isValidDate_ddmmyyyy(receiveDate)) {
		$("#mw002_inputReceiveDate_error").show();
		return false;
	}
	
	var deliveryObj = createNew_BillingDelivery();	
	deliveryObj.hasChanged = true;
	deliveryObj.attentionTo = attentionTo;
	deliveryObj.contactNo = contactNo;
	deliveryObj.streetLine1 = streetLine1;
	deliveryObj.streetLine2 = streetLine2;
	deliveryObj.streetLine3 = streetLine3;
	deliveryObj.postalCode = postalCode;
	deliveryObj.city = city;
	deliveryObj.state = state;
	deliveryObj.country = country;
	deliveryObj.refNo = refNo;
	deliveryObj.method = method;
	deliveryObj.terms = terms;
	deliveryObj.dispatchedOn = tycheesDateTime_toMilliseconds_MMddyyyy( dispatchDate );
	deliveryObj.receivedOn = tycheesDateTime_toMilliseconds_MMddyyyy( receiveDate ) == 0 ? null : tycheesDateTime_toMilliseconds_MMddyyyy( receiveDate );
	deliveryObj.remarks = remarks;	
	
	global_billingObj.deliveryList.push(deliveryObj);

	// Update delivery order number
	consoleCommon_updateNextDeliveryOrderNo();
	// Set Delivery Order number
	$('#mw002_inputRefNo').val( consoleCommon_getNextDeliveryOrderNo() );
	
   	// Auto-save Billing
	bil001_menuPanel_save();
	// Load UI from delivery object
	mw002_tab2_updateUI();
} // .end of mw002_save

</script>