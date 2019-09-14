<!-- SET001_01: Billing Settings -->
<div id="set001_01" style="display:none;">	
    <div class="mail-box" style="padding:10px 20px 20px 20px;">
    	<div class="row">
            <div class="col-md-4 col-lg-3" style="padding:0px 0px;">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <ul class="folder-list m-b-md" style="padding: 0">
                            
                                <!-- General -->
                                <span id="set001_01_sidebar_menu_general_header">
	                                <li style="background-color: #337ab7;height:33px; padding-top:5px; cursor:pointer;" onclick="set001_01_toggleSidebarMenu('general');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		GENERAL
	                                	</span>
										<span class="pull-right">
											<i id="set001_01_sidebar_menu_general_toggle" onclick="set001_01_toggleSidebarMenu('general');" class="fa fa-minus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_01_sidebar_menu_general">
	                            	<li id="set001_01_sidebar_menu_00" onclick="set001_01_executeAction('set001_01_action_select_general');" style="background-color:#FFFFFF;">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-sliders" aria-hidden="true"></i> POS VIEW
	                                	</a>
	                                </li>
	                                <li id="set001_01_sidebar_menu_01" onclick="set001_01_executeAction('set001_01_action_select_taxation');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-usd" aria-hidden="true" style="padding-right:6px;"></i> TAXATION
	                                	</a>
	                                </li>
	                                <li id="set001_01_sidebar_menu_05" onclick="set001_01_executeAction('set001_01_action_select_payment');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-shopping-cart" aria-hidden="true"></i> PAYMENTS
	                                	</a>
	                                </li>
	                                <li id="set001_01_sidebar_menu_06" onclick="set001_01_executeAction('set001_01_action_select_workflow');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-tasks" aria-hidden="true"></i> WORKFLOW 
	                                	</a>
	                                </li>
	                                <li id="set001_01_sidebar_menu_07" onclick="set001_01_executeAction('set001_01_action_select_scheduledEvents');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-calendar" aria-hidden="true"></i> SCHEDULE 
	                                	</a>
	                                </li>
	                            </span>
                                
                                <!-- Floor Layout -->
                                <span id="set001_01_sidebar_menu_floorplan_header">
	                                <li style="background-color: #337ab7;height:33px;margin-top:30px; padding-top:5px; cursor:pointer;" onclick="set001_01_toggleSidebarMenu('floorplan');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		FLOOR PLAN
	                                	</span>
										<span class="pull-right">
											<i id="set001_01_sidebar_menu_floorplan_toggle" onclick="set001_01_toggleSidebarMenu('floorplan');" class="fa fa-plus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_01_sidebar_menu_floorplan" style="display:none;">
	                                <li id="set001_01_sidebar_menu_41" onclick="set001_01_executeAction('set001_01_action_select_floorplanConfiguration');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-columns" aria-hidden="true"></i> CONFIGURE
	                                	</a>
	                                </li>
	                            </span>
                                
                                <!-- Documents -->
                                <span id="set001_01_sidebar_menu_document_header">
	                                <li style="background-color: #337ab7;height:33px;margin-top:30px; padding-top:5px; cursor:pointer;" onclick="set001_01_toggleSidebarMenu('document');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		DOCUMENTS
	                                	</span>
										<span class="pull-right">
											<i id="set001_01_sidebar_menu_document_toggle" onclick="set001_01_toggleSidebarMenu('document');" class="fa fa-plus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_01_sidebar_menu_configureDocuments" style="display:none;">
	                                <li id="set001_01_sidebar_menu_documents" onclick="set001_01_executeAction('set001_01_action_select_documentConfiguration');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-columns" aria-hidden="true"></i> CONFIGURE
	                                	</a>
	                                </li>
	                            </span>
                                
                                <!-- Search Windows -->
                                <span id="set001_01_sidebar_menu_search_header">
	                                <li style="background-color: #337ab7;height:33px;margin-top:30px; padding-top:5px; cursor:pointer;" onclick="set001_01_toggleSidebarMenu('search');">
	                                	<span style="font-size:12pt;color:#ffffff;margin-left:10px;"> 
	                                		SEARCH WINDOWS
	                                	</span>
										<span class="pull-right">
											<i id="set001_01_sidebar_menu_search_toggle" onclick="set001_01_toggleSidebarMenu('search');" class="fa fa-plus-square-o" aria-hidden="true" style="padding-top:3px;font-weight:normal;font-size:12pt;color:#ffffff;cursor:pointer;"></i>
										</span>
	                                </li>
	                            </span>
                                <span id="set001_01_sidebar_menu_search" style="display:none;">
	                                <li id="set001_01_sidebar_menu_31" onclick="set001_01_executeAction('set001_01_action_select_customerSearch');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-columns" aria-hidden="true"></i> CUSTOMER SEARCH
	                                	</a>
	                                </li>
	                                <li id="set001_01_sidebar_menu_32" onclick="set001_01_executeAction('set001_01_action_select_billingSearch');">
	                                	<a href="#" style="padding-left:10px;padding-right:10px;font-size:12pt;"> 
	                                		<i class="fa fa-columns" aria-hidden="true"></i> BILLING SEARCH
	                                	</a>
	                                </li>
	                            </span>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-lg-9 animated fadeInRight" style="padding:0px 0px;">
                <!-- General Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_00.jsp" %>
                <!-- GST Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_01.jsp" %>
                <!-- Billing Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_02.jsp" %>
                <!-- Invoice Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_03.jsp" %>
                <!-- Receipt Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_04.jsp" %>
                <!-- Quotation Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_08.jsp" %>
                <!-- BackOffice Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_09.jsp" %>
                <!-- Delivery Order Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_10.jsp" %>
                <!-- Payments -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_05.jsp" %>
                <!-- Workflow Settings -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_06.jsp" %>
                <!-- Scheduled Events -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_07.jsp" %>
                <!-- MW: Customer Search -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_31.jsp" %>
                <!-- MW: Billing Search -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_32.jsp" %>
                <!-- Floor Plan: Configuration -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_41.jsp" %>
                <!-- Document: Configuration -->
                <%@include file="/console/settings/set001/view/set001_01/set001_01_documents_configure.jsp" %>
            </div>
        </div>
    </div>
