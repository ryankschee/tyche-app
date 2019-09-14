<!-- SET001_03: User Settings -->
<div id="set001_21" style="display:none;">
	<!--
    <div class="mail-box-header">
        <h2>
            MY PROFILE
        </h2>
    </div>
      -->
    <div class="mail-box" style="padding:10px 20px 20px 20px;">
    	<div class="row">
            <div class="col-md-4 col-lg-3" style="padding:0px 0px;">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <ul class="folder-list m-b-md" style="padding: 0">
                                <!-- General -->
                                <span id="set001_21_sidebar_menu_general_header">
	                                <li style="background-color: #337ab7;height:33px; padding-top:5px; cursor:pointer;" onclick="set001_21_toggleSidebarMenu('general');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		GENERAL
	                                	</span>
										<span class="pull-right">
											<i id="set001_21_sidebar_menu_general_toggle" onclick="set001_21_toggleSidebarMenu('general');" class="fa fa-minus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_21_sidebar_menu_general">
                                	<li id="set001_21_sidebar_menu_00" onclick="set001_21_executeAction('set001_21_action_select_general');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-sliders" aria-hidden="true"></i> BASIC INFO
                                    	</a>
                                    </li>
                                    <li id="set001_21_sidebar_menu_01" onclick="set001_21_executeAction('set001_21_action_select_gallery');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-picture-o" aria-hidden="true"></i> IMAGES GALLERY
                                    	</a>
                                    </li>
                                    <li id="set001_21_sidebar_menu_02" onclick="set001_21_executeAction('set001_21_action_select_location');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-map-marker" aria-hidden="true"></i> LOCATION
                                    	</a>
                                    </li>
                                    <li id="set001_21_sidebar_menu_03" onclick="set001_21_executeAction('set001_21_action_select_access_rights');">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-shield" aria-hidden="true"></i> ACCESS RIGHTS
                                    	</a>
                                    </li>
                                </span>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-lg-9 animated fadeInRight" style="padding:0px 0px;">
                <!-- General Settings -->
                <%@include file="/console/settings/set001/view/set001_21/set001_21_00.jsp" %>
                <!-- General Settings -->
                <%@include file="/console/settings/set001/view/set001_21/set001_21_01.jsp" %>
                <!-- General Settings -->
                <%@include file="/console/settings/set001/view/set001_21/set001_21_02.jsp" %>
                <!-- General Settings -->
                <%@include file="/console/settings/set001/view/set001_21/set001_21_03.jsp" %>
            </div>
        </div>
    </div>
</div>

<!-- Modal Window: Change Email -->
<%@include file="/console/settings/set001/view/set001_21/set001_21_mw001.jsp" %>
<!-- Modal Window: Change Password -->
<%@include file="/console/settings/set001/view/set001_21/set001_21_mw002.jsp" %>

<script>

var set001_21_initialized = false;
var set001_21_userObj;

function set001_21_init()
{
    if (set001_21_initialized == true)
        return false;
        
	set001_21_initialized = true;
} // .end of set001_21_init

function set001_21_updateUI()
{
    set001_21_init();
    
    $('#set001_21').show();
} // .end of set001_21_updateUI

function set001_21_hide()
{
    $('#set001_21').hide();
} // .end of set001_21_hide


function set001_21_reloadUI()
{

} // .end of set001_21_reloadUI

/**
 * Toggle menu item (expand/collapse).
 */
function set001_21_toggleSidebarMenu(menuGroupName)
{
	if (menuGroupName=='general')
	{
		if ($('#set001_21_sidebar_menu_general_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_21_sidebar_menu_general_toggle').removeClass('fa-plus-square-o');
			$('#set001_21_sidebar_menu_general_toggle').addClass('fa-minus-square-o');
			$('#set001_21_sidebar_menu_general').show();
		}
		else
		{
			$('#set001_21_sidebar_menu_general_toggle').removeClass('fa-minus-square-o');
			$('#set001_21_sidebar_menu_general_toggle').addClass('fa-plus-square-o');
			$('#set001_21_sidebar_menu_general').hide();
		}
	
		return false;
	}
} // .end of set001_21_toggleSidebarMenu


function set001_21_executeAction(actionName, params)
{
    if (actionName == SET001_21_ACTION_SELECT_GENERAL)
	{
		set001_21_00_updateUI();
		set001_21_01_hide();
		set001_21_02_hide();
		set001_21_03_hide();
		
		$('#set001_21_sidebar_menu_00').css('background-color', '#ddd');
		$('#set001_21_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_03').css('background-color', 'transparent');
		
		return false;
	}
	else
	if (actionName == SET001_21_ACTION_SELECT_GALLERY)
	{
		set001_21_00_hide();
		set001_21_01_updateUI();
		set001_21_02_hide();
		set001_21_03_hide();
		
		$('#set001_21_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_01').css('background-color', '#ddd');
		$('#set001_21_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_03').css('background-color', 'transparent');
		
		return false;
	}
	else
	if (actionName == SET001_21_ACTION_SELECT_LOCATION)
	{
		set001_21_00_hide();
		set001_21_01_hide();
		set001_21_02_updateUI();
		set001_21_03_hide();
		
		$('#set001_21_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_02').css('background-color', '#ddd');
		$('#set001_21_sidebar_menu_03').css('background-color', 'transparent');
		
		return false;
	}
	else
	if (actionName == SET001_21_ACTION_SELECT_ACCESS_RIGHTS)
	{
		set001_21_00_hide();
		set001_21_01_hide();
		set001_21_02_hide();
		set001_21_03_updateUI();
		
		$('#set001_21_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_21_sidebar_menu_03').css('background-color', '#ddd');
		
		return false;
	}
	else
	{
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_21_executeAction
	  
</script>