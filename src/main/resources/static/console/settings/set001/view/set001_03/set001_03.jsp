<!-- SET001_01: Customer Settings -->
<div id="set001_03" style="display:none;">
	<!--
    <div class="mail-box-header">
        <form method="get" action="index.html" class="pull-right mail-search">
            <div class="input-group">
                <input id="set001_03_searchField" type="text" class="form-control input-sm" name="search" placeholder="Search">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-primary">
                        Search
                    </button>
                </div>
            </div>
        </form>
        <h2>
            CUSTOMER SETTINGS
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
                                <span id="set001_03_sidebar_menu_general_header">
	                                <li style="background-color: #337ab7;height:33px; padding-top:5px; cursor:pointer;" onclick="set001_03_toggleSidebarMenu('general');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		GENERAL
	                                	</span>
										<span class="pull-right">
											<i id="set001_03_sidebar_menu_general_toggle" onclick="set001_03_toggleSidebarMenu('general');" class="fa fa-minus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_03_sidebar_menu_general">
                                	<li id="set001_03_sidebar_menu_00" onclick="set001_03_executeAction('set001_03_action_select_general');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-sliders" aria-hidden="true"></i> CUSTOMER NUMBER
                                    	</a>
                                    </li>
                                    <li id="set001_03_sidebar_menu_01" onclick="set001_03_executeAction('set001_03_action_select_customerTemplate');">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-file-text-o" aria-hidden="true"></i> CUSTOMER TEMPLATE 
                                    	</a>
                                    </li>
                                    <li id="set001_03_sidebar_menu_02" onclick="set001_03_executeAction('set001_03_action_select_profileTemplate');">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-files-o" aria-hidden="true"></i> PROFILE TEMPLATE
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
                <%@include file="/console/settings/set001/view/set001_03/set001_03_00.jsp" %>
                <!-- Billing Settings -->
                <%@include file="/console/settings/set001/view/set001_03/set001_03_01.jsp" %>
                <!-- Inventory Settings -->
                <%@include file="/console/settings/set001/view/set001_03/set001_03_02.jsp" %>
            </div>
        </div>
    </div>
</div>

<script>

var set001_03_initialized = false;

/**
 * Init Panel
 */
function set001_03_init()
{
    if (set001_03_initialized == true)
        return false;
    
    // Register event for search field
    $('#set001_03_searchField').on('input propertychange paste', function() {
        
        var searchText = $('#set001_03_searchField').val();
        console.log( "Handler for .change() called. [searchText=" + searchText + ']' );
    });
    
	set001_03_initialized = true;
} // .end of set001_03_init

/**
 * Show Panel
 */
function set001_03_updateUI()
{
    set001_03_init();
      	
    $('#set001_03').show();
} // .end of set001_03_updateUI

/**
 * Hide Panel.
 */
function set001_03_hide()
{
    $('#set001_03').hide();
} // .end of set001_03_hide

/**
 * Toggle menu item (expand/collapse).
 */
function set001_03_toggleSidebarMenu(menuGroupName)
{
	if (menuGroupName=='general')
	{
		if ($('#set001_03_sidebar_menu_general_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_03_sidebar_menu_general_toggle').removeClass('fa-plus-square-o');
			$('#set001_03_sidebar_menu_general_toggle').addClass('fa-minus-square-o');
			$('#set001_03_sidebar_menu_general').show();
		}
		else
		{
			$('#set001_03_sidebar_menu_general_toggle').removeClass('fa-minus-square-o');
			$('#set001_03_sidebar_menu_general_toggle').addClass('fa-plus-square-o');
			$('#set001_03_sidebar_menu_general').hide();
		}
	
		return false;
	}
} // .end of set001_03_toggleSidebarMenu

/**
 * Update the UI of whole page.
 */
function set001_03_executeAction(actionName)
{
	if (actionName == SET001_03_ACTION_SELECT_GENERAL)
	{
		set001_03_00_updateUI();
		set001_03_01_hide();
		set001_03_02_hide();
		
		$('#set001_03_sidebar_menu_00').css('background-color', '#ddd');
		$('#set001_03_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_03_sidebar_menu_02').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_03_ACTION_SELECT_CUSTOMER_TEMPLATE)
	{
		set001_03_00_hide();
		set001_03_01_updateUI();
		set001_03_02_hide();
		
		$('#set001_03_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_03_sidebar_menu_01').css('background-color', '#ddd');
		$('#set001_03_sidebar_menu_02').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_03_ACTION_SELECT_PROFILE_TEMPLATE)
	{
		set001_03_00_hide();
		set001_03_01_hide();
		set001_03_02_updateUI();
		
		$('#set001_03_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_03_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_03_sidebar_menu_02').css('background-color', '#ddd');
	}
	else
	{
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_03_executeAction
	  
	  
</script>