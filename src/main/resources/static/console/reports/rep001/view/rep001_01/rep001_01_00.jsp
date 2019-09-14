
<!-- rep001_01_00: Reports -->
<div id="rep001_01_00" style="display:none;">
    <div class="row" style="padding-bottom:10px;padding-top:20px;">
        <div class="col-md-6" style="padding:0px 5px;">
            <div id="rep001_01_00_dateRange" class="form-control">
                <i class="fa fa-calendar" aria-hidden="true"></i>
                <span style="padding-left:10px;"></span> 
                <b class="caret"></b>
            </div>
        </div>
        <div class="col-md-6" style="padding:0px 5px;">
            <label title="Refresh" id="rep001_01_00_refreshReports" class="btn btn-primary pull-right" onclick="rep001_01_00_refresh();">
                <i class="fa fa-cog" aria-hidden="true"></i> Generate Report
            </label>
            <label title="Report Filter" id="rep001_01_00_toggleFilter" class="btn btn-link pull-right" onclick="rep001_01_00_toggleFilter(this);" style="font-size:9pt;"> 
            	<i class="fa fa-filter" aria-hidden="true"></i> Show Filters
            </label>
        </div>
    </div> <!-- .end of row #1 -->
    <div class="row hidden" id="rep001_01_00_filter" style="display:none;padding-bottom:20px;padding-top:0px;">
        <div class="col-md-4" style="padding:0px 5px;">
        	<div class="form-group">
                <label class="font-bold">Filtered by Customer</label>
                <div class="input-group">
	                <select id="rep001_01_00_filter_customer" data-placeholder="Filtered by customer..." class="chosen-select" tabindex="2">
		                <option value="">Show All</option>
	                </select>
                </div>
            </div>
        </div>
        <div class="col-md-4" style="padding:0px 5px;">
        	<div class="form-group">
                <label class="font-bold">Filtered by Status</label>
                <div class="input-group">
	                <select id="rep001_01_00_filter_status" data-placeholder="Show All" multiple class="chosen-select" tabindex="2">
		                <option value="">Show All</option>
	                </select>
                </div>
            </div>
        </div>
    </div> <!-- .end of row #1 -->
    <div id="rep001_01_00_filter_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
    
    <div id="rep001_01_00_reportDetails" style="display:none;"> 
        <div class="row">
            <div class="col-md-4" style="padding:0px 5px;">
                <div class="ibox float-e-margins" style="margin:0px;">
                    <div class="ibox-title" style="padding-left:10px; padding-right:10px;">
                        <h5>Order Summary</h5>
                    </div>
                    <div class="ibox-content" style="height:80px; padding:10px 0px;">
                        <div class="col-md-5" style="padding-left:10px; padding-right:10px;">
                        	<div id="rep001_01_00_orders_count" class="no-margins widget-summary-text">0.00</div>
                    		<div class="font-bold text-navy"><small>New Orders</small></div>                        
                        </div>
                        <div class="col-md-7" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_01_00_orders_totalAmount" class="no-margins pull-right widget-summary-text">0.00</div>
                            <br/>
                    		<div class="font-bold text-navy"><span class="small pull-right">Total Amount</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4" style="padding:0px 5px;">
                <div class="ibox float-e-margins" style="margin:0px;">
                    <div class="ibox-title" style="padding-left:10px; padding-right:10px;">
                        <h5>Payment Summary</h5>
                    </div>
                    <div class="ibox-content" style="height:80px; padding:10px 0px;">
                        <div class="col-md-5" style="padding-left:10px; padding-right:10px;">
                        	<div id="rep001_01_00_payments_completedCount" class="no-margins widget-summary-text">0</div>
                    		<div class="font-bold text-navy"><small>Completed</small></div>                        
                        </div>
                        <div class="col-md-7" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_01_00_payments_totalAmount" class="no-margins pull-right widget-summary-text">0.00</div>
                    		<br/>
                    		<div class="font-bold text-navy"><span class="small pull-right">Total Amount</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4" style="padding:0px 5px;">
                <div class="ibox float-e-margins" style="margin:0px;">
                    <div class="ibox-title" style="padding-left:10px; padding-right:10px;">
                        <h5>Customer Summary</h5>
                    </div>
                    <div class="ibox-content" style="height:80px; padding:10px 0px;">
                    	<div class="col-md-12" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_01_00_customers_uniqueCount" class="no-margins pull-right widget-summary-text">0.00</div>
                            <br/><br/>
                    		<div class="font-bold text-navy"><span class="small pull-right">Unique Customers</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- .end of row #2 -->
        
        <div class="row">
            <div class="col-md-12" style="padding:0px 5px;">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>REPORT</h5>
                        <label title="Download PDF" id="rep001_01_00_downloadPdf" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_01_00_downloadPdf();">
			                <i class="fa fa-download" aria-hidden="true"></i> PDF
			            </label>
			            <label title="Download CSV" id="rep001_01_00_downloadCsv" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_01_00_downloadCsv();">
			                <i class="fa fa-download" aria-hidden="true"></i> CSV
			            </label>
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                        	<table id="rep001_01_00_dataTable_billingList" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>Billing Date</th>
										<th>Billing No</th>
										<th>Invoice No</th>
										<th>Status</th>
										<th>Customer</th>
										<th style="text-align:right;">Total Amount</th>
										<th style="text-align:right;">Total Payment</th>
									</tr>
								</thead>
								<tbody id="rep001_01_00_dataTable_billingList_tbody">
								</tbody>
							</table>
                        </div>
                    </div> <!-- .end of ibox-content -->
                </div>
            </div>
        </div> <!-- .end of row #4 -->
        
    </div>
    
    <div id="rep001_01_00_reportDetails_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
