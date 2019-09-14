<!-- CUSTOMER PROFILE DIALOG -->
<div class="modal inmodal fade" id="mw013" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">CUSTOMER PROFILE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-4">
						<div class="ibox-content">
                            <div class="row">
								<div class="col-md-4 col-lg-4 text-center">
	                                <h2><span id="mw013_customerName"></span></h2>
	                                <div class="m-b-sm">
	                                    <img id="mw013_customerImage" alt="image" class="img-circle" src="http://blogs.plos.org/dnascience/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png" style="width: 62px" data-pin-nopin="true">
	                                </div>
	                            </div>
	                            <div class="col-md-8 col-lg-8">
	                                <strong>
	                                    <i class="fa fa-home" aria-hidden="true"></i> Address
	                                </strong>
	                                <p>
	                                    <span id="mw013_customerAddress"></span>
	                                </p>
	                                <p>
	                                    <span id="mw013_customerDescription"></span>
	                                </p>
	                                <button type="button" class="btn btn-primary btn-sm btn-block"><i class="fa fa-envelope"></i> Send Message
	                                </button>
	                            </div>
	                        </div>
                        	<div id="mw013_basicInfo" class="row">
               	                <ul class="list-group clear-list" style="margin:5px 15px 10px 15px;">
                        	        <li class="list-group-item fist-item">
                        	            <span id="mw013_customerGender" class="pull-right"></span>
                        	            <i class="fa fa-venus-mars"></i> <span style="padding-left:5px;">Gender</span>
                        	        </li>
                        	        <li class="list-group-item">
                        	            <i class="fa fa-birthday-cake"></i> <span style="padding-left:5px;">Date of Birth</span>
                        	            <span id="mw013_customerDob" class="pull-right"></span>
                        	        </li>
                        	        <li class="list-group-item">
                        	            <i class="fa fa-phone"></i> <span style="padding-left:5px;">Contact</span>
                        	            <span id="mw013_customerContact" class="pull-right"></span>
                        	        </li>
                        	        <li class="list-group-item">
                        	            <i class="fa fa-envelope"></i> <span style="padding-left:5px;">Email</span>
                        	            <span id="mw013_customerEmail" class="pull-right"></span>
                        	        </li>
                        	        <span id="mw013_customerCustomFieldList">
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
                               	        <a data-toggle="tab" href="mw013_tab_billingList">
                               	        	<i class="fa fa-shopping-bag" aria-hidden="true"></i> Billing History
                               	        </a>
                               	    </li>
                               	    <li>
                               	        <a data-toggle="tab" href="#mw013_tab_profiles">
                               	        	<i class="fa fa-user" aria-hidden="true"></i> Profiles
                               	        </a>
                               	    </li>
                               	</ul>
                       	        <div class="tab-content">
                       	            <div id="mw013_tab_billingList" class="tab-pane active">
                       	            	<br/>
                       	                <table class="table table-striped table-bordered table-hover " id="mw013_dataTable_billing" >
                       	                    <thead>
                       	                        <tr>
                       	                            <th>Created On</th>
                       	                            <th>Billing Date</th>
                       	                            <th>Billing No.</th>
                       	                            <th>Amount</th>
                       	                            <th>Status</th>
                       	                        </tr>
                       	                    </thead>
                       	                    <tbody>
                       	                    </tbody>
                       	                </table>
                       	            </div>
                       	            <div id="mw013_tab_profiles" class="tab-pane">
                       	            	<div class="input-group" style="padding-top:20px; padding-bottom:10px;">
                       	            		<select id="mw013_tab_profiles_select" class="form-control" onchange="mw013_reloadProfile();">
								            </select>
								            <!--
								            <span class="input-group-btn">
								                <button type="button" class="btn btn-info" onclick="mw013_executeAction('mw013_action_cloneProfile');"> 
								                    <i class="fa fa-clone" aria-hidden="true"></i> Clone
								                </button>
								                <button type="button" class="btn btn-primary" onclick="mw013_executeAction('mw013_action_addProfile');">
								                    <i class="fa fa-plus" aria-hidden="true"></i> Add
								                </button>
								                <button type="button" class="btn btn-primary" onclick="mw013_executeAction('mw013_action_editProfile');"> 
								                    <i class="fa fa-pencil" aria-hidden="true"></i> Edit
								                </button>
								                <button type="button" class="btn btn-danger" onclick="mw013_executeAction('mw013_action_deleteProfile');"> 
								                    <i class="fa fa-trash-o" aria-hidden="true"></i> Delete
								                </button>
								            </span>
								            -->
								        </div>
								            <!--
								        <div>
											<button type="button" class="btn btn-info btn-xs" onclick="mw013_executeAction('mw013_action_addProperties');">
												<i class="fa fa-plus" aria-hidden="true"></i> Add Properties
											</button>								        	
								        </div>
								            -->
                       	                <ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
                       	                	<span id="mw013_profile_propertiesList">
	                            	        </span>
                       	                </ul>
                       	            </div>
                       	        </div><!-- .end of tab-content -->
	                       	</div>
	                    </div><!-- .end of tab-content -->
					</div>
				</div> <!-- .end of row -->					
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var mw013_initializing = false;
var mw013_initialized = false;
var mw013_customerObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw013_isOpen()
{
	return ($("#mw013").data('bs.modal') || {}).isShown;	
} // .end of mw013_isOpen

