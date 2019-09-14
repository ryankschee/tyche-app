
<!-- SEARCH DIALOG -->
<div class="modal inmodal fade" id="sea001_mw000" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xxl" style="margin-top:10px;">
		<div class="modal-content animated fadeIn">
			<div class="modal-header" style="padding-top:10px; padding-bottom:10px;">
				<span class="modal-title">CONSOLE SEARCH</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body modal-body-xl">
				<div class="row">
					<div class="col-lg-12">
						<div class="input-group m-b" style="width:720px;margin:0px auto 0px auto;">
			                <div class="input-group-btn">
			                    <button data-toggle="dropdown" class="btn btn-white dropdown-toggle" type="button" aria-expanded="false" style="height:46px;font-size:13pt;">
									<span id="sea001_mw000_searchModeTitle">Everywhere</span> <span class="caret"></span>
								</button>
			                    <ul class="dropdown-menu">
			                        <li><a href="#" style="font-size:12pt;" onclick="sea001_mw000_toggleSearchMode('everywhere');">Everywhere</a></li>
			                        <li class="divider"></li>
			                        <li><a href="#" style="font-size:12pt;" onclick="sea001_mw000_toggleSearchMode('billing');">Billing Only</a></li>
			                        <li><a href="#" style="font-size:12pt;" onclick="sea001_mw000_toggleSearchMode('customer');">Customer Only</a></li>
			                        <li><a href="#" style="font-size:12pt;" onclick="sea001_mw000_toggleSearchMode('inventory');">Inventory Only</a></li>
			                    </ul>
			                </div>
		            		<input id="sea001_mw000_searchKeywords" type="text" class="form-control input-lg" style="z-index:10;" placeholder="type any keywords...">
		                	<span class="input-group-btn"> 
								<button type="button" class="btn btn-white" style="height:46px;" onclick="sea001_mw000_reset();">
									<i class="fa fa-eraser" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-primary" style="height:46px;font-size:13pt;border:0px;" onclick="sea001_mw000_search();">
									<i class="fa fa-search" aria-hidden="true"></i> Search
								</button> 
		                	</span>
		            	</div>
					</div>
				</div> <!-- .end of row -->
				
				<div id="sea001_mw000_resultPanel" class="row" style="height:100%;margin-top:20px;">
					<div class="col-lg-12 ibox-content" style="height:100%;">
						<table id="sea001_mw000_table" class="table table-striped table-bordered table-hover">
	                        <thead>
		                        <tr>
		                            <th>Type</th>
		                            <th>Results</th>
		                            <th></th>
		                        </tr>
	                        </thead>
	                        <tbody id="sea001_mw000_tableBody">
							</tbody>
						</table>
					</div>
				</div><!-- .end of row -->
				
				<div id="sea001_mw000_resultPanel_spinner" class="row" style="height:100%; margin-top:20px; display:none;">
					<div class="col-lg-12 ibox-content" style="height:100%;">
						<div class="spiner-example" style="padding-top:0px;">
		                    <div class="sk-spinner sk-spinner-wave">
		                        <div class="sk-rect1"></div>
		                        <div class="sk-rect2"></div>
		                        <div class="sk-rect3"></div>
		                        <div class="sk-rect4"></div>
		                        <div class="sk-rect5"></div>
		                    </div>
		                </div>
					</div>
				</div>
				
			</div>
			<div class="modal-footer" style="padding-top:10px; padding-bottom:10px;">
				<span id="sea001_mw000_timeElapsed" style="float:left;"></span>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="">Close</button>
			</div>
		</div>
	</div>
</div>

<script>

var sea001_mw000_initialized = false;
var sea001_mw000_searchMode = 'everywhere';
var sea001_mw000_filter_searchCustomer = true;
var sea001_mw000_filter_searchBilling = true;
var sea001_mw000_filter_searchCategory = true;
var sea001_mw000_filter_searchItem = true;
var sea001_mw000_filter_searchPlace = true;

const OPEN_FROM_SEARCH_BILLING_ID = 'openFromSearch_billingId';
const OPEN_FROM_SEARCH_CUSTOMER_ID = 'openFromSearch_customerId';
const OPEN_FROM_SEARCH_CATEGORY_ID = 'openFromSearch_categoryId';
const OPEN_FROM_SEARCH_ITEM_ID = 'openFromSearch_itemId';

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function sea001_mw000_isOpen()
{
	return ($("#sea001_mw000").data('bs.modal') || {}).isShown;	
} // .end of sea001_mw000_isOpen

/**
 * Initiate components/variables
 */
function sea001_mw000_init()
{
	if (sea001_mw000_initialized)
		return false;

	$('#sea001_mw000').on('shown.bs.modal', function () {
	    $("#sea001_mw000_searchKeywords").focus();
	})
	
	// Init dataTable (customer Modal Dialog)
	$("#sea001_mw000_table").DataTable({
		  "columnDefs": [
                 { "width": "120px", "targets": 0 }, 
                 { "width": "100px", "targets": 2 }]
	});
	
	$("#sea001_mw000_searchKeywords").keypress(function(event) {
	    if ( event.keyCode == 13 ) {
	       sea001_mw000_search();
	    }
	});
	
	sea001_mw000_initialized = true;
} // .end of sea001_mw000_init

