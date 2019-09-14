
<!-- 
	Module:		Reports
	Name:		rep001_inventoryOverview	 
-->

<div id="rep001_inventoryOverview" style="display:none;">
    <div class="row" style="padding-bottom:10px;padding-top:20px;">
        <div class="col-md-6" style="padding:0px 5px;">
            <div id="rep001_inventoryOverview_dateRange" class="form-control">
                <i class="fa fa-calendar" aria-hidden="true"></i>
                <span style="padding-left:10px;"></span> 
                <b class="caret"></b>
            </div>
        </div>
        <div class="col-md-6" style="padding:0px 5px;">
        	<div class="input-group-btn">
			  	<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" style="margin-right:5px;" aria-expanded="false">
			  		<i class="fa fa-file-text-o" aria-hidden="true"></i> Select Report
			  		<span class="caret"></span>
			  	</button>
			  	<ul class="dropdown-menu" role="menu">
			    	<li>
			    		<a href="#" onclick="rep001_inventoryOverview_showTopSellingItems();">
			    			Top Selling Items 
			    			<i id="rep001_inventoryOverview_topSellingItems_checkbox" class="fa fa-check-circle menuButton-check" style="color:#1ab394; font-size:14pt; display:none;" aria-hidden="true"></i>
			    		</a>
			    	</li>
			    	<li class="divider"></li>
			    	<li>
			    		<a href="#" onclick="rep001_inventoryOverview_showZeroSoldItems();">
			    			Zero Sold Items 
			    			<i id="rep001_inventoryOverview_zeroSoldItems_checkbox" class="fa fa-check-circle menuButton-check" style="color:#1ab394; font-size:14pt; display:none;" aria-hidden="true"></i>
			    		</a>
			    	</li>
			  	</ul>
			  	<button class="btn btn-gray" type="button" id="rep001_inventoryOverview_refreshButton" onclick="rep001_inventoryOverview_refreshReport();">
			  		<i class="fa fa-refresh" aria-hidden="true"></i> Refresh
			  	</button>
			</div>
        </div>
    </div> <!-- .end of row #1 -->
    
    <div id="rep001_inventoryOverview_reportDetails" style="display:none;">     	
        <div class="row">
            <div class="col-md-12" style="padding:0px 5px;">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>REPORT: <span id="rep001_inventoryOverview_reportName"></span></h5>
                        <label title="Download PDF" id="rep001_inventoryOverview_downloadPdf" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_inventoryOverview_downloadPdf();">
			                <i class="fa fa-download" aria-hidden="true"></i> PDF
			            </label>
			            <label title="Download CSV" id="rep001_inventoryOverview_downloadCsv" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_inventoryOverview_downloadCsv();">
			                <i class="fa fa-download" aria-hidden="true"></i> CSV
			            </label>
                    </div>
                    
                    <div id="rep001_inventoryOverview_dataTable_topSelling" class="ibox-content dataTable-content" style="display:none;">
                        <div class="table-responsive">
                        	<table id="rep001_inventoryOverview_dataTable_topSellingList" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>Category</th>
										<th>Item</th>
										<th style="text-align:right;">Quantity</th>
										<th style="text-align:right;">Total Amount</th>
									</tr>
								</thead>
								<tbody id="rep001_inventoryOverview_dataTable_topSellingList_tbody">
								</tbody>
							</table>
                        </div>
                    </div> <!-- .end of ibox-content -->
                    
                    <div id="rep001_inventoryOverview_dataTable_itemState" class="ibox-content dataTable-content" style="display:none;">
                        <div class="table-responsive">
                        	<table id="rep001_inventoryOverview_dataTable_itemStateList" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>Category</th>
										<th>Item</th>
										<th style="text-align:right;">Quantity</th>
									</tr>
								</thead>
								<tbody id="rep001_inventoryOverview_dataTable_itemStateList_tbody">
								</tbody>
							</table>
                        </div>
                    </div> <!-- .end of ibox-content -->
                </div>
            </div>
        </div> <!-- .end of row -->        
    </div>
        
    <div id="rep001_inventoryOverview_reportDetails_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
</div>

<!-- REPORT PROPERTIES: TOP SELLING ITEMS -->
<%@include file="/console/reports/rep001/view/rep001_inventory/rep001_inventoryOverview_mw001.jsp" %>
<!-- REPORT PROPERTIES: ZERO SOLD ITEMS -->
<%@include file="/console/reports/rep001/view/rep001_inventory/rep001_inventoryOverview_mw002.jsp" %>

<script>