function mw013_init()
{
	if (mw013_initialized==true)
		return false;
	
    mw013_initialized = true;
}

/**
 * Initiate data into modal window.
 */
function mw013_open(itemId)
{	
	mw013_init();
	
} // .end of mw013_open

/**
 * Update data on Modal Window.
 */
function mw013_updateUI()
{
	tycheesOverlay_startShortProgress('loading customer...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_POS,
		'fullBean': true,
		'customerId': global_billingObj.customerId
	};

	var params = new Object();

	tycheesdb_api_getCustomerById(requestBody, mw013_updateUI_postHandler, params);
} // .end of mw013_updateUI

function mw013_updateUI_postHandler(success, responseObj, params)
{
	tycheesOverlay_stopShortProgress();
	
	if (success == false)
		return false;	
	
	// Get object
    mw013_customerObj = responseObj.customerObj;
    if (mw013_customerObj == null)
    {
    	swal('System Error', 'No customer record found in database.', 'error');
    	return false;
    }
    
    // Show Customer
  	mw013_showCustomer(global_billingObj.customerId);
  	    	
    // Show Modal Window on Top
    module_showModalWindow('mw013', true);
} // .end of mw013_updateUI_postHandler

/**
 * Show modal window.
 */
function mw013_show() 
{
	mw013_updateUI();
} // .end of show_mw013

	    
function mw013_showCustomer()
{
    // Get object
    //mw013_customerObj = Cached_getCustomerById(customerId);
    
    // Check existence of customer object
    //if (mw013_customerObj == null)
    //{
    //	swal('System Error', 'No customer record found in database.', 'error');
    //	return false;
    //}
    
    // Basic Info
    var profileImageUrl = mw013_customerObj.profileImage;
    if ($.trim(profileImageUrl)=='')
    {
        profileImageUrl = 'http://blogs.plos.org/dnascience/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png';
    }

    var dobVal = 'N/A';
    if (isNaN(mw013_customerObj.dob)==false && mw013_customerObj.dob > 0)
    	dobVal = tycheesDateTime_getFormattedDate_MMMddyyyy(mw013_customerObj.dob);
    
    $('#mw013_customerImage').attr('src', profileImageUrl);
    $('#mw013_customerName').html( mw013_customerObj.firstName + ' ' + mw013_customerObj.lastName );
    $('#mw013_customerDescription').html( tycheesText_getDisplayText(mw013_customerObj.description, 0) );
    $('#mw013_customerAddress').html( tycheesText_getDisplayText(mw013_customerObj.address, 0) );
    $('#mw013_customerGender').html( tycheesText_getDisplayText(mw013_customerObj.gender, 0) );
    $('#mw013_customerDob').html( dobVal );
    $('#mw013_customerContact').html( tycheesText_getDisplayText(mw013_customerObj.contact, 0) );
    $('#mw013_customerEmail').html( tycheesText_getDisplayText(mw013_customerObj.email, 0) );
    
    $('#mw013_customerCustomFieldList').empty();
	$.each(mw013_customerObj.propertiesList, function(index, propertiesObj){
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
		
		$('#mw013_customerCustomFieldList').append(htmlLines);
	});
	
	// TAB #1: Billings
	$('#mw013_dataTable_billing').DataTable().clear().draw();
	$.each(Cached_getBillingList(), function(i, billingObj){
		if (billingObj.customerId==mw013_customerObj.id)
		{
		    // COL #1
		    var htmlLines_col1 = '';
		    htmlLines_col1 += tycheesDateTime_getFormattedDate_MMMddyyyy(billingObj.createdOn);
		    htmlLines_col1 += ' ';
		    htmlLines_col1 += tycheesDateTime_getFormattedDate_hhmm(billingObj.createdOn);
		    
		    // COL #2
		    var htmlLines_col2 = '';
		    htmlLines_col2 += tycheesDateTime_getFormattedDate_MMMddyyyy(billingObj.billingDate);
		    
		    // COL #3
		    var htmlLines_col3 = '';
		    htmlLines_col3 += '<a onclick="mw013_openPOS(\'' + billingObj.id + '\')">';
		    htmlLines_col3 += billingObj.billingNo;
		    htmlLines_col3 += ' <i class="fa fa-external-link" aria-hidden="true"></i>';
		    htmlLines_col3 += '</a>'
		    
		    // COL #4
		    var htmlLines_col4 = '';
		    htmlLines_col4 += Number(billingObj.totalAmount).toFixed(2);
		    
		    // COL #5
		    var htmlLines_col5 = '';
		    htmlLines_col5 += billingObj.stateDesc;
		    
		    var rowSet = [];
		    rowSet.push( htmlLines_col1 );
		    rowSet.push( htmlLines_col2 );
		    rowSet.push( htmlLines_col3 );
		    rowSet.push( htmlLines_col4 );
		    rowSet.push( htmlLines_col5 );
		    
		    $('#mw013_dataTable_billing').dataTable().fnAddData( rowSet, false );
		}
	});
	
	$('#mw013_dataTable_billing').DataTable().draw();
    
	// TAB #2: Profiles
	// Sort list, by profileName
    mw013_customerObj.profileList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.profileName, b.profileName);
		});
	
	$('#mw013_tab_profiles_select').empty();
	$('#mw013_tab_profiles_select').append('<option value="0">--- SELECT ---</option>');
	$.each(mw013_customerObj.profileList, function(i, profileObj){

		var selectedVal = '';
		var defaultVal = '';
		if (profileObj.defaultProfile==true)
		{
		    defaultVal = ' (Default)';
			selectedVal = 'selected';
		}
		
		var profile_htmlLines = '';
		profile_htmlLines += '<option value="' + profileObj.id + '" ' + selectedVal + '>' + profileObj.profileName + defaultVal + '</option>';		
		$('#mw013_tab_profiles_select').append(profile_htmlLines);	
		
	});
	
	// Reload profile's properties by current selection
	mw013_reloadProfile();
} // .end of mw013_showCustomer
	    
