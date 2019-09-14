
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES | REPORTS
    </title>

    <%@include file="/console/segment/include_stylesheets.jspf" %>
    
</head>


<style>

/* Landscape: iPad 1,2 */
@media only screen 
  and (min-device-width: 768px) 
  and (max-device-width: 1024px) 
  and (orientation: landscape) 
  and (-webkit-min-device-pixel-ratio: 1) {
	.widget-summary-text {
		font-size: 12pt;
	}
}
/* Landscape: iPad 3,4 */
@media only screen 
  and (min-device-width: 768px) 
  and (max-device-width: 1024px) 
  and (orientation: landscape) 
  and (-webkit-min-device-pixel-ratio: 2) {
	.widget-summary-text {
		font-size: 12pt;
	}
}

@media screen and (min-width: 1025px) {
	.widget-summary-text {
		font-size: 18pt;
	}
}

</style>

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
		                            <h1>REPORTS</h1>
		                            <ul class="folder-list m-b-md" style="padding: 0">
		                            	<!--
		                            	<li id="rep001_menu_1" onclick="rep001_executeAction('rep001_action_select_overview');" style="background-color:#FFFFFF;">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-bar-chart" aria-hidden="true"></i> OVERVIEW
		                                	</a>
		                                </li>
		                                -->
		                                
		                                <li id="rep001_menu_billing" onclick="rep001_selectMenu_billing();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-shopping-bag" aria-hidden="true"></i> BILLING 
		                                	</a>
		                                	<div id="rep001_menu_billing_nodes" style="display:none;">
			                                	<a id="rep001_menu_billing_node_1" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_billing_overview();">
													<i class="fa fa-sliders" aria-hidden="true"></i> 
													<span style="padding-left: 0px;"> OVERVIEW</span>
			                                	</a>
			                                	<a id="rep001_menu_billing_node_2" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_billing_orders();">
													<i class="fa fa-shopping-cart" aria-hidden="true"></i> 
													<span style="padding-left: 0px;"> ORDERS</span>
			                                	</a>
			                                	<a id="rep001_menu_billing_node_3" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_billing_payment();">
													<i class="fa fa-usd" aria-hidden="true"></i> 
													<span style="padding-left: 6px;"> PAYMENTS</span>
			                                	</a>
			                                	<a id="rep001_menu_billing_node_4" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_billing_gst();">
													<i class="fa fa-files-o" aria-hidden="true"></i> 
													<span style="padding-left: 0px;"> GST</span>
			                                	</a>
			                                </div>
		                                </li>
		                                
		                                <li id="rep001_menu_relation" onclick="rep001_selectMenu_relation();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-users" aria-hidden="true"></i>  RELATION
		                                	</a>
		                                	<div id="rep001_menu_relation_nodes" style="display:none;">
			                                	<a id="rep001_menu_relation_node_1" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_relation_overview();">
													<i class="fa fa-sliders" aria-hidden="true"></i> 
													<span style="padding-left: 0px;"> OVERVIEW</span>
			                                	</a>
			                                </div>
		                                </li>
		                                
		                                <li id="rep001_menu_inventory" onclick="rep001_selectMenu_inventory();">
		                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
		                                		<i class="fa fa-database" aria-hidden="true"></i> INVENTORY
		                                	</a>
		                                	<div id="rep001_menu_inventory_nodes" style="display:none;">
			                                	<a id="rep001_menu_inventory_node_1" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_inventory_overview();">
													<i class="fa fa-sliders" aria-hidden="true"></i> OVERVIEW
			                                	</a>	
			                                	<!-- 	                                	
			                                	<a id="rep001_menu_inventory_node_2" href="#" class="menu-node" style="padding-left:18px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_inventory_itemVariants();">
													<i class="fa fa-bar-chart" aria-hidden="true"></i> ITEM VARIANTS
			                                	</a>
			                                	<a id="rep001_menu_inventory_node_3" href="#" class="menu-node" style="padding-left:20px;padding-right:10px;font-size:12pt;" onclick="rep001_selectMenu_inventory_suppliers();">
													<i class="fa fa-truck" aria-hidden="true"></i> SUPPLIERS
			                                	</a>
			                                	-->			                                	 
			                                	<!-- 
			                                	<a id="rep001_menu_3_node_2" href="#" style="padding-left:40px;padding-right:10px;font-size:12pt;" onclick="rep001_02_executeAction('rep001_02_action_select_option1');">
													<i class="fa fa-files-o" aria-hidden="true"></i> CUSTOM REPORT 1
			                                	</a>
			                                	 -->
			                                </div>
		                                </li>	
		                                	                                
		                            </ul>
		                            <div class="clearfix"></div>
		                        </div>
		                    </div>
		                </div>
		            </div> <!-- col-lg-2 -->
	                <div class="col-md-9 col-lg-10 animated fadeInRight" style="padding:0px 5px;">	                 
	                
		                <!-- Billing Report: Overview -->
		                <%@include file="/console/reports/rep001/view/rep001_01/rep001_01_00.jsp" %>
		                <!-- Billing Report: Orders -->
		                <%@include file="/console/reports/rep001/view/rep001_01/rep001_01_01.jsp" %>
		                <!-- Billing Report: Payments -->
		                <%@include file="/console/reports/rep001/view/rep001_01/rep001_01_02.jsp" %>
		                <!-- Billing Report: GST -->
		                <%@include file="/console/reports/rep001/view/rep001_01/rep001_01_03.jsp" %>
		                		                
		                <!-- Relation Report: Overview -->
		                <%@include file="/console/reports/rep001/view/rep001_relation/rep001_relationOverview.jsp" %>
		                
		                <!-- Inventory Report: Overview -->
		                <!-- %@include file="/console/reports/rep001/view/rep001_02/rep001_02_00.jsp" %-->
		                <!-- Inventory Report: Custom 1 -->
		                <!-- %@include file="/console/reports/rep001/view/rep001_02/rep001_02_01.jsp" %-->		                
		                <!-- Inventory Report: Overview -->
		                <%@include file="/console/reports/rep001/view/rep001_inventory/rep001_inventoryOverview.jsp" %>		                
		                <!-- Inventory Report: Item Variants -->
		                <%@include file="/console/reports/rep001/view/rep001_inventory/rep001_inventoryItemVariants.jsp" %>		                
		                <!-- Inventory Report: Suppliers -->
		                <%@include file="/console/reports/rep001/view/rep001_inventory/rep001_inventorySuppliers.jsp" %>		                
		                
		                
	                </div> <!-- col-lg-10 -->
	            </div>
	        </div>         
        	<%@include file="/console/segment/footer_main.jsp" %>  
        </div>
        <%@include file="/console/segment/sidebar_right.jspf" %>  
    </div>
    
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
    
    <%@include file="/console/segment/include_scripts.jspf" %>
    
	<!-- Common JS -->
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/billing_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
    <script src="/console/_common/settings_common.js"></script>
	<!-- Modal -->
    <!-- View -->
    <script src="/console/reports/rep001/view/rep001.variables.js"></script>
    <script src="/console/reports/rep001/view/rep001.js"></script>
    
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
      	tycheesdb_initConsole(APP_NAME_REPORTS);
	  	//----------------------------------------------------------------------
	    
    </script>
    
</body>
</html>
