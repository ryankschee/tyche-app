
<!-- 
	Module:		Settings
	Submodule:	SET001_01
	Function:	Employee Settings 
-->

<div id="set001_04" style="display:none;">
	<div class="mail-box" style="padding:10px 20px 20px 20px;">
    	<div class="row">
            <div class="col-md-4 col-lg-3" style="padding:0px 0px;">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <ul class="folder-list m-b-md" style="padding: 0">
                                <!-- General -->
                                <span id="set001_04_sidebar_menu_general_header">
	                                <li style="background-color: #337ab7;height:33px; padding-top:5px; cursor:pointer;" onclick="set001_04_toggleSidebarMenu('general');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		GENERAL
	                                	</span>
										<span class="pull-right">
											<i id="set001_04_sidebar_menu_general_toggle" onclick="set001_04_toggleSidebarMenu('general');" class="fa fa-minus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_04_sidebar_menu_general">
                                	<li id="set001_04_sidebar_menu_00" onclick="set001_04_executeAction('set001_04_action_select_general');" style="background-color:#FFFFFF;">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-sliders" aria-hidden="true"></i> EMPLOYEE NUMBER
                                    	</a>
                                    </li>
                                    <li id="set001_04_sidebar_menu_01" onclick="set001_04_executeAction('set001_04_action_select_employeeTemplate');">
                                    	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
                                    		<i class="fa fa-file-text-o" aria-hidden="true"></i> EMPLOYEE TEMPLATE 
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
                <%@include file="/console/settings/set001/view/set001_04/set001_04_00.jsp" %>
                <!-- Employee Template -->
                <%@include file="/console/settings/set001/view/set001_04/set001_04_01.jsp" %>
            </div>
        </div>
    </div>
</div>

<script>

var set001_04_initialized = false;

function set001_04_init()
{
    if (set001_04_initialized == true)
        return false;
    
    // Register event for search field
    $('#set001_04_searchField').on('input propertychange paste', function() {        
        var searchText = $('#set001_04_searchField').val();
    });
    
	set001_04_initialized = true;
} // .end of set001_04_init

function set001_04_updateUI()
{
    set001_04_init();
      	
    $('#set001_04').show();
} // .end of set001_04_updateUI

function set001_04_hide()
{
    $('#set001_04').hide();
} // .end of set001_04_hide

function set001_04_toggleSidebarMenu(menuGroupName)
{
	if (menuGroupName=='general')
	{
		if ($('#set001_04_sidebar_menu_general_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_04_sidebar_menu_general_toggle').removeClass('fa-plus-square-o');
			$('#set001_04_sidebar_menu_general_toggle').addClass('fa-minus-square-o');
			$('#set001_04_sidebar_menu_general').show();
		}
		else
		{
			$('#set001_04_sidebar_menu_general_toggle').removeClass('fa-minus-square-o');
			$('#set001_04_sidebar_menu_general_toggle').addClass('fa-plus-square-o');
			$('#set001_04_sidebar_menu_general').hide();
		}
	
		return false;
	}
} // .end of set001_04_toggleSidebarMenu

function set001_04_executeAction(actionName)
{
	if (actionName == SET001_04_ACTION_SELECT_GENERAL)
	{
		set001_04_00_updateUI();
		set001_04_01_hide();
		
		$('#set001_04_sidebar_menu_00').css('background-color', '#ddd');
		$('#set001_04_sidebar_menu_01').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_04_ACTION_SELECT_EMPLOYEE_TEMPLATE)
	{
		set001_04_00_hide();
		set001_04_01_updateUI();
		
		$('#set001_04_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_04_sidebar_menu_01').css('background-color', '#ddd');
	}
	else
	{
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_04_executeAction
	  
	  
</script>