</div>

<script>

var set001_01_initialized = false;

/**
 * Init Panel
 */
function set001_01_init()
{
    if (set001_01_initialized == true)
        return false;
    
    // Register event for search field
    $('#set001_01_searchField').on('input propertychange paste', function() {
        
        var searchText = $('#set001_01_searchField').val();
    });
    
    //--------------------------------------------------------------------------
    // Updating invoice/receipt list
    var invoiceList = [];   
    var receiptList = [];
       
    var placeObj = tycheesCommon_getCurrentPlaceObject();   
    $.each(placeObj.documentList, function(i, placeDocumentObj) {
        var documentObj = Cached_getDocumentById(placeDocumentObj.documentId);
        
        if (documentObj.docType==DocumentConstants.DOC_TYPE_INVOICE) {
            invoiceList.push(documentObj.docCode);
        }
        
        if (documentObj.docType==DocumentConstants.DOC_TYPE_PAYMENT_RECEIPT) {
            receiptList.push(documentObj.docCode);
        }
    });   
    
    var settingsObj_selectedInvoice = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_INVOICE_TEMPLATE);
    settingsObj_selectedInvoice.propContent = invoiceList.toString();
    settingsObj_selectedInvoice.hasChanged = true;
    
    var settingsObj_selectedReceipt = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_TEMPLATE);
    settingsObj_selectedReceipt.propContent = receiptList.toString();
    settingsObj_selectedReceipt.hasChanged = true;
    // .end of updating invoice/receipt list
    //--------------------------------------------------------------------------
    
    tycheesIO_saveBean( placeObj );
        
	set001_01_initialized = true;
} // .end of set001_01_init

/**
 * Show Panel
 */
function set001_01_updateUI()
{
	var placeObj = tycheesCommon_getCurrentPlaceObject();

	if (placeObj.category == 'Local Business') {
		if (placeObj.subcategory == 'cafe' || placeObj.subcategory == 'restaurant')	{
			$('#set001_01_sidebar_menu_floorplan_header').show();
			//$('#set001_01_sidebar_menu_floorplan').hide();
		} else {
			$('#set001_01_sidebar_menu_floorplan_header').hide();
			//$('#set001_01_sidebar_menu_floorplan').hide();
		}
	} else {
		$('#set001_01_sidebar_menu_floorplan_header').hide();
		//$('#set001_01_sidebar_menu_floorplan').hide();
	}
	
	// Show Control Panel
    $('#set001_01').show();
} // .end of set001_01_updateUI

/**
 * Hide Panel
 */
function set001_01_hide()
{
    $('#set001_01').hide();
} // .end of set001_01_hide

/**
 * Refresh UI
 */
function set001_01_reloadUI()
{

} // .end of set001_01_reloadUI

