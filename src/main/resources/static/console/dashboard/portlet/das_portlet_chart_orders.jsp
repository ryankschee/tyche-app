<div id="das_portlet_chart_orders" class="ibox float-e-margins">
    <div id="das_portlet_chart_orders_header" class="ibox-title">
        <h5>Orders</h5>
        <div id="das_portlet_chart_orders_haeder_menu" class="pull-right">
            <div class="btn-group">
                <button id="das_portlet_chart_orders_button_today" class="btn btn-xs active" onclick="das_portlet_chart_orders_timeSwitcher('das_portlet_chart_orders_timeframe_today');">Today</button>
                <button id="das_portlet_chart_orders_button_weekly" class="btn btn-xs" onclick="das_portlet_chart_orders_timeSwitcher('das_portlet_chart_orders_timeframe_weekly');">Weekly</button>
                <button id="das_portlet_chart_orders_button_monthly" class="btn btn-xs" onclick="das_portlet_chart_orders_timeSwitcher('das_portlet_chart_orders_timeframe_monthly');">Monthly</button>
                <button id="das_portlet_chart_orders_button_annually" class="btn btn-xs" onclick="das_portlet_chart_orders_timeSwitcher('das_portlet_chart_orders_timeframe_annually');">Annual</button>
            </div>
        </div>
    </div>
    <div id="das_portlet_chart_orders_content" class="ibox-content">
        <div class="row">
            <div class="col-md-9">
                <div class="flot-chart">
                    <div class="flot-chart-content" id="flot-dashboard-chart" style="padding: 0px; position: relative;">                            	
                   	</div>
                </div>
            </div>
        	<div class="col-md-3">
                <ul class="stat-list">
                    <li>
                        <h2 class="no-margins" id="das_portlet_chart_orders_thisTotalOrder">2,346</h2>
                        <small>Total orders in period</small>
                        <div class="stat-percent">48% <i class="fa fa-level-up text-navy"></i></div>
                        <div class="progress progress-mini">
                            <div style="width: 48%;" class="progress-bar"></div>
                        </div>
                    </li>
                    <li>
                        <h2 class="no-margins " id="das_portlet_chart_orders_lastTotalOrder">4,422</h2>
                        <small>Orders in last month</small>
                        <div class="stat-percent">60% <i class="fa fa-level-down text-navy"></i></div>
                        <div class="progress progress-mini">
                            <div style="width: 60%;" class="progress-bar"></div>
                        </div>
                    </li>
                    <li>
                        <h2 class="no-margins " id="das_portlet_chart_orders_thisTotalAmount">9,180</h2>
                        <small>Monthly income from orders</small>
                        <div class="stat-percent">22% <i class="fa fa-bolt text-navy"></i></div>
                        <div class="progress progress-mini">
                            <div style="width: 22%;" class="progress-bar"></div>
                        </div>
                    </li>
                </ul>
        	</div>
        </div>
    </div>
    <div id="das_portlet_chart_orders_spinner" class="ibox-content" style="height:90px; display:none;">
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

<script>

var das_portlet_chart_orders_initialized            = false;

var DAS_PORTLET_CHART_ORDERS_TIMEFRAME_TODAY        = 'das_portlet_chart_orders_timeframe_today';
var DAS_PORTLET_CHART_ORDERS_TIMEFRAME_WEEKLY       = 'das_portlet_chart_orders_timeframe_weekly';
var DAS_PORTLET_CHART_ORDERS_TIMEFRAME_MONTHLY      = 'das_portlet_chart_orders_timeframe_monthly';
var DAS_PORTLET_CHART_ORDERS_TIMEFRAME_ANNUALLY     = 'das_portlet_chart_orders_timeframe_annually';

/**
 * Init variables / states / components. 
 */
function das_portlet_chart_orders_init()
{
    if (das_portlet_chart_orders_initialized==true)
        return false;
        
    das_portlet_chart_orders_initialized = true;
} // .end of das_portlet_chart_orders_init

/**
 * Setup values. 
 */
function das_portlet_chart_orders_updateUI()
{
    // Init, if any
    das_portlet_chart_orders_init();
    // Show default - TODAY
    das_portlet_chart_orders_timeSwitcher(DAS_PORTLET_CHART_ORDERS_TIMEFRAME_TODAY);
    // Show segment
    $('#das_portlet_chart_orders').show();
} // .end of das_portlet_chart_orders_updateUI

