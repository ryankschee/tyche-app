<!-- REL001_02: Customer -->
<div id="rel001_20" style="display:none;">
	<!--
    <div class="mail-box-header">
        <h2>
            <i class="fa fa-user" aria-hidden="true"></i> USER MANAGEMENT
        </h2>
    </div>
    -->
    <input type="hidden" id="rel001_20_userId" value="">
    
    <div class="row">
        <div class="col-sm-12">	                    
            <div class="ibox float-e-margins" style="margin-top:4px;">
            	<div class="ibox-title" style="border:0px;">
                    <!-- Toolbar: BEGIN -->
                	<div class="note-toolbar btn-toolbar">
                		<div class="note-font btn-group">
                			<button id="rel001_20_menu_addUser" type="button" class="btn btn-info" tabindex="-1" onclick="rel001_20_executeAction('rel001_20_action_addUser');">
                				<i class="fa fa-plus" aria-hidden="true"></i>
                				Add User
                			</button>
                		</div>
                	</div>
               	</div> <!-- .end of ibox-title -->
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover " id="rel001_20_dataTable_user" >
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Full Name</th>
                                <th>Contact</th>
                                <th>Email</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="rel001_20_dataTable_userList">	                                                    
                        </tbody>
                    </table>
                </div>
            </div>  
        </div>
        <div class="col-sm-5">
            <div class="ibox" id="rel001_20_user_frame" style="display:none; margin-top:4px;">
                <div class="ibox-content">
                    <div class="tab-content">	  
                        <div class="tab-pane active">
	                        <div>
	                            <div class="row m-b-lg">
                                    <div class="col-lg-4 text-center">
                                        <h2><span id="rel001_20_user_name"></span></h2>
                                        <div class="m-b-sm">
                                            <img id="rel001_20_user_image" alt="image" class="img-circle" src="https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png" style="width: 62px" data-pin-nopin="true">
                                        </div>
                                    </div>
                                    <div class="col-lg-8">
                                        <strong>
                                            <i class="fa fa-home" aria-hidden="true"></i> Address
                                        </strong>
                                        <p>
                                            <span id="rel001_20_user_address"></span>
                                        </p>
                                        <p>
                                            <span id="rel001_20_user_description"></span>
                                        </p>
                                        <button type="button" class="btn btn-primary btn-sm btn-block"><i class="fa fa-envelope"></i> Send Message
                                        </button>
                                    </div>
                                </div>
                        	</div>
	
							<div>
                               	<ul class="nav nav-tabs">
                               	    <li class="active">
                               	        <a data-toggle="tab" href="#rel001_20_tab_basicInfo">
                               	        	<i class="fa fa-info-circle" aria-hidden="true"></i> Basic Info
                               	        </a>
                               	    </li>
                               	    <li>
                               	        <a data-toggle="tab" href="#rel001_20_tab_profiles">
                               	        	<i class="fa fa-user" aria-hidden="true"></i> Profiles
                               	        </a>
                               	    </li>
                               	    <li>
                               	        <a data-toggle="tab" href="#rel001_20_tab_orderList">
                               	        	<i class="fa fa-shopping-bag" aria-hidden="true"></i> Billing History
                               	        </a>
                               	    </li>
                               	</ul>
                       	        <div class="tab-content">
                       	        	<div id="rel001_20_tab_basicInfo" class="tab-pane active">
                       	                <ul class="list-group clear-list" style="margin:5px 0px 10px 0px;">
	                            	        <li class="list-group-item fist-item">
	                            	            <span id="rel001_20_user_gender" class="pull-right"></span>
	                            	            <i class="fa fa-venus-mars"></i> <span style="padding-left:5px;">Gender</span>
	                            	        </li>
	                            	        <li class="list-group-item">
	                            	            <i class="fa fa-birthday-cake"></i> <span style="padding-left:5px;">Date of Birth</span>
	                            	            <span id="rel001_20_user_dob" class="pull-right"></span>
	                            	        </li>
	                            	        <li class="list-group-item">
	                            	            <i class="fa fa-phone"></i> <span style="padding-left:5px;">Contact</span>
	                            	            <span id="rel001_20_user_phone" class="pull-right"></span>
	                            	        </li>
	                            	        <li class="list-group-item">
	                            	            <i class="fa fa-envelope"></i> <span style="padding-left:5px;">Email</span>
	                            	            <span id="rel001_20_user_email" class="pull-right"></span>
	                            	        </li>
	                            	        <span id="rel001_20_user_customFieldList">
	                            	        </span>
	                            	    </ul>
                       	            </div>
                       	            <div id="rel001_20_tab_profiles" class="tab-pane">
                       	            	<div class="input-group" style="padding-top:20px; padding-bottom:10px;">
                       	            		<select id="rel001_20_tab_profiles_select" class="form-control" onchange="rel001_20_reloadProfile();">
								            </select>
								            <span class="input-group-btn">
								                <button type="button" class="btn btn-info" onclick="rel001_20_executeAction('rel001_20_action_cloneProfile');"> 
								                    <i class="fa fa-clone" aria-hidden="true"></i> Clone
								                </button>
								                <button type="button" class="btn btn-primary" onclick="rel001_20_executeAction('rel001_20_action_addProfile');">
								                    <i class="fa fa-plus" aria-hidden="true"></i>
								                </button>
								                <button type="button" class="btn btn-primary" onclick="rel001_20_executeAction('rel001_20_action_editProfile');"> 
								                    <i class="fa fa-pencil" aria-hidden="true"></i>
								                </button>
								                <button type="button" class="btn btn-danger" onclick="rel001_20_executeAction('rel001_20_action_deleteProfile');"> 
								                    <i class="fa fa-trash-o" aria-hidden="true"></i>
								                </button>
								            </span>
								        </div>
								        <div>
											<button type="button" class="btn btn-info btn-xs" onclick="rel001_20_executeAction('rel001_20_action_addProperties');">
												<i class="fa fa-plus" aria-hidden="true"></i> Add Properties
											</button>								        	
								        </div>
                       	                <ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
                       	                	<span id="rel001_20_customer_propertiesList">
	                            	        </span>
                       	                </ul>
                       	            </div>
                       	            <div id="rel001_20_tab_orderList" class="tab-pane">
                       	            	<br/>
                       	                <table class="table table-striped table-bordered table-hover " id="rel001_20_dataTable_billing" >
                       	                    <thead>
                       	                        <tr>
                       	                            <th>Created On</th>
                       	                            <th>Billing Date</th>
                       	                            <th>Billing No</th>
                       	                            <th>Amount</th>
                       	                            <th>Status</th>
                       	                        </tr>
                       	                    </thead>
                       	                    <tbody>
                       	                    </tbody>
                       	                </table>
                       	            </div>
                       	        </div>
                       	    </div> <!-- .end of tab-content -->
                       	</div>
                    </div><!-- .end of tab-content -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CUSTOMER CREATE WIZARD -->