const REPORT_TYPE_TOP_SELLING_ITEMS = 'REPORT_TYPE_TOP_SELLING_ITEMS';
const REPORT_TYPE_ZERO_SOLD_ITEMS = 'REPORT_TYPE_ZERO_SOLD_ITEMS';

var rep001_inventoryOverview_initialized = false;
var rep001_inventoryOverview_selectedReport = '';
var rep001_inventoryOverview_dateStart;
var rep001_inventoryOverview_dateEnd;

function rep001_inventoryOverview_init()
{
    if (rep001_inventoryOverview_initialized == true)
        return false;

    // Init DataTable
	$("#rep001_inventoryOverview_dataTable_topSellingList").DataTable({
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "displayLength": 10,
	   	"order": [[0, "asc"]]
    });
    // Set table width
	$('.dataTables_wrapper').css('width','98%');
	
	rep001_inventoryOverview_dateStart = moment().subtract(29, 'days').toDate();
	rep001_inventoryOverview_dateEnd = moment().toDate();
	
    // Date Range Picker - http://www.daterangepicker.com/
    $('#rep001_inventoryOverview_dateRange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
    $('#rep001_inventoryOverview_dateRange').daterangepicker({
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
        
        rep001_inventoryOverview_dateStart = start.toDate();
        rep001_inventoryOverview_dateEnd = end.toDate();
    
        $('#rep001_inventoryOverview_dateRange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });

	rep001_inventoryOverview_initialized = true;
} // .end of rep001_inventoryOverview_init

function rep001_inventoryOverview_hide()
{
    $('#rep001_inventoryOverview').hide();
} // .end of rep001_inventoryOverview_hide

function rep001_inventoryOverview_updateUI()
{
    rep001_inventoryOverview_init();

    $('#rep001_inventoryOverview').show();
} // .end of rep001_inventoryOverview_updateUI

function rep001_inventoryOverview_refreshReport() 
{
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_TOP_SELLING_ITEMS) {
		rep001_inventoryOverview_showTopSellingItems();
	}
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_ZERO_SOLD_ITEMS) {
		rep001_inventoryOverview_showZeroSoldItems();
	}
} // .end of rep001_inventoryOverview_refreshReport

function rep001_inventoryOverview_showTopSellingItems(postHandlerFn, params)
{
	if (params == null)
		params = new Object();
	if (postHandlerFn != null)
		params.postHandlerFn = postHandlerFn;
	
	rep001_inventoryOverview_mw001_updateUI(
		rep001_inventoryOverview_showTopSellingItems_preHandler,
		params);	
} // .end of rep001_inventoryOverview_showTopSellingItems

function rep001_inventoryOverview_showTopSellingItems_preHandler(itemCount, itemTypeList, params)
{
	if (rep001_inventoryOverview_dateStart==null || rep001_inventoryOverview_dateEnd==null)
    {
    	sweetAlert("No Date Range Selected", "Please select another date range.", "warning");
    	return false;
    }

	// Set Button class
	$('#rep001_inventoryOverview_refreshButton').addClass('btn-primary');
	$('#rep001_inventoryOverview_refreshButton').removeClass('btn-gray');
	
	// Set Report Type/Title
	rep001_inventoryOverview_selectedReport = REPORT_TYPE_TOP_SELLING_ITEMS;
	$('#rep001_inventoryOverview_reportName').html('TOP ' + itemCount + ' SELLING ITEMS');
	
	// Set checkbox at menu button
	$('.menuButton-check').hide();
	$('#rep001_inventoryOverview_topSellingItems_checkbox').show();
	
    // Show/Hide
    $('#rep001_inventoryOverview_reportDetails').hide();
    $('#rep001_inventoryOverview_reportDetails_spinner').show();
    
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'beginTime': rep001_inventoryOverview_dateStart.getTime(),
		'endTime': rep001_inventoryOverview_dateEnd.getTime(),
		'itemCount': itemCount,
		'itemTypeList': itemTypeList.toString() 
	};

	params.itemCount = itemCount;
	params.itemTypeList = itemTypeList;
		
	// Call API
	tycheesdb_api_getReportByInventoryTopSellingItems(requestBody, rep001_inventoryOverview_showTopSellingItems_postHandler, params);
} // .end of rep001_inventoryOverview_showTopSellingItems_preHandler

function rep001_inventoryOverview_showTopSellingItems_postHandler(success, responseObj, params) 
{
	if (!success) {
		tycheesLogger_showToast('error', 'Ajax Error', 'Failed to load content.');
		return false;
	}

    var rowCount = 1;
	var report_2d_array = [];
    
	// Sort descendingly
	responseObj.resultList.sort(function(a, b){
		if(a.quantity > b.quantity) return -1;
    	if(a.quantity < b.quantity) return 1;
    	return 0;
	});
	
	// Clear payment list
	$('#rep001_inventoryOverview_dataTable_topSellingList').DataTable().clear().draw();
	$.each(responseObj.resultList, function(i, resultObj){
		var rowSet = [];
		rowSet.push( resultObj.categoryName );
		rowSet.push( resultObj.itemName );
		rowSet.push( '<span class="pull-right">' + Number(resultObj.quantity).toFixed(2) + '</span>' );
		rowSet.push( '<span class="pull-right">' + Number(resultObj.totalAmount).toFixed(2) + '</span>' );
		
		// For CSV/PDF
		var dataRowSet = [];
		dataRowSet.push( resultObj.categoryName );
		dataRowSet.push( resultObj.itemName );
		dataRowSet.push( Number(resultObj.quantity).toFixed(2) );
		dataRowSet.push( Number(resultObj.totalAmount).toFixed(2) );
				
		// Increment Row Count
		rowCount++;
		// Add row into 2d array
		report_2d_array.push(dataRowSet);
		// Add row into DataTable
		if (rowCount <= params.itemCount)
			$("#rep001_inventoryOverview_dataTable_topSellingList").dataTable().fnAddData( rowSet, false );
	});	
	
	
	if (report_2d_array.length==0) {
		sweetAlert("No Result Found", "Please select another date range.", "info");
	}
		
	// Redraw Table
	$("#rep001_inventoryOverview_dataTable_topSellingList").DataTable().draw();
	
    // Show/Hide Content, Spinner
    $('#rep001_inventoryOverview_reportDetails').show();
    $('#rep001_inventoryOverview_reportDetails_spinner').hide();
	// Show/Hide DataTable
	$('.dataTable-content').hide();
	$('#rep001_inventoryOverview_dataTable_topSelling').show();
    
	if (params.postHandlerFn != null)
		params.postHandlerFn(report_2d_array, params);
} // .end of rep001_inventoryOverview_showTopSellingItems_postHandler

function rep001_inventoryOverview_showZeroSoldItems(postHandlerFn, params)
{
	if (params == null)
		params = new Object();
	if (postHandlerFn != null)
		params.postHandlerFn = postHandlerFn;
	
	rep001_inventoryOverview_mw002_updateUI(
		rep001_inventoryOverview_showZeroSoldItems_preHandler,
		params);	
} // .end of rep001_inventoryOverview_showZeroSoldItems

function rep001_inventoryOverview_showZeroSoldItems_preHandler(itemTypeList, params)
{
	if (rep001_inventoryOverview_dateStart==null || rep001_inventoryOverview_dateEnd==null)
    {
    	sweetAlert("No Date Range Selected", "Please select another date range.", "warning");
    	return false;
    }

	// Set Button class
	$('#rep001_inventoryOverview_refreshButton').addClass('btn-primary');
	$('#rep001_inventoryOverview_refreshButton').removeClass('btn-gray');
	
	// Set Report Type/Title
	rep001_inventoryOverview_selectedReport = REPORT_TYPE_ZERO_SOLD_ITEMS;
	$('#rep001_inventoryOverview_reportName').html('ZERO SOLD ITEMS');

	// Set checkbox at menu button
	$('.menuButton-check').hide();
	$('#rep001_inventoryOverview_zeroSoldItems_checkbox').show();

    // Show/Hide
    $('#rep001_inventoryOverview_reportDetails').hide();
    $('#rep001_inventoryOverview_reportDetails_spinner').show();
    
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'beginTime': rep001_inventoryOverview_dateStart.getTime(),
		'endTime': rep001_inventoryOverview_dateEnd.getTime(),
		'itemCount': 9999,
		'itemTypeList': itemTypeList.toString() 
	};

	params.itemTypeList = itemTypeList;
		
	// Call API
	tycheesdb_api_getReportByInventoryZeroSoldItems(requestBody, rep001_inventoryOverview_showZeroSoldItems_postHandler, params);
} // .end of rep001_inventoryOverview_showZeroSoldItems

