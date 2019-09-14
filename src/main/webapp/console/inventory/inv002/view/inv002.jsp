<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	Tychees | Inventory Control 2.0
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
            
            	<!-- Menu Header -->
            	<!-- %@include file="/console/inventory/inv001/view/inv001_01/inv001_01_segment00.jsp" %-->
	            
            	<div class="row">
	            	<div class="col-md-4" style="padding:0px 5px 0px 0px;">
	                    <%@include file="/console/inventory/inv002/view/inv002_segment01.jsp" %>
	                </div> <!-- .end of col-md-4 -->
	            	<div class="col-md-8" style="padding:0px 0px 0px 5px;">
	            		<%@include file="/console/inventory/inv002/view/inv002_segment02.jsp" %>  
	            	</div> <!-- .end of col-md-8 -->
            	</div> <!-- .end of row -->
	        </div>            
            
        	<%@include file="/console/segment/footer_main.jsp" %>          
            
        </div>
        
        <%@include file="/console/inventory/inv002/view/inv002_segment03.jsp" %>  
        
    </div>
    
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
    
	<!-- Common JS Scripts -->
    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
    <script src="/console/_common/settings_common.js"></script>
    <script src="/console/_util/inventory_util.js"></script>
    <!-- Modal -->
    <!-- View -->
    <script src="/console/inventory/inv002/view/inv002.variables.js"></script>
    <script src="/console/inventory/inv002/view/inv002.js"></script>
    <!-- Controller -->
    <script src="/console/inventory/inv002/controller/controller_localdb.js"></script>
    <script src="/console/inventory/inv002/controller/controller_00.js"></script>
    <script src="/console/inventory/inv002/controller/controller_01.js"></script>
    
    <script>
	    $(document).ready(function() {
	    	// common preload
	    	tycheesCommon_loadUI_preloadPage();	    	
	    	// custom preload
	    	my_preload_page();	
	    });
	    
	    function my_preload_page()
	    {
			// initialiase iCheck components
	        tycheesCommon_initCheckBox();
	        // initialiase datePicker components
	        tycheesCommon_initDatePicker();
	    } // .end of my_preload_page
        
	    function loadUI_custom()
	    {
			$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
        //----------------------------------------------------------------------
     	// Load this function on page loaded.
     	// #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	// #2. Validation passed, now sync both remote and local database.
	    tycheesdb_initConsole(APP_NAME_INVENTORY);	
	  	//----------------------------------------------------------------------
	    
    </script>
    
</body>
</html>