<%@include file="/console/relation/rel001/view/rel001_20/rel001_20_mw001.jsp" %>
<!-- CUSTOMER EDITOR -->
<%@include file="/console/relation/rel001/view/rel001_20/rel001_20_mw002.jsp" %>

<script>

var initialized = false;
var rel001_20_userObj;

/*******************************************************************************
 * Init Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_20_init()
{
    if (initialized == true)
        return false;
        
    $("#rel001_20_dataTable_user").DataTable({
        "displayLength": 10,
    	"order": [[0, "asc"],[1, "asc"]]
    });
	
	initialized = true;
} // .end of rel001_20_init

/*******************************************************************************
 * Show CRM Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_20_updateUI()
{
    rel001_20_init();
    
    // Remove any existing records
   	$("#rel001_20_dataTable_user").DataTable().clear().draw();
   	
   	// Populate records as table row & frame
 	$.each(Cached_getUserList(), function(index, userObj) {	
 	
 	    if (userObj != null)
 	    {
    		rel001_20_updateUI_addUserIntoDataTable(userObj);
 	    }
  	});
  	
  	// Redraw Table
  	$("#rel001_20_dataTable_user").DataTable().draw();
  	
  	// Refresh currently selected 
  	var userId = $('#rel001_20_userId').val();
  	if ($.trim(customerId) != '')
  	    rel001_20_showUser(userId);
  	
    $('#rel001_20').show();
} // .end of rel001_20_updateUI

/*******************************************************************************
 * Hide CRM Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_20_hide()
{
    $('#rel001_20_user_frame').hide();
    $('#rel001_20').hide();
} // .end of rel001_20_updateUI

/*******************************************************************************
 * Common Action Delegate
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_20_executeAction(actionName, params)
{
    if (actionName == REL001_02_ACTION_ADD_CUSTOMER)
    {
        rel001_20_mw001_show();
    } // .end of REL001_02_ACTION_ADD_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_EDIT_CUSTOMER)
    {
        var customerId = '';
        if (params==null) 
        {
            customerId = $('#rel001_20_userId').val();
        }
        else
        {
            customerId = params;
        }
        
        var customerObj = Cached_getCustomerById(customerId);
        if (customerObj != null)
        {
            rel001_20_mw002_open(customerId);
        }
    } // .end of REL001_02_ACTION_EDIT_CUSTOMER
    else
    //--------------------------------------------------------------------------
    if (actionName == REL001_02_ACTION_DELETE_CUSTOMER)
    {
        var customerId = '';
        if (params==null) 
        {
            customerId = $('#rel001_20_userId').val();
        }
        else
        {
            customerId = params;
        }
        
        var customerObj = Cached_getCustomerById(customerId);
        if (customerObj != null)
        {
            swal({
                title: "Are you sure?",
                text: "You will not be able to recover this customer!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: true
            }, 
            function () {
                
            	// Delete object from local list
            	Cached_deleteCustomerById(customerId);
                
            	// Update UI
            	rel001_20_updateUI();
            	
                // Delete from localDB
                Cached_deleteBean(customerObj);
            	tycheesIO_saveBean(customerObj);
            	
                // Show message
                swal("Deleted!", "Customer record has been deleted.", "success");
            });
        }
    } // .end of REL001_02_ACTION_DELETE_CUSTOMER
} // .end of rel001_20_executeAction

function rel001_20_reloadProfile()
{
	var profileId = $('#rel001_20_tab_profiles_select').val();
	var customerObj = Cached_getCustomerById( $('#rel001_20_userId').val() );
	
	$.each(customerObj.profileList, function(i, profileObj){
		
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
			$('#rel001_20_customer_propertiesList').empty();
			$.each(sortedList, function(j, propertiesObj){
				
				if (lastGroupName != propertiesObj.groupName)
		    	{
		    	    lastGroupName = propertiesObj.groupName;
		    	    
		    	    var dividerHtmlLines = '';		    	    
		    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding-left:10px;">';
		    	    dividerHtmlLines += lastGroupName;
		    	    dividerHtmlLines += '</li>';
		    	    
		    	    $('#rel001_20_customer_propertiesList').append(dividerHtmlLines);
		    	}
				
				var htmlLines = '';
				htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
				htmlLines += '<span style="height:25px;margin-top:5px;">';
				htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
				htmlLines += propertiesObj.propKey;
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
				htmlLines += '<span style="padding-left:10px;padding-right:5px;">';
				htmlLines += '<i class="fa fa-pencil" aria-hidden="true" style="cursor:pointer;" onclick="rel001_20_executeAction(\'' + REL001_02_ACTION_EDIT_PROPERTIES + '\',\'' + propertiesObj.id  + '\');"></i>';
				htmlLines += '</span>';
				htmlLines += '<span style="padding-left:5px;padding-right:10px;">';
				htmlLines += '<i class="fa fa-times-circle" aria-hidden="true" style="cursor:pointer;color:#ff0000;" onclick="rel001_20_executeAction(\'' + REL001_02_ACTION_DELETE_PROPERTIES + '\',\'' + propertiesObj.id  + '\');"></i>'; 
				htmlLines += '</span>';
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right"> ';
				htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
				htmlLines += '</span>';
				htmlLines += '</li>';
				
				$('#rel001_20_customer_propertiesList').append(htmlLines);
			});
		}
	});
	
} // .end of rel001_20_reloadProfile

/**
 * Add user details as table row into DataTable.
 *
 * @param   {CustomerBean} customerObj - Customer Object
 */