function sea001_mw000_showSpinner()
{
	$('#sea001_mw000_resultPanel').hide();
	$('#sea001_mw000_resultPanel_spinner').show();
} // .end of sea001_mw000_showSpinner

function sea001_mw000_hideSpinner()
{
	$('#sea001_mw000_resultPanel').show();
	$('#sea001_mw000_resultPanel_spinner').hide();
} // .end of sea001_mw000_hideSpinner

/**
 * Initiate data into modal window.
 */
function sea001_mw000_updateUI()
{			
	sea001_mw000_init();
	
	//sea001_mw000_reset();
	
	sea001_mw000_hideSpinner();
	
	module_showModalWindow('sea001_mw000', true);
} // .end of sea001_mw000_updateUI

/**
 * Show/hide modal window.
 *
 * @param showing		true if show; false if hide. 
 */
function sea001_mw000_show() 
{
	sea001_mw000_updateUI();
} // .end of sea001_mw000_show

/**
 * Set search mode (everywhere, billing, customer) 
 * 
 * @param {String} mode - Search mode
 */
function sea001_mw000_toggleSearchMode(mode)
{
	sea001_mw000_searchMode = mode;
		
	if (mode=='everywhere') 
	{
		$('#sea001_mw000_searchModeTitle').html('Everywhere'); 
		sea001_mw000_filter_searchCustomer = true;
		sea001_mw000_filter_searchBilling = true;
		sea001_mw000_filter_searchCategory = true;
		sea001_mw000_filter_searchItem = true;
		sea001_mw000_filter_searchPlace = true;
		return false;
	}
	if (mode=='billing')
	{
		$('#sea001_mw000_searchModeTitle').html('Billing Only');
		sea001_mw000_filter_searchCustomer = false;
		sea001_mw000_filter_searchBilling = true;
		sea001_mw000_filter_searchCategory = false;
		sea001_mw000_filter_searchItem = false;
		sea001_mw000_filter_searchPlace = false;
		return false;
	}
	if (mode=='customer')
	{
		$('#sea001_mw000_searchModeTitle').html('Customer Only');
		sea001_mw000_filter_searchCustomer = true;
		sea001_mw000_filter_searchBilling = false;
		sea001_mw000_filter_searchCategory = false;
		sea001_mw000_filter_searchItem = false;
		sea001_mw000_filter_searchPlace = false;
		return false;
	}
	if (mode=='inventory')
	{
		$('#sea001_mw000_searchModeTitle').html('Inventory Only');
		sea001_mw000_filter_searchCustomer = false;
		sea001_mw000_filter_searchBilling = false;
		sea001_mw000_filter_searchCategory = true;
		sea001_mw000_filter_searchItem = true;
		sea001_mw000_filter_searchPlace = false;
		return false;
	}
		
	//sea001_mw000_search();
} // .end of sea001_mw000_toggleSearchMode

/**
 * Reset search keyword field.
 */
function sea001_mw000_reset()
{
	$('#sea001_mw000_searchKeywords').val('');
    $("#sea001_mw000_searchKeywords").focus();
 	// Clear list
 	$('#sea001_mw000_table').DataTable().clear().draw();
} // .end of sea001_mw000_reset

/**
 * Search records from IDB. 
 */
function sea001_mw000_search()
{
	sea001_mw000_showSpinner();
	
	// Clear list
	$('#sea001_mw000_table').DataTable().clear().draw();
	$('#sea001_mw000_timeElapsed').html('');
	
	// Get search criteria 
	//var searchKeywordList = sea001_mw000_parseKeywords( $('#sea001_mw000_searchKeywords').val() );
	var searchKeywordList = $.trim( $('#sea001_mw000_searchKeywords').val() );
	var searchMode = sea001_mw000_searchMode;
	
	// DBEUG ONLY
	//$.each(searchKeywordList, function(i, searchKeyword){
	//	tycheesLogger_logDebug(i+'. searchKeyword='+searchKeyword, 'sea001_mw000_search');
	//});
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_ALL,
		'keywordList': JSON.stringify(searchKeywordList),
		'searchCustomer': sea001_mw000_filter_searchCustomer,
		'searchBilling': sea001_mw000_filter_searchBilling,
		'searchCategory': sea001_mw000_filter_searchCategory,
		'searchItem': sea001_mw000_filter_searchItem,
		'searchPlace': sea001_mw000_filter_searchPlace
	};

	var params = new Object();
	params.timeStart = tycheesDateTime_getCurrentTimeInMillis();
	params.keywordList = searchKeywordList;
	params.searchCustomer = sea001_mw000_filter_searchCustomer;
	params.searchBilling = sea001_mw000_filter_searchBilling;
	params.searchCategory = sea001_mw000_filter_searchCategory;
	params.searchItem = sea001_mw000_filter_searchItem;
	params.searchPlace = sea001_mw000_filter_searchPlace;
	
	tycheesdb_api_commonSearch(requestBody, sea001_mw000_search_postHandler, params);	
} // .end of sea001_mw000_search