/**
 * In response to user selection on timeframe, for sales boxlet
 */
function das_portlet_chart_orders_timeSwitcher(timeframe)
{
    // Show/Hide
    $('#das_portlet_chart_orders_haeder_menu').hide();
    $('#das_portlet_chart_orders_content').hide();
    $('#das_portlet_chart_orders_spinner').show();

    // TODAY
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_TODAY)
    {
        das_portlet_chart_orders_timeSwitcher_today(timeframe);
    }
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_WEEKLY)
    {
        das_portlet_chart_orders_timeSwitcher_weekly(timeframe);
    }
    // MONTHLY
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_MONTHLY)
    {
        das_portlet_chart_orders_timeSwitcher_monthly(timeframe);
    }
    // YEARLY
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_ANNUALLY)
    {
        das_portlet_chart_orders_timeSwitcher_yearly(timeframe);
    }
} // .end of das_portlet_chart_orders_timeSwitcher

function das_portlet_chart_orders_timeSwitcher_today(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das_portlet_chart_orders_button_today').addClass('active btn-info');
    $('#das_portlet_chart_orders_button_weekly').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_monthly').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_annually').removeClass('active btn-info');

    thisBegin = new Date( $.now() );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setHours(23, 59, 59, 999);
    
    lastBegin = new Date( thisBegin.getTime() );
    lastBegin.setDate( lastBegin.getDate() - 1 );
    
    lastEnd = new Date( thisEnd.getTime() );
    lastEnd.setDate( lastBegin.getDate() - 1 );
    
    // Iterate through hours of the day
    var runningTime = new Date( thisBegin.getTime() );
    for (i = 0 ; i < 24 ; )
    {
        // Set incremented hour
        runningTime.setHours( thisBegin.getHours() + i )
        // Create dataset [x, y]
        var dataset = [runningTime.getTime(), 0];
        // DEBUG ONLY
        //var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
        // .end of DEBUG
        // Insert into list
        data_orderList.push(dataset);
        
        i = i + 2; // show interval of every 2 hours
    }
    
    // Prepare request body
	var requestBody = {
		'appName': APP_NAME_DASHBOARD,
		'beginTime': thisBegin.getTime(),
		'endTime': thisEnd.getTime(),
		'fullBean': false,
		'transactionBean': false
	};
	
	var params = new Object();
	params.timeframe = timeframe;
	params.data_orderList = data_orderList;
	params.thisBegin = lastBegin;
	params.thisEnd = thisEnd;
	params.lastBegin = lastBegin;
	params.lastEnd = lastEnd;
	
	tycheesdb_api_getBillingsByTimePeriod(
	    requestBody, 
	    das_portlet_chart_orders_timeSwitcher_today_postHandler, 
	    params);
} // .end of das_portlet_chart_orders_timeSwitcher_today

/**
 * Ajax post-handler.
 *
 * @param {Boolean} successFlag - true/false.
 * @param {Object} responseObj - Ajax http response object
 * @param {Object} params - Parameter object
 */
function das_portlet_chart_orders_timeSwitcher_today_postHandler(successFlag, responseObj, params)
{
    if (successFlag==false)
    {
        return false;
    }
    
    $.each(responseObj.billingList, function(i, billingObj) {
        
        if (billingObj.billingDate > params.thisBegin.getTime() && 
            billingObj.billingDate < params.thisEnd.getTime() )
        {
            var billingObjCreationDateObj = new Date( billingObj.billingDate );
            var hour = billingObjCreationDateObj.getHours() / 2;
            
            params.data_orderList[hour][1] = params.data_orderList[hour][1] + 1;
        }
    });
    
    das_portlet_chart_orders_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das_portlet_chart_orders_thisTotalOrder').html( thisTotalOrder );
    $('#das_portlet_chart_orders_lastTotalOrder').html( 0 );
    $('#das_portlet_chart_orders_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das_portlet_chart_orders_haeder_menu').show();
    $('#das_portlet_chart_orders_content').show();
    $('#das_portlet_chart_orders_spinner').hide();
} // .end of das_portlet_chart_orders_timeSwitcher_today_postHandler

