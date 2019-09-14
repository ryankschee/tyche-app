
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES | RELATION MANAGEMENT
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
	                <div class="col-md-3 col-lg-2" style="padding:0px 5px;">
		                <div class="ibox float-e-margins">
		                    <div class="ibox-content mailbox-content">
		                        <div class="file-manager">
		                            <h1>RELATION</h1>
		                            <ul class="folder-list m-b-md" style="padding: 0">
		                            	<!--
		                            	<li id="rel001_sidebar_menu_00" onclick="rel001_executeAction('rel001_action_select_overview');" style="background-color:#FFFFFF;">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-bar-chart" aria-hidden="true"></i> OVERVIEW
		                                	</a>
		                                </li>
		                                -->
		                                <!--
		                                <li id="rel001_sidebar_menu_01" onclick="rel001_executeAction('rel001_action_select_prospect');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user-secret" aria-hidden="true"></i> PROSPECT 
		                                		<span class="label label-warning pull-right">16 new</span> 
		                                	</a>
		                                </li>
		                                -->
		                                <li id="rel001_sidebar_menu_employee" onclick="rel001_selectEmployeeModule();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> EMPLOYEE
		                                	</a>
		                                </li>
		                                <li id="rel001_sidebar_menu_customer" onclick="rel001_selectCustomerModule();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> CUSTOMER
		                                	</a>
		                                </li>
		                                 <!-- 
		                                
		                                <br><br><br>
		                                
		                                <li id="rel001_sidebar_menu_02" onclick="runPatch();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> PATCH 1
		                                	</a>
		                                </li>
		                                <li id="rel001_sidebar_menu_02" onclick="runPatchGST();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> PATCH GST
		                                	</a>
		                                </li>
		                                     -->
		                                  
		                                <!--
		                                <li id="rel001_sidebar_menu_03" onclick="rel001_executeAction('rel001_action_select_vendor');" >
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-truck" aria-hidden="true"></i> VENDOR
		                                	</a>
		                                </li>
		                                -->
		                                <!-- 
		                                <li id="rel001_sidebar_menu_04" onclick="rel001_executeAction('rel001_action_select_calendar');" >
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-calendar" aria-hidden="true"></i> CALENDAR
		                                	</a>
		                                </li>
		                                 -->
		                                 <!--
		                                <li id="rel001_sidebar_menu_20" onclick="rel001_executeAction('rel001_action_select_user');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> USERS
		                                	</a>
		                                </li>
		                                -->
		                            </ul>
		                            <div class="clearfix"></div>
		                        </div>
		                    </div>
		                </div>
		            </div> <!-- col-lg-2 -->
		            <div class="col-md-9 col-lg-10 animated fadeInRight" style="padding:0px 5px;">  
	                    <!-- EMPLOYEE -->
	                    <%@include file="/console/relation/rel001/view/rel001_employee/rel001_employeePanel.jsp" %>
	                    <!-- CUSTOMER -->
	                    <%@include file="/console/relation/rel001/view/rel001_customer/rel001_customerPanel.jsp" %>
	                               
	                	<!-- OVERVIEW -->
	                    <!-- %@include file="/console/relation/rel001/view/rel001_00/rel001_00.jsp" %-->
	                    <!-- PROSPECT -->
	                    <!-- %@include file="/console/relation/rel001/view/rel001_01/rel001_01.jsp" %-->
	                    <!-- VENDOR -->
	                    <!-- %@include file="/console/relation/rel001/view/rel001_03/rel001_03.jsp" %-->
	                    <!-- USER/STAFF MANAGEMENT -->
	                    <!-- %@include file="/console/relation/rel001/view/rel001_20/rel001_20.jsp" %-->
	                </div> <!-- col-lg-10 -->
	            </div>
	        </div>         
        	<%@include file="/console/segment/footer_main.jsp" %>  
        </div>
        <%@include file="/console/segment/sidebar_right.jspf" %>  
    </div>
    
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
	<!-- MODAL WINDOW: Contact Editor -->
	<%@include file="/console/_view/view_mw_contactEditor.jsp" %>
	<!-- MODAL WINDOW: Email Editor -->
	<%@include file="/console/_view/view_mw_emailEditor.jsp" %>
	<!-- MODAL WINDOW: Address Editor -->
	<%@include file="/console/_view/view_mw_addressEditor.jsp" %>
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/relation/view_mw_employeeSearch.jsp" %>
	
    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/billing_common.js"></script>
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/customer_common.js"></script>
    <script src="/console/_common/employee_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
	<!-- Util JS -->
    <script src="/console/_util/customer_util.js"></script>
	<!-- Modal -->
    <!-- View -->
    <script src="/console/relation/rel001/view/rel001.variables.js"></script>
    <script src="/console/relation/rel001/view/rel001.js"></script>
    
    <!-- Controller -->
    
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
			$("#page-title").html('Relation Management');
			$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
        //----------------------------------------------------------------------
     	// Load this function on page loaded.
     	// #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	// #2. Validation passed, now sync both remote and local database.	    		
	   	tycheesdb_initConsole(APP_NAME_RELATION);
		  	
    </script>
    
</body>
</html>
