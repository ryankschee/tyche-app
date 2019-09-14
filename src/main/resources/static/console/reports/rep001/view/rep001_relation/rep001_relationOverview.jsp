
<!-- rep001_relationOverview: Reports -->
<div id="rep001_relationOverview" style="display:none;">
    <div class="row" style="padding-bottom:10px;padding-top:20px;">
        <div class="col-md-6" style="padding:0px 5px;">
            <div id="rep001_relationOverview_dateRange" class="form-control">
                <i class="fa fa-calendar" aria-hidden="true"></i>
                <span style="padding-left:10px;"></span> 
                <b class="caret"></b>
            </div>
        </div>
        <div class="col-md-6" style="padding:0px 5px;">
            <label title="Refresh" id="rep001_relationOverview_refreshReports" class="btn btn-primary pull-right" onclick="rep001_relationOverview_refresh();">
                <i class="fa fa-cog" aria-hidden="true"></i> Generate Report
            </label>
            <label title="Report Filter" id="rep001_relationOverview_toggleFilter" class="btn btn-link pull-right" onclick="rep001_relationOverview_toggleFilter(this);" style="font-size:9pt;"> 
            	<i class="fa fa-filter" aria-hidden="true"></i> Show Filters
            </label>
        </div>
    </div> <!-- .end of row #1 -->
    <div class="row hidden" id="rep001_relationOverview_filter" style="display:none;padding-bottom:20px;padding-top:0px;">
        <div class="col-md-3" style="padding:0px 5px;">
        	<div class="form-group">
                <label class="font-bold">Filtered by Type</label>
                <div class="input-group">
	                <select id="rep001_relationOverview_filter_type" data-placeholder="Show ANY" multiple class="chosen-select" tabindex="2">
	                </select>
                </div>
            </div>
        </div>
        <div class="col-md-3" style="padding:0px 5px;">
        	<div class="form-group">
                <label class="font-bold">Filtered by State</label>
                <div class="input-group">
	                <select id="rep001_relationOverview_filter_state" data-placeholder="Show ANY" multiple class="chosen-select" tabindex="2">
	                </select>
                </div>
            </div>
        </div>
        <div class="col-md-3" style="padding:0px 5px;">
        	<div class="form-group">
                <label class="font-bold">Filtered by Area</label>
                <div class="input-group">
	                <select id="rep001_relationOverview_filter_area" data-placeholder="Show ANY" multiple class="chosen-select" tabindex="2">
	                </select>
                </div>
            </div>
        </div>
        <div class="col-md-3" style="padding:0px 5px;">
        	<div class="form-group">
                <label class="font-bold">Filtered by City</label>
                <div class="input-group">
	                <select id="rep001_relationOverview_filter_city" data-placeholder="Show ANY" multiple class="chosen-select" tabindex="2">
	                </select>
                </div>
            </div>
        </div>
    </div> <!-- .end of row #1 -->
    <div id="rep001_relationOverview_filter_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
    
    <div id="rep001_relationOverview_reportDetails" style="display:none;"> 
    	<!-- 
        <div class="row">
            <div class="col-md-4" style="padding:0px 5px;">
                <div class="ibox float-e-margins" style="margin:0px;">
                    <div class="ibox-title" style="padding-left:10px; padding-right:10px;">
                        <h5>Order Summary</h5>
                    </div>
                    <div class="ibox-content" style="height:80px; padding:10px 0px;">
                        <div class="col-md-5" style="padding-left:10px; padding-right:10px;">
                        	<div id="rep001_relationOverview_orders_count" class="no-margins widget-summary-text">0.00</div>
                    		<div class="font-bold text-navy"><small>New Orders</small></div>                        
                        </div>
                        <div class="col-md-7" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_relationOverview_orders_totalAmount" class="no-margins pull-right widget-summary-text">0.00</div>
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
                        	<div id="rep001_relationOverview_payments_completedCount" class="no-margins widget-summary-text">0</div>
                    		<div class="font-bold text-navy"><small>Completed</small></div>                        
                        </div>
                        <div class="col-md-7" style="padding-left:10px; padding-right:10px;">
                            <div id="rep001_relationOverview_payments_totalAmount" class="no-margins pull-right widget-summary-text">0.00</div>
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
                            <div id="rep001_relationOverview_customers_uniqueCount" class="no-margins pull-right widget-summary-text">0.00</div>
                            <br/><br/>
                    		<div class="font-bold text-navy"><span class="small pull-right">Unique Customers</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
         -->
        <div class="row">
            <div class="col-md-12" style="padding:0px 5px;">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>REPORT</h5>
                        <label title="Download PDF" id="rep001_relationOverview_downloadPdf" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_relationOverview_downloadPdf();">
			                <i class="fa fa-download" aria-hidden="true"></i> PDF
			            </label>
			            <label title="Download CSV" id="rep001_relationOverview_downloadCsv" class="btn btn-xs btn-info pull-right" style="margin-right:3px;" onclick="rep001_relationOverview_downloadCsv();">
			                <i class="fa fa-download" aria-hidden="true"></i> CSV
			            </label>
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                        	<table id="rep001_relationOverview_dataTable_billingList" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>Customer Name</th>
										<th>City</th>
										<th>Area</th>
										<th>State</th>
										<th style="text-align:right;">No. of Orders</th>
										<th style="text-align:right;">Total Amount</th>
										<th style="text-align:right;">Average Spending</th>
									</tr>
								</thead>
								<tbody id="rep001_relationOverview_dataTable_billingList_tbody">
								</tbody>
							</table>
                        </div>
                    </div> <!-- .end of ibox-content -->
                </div>
            </div>
        </div> <!-- .end of row #4 -->
        
    </div>
    
    <div id="rep001_relationOverview_reportDetails_spinner" class="sk-spinner sk-spinner-wave" style="display:none;">
        <div class="sk-rect1"></div>
        <div class="sk-rect2"></div>
        <div class="sk-rect3"></div>
        <div class="sk-rect4"></div>
        <div class="sk-rect5"></div>
	</div>