</div>

<script>

var rep001_01_00_customerList = [];

var rep001_01_00_initialized = false;
var rep001_01_00_dateStart;
var rep001_01_00_dateEnd;
var rep001_01_00_selectedCustomerId = '';
var rep001_01_00_selectedStateList = [];

/**
 * Init Panel
 */
function rep001_01_00_init()
{
    if (rep001_01_00_initialized == true)
        return false;

    // Init DataTable
	$("#rep001_01_00_dataTable_billingList").DataTable({
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "displayLength": 10,
	   	"order": [[0, "asc"]]
    });
    // Set table width
	$('.dataTables_wrapper').css('width','98%');
	
	rep001_01_00_dateStart = moment().subtract(29, 'days').toDate();
	rep001_01_00_dateEnd = moment().toDate();
	
    // Date Range Picker - http://www.daterangepicker.com/
    $('#rep001_01_00_dateRange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

    $('#rep001_01_00_dateRange').daterangepicker({
        format: 'MM/DD/YYYY',
        startDate: moment().subtract(29, 'days'),
        endDate: moment(),
        minDate: '01/01/2015',
        maxDate: '12/31/2030',
        dateLimit: { days: 60 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        opens: 'right',
        drops: 'down',
        buttonClasses: ['btn', 'btn-sm'],
        applyClass: 'btn-primary',
        cancelClass: 'btn-default',
        separator: ' to ',
        locale: {
            applyLabel: 'Apply',
            cancelLabel: 'Cancel',
            fromLabel: 'From',
            toLabel: 'To',
            customRangeLabel: 'Custom',
            daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr','Sa'],
            monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            firstDay: 1
        }
    }, function(start, end, label) {
        
        rep001_01_00_dateStart = start.toDate();
        rep001_01_00_dateEnd = end.toDate();
    
        $('#rep001_01_00_dateRange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });

    // Init chosen-select: Status Event
    $('#rep001_01_00_filter_status').empty();
    
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.workflowList, function(i, workflowObj){
    	
    	if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
    	{
    		$.each(workflowObj.eventList, function(j, eventObj){
    			var htmlLines = '';
    	    	htmlLines += '<option value="' + eventObj.eventKey + '">';
    	    	htmlLines += eventObj.eventDescription;
    			htmlLines += '</option>';
    	    	
    	    	$('#rep001_01_00_filter_status').append(htmlLines);    			
    		});
    	}
    });
    
	$('#rep001_01_00_filter_status').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_01_00_filter_status').on('change', rep001_01_00_selectStatus);

	rep001_01_00_initialized = true;
} // .end of rep001_01_00_init

/**
 * Update UI of panel.
 */
function rep001_01_00_updateUI()
{
    rep001_01_00_init();

    $('#rep001_01_00').show();
} // .end of rep001_01_00_updateUI

/**
 * Handler when user select customer from chosen-select.
 */
function rep001_01_00_selectCustomer(event, params)
{
	rep001_01_00_selectedCustomerId = params.selected;
} // .end of rep001_01_00_selectCustomer

/**
 * Handler when user select status from chosen-select.
 */
function rep001_01_00_selectStatus(event, params)
{
	if (rep001_01_00_selectedStateList==null)
		rep001_01_00_selectedStateList = [];
	
	if (params.selected != null)
	{	
		if (params.selected=='')
			rep001_01_00_selectedStateList = [];
		else
		{	
			rep001_01_00_selectedStateList.push(params.selected);
		}
	}
	
	if (params.deselected != null)
	{
		var index = rep001_01_00_selectedStateList.indexOf(params.deselected);
		rep001_01_00_selectedStateList.splice(index, 1);
	}
} // .end of rep001_01_00_selectStatus

/**
 * Show/hide filter pane.
 */
function rep001_01_00_toggleFilter(element)
{
	var isHidden = $('#rep001_01_00_filter').hasClass('hidden');
	if (isHidden)
	{
		$(element).html('<i class="fa fa-filter" aria-hidden="true"></i> Hide Filters');
		$('#rep001_01_00_filter').removeClass('hidden');
		$('#rep001_01_00_filter').show();
		
		if (rep001_01_00_customerList == null || rep001_01_00_customerList.length == 0)
		{
			$('#rep001_01_00_filter').hide();
			$('#rep001_01_00_filter_spinner').show();
			// Ajax call to get all customers
			rep001_01_00_populateCustomerList();
		}
	}
	else
	{
		$(element).html('<i class="fa fa-filter" aria-hidden="true"></i> Show Filters');
		$('#rep001_01_00_filter').addClass('hidden');
		$('#rep001_01_00_filter').hide();
	}
} // .end of rep001_01_00_toggleFilter

function rep001_01_00_populateCustomerList()
{
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'fullBean': false
	};
	
	var params = new Object();
	
	// Call API
	tycheesdb_api_getCustomersByPlace(requestBody, rep001_01_00_populateCustomerList_postHandler, params);
} // .end of rep001_01_00_populateCustomerList

function rep001_01_00_populateCustomerList_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false)
		return false;
	
	rep001_01_00_customerList = responseObj.customerList;
	
	// Sort
	rep001_01_00_customerList.sort(function(a, b){
		if(a.firstName < b.firstName) return -1;
    	if(a.firstName > b.firstName) return 1;
    	return 0;
	});
	
	// Init chosen-select: Customer
    $('#rep001_01_00_filter_customer').empty();
    $('#rep001_01_00_filter_customer').append('<option value="">Show All</option>');
    
    $.each(rep001_01_00_customerList, function(i, customerObj){
    	var htmlLines = '';
    	htmlLines += '<option value="' + customerObj.id + '">';
    	htmlLines += (customerObj.firstName + ' ' + customerObj.lastName);
    	htmlLines += '</option>';
    	
    	$('#rep001_01_00_filter_customer').append(htmlLines);
    });

	$('#rep001_01_00_filter_customer').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_01_00_filter_customer').on('change', rep001_01_00_selectCustomer);
	
	// Show/Hide
	$('#rep001_01_00_filter').show();
	$('#rep001_01_00_filter_spinner').hide();
} // .end of rep001_01_00_populateCustomerList_postHandler

function rep001_01_00_refresh(postHandlerFn, params)
{
    if (rep001_01_00_dateStart==null || rep001_01_00_dateEnd==null)
    {
    	sweetAlert("No Date Range Selected", "Please select another date range.", "warning");
    	return false;
    }
    
    // Show/Hide
    $('#rep001_01_00_reportDetails').hide();
    $('#rep001_01_00_reportDetails_spinner').show();
    
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'beginTime': rep001_01_00_dateStart.getTime(),
		'endTime': rep001_01_00_dateEnd.getTime(),
		'fullBean': false,
		'transactionBean': false
	};
	
	if (params == null)
		params = new Object();
	if (postHandlerFn != null)
		params.postHandlerFn = postHandlerFn;
	
	// Call API
	tycheesdb_api_getBillingsByTimePeriod(requestBody, rep001_01_00_refresh_postHandler, params);
} // .end of rep001_01_00_refresh

