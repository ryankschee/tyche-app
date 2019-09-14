<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- set001_20_05: Manage Users - User List -->
<div id="set001_20_05" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
        APPROVED USERS
	</span>
    <div class="ibox-content">
       	<button class="btn btn-sm btn-primary" type="button" onclick="set001_20_05_addUser();"><i class="fa fa-plus" aria-hidden="true"></i> Add User</button>
        <div class="col-md-6 input-group pull-right">
            <input id="set001_20_05_searchFilter" type="text" class="form-control input-sm" name="search" placeholder="Search user" oninput="set001_20_05_search();">
            <div class="input-group-btn">
                <button type="button" class="btn btn-sm btn-grey" onclick="set001_20_05_resetSearch();">
                    Reset
                </button>
            </div>
        </div>    
    </div>      
    <div class="mail-box">
    	
        <div id="set001_20_05_spinner" class="spiner-example">
			<div class="sk-spinner sk-spinner-wave">
			    <div class="sk-rect1"></div>
			    <div class="sk-rect2"></div>
			    <div class="sk-rect3"></div>
			    <div class="sk-rect4"></div>
			    <div class="sk-rect5"></div>
			</div>
		    <div id="set001_20_05_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
		</div>
        <table id="set001_20_05_table" class="table table-hover table-mail" style="margin-bottom:0px;">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td class="table-thead-td" width="auto">NAME</td>
                    <td class="table-thead-td" width="auto">EMAIL</td>
                    <td class="table-thead-td" width="auto">ASSIGNED ROLE</td>
                    <td class="table-thead-td" width="180px">ACTIONS</td>
                </tr>
            </thead>
            <tbody id="set001_20_05_tableContent">
            </tbody>
        </table>
    </div>
</div>

<!-- MODAL WINDOW: New User -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_05_mw001.jsp" %>
<!-- MODAL WINDOW: Edit User -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_05_mw002.jsp" %>
<!-- MODAL WINDOW: Reset Password -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_05_mw003.jsp" %>

<script>

var set001_20_05_initialized = false;

function set001_20_05_init()
{
    if (set001_20_05_initialized == true)
        return false;
            
	set001_20_05_initialized = true;
} // .end of set001_20_05_init

function set001_20_05_updateUI()
{
	// Init, if any
    set001_20_05_init();
    // Show UI
    $('#set001_20_05').show();
    // Show/Hide Progress
    $('#set001_20_05_spinner').show();
    $('#set001_20_05_table').hide();
        
    var requestBody = new Object();    
    var params = new Object();
    
    tycheesdb_api_getUsersByPlace(requestBody, set001_20_05_updateUI_postHandler, params);
} // .end of set001_20_05_updateUI

