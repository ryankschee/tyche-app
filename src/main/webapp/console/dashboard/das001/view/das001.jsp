<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	Tychees | Console Dashboard 
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
        
            <div id="main-content" class="wrapper-content animated fadeInRight">   
                
                <div class="row">
                    <div class="col-md-3" style="padding:0px 5px;">
                        <%@include file="/console/dashboard/portlet/das_portlet_gotoModule_billing.jsp" %>
                    </div>
                    <div class="col-md-3" style="padding:0px 5px;">
                        <%@include file="/console/dashboard/portlet/das_portlet_gotoModule_calendar.jsp" %>
                    </div>
                    <div class="col-md-3" style="padding:0px 5px;">
                        <%@include file="/console/dashboard/portlet/das_portlet_gotoModule_inventory.jsp" %>
                    </div>
                    <div class="col-md-3" style="padding:0px 5px;">
                        <%@include file="/console/dashboard/portlet/das_portlet_gotoModule_relation.jsp" %>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3" style="padding:0px 5px;">
                        <!-- ROW #1: Module Access Pane -->
                        <%@include file="/console/dashboard/portlet/das_portlet_calendar_timeline.jsp" %>
                    </div>
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-4" style="padding:0px 5px;">
                                <%@include file="/console/dashboard/portlet/das_portlet_summary_newOrders.jsp" %>
                            </div>
                            <div class="col-md-4" style="padding:0px 5px;">
                                <%@include file="/console/dashboard/portlet/das_portlet_summary_sales.jsp" %>
                            </div>
                            <div class="col-md-4" style="padding:0px 5px;">
                                <%@include file="/console/dashboard/portlet/das_portlet_summary_visitors.jsp" %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" style="padding:0px 5px;">
                                <%@include file="/console/dashboard/portlet/das_portlet_chart_orders.jsp" %>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- ROW #1: Module Access Pane -->
                <!--%@include file="/console/dashboard/das001/view/das001_row01.jsp" %-->
                <!-- ROW #2: Quick Summary Pane -->
                <!--%@include file="/console/dashboard/das001/view/das001_row02.jsp" %-->
                <!-- ROW #3: Quick Report Pane -->
                <!--%@include file="/console/dashboard/das001/view/das001_row03.jsp" %-->
		        
            </div>
        
        	<%@include file="/console/segment/footer_main.jsp" %>   
        </div>        
        <%@include file="/console/segment/sidebar_right.jspf" %>  
    </div>
    
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>

	<!-- Common JS Scripts -->
    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
    <script src="/console/_common/settings_common.js"></script>
	<!-- Custom JS -->
    <script src="/console/dashboard/_common/das.variables.js"></script>
    <script src="/console/dashboard/das001/view/das001.variables.js"></script>
    <script src="/console/dashboard/das001/view/das001.js"></script> <!-- check file duplication -->
    
    <script>
        $(document).ready(function() {
	    	// common preload
	    	tycheesCommon_loadUI_preloadPage();	    	
	    	// custom preload
	    	my_preload_page();	
    	});
    	
	    function my_preload_page()
	    {
	        //das001_row01_init();
            //das001_row02_init();
            //das001_row03_init();
        } // .end of my_preload_page
        
	    function loadUI_custom()
	    {
			$("#page-title").html('Dashboard');
			$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
        //----------------------------------------------------------------------
     	// Load this function on page loaded.
     	// #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	
      	// #2. Validation passed, now sync both remote and local database.
      	tycheesdb_initConsole(APP_NAME_DASHBOARD);
	  	//----------------------------------------------------------------------
    </script>
</body>
</html>