/**
 * Refresh page, based on current user inputs. 
 */
function rep001_01_00_refresh_postHandler(successFlag, responseObj, params)
{
	if (successFlag == false)
		return false;
	
	var report_2d_array = [];
    var rowCount = 1;
    var billingCount = 0;
    var billingTotalAmount = 0;
    var paymentCompletedCount = 0;
    var paymentTotalAmount = 0;
    var newCustomerIdList = [];
    var customerIdList = [];

	// Clear payment list
	$('#rep001_01_00_dataTable_billingList').DataTable().clear().draw();
	$.each(responseObj.billingList, function(i, billingObj){

		if ($.trim(rep001_01_00_selectedCustomerId) != '')
		{
			if (billingObj.customerId != rep001_01_00_selectedCustomerId)
				return true;
		}
		
		tycheesLogger_logDebug('billingObj.state='+billingObj.state, 'rep001_01_00_refresh');
		tycheesLogger_logDebug('billingObj.stateDesc='+billingObj.stateDesc, 'rep001_01_00_refresh');
		
		if (rep001_01_00_selectedStateList.length > 0)
		{
			var index = rep001_01_00_selectedStateList.indexOf(billingObj.state);
			if (index == -1)
				return true;
		}
		
		billingCount++;
		billingTotalAmount += billingObj.totalAmount;
		
		paymentTotalAmount += billingObj.totalPayment;
		if (billingObj.totalPayment >= billingObj.totalAmount)
			paymentCompletedCount++;
		
		// Check Customer Id
		if ($.trim(billingObj.customerId) != '') {
			if (customerIdList.indexOf($.trim(billingObj.customerId)) == -1) {
				customerIdList.push($.trim(billingObj.customerId));
			}
		}
		
		// For DataTable
		var rowSet = [];
		rowSet.push( tycheesDateTime_getFormattedDate_yyyyMMdd(billingObj.billingDate) );
		rowSet.push( billingObj.billingNo );
		rowSet.push( billingObj.invoiceNo );
		rowSet.push( billingObj.stateDesc );
		rowSet.push( $.trim(billingObj.customerName)=='' ? 'N/A' : billingObj.customerName );
		rowSet.push( '<span class="pull-right">' + Number(billingObj.totalAmount).toFixed(2) + '</span>' );
		rowSet.push( '<span class="pull-right">' + Number(billingObj.totalPayment).toFixed(2) + '</span>' );
		
		// For CSV/PDF
		var dataRowSet = [];
		dataRowSet.push( tycheesDateTime_getFormattedDate_yyyyMMdd(billingObj.billingDate) );
		dataRowSet.push( billingObj.billingNo );
		dataRowSet.push( billingObj.invoiceNo );
		dataRowSet.push( billingObj.stateDesc );
		dataRowSet.push( $.trim(billingObj.customerName)=='' ? 'N/A' : billingObj.customerName );
		dataRowSet.push( Number(billingObj.totalAmount).toFixed(2) );
		dataRowSet.push( Number(billingObj.totalPayment).toFixed(2) );
		
		// Increment Row Count
		rowCount++;
		// Add row into 2d array
		report_2d_array.push(dataRowSet);
		// Add row into DataTable
		$("#rep001_01_00_dataTable_billingList").dataTable().fnAddData( rowSet, false );
	});

	// Sort dataRowSet, by billing date
	report_2d_array.sort(function(a, b) {
		return tycheesList_sortByString(a[0], b[0]);
	});
	
	// Redraw Table
	$("#rep001_01_00_dataTable_billingList").DataTable().draw();
	
	// Panel - Billing Orders
	$('#rep001_01_00_orders_count').html(billingCount);
	$('#rep001_01_00_orders_totalAmount').html('<i class="fa fa-usd" aria-hidden="true"></i> ' + Number(billingTotalAmount).toFixed(2));

	// Panel - Payments
	$('#rep001_01_00_payments_completedCount').html(paymentCompletedCount);
	$('#rep001_01_00_payments_totalAmount').html('<i class="fa fa-usd" aria-hidden="true"></i> ' + Number(paymentTotalAmount).toFixed(2));
	
	// Panel - Customers
	$('#rep001_01_00_customers_newCount').html(newCustomerIdList.length);
	$('#rep001_01_00_customers_uniqueCount').html(customerIdList.length);
	
	if (report_2d_array.length==0)
	{
		sweetAlert("No Result Found", "Please select another date range.", "info");
	}
	
    // Show/Hide
    $('#rep001_01_00_reportDetails').show();
    $('#rep001_01_00_reportDetails_spinner').hide();
	
	if (params.postHandlerFn != null)
		params.postHandlerFn(report_2d_array, params);
} // .end of rep001_01_00_refresh_postHandler