function rel001_20_updateUI_addUserIntoDataTable(userObj) 
{	
    if (userObj == null)
        return false;
        
    // Col #1
	var profileImage = userObj.profileImageUrl;
	if ($.trim(profileImage)=='')
		profileImage = 'https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png';
	var htmlLines_col1 = '';
	htmlLines_col1 += '<span class="client-avatar" style="padding-right:5px;">';
	htmlLines_col1 += '<img alt="image" src="' + profileImage + '">'; 
	htmlLines_col1 += '</span>';
	htmlLines_col1 += '<a onclick="rel001_20_showUser(\'' + userObj.id +'\');" class="client-link">';
	htmlLines_col1 += (userObj.firstName + ' ' + userObj.lastName);
	htmlLines_col1 += '</a>';
	
	// Col #2
	var htmlLines_col2 = '';
	htmlLines_col2 += '<i class="fa fa-id-card-o" aria-hidden="true"></i> ';
	htmlLines_col2 += '<a onclick="rel001_20_showUser(\'' + userObj.id +'\');" class="client-link">';
	htmlLines_col2 += $.trim(userObj.gender)=='' ? 'N/A' : $.trim(userObj.gender);
	htmlLines_col2 += '</a>';
	
	// Col #3
	var htmlLines_col3 = '';
	htmlLines_col3 += '<i class="fa fa-phone" aria-hidden="true"></i> ';
	htmlLines_col3 += $.trim(userObj.contact)=='' ? 'N/A' : $.trim(userObj.contact);
	
	// Col #4
	var htmlLines_col4 = '';
	htmlLines_col4 += '<i class="fa fa-envelope-o" aria-hidden="true"></i> ';
	htmlLines_col4 += $.trim(userObj.email)=='' ? 'N/A' : $.trim(userObj.email);
	
	// Col #5
	var htmlLines_col5 = '';
	htmlLines_col5 += '<a onclick="rel001_20_executeAction(\'' + REL001_20_ACTION_EDIT_USER + '\',\'' + userObj.id + '\');" class="btn btn-primary btn-xs">';
	htmlLines_col5 += '<i class="fa fa-pencil" aria-hidden="true"></i>';
	htmlLines_col5 += '</a> ';
	htmlLines_col5 += '<a onclick="rel001_20_executeAction(\'' + REL001_20_ACTION_DELETE_USER + '\',\'' + userObj.id + '\');" class="btn btn-danger btn-xs">';
	htmlLines_col5 += '<i class="fa fa-times" aria-hidden="true"></i>';
	htmlLines_col5 += '</a>';
	
    var tableRow = [];
	tableRow.push(htmlLines_col1);
	tableRow.push(htmlLines_col2);
	tableRow.push(htmlLines_col3);
	tableRow.push(htmlLines_col4);
	tableRow.push(htmlLines_col5);
	
	$('#rel001_20_dataTable_user').dataTable().fnAddData( tableRow, false );
} // .end of rel001_20_updateUI_addCustomerIntoDataTable
	    
