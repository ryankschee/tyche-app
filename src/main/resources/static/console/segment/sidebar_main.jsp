<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
        
            <li id="sidebar-profile" class="nav-header" style="display:none; background-color:#293846;">
                <div class="dropdown profile-element"> 
                	<span>
                        <img id="user-profileImage" alt="image" class="img-circle" src="" style="width:48px;height:48px;" />
                    </span>
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <span class="clear"> 
                        	<span class="block m-t-xs"> 
                        	    <strong class="font-bold" id="user-name">$USER_FULLNAME</strong>
                        	</span> 
                        	<span class="text-muted text-xs block">
                        	    <span id="user-position">$USER_POSITION</span>
                        	    <b class="caret"></b>
                        	</span> 
                        </span> 
                    </a>
                    <!--
                    <ul class="dropdown-menu animated fadeInDown m-t-xs">
                        <li><a href="profile.html">Profile</a></li>
                        <li><a href="contacts.html">Contacts</a></li>
                        <li><a href="mailbox.html">Mailbox</a></li>
                        <li class="divider"></li>
                        <li><a href="login.html" data-i18n="app.action-logout">$LOGOUT</a></li>
                    </ul>
                    -->
                </div>
                <div class="logo-element" data-i18n="tychees.name-abbr">
                    $ABBR
                </div>
            </li>
            <li id="sidebar-dashboard" style="display:none;">
                <a href="#" onclick="tycheesCommon_gotoModule('ModuleDashboard');">
                    <i class="fa fa-tachometer" aria-hidden="true"></i> 
                    <span class="nav-label" data-i18n="app.module-dashboard">$DASHBOARD</span>
                </a>
            </li>
            <li id="sidebar-calendar" style="display:none;">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleCalendar');">
            	    <i class="fa fa-calendar" aria-hidden="true"></i>
            	    <span class="nav-label" data-i18n="app.module-calendar">$CALENDAR</span>
            	</a>
            </li>
            <li id="sidebar-billing" style="display:none;">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleBilling');">
            	    <i class="fa fa-shopping-bag" aria-hidden="true"></i> 
            	    <span class="nav-label" data-i18n="app.module-billing">$POS</span>
            	</a>
            </li>
            <li id="sidebar-inventory" style="display:none;">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleInventory');">
            	    <i class="fa fa-database" aria-hidden="true"></i> 
            	    <span class="nav-label" data-i18n="app.module-inventory">$INVENTORY</span>
            	</a>
            </li>
            
            <li id="sidebar-relation" style="display:none;">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleRelation');">
            	    <i class="fa fa-users" aria-hidden="true"></i> 
            	    <span class="nav-label" data-i18n="app.module-relation">$RELATION</span>
            	</a>
            </li>
            
            <li id="sidebar-reports" style="display:none;">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleReports');">
            	    <i class="fa fa-bar-chart" aria-hidden="true"></i>
            	    <span class="nav-label" data-i18n="app.module-reports">$REPORTS</span>
            	</a>
            </li>
                  <!--      
            <li id="sidebar-humanResource">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleHumanResource');">
            	    <i class="fa fa-sitemap" aria-hidden="true"></i>
            	    <span class="nav-label" data-i18n="app.module-humanResources">$HUMAN_RESOURCES_PAYROLL</span>
            	</a>
            </li>
             -->      
            <li id="sidebar-settings" style="display:none;">
            	<a href="#" onclick="tycheesCommon_gotoModule('ModuleSettings');">
            	    <i class="fa fa-cogs" aria-hidden="true"></i>
            	    <span class="nav-label" data-i18n="app.module-settings">$SETTINGS</span>
            	</a>
            </li>
            <li class="landing_link">
            	<a onclick="tycheesCommon_openSearchWindow();" style="padding-left:20px;">
                    <i class="fa fa-search fa-2x" aria-hidden="true"></i>
                    <span class="nav-label" style="font-size:18pt;">Search</span> 
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- MODAL WINDOW: Console Search -->
<%@include file="/console/search/sea001/view/sea001_mw000.jsp" %>