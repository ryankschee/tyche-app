
<!-- 
    Title:			CUSTOMER PROFILE
    Desc:			- Show order list
    Author:			Ryan Chee
    Last Modified:	20170812
-->

<div class="modal inmodal fade" id="mw_customerProfile" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header"  style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">CUSTOMER PROFILE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div id="mw_customerProfile_content_spinner" class="row spiner-example" style="display:none;">
					<div class="sk-spinner sk-spinner-wave">
					    <div class="sk-rect1"></div>
					    <div class="sk-rect2"></div>
					    <div class="sk-rect3"></div>
					    <div class="sk-rect4"></div>
					    <div class="sk-rect5"></div>
					</div>
				    <div id="mw_customerProfile_content_spinner_text" style="padding-top:10px; text-align:center;">loading customer...</div>
				</div>				
				<div id="mw_customerProfile_content" class="row">
					<div class="col-md-4">
						<div class="ibox-content">
                            <div class="row">
								<div class="col-md-4 text-center">
	                                <h2><span id="mw_customerProfile_customerName"></span></h2>
	                                <div class="m-b-sm">
	                                    <img id="mw_customerProfile_customerImage" alt="image" class="img-circle" src="https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png" style="width: 62px" data-pin-nopin="true">
	                                </div>
	                            </div>
	                            <div class="col-md-8">
	                                <strong>
	                                    <i class="fa fa-home" aria-hidden="true"></i> Address
	                                </strong>
	                                <p>
	                                    <span id="mw_customerProfile_customerAddress"></span>
	                                </p>
	                                <p>
	                                    <span id="mw_customerProfile_customerDescription"></span>
	                                </p>
	                                <button type="button" class="btn btn-primary btn-sm btn-block"><i class="fa fa-envelope"></i> Send Message
	                                </button>
	                            </div>
	                        </div>
                        	<div id="mw_customerProfile_basicInfo" class="row">
               	                <ul class="list-group clear-list" style="margin:5px 15px 10px 15px;">
                        	        <li class="list-group-item fist-item">
                        	            <span id="mw_customerProfile_customerGender" class="pull-right"></span>
                        	            <i class="fa fa-venus-mars"></i> <span style="padding-left:5px;">Gender</span>
                        	        </li>
                        	        <li class="list-group-item">
                        	            <i class="fa fa-birthday-cake"></i> <span style="padding-left:5px;">Date of Birth</span>
                        	            <span id="mw_customerProfile_customerDob" class="pull-right"></span>
                        	        </li>
                        	        <li class="list-group-item">
                        	            <i class="fa fa-phone"></i> <span style="padding-left:5px;">Contact</span>
                        	            <span id="mw_customerProfile_customerContact" class="pull-right"></span>
                        	        </li>
                        	        <li class="list-group-item">
                        	            <i class="fa fa-envelope"></i> <span style="padding-left:5px;">Email</span>
                        	            <span id="mw_customerProfile_customerEmail" class="pull-right"></span>
                        	        </li>
                        	        <span id="mw_customerProfile_customerCustomFieldList">
                        	        </span>
                        	    </ul>
               	            </div>
               	        </div>
					</div>
					<div class="col-md-8">						
						<div class="ibox-content tab-content">	  
	                        <div class="tab-pane active">
                               	<ul class="nav nav-tabs">
                               	    <li class="active">
                               	        <a data-toggle="tab" href="#mw_customerProfile_tab_billingList">
                               	        	<i class="fa fa-shopping-bag" aria-hidden="true"></i> Billing History
                               	        </a>
                               	    </li>
                               	    <li>
                               	        <a data-toggle="tab" href="#mw_customerProfile_tab_profiles">
                               	        	<i class="fa fa-user" aria-hidden="true"></i> Profiles
                               	        </a>
                               	    </li>
                               	</ul>
                       	        <div class="tab-content">
                       	            <div id="mw_customerProfile_tab_billingList" class="tab-pane active">
                       	            	<br/>
                       	                <table class="table table-striped table-bordered table-hover " id="mw_customerProfile_dataTable_billing" >
                       	                    <thead>
                       	                        <tr>
                       	                            <th>Created On</th>
                       	                            <th>Billing Date</th>
                       	                            <th>Type</th>
                       	                            <th>Billing No.</th>
                       	                            <th style="text-align:right;">Amount</th>
                       	                            <th style="text-align:right;">Status</th>
                       	                        </tr>
                       	                    </thead>
                       	                    <tbody>
                       	                    </tbody>
                       	                </table>
                       	            </div>
                       	            <div id="mw_customerProfile_tab_profiles" class="tab-pane">
                       	            	<div class="input-group" style="padding-top:20px; padding-bottom:10px;">
                       	            		<select id="mw_customerProfile_tab_profiles_select" class="form-control" onchange="mw_customerProfile_reloadProfileProperties();">
								            </select>
								        </div>
                       	                <ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
                       	                	<span id="mw_customerProfile_profile_propertiesList">
	                            	        </span>
                       	                </ul>
                       	            </div>
                       	        </div><!-- .end of tab-content -->
	                       	</div>
	                    </div><!-- .end of tab-content -->
					</div>
				</div> <!-- .end of row -->					
			</div>
			<div class="modal-footer"  style="padding-top:10px; padding-bottom:10px;">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw_customerProfile_initializing = false;