function sea001_mw000_search_postHandler(successFlag, resultObj, params)
{
	if (successFlag==false) 
	{
		sea001_mw000_hideSpinner();
		return false;
	}
	
	sea001_mw000_displayResult(resultObj.resultList);
	
	// Inject CSS for each table cells.
	$.each($('#sea001_mw000_tableBody').children(), function(i, rowObj){
		$.each($(rowObj).children(), function(j, cellObj){
			$(cellObj).css('vertical-align', 'middle');
		});
	});
	
	var timeEnd = tycheesDateTime_getCurrentTimeInMillis();
	
	// Show time spent
	$('#sea001_mw000_timeElapsed').html('Spent ' + (params.timeStart - timeEnd) / 1000 + 's');
	
	sea001_mw000_hideSpinner();
} // .end of sea001_mw000_search_postHandler

function sea001_mw000_displayResult(resultList)
{	
	$.each(resultList, function(i, resultObj){	
		
		if (resultObj == null)
			return true;
			
		var beanClassShortName = '';
		var openBeanFn = '';
		var openBeanParams = '';
		var viewBeanObj = JSON.parse( resultObj.viewBean );
		
		if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_BILLING)
		{
			beanClassShortName = BeanConstants.BEAN_CLASS_SHORT_NAME_BILLING;
			openBeanFn = 'sea001_mw000_openBilling';
			openBeanParams = '\'' + viewBeanObj.id + '\'';
		}
		if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_CUSTOMER)
		{
			beanClassShortName = BeanConstants.BEAN_CLASS_SHORT_NAME_CUSTOMER;
			openBeanFn = 'sea001_mw000_openCustomer';
			openBeanParams = '\'' + viewBeanObj.id + '\'';
		}
		if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_INVENTORY_CATEGORY)
		{
			beanClassShortName = BeanConstants.BEAN_CLASS_SHORT_NAME_INVENTORY_CATEGORY;
			openBeanFn = 'sea001_mw000_openInventoryCategory';
			openBeanParams = '\'' + viewBeanObj.id + '\'';
		}
		if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_INVENTORY_ITEM)
		{
			beanClassShortName = BeanConstants.BEAN_CLASS_SHORT_NAME_INVENTORY_ITEM;
			openBeanFn = 'sea001_mw000_openInventoryItem';
			openBeanParams = '\'' + viewBeanObj.categoryId + '\',\'' + viewBeanObj.id + '\'';
		}
			
		// COLUMN #1
		var htmlLines_col1 = '';
		htmlLines_col1 += '<span class="label label-primary" style="font-size:9pt;">' + beanClassShortName + '</span>';
		
		// COLUMN #2
		var htmlLines_col2 = '';
		htmlLines_col2 += '<div style="font-size:13pt;">';
		htmlLines_col2 += '<i class="fa fa-plus-square-o" aria-hidden="true" style="cursor:pointer;" onclick="sea001_mw000_toggleSearchNode(this, \'' + resultObj.beanId + '\');"></i> ';
		htmlLines_col2 += $.trim( resultObj.beanDisplayName );
		htmlLines_col2 += '</div>';
		htmlLines_col2 += sea001_mw000_generateBeanResultTable( resultObj );
		
		// COLUMN #3
		var htmlLines_col3 = '';
		htmlLines_col3 += '<button class="btn btn-primary btn-xs ladda-button" data-style="zoom-in" id="selectBtn-' + viewBeanObj.id + '" onclick="' + openBeanFn + '(' + openBeanParams + ');">';
		htmlLines_col3 += '<i class="fa fa-folder-open-o" aria-hidden="true"></i> Open';
		htmlLines_col3 += '</button>';
	
		var rowSet = [];
		rowSet.push( htmlLines_col1 );
		rowSet.push( htmlLines_col2 );
		rowSet.push( htmlLines_col3 );
		$("#sea001_mw000_table").dataTable().fnAddData( rowSet, false );
	});
	
	// Redraw Table
	$("#sea001_mw000_table").DataTable().draw();
} // .end of sea001_mw000_displayResult

function sea001_mw000_openBilling(billingId) {
	
	var currentPageUrl = window.location.pathname;

	if (currentPageUrl.indexOf('billing') >= 0) {
		$('#selectBtn-'+billingId).ladda().ladda('start');
		
		var requestBody = {
				'appName': APP_NAME_ALL,
				'billingId': billingId,
				'fullBean': true	
			};	

		var params = new Object();
		params.billingId = billingId;
		
		tycheesdb_api_getBillingById(requestBody, sea001_mw000_openBilling_postHandler, params);
	}
	else {
		// Set billing ID to localstorage
		localStorage.setItem(OPEN_FROM_SEARCH_BILLING_ID, billingId);
		
		var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING);
		window.open(location, '_self');
	}
} // .end of sea001_mw000_openBilling

