<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES
        | 
    	REGISTER NEW PLACE
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
	                <div class="col-lg-2">
		                <div class="ibox float-e-margins">
		                    <div class="ibox-content mailbox-content">
		                        <div class="file-manager">
		                            <h1>PLACE</h1>
		                            <ul class="folder-list m-b-md" style="padding: 0">
		                                <li id="rel001_sidebar_menu_02" onclick="rel001_executeAction('rel001_action_select_customer');">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> NEW REGISTRATION
		                                	</a>
		                                </li>
		                            </ul>
		                            <div class="clearfix"></div>
		                        </div>
		                    </div>
		                </div>
		            </div> <!-- col-lg-2 -->
	                <div class="col-lg-10 animated fadeInRight">	                 
	                	
	                </div> <!-- col-lg-10 -->
	            </div>
	        </div>         
        	<%@include file="/console/segment/footer_main.jsp" %>  
        </div>
        <%@include file="/console/segment/sidebar_right.jspf" %>  
    </div>
    

    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
	<!-- Modal -->
    <!-- View -->
    <script src="/console/place/pla001/view/pla001.variables.js"></script>
    <script src="/console/place/pla001/view/pla001.js"></script>
    
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
	
	  	//----------------------------------------------------------------------
	    
    </script>
    
</body>
</html>
