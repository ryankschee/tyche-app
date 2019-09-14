
<!-- rep001_02_00: Inventory Reports - Overview -->
<div id="rep001_02_00" style="display:none;">
	<!-- 
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	BILLING STATISTICAL REPORTS: OVERVIEW
	</span>
	 -->   
    <div class="row" style="padding-bottom:10px;padding-top:20px;">
        <div class="col-lg-6">
            <div id="rep001_02_00_dateRange" class="form-control">
                <i class="fa fa-calendar" aria-hidden="true"></i>
                <span style="padding-left:10px;"></span> 
                <b class="caret"></b>
            </div>
        </div>
        <div class="col-lg-6">
            <label title="Refresh" id="rep001_02_00_refreshReports" class="btn btn-primary" onclick="rep001_02_00_refresh();">
                <i class="fa fa-refresh" aria-hidden="true"></i> Refresh
            </label>
            <label title="Report Filter" id="rep001_02_00_toggleFilter" class="btn btn-link" onclick="rep001_02_00_toggleFilter(this);" style="font-size:9pt;"> 
            	<i class="fa fa-filter" aria-hidden="true"></i> Show Filters
            </label>	
            <label title="Download PDF" id="rep001_02_00_downloadPdf" class="btn btn-sm btn-info pull-right" style="margin-right:3px;" onclick="rep001_02_00_downloadPdf();">
                <i class="fa fa-download" aria-hidden="true"></i> PDF
            </label>
            <label title="Download CSV" id="rep001_02_00_downloadCsv" class="btn btn-sm btn-info pull-right" style="margin-right:3px;" onclick="rep001_02_00_downloadCsv();">
                <i class="fa fa-download" aria-hidden="true"></i> CSV
            </label>
            <label title="Print Friendly" id="rep001_02_00_printFriendly" class="btn btn-sm btn-info pull-right" style="margin-right:3px;" onclick="rep001_02_00_printFriendly();">
                <i class="fa fa-print" aria-hidden="true"></i>
            </label>
            <label title="Screenshot as PDF" id="rep001_02_00_screenshotPdf" class="btn btn-sm btn-info pull-right" style="margin-right:3px;" onclick="rep001_02_00_screenshotPdf();">
                <i class="fa fa-camera-retro" aria-hidden="true"></i>
            </label>
        </div>
    </div> <!-- .end of row #1 -->
    
    <div class="row filter-hidden" id="rep001_02_00_filter" style="display:none;padding-bottom:20px;padding-top:0px;">
    	
        <div class="col-lg-3">
        	<div class="form-group">
                <label class="font-bold">Filtered by Category</label>
                <div class="input-group">
	                <select id="rep001_02_00_filter_category" data-placeholder="Show All" multiple class="chosen-select">
	                </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
        	<div class="form-group">
                <label class="font-bold">Filtered by Item Group</label>
                <div class="input-group">
	                <select id="rep001_02_00_filter_itemGroup" data-placeholder="Show All" multiple class="chosen-select">
	                </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
        	<div class="form-group">
                <label class="font-bold">Filtered by Item</label>
                <div class="input-group">
	                <select id="rep001_02_00_filter_item" data-placeholder="Show All" multiple class="chosen-select">
	                </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
        	<div class="form-group">
                <label class="font-bold">Filtered by Availability Status</label>
                <div class="input-group">
	                <select id="rep001_02_00_filter_availability" data-placeholder="Filtered by availability..." class="chosen-select">
	                </select>
                </div>
            </div>
        </div>
                 
    </div> <!-- .end of row #1 -->
    
    <div id="rep001_01_02_filter_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
    
    <div id="rep001_02_00_pdfReport" class="mail-box"> 
    
    	<div class="ibox float-e-margins">
    		<div class="ibox-content">
	            <div class="row">
		            <div class="col-lg-9">
		                <div class="flot-chart">
		                    <div class="flot-chart-content" id="flot-dashboard-chart"></div>
		                </div>
		            </div>
	            	<div class="col-lg-3">
	                	<ul class="stat-list">
		                    <li>
		                        <div id="rep001_02_00_chartSummary_totalItemSold" class="no-margins" style="font-size:18pt;">2,346</div>
		                        <small>Total items sold in this period</small>
		                        <div class="progress progress-mini">
		                            <div id="rep001_02_00_chartSummary_totalItemSold_progress" style="width: 48%;" class="progress-bar"></div>
		                        </div>
		                    </li>
		                    <li>
		                        <div id="rep001_02_00_chartSummary_totalItemPurchased" class="no-margins" style="font-size:18pt;">2,346</div>
		                        <small>Total items purchased in this period</small>
		                        <div class="progress progress-mini">
		                            <div id="rep001_02_00_chartSummary_totalItemPurchased_progress" style="width: 60%;" class="progress-bar"></div>
		                        </div>
		                    </li>
	                    </ul>
	                </div>
	            </div>
            </div>
        </div> <!-- .end of ibox -->
                                
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="table-responsive">
                        	<table id="rep001_02_00_dataTable_itemList" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th data-toggle="true">#</th>
										<th>Category</th>
										<th>Item</th>
										<th>Total Purchased</th>
										<th>Total Sold</th>
										<th>Last Quantity</th>
										<th>Last Availability</th>
									</tr>
								</thead>
								<tbody id="rep001_02_00_dataTable_itemList_tbody">
								</tbody>
							</table>
                        </div>
                    </div> <!-- .end of ibox-content -->
                </div>
            </div>
        </div> <!-- .end of row #4 -->
    </div>
    <div id="rep001_02_00_reportDetails_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