</div>

<script>

var rep001_relationOverview_typeList = [];
var rep001_relationOverview_stateList = [];
var rep001_relationOverview_areaList = [];
var rep001_relationOverview_cityList = [];

var rep001_relationOverview_selectedTypeList = [];
var rep001_relationOverview_selectedStateList = [];
var rep001_relationOverview_selectedAreaList = [];
var rep001_relationOverview_selectedCityList = [];

var rep001_relationOverview_customerList = [];

var rep001_relationOverview_initialized = false;
var rep001_relationOverview_dateStart;
var rep001_relationOverview_dateEnd;

/**
 * Init Panel
 */
function rep001_relationOverview_init()
{
    if (rep001_relationOverview_initialized == true)
        return false;

    // Init DataTable
	$("#rep001_relationOverview_dataTable_billingList").DataTable({
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "displayLength": 10,
	   	"order": [[0, "asc"]]
    });
    // Set table width
	$('.dataTables_wrapper').css('width','98%');
	
	rep001_relationOverview_dateStart = moment().subtract(29, 'days').toDate();
	rep001_relationOverview_dateEnd = moment().toDate();
	
    // Date Range Picker - http://www.daterangepicker.com/
    $('#rep001_relationOverview_dateRange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

    $('#rep001_relationOverview_dateRange').daterangepicker({
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
        
        rep001_relationOverview_dateStart = start.toDate();
        rep001_relationOverview_dateEnd = end.toDate();
    
        $('#rep001_relationOverview_dateRange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });

    // Init chosen-select: Status Event
    $('#rep001_relationOverview_filter_status').empty();
    /*
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.workflowList, function(i, workflowObj){
    	
    	if (workflowObj.moduleId == ModuleConstants.MODULE_BILLING)
    	{
    		$.each(workflowObj.eventList, function(j, eventObj){
    			var htmlLines = '';
    	    	htmlLines += '<option value="' + eventObj.eventKey + '">';
    	    	htmlLines += eventObj.eventDescription;
    			htmlLines += '</option>';
    	    	
    	    	$('#rep001_relationOverview_filter_status').append(htmlLines);    			
    		});
    	}
    });
	$('#rep001_relationOverview_filter_type').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_relationOverview_filter_type').on('change', rep001_relationOverview_selectType);

    */
    
	rep001_relationOverview_initialized = true;
} // .end of rep001_relationOverview_init

/**
 * Update UI of panel.
 */
function rep001_relationOverview_updateUI()
{
    rep001_relationOverview_init();

    $('#rep001_relationOverview').show();
} // .end of rep001_relationOverview_updateUI

function rep001_relationOverview_selectType(event, params)
{
	if (rep001_relationOverview_selectedTypeList==null)
		rep001_relationOverview_selectedTypeList = [];
	
	if (params.selected != null)
	{	
		if (params.selected=='')
			rep001_relationOverview_selectedTypeList = [];
		else
		{	
			rep001_relationOverview_selectedTypeList.push(params.selected);
		}
	}
	
	if (params.deselected != null)
	{
		var index = rep001_relationOverview_selectedTypeList.indexOf(params.deselected);
		rep001_relationOverview_selectedTypeList.splice(index, 1);
	}
} // .end of rep001_relationOverview_selectType

function rep001_relationOverview_selectState(event, params)
{
	if (rep001_relationOverview_selectedStateList==null)
		rep001_relationOverview_selectedStateList = [];
	
	if (params.selected != null)
	{	
		if (params.selected=='')
			rep001_relationOverview_selectedStateList = [];
		else
		{	
			rep001_relationOverview_selectedStateList.push(params.selected);
		}
	}
	
	if (params.deselected != null)
	{
		var index = rep001_relationOverview_selectedStateList.indexOf(params.deselected);
		rep001_relationOverview_selectedStateList.splice(index, 1);
	}
} // .end of rep001_relationOverview_selectState

function rep001_relationOverview_selectArea(event, params)
{
	if (rep001_relationOverview_selectedAreaList==null)
		rep001_relationOverview_selectedAreaList = [];
	
	if (params.selected != null)
	{	
		if (params.selected=='')
			rep001_relationOverview_selectedStateList = [];
		else
		{	
			rep001_relationOverview_selectedAreaList.push(params.selected);
		}
	}
	
	if (params.deselected != null)
	{
		var index = rep001_relationOverview_selectedAreaList.indexOf(params.deselected);
		rep001_relationOverview_selectedAreaList.splice(index, 1);
	}
} // .end of rep001_relationOverview_selectArea

function rep001_relationOverview_selectCity(event, params)
{
	if (rep001_relationOverview_selectedCityList==null)
		rep001_relationOverview_selectedCityList = [];
	
	if (params.selected != null)
	{	
		if (params.selected=='')
			rep001_relationOverview_selectedCityList = [];
		else
		{	
			rep001_relationOverview_selectedCityList.push(params.selected);
		}
	}
	
	if (params.deselected != null)
	{
		var index = rep001_relationOverview_selectedCityList.indexOf(params.deselected);
		rep001_relationOverview_selectedCityList.splice(index, 1);
	}
} // .end of rep001_relationOverview_selectCity

/**
 * Show/hide filter pane.
 */
function rep001_relationOverview_toggleFilter(element)
{
	var isHidden = $('#rep001_relationOverview_filter').hasClass('hidden');
	if (isHidden)
	{
		$(element).html('<i class="fa fa-filter" aria-hidden="true"></i> Hide Filters');
		$('#rep001_relationOverview_filter').removeClass('hidden');
		$('#rep001_relationOverview_filter').show();
		
		if (rep001_relationOverview_customerList == null || rep001_relationOverview_customerList.length == 0)
		{
			$('#rep001_relationOverview_filter').hide();
			$('#rep001_relationOverview_filter_spinner').show();
			
			// Ajax call to get all data
			var requestBody = {
				'appName': APP_NAME_REPORTS,
				'fullBean': false
			};
			
			var params = new Object();
			
			// Call API
			tycheesdb_api_getCustomerFilterCriteriaByPlace(requestBody, rep001_relationOverview_toggleFilter_postHandler, params);
		}
	}
	else
	{
		$(element).html('<i class="fa fa-filter" aria-hidden="true"></i> Show Filters');
		$('#rep001_relationOverview_filter').addClass('hidden');
		$('#rep001_relationOverview_filter').hide();
	}
} // .end of rep001_relationOverview_toggleFilter

function rep001_relationOverview_toggleFilter_postHandler(success, responseObj, params)
{
	if (!success)
		return false;
	
	rep001_relationOverview_typeList = responseObj.typeList;
	rep001_relationOverview_stateList = responseObj.stateList;
	rep001_relationOverview_areaList = responseObj.areaList;
	rep001_relationOverview_cityList = responseObj.cityList;
	
	// Sort
	rep001_relationOverview_typeList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	// Sort
	rep001_relationOverview_stateList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	// Sort
	rep001_relationOverview_areaList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	// Sort
	rep001_relationOverview_cityList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	// Init chosen-select: Customer Type
    $('#rep001_relationOverview_filter_type').empty();
    $.each(rep001_relationOverview_typeList, function(i, type){
    	if ($.trim(type)=='')
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + type + '">';
    	htmlLines += type.toUpperCase();
    	htmlLines += '</option>';
    	
    	$('#rep001_relationOverview_filter_type').append(htmlLines);
    });

	$('#rep001_relationOverview_filter_type').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_relationOverview_filter_type').on('change', rep001_relationOverview_selectType);
		
	// Init chosen-select: Customer State
    $('#rep001_relationOverview_filter_state').empty();
    $.each(rep001_relationOverview_stateList, function(i, state){
    	if ($.trim(state)=='')
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + state + '">';
    	htmlLines += state.toUpperCase();
    	htmlLines += '</option>';
    	
    	$('#rep001_relationOverview_filter_state').append(htmlLines);
    });

	$('#rep001_relationOverview_filter_state').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_relationOverview_filter_state').on('change', rep001_relationOverview_selectState);
	
	// Init chosen-select: Customer Area
    $('#rep001_relationOverview_filter_area').empty();    
    $.each(rep001_relationOverview_areaList, function(i, area){
    	if ($.trim(area)=='')
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + area + '">';
    	htmlLines += area.toUpperCase();
    	htmlLines += '</option>';
    	
    	$('#rep001_relationOverview_filter_area').append(htmlLines);
    });

	$('#rep001_relationOverview_filter_area').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_relationOverview_filter_area').on('change', rep001_relationOverview_selectArea);

	// Init chosen-select: Customer City
    $('#rep001_relationOverview_filter_city').empty();
    $.each(rep001_relationOverview_cityList, function(i, city){
    	if ($.trim(city)=='')
    		return true;
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + city + '">';
    	htmlLines += city.toUpperCase();
    	htmlLines += '</option>';
    	
    	$('#rep001_relationOverview_filter_city').append(htmlLines);
    });

	$('#rep001_relationOverview_filter_city').chosen({ 
		width: '350px', 
		search_contains: true 
	});
	$('#rep001_relationOverview_filter_city').on('change', rep001_relationOverview_selectCity);
	
	
	// Show/Hide
	$('#rep001_relationOverview_filter').show();
	$('#rep001_relationOverview_filter_spinner').hide();
} // .end of rep001_relationOverview_populateCustomerList_postHandler

function rep001_relationOverview_refresh(postHandlerFn, params)
{
    if (rep001_relationOverview_dateStart==null || rep001_relationOverview_dateEnd==null)
    {
    	sweetAlert("No Date Range Selected", "Please select another date range.", "warning");
    	return false;
    }
    
    // Show/Hide
    $('#rep001_relationOverview_reportDetails').hide();
    $('#rep001_relationOverview_reportDetails_spinner').show();
    
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_REPORTS,
		'beginTime': rep001_relationOverview_dateStart.getTime(),
		'endTime': rep001_relationOverview_dateEnd.getTime(),
		'typeList': rep001_relationOverview_selectedTypeList.toString(),
		'stateList': rep001_relationOverview_selectedStateList.toString(),
		'areaList': rep001_relationOverview_selectedAreaList.toString(),
		'cityList': rep001_relationOverview_selectedCityList.toString()
	};
	
	if (params == null)
		params = new Object();
	if (postHandlerFn != null)
		params.postHandlerFn = postHandlerFn;
	
	// Call API
	tycheesdb_api_getReportByCustomerOverview(requestBody, rep001_relationOverview_refresh_postHandler, params);
} // .end of rep001_relationOverview_refresh

/**
 * Refresh page, based on current user inputs. 
 */
function rep001_relationOverview_refresh_postHandler(successFlag, responseObj, params)
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

	// Sort
	responseObj.resultList.sort(function(a, b){
		if(a.customerName < b.customerName) return -1;
    	if(a.customerName > b.customerName) return 1;
    	return 0;
	});
	
	// Clear payment list
	$('#rep001_relationOverview_dataTable_billingList').DataTable().clear().draw();
	$.each(responseObj.resultList, function(i, resultObj){
		/*
		if ($.trim(rep001_relationOverview_selectedCustomerId) != '')
		{
			if (billingObj.customerId != rep001_relationOverview_selectedCustomerId)
				return true;
		}
		
		tycheesLogger_logDebug('billingObj.state='+billingObj.state, 'rep001_relationOverview_refresh');
		tycheesLogger_logDebug('billingObj.stateDesc='+billingObj.stateDesc, 'rep001_relationOverview_refresh');
		
		if (rep001_relationOverview_selectedStateList.length > 0)
		{
			var index = rep001_relationOverview_selectedStateList.indexOf(billingObj.state);
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
		*/
		// For DataTable
		var rowSet = [];
		rowSet.push( resultObj.customerName );
		rowSet.push( resultObj.city );
		rowSet.push( resultObj.area );
		rowSet.push( resultObj.state );
		rowSet.push( '<span class="pull-right">' + resultObj.billingCount + '</span>' );
		rowSet.push( '<span class="pull-right">' + Number(resultObj.totalAmount).toFixed(2) + '</span>' );
		if (resultObj.billingCount == 0)
			rowSet.push( '<span class="pull-right">' + Number(0).toFixed(2) + '</span>' );
		else
			rowSet.push( '<span class="pull-right">' + Number(Number(resultObj.totalAmount)/Number(resultObj.billingCount)).toFixed(2) + '</span>' );

		// For CSV/PDF
		var dataRowSet = [];
		dataRowSet.push( resultObj.customerName );
		dataRowSet.push( resultObj.city );
		dataRowSet.push( resultObj.area );
		dataRowSet.push( resultObj.state );
		dataRowSet.push( resultObj.billingCount );
		dataRowSet.push( Number(resultObj.totalAmount).toFixed(2) );
		if (resultObj.billingCount == 0)
			dataRowSet.push( Number(0).toFixed(2) );
		else
			dataRowSet.push( Number(Number(resultObj.totalAmount)/Number(resultObj.billingCount)).toFixed(2) );
		
		// Increment Row Count
		rowCount++;
		// Add row into 2d array
		report_2d_array.push(dataRowSet);
		// Add row into DataTable
		$("#rep001_relationOverview_dataTable_billingList").dataTable().fnAddData( rowSet, false );
	});

	// Sort dataRowSet, by billing date
	report_2d_array.sort(function(a, b) {
		return tycheesList_sortByString(a[0], b[0]);
	});
	
	// Redraw Table
	$("#rep001_relationOverview_dataTable_billingList").DataTable().draw();
	
	/*
	// Panel - Billing Orders
	$('#rep001_relationOverview_orders_count').html(billingCount);
	$('#rep001_relationOverview_orders_totalAmount').html('<i class="fa fa-usd" aria-hidden="true"></i> ' + Number(billingTotalAmount).toFixed(2));

	// Panel - Payments
	$('#rep001_relationOverview_payments_completedCount').html(paymentCompletedCount);
	$('#rep001_relationOverview_payments_totalAmount').html('<i class="fa fa-usd" aria-hidden="true"></i> ' + Number(paymentTotalAmount).toFixed(2));
	
	// Panel - Customers
	$('#rep001_relationOverview_customers_newCount').html(newCustomerIdList.length);
	$('#rep001_relationOverview_customers_uniqueCount').html(customerIdList.length);
	*/
	if (report_2d_array.length==0)
	{
		sweetAlert("No Result Found", "Please select another date range.", "info");
	}
	
    // Show/Hide
    $('#rep001_relationOverview_reportDetails').show();
    $('#rep001_relationOverview_reportDetails_spinner').hide();
	
	if (params.postHandlerFn != null)
		params.postHandlerFn(report_2d_array, params);
} // .end of rep001_relationOverview_refresh_postHandler

/**
 * Hide panel.
 */
function rep001_relationOverview_hide()
{
    $('#rep001_relationOverview').hide();
} // .end of rep001_relationOverview_hide

/**
 * Generate & download PDF file of current selection.
 */
function rep001_relationOverview_screenshotPdf()
{
	rep001_relationOverview_refresh(rep001_relationOverview_screenshotPdf_postHandler);
} // .end of rep001_relationOverview_screenshotPdf

function rep001_relationOverview_screenshotPdf_postHandler(reportArray)
{
	var pdfDoc = new jsPDF('l', 'pt', 'a4');
	var margins = {top: 50, bottom: 10, left: 10, width: 600 };

	pdfDoc.addHTML(
	    $('#rep001_relationOverview_reportDetails')[0], 
	    function () {

	   		var pdfFileName = '';
	   		pdfFileName += 'customerReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	   		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	   		pdfFileName += '.pdf';
	    		
	    	pdfDoc.save( pdfFileName );
	 	},
	 	margins
	);
} // .end of rep001_relationOverview_screenshotPdf_postHandler

/**
 * Generate & download PDF file of current selection.
 */
function rep001_relationOverview_downloadPdf()
{	
	rep001_relationOverview_generatePDF(false, true);
} // .end of rep001_relationOverview_downloadPdf

/**
 * Generate & download Spreadsheet file of current selection.
 */
function rep001_relationOverview_downloadCsv()
{
	rep001_relationOverview_refresh(rep001_relationOverview_downloadCsv_postHandler);
} // .end of rep001_relationOverview_downloadCsv

function rep001_relationOverview_downloadCsv_postHandler(reportArray)
{
	var csvContent = "data:text/csv;charset=utf-8,";
	
	// Header
	csvContent += 'Customer Name,';
	csvContent += 'City,';
	csvContent += 'Area,';
	csvContent += 'State,';
	csvContent += 'No. of Orders,';
	csvContent += 'Total Amount,';
	csvContent += 'Average Spending';
	csvContent += '\n';
	
	// Content
	$.each(reportArray, function(i, rowArray){
	   var dataString = rowArray.join(",");
	   csvContent += i < reportArray.length ? dataString+ "\n" : dataString;
	}); 
	
	var csvFileName = '';
	csvFileName += 'customerReport-' + tycheesCommon_getCurrentPlaceId() + '-';
	csvFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
	csvFileName += '.csv';
	
	var encodedUri = encodeURI(csvContent);
	var link = document.createElement("a");
	link.setAttribute("href", encodedUri);
	link.setAttribute("download", csvFileName);
	document.body.appendChild(link); // Required for FF

	link.click(); // This will download the data file named "my_data.csv".
} // .end of rep001_relationOverview_downloadCsv_postHandler

/**
 * Print Friendly
 */
function rep001_relationOverview_printFriendly()
{
	rep001_relationOverview_generatePDF(true, false);
} // .end of rep001_relationOverview_printFriendly

/**
 * Generate PDF
 *
 * @param {Boolean} printFriendly - true if print; otherwise false.
 * @param {Boolean} downloadNow - true if download; otherwise false.
 * @return	{jsPDF}
 */
function rep001_relationOverview_generatePDF(printFriendly, downloadNow)
{
	var params = new Object();
	params.printFriendly = printFriendly;
	params.downloadNow = downloadNow;
	
	rep001_relationOverview_refresh(rep001_relationOverview_generatePDF_postHandler, params);
} // .end of rep001_relationOverview_generatePDF

function rep001_relationOverview_generatePDF_postHandler(reportArray, params)
{
	var doc = new jsPDF("landscape", "pt", "a4");
	
	doc.setFontSize(16);
	doc.text(376, 30, 'Customer Report');
	
	doc.setFontSize(12);
	doc.text(365, 48, tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_relationOverview_dateStart) + ' - ' + tycheesDateTime_getFormattedDate_ddMMyyyy(rep001_relationOverview_dateEnd));
	
	doc.setLineWidth(0.1);
	doc.line(40, 55, 802, 55);	
	/*
	var customerObj = Cached_getCustomerById(rep001_relationOverview_selectedCustomerId);
	doc.setFontSize(10);
	doc.text(40, 70, 'Filter by Customer');
	doc.text(130, 70, ':');
	doc.text(140, 70, (customerObj==null ? 'Show All' : customerObj.firstName + ' ' + customerObj.lastName));

	doc.setFontSize(10);
	doc.text(40, 85, 'Filter by Status');
	doc.text(130, 85, ':');
	doc.text(140, 85, (rep001_relationOverview_selectedStateList.length==0 ? 'Show All' : rep001_relationOverview_selectedStateList.toString()));
	*/
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
	rep001_relationOverview_generatePDF_drawTableHeader(doc, 100);
	
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
		doc.text(rowData[4].toString(), 602, y_axis+cellValue_y_offset, 'right');
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
			rep001_relationOverview_generatePDF_drawTableHeader(doc, y_axis);
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
		pdfFileName += 'customerReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.autoPrint();	
		
		window.open(doc.output('bloburl'), '_blank');
	}
	
	if (params.downloadNow)
	{
		var pdfFileName = '';
		pdfFileName += 'customerReport-' + tycheesCommon_getCurrentPlaceId() + '-';
		pdfFileName += tycheesDateTime_getFormattedDate_ddMMyyyy(new Date()) + '_' + tycheesDateTime_getFormattedDate_hhmmss(new Date());
		pdfFileName += '.pdf';
		
		doc.save( pdfFileName );
	}
} // .end of rep001_relationOverview_generatePDF_postHandler

function rep001_relationOverview_generatePDF_drawTableHeader(pdfDoc, y_axis)
{
	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis, 802, y_axis);	
	
	pdfDoc.setFontSize(10);
	pdfDoc.setFontStyle('bold');
	pdfDoc.text('Customer Name', 40,  y_axis+13);
	pdfDoc.text('City', 170, y_axis+13);
	pdfDoc.text('Area', 270, y_axis+13);
	pdfDoc.text('State', 370, y_axis+13);
	pdfDoc.text('No. of Orders', 602, y_axis+13, 'right');
	pdfDoc.text('Total Amount', 702, y_axis+13, 'right');
	pdfDoc.text('Average Spending', 802, y_axis+13, 'right');

	pdfDoc.setLineWidth(0.1);
	pdfDoc.line(40, y_axis+20, 802, y_axis+20);
} // .end of rep001_relationOverview_generatePDF_drawTableHeader

function rep001_relationOverview_showGrid(pdfDoc)
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
} // .end of rep001_relationOverview_showGrid

</script>