/**
 * Hide panel.
 */
function rep001_01_00_hide()
{
    $('#rep001_01_00').hide();
} // .end of rep001_01_00_hide

/**
 * Generate & download PDF file of current selection.
 */
function rep001_01_00_screenshotPdf()
{
	rep001_01_00_refresh(rep001_01_00_screenshotPdf_postHandler);
} // .end of rep001_01_00_screenshotPdf

function rep001_01_00_screenshotPdf_postHandler(reportArray)
{
	var pdfDoc = new jsPDF('l', 'pt', 'a4');
	var margins = {top: 50, bottom: 10, left: 10, width: 600 };

	pdfDoc.addHTML(
	    $('#rep001_01_00_reportDetails')[0], 
	    function () {

	   		var pdfFileName = '';
	   		pdfFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	   		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	   		pdfFileName += '.pdf';
	    		
	    	pdfDoc.save( pdfFileName );
	 	},
	 	margins
	);
} // .end of rep001_01_00_screenshotPdf_postHandler

/**
 * Generate & download PDF file of current selection.
 */
function rep001_01_00_downloadPdf()
{	
	rep001_01_00_generatePDF(false, true);
} // .end of rep001_01_00_downloadPdf

/**
 * Generate & download Spreadsheet file of current selection.
 */
function rep001_01_00_downloadCsv()
{
	rep001_01_00_refresh(rep001_01_00_downloadCsv_postHandler);
} // .end of rep001_01_00_downloadCsv

