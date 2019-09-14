<!-- SET001_31: Search Filter Settings -->
<div id="set001_31" style="display:none;">
	<div class="mail-box" style="padding:10px 20px 20px 20px;">
    	<div class="row">
            <div class="col-md-4 col-lg-3" style="padding:0px 0px;">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <ul class="folder-list m-b-md" style="padding: 0">
                                <!-- General -->
                                <span id="set001_31_sidebar_menu_general_header">
	                                <li style="background-color: #337ab7;height:33px; padding-top:5px;">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		GENERAL
	                                	</span>
										<span class="pull-right">
											<i id="set001_31_sidebar_menu_general_toggle" onclick="set001_31_toggleSidebarMenu('general');" class="fa fa-minus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_31_sidebar_menu_general">
                                	<li id="set001_31_sidebar_menu_00" onclick="set001_31_executeAction('set001_31_action_select_billing');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-shopping-bag" aria-hidden="true"></i> BILLING
                                    	</a>
                                    </li>
                                    <li id="set001_31_sidebar_menu_01" onclick="set001_31_executeAction('set001_31_action_select_customer');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-users" aria-hidden="true"></i> CUSTOMER
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
                <!-- Billing Search Filter -->
                <%@include file="/console/settings/set001/view/set001_31/set001_31_00.jsp" %>
                <!-- Customer Search Filter -->
                <%@include file="/console/settings/set001/view/set001_31/set001_31_01.jsp" %>
            </div>
        </div>
    </div>
</div>

<script>

var set001_31_initialized = false;
var set001_31_userObj;

/**
 * Init Panel
 */
function set001_31_init()
{
    if (set001_31_initialized == true)
        return false;
        
	set001_31_initialized = true;
} // .end of set001_31_init

/**
 * Show Panel
 */
function set001_31_updateUI()
{
    set001_31_init();
    
    $('#set001_31').show();
} // .end of set001_31_updateUI

/**
 * Hide Panel
 */
function set001_31_hide()
{
    $('#set001_31').hide();
} // .end of set001_31_hide


function set001_31_reloadUI()
{

} // .end of set001_31_reloadUI

/**
 * Toggle menu item (expand/collapse).
 */
function set001_31_toggleSidebarMenu(menuGroupName)
{
	if (menuGroupName=='general')
	{
		if ($('#set001_31_sidebar_menu_general_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_31_sidebar_menu_general_toggle').removeClass('fa-plus-square-o');
			$('#set001_31_sidebar_menu_general_toggle').addClass('fa-minus-square-o');
			$('#set001_31_sidebar_menu_general').show();
		}
		else
		{
			$('#set001_31_sidebar_menu_general_toggle').removeClass('fa-minus-square-o');
			$('#set001_31_sidebar_menu_general_toggle').addClass('fa-plus-square-o');
			$('#set001_31_sidebar_menu_general').hide();
		}
	
		return false;
	}
} // .end of set001_31_toggleSidebarMenu


function set001_31_executeAction(actionName, params)
{
    if (actionName == SET001_31_ACTION_SELECT_BILLING)
	{
		set001_31_00_updateUI();
		set001_31_01_hide();
		
		$('#set001_31_sidebar_menu_00').css('background-color', '#ddd');
		$('#set001_31_sidebar_menu_01').css('background-color', 'transparent');	
	}
	else
	if (actionName == SET001_31_ACTION_SELECT_CUSTOMER)
	{
		set001_31_00_hide();
		set001_31_01_updateUI();
		
		$('#set001_31_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_31_sidebar_menu_01').css('background-color', '#ddd');			
	}
	else
	{
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_31_executeAction
	  
</script>