function mw013_reloadProfile()
{
	var profileId = $('#mw013_tab_profiles_select').val();
	if (profileId == '0')
		return false;
	
	$.each(mw013_customerObj.profileList, function(i, profileObj) {
		
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
			$('#mw013_profile_propertiesList').empty();
			$.each(sortedList, function(j, propertiesObj){
				
				if (lastGroupName != propertiesObj.groupName)
		    	{
		    	    lastGroupName = propertiesObj.groupName;
		    	    
		    	    var dividerHtmlLines = '';		    	    
		    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding-left:10px;">';
		    	    dividerHtmlLines += lastGroupName;
		    	    dividerHtmlLines += '</li>';
		    	    
		    	    $('#mw013_profile_propertiesList').append(dividerHtmlLines);
		    	}
				
				var htmlLines = '';
				htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
				htmlLines += '<span style="height:25px;margin-top:5px;">';
				htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
				htmlLines += propertiesObj.propKey;
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
				//htmlLines += '<span style="padding-left:10px;padding-right:5px;">';
				//htmlLines += '<i class="fa fa-pencil" aria-hidden="true" style="cursor:pointer;" onclick="mw013_executeAction(\'' + MW013_ACTION_EDIT_PROPERTIES + '\',\'' + propertiesObj.id  + '\');"></i>';
				//htmlLines += '</span>';
				//htmlLines += '<span style="padding-left:5px;padding-right:10px;">';
				//htmlLines += '<i class="fa fa-times-circle" aria-hidden="true" style="cursor:pointer;color:#ff0000;" onclick="mw013_executeAction(\'' + MW013_ACTION_DELETE_PROPERTIES + '\',\'' + propertiesObj.id  + '\');"></i>'; 
				//htmlLines += '</span>';
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right"> ';
				htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
				htmlLines += '</span>';
				htmlLines += '</li>';
				
				$('#mw013_profile_propertiesList').append(htmlLines);
			});
		}
	});
	
} // .end of mw013_reloadProfile