function das_portlet_chart_orders_timeSwitcher_weekly(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das_portlet_chart_orders_button_today').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_weekly').addClass('active btn-info');
    $('#das_portlet_chart_orders_button_monthly').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_annually').removeClass('active btn-info');

    thisBegin = new Date( $.now() );
    thisBegin.setDate( thisBegin.getDate() - thisBegin.getDay() + 1 );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setDate( thisEnd.getDate() + (6 - thisEnd.getDay()) + 1 );
    thisEnd.setHours(23, 59, 59, 999);
    
    lastBegin = new Date( thisBegin.getTime() );
    lastBegin.setDate( lastBegin.getDate() - 7 );
    
    lastEnd = new Date( thisEnd.getTime() );
    lastEnd.setDate( lastEnd.getDate() - 7 );
    
    // Iterate through days of the week
    var runningTime = new Date( thisBegin.getTime() );
    for (i = 0 ; i < 7 ; i++)
    {
        // Set incremented day
        runningTime.setDate( thisBegin.getDate() + i )
        // Create dataset [x, y]
        var dataset = [runningTime.getTime(), 0];
        // DEBUG ONLY
        //var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
        // .end of DEBUG
        // Insert into list
        data_orderList.push(dataset);
    }
    
    // Prepare request body
	var requestBody = {
		'appName': APP_NAME_DASHBOARD,
		'beginTime': lastBegin.getTime(),
		'endTime': thisEnd.getTime(),
		'fullBean': false,
		'transactionBean': false
	};
	
	var params = new Object();
	params.timeframe = timeframe;
	params.data_orderList = data_orderList;
	params.thisBegin = thisBegin;
	params.thisEnd = thisEnd;
	params.lastBegin = lastBegin;
	params.lastEnd = lastEnd;
	
	tycheesdb_api_getBillingsByTimePeriod(
	    requestBody, 
	    das_portlet_chart_orders_timeSwitcher_weekly_postHandler, 
	    params);
} // .end of das_portlet_chart_orders_timeSwitcher_weekly

/**
 * Ajax post-handler.
 *
 * @param {Boolean} successFlag - true/false.
 * @param {Object} responseObj - Ajax http response object
 * @param {Object} params - Parameter object
 */
function das_portlet_chart_orders_timeSwitcher_weekly_postHandler(successFlag, responseObj, params)
{
    if (successFlag==false)
    {
        return false;
    }

    $.each(responseObj.billingList, function(i, billingObj) {
        
        if (billingObj.billingDate > params.thisBegin.getTime() && 
            billingObj.billingDate < params.thisEnd.getTime() )
        {
            var billingObjCreationDateObj = new Date( billingObj.billingDate );
            var dayInWeek = billingObjCreationDateObj.getDay();
            
            // Increment number of order
            params.data_orderList[dayInWeek][1] = params.data_orderList[dayInWeek][1] + 1;
        }
    });
    
    das_portlet_chart_orders_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das_portlet_chart_orders_thisTotalOrder').html( thisTotalOrder );
    $('#das_portlet_chart_orders_lastTotalOrder').html( 0 );
    $('#das_portlet_chart_orders_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das_portlet_chart_orders_haeder_menu').show();
    $('#das_portlet_chart_orders_content').show();
    $('#das_portlet_chart_orders_spinner').hide();
} // .end of das_portlet_chart_orders_timeSwitcher_weekly_postHandler

