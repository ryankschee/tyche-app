<!-- BILLING PROPERTIES DIALOG -->
<div class="modal inmodal fade" id="mw010" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">BILLING PROPERTIES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-5">
						<div class="ibox float-e-margins" style="margin-bottom:0px;">
							<div class="ibox-title" style="background-color:#f3f3f3;">
							    <h5>
							        <span id="mw010_customerProfileTitle">Customer Profiles</span>
							    </h5> 
							</div>
							<div class="ibox-content">
								<select id="mw010_profiles_select" class="form-control" onchange="mw010_reloadCustomerProfile();">
					            </select>
					            <ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
               	                	<span id="mw010_customer_propertiesList">
                        	        </span>
               	                </ul>
							</div>
						</div>
					</div>
					<div class="col-md-7">
						<div class="ibox float-e-margins" style="margin-bottom:0px;">
							<div class="ibox-title" style="background-color:#f3f3f3;">
							    <h5>
							        <span>Billing Properties</span>
							    </h5> 
							</div>
							<div class="ibox-content">
								<button type="button" class="btn btn-info btn-xs" onclick="mw010_addProperties();">
									<i class="fa fa-plus" aria-hidden="true"></i> Add Properties
								</button>
								<ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
               	                	<span id="mw010_billing_propertiesList">
                        	        </span>
               	                </ul>
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

var mw010_initializing = false;
var mw010_initialized = false;
var mw010_customerObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw010_isOpen()
{
	return ($("#mw010").data('bs.modal') || {}).isShown;	
} // .end of mw010_isOpen

function mw010_init()
{
	if (mw010_initialized==true)
		return false;
	
    mw010_initialized = true;
}

/**
 * Initiate data into modal window.
 */
function mw010_open(itemId)
{	
	mw010_init();
	
} // .end of mw010_open

/**
 * Update data on Modal Window.
 */
function mw010_updateUI()
{
	tycheesOverlay_startShortProgress('loading customer...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': true,
		'customerId': global_billingObj.customerId
	};

	var params = new Object();

	tycheesdb_api_getCustomerById(requestBody, mw010_updateUI_postHandler, params);
} // .end of mw010_updateUI

function mw010_updateUI_postHandler(success, responseObj, params)
{
	tycheesOverlay_stopShortProgress();
	
	if (success == false)
		return false;	
	
	mw010_customerObj = responseObj.customerObj;	
	if (mw010_customerObj == null)
	{
		swal("No Customer Found", "Please select a customer first.", "warning");
		return false;
	}
	
	// Populate customer profiles into select component
	$.each(mw010_customerObj.profileList, function(i, profileObj){
		
		var selectedVal = '';
		if (profileObj.defaultProfile)
			selectedVal = 'selected';
		
		var htmlLines = '';
		htmlLines += '<option value="' + profileObj.id + '" ' + selectedVal + '>';
		htmlLines += profileObj.profileName;
		htmlLines += '</option>';
		
		$('#mw010_profiles_select').append(htmlLines);
	});
	
	mw010_reloadCustomerProfile();
	mw010_reloadBillingProperties();
	
    // Show Modal Window on Top
    module_showModalWindow('mw010', true);
} // .end of mw010_updateUI_postHandler

/**
 * Show modal window.
 */
function mw010_show() 
{
	mw010_updateUI();
} // .end of show_mw010

/**
 * Reload Customer Profile details
 */
function mw010_reloadCustomerProfile()
{
	var profileId = $('#mw010_profiles_select').val();
	
	$.each(mw010_customerObj.profileList, function(i, profileObj){
		
		if (profileId==profileObj.id) 
		{
			// Extract & Process List
		    var sortedList = [];
		    $.each(profileObj.propertiesList, function(i, propertiesObj){
		    	sortedList.push(propertiesObj);
		    });
		    // Sort list, by group name
		    sortedList.sort(
				function(a, b){ 
					return tycheesList_sortByString(a.groupName, b.groupName);
				});
			

		    var lastGroupName = '';
			$('#mw010_customer_propertiesList').empty();
			$.each(sortedList, function(j, propertiesObj){
				
				if (lastGroupName != propertiesObj.groupName)
		    	{
		    	    lastGroupName = propertiesObj.groupName;
		    	    
		    	    var dividerHtmlLines = '';		    	    
		    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#999;color:#FFF;font-weight:bold;padding-left:10px;">';
		    	    dividerHtmlLines += lastGroupName;
		    	    dividerHtmlLines += '</li>';
		    	    
		    	    $('#mw010_customer_propertiesList').append(dividerHtmlLines);
		    	}
				
				var htmlLines = '';
				htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
				htmlLines += '<span style="height:25px;margin-top:5px;">';
				htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
				htmlLines += propertiesObj.propKey;
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
				htmlLines += '<span style="padding-left:10px;padding-right:5px;">';
				htmlLines += '<i class="fa fa-chevron-right" aria-hidden="true" style="cursor:pointer;" onclick="mw010_shiftRight(\'' + propertiesObj.id  + '\');"></i>';
				htmlLines += '</span>';
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right"> ';
				htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
				htmlLines += '</span>';
				htmlLines += '</li>';
				
				$('#mw010_customer_propertiesList').append(htmlLines);
			});
		}
	});
	
} // .end of mw010_reloadCustomerProfile

