<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- SET001_01_00: Store Settings - User Roles -->
<div id="set001_20_04" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	USER ROLE
	</span>
	<div class="ibox-content">
        <form user="form" class="form-inline">
        	<button class="btn btn-sm btn-white" type="button" onclick="set001_20_04_mw001_updateUI();">
        		<i class="fa fa-plus" aria-hidden="true"></i> 
        		Add New User
        	</button>
        	<div class="input-group pull-right">
                <input type="text" class="form-control input-sm" name="search" placeholder="Search user">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-grey">
                        Reset
                    </button>
                </div>
            </div>
        </form>
    </div>        
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td class="table-thead-td" width="auto">ALLOWED USER</td>
                    <td class="table-thead-td" width="auto">ROLE TYPE</td>
                    <td class="table-thead-td" width="170px">ACTION</td>
                </tr>
            </thead>
            <tbody id="set001_20_04_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var set001_20_04_initialized = false;

/*******************************************************************************
 * Init Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_20_04_init()
{
    if (set001_20_04_initialized == true)
        return false;

	set001_20_04_initialized = true;
} // .end of set001_20_04_init

/*******************************************************************************
 * Show Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_20_04_updateUI()
{
    set001_20_04_init();
    
 	// Empty table
    $('#set001_20_04_table').empty();
    
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.roleList, function(i, roleObj) { 
    
    	if (Cached_isDeletedBean(roleObj))
    		return true;

    	var userObj = Cached_getUserById( roleObj.userId );
    	
        var htmlLines = '';
       	htmlLines += '<tr class="read">';

       	// COL #1
   		htmlLines += '<td style="font-size:12pt; padding:12px auto; vertical-align:top;">';
   		htmlLines += userObj.firstName + ' ' + userObj.lastName;
   		htmlLines += '</td>';
   		
   		// COL #2
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += roleObj.role;
   		htmlLines += '</td>';
   		
   		// COL #4
   		var buttonVal_edit = '<a onclick="set001_20_04_editRow(\'' + roleObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-pencil" aria-hidden="true"></i></a>';
	    var buttonVal_delete = '<a onclick="set001_20_04_deleteRow(\'' + roleObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-times" aria-hidden="true"></i></a>';
	    
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += buttonVal_edit + ' ' + buttonVal_delete;
   		htmlLines += '</td>';
   		
   		// Add to html content
       	$('#set001_20_04_table').append(htmlLines);
    });  	
      	
    $('#set001_20_04').show();
} // .end of set001_20_04_updateUI

/*******************************************************************************
 * Hide Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_20_04_hide()
{
    $('#set001_20_04').hide();
} // .end of set001_20_04_hide

</script>