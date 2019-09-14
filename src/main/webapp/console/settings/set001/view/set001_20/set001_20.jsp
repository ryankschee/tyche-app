<!-- SET001_03: Store Settings -->
<div id="set001_20" style="display:none;">
	<!--
    <div class="mail-box-header">
        <h2>
            MY STORE
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
                                <span id="set001_20_sidebar_menu_general_header">
	                                <li style="background-color: #337ab7;height:33px; padding-top:5px; cursor:pointer;" onclick="set001_20_toggleSidebarMenu('general');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		GENERAL
	                                	</span>
										<span class="pull-right">
											<i id="set001_20_sidebar_menu_general_toggle" onclick="set001_20_toggleSidebarMenu('general');" class="fa fa-minus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_20_sidebar_menu_general">
	                            	<li id="set001_20_sidebar_menu_00" onclick="set001_20_executeAction('set001_20_action_select_general');" style="background-color:#FFFFFF;">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-cogs" aria-hidden="true"></i> BASIC INFO
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_01" onclick="set001_20_executeAction('set001_20_action_select_address');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-home" aria-hidden="true"></i> ADDRESS
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_02" onclick="set001_20_executeAction('set001_20_action_select_contact');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-phone-square" aria-hidden="true"></i> CONTACT
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_03" onclick="set001_20_executeAction('set001_20_action_select_operatingHours');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-clock-o" aria-hidden="true"></i> OPERATING HOURS
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_04" onclick="set001_20_executeAction('set001_20_action_select_gallery');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-picture-o" aria-hidden="true" style="padding-right:3px;"></i>GALLERY
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_05" onclick="set001_20_executeAction('set001_20_action_select_users');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-list" aria-hidden="true"></i> APPROVED USERS
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_06" onclick="set001_20_executeAction('set001_20_action_select_roles');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-shield" aria-hidden="true" style="padding-right:3px;"></i> ROLES & PERMISSION
	                                	</a>
	                                </li>
	                                <li id="set001_20_sidebar_menu_07" onclick="set001_20_executeAction('set001_20_action_select_account_membership');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-key" aria-hidden="true" style="padding-right:3px;"></i> ACCOUNT MEMBERSHIP
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
                <%@include file="/console/settings/set001/view/set001_20/set001_20_00.jsp" %>
                <!-- Address -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_01.jsp" %>
                <!-- Contact -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_02.jsp" %>
                <!-- Operating Hours -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_03.jsp" %>
                <!-- Gallery -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_04.jsp" %>
                <!-- User Roles -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_05.jsp" %>
                <!-- Roles & Permissions -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_06.jsp" %>
                <!-- Account Membership -->
                <%@include file="/console/settings/set001/view/set001_20/set001_20_07.jsp" %>
            </div>
        </div>
    </div>
</div>
   
<script>

var set001_20_initialized = false;

/**
 * Init Panel
 */
function set001_20_init()
{
    if (set001_20_initialized == true)
        return false;
    
	set001_20_initialized = true;
} // .end of set001_20_init

/**
 * Show Panel
 */
function set001_20_updateUI()
{
    set001_20_init();
    
    $('#set001_20').show();
} // .end of set001_20_updateUI

/**
 * Hide Panel
 */
function set001_20_hide()
{
    $('#set001_20').hide();
} // .end of set001_20_hide

/**
 * Reload whole UI
 */
function set001_20_reloadUI()
{
	set001_20_updateUI();
} // .end of set001_20_reloadUI

/**
 * Toggle menu item (expand/collapse).
 */
function set001_20_toggleSidebarMenu(menuGroupName)
{
	if (menuGroupName=='general')
	{
		if ($('#set001_20_sidebar_menu_general_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_20_sidebar_menu_general_toggle').removeClass('fa-plus-square-o');
			$('#set001_20_sidebar_menu_general_toggle').addClass('fa-minus-square-o');
			$('#set001_20_sidebar_menu_general').show();
		}
		else
		{
			$('#set001_20_sidebar_menu_general_toggle').removeClass('fa-minus-square-o');
			$('#set001_20_sidebar_menu_general_toggle').addClass('fa-plus-square-o');
			$('#set001_20_sidebar_menu_general').hide();
		}
	
		return false;
	}
} // .end of set001_20_toggleSidebarMenu

/**
 * Show/Hide panels.
 */
function set001_20_executeAction(actionName, params)
{
    if (actionName == SET001_20_ACTION_SELECT_GENERAL)
	{
		set001_20_00_updateUI();
		set001_20_01_hide();
		set001_20_02_hide();
		set001_20_03_hide();
		set001_20_04_hide();
		set001_20_05_hide();
		set001_20_06_hide();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_ADDRESS)
	{
		set001_20_00_hide();
		set001_20_01_updateUI();
		set001_20_02_hide();
		set001_20_03_hide();
		set001_20_04_hide();
		set001_20_05_hide();
		set001_20_06_hide();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_CONTACT)
	{
		set001_20_00_hide();
		set001_20_01_hide();
		set001_20_02_updateUI();
		set001_20_03_hide();
		set001_20_04_hide();
		set001_20_05_hide();
		set001_20_06_hide();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_OPERATING_HOURS)
	{
		set001_20_00_hide();
		set001_20_01_hide();
		set001_20_02_hide();
		set001_20_03_updateUI();
		set001_20_04_hide();
		set001_20_05_hide();
		set001_20_06_hide();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_GALLERY)
	{
		set001_20_00_hide();
		set001_20_01_hide();
		set001_20_02_hide();
		set001_20_03_hide();
		set001_20_04_updateUI();
		set001_20_05_hide();
		set001_20_06_hide();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_USERS)
	{
		set001_20_00_hide();
		set001_20_01_hide();
		set001_20_02_hide();
		set001_20_03_hide();
		set001_20_04_hide();
		set001_20_05_updateUI();
		set001_20_06_hide();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_ROLES)
	{
		set001_20_00_hide();
		set001_20_01_hide();
		set001_20_02_hide();
		set001_20_03_hide();
		set001_20_04_hide();
		set001_20_05_hide();
		set001_20_06_updateUI();
		set001_20_07_hide();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', '#ddd');
		$('#set001_20_sidebar_menu_07').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_20_ACTION_SELECT_ACCOUNT_MEMBERSHIP)
	{
		set001_20_00_hide();
		set001_20_01_hide();
		set001_20_02_hide();
		set001_20_03_hide();
		set001_20_04_hide();
		set001_20_05_hide();
		set001_20_06_hide();
		set001_20_07_updateUI();
		
		$('#set001_20_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_20_sidebar_menu_07').css('background-color', '#ddd');
	}
	else
	{
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_20_executeAction

</script>