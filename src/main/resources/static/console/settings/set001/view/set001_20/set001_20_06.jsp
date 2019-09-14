<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- set001_20_06: Manage Users - Roles & Permissions -->
<div id="set001_20_06" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	ROLES &amp; PERMISSIONS
	</span>
	<div class="ibox-content">
        <form user="form" class="form-inline">
            <div class="form-group">
                <label for="set001_20_06_roleList" class="sr-only">User Role List</label>
                <select id="set001_20_06_roleList" class="form-control" style="width:300px;height:30px;padding-top:0px;padding-bottom:0px;" onchange="set001_20_06_roleChanged();">                	
                </select>
            </div>
            <button class="btn btn-sm btn-white" type="button" onclick="set001_20_06_addRole();"><i class="fa fa-plus" aria-hidden="true"></i> Add Role</button>
            <button class="btn btn-sm btn-white" type="button" onclick="set001_20_06_editRole();"><i class="fa fa-pencil" aria-hidden="true"></i></button>
            <button class="btn btn-sm btn-danger" type="button" onclick="set001_20_06_deleteRole();"><i class="fa fa-times" aria-hidden="true"></i></button>
        	<!-- 
        	<div class="input-group pull-right">
                <input type="text" class="form-control input-sm" name="search" placeholder="Search user">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-primary">
                        Reset
                    </button>
                </div>
            </div>
             -->
        </form>
    </div> 
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <tbody id="set001_20_06_table">
            </tbody>
        </table>
    </div>
</div>
<!-- MODAL WINDOW: New Access -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_06_mw001.jsp" %>
<!-- MODAL WINDOW: Edit Access -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_06_mw002.jsp" %>

<script>

var set001_20_06_initialized = false;

function set001_20_06_init()
{
    if (set001_20_06_initialized == true)
        return false;
            
	set001_20_06_initialized = true;
} // .end of set001_20_06_init

function set001_20_06_updateUI()
{
    set001_20_06_init();

    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();

    $('#set001_20_06_roleList').empty();
    $('#set001_20_06_roleList').append('<option value="">-- SELECT ROLE--</option>');
    $.each(placeObj.accessList, function(i, accessObj){
    	if (Cached_isDeletedBean(accessObj))
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + accessObj.id + '">';
    	htmlLines += accessObj.roleName;
    	htmlLines += '</option>';
    	
    	$('#set001_20_06_roleList').append( htmlLines );
    });
  	
    $('#set001_20_06').show();
} // .end of set001_20_06_updateUI

function set001_20_06_hide()
{
    $('#set001_20_06').hide();
} // .end of set001_20_06_hide

function set001_20_06_updateUI_showAccessProperties(accessId)
{
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();

    placeObj.accessList.sort(function(a, b) {
		if (a.roleName < b.roleName) return -1;
		if (a.roleName > b.roleName) return 1;
		return 0;
	});
    
    $('#set001_20_06_table').empty();
    $.each(placeObj.accessList, function(i, accessObj){
    	if (accessObj.id == accessId)
    	{
    		accessObj.propertiesList.sort(function(a, b) {
    			if (a.propSeqno < b.propSeqno) return -1;
    			if (a.propSeqno > b.propSeqno) return 1;
    			return 0;
    		});
    		
    		var lastGroupName = '';
            var thisGroupName = '';
        
    		$.each(accessObj.propertiesList, function(j, propObj){
            		
            	thisGroupName = propObj.groupName;
            	
            	if (lastGroupName != thisGroupName)
            	{
            		var group_htmlLines = '';
            		group_htmlLines += '<tr style="background-color:#555;">';
            		group_htmlLines += '<td colspan="3" style="font-weight:bold; color:#fff; padding-top:2px; padding-bottom:2px;">';
            		group_htmlLines += thisGroupName
            		group_htmlLines += '</td>';
            		group_htmlLines += '</tr>';
            		
                	$('#set001_20_06_table').append(group_htmlLines);
            	}
            	 
        		var htmlLines = '';
            	htmlLines += '<tr class="read">';
            	
            	// COL #1
        		htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
        		htmlLines += propObj.propName;
        		htmlLines += '</td>';
        		
        		// COL #2
        		htmlLines += '<td class="mail-date">' + settingsCommon_getInputComponent(propObj) + '</td>';
        		
        		// COL #3
        		htmlLines += '<td class="mail-subject">' + propObj.remarks + '</td>';
        		htmlLines += '</tr>';
        		
            	$('#set001_20_06_table').append(htmlLines);
            	
        	    // Register events
        	    settingsCommon_addEventListeners( propObj );    	
        	    // Set lastGroupName
        	    lastGroupName = thisGroupName;		
    		});
    	}
    });
} // .end of set001_20_06_updateUI_showAccessProperties

function set001_20_06_addRole()
{
	set001_20_06_mw001_show();
} // .end of set001_20_06_addRole

function set001_20_06_editRole()
{
	var selectedRoleId = $('#set001_20_06_roleList').val();
	set001_20_06_mw002_show( selectedRoleId );
} // .end of set001_20_06_editRole

function set001_20_06_deleteRole()
{
	var roleId = $('#set001_20_06_roleList').val();
	var roleName = $("select[id='set001_20_06_roleList'").find('option:selected').text();
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	if (roleId==null || roleId=='') {
		tycheesLogger_showToast(
			'warning',
			'No role selected',
			'Please select a role.');
    	return false;
	}
	
	var associatedRoleFound = false;
	$.each(placeObj.roleList, function(i, roleObj) {
		if ($.trim(roleObj.role) == roleName) {
			associatedRoleFound = true;
		}
	});
	
	if (associatedRoleFound) {
		sweetAlert(
			"Unable to Delete Access", 
			"This access right is being associated with one of the user role. Please remove the user role from this access before proceed.", 
			"error");
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this role record!",
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
		  		
		  		$.each(placeObj.accessList, function(i, accessObj){
		  			if (accessObj.id == roleId)
		  			{
		  				Cached_deleteBean(accessObj);
				  		
				  		// Save to IndexedDB
				    	tycheesIO_saveBean(placeObj);
				  		// Refresh UI
				    	set001_20_06_updateUI();
				    	set001_20_06_updateUI_showAccessProperties('');
		  			}
		  		});
		  	}
		});
} // .end of set001_20_06_deleteRole

function set001_20_06_roleChanged()
{
	var selectedAccessId = $('#set001_20_06_roleList').val();
	set001_20_06_updateUI_showAccessProperties( selectedAccessId );
} // .end of set001_20_06_roleChanged

</script>