function das_portlet_chart_orders_timeSwitcher_monthly(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das_portlet_chart_orders_button_today').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_weekly').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_monthly').addClass('active btn-info');
    $('#das_portlet_chart_orders_button_annually').removeClass('active btn-info');

    thisBegin = new Date( $.now() );
    thisBegin.setDate( 1 );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setDate( thisEnd.getYear() % 4 == 0 ? DAS_DAYS_IN_MONTHS_LEAP[thisEnd.getMonth()] : DAS_DAYS_IN_MONTHS[thisEnd.getMonth()] );
    thisEnd.setHours(23, 59, 59, 999);
    
    lastBegin = new Date( thisBegin.getTime() );
    lastBegin.setMonth( lastBegin.getMonth() - 1 );
    
    lastEnd = new Date( lastBegin.getTime() );
    lastEnd.setDate( thisEnd.getYear() % 4 == 0 ? DAS_DAYS_IN_MONTHS_LEAP[lastEnd.getMonth()] : DAS_DAYS_IN_MONTHS[lastEnd.getMonth()] );
    lastEnd.setHours(23, 59, 59, 999);
    
    // Iterate through days of the month
    var runningTime = new Date( thisBegin.getTime() );
    for (i = 0 ; i < thisEnd.getDate() ; i++)
    {
        // Set incremented day
        runningTime.setDate( thisBegin.getDate() + i )
        // Create dataset [x, y]
        var dataset = [runningTime.getTime(), 0];
        // DEBUG ONLY
        //var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
        // .end of DEBUG
        // Insert into list
        data_orderList.push(dataset);
    }
    
    // Prepare request body
	var requestBody = {
		'appName': APP_NAME_DASHBOARD,
		'beginTime': lastBegin.getTime(),
		'endTime': thisEnd.getTime(),
		'fullBean': false,
		'transactionBean': false
	};
	
	var params = new Object();
	params.timeframe = timeframe;
	params.data_orderList = data_orderList;
	params.thisBegin = thisBegin;
	params.thisEnd = thisEnd;
	params.lastBegin = lastBegin;
	params.lastEnd = lastEnd;
	
	tycheesdb_api_getBillingsByTimePeriod(
	    requestBody, 
	    das_portlet_chart_orders_timeSwitcher_monthly_postHandler, 
	    params);
} // .end of das_portlet_chart_orders_timeSwitcher_monthly

/**
 * Ajax post-handler.
 *
 * @param {Boolean} successFlag - true/false.
 * @param {Object} responseObj - Ajax http response object
 * @param {Object} params - Parameter object
 */
function das_portlet_chart_orders_timeSwitcher_monthly_postHandler(successFlag, responseObj, params)
{
    if (successFlag==false)
    {
        return false;
    }
    
    $.each(Cached_getBillingList(APP_NAME_DASHBOARD, false), function(i, billingObj) {
    
        if (billingObj.billingDate > thisBegin.getTime() && 
            billingObj.billingDate < thisEnd.getTime() )
        {
            var billingObjCreationDateObj = new Date( billingObj.billingDate );
            var dayInMonth = billingObjCreationDateObj.getDate();
            
            // Increment number of order
            data_orderList[dayInMonth][1] = data_orderList[dayInMonth][1] + 1;
        }
    });
    
    das_portlet_chart_orders_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das_portlet_chart_orders_thisTotalOrder').html( thisTotalOrder );
    $('#das_portlet_chart_orders_lastTotalOrder').html( 0 );
    $('#das_portlet_chart_orders_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das_portlet_chart_orders_haeder_menu').show();
    $('#das_portlet_chart_orders_content').show();
    $('#das_portlet_chart_orders_spinner').hide();
} // .end of das_portlet_chart_orders_timeSwitcher_monthly_postHandler

function das_portlet_chart_orders_timeSwitcher_yearly(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das_portlet_chart_orders_button_today').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_weekly').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_monthly').removeClass('active btn-info');
    $('#das_portlet_chart_orders_button_annually').addClass('active btn-info');
    
    thisBegin = new Date( $.now() );
    thisBegin.setDate( 1 );
    thisBegin.setMonth( 0 );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setDate( DAS_DAYS_IN_MONTHS[11] );
    thisEnd.setMonth( 11 );
    thisEnd.setHours(23, 59, 59, 999);
    
    lastBegin = new Date( thisBegin.getTime() );
    lastBegin.setYear( lastBegin.getYear() - 1 );
    
    lastEnd = new Date( thisEnd.getTime() );
    lastEnd.setYear( lastEnd.getYear() - 1 );
    
    // Iterate through days of the month
    var runningTime = new Date( thisBegin.getTime() );
    for (i = 0 ; i < 12 ; i++)
    {
        // Set incremented day
        runningTime.setMonth( thisBegin.getMonth() + i )
        // Create dataset [x, y]
        var dataset = [runningTime.getTime(), 0];
        // DEBUG ONLY
        //var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
        // .end of DEBUG
        // Insert into list
        data_orderList.push(dataset);
    }
    
    // Prepare request body
	var requestBody = {
		'appName': APP_NAME_DASHBOARD,
		'beginTime': lastBegin.getTime(),
		'endTime': thisEnd.getTime(),
		'fullBean': false,
		'transactionBean': false
	};
	
	var params = new Object();
	params.timeframe = timeframe;
	params.data_orderList = data_orderList;
	params.thisBegin = thisBegin;
	params.thisEnd = thisEnd;
	params.lastBegin = lastBegin;
	params.lastEnd = lastEnd;
	
	tycheesdb_api_getBillingsByTimePeriod(
	    requestBody, 
	    das_portlet_chart_orders_timeSwitcher_yearly_postHandler, 
	    params);
} // .end of das_portlet_chart_orders_timeSwitcher_yearly