function rep001_01_00_downloadCsv_postHandler(reportArray)
{
	var csvContent = "data:text/csv;charset=utf-8,";
	
	// Header
	csvContent += 'Billing Date,';
	csvContent += 'Billing No,';
	csvContent += 'Invoice No,';
	csvContent += 'Status,';
	csvContent += 'Customer,';
	csvContent += 'Total Amount,';
	csvContent += 'Total Payment';
	csvContent += '\n';
	
	// Content
	$.each(reportArray, function(i, rowArray){
	   var dataString = rowArray.join(",");
	   csvContent += i < reportArray.length ? dataString+ "\n" : dataString;
	}); 
	
	var csvFileName = '';
	csvFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	csvFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	csvFileName += '.csv';
	
	var encodedUri = encodeURI(csvContent);
	var link = document.createElement("a");
	link.setAttribute("href", encodedUri);
	link.setAttribute("download", csvFileName);
	document.body.appendChild(link); // Required for FF

	link.click(); // This will download the data file named "my_data.csv".
} // .end of rep001_01_00_downloadCsv_postHandler

/**
 * Print Friendly
 */
function rep001_01_00_printFriendly()
{
	rep001_01_00_generatePDF(true, false);
} // .end of rep001_01_00_printFriendly

/**
 * Generate PDF
 *
 * @param {Boolean} printFriendly - true if print; otherwise false.
 * @param {Boolean} downloadNow - true if download; otherwise false.
 * @return	{jsPDF}
 */
function rep001_01_00_generatePDF(printFriendly, downloadNow)
{
	var params = new Object();
	params.printFriendly = printFriendly;
	params.downloadNow = downloadNow;
	
	rep001_01_00_refresh(rep001_01_00_generatePDF_postHandler, params);
} // .end of rep001_01_00_generatePDF

