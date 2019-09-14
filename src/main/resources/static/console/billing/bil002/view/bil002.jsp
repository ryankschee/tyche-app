
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES | Cloud POS
    </title>

    <%@include file="/console/segment/include_stylesheets_billing.jspf" %>
    <%@include file="/console/segment/include_scripts_billing.jspf" %>
    
</head>


<body id="page-body" class="fixed-navigation" style="padding: 0px !important; padding-right: 0px !important;">
    <div id="wrapper" style="display:none;">
	    
	    <%@include file="/console/segment/sidebar_main.jsp" %>

        <div id="page-wrapper" class="gray-bg sidebar-content">
        
        	<%@include file="/console/segment/header_main.jsp" %>
        	
            <div id="header-section" class="row wrapper border-bottom white-bg page-heading" style="display:none;">
		        <div class="col-lg-12">
		        </div>
	        </div>
            
            <div id="module_spinner" class="spiner-example" style="display:none;">
				<div class="sk-spinner sk-spinner-wave">
				    <div class="sk-rect1"></div>
				    <div class="sk-rect2"></div>
				    <div class="sk-rect3"></div>
				    <div class="sk-rect4"></div>
				    <div class="sk-rect5"></div>
				</div>
			    <div id="module_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
			</div>
								
            <div id="main-content" class="wrapper-content animated fadeInRight" style="display:none; padding-top:0px;">  
                                
                <!-- TABLE VIEW -->
                <div class="row" id="bil002_tablePanel" class="animated fadeInRight" style="padding:10px;">                
            	    <div class="col-lg-12" id="bil002_canvas_parent" style="padding:10px;">
	            	</div>	            	
            	</div>
            	
            	<!-- ITEM MANSORY VIEW -->
            	<div class="row" id="bil002_cartPanel" class="animated fadeInRight" style="display:none;">
	            	<div class="col-md-7" style="padding:0px 0px;">
                        <div class="ibox" style="padding-top:10px;">
                            <div class="ibox-content" style="padding:5px 5px;">
                                <div id="bil002_cartPanel_itemView" class="animated fadeInRight">                                 
                                </div>
                            </div>
                        </div>
                    </div> <!-- end of col-md-6 -->
                    <div class="col-md-5" style="padding-top:10px;">
	            	    <div id="bil002_cartPanel_bucketList_header" class="ibox-title" style="background-color:#333333; color:#FFFFFF; font-size:16pt; padding:6px 10px;">
	                        <span id="bil002_cartPanel_bucketList_header_name">TABLE NAME</span>
	                        <span style="padding-left:10px; color:#1ab394; cursor:pointer;" onclick="bil002_printBucket();">
	                        	<i class="fa fa-print" aria-hidden="true"></i>
	                        </span>
	                        <span id="bil002_cartPanel_bucketList_header_totalAmount" class="pull-right">AMOUNT</span>
	                    </div>
                        <div id="bil002_cartPanel_bucketList_spinner" class="spiner-example" style="display:none; padding:20px; height:28px;">
							<div class="sk-spinner sk-spinner-wave">
							    <div class="sk-rect1"></div>
							    <div class="sk-rect2"></div>
							    <div class="sk-rect3"></div>
							    <div class="sk-rect4"></div>
							    <div class="sk-rect5"></div>
							</div>
						</div>   
						<div id="bil002_cartPanel_bucketList_content" class="ibox-content" style="display:none; padding:5px 5px;">
		                	<table id="bil002_cartPanel_bucketList_dataTable" class="table table-striped table-bordered table-hover">
		   	                    <thead>
		   	                        <tr>
		   	                            <th>ITEM</th>
		   	                            <th>PRICE</th>
		   	                            <th>QUANTITY</th>
		   	                            <th>ACTION</th>
		   	                        </tr>
		   	                    </thead>
		   	                    <tbody>
		   	                    </tbody>
		   	                </table>      
		   	            </div> 
                    </div>
                </div> <!-- end of row -->
            	
            	<!-- PAYMENT VIEW -->
            	<div id="bil002_paymentPanel" class="animated fadeInRight" style="display:none;">
            	    <div class="row">
            	    	<div class="col-md-2" style="padding:10px 0px;">
            	    	    <button type="button" class="btn btn btn-danger" style="width:48%" onclick="bil002_tablePanel_show();"> 
            	    	    	<i class="fa fa-chevron-left"></i> BACK
            	    	    </button>
            	    	    <button type="button" class="btn btn btn-primary" style="width:48%" onclick="bil002_cartPanel_show();"> 
            	    	    	<i class="fa fa-cart-plus" aria-hidden="true"></i> CART
            	    	    </button>
            	    	</div>
            	    	<div class="col-md-9">
	            			<div class="row">
	            				<div class="col-md-3" style="padding: 10px 0px 10px 10px;">
				            		<div id="bil001_orderNoDiv" style="padding-right:5px;" >
				        				<div class="input-group">
											<span class="input-group-btn">
				                            	<button type="button" class="btn btn-primary" style="height:34px; width:34px; font-size:10pt;" onclick="bil002_paymentPanel_addNewBilling();">
				                            		 <i class="fa fa-plus" aria-hidden="true"></i> 
				                            	</button> 
				                            </span> 
				                            <input id="bil002_billingNo" type="text" class="form-control" style="font-size:12pt; cursor:pointer;" onclick="bil002_paymentPanel_editBillingNo();" onfocus="$(this).blur();">
				                        </div>
				        			</div>
				                </div>
	            				<div class="col-md-6" style="padding: 10px 0px 10px 0px;">
				                    <div style="padding-right:5px;">
			            				<div class="input-group">
											<span class="input-group-btn">
			                                	<button id="bil002_searchCustomerButton" type="button" class="btn btn-primary" style="height:34px; width:110px; font-size:10pt;" onclick="bil002_paymentPanel_searchCustomer();">
			                                		 <i class="fa fa-search" aria-hidden="true"></i> Customer
			                                	</button> 
			                                </span> 
			                                <input id="bil002_customerName" type="text" class="form-control" style="font-size:12pt; cursor:pointer;" onclick="bil002_paymentPanel_showCustomerProfile();" onfocus="$(this).blur();">
			                                <span class="input-group-btn">
			                                	<button id="bil002_showCustomerPropertiesButton" type="button" class="btn btn-primary" style="height:34px; width:34px; font-size:16pt; padding:0px 2px;" onclick="bil002_paymentPanel_showCustomerProperties();">
			                                		<i class="fa fa-list-alt" aria-hidden="true"></i> 
			                                	</button> 
			                                </span>
			                            </div>
			            			</div>
			                    </div>
	            				<div class="col-md-3" style="padding: 10px 0px 10px 0px;">
			            			<div style="padding-right:5px;">
			            				<div id="billingForm_createdOn" class="form-group" style="margin:0px;">
			            					<div class="input-group date">
			            						<span class="input-group-btn" >
				                                	<button id="bil002_showScheduleButton" type="button" class="btn btn-primary" style="height:34px; width:34px; font-size:16pt; padding:0px 2px;" onclick="bil002_paymentPanel_showSchedule();">
				                                		 <i class="fa fa-calendar"></i>
				                                	</button> 
				                                </span>
			                        			<input id="bil002_billingDate" type="text" class="form-control" data-mask="99/99/9999" style="font-size:12pt; text-align:center;" value="">
			                    			</div>
			                            </div>                        				
			            			</div>
			                    </div>
			                </div>
	        			</div>
	        			<div class="col-md-1" style="padding: 10px 0px 10px 0px;">
	        				<span class="pull-right">
	        			    	<button id="bil002_printBillingButton" type="button" class="btn btn-primary ladda-button" data-style="zoom-in" style="height:34px; width:34px; font-size:16pt; padding:0px 2px;" onclick="bil002_paymentPanel_printBilling(this);">
	        			    		<i class="fa fa-print" aria-hidden="true"></i>
	        			    	</button>
	        			    	<button id="bil002_deleteBillingButton" type="button" class="btn btn-danger ladda-button" data-style="zoom-in" style="height:34px; width:34px; font-size:16pt; padding:0px 2px;" onclick="bil002_paymentPanel_deleteBilling(this);">
	        			    		<i class="fa fa-trash" aria-hidden="true"></i> 
	        			    	</button>
	        			    </span>
	        			</div>
            	    </div>
            	    <div class="row">
            	    	<div class="col-md-2" style="padding:0px 0px;">            	    		
            	    		<div class="ibox">
            	    			<div id="bil002_paymentPanel_billingList_header" class="ibox-title" style="background-color:#333333; color:#FFFFFF; font-size:16pt; padding:6px 10px;">
			                        TABLE NAME
			                    </div>
		                        <div class="ibox-content" style="padding-left:5px; padding-right:5px;">
		                            <div id="bil002_paymentPanel_billingList_spinner" class="spiner-example" style="display:none;">
										<div class="sk-spinner sk-spinner-wave">
										    <div class="sk-rect1"></div>
										    <div class="sk-rect2"></div>
										    <div class="sk-rect3"></div>
										    <div class="sk-rect4"></div>
										    <div class="sk-rect5"></div>
										</div>
									    <div id="bil002_paymentPanel_billingList_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
									</div>
		                            <ul id="bil002_paymentPanel_billingList" class="sortable-list connectList agile-list ui-sortable">	
		                            </ul>
		                        </div>
		                    </div>
            	    	</div>
		            	<div class="col-md-5" style="padding:0px 5px;">
		            	    <div id="bil002_paymentPanel_bucketList_header" class="ibox-title" style="background-color:#333333; color:#FFFFFF; font-size:16pt; padding:6px 10px;">
		                        <span id="bil002_paymentPanel_bucketList_header_name">TABLE NAME</span>
		                        <span style="padding-left:10px; color:#1ab394; cursor:pointer;" onclick="bil002_printBucket();">
		                        	<i class="fa fa-print" aria-hidden="true"></i>
		                        </span>
		                        <span id="bil002_paymentPanel_bucketList_header_totalAmount" class="pull-right">AMOUNT</span>
		                    </div>
	                        <div id="bil002_paymentPanel_bucketList_spinner" class="spiner-example" style="display:none; padding:20px; height:28px;">
								<div class="sk-spinner sk-spinner-wave">
								    <div class="sk-rect1"></div>
								    <div class="sk-rect2"></div>
								    <div class="sk-rect3"></div>
								    <div class="sk-rect4"></div>
								    <div class="sk-rect5"></div>
								</div>
							</div>   
							<div id="bil002_paymentPanel_bucketList_content" class="ibox-content" style="display:none; padding:10px 5px;">
			                	<table id="bil002_paymentPanel_bucketList_dataTable" class="table table-striped table-bordered table-hover">
			   	                    <thead>
			   	                        <tr>
			   	                            <th>ITEM</th>
			   	                            <th>PRICE</th>
			   	                            <th>QTY</th>
			   	                            <th>ACTION</th>
			   	                        </tr>
			   	                    </thead>
			   	                    <tbody>
			   	                    </tbody>
			   	                </table>      
			   	            </div> 
	                    </div> <!-- end of col-md-5 -->
	                    <div class="col-md-5" style="padding:0px 0px;">
	    				    <div class="ibox">
	                            <div class="ibox-content" style="padding:0px 5px;">
	                                <div class="tab-content">
	                                    <div id="contact-1" class="tab-pane active">
	                                    	<div class="row m-b-lg" style="margin:0;">
	                                            <div class="col-lg-12 text-center" style="padding:0;">
	   												<div class="widget blue-bg p-lg text-center" style="margin:0;padding:0;cursor:pointer;" onclick="bil002_paymentPanel_showPaymentTerminal();">
	   													<div class="m-b-md" style="margin:0;">
	   														<p class="m-xs" class="font-bold no-margins" style="text-align:right;">
	   															<span class="currency" style="font-size:20pt;">$CURRENCY</span>
	   															<span id="bil002_billableAmount" style="font-size:40pt;">0.00</span>
	   														</p>
	   														
	   														<div class="row">
	   														    <div class="col-md-6">
	   														        <p style="text-align:left; padding-left:10px; margin-bottom:0;">
	   															        <small>Payment Balance</small>
	   														        </p>
	   														    </div>
	   														    <div class="col-md-6">
	   														        <p style="text-align:right;padding-right:10px;margin-bottom:0;">
	   															        <small>Subtotal</small>
	   														        </p>
	   														    </div>
	   														</div>
	   														
	   														<div class="row">
	   														    <div class="col-md-6">
	   														        <p class="font-bold no-margins" style="font-size:20pt; text-align:left; padding-left:10px;">
			   															<span id="bil002_paymentBalance_currency" class="currency" style="font-size:16pt;">$CURRENCY</span>
			   															<span id="bil002_paymentBalance" style="font-size:20pt;"></span>
			   														</p>
	   														    </div>
	   														    <div class="col-md-6">
	   														        <p class="font-bold no-margins" style="font-size:20pt; text-align:right; padding-right:10px;">
			   															<span class="currency" style="font-size:16pt;">$CURRENCY</span>
			   															<span id="bil002_billingSubtotal" style="font-size:20pt;"></span>
			   														</p>
	   														    </div>
	   														</div>
	   													</div>
	   												</div>
	                                            </div>
	                                        </div> 
	                                        
	    									<table id="bil002_billingLine_commonPanel" class="table table-striped table-hover" style="margin-top:10px;">
	    										<thead>
	    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
	    												<!--td></td-->
	    												<td style="width:300px;height:20px;padding:0px 0px 0px 10px;">ITEM NAME</td>
	    												<td style="width:80px;height:20px;padding:0px 4px 0px 0px;"><span class="pull-right">U.PRICE</span></td>
	    												<td style="width:60px;height:20px;padding:0px 4px 0px 0px;"><span class="pull-right">%</span></td>
	    												<td style="width:60px;height:20px;padding:0px 4px 0px 0px;"><span class="pull-right">QTY</span></td>
	    												<td></td>
	    											</tr>
	    										</thead>
	    										<tbody id="bil002_billingLine_commonTable">
	    										</tbody>
	    									</table>  
	    									<table id="bil002_billingLine_discountPanel" class="table table-striped table-hover" style="display:none;">
	    										<thead>
	    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
	    												<td></td>
	    												<td colspan="7" style="height:20px;padding:0px;">DISCOUNTS on TOTAL BILL</td>
	    											</tr>
	    										</thead>
	    										<tbody id="bil002_billingLine_discountTable">
	    										</tbody>
	    									</table>  
	    									<table id="bil002_billingLine_taxPanel" class="table table-striped table-hover" style="display:none;">
	    										<thead>
	    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
	    												<td></td>
	    												<td colspan="7" style="height:20px;padding:0px;">TAXES on TOTAL BILL</td>
	    											</tr>
	    										</thead>
	    										<tbody id="bil002_billingLine_taxTable">
	    										</tbody>
	    									</table>                                    
	                                    </div>                  
	                                </div>
	                            </div>
	                        </div>
	                    </div> <!-- end of col-sm-4 -->
	                </div>
                </div> <!-- end of row -->
            	
	        </div> <!-- end of main-content -->
	        
        	<%@include file="/console/segment/footer_main.jsp" %>          
            
        </div> <!-- end of page-wrapper -->
            	
		<!-- MODAL WINDOW: Reset Password -->
		<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
            	
	    <!-- MODAL WINDOW : Edit Billing No -->
		<%@include file="/console/_view/billing/view_mw_editBillingNo.jsp" %>
	    <!-- MODAL WINDOW : Search Customer Window -->
		<%@include file="/console/_view/relation/view_mw_customerSearch.jsp" %>
	    <!-- MODAL WINDOW : Customer Profile Window -->
		<%@include file="/console/_view/view_mw_customerProfile.jsp" %>
	    <!-- MODAL WINDOW : Search Billing Window -->
		<%@include file="/console/_view/view_mw_billingSearch.jsp" %>
	    <!-- MODAL WINDOW : Payment Terminal Window -->
		<%@include file="/console/_view/view_mw_paymentTerminal.jsp" %>
	    <!-- MODAL WINDOW : PDF Preview Window -->
		<%@include file="/console/_view/view_mw_pdfPreview.jsp" %>
		
        <!-- Side Window: Table Details -->
    	<%@include file="/console/billing/bil002/view/bil002_sw001.jsp" %> 
    	<!-- Modal Window: New Reservation -->
    	<%@include file="/console/billing/bil002/view/bil002_mw001.jsp" %> 	
    	<!-- Modal Window: Print Billing -->
    	<%@include file="/console/billing/bil002/view/bil002_mw_printBilling.jsp" %> 	
    	<!-- Modal Window: Print Bucket -->
    	<%@include file="/console/billing/bil002/view/bil002_mw_printBucket.jsp" %> 	
	    <!-- MODAL WINDOW : Billing Properties -->
		<%@include file="/console/billing/bil002/view/bil002_mw006.jsp" %>
	    <!-- MODAL WINDOW : Calendar -->
		<%@include file="/console/billing/bil002/view/bil002_mw007.jsp" %>
	    <!-- MODAL WINDOW : Billing Line Details: RAW, PRODUCT, SERVICE, EVENT -->
		<%@include file="/console/billing/bil002/view/bil002_mw008.jsp" %>
	    <!-- MODAL WINDOW : Billing Line Details: TAX, DISCOUNT -->
		<%@include file="/console/billing/bil002/view/bil002_mw009.jsp" %>
	    
    </div> <!-- end of wrapper -->
		
    
	<!-- Common JS -->
    <script src="/console/_common/canvas_common.js"></script>
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/billing_common.js"></script>
    <script src="/console/_common/billingBucket_common.js"></script>
    <script src="/console/_common/document_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
    <script src="/console/_common/settings_common.js"></script>
    <script src="/console/_util/place_util.js"></script>
    <!-- Modal -->
    <!-- View -->
    <script src="/console/billing/bil002/view/bil002.variables.js"></script>
    <script src="/console/billing/bil002/view/bil002.js"></script>
    <script src="/console/billing/bil002/view/bil002.panel.tables.js"></script>
    <script src="/console/billing/bil002/view/bil002.panel.cart.js"></script>
    <script src="/console/billing/bil002/view/bil002.panel.payment.js"></script>
    <!-- Controller -->
    <script src="/console/billing/bil002/controller/bil002_controller.js"></script>
    <script src="/console/inventory/inv002/controller/controller_00.js"></script>
    
    <!-- Document Processor -->
    <script src="/console/document/processor/processor_DRK001_001.js"></script>
    <script src="/console/document/processor/processor_FOD001_001.js"></script>
    <script src="/console/document/processor/processor_FOR001_001.js"></script>
    <script src="/console/document/processor/processor_INV001_001.js"></script>
    <script src="/console/document/processor/processor_RCP001_001.js"></script>
    <script src="/console/document/processor/processor_QUO001_001.js"></script>
    
    
    <script>
     
	    $(document).ready(function() {	    
	    	// common preload
	    	tycheesCommon_loadUI_preloadPage();	    	
	    	// custom preload
	    	my_preload_page();
	    });
	    
	    function my_preload_page()
	    {			
	        // Init DataTable
	        $('#bil002_cartPanel_bucketList_dataTable').DataTable({
	            "paging":   false,
	            "ordering": false,
	            "info":     false
	        });	   
	        $("#bil002_cartPanel_bucketList_dataTable_filter").detach();
	        
	        $('#bil002_paymentPanel_bucketList_dataTable').DataTable({
	            "paging":   false,
	            "ordering": false,
	            "info":     false
	        });	
	        $("#bil002_paymentPanel_bucketList_dataTable_filter").detach();
	        
	        // Init DatePicker
			$('#bil002_billingDate').datepicker({
		    	format: 'dd/mm/yyyy',
		    	todayBtn: 'linked',
		    	todayHighlight: true,
		        keyboardNavigation: false,
		        forceParse: false,
		        calendarWeeks: true,
		        autoclose: true
		    });
	        
			$("#bil002_paymentPanel_billingList").sortable({
                connectWith: ".connectList",
                update: function( event, ui ) {

                    var inprogress = $( "#bil002_paymentPanel_billingList" ).sortable( "toArray" );
                }
            }).disableSelection();
	    }
	    
        /**
         * Called by initApp() in billing-pos.main.js
         */
	    function loadUI_custom()
	    {
	    	// Set Currency
	    	global_currencySign = settingsCommon_getSettingsValue(
									ModuleConstants.MODULE_BILLING, 
									ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
									SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
	    	$('.currency').html( global_currencySign );					
	    	
	    	$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
		//----------------------------------------------------------------------
        // BEGIN: 
	    // Load this function on page loaded.
	    // #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	// #2. Validation passed, now sync both remote and local database.
      	tycheesdb_initConsole(APP_NAME_POS);
	    	
    </script>
    
</body>
</html>