function mw013_openPOS(billingId)
{
    var billingObj = Cached_getBillingById(billingId);
    
    if (billingObj != null)
    {
        var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING) + '?' + PARAMETER_NAME_OPEN_BY_BILLING_ID + '=' + billingId ;
        window.open(location, '_self');
    }
} // .end of mw013_openPOS


/**
 * Common Action Delegate
 */
function mw013_executeAction(actionName, params)
{
/*
    if (actionName == MW013_ACTION_CLONE_PROFILE)
    {
    	var selectedProfileId = $('#mw013_tab_profiles_select').val();
        mw013_mw007_show( selectedProfileId );
    } // .end of MW013_ACTION_ADD_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == MW013_ACTION_ADD_PROFILE)
    {
        mw013_mw003_show();
    } // .end of MW013_ACTION_ADD_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == MW013_ACTION_EDIT_PROFILE)
    {
    	var selectedProfileId = $('#mw013_tab_profiles_select').val();
        mw013_mw004_show( selectedProfileId );
    } // .end of MW013_ACTION_EDIT_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == MW013_ACTION_DELETE_PROFILE)
    {
    	var profileId = $('#mw013_tab_profiles_select').val();
    	
    	swal({
    		  title: "Are you sure?",
    		  text: "You will not be able to recover this profile record!",
    		  type: "warning",
    		  showCancelButton: true,
    		  confirmButtonColor: "#DD6B55",
    		  confirmButtonText: "Yes, delete it!",
    		  cancelButtonText: "No, cancel plx!",
    		  closeOnConfirm: true,
    		  closeOnCancel: true
    		},
    		function(isConfirm) {
    		  	if (isConfirm) 
    		  	{
    		  		$.each(mw013_customerObj.profileList, function(i, profileObj){
    		  			if (profileObj.id == profileId)
    		  			{
    		  			    Cached_deleteBean(profileObj);
    	    		  		
    	    		  		// Save to IndexedDB
    	    		    	tycheesIO_saveBean(mw013_customerObj);
    	    		  		// Refresh UI
    	    		    	mw013_showCustomer(mw013_customerObj.id);
    		  			}
    		  		});
    		  	}
    		});
    } // .end of MW013_ACTION_DELETE_PROFILE
    else
    //--------------------------------------------------------------------------
    if (actionName == MW013_ACTION_ADD_PROPERTIES)
    {
        var selectedProfileId = $('#mw013_tab_profiles_select').val();
        mw013_mw005_show( selectedProfileId );
    } // .end of MW013_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == MW013_ACTION_EDIT_PROPERTIES)
    {
    	var profileId = $('#mw013_tab_profiles_select').val();
		var propertiesId = params;
		
        mw013_mw006_show(profileId, propertiesId);
    } // .end of MW013_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == MW013_ACTION_DELETE_PROPERTIES)
    {
		var profileId = $('#mw013_tab_profiles_select').val();
		var propertiesId = params;
    	
    	swal({
    		  title: "Are you sure?",
    		  text: "You will not be able to recover this properties record!",
    		  type: "warning",
    		  showCancelButton: true,
    		  confirmButtonColor: "#DD6B55",
    		  confirmButtonText: "Yes, delete it!",
    		  cancelButtonText: "No, cancel plx!",
    		  closeOnConfirm: true,
    		  closeOnCancel: true
    		},
    		function(isConfirm) {
    		  	if (isConfirm) 
    		  	{
    		  		var profileObj = Cached_getCustomerProfileById(mw013_customerObj.id, profileId);
    		  		
    		  		$.each(profileObj.propertiesList, function(i, propObj){
    		  			if (propObj.id == propertiesId)
    		  			{
    		  			    Cached_deleteBean(propObj);
    	    		  		
    	    		  		// Save to IndexedDB
    	    		    	tycheesIO_saveBean(mw013_customerObj);
    	    		  		// Refresh UI
    	    		    	mw013_showCustomer(mw013_customerObj.id);
    		  			}
    		  		});
    		  	}
    		});
    } // .end of MW013_ACTION_ADD_CUSTOMER
    */
} // .end of mw013_executeAction

</script>