function rep001_01_00_generatePDF_postHandler(reportArray, params)
{
	var doc = new jsPDF("landscape", "pt", "a4");
	
	doc.setFontSize(16);
	doc.text(376, 30, 'Billing Report');
	
	doc.setFontSize(12);
	doc.text(365, 48, tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_01_00_dateStart) + ' - ' + tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_01_00_dateEnd));
	
	doc.setLineWidth(0.1);
	doc.line(40, 55, 802, 55);	
	
	var customerObj = Cached_getCustomerById(rep001_01_00_selectedCustomerId);
	doc.setFontSize(10);
	doc.text(40, 70, 'Filter by Customer');
	doc.text(130, 70, ':');
	doc.text(140, 70, (customerObj==null ? 'Show All' : customerObj.firstName + ' ' + customerObj.lastName));

	doc.setFontSize(10);
	doc.text(40, 85, 'Filter by Status');
	doc.text(130, 85, ':');
	doc.text(140, 85, (rep001_01_00_selectedStateList.length==0 ? 'Show All' : rep001_01_00_selectedStateList.toString()));

	var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
	doc.setFontSize(10);
	doc.text(590, 70, 'Generated By');
	doc.text(680, 70, ':');
	doc.text(690, 70, (userObj==null ? 'N/A' : userObj.firstName + ' ' + userObj.lastName));

	doc.setFontSize(10);
	doc.text(590, 85, 'Generated On');
	doc.text(680, 85, ':');
	doc.text(690, 85, tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss(new Date()));

	// Table Header
	rep001_01_00_generatePDF_drawTableHeader(doc, 100);
	
	// Table Content
	var y_axis = 120;
	var cellValue_y_offset = 13;
	var rowHeight = 20;
	var maxRowCountInPage = 20;
	var pageNumber = 1;
	var totalPageCount = Math.ceil( reportArray.length / maxRowCountInPage );
	var pageHasContent = false;
	
	$.each(reportArray, function(i, rowData){

		doc.setFontSize(9);
		doc.setFontStyle('normal');
		
		doc.text(rowData[0].toString(), 40,  y_axis+cellValue_y_offset);
		doc.text(rowData[1].toString(), 170, y_axis+cellValue_y_offset);
		doc.text(rowData[2].toString(), 270, y_axis+cellValue_y_offset);
		doc.text(rowData[3].toString(), 370, y_axis+cellValue_y_offset);
		doc.text(rowData[4].toString(), 470, y_axis+cellValue_y_offset);
		doc.text(rowData[5].toString(), 702, y_axis+cellValue_y_offset, 'right');
		doc.text(rowData[6].toString(), 802, y_axis+cellValue_y_offset, 'right');

		y_axis += rowHeight;
		doc.setLineWidth(0.1);
		doc.line(40, y_axis, 802, y_axis);	
		
		pageHasContent = true;
		
		var rowNumber = i + 1;
		if ( rowNumber % maxRowCountInPage == 0 && rowNumber != reportArray.length)
		{
			// Add footer to current page
			doc.setFontSize(8);
			doc.text(395, 560, 'Page ' + pageNumber++ + ' of ' + totalPageCount );
	
			// Add new page
			doc.addPage();
			// Reset y_axis
			y_axis = 60;
			// Draw table header
			rep001_01_00_generatePDF_drawTableHeader(doc, y_axis);
			y_axis += rowHeight;
			// Reset
			pageHasContent = false;
		}
	});
	
	if (pageHasContent)
	{
		// Add footer to last page
		doc.setFontSize(8);
		doc.text(395, 560, 'Page ' + pageNumber++ + ' of ' + totalPageCount );
	}
	
	if (params.printFriendly)
	{
		var pdfFileName = '';
		pdfFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.autoPrint();	
		
		window.open(doc.output('bloburl'), '_blank');
	}
	
	if (params.downloadNow)
	{
		var pdfFileName = '';
		pdfFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.save( pdfFileName );
	}
} // .end of rep001_01_00_generatePDF_postHandler

function rep001_01_00_generatePDF_drawTableHeader(pdfDoc, y_axis)
{
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis, 802, y_axis);	
	
	pdfDoc.setFontSize(10);
	pdfDoc.setFontStyle('bold');
	pdfDoc.text('Billing Date', 40,  y_axis+13);
	pdfDoc.text('Billing No.', 170, y_axis+13);
	pdfDoc.text('Invoice No.', 270, y_axis+13);
	pdfDoc.text('Status', 370, y_axis+13);
	pdfDoc.text('Customer', 470, y_axis+13);
	pdfDoc.text('Total Amount', 702, y_axis+13, 'right');
	pdfDoc.text('Total Payment', 802, y_axis+13, 'right');

	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis+20, 802, y_axis+20);
} // .end of rep001_01_00_generatePDF_drawTableHeader

function rep001_01_00_showGrid(pdfDoc)
{
	// Draw Grid - BEGIN
	for (var i=0 ; i<842 ; i+=20) 
	{
		pdfDoc.setLineWidth(0.1);
		pdfDoc.line(i, 0, i, 595);		
	}
	
	pdfDoc.setLineWidth(0.5);
	pdfDoc.line(421, 0, 421, 595);
	
	for (var i=0 ; i<595 ; i+=20) 
	{
		pdfDoc.setLineWidth(0.1);
		pdfDoc.line(0, i, 842, i);		
	}
	
	//pdfDoc.setLineWidth(0.1);
	//pdfDoc.line(0, 298, 842, 298);
	// Draw Grid - END
} // .end of rep001_01_00_showGrid

</script>