/**
 * Reload Billing Properties
 */
function mw010_reloadBillingProperties()
{
	// Extract & Process List
    var sortedList = [];
    $.each(global_billingObj.propertiesList, function(i, propertiesObj){
    	sortedList.push(propertiesObj);
    });
    // Sort list, by group name
    sortedList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.groupName, b.groupName);
		});
		
	var lastGroupName = '';
			

	$('#mw010_billing_propertiesList').empty();
	$.each(sortedList, function(j, propertiesObj){
		
		if (lastGroupName != propertiesObj.groupName)
    	{
    	    lastGroupName = propertiesObj.groupName;
    	    
    	    var dividerHtmlLines = '';		    	    
    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding-left:10px;">';
    	    dividerHtmlLines += lastGroupName;
    	    dividerHtmlLines += '</li>';
    	    
    	    $('#mw010_billing_propertiesList').append(dividerHtmlLines);
    	}
		
		var htmlLines = '';
		htmlLines += '<li id="' + propertiesObj.id + '" class="list-group-item list-group-item-custom form-inline" style="height:50px;padding-left:10px;padding-right:10px;">';
		htmlLines += '<span style="height:25px;margin-top:5px;">';
		htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
		htmlLines += tycheesText_getDisplayText(propertiesObj.propKey, 0);
		htmlLines += '</span>';
		htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
		htmlLines += '<span style="padding-left:10px;padding-right:5px;">';
		htmlLines += '<i class="fa fa-pencil" aria-hidden="true" style="cursor:pointer;" onclick="mw010_editProperties(\'' + propertiesObj.id  + '\');"></i>';
		htmlLines += '</span>';
		htmlLines += '<span style="padding-left:5px;padding-right:10px;">';
		htmlLines += '<i class="fa fa-times-circle" aria-hidden="true" style="cursor:pointer;color:#ff0000;" onclick="mw010_deleteProperties(\'' + propertiesObj.id  + '\');"></i>'; 
		htmlLines += '</span>';
		htmlLines += '</span>';
		htmlLines += '<span class="pull-right"> ';
		htmlLines += '<input id="value-' + propertiesObj.id + '" class="form-control input-sm" id="inputsm" type="text" onchange="mw010_saveProperties(\'' + propertiesObj.id  + '\');" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
		htmlLines += '</span>';
		htmlLines += '</li>';
		
		$('#mw010_billing_propertiesList').append(htmlLines);
	});
} // .end of mw010_reloadBillingProperties

/**
 * MOVE profile properties RIGHT to billing properties.
 */
function mw010_shiftRight(profilePropertiesId) 
{
	var profileId = $('#mw010_profiles_select').val();
	
	$.each(mw010_customerObj.profileList, function(i, profileObj){
		
		if (profileId==profileObj.id) 
		{
			$.each(profileObj.propertiesList, function(i, propertiesObj){
		    	if (propertiesObj.id == profilePropertiesId) {
		    		var newPropertiesObj = createNew_BillingProperties();
		    		
		    		newPropertiesObj.billingId = global_billingObj.id;
		    		newPropertiesObj.propKey = propertiesObj.propKey;
		    		newPropertiesObj.propValue = propertiesObj.propValue;
		    		newPropertiesObj.groupName = propertiesObj.groupName;	
		    		newPropertiesObj.propName = propertiesObj.propName;
		    		newPropertiesObj.propType = propertiesObj.propType;	    
		    		
		    		global_billingObj.propertiesList.push(newPropertiesObj);
		    		
		    		mw010_reloadBillingProperties();
		    	}
		    });
		}
	});
	
	// Auto-save Billing
	bil001_menuPanel_save();
} // .end of mw010_shiftRight

/**
 * Add properties (prompt Modal Window)
 */
function mw010_addProperties()
{
	mw011_show();
} // .end of mw010_saveProperties

/**
 * Edit Properties (prompt Modal Window)
 */
function mw010_editProperties(propertiesId)
{
	mw012_show(propertiesId);	
} // .end of mw010_editProperties

/**
 * Save Properties
 */
function mw010_saveProperties(propertiesId)
{
	var newKey = $('#key-'+propertiesId).val();
	var newVal = $('#value-'+propertiesId).val();
	$.each(global_billingObj.propertiesList, function(i, propertiesObj){
    	if (propertiesId==propertiesObj.id) 
    	{
    		propertiesObj.hasChanged = true;
    		propertiesObj.propKey = newKey;
    		propertiesObj.propValue = newVal;
    	}
    });
	
	// Auto-save Billing
	bil001_menuPanel_save();
} // .end of mw010_saveProperties

/**
 * Delete Properties
 */
function mw010_deleteProperties(propertiesId)
{
	var deletedIndex = -1;
	$.each(global_billingObj.propertiesList, function(i, propObj){
    	if (propertiesId==propObj.id)
    	{
    		Cached_deleteBean(propObj);
			
    		// Remove from UI
    		$('#'+propertiesId).remove();
    		
    	    // Update Customer UI
    	    mw010_reloadBillingProperties();
    	}
    });
    
	// Auto-save Billing
	bil001_menuPanel_save();
} // .end of mw010_deleteProperties

</script>