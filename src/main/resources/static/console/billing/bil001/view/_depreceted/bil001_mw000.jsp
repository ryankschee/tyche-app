<style>
.entry_button {
	padding-left: 5px;
	padding-right: 5px;
}
</style>

<!-- ENTRY DIALOG -->
<div class="modal inmodal fade" id="mw000" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg2">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<i class="fa fa-laptop modal-icon"></i>
				<h4 class="modal-title">Cloud POS</h4>
				<small>TYCHEES &copy; 2017. Licensed to <span id="placeName"></span>.</small>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-4 col-lg-4">
	                    <div class="widget style1 yellow-bg" onclick="mw000_onclick_newQuotation();" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-file fa-4x"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">New Quotation</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-4 col-lg-4">
	                    <div class="widget style1 navy-bg" onclick="mw000_onclick_newBilling();" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-file-o fa-4x"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">New Billing</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-4 col-lg-4">
	                    <div class="widget style1 navy-bg" onclick="mw000_onclick_openBilling();" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-search fa-4x"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:14pt;">Open Billing</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
				</div> <!-- .end of row -->
				
				<hr style="height:3px;border:none;background-color:#D5D8DC;">
				
				<div class="row">
	                <div class="col-md-12 col-lg-12">
	                	<div class="form-group">
	                		<span class="help-block m-b-none" style="text-align:center;font-size:16pt;">OR</span>
	                		<span class="help-block m-b-none" style="text-align:center;font-size:12pt;padding-bottom:10px;">You want to navigate to other page?</span>
                        </div>
	                </div>
	            </div> <!-- .end of row -->
	            
				<div class="row">
					<div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule('ModuleDashboard');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-tachometer fa-2x" aria-hidden="true"></i> 
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Dashboard</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule('ModuleCalendar');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                            	<i class="fa fa-calendar fa-2x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Calendar</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>	
	                <div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule('ModuleInventory');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                            	<i class="fa fa-database fa-2x" aria-hidden="true"></i> 
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Inventory</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>		
	                <div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule('ModuleRelation');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-users fa-2x" aria-hidden="true"></i> 
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Relation</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>					
				</div> <!-- .end of row -->
				
				<div class="row">
					<div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule('ModuleReports');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                            	<i class="fa fa-bar-chart fa-2x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Reports</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
					<div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule('ModuleSettings');" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                            	<i class="fa fa-map-marker fa-2x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Settings</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 red-bg" onclick="" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                            	<i class="fa fa-lock fa-2x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Lock Screen</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>		
	                <div class="col-md-3 col-lg-3 entry_button">
	                    <div class="widget style1 red-bg" onclick="tycheesCommon_logout();" style="cursor:pointer;">
	                        <div class="row vertical-align">
	                            <div class="col-xs-3">
	                                <i class="fa fa-sign-out fa-2x" aria-hidden="true"></i>
	                            </div>
	                            <div class="col-xs-9 text-right">
	                                <span class="font-bold" style="font-size:11pt;">Log Out</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>					
				</div>  <!-- .end of row -->
			</div>
		</div>
	</div>
</div>

<script>

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function mw000_isOpen()
{
	return ($("#mw000").data('bs.modal') || {}).isShown;	
} // .end of mw000_isOpen

/**
 * Initiate data into modal window.
 */
function mw000_init()
{			
	var placeObj = Cached_getPlaceById(tycheesCommon_getCurrentPlaceId());
	$('#placeName').html(placeObj.name);
} // .end of mw000_init

/**
 * Show/hide modal window.
 *
 * @param showing		true if show; false if hide. 
 */
function mw000_updateUI(showing) 
{
	if (showing==true)
		module_showModalWindow('mw000', true);
	else
		$("#mw000").modal("hide");
} // .end of mw000_updateUI

function mw000_onclick_newQuotation()
{
	mw000_updateUI(false);
	page_executeAction(PAGE_ACTION_NEW_QUOTATION);
} // .end of mw000_onclick_newBilling

function mw000_onclick_newBilling()
{
	mw000_updateUI(false);
	page_executeAction(PAGE_ACTION_NEW_BILLING);
} // .end of mw000_onclick_newBilling

function mw000_onclick_openBilling() 
{
	$('#mw000').modal('hide');
	
	mw_billingSearch_show(mw000_onclick_openBilling_selectCallbackFn, mw000_onclick_openBilling_deleteCallbackFn);
} // .end of mw000_onclick_openBilling

function mw000_onclick_openBilling_selectCallbackFn(billingObj, transactionObj)
{
	if (billingObj != null && transactionObj != null) 
	{
		//$('#mw000').modal('hide');
		
		// Assign objects to global scope
		global_billingObj = billingObj;
		global_transactionObj = transactionObj;
	}
	else
	{
		$('#mw000').modal('show');
	}
} // .end of mw000_onclick_openBilling_callbackFn

function mw000_onclick_openBilling_deleteCallbackFn(billingObj, transactionObj)
{
	if (billingObj != null && transactionObj != null) 
	{
		// IF selected billing id EQUALS TO currently opened billing object,
    	// THEN close/reset billing
    	if (global_billingObj.id == billingObj.id)
    	{
    		page_ctrl_closeBilling();
    	}		

		// Delete from DB
    	localdb_billing_delete(billingObj, transactionObj);	        	
	}	
} // .end of mw000_onclick_openBilling_deleteCallbackFn

</script>