function rep001_inventoryOverview_showZeroSoldItems_postHandler(success, responseObj, params) 
{
	if (!success) {
		tycheesLogger_showToast('error', 'Ajax Error', 'Failed to load content.');
		return false;
	}

    var rowCount = 1;
	var report_2d_array = [];
    
	// Sort descendingly
	responseObj.resultList.sort(function(a, b){
		if(a.itemName < b.itemName) return -1;
    	if(a.itemName > b.itemName) return 1;
    	return 0;
	});
	
	// Clear payment list
	$('#rep001_inventoryOverview_dataTable_itemStateList').DataTable().clear().draw();
	$.each(responseObj.resultList, function(i, resultObj){
		var rowSet = [];
		rowSet.push( resultObj.categoryName );
		rowSet.push( resultObj.itemName );
		rowSet.push( '<span class="pull-right">' + Number(resultObj.quantity).toFixed(2) + '</span>' );
		
		// For CSV/PDF
		var dataRowSet = [];
		dataRowSet.push( resultObj.categoryName );
		dataRowSet.push( resultObj.itemName );
		dataRowSet.push( Number(resultObj.quantity).toFixed(2) );
				
		// Increment Row Count
		rowCount++;
		// Add row into 2d array
		report_2d_array.push(dataRowSet);
		// Add row into DataTable
		$("#rep001_inventoryOverview_dataTable_itemStateList").dataTable().fnAddData( rowSet, false );
	});	
	
	
	if (report_2d_array.length==0) {
		sweetAlert("No Result Found", "Please select another date range.", "info");
	}
		
	// Redraw Table
	$("#rep001_inventoryOverview_dataTable_itemStateList").DataTable().draw();
	
    // Show/Hide content, spinner
    $('#rep001_inventoryOverview_reportDetails').show();
    $('#rep001_inventoryOverview_reportDetails_spinner').hide();
	// Show/Hide DataTable
	$('.dataTable-content').hide();
	$('#rep001_inventoryOverview_dataTable_itemState').show();
	
	if (params.postHandlerFn != null)
		params.postHandlerFn(report_2d_array, params);
} // .end of rep001_inventoryOverview_showZeroSoldItems_postHandler