function sea001_mw000_openBilling_postHandler(success, responseObj, params) {
	$('#selectBtn-'+params.billingId).ladda().ladda('stop');
	
	if (success==false)
		return false;
	
	if (responseObj.billingObj != null) {

		// Hide modal window
		$("#sea001_mw000").modal('hide');
		// Assign objects to global scope
		global_billingObj = responseObj.billingObj;
		
		// Update page UI
		bil001_show();
	} 
	else 
	{
		tycheesLogger_showToast("error", "Error", "Invalid billing object found.")
	}
} // .end of sea001_mw000_openBilling_postHandler

function sea001_mw000_openCustomer(customerId) {
	
	var currentPageUrl = window.location.pathname;

	if (currentPageUrl.indexOf('relation') >= 0) {
		// Hide modal window
		$("#sea001_mw000").modal('hide');
		if (rel001_02_initialized==false) {
			// Update UI: load customer list
			rel001_02_updateUI(true);
		}
		// Show Customer
		rel001_02_sw001_updateUI(customerId);
	}
	else {
		// Set customer ID to localstorage
		localStorage.setItem(OPEN_FROM_SEARCH_CUSTOMER_ID, customerId);
		
		var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_RELATION);
		window.open(location, '_self');
	}
} // .end of sea001_mw000_openCustomer

function sea001_mw000_openInventoryCategory(categoryId) {
	
	var currentPageUrl = window.location.pathname;

	if (currentPageUrl.indexOf('inventory') >= 0) {
		// Hide modal window
		$("#sea001_mw000").modal('hide');

		// Call function in inventory module.
		segment01_jstree_selectNode(categoryId);
	}
	else {
		// Set category ID to localstorage
		localStorage.setItem(OPEN_FROM_SEARCH_CATEGORY_ID, categoryId);
		
		var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_INVENTORY);
		window.open(location, '_self');
	}
} // .end of sea001_mw000_openInventoryCategory

function sea001_mw000_openInventoryItem(categoryId, itemId) {
	
	var currentPageUrl = window.location.pathname;

	if (currentPageUrl.indexOf('inventory') >= 0) {
		// Hide modal window
		$("#sea001_mw000").modal('hide');
		
		// Call function in inventory module.
		//segment01_jstree_selectNode(categoryId);
		segment03_updateUI(itemId);
	}
	else {
		// Set category ID, item ID to localstorage
		localStorage.setItem(OPEN_FROM_SEARCH_CATEGORY_ID, categoryId);
		localStorage.setItem(OPEN_FROM_SEARCH_ITEM_ID, itemId);
		
		var location = tycheesCommon_getModulePath(ModuleConstants.MODULE_INVENTORY);
		window.open(location, '_self');
	}
} // .end of sea001_mw000_openInventoryCategory