/**
 * Display customer details on customer pane (right-most pane).
 */
function rel001_20_showUser(userId, profileId)
{
    // Set selected customerId to page scope
    $('#rel001_20_userId').val(customerId);
    // Get customer object
    rel001_20_customerObj = Cached_getCustomerById(customerId);
    
    if (rel001_20_customerObj==null) 
    {
    	$('#rel001_20_customer_frame').hide();
    	tycheesLogger_logError('Invalid customerId found. (id='+customerId+')', 'rel001_20_showCustomer');
    	return false;
    }
    
    // TAB #1: Basic Info
    var profileImageUrl = rel001_20_customerObj.profileImage;
    if (profileImageUrl==null || profileImageUrl.length==0)
    {
        profileImageUrl = 'https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png';
    }
    
    $('#rel001_20_customer_image').attr('src', profileImageUrl);
    $('#rel001_20_customer_name').html( rel001_20_customerObj.firstName + ' ' + rel001_20_customerObj.lastName );
    $('#rel001_20_customer_description').html( tycheesText_getDisplayText(rel001_20_customerObj.description, 0) );
    $('#rel001_20_customer_address').html( tycheesText_getDisplayText(rel001_20_customerObj.address, 0) );
    $('#rel001_20_customer_gender').html( tycheesText_getDisplayText(rel001_20_customerObj.gender, 0) );
    $('#rel001_20_customer_dob').html( tycheesDateTime_getFormattedDate_MMMddyyyy(rel001_20_customerObj.dob) );
    $('#rel001_20_customer_phone').html( tycheesText_getDisplayText(rel001_20_customerObj.contact, 0) );
    $('#rel001_20_customer_email').html( tycheesText_getDisplayText(rel001_20_customerObj.email, 0) );
    
    $('#rel001_20_customer_customFieldList').empty();
	$.each(rel001_20_customerObj.propertiesList, function(index, propertiesObj){
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
		
		$('#rel001_20_customer_customFieldList').append(htmlLines);
	});
	
	// TAB #2: Profiles
	// Sort list, by profileName
    rel001_20_customerObj.profileList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.profileName, b.profileName);
		});
	
	$('#rel001_20_tab_profiles_select').empty();
	$.each(rel001_20_customerObj.profileList, function(i, profileObj){
		
		var defaultVal = '';
		if (profileObj.defaultProfile==true)
		    defaultVal = ' (Default)';
		
		var selectedVal = '';
		if (profileId != null && profileId==profileObj.id)
			selectedVal = 'selected';
		
		var profile_htmlLines = '';
		profile_htmlLines += '<option value="' + profileObj.id + '" ' + selectedVal + '>' + profileObj.profileName + defaultVal + '</option>';		
		$('#rel001_20_tab_profiles_select').append(profile_htmlLines);	
		
	});
	// Reload profile's properties by current selection
	rel001_20_reloadProfile();
	
	// TAB #3: Billings
	$('#rel001_20_dataTable_billing').DataTable().clear().draw();
	$.each(Cached_getBillingList(APP_NAME_RELATION, false), function(i, billingObj){
		if (billingObj.customerId==customerId)
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
		    htmlLines_col3 += '<a onclick="rel001_20_executeAction(\'' + REL001_02_ACTION_OPEN_POS_BY_BILLING + '\',\'' + billingObj.id + '\')">';
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
		    
		    $('#rel001_20_dataTable_billing').dataTable().fnAddData( rowSet, false );
		}
	});
	
	$('#rel001_20_dataTable_billing').DataTable().draw();
    
    $('#rel001_20_customer_frame').show();
} // .end of rel001_20_showCustomer
	    
</script>