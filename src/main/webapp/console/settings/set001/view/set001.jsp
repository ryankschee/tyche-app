
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES | Console Settings 
    </title>

    <%@include file="/console/segment/include_stylesheets.jspf" %>
    
</head>

<body id="page-body" class="fixed-navigation">
    <div id="wrapper" style="display:none;">
	    
	    <%@include file="/console/segment/sidebar_main.jsp" %>

        <div id="page-wrapper" class="gray-bg sidebar-content">
        
        	<%@include file="/console/segment/header_main.jsp" %>
        	
            <!--%@include file="/console/segment/sidebar_right_summary.jspf" %-->
            
            <div id="header-section" class="row wrapper border-bottom white-bg page-heading" style="display:none;">
		        <div class="col-lg-12">
		        </div>
	        </div>
			 
            <div id="main-content" class="wrapper-content animated fadeInRight" style="display:none;">                 
	            <div class="row">
	                <div class="col-md-3 col-lg-2" style="padding:0px 0px;">
		                <div class="ibox float-e-margins">
		                    <div class="ibox-content mailbox-content">
		                        <div class="file-manager">
		                            <h1>SETTINGS</h1>
		                            <ul class="folder-list m-b-md" style="padding: 0">
		                            	<li id="set001_sidebar_menu_01" onclick="set001_executeAction('set001_action_select_billing');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-shopping-bag" aria-hidden="true"></i> 
		                                		<span style="padding-left:3px;"> CLOUD POS</span> 
		                                		<!-- span class="label label-warning pull-right">16</span--> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_02" onclick="set001_executeAction('set001_action_select_inventory');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-database" aria-hidden="true"></i> 
		                                		<span style="padding-left:6px;"> INVENTORY</span> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_03" onclick="set001_executeAction('set001_action_select_customer');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-users" aria-hidden="true"></i> 
		                                		<span style="padding-left:2px;"> CUSTOMER</span> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_04" onclick="set001_executeAction('set001_action_select_employee');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-users" aria-hidden="true"></i> 
		                                		<span style="padding-left:2px;"> EMPLOYEE</span> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_document" onclick="set001_executeAction('set001_action_select_document');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-file-text" aria-hidden="true"></i>
		                                		<span style="padding-left:7px;"> DOCUMENT</span> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_20" onclick="set001_executeAction('set001_action_select_store');" >
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-map-marker" aria-hidden="true"></i> 
		                                		<span style="padding-left:10px;"> MY PLACE</span> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_21" onclick="set001_executeAction('set001_action_select_user');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> 
		                                		<span style="padding-left:7px;"> MY PROFILE</span> 
		                                	</a>
		                                </li>
		                                <li id="set001_sidebar_menu_31" onclick="set001_executeAction('set001_action_select_search');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-search-plus" aria-hidden="true"></i>
		                                		<span style="padding-left:7px;"> SEARCH</span> 
		                                	</a>
		                                </li>
		                            </ul>
		                            <div class="clearfix"></div>
		                        </div>
		                    </div>
		                </div>
		            </div> <!-- col-lg-2 -->
		            <div class="col-md-9 col-lg-10 animated fadeInRight" style="padding:0px 0px;">
		            	<!-- General Settings -->
	                    <%@include file="/console/settings/set001/view/set001_00/set001_00.jsp" %>
	                    <!-- Billing Settings -->
	                    <%@include file="/console/settings/set001/view/set001_01/set001_01.jsp" %>
	                    <!-- Inventory Settings -->
	                    <%@include file="/console/settings/set001/view/set001_02/set001_02.jsp" %>
	                    <!-- Customer Settings -->
	                    <%@include file="/console/settings/set001/view/set001_03/set001_03.jsp" %>
	                    <!-- Employee Settings -->
	                    <%@include file="/console/settings/set001/view/set001_04/set001_04.jsp" %>
	                    <!-- Document Settings -->
	                    <%@include file="/console/settings/set001/view/set001_document/set001_document.jsp" %>
	                    
	                    <!-- My Store Settings -->
	                    <%@include file="/console/settings/set001/view/set001_20/set001_20.jsp" %>
	                    <!-- My Profile Settings -->
	                    <%@include file="/console/settings/set001/view/set001_21/set001_21.jsp" %>
	                    
	                    <!-- Search Filter Settings -->
	                    <%@include file="/console/settings/set001/view/set001_31/set001_31.jsp" %>
					</div> <!-- col-lg-10 -->
	            </div>
	        </div>            
            
        	<%@include file="/console/segment/footer_main.jsp" %>          
            
        </div>
        
        <%@include file="/console/segment/sidebar_right.jspf" %>  
        
    </div>
    
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
    <!-- MODAL WINDOW : PDF Preview Window -->
	<%@include file="/console/_view/view_mw_pdfPreview.jsp" %>
    
    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/canvas_common.js"></script>
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/settings_common.js"></script>
    <script src="/console/_util/place_util.js"></script>
	<!-- Modal -->
    <!-- View -->
    <script src="/console/settings/set001/view/set001.variables.js"></script>
    <script src="/console/settings/set001/view/set001.js"></script>
    
    <!-- Controller -->
    <script src="/console/document/processor/documentProcessor.js"></script>
    
    <script>
	    $(document).ready(function() {
	    	// common preload
	    	tycheesCommon_loadUI_preloadPage();	    	
	    	// custom preload
	    	my_preload_page();	
	    });
	    
	    function my_preload_page()
	    {
	        tycheesCommon_initCheckBox();
	        tycheesCommon_initDatePicker();
	    }
        
	    function loadUI_custom()
	    {
			$("#page-title").html('Console Settings');
			$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
        //----------------------------------------------------------------------
     	// Load this function on page loaded.
     	// #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	// #2. Validation passed, now sync both remote and local database.
	   	tycheesdb_initConsole(APP_NAME_SETTINGS);
	  	//----------------------------------------------------------------------
	    
    </script>
    
</body>
</html>