/**
 * Ajax post-handler.
 *
 * @param {Boolean} successFlag - true/false.
 * @param {Object} responseObj - Ajax http response object
 * @param {Object} params - Parameter object
 */
function das_portlet_chart_orders_timeSwitcher_yearly_postHandler(successFlag, responseObj, params)
{
    if (successFlag==false)
    {
        return false;
    }
    
    $.each(responseObj.billingList, function(i, billingObj) {
        
        if (billingObj.billingDate > params.thisBegin.getTime() && 
            billingObj.billingDate < params.thisEnd.getTime())
        {
            var billingObjCreationDateObj = new Date( billingObj.billingDate );
            var month = billingObjCreationDateObj.getMonth();
            
            // Increment number of order
            params.data_orderList[month][1] = params.data_orderList[month][1] + 1;
        }
    });
    
    das_portlet_chart_orders_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das_portlet_chart_orders_thisTotalOrder').html( thisTotalOrder );
    $('#das_portlet_chart_orders_lastTotalOrder').html( 0 );
    $('#das_portlet_chart_orders_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das_portlet_chart_orders_haeder_menu').show();
    $('#das_portlet_chart_orders_content').show();
    $('#das_portlet_chart_orders_spinner').hide();
} // .end of das_portlet_chart_orders_timeSwitcher_yearly_postHandler

/**
 * Plot graph.  
 *
 * @param {String} timeframe - DAS_PORTLET_CHART_ORDERS_TIMEFRAME_*
 * @param {Array} data_orderList - list of data
 */
function das_portlet_chart_orders_plotGraph(timeframe, data_orderList)
{
    var tickSizeValue   = 1;
    var tickSizeUnit    = '';
    var orderNumberMin  = 0;
    var orderNumberMax  = 0;
    var barWidthVal = 0;
    
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_TODAY)
    {
    	tickSizeValue = 2;
        tickSizeUnit = 'hour';
        barWidthVal = 60 * 60 * 1000;
    }
    
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_WEEKLY)
    {
    	tickSizeValue = 1;
        tickSizeUnit = 'day';
        barWidthVal = 24 * 60 * 60 * 1000;
    }
    
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_MONTHLY)
    {
    	tickSizeValue = 3;
        tickSizeUnit = 'day';
        barWidthVal = 24 * 60 * 60 * 600;
    }
    
    if (timeframe == DAS_PORTLET_CHART_ORDERS_TIMEFRAME_ANNUALLY)
    {
        tickSizeUnit = 'month';
        data_orderList.unshift([0,0]);
        data_orderList.push([0,0]);
        barWidthVal = 25* 24 * 60 * 60 * 1000;
    }

    $.each(data_orderList, function(i, dataSet){
        if (dataSet[1] < orderNumberMin)
            orderNumberMin = dataSet[1];
        if (dataSet[1] > orderNumberMax)
            orderNumberMax = dataSet[1];
    });
    
    var dataset = [{
            label: "Number of orders",
            data: data_orderList,
            color: "#1ab394",
            hoverable: true,
            bars: {
                show: true,
                align: "center",
                barWidth: barWidthVal,
                lineWidth:0
            }
        }];

    var options = {
        xaxis: {
            mode: "time",
            tickSize: [tickSizeValue, tickSizeUnit],
            tickLength: 0,
            axisLabel: "Date",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Arial',
            axisLabelPadding: 3,
            color: "#d5d5d5"
        },
        yaxes: {
            position: "top",
            color: "#d5d5d5",
            tickDecimals: 1,
            minTickSize: 1,
            min: orderNumberMin,
            max: orderNumberMax,
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: ' Arial',
            axisLabelPadding: 67
        },
        legend: {
            noColumns: 1,
            labelBoxBorderColor: "#000000",
            position: "nw"
        },
        grid: {
            hoverable: true,
            borderWidth: 0
        }
    };
    
    $.plot($("#flot-dashboard-chart"), dataset, options);
} // .end of das_portlet_chart_orders_plotGraph

</script>