/**
 * Generate & download Spreadsheet file of current selection.
 */
function rep001_inventoryOverview_downloadCsv()
{
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_TOP_SELLING_ITEMS) {
		rep001_inventoryOverview_showTopSellingItems(rep001_inventoryOverview_downloadCsv_postHandler);
	}
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_ZERO_SOLD_ITEMS) {
		rep001_inventoryOverview_showZeroSoldItems(rep001_inventoryOverview_downloadCsv_postHandler);
	}
} // .end of rep001_inventoryOverview_downloadCsv

function rep001_inventoryOverview_downloadCsv_postHandler(reportArray)
{
	var csvContent = "data:text/csv;charset=utf-8,";
	
	// CSV Header
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_TOP_SELLING_ITEMS) {
		csvContent += 'Category,';
		csvContent += 'Item,';
		csvContent += 'Quantity,';
		csvContent += 'Total Amount';
		csvContent += '\n';
	}
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_ZERO_SOLD_ITEMS) {
		csvContent += 'Category,';
		csvContent += 'Item,';
		csvContent += 'Quantity';
		csvContent += '\n';
	}
	
	// Content
	$.each(reportArray, function(i, rowArray){
	   var dataString = rowArray.join(",");
	   csvContent += i < reportArray.length ? dataString+ "\n" : dataString;
	}); 
	
	var csvFileName = '';
	csvFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	csvFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	csvFileName += '.csv';
	
	var encodedUri = encodeURI(csvContent);
	var link = document.createElement("a");
	link.setAttribute("href", encodedUri);
	link.setAttribute("download", csvFileName);
	document.body.appendChild(link); // Required for FF

	link.click(); // This will download the data file named "my_data.csv".
} // .end of rep001_inventoryOverview_downloadCsv_postHandler

/**
 * Generate & download PDF file of current selection.
 */
function rep001_inventoryOverview_downloadPdf()
{	
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_TOP_SELLING_ITEMS) {
		rep001_inventoryOverview_generatePDF(false, true);
	}
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_ZERO_SOLD_ITEMS) {
		rep001_inventoryOverview_generatePDF(false, true);
	}
} // .end of rep001_inventoryOverview_downloadPdf

/**
 * Generate PDF
 *
 * @param {Boolean} printFriendly - true if print; otherwise false.
 * @param {Boolean} downloadNow - true if download; otherwise false.
 * @return	{jsPDF}
 */
