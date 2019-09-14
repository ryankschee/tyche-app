
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

<style>
.tooltip-right {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tooltip-right .tooltiptext-right {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
    top: -5px;
    left: 105%;
}

.tooltip-right:hover .tooltiptext-right {
    visibility: visible;
}

.tooltip-left {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tooltip-left .tooltiptext-left {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
    top: -5px;
    right: 105%;
}

.tooltip-left:hover .tooltiptext-left {
    visibility: visible;
}

.tooltip-top {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tooltip-top .tooltiptext-top {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
    bottom: 100%;
    left: 50%;
    margin-left: -60px;
}

.tooltip-top:hover .tooltiptext-top {
    visibility: visible;
}

.tooltip-bottom {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tooltip-bottom .tooltiptext-bottom {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
    top: 100%;
    left: 50%;
    margin-left: -60px;
}

.tooltip-bottom:hover .tooltiptext-bottom {
    visibility: visible;
}
</style>

<body id="page-body" class="fixed-navigation" style="padding: 0px !important; padding-right: 0px !important;">
    <div id="wrapper" style="display:none;">
	    
	    <%@include file="/console/segment/sidebar_main.jsp" %>

        <div id="page-wrapper" class="gray-bg sidebar-content">
        
        	<%@include file="/console/segment/header_main.jsp" %>
        	
            <div id="header-section" class="row wrapper border-bottom white-bg page-heading" style="display:none;">
		        <div class="col-md-12 col-lg-12">
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
            		<div class="col-md-9">
            			<div class="row">
            				<div class="col-md-3" style="padding: 10px 0px 10px 0px;">
		            			<div style="padding-right:5px;">
		            				<div id="bil001_menuPanel_billingCalendar" class="form-group" style="margin:0px;">
		            					<div class="input-group date">
		            						<span class="input-group-btn" >
			                                	<button id="bil001_menuPanel_billingCalendarButton" type="button" class="btn btn-primary" style="height:34px; width:38px; font-size:10pt;" onclick="bil001_menuPanel_openBillingCalendar();">
			                                		 <i class="fa fa-calendar"></i>
			                                	</button> 
			                                </span>
		                        			<input id="bil001_menuPanel_billingCreatedOn" type="text" class="form-control" data-mask="99/99/9999" style="font-size:12pt; text-align:center;">
		                    			</div>
		                            </div>                        				
		            			</div>
		                    </div>
            				<div class="col-md-4" style="padding: 10px 0px 10px 10px;">
			            		<div id="bil001_orderNoDiv" style="padding-right:5px;" >
			        				<div class="input-group">
										<span class="input-group-btn">
			                            	<button id="bil001_menuPanel_searchBillingButton" type="button" class="btn btn-primary" style="height:34px;width:38px;font-size:10pt;" onclick="bil001_menuPanel_searchBilling();">
			                            		 <i class="fa fa-search" aria-hidden="true"></i> 
			                            	</button> 
			                            </span> 	
			                            <input id="bil001_menuPanel_billingNo" type="text" class="form-control" style="font-size:12pt; cursor:pointer;" placeholder="Order">		
			                            <span class="input-group-btn">
			                            	<button id="bil001_menuPanel_editBillingNoButton" type="button" class="btn btn-primary" onclick="bil001_menuPanel_editBillingNo();">
			                            		 <i class="fa fa-pencil" aria-hidden="true" style="font-size:14pt;"></i>
			                            	</button> 
			                            </span> 	                            
			                        </div>
			        			</div>
		        				<div id="bil001_quotationNoDiv" style="padding-right:5px; display:none;">
			        				<div class="input-group">
										<span class="input-group-btn">
			                            	<button id="bil001_menuPanel_openQuotationButton" type="button" class="btn btn-warning" style="height:34px;width:38px;font-size:16pt; padding-top:0px;" onclick="bil001_menuPanel_openQuotationOptions();">
			                            		 Q
			                            	</button> 
			                            </span> 
			                            <input id="bil001_menuPanel_quotationNo" type="text" class="form-control" style="font-size:12pt; cursor:pointer;" placeholder="Quotation">	
			                            <span class="input-group-btn">
			                            	<button id="bil001_menuPanel_editQuotationNoButton" type="button" class="btn btn-primary" onclick="bil001_menuPanel_editQuotationNo();">
			                            		 <i class="fa fa-pencil" aria-hidden="true" style="font-size:14pt;"></i>
			                            	</button> 
			                            </span> 	                            
			                        </div>
			                    </div>
			                </div>
            				<div class="col-md-5" style="padding: 10px 0px 10px 0px;">
			                    <div style="padding-right:5px;">
		            				<div class="input-group">
										<span class="input-group-btn">
		                                	<button id="bil001_menuPanel_searchCustomerButton" type="button" class="btn btn-primary" style="height:34px;width:38px;font-size:10pt;" onclick="bil001_menuPanel_searchCustomer();">
		                                		 <i class="fa fa-search" aria-hidden="true"></i> 
		                                	</button> 
		                                </span> 
		                                <input id="bil001_menuPanel_customerName" type="text" class="form-control" style="font-size:12pt; cursor:pointer;" placeholder="Customer" onclick="bil001_menuPanel_showCustomerProfile();" onfocus="$(this).blur();">
		                            </div>
		            			</div>
		                    </div>
		                </div>
        			</div>
        			<div class="col-md-3" style="padding: 10px 10px 10px 0px;">
        				<span class="pull-right">
        			    	<span class="dropdown">
							    <button type="button" class="btn btn-primary tooltip-bottom dropdown-toggle" style="height:34px;width:38px;font-size:12pt;padding:5px 0px;" data-toggle="dropdown" aria-expanded="false">
	        			    		<i class="fa fa-plus" aria-hidden="true" style="font-size:18pt;"></i> 
	        			    		<span class="tooltiptext-bottom">Create New</span>	
	        			    	</button>
							    <ul class="dropdown-menu">
							        <li><a id="bil001_menuPanel_newBillingButton" class="dropdown-item" onclick="bil001_menuPanel_newBilling();">New Billing</a></li>
							        <li><a id="bil001_menuPanel_newQuotationButton" class="dropdown-item" onclick="bil001_menuPanel_newQuotation();">New Quotation</a></li>
							        <li class="divider"></li>
							        <li><a id="bil001_menuPanel_cloneButton" class="dropdown-item" onclick="bil001_menuPanel_cloneBilling();">Clone This</a></li>
							    </ul>
							</span>
        			    	<button id="bil001_menuPanel_printButton" type="button" class="btn btn-primary tooltip-bottom" style="height:34px;width:38px;font-size:12pt;padding:4px 0px;" onclick="bil001_menuPanel_print();">
        			    		<i class="fa fa-print" aria-hidden="true" style="font-size:18pt;"></i>
        			    		<span class="tooltiptext-bottom">Print</span>
        			    	</button>
        			    	<button id="bil001_menuPanel_closeButton" type="button" class="btn btn-warning tooltip-bottom" style="height:34px;width:38px;font-size:12pt;padding:4px 0px;" onclick="bil001_menuPanel_close();">
        			    		<i class="fa fa-times" aria-hidden="true" style="font-size:18pt;"></i>
        			    		<span class="tooltiptext-bottom">Close</span>
        			    	</button>
        			    	<span class="dropdown">
							    <button type="button" class="btn btn-info tooltip-bottom dropdown-toggle" style="height:34px;width:38px;font-size:12pt;padding:4px 0px;" data-toggle="dropdown" aria-expanded="false">
	        			    		<i class="fa fa-bars" aria-hidden="true" style="font-size:18pt;"></i> 
	        			    		<span class="tooltiptext-bottom">More Actions</span>	
	        			    	</button>
							    <ul class="dropdown-menu dropdown-menu-right" style="right:0px; left:auto;">
							        <li><a id="bil001_menuPanel_openWorkflowButton" class="dropdown-item" onclick="bil001_menuPanel_showWorkflow();"><i class="fa fa-arrow-right" aria-hidden="true"></i> Workflow</a></li>
							        <li><a id="bil001_menuPanel_openDeliveryButton" class="dropdown-item" onclick="bil001_menuPanel_showDelivery();"><i class="fa fa-truck" aria-hidden="true"></i> Delivery</a></li>
      								<li class="divider"></li>
							        <li><a id="bil001_menuPanel_saveButton" class="dropdown-item" onclick="bil001_menuPanel_save();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</a></li>
							        <li><a id="bil001_menuPanel_deleteButton" class="dropdown-item" onclick="bil001_menuPanel_delete();"><i class="fa fa-trash-o" aria-hidden="true"></i> Delete</a></li>
							    </ul>
							</span>
        			    </span>
        			</div>
            	</div>
	            <div class="row">
	            	<div class="col-md-6" style="padding:0px 0px;">
                        <div class="ibox">
                            <div class="ibox-content">
                                <div id="itemView">                                 
                                </div>
                            </div>
                        </div>
                    </div> <!-- end of col-md-6 -->
                    <div class="col-md-6" style="padding:0px 0px;">
    				    <div class="ibox">
                            <div class="ibox-content">
                                <div class="tab-content">
                                    <div id="contact-1" class="tab-pane active">
                                    	<div class="row m-b-lg" style="margin:0;">
                                            <div class="col-md-12 col-lg-12 text-center" style="padding:0;">
   												<div id="bil001_paymentPanel" class="widget blue-bg p-lg text-center" style="margin:0;padding:0;cursor:pointer;" onclick="bil001_paymentPanel_showPaymentTerminal();">
   													<div class="m-b-md" style="margin:0;">
   													
   														<div class="row">
   														    <div class="col-md-4">
   														    	<p style="text-align:left; padding-left:10px; padding-top:10px; margin-bottom:0;">
   															        <span id="bil001_paymentPanel_billingStatus" class="label label-danger"></span>
   														        </p>
   														        <p style="text-align:left; padding-left:10px; padding-top:10px; margin-bottom:0;">
   															        <span id="bil001_paymentPanel_invoiceNo" class="label label-info"></span> 
   															        <span id="bil001_paymentPanel_invoiceDate" class="label label-info"></span>
   														        </p>
   														    </div>
   														    <div class="col-md-8">
	   														    <p style="text-align:right; padding-right:10px; margin-bottom:0;">
	   																<span id="bil001_paymentPanel_totalPayable_currency" class="currency" style="font-size:20pt;">$CURRENCY</span>
	   																<span id="bil001_paymentPanel_totalPayable" style="font-size:40pt;">0.00</span>
	   															</p>
   														    </div>
													    </div>
													       														
   														<div class="row">
   														    <div class="col-md-6">
   														        <p style="text-align:left; padding-left:10px; margin-bottom:0;">
   															        <small>Payment Balance</small>
   														        </p>
   														    </div>
   														    <div class="col-md-6">
   														        <p style="text-align:right; padding-right:10px; margin-bottom:0;">
   															        <small>Subtotal</small>
   														        </p>
   														    </div>
   														</div>
   														
   														<div class="row">
   														    <div class="col-md-6">
   														        <p class="font-bold no-margins" style="font-size:20pt; text-align:left; padding-left:10px;">
		   															<span id="bil001_paymentPanel_paymentBalance_currency" class="currency" style="font-size:16pt;">$CURRENCY</span>
		   															<span id="bil001_paymentPanel_paymentBalance" style="font-size:20pt;"></span>
		   														</p>
   														    </div>
   														    <div class="col-md-6">
   														        <p class="font-bold no-margins" style="font-size:20pt; text-align:right; padding-right:10px;">
		   															<span id="bil001_paymentPanel_subtotal_currency" class="currency" style="font-size:16pt;">$CURRENCY</span>
		   															<span id="bil001_paymentPanel_subtotal" style="font-size:20pt;"></span>
		   														</p>
   														    </div>
   														</div>
   													</div>
   												</div>
                                            </div>
                                        </div> 
                                        
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
    										<tbody id="bil001_cartPanel_billingLineTable" class="sortable-list" style="cursor:pointer;">
    										</tbody>
    									</table> 
    									<table class="table table-striped table-hover" id="bil001_cartPanel_billingDiscountTableRoot" style="display:none;">
    										<thead>
    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
    												<td></td>
    												<td colspan="7" style="height:20px;padding:0px;">DISCOUNTS on TOTAL BILL</td>
    											</tr>
    										</thead>
    										<tbody id="bil001_cartPanel_billingDiscountTable" class="sortable-list" style="cursor:pointer;">
    										</tbody>
    									</table>  
    									<table class="table table-striped table-hover" id="bil001_cartPanel_billingTaxTableRoot" style="display:none;">
    										<thead>
    											<tr style="font-weight:bold;background-color:#444444;color:#ffffff;">
    												<td></td>
    												<td colspan="7" style="height:20px;padding:0px;">TAXES on TOTAL BILL</td>
    											</tr>
    										</thead>
    										<tbody id="bil001_cartPanel_billingTaxTable" class="sortable-list" style="cursor:pointer;">
    										</tbody>
    									</table>                                    
                                    </div>                  
                                </div>
                            </div>
                        </div>
                    </div> <!-- end of col-sm-4 -->
                </div> <!-- end of row -->
	        </div> <!-- end of main-content -->
	        
        	<%@include file="/console/segment/footer_main.jsp" %>          
            
        </div> <!-- end of page-wrapper -->
        
    </div> <!-- end of wrapper -->
		
	<!-- MODAL WINDOW: Reset Password -->
	<%@include file="/console/_view/view_mw_resetPassword.jsp" %>
		
    <!-- MODAL WINDOW : Search Billing Window -->
	<%@include file="/console/_view/view_mw_billingSearch.jsp" %>
    <!-- MODAL WINDOW : Search Customer Window -->
	<%@include file="/console/_view/relation/view_mw_customerSearch.jsp" %>
    <!-- MODAL WINDOW : Customer Profile Window -->
	<%@include file="/console/_view/view_mw_customerProfile.jsp" %>
    <!-- MODAL WINDOW : Search Customer Window -->
	<%@include file="/console/_view/view_mw_paymentTerminal.jsp" %>
    <!-- MODAL WINDOW : PDF Preview Window -->
	<%@include file="/console/_view/view_mw_pdfPreview.jsp" %>
    <!-- MODAL WINDOW : Clone Billing -->
	<%@include file="/console/_view/view_mw_cloneBilling.jsp" %>
    <!-- MODAL WINDOW : Edit Billing No -->
	<%@include file="/console/_view/billing/view_mw_editBillingNo.jsp" %>
    <!-- MODAL WINDOW : Edit Quotation No -->
	<%@include file="/console/_view/billing/view_mw_editQuotationNo.jsp" %>
    <!-- MODAL WINDOW : Print Wizard -->
	<%@include file="/console/_view/billing/view_mw_printWizard.jsp" %>
	    
    <!-- MODAL WINDOW : Delivery Window -->
	<%@include file="/console/billing/bil001/view/bil001_mw002.jsp" %>	
    <!-- MODAL WINDOW : Item Details Window for PRODUCT, SERVICE, EVENT, RAW -->
	<%@include file="/console/billing/bil001/view/bil001_mw008.jsp" %>	
    <!-- MODAL WINDOW : Item Details Window for TAX, DISCOUNT-->
	<%@include file="/console/billing/bil001/view/bil001_mw009.jsp" %>	
    <!-- MODAL WINDOW : Edit Profile -->
	<%@include file="/console/billing/bil001/view/bil001_mw010.jsp" %>
    <!-- MODAL WINDOW : Add Properties -->
	<%@include file="/console/billing/bil001/view/bil001_mw011.jsp" %>
    <!-- MODAL WINDOW : Edit Properties -->
	<%@include file="/console/billing/bil001/view/bil001_mw012.jsp" %>
    <!-- MODAL WINDOW : Billing Workflow -->
	<%@include file="/console/billing/bil001/view/bil001_mw014.jsp" %>
    <!-- MODAL WINDOW : Schedule Event -->
	<%@include file="/console/billing/bil001/view/bil001_mw016.jsp" %>
    <!-- MODAL WINDOW : Open Quotation Options -->
	<%@include file="/console/billing/bil001/view/bil001_mw018.jsp" %>
    <!-- SIDE WINDOW : Right-sliding control panel -->
	<%@include file="/console/billing/bil001/view/bil001_sw000.jsp" %>
           	
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
    <script src="/console/billing/bil001/view/bil001.panel.cart.js"></script>
    <script src="/console/billing/bil001/view/bil001.panel.datatable.js"></script>
    <script src="/console/billing/bil001/view/bil001.panel.mansory.js"></script>
    <script src="/console/billing/bil001/view/bil001.panel.menu.js"></script>
    <script src="/console/billing/bil001/view/bil001.panel.payment.js"></script>
    <!-- Controller -->
    <script src="/console/inventory/inv002/controller/controller_00.js"></script>
    <!-- script src="/console/billing/bil001/controller/controller_localdb.js"></script-->
    <script src="/console/billing/bil001/controller/bil001_controller.js"></script>
    
    <!-- Document Processor -->
    <script src="/console/document/processor/documentProcessor.js"></script>    
    <script src="/console/document/processor/processor_DO001_001.js"></script>
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
	    	// Init DatePicker
			$('#bil001_menuPanel_billingCalendar .input-group.date').datepicker({
		    	format: 'dd/mm/yyyy',
		    	todayBtn: 'linked',
		    	todayHighlight: true,
                keyboardNavigation: false,
                forceParse: false,
                calendarWeeks: true,
                autoclose: true
		    });
			// DatePicker onChange listener			
			$("#bil001_menuPanel_billingCreatedOn").on('change', function(){
				if (global_billingObj == null)
					return false;
			    // Auto-save Billing
			    bil001_menuPanel_save();			    
			});
			
			$("#bil001_cartPanel_billingLineTable").sortable({
				placeholder: "ui-state-highlight",
                update: function(event, ui) {
					var rowId = ui.item.context.id;
                    var rowList = $("#bil001_cartPanel_billingLineTable").sortable( "toArray" );
                    
                    bil001_cartPanel_onCartItemReorder(rowId, rowList);
                }
            }).disableSelection();
			
			$("#bil001_cartPanel_billingTaxTable").sortable({
				placeholder: "ui-state-highlight",
                update: function(event, ui) {
                    var rowId = ui.item.context.id;
                    var rowList = $("#bil001_cartPanel_billingDiscountTable").sortable( "toArray" );
                    
                    bil001_cartPanel_onCartItemReorder(rowId, rowList);
                }
            }).disableSelection();
			
			$("#bil001_cartPanel_billingDiscountTable").sortable({
				placeholder: "ui-state-highlight",
                update: function(event, ui) {
                    var rowId = ui.item.context.id;
                    var rowList = $("#bil001_cartPanel_billingTaxTable").sortable( "toArray" );

                    bil001_cartPanel_onCartItemReorder(rowId, rowList);
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
