<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES | CALENDAR
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
	                <div class="col-md-3" style="padding:0px 5px;">
		                <div class="ibox float-e-margins">
		                    <div class="ibox-content mailbox-content" style="padding:0px 5px;">
		                        <div class="file-manager">
		                            <h1><i class="fa fa-calendar" aria-hidden="true"></i> CALENDAR</h1>
		                            <ul class="folder-list m-b-md" style="padding: 0">
		                            	<li id="cal001_sidebar_menu_1" onclick="cal001_mw001_show();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-calendar-plus-o" aria-hidden="true"></i> CREATE CALENDAR
		                                	</a>
		                                </li>
		                                <li id="cal001_sidebar_menu_2" onclick="cal001_mw004_show();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-calendar-plus-o" aria-hidden="true"></i> CREATE EVENT
		                                	</a>
		                                </li>
		                                <li style="padding-top:30px;">
		                                </li>
		                                <li id="cal001_sidebar_menu_3">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-home" aria-hidden="true"></i> PLACE CALENDAR
		                                	</a>
				                    		<div id="cal001_placeCalendarList" style="padding-top:6px;"></div>
		                                </li>
		                                <li id="cal001_sidebar_menu_4">
		                                	<a href="#" style="padding-left:10px;padding-right:0px;font-size:12pt;"> 
		                                		<i class="fa fa-user" aria-hidden="true"></i> MY CALENDAR
		                                		<span id="cal001_myCalendars_count" class="label label-warning"></span>
			                                	<span class="button btn-xs btn-white pull-right mycalendars-expanded" style="cursor:pointer;padding-left:10px;" onclick="cal001_myCalendars_toggleList(this);">
			                                        <i class="fa fa-minus-square-o" aria-hidden="true"></i>
			                                    </span>
		                                	</a>
						                    <div id="cal001_userCalendarList" style="padding-top:6px;"></div>
		                                </li>
		                            </ul>
		                            <div class="clearfix"></div>
		                        </div>
		                    </div>
		                </div>
		            </div> <!-- col-lg-3 -->
	                <div class="col-md-9 animated fadeInRight" style="padding:0px 5px;">	                 
	                	<div class="ibox float-e-margins">
			                <div class="ibox-content" style="border-width:0px 0px;">
			                    <div id="cal001_calendar"></div>
			                </div>
			            </div>
	                </div> <!-- col-lg-10 -->
	            </div>
	        </div>         
        	<%@include file="/console/segment/footer_main.jsp" %>  
        </div>
        <%@include file="/console/segment/sidebar_right.jspf" %>  
    </div>
    
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
    
    <!-- CALENDAR: Create Event -->
	<%@include file="/console/calendar/cal001/view/cal001_mw001.jsp" %>
	<!-- CALENDAR: Create Event -->
	<%@include file="/console/calendar/cal001/view/cal001_mw002.jsp" %>
	<!-- CALENDAR: Create Event -->
	<%@include file="/console/calendar/cal001/view/cal001_mw003.jsp" %>
	<!-- CALENDAR: Create Event -->
	<%@include file="/console/calendar/cal001/view/cal001_mw004.jsp" %>
	<!-- CALENDAR: Edit Event -->
	<%@include file="/console/calendar/cal001/view/cal001_mw005.jsp" %>
	    

    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/billing_common.js"></script>
	<!-- Modal -->
    <!-- View -->
    <script src="/console/calendar/cal001/view/cal001.variables.js"></script>
    <script src="/console/calendar/cal001/view/cal001.js"></script>
    
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
			//$("#page-title").html('Relation Management');
			$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
        //----------------------------------------------------------------------
     	// Load this function on page loaded.
     	// #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	
      	// #2. Validation passed, now sync both remote and local database.
      	tycheesdb_initConsole(APP_NAME_CALENDAR);
	  	//----------------------------------------------------------------------
	    
    </script>
    
</body>
</html>