function sea001_mw000_generateBeanResultTable(resultObj)
{
	if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_BILLING)
	{
		var viewBeanObj = JSON.parse( resultObj.viewBean );
		
		var billingCustomerLabel = $.trim(viewBeanObj.customerName);
	    if (billingCustomerLabel=='')
	    	billingCustomerLabel = 'N/A';
	    
	    var billingTotalAmountLabel = Number(viewBeanObj.totalAmount).toFixed(2);
	    var billingTotalPaymentLabel = Number(viewBeanObj.totalPayment).toFixed(2);
	    
	    var billingInvoiceLabel = $.trim(viewBeanObj.invoiceNo);
	    if (billingInvoiceLabel=='')
	    	billingInvoiceLabel = 'N/A';
	    	
	    var billingReceiptLabel = $.trim(viewBeanObj.receiptNo);
	    if (billingReceiptLabel=='')
	    	billingReceiptLabel = 'N/A';
	    
	    var billingStateLabel = viewBeanObj.stateDesc;
		
		var htmlLines = '';
		htmlLines += '<span id="search-' + viewBeanObj.id + '" style="display:none;">';
		htmlLines += '<table class="table table-striped table-hover" style="margin:0px 0px 0px 20px; width: 98%;">';
		htmlLines += sea001_mw000_getBillingTableHeader();
		htmlLines += '<tbody>';
        htmlLines += '<tr>';
        htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-user" aria-hidden="true"></i> ' + billingCustomerLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-usd" aria-hidden="true"></i> ' + billingTotalAmountLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-usd" aria-hidden="true"></i> ' + billingTotalPaymentLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-file-text-o" aria-hidden="true"></i> ' + billingInvoiceLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-file-text-o" aria-hidden="true"></i> ' + billingReceiptLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + billingStateLabel + '</td>';
        htmlLines += '</tr>';
        htmlLines += '</tbody>';
    	htmlLines += '</table>';
		htmlLines += '</span>';
		
		return htmlLines;
	}
	
	if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_CUSTOMER)
	{
		var viewBeanObj = JSON.parse( resultObj.viewBean );
		
		var customerImageUrl = viewBeanObj.profileImageUrl;
	    if ($.trim(customerImageUrl) == '')
	        customerImageUrl = 'https://www.cabe-africa.org/wp-content/uploads/2012/01/1.png';
	    
	    var customerGenderLabel = $.trim(viewBeanObj.gender);
	    if (customerGenderLabel=='')
	    	customerGenderLabel = 'N/A';
	    	
	    var customerDobLabel = tycheesDateTime_getFormattedDate_ddMMyyyy(viewBeanObj.dob);
	    if (viewBeanObj.dob==0 || viewBeanObj.dob==null)
	    	customerDobLabel = 'N/A';
	    	
	    var customerContactLabel = $.trim(viewBeanObj.contact);
	    if (customerContactLabel=='')
	    	customerContactLabel = 'N/A';
	    
	    var customerEmailLabel = $.trim(viewBeanObj.email);
	    if (customerEmailLabel=='')
	    	customerEmailLabel = 'N/A';
	    
	    var customerLastBillingNoLabel = $.trim(viewBeanObj.lastBillingNo);
	    if (customerLastBillingNoLabel=='')
	    	customerLastBillingNoLabel = 'N/A';
	    
		var htmlLines = '';
		htmlLines += '<span id="search-' + resultObj.beanId + '" style="display:none;">';
		htmlLines += '<table class="table table-striped table-hover" style="margin:0px 0px 0px 20px; width: 98%;">';
		htmlLines += sea001_mw000_getCustomerTableHeader();
		htmlLines += '<tbody>';
		htmlLines += '<tr>';
		htmlLines += '<td class="client-avatar"><img alt="image" src="' + customerImageUrl + '" data-pin-nopin="true"> </td>';
		htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-transgender" aria-hidden="true"></i> ' + customerGenderLabel + '</td>';
		htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-birthday-cake" aria-hidden="true"></i> ' + customerDobLabel + '</td>';
		htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-phone" aria-hidden="true"></i> ' + customerContactLabel + '</td>';
		htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-envelope" aria-hidden="true"></i> ' + customerEmailLabel + '</td>';
		htmlLines += '<td style="vertical-align:middle;"><i class="fa fa-shopping-bag" aria-hidden="true"></i> ' + customerLastBillingNoLabel + '</td>';
		htmlLines += '</tr>';
		htmlLines += '</tbody>';
		htmlLines += '</table>';
		htmlLines += '</span>';
		
		return htmlLines;
	}
	
	if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_INVENTORY_CATEGORY)
	{
		var viewBeanObj = JSON.parse( resultObj.viewBean );
		
		var categoryNameLabel = $.trim(viewBeanObj.name);
	    if (categoryNameLabel=='')
	    	categoryNameLabel = 'N/A';
	    
	    var parentCategoryNameLabel = 'N/A';
	    if (viewBeanObj.parentCategoryName != null)
	    	parentCategoryNameLabel = $.trim(viewBeanObj.parentCategoryName);
	    
	    var categoryTypeLabel = $.trim(viewBeanObj.itemType);
	    if (categoryTypeLabel=='')
	    	categoryTypeLabel = 'N/A';
	    
	    var posVisibleLabel = '<i class="fa fa-eye-slash" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.posVisible);
	    if (viewBeanObj.posVisible==true)
	    	posVisibleLabel = '<i class="fa fa-eye" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.posVisible);

	    var pwsVisibleLabel = '<i class="fa fa-eye-slash" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.pwsVisible);
	    if (viewBeanObj.pwsVisible==true)
	    	pwsVisibleLabel = '<i class="fa fa-eye" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.pwsVisible);
		    	
		var htmlLines = '';
		htmlLines += '<span id="search-' + viewBeanObj.id + '" style="display:none;">';
		htmlLines += '<table class="table table-striped table-hover" style="margin:0px 0px 0px 20px; width: 98%;">';
		htmlLines += sea001_mw000_getInventoryCategoryTableHeader();
		htmlLines += '<tbody>';
        htmlLines += '<tr>';
        htmlLines += '<td style="vertical-align:middle;">' + categoryNameLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + parentCategoryNameLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + categoryTypeLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + posVisibleLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + pwsVisibleLabel + '</td>';
        htmlLines += '</tr>';
        htmlLines += '</tbody>';
    	htmlLines += '</table>';
		htmlLines += '</span>';
		
		return htmlLines;
	}
	
	if (resultObj.beanClassName == BeanConstants.BEAN_CLASS_NAME_INVENTORY_ITEM)
	{
		var viewBeanObj = JSON.parse( resultObj.viewBean );
		
		var itemNameLabel = $.trim(viewBeanObj.name);
	    if (itemNameLabel=='')
	    	itemNameLabel = 'N/A';

	    var categoryNameLabel = 'N/A';
	    if (viewBeanObj.categoryName != null)
	    	categoryNameLabel = $.trim(viewBeanObj.categoryName);
	    
	    var itemTypeLabel = $.trim(viewBeanObj.itemType);
	    if (itemTypeLabel == '')
	    	itemTypeLabel = 'N/A';

	    var itemGroupLabel = $.trim(viewBeanObj.groupName);
	    if (itemGroupLabel == '')
	    	itemGroupLabel = 'N/A';
	    
	    var posVisibleLabel = '<i class="fa fa-eye-slash" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.posVisible);
	    if (viewBeanObj.posVisible==true)
	    	posVisibleLabel = '<i class="fa fa-eye" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.posVisible);

	    var pwsVisibleLabel = '<i class="fa fa-eye-slash" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.pwsVisible);
	    if (viewBeanObj.pwsVisible==true)
	    	pwsVisibleLabel = '<i class="fa fa-eye" aria-hidden="true"></i> ' + tycheesUtil_getYesNoFromBoolean(viewBeanObj.pwsVisible);
		    	
		var htmlLines = '';
		htmlLines += '<span id="search-' + viewBeanObj.id + '" style="display:none;">';
		htmlLines += '<table class="table table-striped table-hover" style="margin:0px 0px 0px 20px; width: 98%;">';
		htmlLines += sea001_mw000_getInventoryItemTableHeader();
		htmlLines += '<tbody>';
        htmlLines += '<tr>';
        htmlLines += '<td style="vertical-align:middle;">' + itemNameLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + categoryNameLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + itemTypeLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + itemGroupLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + posVisibleLabel + '</td>';
        htmlLines += '<td style="vertical-align:middle;">' + pwsVisibleLabel + '</td>';
        htmlLines += '</tr>';
        htmlLines += '</tbody>';
    	htmlLines += '</table>';
		htmlLines += '</span>';
		
		return htmlLines;
	}	
} // .end of sea001_mw000_generateBeanResultTable_customer