var mw_customerProfile_initialized = false;

var mw_customerProfile_callbackFn;
var mw_customerProfile_callerSelectorId;
var mw_customerProfile_customerId;
var mw_customerProfile_customerObj;
var mw_customerProfile_billingList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw_customerProfile_isOpen()
{
	return ($("#mw_customerProfile").data('bs.modal') || {}).isShown;	
} // .end of mw_customerProfile_isOpen

function mw_customerProfile_init()
{
	if (mw_customerProfile_initialized==true)
		return false;
	
    mw_customerProfile_initialized = true;
}

function mw_customerProfile_reset()
{
	mw_customerProfile_callbackFn = null;
	mw_customerProfile_callerSelectorId = null;
	mw_customerProfile_customerId = null;
	mw_customerProfile_customerObj = null;
	mw_customerProfile_billingList = [];
} // .end of mw_customerProfile_reset

function mw_customerProfile_show(callbackFn, callerSelectorId, customerId)
{
	if (callbackFn == null) {
		tycheesLogger_showToast('error', 'System Error', 'Invalid callback function.');
		return false;
	}
	
	if (customerId == null) {
		tycheesLogger_showToast('error', 'System Error', 'Invalid customer ID.');
		return false;
	}

	// Set callback function
	mw_customerProfile_callbackFn = callbackFn;
	mw_customerProfile_callerSelectorId = callerSelectorId;
	mw_customerProfile_customerId = $.trim(customerId);

	// UI Setup
	mw_customerProfile_updateUI();
} // .end of mw_customerProfile_show

/**
 * Update data on Modal Window.
 */
function mw_customerProfile_updateUI()
{
	mw_customerProfile_init();
	
	// Hide caller modal window
	if (mw_customerProfile_callerSelectorId != '')
		$('#'+mw_customerProfile_callerSelectorId).modal('hide');
	// Show Modal Window
	module_showModalWindow('mw_customerProfile', true);
	
	// Show/hide
	$('#mw_customerProfile_content_spinner').show();
	$('#mw_customerProfile_content_spinner_text').html('loading customer...');
	$('#mw_customerProfile_content').hide();
		
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': true,
		'customerId': mw_customerProfile_customerId
	};

	var params = new Object();

	tycheesdb_api_getCustomerById(requestBody, mw_customerProfile_updateUI_postHandler_step1, params);
} // .end of mw_customerProfile_updateUI

function mw_customerProfile_updateUI_postHandler_step1(success, responseObj, params)
{
	if (success == false)
		return false;	
	
	// Set progressing message
	$('#mw_customerProfile_content_spinner_text').html('loading billings...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_ALL,
		'fullBean': true,
		'customerId': mw_customerProfile_customerId
	};

	// Get object
    mw_customerProfile_customerObj = responseObj.customerObj;
    if (mw_customerProfile_customerObj == null)
    {
    	swal('System Error', 'No customer record found in database.', 'error');
    	return false;
    }
    
	tycheesdb_api_getBillingsByCustomer(requestBody, mw_customerProfile_updateUI_postHandler_step2, params);
} // .end of mw_customerProfile_updateUI_postHandler

