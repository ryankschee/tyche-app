<!-- rep001_01_02: Reports -->
<div id="rep001_01_02" style="display:none;">
	<div class="row" style="padding-bottom:10px;padding-top:20px;">
        <div class="col-md-6" style="padding:0px 5px;">
            <div id="rep001_01_02_dateRange" class="form-control">
                <i class="fa fa-calendar" aria-hidden="true"></i>
                <span style="padding-left:10px;"></span> 
                <b class="caret"></b>
            </div>
        </div>
        <div class="col-md-6" style="padding:0px 5px;">
            <label title="Refresh" id="rep001_01_02_refreshReports" class="btn btn-primary pull-right" onclick="rep001_01_02_refresh();">
                <i class="fa fa-cog" aria-hidden="true"></i> Generate Report
            </label>
        </div>
    </div> <!-- .end of row #1 -->
    
    <div id="rep001_01_02_reportDetails" style="display:none;"> 
    	<div class="row">
    		<div class="col-md-4" style="padding:0px 5px;">
                <div class="ibox float-e-margins" style="margin:0px;">
                    <div class="ibox-title" style="padding-left:10px; padding-right:10px;">
                        <h5>Order Summary</h5>
                    </div>
                    <div class="ibox-content" style="height:80px; padding:10px 0px;">
                        <div class="col-md-5" style="padding-left:10px; padding-right:10px;">
                        	<div id="rep001_01_02_orders_count" class="no-margins widget-summary-text">0.00</div>
                    		<div class="font-bold text-navy"><small>Orders</small></div>                        
                        </div>
                        <div class="col-md-7" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_01_02_orders_totalAmount" class="no-margins pull-right widget-summary-text">0.00</div>
                            <br/>
                    		<div class="font-bold text-navy"><span class="small pull-right">Total Amount (<span class='currency'></span>)</span></div>
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
                        	<div id="rep001_01_02_payments_completedCount" class="no-margins widget-summary-text">0.00</div>
                    		<div class="font-bold text-navy"><small>Paid Orders</small></div>                        
                        </div>
                        <div class="col-md-7" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_01_02_payments_totalAmount" class="no-margins pull-right widget-summary-text">0.00</div>
                            <br/>
                    		<div class="font-bold text-navy"><span class="small pull-right">Total Amount (<span class='currency'></span>)</span></div>
                        </div>
                    </div>
                </div>
            </div>
    	</div>      
        <div class="row">
            <div class="col-md-12" style="padding:0px 5px;">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>REPORT</h5>
                        <label title="Download PDF" id="rep001_01_02_downloadPdf" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_01_02_downloadPdf();">
			                <i class="fa fa-download" aria-hidden="true"></i> PDF
			            </label>
			            <label title="Download CSV" id="rep001_01_02_downloadCsv" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_01_02_downloadCsv();">
			                <i class="fa fa-download" aria-hidden="true"></i> CSV
			            </label>
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                        	<table id="rep001_01_02_dataTable_billingList" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<!-- th data-toggle="true">#</th-->
										<th>Payment Date</th>
										<th>Customer</th>
										<th>Billing No</th>
										<th>Description</th>
										<th>Method</th>
										<th style="text-align:right;">Amount (<span class='currency'></span>)</th>
									</tr>
								</thead>
								<tbody id="rep001_01_02_dataTable_billingList_tbody">
								</tbody>
							</table>
                        </div>
                    </div> <!-- .end of ibox-content -->
                </div>
            </div>
        </div> <!-- .end of row #4 -->
        
    </div>
    
    <div id="rep001_01_02_reportDetails_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
</div>

<script>

var rep001_01_02_customerList = [];

var rep001_01_02_initialized = false;
var rep001_01_02_currency;
var rep001_01_02_dateStart;
var rep001_01_02_dateEnd;