function sea001_mw000_getCustomerTableHeader()
{
	var htmlLines = '';
	htmlLines += '<thead>';
	htmlLines += '<tr style="font-weight:normal; background-color:#676a6c; color:#fff;">';
	htmlLines += '<td></td>';
    htmlLines += '<td>Gender</td>';
    htmlLines += '<td>DOB</td>';
    htmlLines += '<td>Contact</td>';
    htmlLines += '<td>Email</td>';
	htmlLines += '<td>Last Billing No</td>';
    htmlLines += '</tr>';
    htmlLines += '</thead>';
	return htmlLines;
} // .end of sea001_mw000_getCustomerTableHeader

function sea001_mw000_getBillingTableHeader()
{
	var htmlLines = '';
	htmlLines += '<thead>';
	htmlLines += '<tr style="font-weight:normal; background-color:#676a6c; color:#fff;">';
	htmlLines += '<td>Customer</td>';
    htmlLines += '<td>Total Amount</td>';
    htmlLines += '<td>Total Payment</td>';
    htmlLines += '<td>Invoice No</td>';
    htmlLines += '<td>Receipt No</td>';
	htmlLines += '<td>State</td>';
    htmlLines += '</tr>';
    htmlLines += '</thead>';
	return htmlLines;
} // .end of sea001_mw000_getBillingTableHeader

function sea001_mw000_getInventoryCategoryTableHeader()
{
	var htmlLines = '';
	htmlLines += '<thead>';
	htmlLines += '<tr style="font-weight:normal; background-color:#676a6c; color:#fff;">';
	htmlLines += '<td>Category</td>';
    htmlLines += '<td>Parent Category</td>';
    htmlLines += '<td>Type</td>';
    htmlLines += '<td>POS Visible</td>';
    htmlLines += '<td>PWS Visible</td>';
    htmlLines += '</tr>';
    htmlLines += '</thead>';
	return htmlLines;
} // .end of sea001_mw000_getInventoryCategoryTableHeader

function sea001_mw000_getInventoryItemTableHeader()
{
	var htmlLines = '';
	htmlLines += '<thead>';
	htmlLines += '<tr style="font-weight:normal; background-color:#676a6c; color:#fff;">';
	htmlLines += '<td>Item</td>';
    htmlLines += '<td>Category</td>';
    htmlLines += '<td>Type</td>';
    htmlLines += '<td>Group</td>';
    htmlLines += '<td>POS Visible</td>';
    htmlLines += '<td>PWS Visible</td>';
    htmlLines += '</tr>';
    htmlLines += '</thead>';
	return htmlLines;
} // .end of sea001_mw000_getInventoryItemTableHeader

function sea001_mw000_toggleSearchNode(element, beanId)
{
	var isCollapsed = $(element).hasClass('fa-plus-square-o');
	
	if (isCollapsed)
	{
		$(element).removeClass('fa-plus-square-o');
		$(element).addClass('fa-minus-square-o');
		// expand result
		$('#search-'+beanId).show();
	}
	else
	{
		$(element).addClass('fa-plus-square-o');
		$(element).removeClass('fa-minus-square-o');
		// collapse result
		$('#search-'+beanId).hide();
	}
} // .end of sea001_mw000_toggleSearchNode