function rep001_inventoryOverview_generatePDF(printFriendly, downloadNow)
{
	var params = new Object();
	params.printFriendly = printFriendly;
	params.downloadNow = downloadNow;

	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_TOP_SELLING_ITEMS) {
		rep001_inventoryOverview_showTopSellingItems(rep001_inventoryOverview_topSellingItems_generatePDF_postHandler, params);
	}
	if (rep001_inventoryOverview_selectedReport == REPORT_TYPE_ZERO_SOLD_ITEMS) {
		rep001_inventoryOverview_showZeroSoldItems(rep001_inventoryOverview_zeroSoldItems_generatePDF_postHandler, params);
	}
} // .end of rep001_inventoryOverview_topSellingItems_generatePDF

function rep001_inventoryOverview_topSellingItems_generatePDF_postHandler(reportArray, params)
{
	var doc = new jsPDF("landscape", "pt", "a4");
	
	doc.setFontSize(16);
	doc.text(300, 30, 'Inventory Report: TOP ' + params.itemCount + ' SELLING ITEMS');
	
	doc.setFontSize(12);
	doc.text(365, 48, tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_inventoryOverview_dateStart) + ' - ' + tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_inventoryOverview_dateEnd));
	
	doc.setLineWidth(0.1);
	doc.line(40, 55, 802, 55);	
	
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
	rep001_inventoryOverview_topSellingItems_generatePDF_drawTableHeader(doc, 100);
	
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
		doc.text(rowData[1].toString(), 270, y_axis+cellValue_y_offset);
		doc.text(rowData[2].toString(), 702, y_axis+cellValue_y_offset, 'right');
		doc.text(rowData[3].toString(), 802, y_axis+cellValue_y_offset, 'right');

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
			rep001_inventoryOverview_topSellingItems_generatePDF_drawTableHeader(doc, y_axis);
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
		pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.autoPrint();	
		
		window.open(doc.output('bloburl'), '_blank');
	}
	
	if (params.downloadNow)
	{
		var pdfFileName = '';
		pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.save( pdfFileName );
	}
} // .end of rep001_inventoryOverview_topSellingItems_generatePDF_postHandler

function rep001_inventoryOverview_topSellingItems_generatePDF_drawTableHeader(pdfDoc, y_axis)
{
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis, 802, y_axis);	
	
	pdfDoc.setFontSize(10);
	pdfDoc.setFontStyle('bold');
	pdfDoc.text('Category', 40,  y_axis+13);
	pdfDoc.text('Item', 270, y_axis+13);
	pdfDoc.text('Quantity', 702, y_axis+13, 'right');
	pdfDoc.text('Total Amount', 802, y_axis+13, 'right');

	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis+20, 802, y_axis+20);
} // .end of rep001_inventoryOverview_topSellingItems_generatePDF_drawTableHeader

function rep001_inventoryOverview_zeroSoldItems_generatePDF_postHandler(reportArray, params)
{
	var doc = new jsPDF("landscape", "pt", "a4");
	
	doc.setFontSize(16);
	doc.text(300, 30, 'Inventory Report: ZERO SOLD ITEMS');
	
	doc.setFontSize(12);
	doc.text(365, 48, tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_inventoryOverview_dateStart) + ' - ' + tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_inventoryOverview_dateEnd));
	
	doc.setLineWidth(0.1);
	doc.line(40, 55, 802, 55);	
	
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
	rep001_inventoryOverview_zeroSoldItems_generatePDF_drawTableHeader(doc, 100);
	
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
		doc.text(rowData[1].toString(), 270, y_axis+cellValue_y_offset);
		doc.text(rowData[2].toString(), 802, y_axis+cellValue_y_offset, 'right');

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
			rep001_inventoryOverview_zeroSoldItems_generatePDF_drawTableHeader(doc, y_axis);
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
		pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.autoPrint();	
		
		window.open(doc.output('bloburl'), '_blank');
	}
	
	if (params.downloadNow)
	{
		var pdfFileName = '';
		pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.save( pdfFileName );
	}
} // .end of rep001_inventoryOverview_zeroSoldItems_generatePDF_postHandler

function rep001_inventoryOverview_zeroSoldItems_generatePDF_drawTableHeader(pdfDoc, y_axis)
{
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis, 802, y_axis);	
	
	pdfDoc.setFontSize(10);
	pdfDoc.setFontStyle('bold');
	pdfDoc.text('Category', 40,  y_axis+13);
	pdfDoc.text('Item', 270, y_axis+13);
	pdfDoc.text('Quantity', 802, y_axis+13, 'right');

	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis+20, 802, y_axis+20);
} // .end of rep001_inventoryOverview_zeroSoldItems_generatePDF_drawTableHeader

</script>