function mw_customerProfile_updateUI_postHandler_step2(success, responseObj, params)
{
	if (success == false)
		return false;	
	
	// Set progressing message
	$('#mw_customerProfile_content_spinner_text').html('Setting UI...');
	    
	// Get Billings
	mw_customerProfile_billingList = responseObj.billingList;
	
    // Show Customer
  	mw_customerProfile_showCustomer();
  	    	
   	// Show/Hide
	$('#mw_customerProfile_content_spinner').hide();
	$('#mw_customerProfile_content_spinner_text').html('loading customer...');
	$('#mw_customerProfile_content').show();
} // .end of mw_customerProfile_updateUI_postHandler
	    
function mw_customerProfile_showCustomer()
{    
    // Basic Info
    var profileImageUrl = mw_customerProfile_customerObj.profileImage;
    if ($.trim(profileImageUrl)=='')
    {
        profileImageUrl = 'https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png';
    }

    var dobVal = 'N/A';
    if (isNaN(mw_customerProfile_customerObj.dob)==false && mw_customerProfile_customerObj.dob > 0)
    	dobVal = tycheesDateTime_getFormattedDate_MMMddyyyy(mw_customerProfile_customerObj.dob);
    
    $('#mw_customerProfile_customerImage').attr('src', profileImageUrl);
    $('#mw_customerProfile_customerName').html( mw_customerProfile_customerObj.firstName + ' ' + mw_customerProfile_customerObj.lastName );
    $('#mw_customerProfile_customerDescription').html( tycheesText_getDisplayText(mw_customerProfile_customerObj.description, 0) );
    $('#mw_customerProfile_customerAddress').html( tycheesText_getDisplayText(mw_customerProfile_customerObj.address, 0) );
    $('#mw_customerProfile_customerGender').html( tycheesText_getDisplayText(mw_customerProfile_customerObj.gender, 0) );
    $('#mw_customerProfile_customerDob').html( dobVal );
    $('#mw_customerProfile_customerContact').html( tycheesText_getDisplayText(mw_customerProfile_customerObj.contact, 0) );
    $('#mw_customerProfile_customerEmail').html( tycheesText_getDisplayText(mw_customerProfile_customerObj.email, 0) );
    
    $('#mw_customerProfile_customerCustomFieldList').empty();
	$.each(mw_customerProfile_customerObj.propertiesList, function(index, propertiesObj){
		var htmlLines = '';
		htmlLines += '<li class="list-group-item list-group-item-custom">';
		htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
		htmlLines += '<span style="padding-left:5px;">';
		htmlLines += propertiesObj.propKey;
		htmlLines += '</span>';
		htmlLines += '<span class="pull-right"> ';
		htmlLines += tycheesText_getDisplayText(propertiesObj.propValue, 0);
		htmlLines += ' </span>';
		htmlLines += '</li>';
		
		$('#mw_customerProfile_customerCustomFieldList').append(htmlLines);
	});
	
	// TAB #1: Billings
	$('#mw_customerProfile_dataTable_billing').DataTable().clear().draw();
	$.each(mw_customerProfile_billingList, function(i, billingObj){
		if (billingObj.customerId == mw_customerProfile_customerObj.id) {
		    // COL #1
		    var htmlLines_col1 = '';
		    htmlLines_col1 += tycheesDateTime_getFormattedDate_MMMddyyyy(billingObj.createdOn);
		    htmlLines_col1 += ' ';
		    htmlLines_col1 += tycheesDateTime_getFormattedDate_hhmm(billingObj.createdOn);
		    
		    // COL #2
		    var htmlLines_col2 = '';
		    htmlLines_col2 += tycheesDateTime_getFormattedDate_MMMddyyyy(billingObj.billingDate);

		    // COL #3
		    var isQuotation = $.trim(billingObj.quotationNo) != '';
		    var htmlLines_col3 = 'Order';
		    if (isQuotation)
		    	htmlLines_col3 = 'Quotation';
		    
		    // COL #4
		    var referenceNo = $.trim(billingObj.billingNo);
		    if (isQuotation)
		    	referenceNo = $.trim(billingObj.quotationNo);
		    		
		    var htmlLines_col4 = '';
		    htmlLines_col4 += '<a onclick="mw_customerProfile_openPOS(\'' + billingObj.id + '\')">';
		    htmlLines_col4 += referenceNo;
		    htmlLines_col4 += ' <i class="fa fa-external-link" aria-hidden="true"></i>';
		    htmlLines_col4 += '</a>'
		    
		    // COL #5
		    var htmlLines_col5 = '';
		    htmlLines_col5 += '<span class="pull-right">';
		    htmlLines_col5 += Number(billingObj.totalAmount).toFixed(2);
		    htmlLines_col5 += '</span>';
		    
		    // COL #6
		    var htmlLines_col6 = '';
		    htmlLines_col6 += '<span class="pull-right">';
		    htmlLines_col6 += $.trim(billingObj.stateDesc);
		    htmlLines_col6 += '</span>';
		    
		    var rowSet = [];
		    rowSet.push( htmlLines_col1 );
		    rowSet.push( htmlLines_col2 );
		    rowSet.push( htmlLines_col3 );
		    rowSet.push( htmlLines_col4 );
		    rowSet.push( htmlLines_col5 );
		    rowSet.push( htmlLines_col6 );
		    
		    $('#mw_customerProfile_dataTable_billing').dataTable().fnAddData( rowSet, false );
		}
	});
	// Repaint DataTable UI
	$('#mw_customerProfile_dataTable_billing').DataTable().draw();
    
	// TAB #2: Profiles
	// Sort list, by profileName
    mw_customerProfile_customerObj.profileList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.profileName, b.profileName);
		});
	
	$('#mw_customerProfile_tab_profiles_select').empty();
	$('#mw_customerProfile_tab_profiles_select').append('<option value="0">--- SELECT ---</option>');
	$.each(mw_customerProfile_customerObj.profileList, function(i, profileObj){

		var selectedVal = '';
		var defaultVal = '';
		if (profileObj.defaultProfile==true)
		{
		    defaultVal = ' (Default)';
			selectedVal = 'selected';
		}
		
		var profile_htmlLines = '';
		profile_htmlLines += '<option value="' + profileObj.id + '" ' + selectedVal + '>' + profileObj.profileName + defaultVal + '</option>';		
		$('#mw_customerProfile_tab_profiles_select').append(profile_htmlLines);	
		
	});
	
	// Reload profile's properties by current selection
	mw_customerProfile_reloadProfileProperties();
} // .end of mw_customerProfile_showCustomer
	    