</div>

<script>

var rep001_02_00_initialized = false;
var rep001_02_00_dateStart;
var rep001_02_00_dateEnd;
var rep001_02_00_selectedCategoryList = [];
var rep001_02_00_selectedItemList = [];
var rep001_02_00_selectedAvailabilityStatus = '';
var rep001_02_00_categoryList = [];
var rep001_02_00_itemList = [];

/**
 * Init Panel
 */
function rep001_02_00_init()
{
    if (rep001_02_00_initialized == true)
        return false;

    // Init DataTable
	$("#rep001_02_00_dataTable_itemList").DataTable({
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "displayLength": 10,
	   	"order": [[0, "asc"],[1, "asc"]]
    });

	rep001_02_00_dateStart = moment().subtract(29, 'days').toDate();
	rep001_02_00_dateEnd = moment().toDate();
	
    // Date Range Picker - http://www.daterangepicker.com/
    $('#rep001_02_00_dateRange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

    $('#rep001_02_00_dateRange').daterangepicker({
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
        
        rep001_02_00_dateStart = start.toDate();
        rep001_02_00_dateEnd = end.toDate();
    
        $('#rep001_02_00_dateRange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });

	
	// Init chosen-select: Item
    $('#rep001_02_00_filter_item').empty();
    
    $.each(Cached_getItemList(), function(i, itemObj) {
		var htmlLines = '';
    	htmlLines += '<option value="' + itemObj.id + '">';
    	htmlLines += itemObj.name;
    	htmlLines += '</option>';
    	
    	$('#rep001_02_00_filter_item').append(htmlLines);    	
    });
    
	$('#rep001_02_00_filter_item').chosen({ 
		width: '100%',
		search_contains: true
	});
	$('#rep001_02_00_filter_item').on('change', rep001_02_00_selectItem);
	
	// Init chosen-select: Availability
	$('#rep001_02_00_filter_availability').empty();
    $('#rep001_02_00_filter_availability').append('<option value="">Show All</option>');
    $('#rep001_02_00_filter_availability').append('<option value="' + InventoryConstants.QUANTITY_AVAILABLE + '">' + inventoryCommon_getQuantityAvailabilityName(InventoryConstants.QUANTITY_AVAILABLE) + '</option>');
    $('#rep001_02_00_filter_availability').append('<option value="' + InventoryConstants.QUANTITY_LOW_STOCK + '">' + inventoryCommon_getQuantityAvailabilityName(InventoryConstants.QUANTITY_LOW_STOCK) + '</option>');
    $('#rep001_02_00_filter_availability').append('<option value="' + InventoryConstants.QUANTITY_NO_STOCK + '">' + inventoryCommon_getQuantityAvailabilityName(InventoryConstants.QUANTITY_NO_STOCK) + '</option>');
    
    $('#rep001_02_00_filter_availability').chosen({ 
    	width: '100%',
    	search_contains: true
    });
	$('#rep001_02_00_filter_availability').on('change', rep001_02_00_selectAvailability);

	rep001_02_00_initialized = true;
} // .end of rep001_02_00_init

/**
 * Update UI of panel.
 */
function rep001_02_00_updateUI()
{
    rep001_02_00_init();

    // Show panel
    $('#rep001_02_00').show();
} // .end of rep001_02_00_updateUI

/**
 * Draw chart, based on current result.
 */
function rep001_02_00_drawChart(dailySales, dailyPurchases, totalItemCount)
{
	var dataset = [
		/*{
	        label: "Daily Purchases",
	        data: dailyPurchases,
	        color: "#1ab394",
	        bars: {
	            show: true,
	            align: "center",
	            barWidth: 24 * 60 * 60 * 600,
	            lineWidth:0
	       	    }
		}, */
       	{
	        label: "Daily Sales",
	        data: dailySales,
	        fillColor: "rgba(220,220,220,0.5)",
	        strokeColor: "rgba(220,220,220,1)",
	        pointColor: "rgba(220,220,220,1)",
	        pointStrokeColor: "#fff",
	        pointHighlightFill: "#fff",
	        pointHighlightStroke: "rgba(220,220,220,1)",
	        yaxis: 2,
	        color: "#1C84C6",
	        lines: {
	            lineWidth:1,
	            show: true,
	            fill: true,
	            fillColor: {
	            	colors: [{opacity: 0.2}, {opacity: 0.4}]
	            	}
	        	},
	        splines: {
	            show: false,
	            tension: 0.6,
	            lineWidth: 1,
	            fill: 0.1
	        	},
    	}
   ];


    var options = {
        xaxis: {
            mode: "time",
            tickSize: [3, "day"],
            tickLength: 0,
            axisLabel: "Date",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Arial',
            axisLabelPadding: 10,
            color: "#d5d5d5"
        },
        yaxes: [
        	/*{
	            position: "left",
	            max: 1070,
	            color: "#d5d5d5",
	            axisLabelUseCanvas: true,
	            axisLabelFontSizePixels: 12,
	            axisLabelFontFamily: 'Arial',
	            axisLabelPadding: 3
        	}, */
        	{
	            position: "right",
	            clolor: "#d5d5d5",
	            axisLabelUseCanvas: true,
	            axisLabelFontSizePixels: 12,
	            axisLabelFontFamily: ' Arial',
	            axisLabelPadding: 67
        	}
        ],
        legend: {
            noColumns: 1,
            labelBoxBorderColor: "#000000",
            position: "nw"
        },
        grid: {
            hoverable: true,
            autoHighlight: true,
            borderWidth: 0
        }
    };
	   	
	//$.plot($("#flot-dashboard-chart"), dataset, options);	
	
	// Update Summary
	var totalSalesQuantity = 0;
	$.each(dailySales, function(i, dailyUnit){
		totalSalesQuantity += dailyUnit[1];
	});
	var totalPurchasesQuantity = 0;
	$.each(dailyPurchases, function(i, dailyUnit){
		totalPurchasesQuantity += dailyUnit[1];
	});
	
	$('#rep001_02_00_chartSummary_totalItemSold').html();
	$('#rep001_02_00_chartSummary_totalItemSold_progress').css('width', (totalSalesQuantity/totalItemCount)+'%');
	$('#rep001_02_00_chartSummary_totalItemPurchased').html();
	$('#rep001_02_00_chartSummary_totalItemPurchased_progress').css('width', (totalPurchasesQuantity/totalItemCount)+'%');
} // .end of rep001_02_00_drawChart

/**
 * Show/hide filter pane.
 */
function rep001_02_00_toggleFilter(element)
{
	var isHidden = $('#rep001_02_00_filter').hasClass('filter-hidden');
	if (isHidden)
	{
		$(element).html('<i class="fa fa-filter" aria-hidden="true"></i> Hide Filters');
		$('#rep001_02_00_filter').removeClass('filter-hidden');
		$('#rep001_02_00_filter').show();
		
		if (rep001_02_00_customerList == null || rep001_02_00_customerList.length == 0)
		{
			$('#rep001_02_00_filter').hide();
			$('#rep001_02_00_filter_spinner').show();
			// Ajax call to get all customers
			rep001_02_00_populateCategoryList();
		}
	}
	else
	{
		$(element).html('<i class="fa fa-filter" aria-hidden="true"></i> Show Filters');
		$('#rep001_02_00_filter').addClass('filter-hidden');
		$('#rep001_02_00_filter').hide();
	}
} // .end of rep001_02_00_toggleFilter

function rep001_01_00_populateCategoryList()
{
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'fullBean': true,
		'filterByPosVisible': false,
		'posVisible': false
	};
	
	var params = new Object();
	
	// Ajax Call
	tycheesdb_api_listCategoryByPlace(requestBody, rep001_01_00_populateCategoryList_postHandler, params);
} // .end of rep001_01_00_populateCustomerList

function rep001_01_00_populateCategoryList_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false)
		return false;
	
	rep001_01_00_categoryList = responseObj.categoryList;
	
	// Sort
	rep001_01_00_categoryList.sort(function(a, b){
		if(a.name < b.name) return -1;
    	if(a.name > b.name) return 1;
    	return 0;
	});
	
	// Init chosen-select: Customer
    $('#rep001_02_00_filter_category').empty();
    $('#rep001_01_00_filter_customer').append('<option value="">Show All</option>');
    
    $.each(rep001_01_00_categoryList, function(i, categoryObj){
    	
		var htmlLines = '';
    	htmlLines += '<option value="' + categoryObj.id + '">';
    	htmlLines += categoryObj.name;
    	htmlLines += '</option>';
    	
    	$('#rep001_02_00_filter_category').append(htmlLines);    	
    });
    
	$('#rep001_02_00_filter_category').chosen({ 
		width: '350px',
		search_contains: true
	});
	$('#rep001_02_00_filter_category').on('change', rep001_02_00_selectCategory);
	
	// Show/Hide
	$('#rep001_02_00_filter').show();
	$('#rep001_02_00_filter_spinner').hide();
} // .end of rep001_01_00_populateCustomerList_postHandler

/**
 * Handler when user select category from chosen-select.
 */
function rep001_02_00_selectCategory(event, params)
{
	if (rep001_02_00_selectedCategoryList==null)
		rep001_02_00_selectedCategoryList = [];
	
	if ($.trim(params.selected) != '')
	{	
		if (params.selected=='')
			rep001_02_00_selectedCategoryList = [];
		else
		{	
			rep001_02_00_selectedCategoryList.push(params.selected);
		}
	}
	
	if ($.trim(params.deselected) != '')
	{
		var index = rep001_02_00_selectedCategoryList.indexOf(params.deselected);
		
		rep001_02_00_selectedCategoryList.splice(index, 1);
	}
} // .end of rep001_02_00_selectCategory

/**
 * Handler when user select item from chosen-select.
 */
function rep001_02_00_selectItem(event, params)
{
	if (rep001_02_00_selectedItemList==null)
		rep001_02_00_selectedItemList = [];
	
	if ($.trim(params.selected) != '')
	{	
		if (params.selected=='')
			rep001_02_00_selectedItemList = [];
		else
		{	
			rep001_02_00_selectedItemList.push(params.selected);
		}
	}
	
	if ($.trim(params.deselected) != '')
	{
		var index = rep001_02_00_selectedItemList.indexOf(params.deselected);
		
		rep001_02_00_selectedItemList.splice(index, 1);
	}
} // .end of rep001_02_00_selectItem

/**
 * Handler when user select availability from chosen-select.
 */
function rep001_02_00_selectAvailability(event, params)
{
	rep001_02_00_selectedAvailabilityStatus = params.selected;
} // .end of rep001_02_00_selectCustomer

/**
 * Refresh page, based on current user inputs. 
 */
function rep001_02_00_refresh()
{
    if (rep001_02_00_dateStart==null || rep001_02_00_dateEnd==null)
    {
    	sweetAlert("No Date Range Selected", "Please select another date range.", "warning");
    	return false;
    }

    // Prepare Chart Data
    var dailySales = [];
    var dailyPurchase = [];
    var totalItemCount = 0;
    
    for (var time=rep001_02_00_dateStart.getTime() ; time < rep001_02_00_dateEnd.getTime() ; time += (24*60*60*1000))
    {
    	var dailyUnit = [];
    	dailyUnit.push( time );
    	dailyUnit.push( 0 );
    	
    	dailySales.push( dailyUnit );
    }
    // .end of Chart Data
    
    var report_2d_array = [];
    var rowCount = 1;

	var billingList = Cached_getBillingList();
	var categoryList = Cached_getCategoryList();
								
	// Clear payment list
	$('#rep001_02_00_dataTable_itemList').DataTable().clear().draw();
	$.each(categoryList, function(i, categoryObj){
	
		if (rep001_02_00_selectedCategoryList.length > 0)
		{
			var index = rep001_02_00_selectedCategoryList.indexOf(categoryObj.id);
			if (index == -1)
				return true;
		}
	
		var itemList = Cached_getItemListByCategoryId(categoryObj.id);
		$.each(itemList, function(j, itemObj){
			
			if (rep001_02_00_selectedItemList.length > 0)
			{
				var index = rep001_02_00_selectedItemList.indexOf(itemObj.id);
				if (index == -1)
					return true;
			}
			
			var totalSalesQuantity = 0, totalPurchasedQuantity = 0;
			$.each(billingList, function(k, billingObj) {
				
				if (rep001_02_00_dateStart.getTime() <= billingObj.billingDate &&
					rep001_02_00_dateEnd.getTime() >= billingObj.billingDate )
				{	
					var billingLineQuantity = 0;
					
					$.each(billingObj.lineList, function(l, lineObj){
						if (lineObj.itemId == itemObj.id)
							totalSalesQuantity += lineObj.quantity;
						
						billingLineQuantity += lineObj.quantity;
					});
					
					$.each(dailySales, function(m, dailyUnit){
						if (tycheesDateTime_isSameDay(new Date(billingObj.createdOn), new Date(dailyUnit[0]), false))
						{
							dailyUnit[1] = billingLineQuantity;
						}
					});
				}
			});
			
			var quantity = getItemPropertiesValue_byPropKey(itemObj, InventoryConstants.PROP_KEY_QUANTITY);
			var availability = isItemAvailable(itemObj.id);
			
			if ($.trim(rep001_02_00_selectedAvailabilityStatus) != '')
			{
				if (availability != rep001_02_00_selectedAvailabilityStatus)
					return true;
			}
			
			if (isNaN(quantity)==false)
				totalItemCount += quantity;
			
			var rowSet = [];
			rowSet.push( rowCount++ );
			rowSet.push( categoryObj.name );
			rowSet.push( itemObj.name );
			rowSet.push( totalPurchasedQuantity );										// Total Purchased
			rowSet.push( totalSalesQuantity );											// Total Sales
			rowSet.push( quantity==null ? '0' : quantity.toString() );					// Last Quantity
			rowSet.push( inventoryCommon_getQuantityAvailabilityName(availability) );	// Last Availability
			
			// Add row into 2d array
			report_2d_array.push(rowSet);
			// Add row into DataTable
			$("#rep001_02_00_dataTable_itemList").dataTable().fnAddData( rowSet, false );
		});
	});
	
	// Redraw Table
	$("#rep001_02_00_dataTable_itemList").DataTable().draw();
	
	if (report_2d_array.length==0)
	{
		sweetAlert("No Result Found", "Please select another date range.", "info");
	}
	else
	{
		// Draw Chart
		rep001_02_00_drawChart( dailySales, dailyPurchase, totalItemCount );
	}
	
	return report_2d_array;
} // .end of rep001_02_00_refresh

/**
 * Hide panel.
 */
function rep001_02_00_hide()
{
    $('#rep001_02_00').hide();
} // .end of rep001_02_00_hide

/**
 * Generate & download PDF file of current selection.
 */
function rep001_02_00_screenshotPdf()
{
	var reportArray = rep001_02_00_refresh();
	
	var pdfDoc = new jsPDF('l', 'pt', 'a4');
	var margins = {top: 50, bottom: 10, left: 10, width: 600 };

	pdfDoc.addHTML(
	    $('#rep001_02_00_pdfReport')[0], 
	    function () {

	   		var pdfFileName = '';
	   		pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	   		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	   		pdfFileName += '.pdf';
	    		
	    	pdfDoc.save( pdfFileName );
	 	},
	 	margins
	);
} // .end of rep001_02_00_screenshotPdf

/**
 * Generate & download PDF file of current selection.
 */
function rep001_02_00_downloadPdf()
{	
	var pdfDoc = rep001_02_00_generatePDF();

	var pdfFileName = '';
	pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	pdfFileName += '.pdf';
	
	pdfDoc.save( pdfFileName );
} // .end of rep001_02_00_downloadPdf

/**
 * Generate & download Spreadsheet file of current selection.
 */
function rep001_02_00_downloadCsv()
{
	var reportArray = rep001_02_00_refresh();
	
	var csvContent = "data:text/csv;charset=utf-8,";
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
	
} // .end of rep001_02_00_downloadCsv

/**
 * Print Friendly
 */
function rep001_02_00_printFriendly()
{
	var pdfDoc = rep001_02_00_generatePDF();

	var pdfFileName = '';
	pdfFileName += 'inventoryReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	pdfFileName += '.pdf';
	
	pdfDoc.autoPrint();	
	
	window.open(pdfDoc.output('bloburl'), '_blank');
} // .end of rep001_02_00_printFriendly

/**
 * Generate PDF.
 */
function rep001_02_00_generatePDF()
{
	var reportArray = rep001_02_00_refresh();	
	var doc = new jsPDF("landscape", "pt", "a4");
	
	// DEBUG ONLY
	//rep001_02_00_showGrid(doc);
	
	doc.setFontSize(16);
	doc.text(370, 30, 'Inventory Report');
	
	doc.setFontSize(12);
	doc.text(365, 48, tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_02_00_dateStart) + ' - ' + tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_02_00_dateEnd));
	
	doc.setLineWidth(0.1);
	doc.line(40, 55, 802, 55);	
	
	doc.setFontSize(10);
	doc.text(40, 70, 'Filter by Category');
	doc.text(130, 70, ':');
	doc.text(140, 70, (rep001_02_00_selectedCategoryList.length==0 ? 'Show All' : rep001_02_00_selectedCategoryList.toString()));

	doc.setFontSize(10);
	doc.text(40, 85, 'Filter by Item');
	doc.text(130, 85, ':');
	doc.text(140, 85, (rep001_02_00_selectedItemList.length==0 ? 'Show All' : rep001_02_00_selectedItemList.toString()));
	
	doc.setFontSize(10);
	doc.text(40, 100, 'Filter by Availability');
	doc.text(130, 100, ':');
	doc.text(140, 100, ($.trim(rep001_02_00_selectedAvailabilityStatus)=='' ? 'Show All' : inventoryCommon_getQuantityAvailabilityName(rep001_02_00_selectedAvailabilityStatus)));

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
	rep001_02_00_generatePDF_drawTableHeader(doc, 115);
	
	// Table Content
	var y_axis = 135;
	var cellValue_y_offset = 13;
	var rowHeight = 20;
	var maxRowCountInPage = 5;
	var pageNumber = 1;
	var totalPageCount = Math.ceil( reportArray.length / maxRowCountInPage );
	var pageHasContent = false;
	
	$.each(reportArray, function(i, rowData){

		doc.setFontSize(9);
		doc.setFontStyle('normal');
		
		doc.text(40,  y_axis+cellValue_y_offset, rowData[0].toString());
		doc.text(70,  y_axis+cellValue_y_offset, rowData[1].toString());
		doc.text(220, y_axis+cellValue_y_offset, rowData[2].toString());
		doc.text(370, y_axis+cellValue_y_offset, rowData[3].toString());
		doc.text(470, y_axis+cellValue_y_offset, rowData[4].toString());
		doc.text(570, y_axis+cellValue_y_offset, rowData[5].toString());
		doc.text(670, y_axis+cellValue_y_offset, rowData[6].toString());

		y_axis += rowHeight;
		doc.setLineWidth(0.1);
		doc.line(40, y_axis, 802, y_axis);	

		pageHasContent = true;
		
		var rowNumber = i + 1;
		if ( rowNumber % maxRowCountInPage == 0 )
		{
			// Add footer to current page
			doc.setFontSize(8);
			doc.text(395, 560, 'Page ' + pageNumber++ + ' of ' + totalPageCount );
	
			// Add new page
			doc.addPage();
			// Reset y_axis
			y_axis = 60;
			// Draw table header
			rep001_02_00_generatePDF_drawTableHeader(doc, y_axis);
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
	
	return doc;
} // .end of rep001_02_00_generatePDF

function rep001_02_00_generatePDF_drawTableHeader(pdfDoc, y_axis)
{
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis, 802, y_axis);	
	
	pdfDoc.setFontSize(10);
	pdfDoc.setFontStyle('bold');
	pdfDoc.text(40,  y_axis+13, 'No.');
	pdfDoc.text(70,  y_axis+13, 'Category');
	pdfDoc.text(220, y_axis+13, 'Item');
	pdfDoc.text(370, y_axis+13, 'Total Purchased');
	pdfDoc.text(470, y_axis+13, 'Total Sold');
	pdfDoc.text(570, y_axis+13, 'Last Quantity');
	pdfDoc.text(670, y_axis+13, 'Last Availability');

	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis+20, 802, y_axis+20);
} // .end of rep001_02_00_generatePDF_drawTableHeader

function rep001_02_00_showGrid(pdfDoc)
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
}

</script>