function set001_01_toggleSidebarMenu(menuGroupName)
{
	if (menuGroupName=='general')
	{
		if ($('#set001_01_sidebar_menu_general_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_01_sidebar_menu_general_toggle').removeClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_general_toggle').addClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_general').show();
		}
		else
		{
			$('#set001_01_sidebar_menu_general_toggle').removeClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_general_toggle').addClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_general').hide();
		}
		
	
		return false;
	}
	
	if (menuGroupName=='floorplan')
	{
		if ($('#set001_01_sidebar_menu_floorplan_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_01_sidebar_menu_floorplan_toggle').removeClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_floorplan_toggle').addClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_floorplan').show();
		}
		else
		{
			$('#set001_01_sidebar_menu_floorplan_toggle').removeClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_floorplan_toggle').addClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_floorplan').hide();
		}
		
		return false;
	}
	
	if (menuGroupName=='document')
	{
		if ($('#set001_01_sidebar_menu_document_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_01_sidebar_menu_document_toggle').removeClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_document_toggle').addClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_document').show();
			$('#set001_01_sidebar_menu_configureDocuments').show();
		}
		else
		{
			$('#set001_01_sidebar_menu_document_toggle').removeClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_document_toggle').addClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_document').hide();
			$('#set001_01_sidebar_menu_configureDocuments').hide();
		}
		
		return false;
	}
	
	if (menuGroupName=='search')
	{
		if ($('#set001_01_sidebar_menu_search_toggle').hasClass('fa-plus-square-o'))
		{
			$('#set001_01_sidebar_menu_search_toggle').removeClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_search_toggle').addClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_search').show();
		}
		else
		{
			$('#set001_01_sidebar_menu_search_toggle').addClass('fa-plus-square-o');
			$('#set001_01_sidebar_menu_search_toggle').removeClass('fa-minus-square-o');
			$('#set001_01_sidebar_menu_search').hide();
		}
		
		return false;
	}
	
} // .end of set001_01_toggleSidebarMenu

/**
 * Toggle settings rows by groupName (expand/collapse)
 */
function set001_01_toggleGroup(element, groupNameClass)
{
    // now is expanded, so go collapse
    if ($(element).hasClass('fa-minus-square-o'))
    {
        $('.'+groupNameClass).hide();
        $(element).removeClass('fa-minus-square-o');
        $(element).addClass('fa-plus-square-o');
    }
    // now is collapsed, so go expand
    else
    {
        $('.'+groupNameClass).show();
        $(element).addClass('fa-minus-square-o');
        $(element).removeClass('fa-plus-square-o');
    }
} // .end of set001_01_toggleGroup
	  
/**
 * Update the UI of whole page.
 */
function set001_01_executeAction(actionName)
{
	if (actionName == SET001_01_ACTION_SELECT_GENERAL)
	{
		set001_01_00_updateUI();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_TAXATION)
	{
		set001_01_00_hide();
		set001_01_01_updateUI();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_BILLING)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_updateUI();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_INVOICE)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_updateUI();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_RECEIPT)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_updateUI();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');	
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');	
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');	
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_QUOTATION)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_updateUI();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');	
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');	
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');	
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_DELIVERY_ORDER)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_updateUI();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', '#ddd');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');	
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');	
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');	
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_BACKOFFICE)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_updateUI();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');	
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');	
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');	
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_PAYMENT)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_updateUI();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_WORKFLOW)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_updateUI();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_SCHEDULED_EVENTS)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_updateUI();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
				
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_CUSTOMER_SEARCH)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_updateUI();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', '#ddd');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_BILLING_SEARCH)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_updateUI();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', '#ddd');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_DOCUMENT_CONFIGURATION)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_hide();
		// Documents
		set001_01_documents_configure_show();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', 'transparent');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', '#ddd');
	}
	else
	if (actionName == SET001_01_ACTION_SELECT_FLOOR_PLAN_CONFIGURATION)
	{
		set001_01_00_hide();
		set001_01_01_hide();
		set001_01_02_hide();
		set001_01_03_hide();
		set001_01_04_hide();
		set001_01_05_hide();
		set001_01_06_hide();
		set001_01_07_hide();
		set001_01_08_hide();
		set001_01_09_hide();
		set001_01_10_hide();
		// Search Windows
		set001_01_31_hide();
		set001_01_32_hide();
		// Floor Plan
		set001_01_41_updateUI();
		// Documents
		set001_01_documents_configure_hide();
		
		$('#set001_01_sidebar_menu_00').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_01').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_02').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_03').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_04').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_05').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_06').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_07').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_08').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_09').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_10').css('background-color', 'transparent');
		// Search Windows
		$('#set001_01_sidebar_menu_31').css('background-color', 'transparent');
		$('#set001_01_sidebar_menu_32').css('background-color', 'transparent');
		// Floor Plan
		$('#set001_01_sidebar_menu_41').css('background-color', '#ddd');
		// Documents
		$('#set001_01_sidebar_menu_documents').css('background-color', 'transparent');
	}
	else
	{
		tycheesLogger_showToast('error', 'Invalid Action', 'Unable to identify action name [' + actionName + '].')
	}
} // .end of set001_01_executeAction
	  	  
	  
</script>