function rep001_01_02_init()
{
    if (rep001_01_02_initialized == true)
        return false;

    // Set currency
	rep001_01_02_currency = settingsCommon_getSettingsValue(
								ModuleConstants.MODULE_BILLING, 
								ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
								SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);
    $('.currency').html(rep001_01_02_currency.toUpperCase());
    
    // Init DataTable
	$("#rep001_01_02_dataTable_billingList").DataTable({
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "displayLength": 10,
	   	"order": [[0, "asc"],[1, "asc"]]
    });
    // Set table width
	$('.dataTables_wrapper').css('width','98%');
	

	rep001_01_02_dateStart = moment().subtract(29, 'days').toDate();
	rep001_01_02_dateEnd = moment().toDate();
	
    // Date Range Picker - http://www.daterangepicker.com/
    $('#rep001_01_02_dateRange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

    $('#rep001_01_02_dateRange').daterangepicker({
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
        
        rep001_01_02_dateStart = start.toDate();
        rep001_01_02_dateEnd = end.toDate();
    
        $('#rep001_01_02_dateRange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });

	rep001_01_02_initialized = true;
} // .end of rep001_01_02_init

function rep001_01_02_updateUI()
{
    rep001_01_02_init();

    $('#rep001_01_02').show();
} // .end of rep001_01_02_updateUI

function rep001_01_02_refresh(postHandlerFn, params)
{
    if (rep001_01_02_dateStart==null || rep001_01_02_dateEnd==null)
    {
    	sweetAlert("No Date Range Selected", "Please select another date range.", "warning");
    	return false;
    }
    
    // Show/Hide
    $('#rep001_01_02_reportDetails').hide();
    $('#rep001_01_02_reportDetails_spinner').show();
    
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'beginTime': rep001_01_02_dateStart.getTime(),
		'endTime': rep001_01_02_dateEnd.getTime(),
		'fullBean': true,
		'transactionBean': false
	};
	
	if (params == null)
		params = new Object();
	if (postHandlerFn != null)
		params.postHandlerFn = postHandlerFn;

	params.beginTime = rep001_01_02_dateStart.getTime();
	params.endTime = rep001_01_02_dateEnd.getTime();
	
	// Call API
	tycheesdb_api_getBillingsByPaymentTimePeriod(requestBody, rep001_01_02_refresh_postHandler, params);
} // .end of rep001_01_02_refresh

/**
 * Refresh page, based on current user inputs. 
 */
function rep001_01_02_refresh_postHandler(successFlag, responseObj, params)
{
	if (successFlag == false)
		return false;
	
	var report_2d_array = [];
    var billingCount = 0;
    var billingTotalAmount = 0;
    var paymentCompletedCount = 0;
    var paymentTotalAmount = 0;

	// Clear payment list
	$('#rep001_01_02_dataTable_billingList').DataTable().clear().draw();
	$.each(responseObj.billingList, function(i, billingObj){

		billingCount++;
		billingTotalAmount += billingObj.totalAmount;

		paymentTotalAmount += billingObj.totalPayment;
		if (billingObj.totalPayment >= billingObj.totalAmount)
			paymentCompletedCount++;
		
		$.each(billingObj.paymentList, function(j, paymentObj) {
			
			if (paymentObj.status == 'void')
				return true;
			
			if (paymentObj.paymentDate >= params.beginTime &&
				paymentObj.paymentDate <= params.endTime)
			{		
				var paymentMethod = '';
				if (paymentObj.method == BillingConstants.PAYMENT_METHOD_CREDIT_CARD) {
					var creditCardType = billingCommon_getCreditCardTypeName(paymentObj);
					
					paymentMethod = $.trim(paymentObj.method).toUpperCase();
					if ($.trim(creditCardType) != '')
						paymentMethod += (' (' + creditCardType + ')');
				} else {
					paymentMethod = $.trim(paymentObj.method).toUpperCase();
				}
				
				// For DataTable
				var rowSet = [];
				rowSet.push( tycheesDateTime_getFormattedDate_yyyyMMdd(paymentObj.paymentDate) );
				rowSet.push( $.trim(billingObj.customerName)=='' ? 'N/A' : billingObj.customerName );
				rowSet.push( billingObj.billingNo );
				rowSet.push( $.trim(paymentObj.details).toUpperCase() );
				rowSet.push( paymentMethod );
				rowSet.push( '<span class="pull-right">' + Number(paymentObj.payingAmount).toFixed(2) + '</span>' );
				
				// For CSV/PDF
				var dataRowSet = [];
				dataRowSet.push( tycheesDateTime_getFormattedDate_yyyyMMdd(paymentObj.paymentDate) );
				dataRowSet.push( $.trim(billingObj.customerName)=='' ? 'N/A' : billingObj.customerName );
				dataRowSet.push( billingObj.billingNo );
				dataRowSet.push( $.trim(paymentObj.details).toUpperCase() );
				dataRowSet.push( paymentMethod );
				dataRowSet.push( Number(paymentObj.payingAmount).toFixed(2) );
				
				// Add row into 2d array
				report_2d_array.push(dataRowSet);
				// Add row into DataTable
				$("#rep001_01_02_dataTable_billingList").dataTable().fnAddData( rowSet, false );	
			}
		});		
	});	

	// Sort dataRowSet, by billing date
	report_2d_array.sort(function(a, b) {
		return tycheesList_sortByString(a[0], b[0]);
	});
	
	// Redraw Table
	$("#rep001_01_02_dataTable_billingList").DataTable().draw();	
	
	// Panel - Billing Orders
	$('#rep001_01_02_orders_count').html(billingCount);
	$('#rep001_01_02_orders_totalAmount').html(Number(billingTotalAmount).toFixed(2));

	// Panel - Payments
	$('#rep001_01_02_payments_completedCount').html(paymentCompletedCount);
	$('#rep001_01_02_payments_totalAmount').html(Number(paymentTotalAmount).toFixed(2));
	
	if (report_2d_array.length==0)
	{
		sweetAlert("No Result Found", "Please select another date range.", "info");
	}
	
    // Show/Hide
    $('#rep001_01_02_reportDetails').show();
    $('#rep001_01_02_reportDetails_spinner').hide();
	
	if (params.postHandlerFn != null)
		params.postHandlerFn(report_2d_array, params);
} // .end of rep001_01_02_refresh_postHandler

/**
 * Hide panel.
 */
function rep001_01_02_hide()
{
    $('#rep001_01_02').hide();
} // .end of rep001_01_02_hide

/**
 * Generate & download PDF file of current selection.
 */
function rep001_01_02_screenshotPdf()
{
	rep001_01_02_refresh(rep001_01_02_screenshotPdf_postHandler);
} // .end of rep001_01_02_screenshotPdf

function rep001_01_02_screenshotPdf_postHandler(reportArray)
{
	var pdfDoc = new jsPDF('l', 'pt', 'a4');
	var margins = {top: 50, bottom: 10, left: 10, width: 600 };

	pdfDoc.addHTML(
	    $('#rep001_01_02_reportDetails')[0], 
	    function () {

	   		var pdfFileName = '';
	   		pdfFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	   		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	   		pdfFileName += '.pdf';
	    		
	    	pdfDoc.save( pdfFileName );
	 	},
	 	margins
	);
} // .end of rep001_01_02_screenshotPdf_postHandler

/**
 * Generate & download PDF file of current selection.
 */
function rep001_01_02_downloadPdf()
{	
	rep001_01_02_generatePDF(false, true);
} // .end of rep001_01_02_downloadPdf

/**
 * Generate & download Spreadsheet file of current selection.
 */
function rep001_01_02_downloadCsv()
{
	rep001_01_02_refresh(rep001_01_02_downloadCsv_postHandler);
} // .end of rep001_01_02_downloadCsv

function rep001_01_02_downloadCsv_postHandler(reportArray)
{
	var csvContent = "data:text/csv;charset=utf-8,";
	
	// Header
	csvContent += 'Payment Date,';
	csvContent += 'Customer,';
	csvContent += 'Billing No,';
	csvContent += 'Description,';
	csvContent += 'Method,';
	csvContent += 'Amount (' + rep001_01_02_currency.toUpperCase() + ')';
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
} // .end of rep001_01_02_downloadCsv_postHandler

/**
 * Print Friendly
 */
function rep001_01_02_printFriendly()
{
	rep001_01_02_generatePDF(true, false);
} // .end of rep001_01_02_printFriendly

/**
 * Generate PDF
 *
 * @param {Boolean} printFriendly - true if print; otherwise false.
 * @param {Boolean} downloadNow - true if download; otherwise false.
 * @return	{jsPDF}
 */
function rep001_01_02_generatePDF(printFriendly, downloadNow)
{
	var params = new Object();
	params.printFriendly = printFriendly;
	params.downloadNow = downloadNow;
	
	rep001_01_02_refresh(rep001_01_02_generatePDF_postHandler, params);
} // .end of rep001_01_02_generatePDF

function rep001_01_02_generatePDF_postHandler(reportArray, params)
{
	var doc = new jsPDF("landscape", "pt", "a4");
	
	doc.setFontSize(16);
	doc.text(330, 30, 'Billing Report - PAYMENTS');
	
	doc.setLineWidth(0.1);
	doc.line(40, 40, 802, 40);	

	doc.setFontSize(10);
	doc.text(40, 55, 'Date Range');
	doc.text(130, 55, ':');
	doc.text(140, 55, tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_01_02_dateStart) + ' - ' + tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_01_02_dateEnd));
	
	var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
	doc.setFontSize(10);
	doc.text(590, 55, 'Generated By');
	doc.text(680, 55, ':');
	doc.text(690, 55, (userObj==null ? 'N/A' : userObj.firstName + ' ' + userObj.lastName));

	doc.setFontSize(10);
	doc.text(590, 70, 'Generated On');
	doc.text(680, 70, ':');
	doc.text(690, 70, tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss(new Date()));

	// Table Header
	rep001_01_02_generatePDF_drawTableHeader(doc, 85);
	
	// Table Content
	var y_axis = 105;
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
		doc.text(rowData[2].toString(), 370, y_axis+cellValue_y_offset);
		doc.text(rowData[3].toString(), 470, y_axis+cellValue_y_offset);
		doc.text(rowData[4].toString(), 670, y_axis+cellValue_y_offset);
		doc.text(rowData[5].toString(), 802, y_axis+cellValue_y_offset, 'right');

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
			rep001_01_02_generatePDF_drawTableHeader(doc, y_axis);
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
		doc.autoPrint();	
		doc.output('dataurlnewwindow');
	}
	
	if (params.downloadNow)
	{
		var pdfFileName = '';
		pdfFileName += 'billingReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.save( pdfFileName );
	}
} // .end of rep001_01_02_generatePDF_postHandler

function rep001_01_02_generatePDF_drawTableHeader(pdfDoc, y_axis)
{
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis, 802, y_axis);	
	
	pdfDoc.setFontSize(10);
	pdfDoc.setFontStyle('bold');
	pdfDoc.text('Payment Date', 40,  y_axis+13);
	pdfDoc.text('Customer', 170,  y_axis+13);
	pdfDoc.text('Billing No', 370, y_axis+13);
	pdfDoc.text('Description', 470, y_axis+13);
	pdfDoc.text('Method', 670, y_axis+13);
	pdfDoc.text('Amount (' + rep001_01_02_currency.toUpperCase() + ')', 802, y_axis+13, 'right');
	
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis+20, 802, y_axis+20);
} // .end of rep001_01_02_generatePDF_drawTableHeader

</script>