function set001_20_05_updateUI_postHandler(success, responseObj, params)
{
	if (!success)
		return false;
	
	// Get filtering text
	var searchText = $.trim( $('#set001_20_05_searchFilter').val() );

    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userList = responseObj.userList;
    
    // Sort
    placeObj.roleList.sort(function(a, b) {
    	var userObjA = Cached_getUserById(a.userId, userList);
    	var userObjB = Cached_getUserById(b.userId, userList);
    	if (userObjA==null || userObjB==null)
    		return 0;
    	
    	var fullNameA = userObjA.firstName + ' ' + userObjA.lastName; 
    	var fullNameB = userObjB.firstName + ' ' + userObjB.lastName;    	
    	
		if (fullNameA < fullNameB) return -1;
		if (fullNameA > fullNameB) return 1;
		return 0;
	});
    
    // Empty table
    $('#set001_20_05_tableContent').empty();    
    $.each(placeObj.roleList, function(i, roleObj){
    
    	if (Cached_isDeletedBean(roleObj))
    		return true;
    	
    	var userObj = Cached_getUserById(roleObj.userId, userList);
    	if (userObj == null)
    		return true;
    	
    	var fullName = userObj.firstName + ' ' + userObj.lastName;    	
    	if (fullName.toLowerCase().indexOf(searchText.toLowerCase()) < 0)
    		return true;
    	
        var htmlLines = '';
       	htmlLines += '<tr class="read">';
       	
       	// COL #1
   		htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
   		htmlLines += fullName;
   		htmlLines += '</td>';
   		
   		// COL #2
   		htmlLines += '<td class="mail-subject" style="vertical-align:middle;">';
   		htmlLines += userObj.email;
   		htmlLines += '</td>';
   		
   		// COL #3
   		htmlLines += '<td class="mail-date">';
   		if (userObj.id == tycheesCommon_getCurrentUserId())
   			htmlLines += '<select class="form-control" id="role-' + userObj.id + '" disabled>';
		else
   			htmlLines += '<select class="form-control" id="role-' + userObj.id + '">';
   		
   		$.each(placeObj.accessList, function(j, accessObj){
   	    	if (Cached_isDeletedBean(accessObj))
   	    		return true;   	    	
   		    if ($.trim(accessObj.roleName) == $.trim(roleObj.role))
   		        htmlLines += '<option value="' + accessObj.roleName + '" selected>' + accessObj.roleName + '</option>';
   		    else
   		        htmlLines += '<option value="' + accessObj.roleName + '">' + accessObj.roleName + '</option>';
   		});
   		
   		htmlLines += '</select>';
   		htmlLines += '</td>';
   		
   		// COL #4
   		var buttonVal_editUser = '';
   		var buttonVal_deleteUser = '';
   		var buttonVal_resetPassword = '';
   		if (userObj.id != tycheesCommon_getCurrentUserId()) 
   		{
   			buttonVal_resetPassword += '<a id="set001_20_05_resetPasswordButton_' + userObj.id + '" onclick="set001_20_05_resetPassword(\'' + userObj.id + '\');" href="#" class="btn btn-primary btn-xs ladda-button" data-style="zoom-in" style="color:#FFF; margin-right:3px;">';
   			buttonVal_resetPassword += 'Reset Password';
   			buttonVal_resetPassword += '</a>';
    		
   			buttonVal_editUser += '<a id="set001_20_05_editUserButton_' + userObj.id + '" onclick="set001_20_05_editUser(\'' + userObj.id + '\');" href="#" class="btn btn-primary btn-xs ladda-button" data-style="zoom-in" style="color:#FFF; margin-right:3px;">';
    		buttonVal_editUser += '<i class="fa fa-pencil" aria-hidden="true"></i></a>';
    		buttonVal_editUser += '</a>';
   			
    		buttonVal_deleteUser += '<a id="set001_20_05_deleteUser_' + userObj.id + '" onclick="set001_20_05_deleteUser(\'' + userObj.id + '\');" href="#" class="btn btn-danger btn-xs ladda-button" data-style="zoom-in" style="color:#FFF;">';
    		buttonVal_deleteUser += '<i class="fa fa-times" aria-hidden="true"></i></a>';
    		buttonVal_deleteUser += '</a>';
    		
   		}
   		htmlLines += '<td class="mail-subject" style="vertical-align:middle;">';
   		htmlLines += buttonVal_resetPassword;
   		htmlLines += buttonVal_editUser;
   		htmlLines += buttonVal_deleteUser;
   		htmlLines += '</td>';
   		
   		// Add to html content
       	$('#set001_20_05_tableContent').append(htmlLines);
        // Add event listener
        $('#role-'+userObj.id).on('change', function() {
        	roleObj.role = $(this).val();     
        	roleObj.hasChanged = true;
        	
            tycheesIO_saveBean(placeObj);
        });
    });
  	
    // Show/Hide Progress
    $('#set001_20_05_spinner').hide();
    $('#set001_20_05_table').show();
} // .end of set001_20_05_updateUI_postHandler

function set001_20_05_hide()
{
    $('#set001_20_05').hide();
} // .end of set001_20_05_hide

function set001_20_05_resetSearch()
{
	$('#set001_20_05_searchFilter').val('');
	
	set001_20_05_search();
} // .end of set001_20_05_resetSearch

function set001_20_05_search()
{
	set001_20_05_updateUI();
} // .end of set001_20_05_search

function set001_20_05_addUser()
{
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var userMaxCount = 0;
	var userUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_USER_MAX_COUNT) {
			userMaxCount = Number(propObj.propValue);
			userUsageCount = Number(propObj.propContent);
		}
	});
	
	if (userUsageCount >= userMaxCount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	// Show add user window
	set001_20_05_mw001_show();
} // .end of set001_20_05_addUser

function set001_20_05_resetPassword(userId)
{
	if (userId==null || userId=='') {
		tycheesLogger_showToast('warning','No user selected','Please select a user.');
    	return false;
	}
	
	$('#set001_20_05_resetPasswordButton_'+userId).ladda().ladda('start');
		
	set001_20_05_mw003_show(userId, set001_20_05_resetPassword_openCallbackFn);
} // .end of set001_20_05_resetPassword

function set001_20_05_resetPassword_openCallbackFn(success, userId) 
{
	$('#set001_20_05_resetPasswordButton_'+userId).ladda().ladda('stop');
} // .end of set001_20_05_resetPassword_openCallbackFn

function set001_20_05_editUser(userId)
{
	if (userId==null || userId=='') {
		tycheesLogger_showToast('warning','No user selected','Please select a user.');
    	return false;
	}

	set001_20_05_mw002_show(userId);
} // .end of set001_20_05_editUser

function set001_20_05_deleteUser(userId)
{
	if (userId==null || userId=='') {
		tycheesLogger_showToast('warning','No user selected','Please select a user.');
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this user record!",
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
		  		var placeObj = tycheesCommon_getCurrentPlaceObject();
		  		$.each(placeObj.roleList, function(i, roleObj){
		  			if (roleObj.userId == userId)
		  			{
		  				Cached_deleteBean(roleObj);
				  		
				  		// Save to IndexedDB
				    	tycheesIO_saveBean(placeObj);
				  		// Refresh UI
				    	set001_20_05_updateUI();
		  			}
		  		});
		  	}
		});
} // .end of set001_20_05_deleteUser

function set001_20_05_userChanged()
{
	var selectedAccessId = $('#set001_20_05_userList').val();
	set001_20_05_updateUI_showAccessProperties( selectedAccessId );
} // .end of set001_20_05_userChanged

</script>