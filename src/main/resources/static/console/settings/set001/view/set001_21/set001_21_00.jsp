<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- SET001_01_00: Billing Settings - General -->
<div id="set001_21_00" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
        BASIC INFO
	</span>
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td class="table-thead-td" width="auto">NAME</td>
                    <td class="table-thead-td" width="auto">VALUE</td>
                    <td class="table-thead-td" width="auto">DESCRIPTION</td>
                </tr>
            </thead>
            <tbody id="set001_21_table">
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">User ID</td>
                    <td class="input-group" style="width:100%;">
                    	<input type="text" class="form-control" id="set001_21_userId" placeholder="User ID" value="" disabled>
                    </td>
                    <td></td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Email</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_21_email" placeholder="Email" value="" disabled>
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_updateEmail();">
								<i class="fa fa-pencil" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Password</td>
                    <td class="input-group">
                    	<input type="password" class="form-control" id="set001_21_password" placeholder="********" value="" disabled>
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_updatePassword();">
								<i class="fa fa-pencil" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">First Name</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_21_firstName" placeholder="First Name" value="">
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Last Name</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_21_lastName" placeholder="Last Name" value="">
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Designation</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_21_designation" placeholder="Job Designation" value="">
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <!--
                <tr class="unread">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Home Location</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_21_homeLocation" placeholder="Latitude / Longitude" value="">
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Influence Radius</td>
                    <td class="input-group">
                    	<input type="number" class="form-control" id="set001_21_homeLocationRadius" placeholder="Home Location Radius" value="">
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                <tr class="unread">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Profile Image</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_21_profileImage" placeholder="Profile Image" value="">
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_21_00_save();">
								<i class="fa fa-folder-open-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                    <td></td>
                </tr>
                -->
            </tbody>
        </table>
    </div>
</div>

<!-- Change Email -->
<%@include file="/console/settings/set001/view/set001_21/set001_21_00_mw001.jsp" %>
<!-- Change Password -->
<%@include file="/console/settings/set001/view/set001_21/set001_21_00_mw002.jsp" %>

<script>

var set001_21_00_initialized = false;
var set001_21_00_userObj;

/**
 * Init Panel
 */
function set001_21_00_init()
{
    if (set001_21_00_initialized == true)
        return false;
            
	set001_21_00_initialized = true;
} // .end of set001_21_00_init

/**
 * Show Panel
 */
function set001_21_00_updateUI()
{
    set001_21_00_init();
    
    set001_21_00_userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
    if (set001_21_00_userObj == null) 
    {
        console.log('[ERROR] set001_21_updateUI >> No userObj found.');
    }
    else
    {
        $('#set001_21_userId').val( $.trim(set001_21_00_userObj.id) );
        $('#set001_21_email').val( $.trim(set001_21_00_userObj.email) );
        $('#set001_21_password').val( '********' );
        $('#set001_21_firstName').val( $.trim(set001_21_00_userObj.firstName) );
        $('#set001_21_lastName').val( $.trim(set001_21_00_userObj.lastName) );
        
        //$('#set001_21_designation').val( $.trim(set001_21_00_userObj.designation) );
        //$('#set001_21_homeLocation').val( $.trim(set001_21_00_userObj.homeLocationLatitude) + ', ' + $.trim(set001_21_00_userObj.homeLocationLongitude) );
        //$('#set001_21_homeLocationRadius').val( $.trim(set001_21_00_userObj.homeLocationRadius) );
        //$('#set001_21_profileImage').val( $.trim(set001_21_00_userObj.profileImageUrl) );
    }
  	
    $('#set001_21_00').show();
} // .end of set001_21_00_updateUI

/**
 * Hide Panel
 */
function set001_21_00_hide()
{
    $('#set001_21_00').hide();
} // .end of set001_21_00_hide

function set001_21_00_updateEmail()
{
    set001_21_00_mw001_show();
} // .end of set001_21_00_updateEmail

function set001_21_00_updatePassword()
{
    set001_21_00_mw002_show();
} // .end of set001_21_00_updatePassword

function set001_21_00_save()
{
	// TAB: General
	var firstName = $.trim( $("#set001_21_firstName").val() );
	var lastName = $.trim( $("#set001_21_lastName").val() );
	var designation = $.trim( $("#set001_21_designation").val() );
    
    set001_21_00_userObj.firstName = tycheesText_getSafeString(firstName);
    set001_21_00_userObj.lastName = tycheesText_getSafeString(lastName);
    set001_21_00_userObj.position = tycheesText_getSafeString(designation);
    
    // Save into IndexedDB
	tycheesIO_saveBean(set001_21_00_userObj);
} // .end of set001_21_00_save

</script>