/**
 * Search customer from IDB. 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchCustomerList(searchKeywordList)
{
	var resultList = [];
	var customerList = Cached_getCustomerList();
	
	$.each(customerList, function(i, customerObj){
		var match = sea001_mw000_searchCustomer(customerObj, searchKeywordList);
		if (match)
			resultList.push(customerObj);
	});
	
	return resultList;
} // .end of sea001_mw000_searchCustomerList

/**
 * Search if customer match with search keyword(s). 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchCustomer(customerObj, searchKeywordList)
{
	var match = false;
	
	$.each(searchKeywordList, function(i, keyword){
		if ($.trim(keyword)=='')
			return true;
	
		if (keyword.startsWith(sea001_mw000_keywordPrefix_EXACT))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(customerObj.id).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.customerNo).indexOf(term) >= 0) 
				match = true;
			if (($.trim(customerObj.firstName) + ' ' + $.trim(customerObj.lastName)).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.contact).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.email).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.address).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.description).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.lastBillingId).indexOf(term) >= 0) 
				match = true;
			if ($.trim(customerObj.lastBillingNo).indexOf(term) >= 0) 
				match = true;
		}
		
		if (keyword.startsWith(sea001_mw000_keywordPrefix_FREE))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(customerObj.id).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.customerNo).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if (($.trim(customerObj.firstName) + ' ' + $.trim(customerObj.lastName)).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.contact).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.email).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.address).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.description).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.lastBillingId).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(customerObj.lastBillingNo).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
		}
		
		if (match)
			return false;
	});
	
	return match;
} // .end of sea001_mw000_searchCustomer

/**
 * Search billing from IDB. 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchBillingList(searchKeywordList)
{
	var resultList = [];
	var billingList = Cached_getBillingList();
	
	$.each(billingList, function(i, billingObj){
		var match = sea001_mw000_searchBilling(billingObj, searchKeywordList);
		if (match)
			resultList.push(billingObj);
	});
	
	return resultList;
} // .end of sea001_mw000_searchBillingList

/**
 * Search if billing match with search keyword(s). 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchBilling(billingObj, searchKeywordList)
{
	var match = false;
	
	$.each(searchKeywordList, function(i, keyword){
		if ($.trim(keyword)=='')
			return true;
	
		if (keyword.startsWith(sea001_mw000_keywordPrefix_EXACT))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(billingObj.id).indexOf(term) >= 0) 
				match = true;
			if ($.trim(billingObj.billingNo).indexOf(term) >= 0) 
				match = true;
			if ($.trim(billingObj.customerName).indexOf(term) >= 0) 
				match = true;
			if ($.trim(billingObj.stateDesc).indexOf(term) >= 0) 
				match = true;
			if ($.trim(billingObj.invoiceNo).indexOf(term) >= 0) 
				match = true;
			if ($.trim(billingObj.remarks).indexOf(term) >= 0) 
				match = true;
				
			$.each(billingObj.lineList, function(j, lineObj){
				if ($.trim(lineObj.itemName).indexOf(term) >= 0) 
					match = true;
			});
		}
		
		if (keyword.startsWith(sea001_mw000_keywordPrefix_FREE))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(billingObj.id).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(billingObj.billingNo).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(billingObj.customerName).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(billingObj.stateDesc).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(billingObj.invoiceNo).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(billingObj.remarks).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
				
			$.each(billingObj.lineList, function(j, lineObj){
				if ($.trim(lineObj.itemName).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
					match = true;
			});
		}
		
		if (match)
			return false;
	});
	
	return match;
} // .end of sea001_mw000_searchBilling

/**
 * Search inventory category from IDB. 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchInventoryCategoryList(searchKeywordList)
{
	var resultList = [];
	var categoryList = Cached_getCategoryList();
	
	$.each(categoryList, function(i, categoryObj){
		var match = sea001_mw000_searchInventoryCategory(categoryObj, searchKeywordList);
		if (match)
			resultList.push(categoryObj);
	});
	
	return resultList;
} // .end of sea001_mw000_searchInventoryCategoryList

/**
 * Search if inventory category match with search keyword(s). 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchInventoryCategory(categoryObj, searchKeywordList)
{
	var match = false;
	
	$.each(searchKeywordList, function(i, keyword){
		if ($.trim(keyword)=='')
			return true;
	
		if (keyword.startsWith(sea001_mw000_keywordPrefix_EXACT))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(categoryObj.id).indexOf(term) >= 0) 
				match = true;
			if ($.trim(categoryObj.itemType).indexOf(term) >= 0) 
				match = true;
			if ($.trim(categoryObj.name).indexOf(term) >= 0) 
				match = true;
		}
		
		if (keyword.startsWith(sea001_mw000_keywordPrefix_FREE))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(categoryObj.id).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(categoryObj.itemType).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(categoryObj.name).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
		}
		
		if (match)
			return false;
	});
	
	return match;
} // .end of sea001_mw000_searchInventoryCategory

/**
 * Search inventory item from IDB. 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchInventoryItemList(searchKeywordList)
{
	var resultList = [];
	var itemList = Cached_getItemList();
	
	$.each(itemList, function(i, itemObj){
		var match = sea001_mw000_searchInventoryItem(itemObj, searchKeywordList);
		if (match)
			resultList.push(itemObj);
	});
	
	return resultList;
} // .end of sea001_mw000_searchInventoryItemList

/**
 * Search if inventory item match with search keyword(s). 
 *
 * @param	{Array}	searchKeywordList - List of search keywords
 */
