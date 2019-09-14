<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
    	TYCHEES | Cloud POS
    </title>

    <%@include file="/console/segment/include_stylesheets.jspf" %>
    <%@include file="/console/segment/include_scripts.jspf" %>
    
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
            	
            	<div class="row">
	                <div class="col-lg-2">
	                    <div id="panelAction_buttonSearch" class="widget style1 navy-bg" onclick="page_executeAction('page_actionName_searchBilling');" style="cursor:pointer; padding:8px;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                            	<i class="fa fa-search fa-3x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <h3 class="font-bold">SEARCH</h3>
                           			<span id="panelAction_search_totalBills" style="display:none;"></span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-2">
	                    <div id="panelAction_buttonStatus" class="widget style1 navy-bg" onclick="page_executeAction('page_actionName_showWorkflow');" style="cursor:pointer; padding:8px;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-tasks fa-3x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <h3 class="font-bold">STATUS</h3>
                           			<span id="panelAction_workflow_status"></span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-2">
	                    <div id="panelAction_buttonPayment" class="widget style1 navy-bg" onclick="page_executeAction('page_actionName_makePayment');" style="cursor:pointer; padding:8px;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-usd fa-3x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <h3 class="font-bold">PAYMENT</h3>
                           			<span id="panelAction_payment_amount"></span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-2">
	                    <div id="panelAction_buttonDelivery" class="widget style1 navy-bg" onclick="page_executeAction('page_actionName_makeDelivery');" style="cursor:pointer; padding:8px;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-truck fa-3x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <h3 class="font-bold">DELIVERY</h3>
                           			<span id="panelAction_delivery_dateTime"></span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-2">
	                    <div id="panelAction_buttonPrint" class="widget style1 navy-bg"  onclick="page_executeAction('page_actionName_printBilling');" style="cursor:pointer; padding:8px;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-print fa-3x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <h3 class="font-bold">PRINT</h3>
                           			<span id="panelAction_print_message"></span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-2">
	                    <div id="panelAction_buttonClose" class="widget style1 navy-bg" data-toggle="modal" onclick="page_executeAction('page_actionName_closeBilling');" style="cursor:pointer; padding:8px;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-times fa-3x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <h3 class="font-bold">CLOSE</h3>
                           			<span id="panelAction_close_message"></span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
            	         
	            <div class="row">
                    <div class="col-sm-6">
                        <div class="ibox">
                            <div class="ibox-content">
                            	<!-- 
                            	<span class="dropdown pull-right open" style="padding-left:10px;">
								  <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="true">
								  	Select View <span class="caret"></span>
								  </button>
								  <ul class="dropdown-menu">
								    <li><a href="#" onclick="page_executeAction('page_actionName_switchMenuToList');"><i class="fa fa-list" aria-hidden="true"></i> List View</a></li>
								    <li><a href="#" onclick="page_executeAction('page_actionName_switchMenuToBlock');"><i class="fa fa-th" aria-hidden="true"></i> Masonry View</a></li>
								  </ul>
								</span>
								 -->
                                <div id="itemView">                                 
                                </div>
                            </div>
                        </div>
                    </div> <!-- end of col-sm-8 -->
                    
                    <div class="col-sm-6">
    				    <div class="ibox">
                            <div class="ibox-content">
                                <div class="tab-content">
                                    <div id="contact-1" class="tab-pane active">	
                                    
		                        		<div class="row" style="padding-bottom:5px;">
		                        			<div class="col-md-8" style="padding-right:5px;" id="bil001_orderNoDiv">
		                        				<div class="input-group">
													<span class="input-group-btn">
				                                    	<button type="button" class="btn btn-primary" style="height:46px;width:120px;font-size:12pt;" onclick="page_executeAction('page_actionName_searchBilling');">
				                                    		 Order #
				                                    	</button> 
				                                    </span> 
				                                    <input type="text" class="form-control input-lg" style="font-size:16pt;cursor:pointer;" id="bil001_menuPanel_billingNo" value="" onclick="page_executeAction('page_actionName_editBillingNo');" onfocus="$(this).blur();">
				                                    <span class="input-group-btn">
				                                    	<button type="button" class="btn btn-primary" style="height:46px;width:46px;font-size:16pt;" onclick="page_executeAction('page_actionName_editBillingNo');">
				                                    		<i class="fa fa-pencil" aria-hidden="true"></i>
				                                    	</button> 
				                                    </span> 
				                                </div>
		                        			</div>
		                        			<div class="col-md-8" style="padding-right:5px;" id="bil001_quotationNoDiv" style="display:none;">
		                        				<div class="input-group">
													<span class="input-group-btn">
				                                    	<button type="button" class="btn btn-warning" style="height:46px;width:120px;font-size:12pt;" onclick="page_executeAction('page_actionName_openQuotationOptions');">
				                                    		 Quotation #
				                                    	</button> 
				                                    </span> 
				                                    <input type="text" class="form-control input-lg" style="font-size:16pt;cursor:pointer;" id="bil001_menuPanel_quotationNo" value="" onclick="page_executeAction('page_actionName_editQuotationNo');" onfocus="$(this).blur();">
				                                    <span class="input-group-btn">
				                                    	<button type="button" class="btn btn-primary" style="height:46px;width:46px;font-size:16pt;" onclick="page_executeAction('page_actionName_editQuotationNo');">
				                                    		<i class="fa fa-pencil" aria-hidden="true"></i>
				                                    	</button> 
				                                    </span> 
				                                </div>
		                        			</div>
		                        			<div class="col-md-4">
		                        				<span class="pull-right">
		                        			    	<button type="button" class="btn btn-primary" style="height:46px;width:46px;font-size:16pt;margin-right:5px;" onclick="page_executeAction('page_actionName_openBillingCalendar');">
		                        			    		<i class="fa fa-calendar" aria-hidden="true"></i>
		                        			    	</button>
		                        			    	<button type="button" class="btn btn-primary" style="height:46px;width:46px;font-size:16pt;margin-right:5px;" onclick="page_executeAction('page_actionName_setProfile');">
		                        			    		<i class="fa fa-list-alt" aria-hidden="true"></i> 
		                        			    	</button>
		                        			    	<button type="button" class="btn btn-danger" style="height:46px;width:46px;font-size:16pt;" onclick="page_executeAction('page_actionName_deleteBilling');">
		                        			    		<i class="fa fa-trash" aria-hidden="true"></i> 
		                        			    	</button>
		                        			    </span>
		                        			</div>
		                        		</div> <!-- .end of row -->
		                        		
		                        		<div class="row">
		                        			<div class="col-md-8" style="padding-right:5px;">
		                        				<div class="input-group">
													<span class="input-group-btn">
				                                    	<button type="button" class="btn btn-primary" style="height:46px;width:120px;font-size:12pt;" onclick="page_executeAction('page_actionName_searchCustomer');">
				                                    		 Customer
				                                    	</button> 
				                                    </span> 
				                                    <input type="text" class="form-control input-lg" style="font-size:16pt;cursor:pointer;" id="bil001_menuPanel_customerName" value="" onclick="page_executeAction('page_actionName_showCustomer');" onfocus="$(this).blur();">
				                                    <span class="input-group-btn">
				                                    	<button type="button" class="btn btn-primary" style="height:46px;width:46px;font-size:16pt;" onclick="page_executeAction('page_actionName_showCustomer');">
				                                    		<i class="fa fa-user" aria-hidden="true"></i> 
				                                    	</button> 
				                                    </span> 
				                                </div>
		                        			</div>
		                        			<div class="col-md-4">
		                        				<div id="billingForm_createdOn" class="form-group" style="margin:0px;">
		                        					<div class="input-group date">
		                                    			<span class="input-group-addon">
		                                    				<i class="fa fa-calendar"></i>
		                                    			</span>
		                                    			<input type="text" id="bil001_menuPanel_billingCreatedOn" class="form-control input-lg" data-mask="99/99/9999" style="font-size:16pt;" value="">
		                                			</div>
					                            </div>                        				
		                        			</div>
		                        		</div> <!-- .end of row -->
		                        		
                                    	<div class="row m-b-lg" style="margin:0;">
                                            <div class="col-lg-12 text-center" style="padding:0;">
   												<div class="widget blue-bg p-lg text-center" style="margin:0;padding:0;cursor:pointer;" onclick="page_executeAction('page_actionName_makePayment');">
   													<div class="m-b-md" style="margin:0;">
   														<p class="m-xs" class="font-bold no-margins" style="text-align:right;">
   															<span id="bil001_paymentPanel_totalPayable_currency" style="font-size:20pt;">$CURRENCY</span>
   															<span id="bil001_paymentPanel_totalPayable" style="font-size:40pt;">0.00</span>
   														</p>
   														<p style="text-align:right;padding-right:10px;margin-bottom:0;">
   															<small>Subtotal</small>
   														</p>
   														<p class="font-bold no-margins" style="font-size:20pt;text-align:right;padding-right:10px;">
   															<span id="bil001_paymentPanel_subtotal_currency" style="font-size:16pt;">$CURRENCY</span>
   															<span id="bil001_paymentPanel_subtotal" style="font-size:20pt;"></span>
   														</p>
   													</div>
   												</div>
                                            </div>
                                            <!--
                                            <div class="col-lg-4 text-center" style="padding-right:0px;padding-left:20px;">
                                    			<div id="panelAction_buttonTax" class="widget style1 lazur-bg" onclick="page_executeAction('page_actionName_openTax');" style="cursor:pointer; margin: 5px 0px 5px 0px;padding:5px 10px 5px 10px;">
	                        						<div class="row vertical-align">
	                            						<div class="col-xs-12 text-right">
	                                						<h5 class="font-bold" style="margin:0px;">ITEMIZED TAX</h5>
                           									<span id="summaryPanelTax_currency" style="font-size:12pt;">$CURRENCY</span> 
                           									<span id="summaryPanelTax" style="font-size:12pt;">0.00</span>
	                            						</div>
	                        						</div>
	                    						</div>
	                    						<div id="panelAction_buttonDiscounty" class="widget style1 lazur-bg" onclick="page_executeAction('page_actionName_openDiscount');" style="cursor:pointer; margin: 5px 0px 5px 0px;padding:5px 10px 5px 10px;">
	                        						<div class="row vertical-align">
	                            						<div class="col-xs-12 text-right">
	                                						<h5 class="font-bold" style="margin:0px;">ITEMIZED DISCOUNT</h5>
                           									<span id="summaryPanelDiscount_currency" style="font-size:12pt;">$CURRENCY</span> 
                           									<span id="summaryPanelDiscount" style="font-size:12pt;">0.00</span>
	                            						</div>
	                        						</div>
	                    						</div>
                                    		</div>
                                    		-->
                                        </div> <!-- .end of row -->
                                        
    									<table class="table table-striped table-hover" style="margin-top:10px;">
    										<thead>
    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
    												<!--td></td-->
    												<td style="width:300px;height:20px;padding:0px 0px 0px 10px;">ITEM NAME</td>
    												<td style="width:80px;height:20px;padding:0px 4px 0px 0px;"><span class="pull-right">U.PRICE</span></td>
    												<td style="width:60px;height:20px;padding:0px 4px 0px 0px;"><span class="pull-right">%</span></td>
    												<td style="width:80px;height:20px;padding:0px 4px 0px 0px;"><span class="pull-right">QTY</span></td>
    												<td></td>
    												<td></td>
    												<td></td>
    											</tr>
    										</thead>
    										<tbody id="bil001_cartPanel_billingLineTable">
    										</tbody>
    									</table>  
    									<table class="table table-striped table-hover" id="bil001_cartPanel_billingDiscountTableRoot" style="display:none;">
    										<thead>
    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
    												<td></td>
    												<td colspan="7" style="height:20px;padding:0px;">DISCOUNTS on TOTAL BILL</td>
    											</tr>
    										</thead>
    										<tbody id="bil001_cartPanel_billingDiscountTable">
    										</tbody>
    									</table>  
    									<table class="table table-striped table-hover" id="bil001_cartPanel_billingTaxTableRoot" style="display:none;">
    										<thead>
    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
    												<td></td>
    												<td colspan="7" style="height:20px;padding:0px;">TAXES on TOTAL BILL</td>
    											</tr>
    										</thead>
    										<tbody id="bil001_cartPanel_billingTaxTable">
    										</tbody>
    									</table>                                    
                                    </div>                  
                                </div>
                            </div>
                        </div>
                    </div> <!-- end of col-sm-4 -->
                </div> <!-- end of row -->
	        </div> <!-- end of main-content -->
	        
	        <a id="printDocument_link" href="#" style="display:none;" target="_blank">TEST LINK</a>
            
        	<%@include file="/console/segment/footer_main.jsp" %>          
            
        </div> <!-- end of page-wrapper -->
        
    </div> <!-- end of wrapper -->
		
          	
	<!-- Common JS -->
    <script src="/console/_common/console_common.js"></script>
    <script src="/console/_common/billing_common.js"></script>
    <script src="/console/_common/document_common.js"></script>
    <script src="/console/_common/inventory_common.js"></script>
    <script src="/console/_common/settings_common.js"></script>
    <script src="/console/_util/place_util.js"></script>
    <!-- Modal -->
    <!-- View -->
    <script src="/console/billing/bil001/view/bil001.variables.js"></script>
    <script src="/console/billing/bil001/view/bil001.js"></script>
    <!-- Controller -->
    <script src="/console/inventory/inv002/controller/controller_00.js"></script>
    <script src="/console/billing/bil001/controller/controller_localdb.js"></script>
    <script src="/console/billing/bil001/controller/controller_01.js"></script>
    
    <!-- Document Processor -->
    <script src="/console/document/processor/processor_FOR001_001.js"></script>
    <script src="/console/document/processor/processor_INV001_001.js"></script>
    <script src="/console/document/processor/processor_INV001_002.js"></script>
    <script src="/console/document/processor/processor_INV001_003.js"></script>
    <script src="/console/document/processor/processor_RCP001_001.js"></script>
    <script src="/console/document/processor/processor_RCP001_002.js"></script>
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
	    	// Init DatePicker
			$('#billingForm_createdOn .input-group.date').datepicker({
		    	format: 'dd/mm/yyyy',
		    	todayBtn: 'linked',
		    	todayHighlight: true,
                keyboardNavigation: false,
                forceParse: false,
                calendarWeeks: true,
                autoclose: true
		    });

			$("#bil001_menuPanel_billingCreatedOn").val( tycheesDateTime_getFormattedDate_ddMMyyyy( $.now() ) );
			
			$("#bil001_menuPanel_billingCreatedOn").on('change', function(){				
			    // Auto-save Billing
			    bil001_menuPanel_save();			    
			});
	    }
	    
        /**
         * Called by initApp() in billing-pos.main.js
         */
	    function loadUI_custom()
	    {
	    	// Set Currency
	    	var currency = settingsCommon_getSettingsValue(
	    								ModuleConstants.MODULE_BILLING, 
	    								ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
	    								SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
	    	$('#bil001_paymentPanel_totalPayable_currency').html( currency );
	    	$('#bil001_paymentPanel_subtotal_currency').html( currency );
	    	$('#summaryPanelTax_currency').html( currency );
	    	$('#summaryPanelDiscount_currency').html( currency );
	    	
	    	$("#wrapper").show();
			$("#main-content").show(); 		
	    } // .end of loadUI_custom
	    
		//----------------------------------------------------------------------
        // BEGIN: 
	    // Load this function on page loaded.
	    // #1. Validate session, IF fail, goto login screen
      	tycheesCommon_validateConsoleSession();
      	// #2. Validation passed, now sync both remote and local database.
      	tycheesdb_initIDB(APP_NAME_POS);
	    	
    </script>
    
</body>
</html>