function mw_customerProfile_reloadProfileProperties()
{
	var profileId = $('#mw_customerProfile_tab_profiles_select').val();
	if (profileId == '0')
		return false;
	
	$.each(mw_customerProfile_customerObj.profileList, function(i, profileObj) {
		
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
			$('#mw_customerProfile_profile_propertiesList').empty();
			$.each(sortedList, function(j, propertiesObj){
				
				if (lastGroupName != propertiesObj.groupName)
		    	{
		    	    lastGroupName = propertiesObj.groupName;
		    	    
		    	    var dividerHtmlLines = '';		    	    
		    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding-left:10px;">';
		    	    dividerHtmlLines += lastGroupName;
		    	    dividerHtmlLines += '</li>';
		    	    
		    	    $('#mw_customerProfile_profile_propertiesList').append(dividerHtmlLines);
		    	}
				
				var htmlLines = '';
				htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
				htmlLines += '<span style="height:25px;margin-top:5px;">';
				htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
				htmlLines += propertiesObj.propKey;
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right"> ';
				htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
				htmlLines += '</span>';
				htmlLines += '</li>';
				
				$('#mw_customerProfile_profile_propertiesList').append(htmlLines);
			});
		}
	});
	
} // .end of mw_customerProfile_reloadProfileProperties

function mw_customerProfile_openPOS(billingId)
{
    var billingObj = Cached_getBillingById(billingId);
    
    if (billingObj != null)
    {
        var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING) + '?' + PARAMETER_NAME_OPEN_BY_BILLING_ID + '=' + billingId ;
        window.open(location, '_self');
    }
} // .end of mw_customerProfile_openPOS

</script>