function sea001_mw000_searchInventoryItem(itemObj, searchKeywordList)
{
	var match = false;
	
	$.each(searchKeywordList, function(i, keyword){
		if ($.trim(keyword)=='')
			return true;
	
		if (keyword.startsWith(sea001_mw000_keywordPrefix_EXACT))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(itemObj.id).indexOf(term) >= 0) 
				match = true;
			if ($.trim(itemObj.itemType).indexOf(term) >= 0) 
				match = true;
			if ($.trim(itemObj.name).indexOf(term) >= 0) 
				match = true;
			if ($.trim(itemObj.groupName).indexOf(term) >= 0) 
				match = true;
		}
		
		if (keyword.startsWith(sea001_mw000_keywordPrefix_FREE))
		{
			var term = tycheesText_replaceAll(keyword, sea001_mw000_keywordPrefix_FREE, '');
		
			if ($.trim(itemObj.id).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(itemObj.itemType).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(itemObj.name).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
			if ($.trim(itemObj.groupName).toUpperCase().indexOf(term.toUpperCase()) >= 0) 
				match = true;
		}
		
		if (match)
			return false;
	});
	
	return match;
} // .end of sea001_mw000_searchInventoryItem

//------------------------------------------------------------------------------
// Keywords Parser v1.0

var sea001_mw000_keywordPrefix_EXACT = '_EXACT__';
var sea001_mw000_keywordPrefix_FREE = '_FREE__';

/**
 * Parse search keywords.
 *
 * @author	Ryan Chee
 * @version	1.0
 * @param	{String} searchKeywords - Original user input for search keywords
 * @return	{Array} - List of search keywords
 */
function sea001_mw000_parseKeywords(searchKeywords)
{
	var exactMatchTermList = sea001_mw000_parser_exactMatchTerm(searchKeywords);
	$.each(exactMatchTermList, function(i, exactMatchTerm) {
		searchKeywords = tycheesText_replaceAll(searchKeywords, '"'+exactMatchTerm+'"', '');
	});
	
	var freeTermList = sea001_mw000_parser_freeTerm(searchKeywords);
	
	var parsedList = exactMatchTermList.concat( freeTermList );
	
	return parsedList;
} // .end of sea001_mw000_parseKeywords

/**
 * Parse search keywords, return only exact match terms.
 *
 * @author	Ryan Chee
 * @version	1.0
 * @param	{String} searchKeywords - search keywords in string
 * @return	{Array} - List of search keywords
 */
function sea001_mw000_parser_exactMatchTerm(searchKeywords)
{
	var parsedList = [];
	
	var doubleQuoteBegin = false;
	var doubleQuotaBeginIndex;
	
	for (i = 0 ; i < searchKeywords.length ; i++)
	{
		var char = searchKeywords.charAt(i);
		
		// Found a complete exact match term (word or words)
		if (char=='"' && doubleQuoteBegin==true)
		{
			parsedList.push( sea001_mw000_keywordPrefix_EXACT + searchKeywords.substring(doubleQuotaBeginIndex+1, i) );
			
			// Reset
			doubleQuoteBegin = false;
			doubleQuotaBeginIndex = -1;
		}
		
		// Found beginning of a (possible) exact match term
		if (char=='"' && doubleQuoteBegin==false)
		{
			doubleQuoteBegin = true;
			doubleQuotaBeginIndex = i;
		}
	}
	
	return parsedList;
} // .end of sea001_mw000_parser_exactMatchTerm

/**
 * Parse search keywords, return only free terms.
 *
 * @author	Ryan Chee
 * @version	1.0
 * @param	{String} searchKeywords - search keywords in string
 * @return	{Array} - List of search keywords
 */
function sea001_mw000_parser_freeTerm(searchKeywords)
{
	var parsedList = [];
	
	var processedList = searchKeywords.split(' ');
	$.each(processedList, function(i, term) {
		if ($.trim(term) != '')
		{
			parsedList.push( sea001_mw000_keywordPrefix_FREE + $.trim(term) );
		}
	});
	
	return parsedList;
} // .end of sea001_mw000_parser_freeTerm

</script>