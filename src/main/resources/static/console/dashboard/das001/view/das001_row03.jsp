<div class="row" id="das001_row03">
    <div class="col-lg-9">
        <div class="ibox float-e-margins">
            <div id="das001_row03_chart_header" class="ibox-title">
                <h5>Orders</h5>
                <div id="das001_row03_chart_haeder_menu" class="pull-right">
                    <div class="btn-group">
                        <button id="das001_row03_button_today" class="btn btn-xs active" onclick="das001_row03_timeSwitcher('das002_row03_timeframe_today');">Today</button>
                        <button id="das001_row03_button_weekly" class="btn btn-xs" onclick="das001_row03_timeSwitcher('das002_row03_timeframe_weekly');">Weekly</button>
                        <button id="das001_row03_button_monthly" class="btn btn-xs" onclick="das001_row03_timeSwitcher('das002_row03_timeframe_monthly');">Monthly</button>
                        <button id="das001_row03_button_annually" class="btn btn-xs" onclick="das001_row03_timeSwitcher('das002_row03_timeframe_annually');">Annual</button>
                    </div>
                </div>
            </div>
            <div id="das001_row03_chart_content" class="ibox-content">
                <div class="row">
                    <div class="col-lg-9">
                        <div class="flot-chart">
                            <div class="flot-chart-content" id="flot-dashboard-chart" style="padding: 0px; position: relative;">                            	
                           	</div>
                        </div>
                    </div>
                	<div class="col-lg-3">
	                    <ul class="stat-list">
	                        <li>
	                            <h2 class="no-margins" id="das001_row03_thisTotalOrder">2,346</h2>
	                            <small>Total orders in period</small>
	                            <div class="stat-percent">48% <i class="fa fa-level-up text-navy"></i></div>
	                            <div class="progress progress-mini">
	                                <div style="width: 48%;" class="progress-bar"></div>
	                            </div>
	                        </li>
	                        <li>
	                            <h2 class="no-margins " id="das001_row03_lastTotalOrder">4,422</h2>
	                            <small>Orders in last month</small>
	                            <div class="stat-percent">60% <i class="fa fa-level-down text-navy"></i></div>
	                            <div class="progress progress-mini">
	                                <div style="width: 60%;" class="progress-bar"></div>
	                            </div>
	                        </li>
	                        <li>
	                            <h2 class="no-margins " id="das001_row03_thisTotalAmount">9,180</h2>
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
            <div id="das001_row03_chart_spinner" class="ibox-content" style="height:90px; display:none;">
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
    <div class="col-lg-3">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5><i class="fa fa-calendar" aria-hidden="true"></i> My Calendar</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-wrench"></i>
                    </a>
                    <ul id="das001_calendar_selection" class="dropdown-menu dropdown-user">
                    </ul>
                </div>
            </div>
            <div id="das001_calendar_summary" class="ibox-content ibox-heading">
            </div>
            <div id="das001_calendar_timeline" class="ibox-content inspinia-timeline">
            </div>
        </div>
    </div> <!-- .end of col-lg-3 -->
</div>


<script>

var das001_row03_initialized            = false;

var das001_row03_TIMEFRAME_TODAY        = 'das002_row03_timeframe_today';
var das001_row03_TIMEFRAME_WEEKLY       = 'das002_row03_timeframe_weekly';
var das001_row03_TIMEFRAME_MONTHLY      = 'das002_row03_timeframe_monthly';
var das001_row03_TIMEFRAME_ANNUALLY     = 'das002_row03_timeframe_annually';

var das001_row03_DAYS_IN_MONTHS         = [31,28,31,30,31,30,31,31,30,31,30,31];
var das001_row03_DAYS_IN_MONTHS_LEAP    = [31,29,31,30,31,30,31,31,30,31,30,31];

/**
 * Init variables / states / components. 
 */
function das001_row03_init()
{
    if (das001_row03_initialized==true)
        return false;
    
    /*
    var data_paymentList = [
        [gd(2012, 1, 1), 7], [gd(2012, 1, 2), 6], [gd(2012, 1, 3), 4], [gd(2012, 1, 4), 8],
        [gd(2012, 1, 5), 9], [gd(2012, 1, 6), 7], [gd(2012, 1, 7), 5], [gd(2012, 1, 8), 4],
        [gd(2012, 1, 9), 7], [gd(2012, 1, 10), 8], [gd(2012, 1, 11), 9], [gd(2012, 1, 12), 6],
        [gd(2012, 1, 13), 4], [gd(2012, 1, 14), 5], [gd(2012, 1, 15), 11], [gd(2012, 1, 16), 8],
        [gd(2012, 1, 17), 8], [gd(2012, 1, 18), 11], [gd(2012, 1, 19), 11], [gd(2012, 1, 20), 6],
        [gd(2012, 1, 21), 6], [gd(2012, 1, 22), 8], [gd(2012, 1, 23), 11], [gd(2012, 1, 24), 13],
        [gd(2012, 1, 25), 7], [gd(2012, 1, 26), 9], [gd(2012, 1, 27), 9], [gd(2012, 1, 28), 8],
        [gd(2012, 1, 29), 5], [gd(2012, 1, 30), 8], [gd(2012, 1, 31), 25]
    ];

    var date_orderList = [
        [gd(2012, 1, 1), 800], [gd(2012, 1, 2), 500], [gd(2012, 1, 3), 600], [gd(2012, 1, 4), 700],
        [gd(2012, 1, 5), 500], [gd(2012, 1, 6), 456], [gd(2012, 1, 7), 800], [gd(2012, 1, 8), 589],
        [gd(2012, 1, 9), 467], [gd(2012, 1, 10), 876], [gd(2012, 1, 11), 689], [gd(2012, 1, 12), 700],
        [gd(2012, 1, 13), 500], [gd(2012, 1, 14), 600], [gd(2012, 1, 15), 700], [gd(2012, 1, 16), 786],
        [gd(2012, 1, 17), 345], [gd(2012, 1, 18), 888], [gd(2012, 1, 19), 888], [gd(2012, 1, 20), 888],
        [gd(2012, 1, 21), 987], [gd(2012, 1, 22), 444], [gd(2012, 1, 23), 999], [gd(2012, 1, 24), 567],
        [gd(2012, 1, 25), 786], [gd(2012, 1, 26), 666], [gd(2012, 1, 27), 888], [gd(2012, 1, 28), 900],
        [gd(2012, 1, 29), 178], [gd(2012, 1, 30), 555], [gd(2012, 1, 31), 993]
    ];


    var dataset = [
        {
            label: "Number of orders",
            data: date_orderList,
            color: "#1ab394",
            bars: {
                show: true,
                align: "center",
                barWidth: 24 * 60 * 60 * 600,
                lineWidth:0
            }

        }, {
            label: "Payments",
            data: data_paymentList,
            yaxis: 2,
            color: "#1C84C6",
            lines: {
                lineWidth:1,
                    show: true,
                    fill: true,
                fillColor: {
                    colors: [{
                        opacity: 0.2
                    }, {
                        opacity: 0.4
                    }]
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
        yaxes: [{
            position: "left",
            max: 1070,
            color: "#d5d5d5",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Arial',
            axisLabelPadding: 3
        }, {
            position: "right",
            clolor: "#d5d5d5",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: ' Arial',
            axisLabelPadding: 67
        }],
        legend: {
            noColumns: 1,
            labelBoxBorderColor: "#000000",
            position: "nw"
        },
        grid: {
            hoverable: false,
            borderWidth: 0
        }
    };

    function gd(year, month, day) {
        return new Date(year, month - 1, day).getTime();
    }

    $.plot($("#flot-dashboard-chart"), dataset, options);
    */
    
    das001_row03_initialized = true;
} // .end of das001_row03_init


/**
 * Setup values. 
 */
function das001_row03_updateUI()
{
    // Init segment
    das001_row03_init();
    
    das001_row03_timeSwitcher(das001_row03_TIMEFRAME_TODAY);
    
    das001_row03_updateUI_calendar();
    
    // Show segment
    $('#das001_row03').show();
} // .end of das001_row03_updateUI

/**
 * In response to user selection on timeframe, for sales boxlet
 */
function das001_row03_timeSwitcher(timeframe)
{
    // Show/Hide
    $('#das001_row03_chart_haeder_menu').hide();
    $('#das001_row03_chart_content').hide();
    $('#das001_row03_chart_spinner').show();

    // TODAY
    if (timeframe == das001_row03_TIMEFRAME_TODAY)
    {
        das001_row03_timeSwitcher_today(timeframe);
    }
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == das001_row03_TIMEFRAME_WEEKLY)
    {
        das001_row03_timeSwitcher_weekly(timeframe);
    }
    // MONTHLY
    if (timeframe == das001_row03_TIMEFRAME_MONTHLY)
    {
        das001_row03_timeSwitcher_monthly(timeframe);
    }
    // YEARLY
    if (timeframe == das001_row03_TIMEFRAME_ANNUALLY)
    {
        das001_row03_timeSwitcher_yearly(timeframe);
    }
} // .end of das001_row03_timeSwitcher

function das001_row03_timeSwitcher_today(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das001_row03_button_today').addClass('active btn-info');
    $('#das001_row03_button_weekly').removeClass('active btn-info');
    $('#das001_row03_button_monthly').removeClass('active btn-info');
    $('#das001_row03_button_annually').removeClass('active btn-info');

    thisBegin = new Date( $.now() );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setHours(23, 59, 59, 999);
    
    lastBegin = new Date( thisBegin.getTime() );
    lastBegin.setDate( lastBegin.getDate() - 1 );
    
    lastEnd = new Date( thisEnd.getTime() );
    lastEnd.setDate( lastEnd.getDate() - 1 );
    
    // Iterate through hours of the day
    var runningTime = new Date( thisBegin.getTime() );
    for (i = 0 ; i < 12 ; )
    {
        // Set incremented hour
        runningTime.setHours( thisBegin.getHours() + i )
        // Create dataset [x, y]
        //var dataset = [runningTime.getTime(), 0];
        var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
        // Insert into list
        data_orderList.push(dataset);
        
        i = i + 2; // show interval of every 2 hours
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
	    das001_row03_timeSwitcher_today_postHandler, 
	    params);
} // .end of das001_row03_timeSwitcher_today

function das001_row03_timeSwitcher_today_postHandler(successFlag, responseObj, params)
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
            var hour = billingObjCreationDateObj.getHours();
            
            params.data_orderList[hour][1] = params.data_orderList[hour][1] + 1;
        }
    });
    
    das001_row03_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das001_row03_thisTotalOrder').html( thisTotalOrder );
    $('#das001_row03_lastTotalOrder').html( 0 );
    $('#das001_row03_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das001_row03_chart_haeder_menu').show();
    $('#das001_row03_chart_content').show();
    $('#das001_row03_chart_spinner').hide();
} // .end of das001_row03_timeSwitcher_today_postHandler

function das001_row03_timeSwitcher_weekly(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das001_row03_button_today').removeClass('active btn-info');
    $('#das001_row03_button_weekly').addClass('active btn-info');
    $('#das001_row03_button_monthly').removeClass('active btn-info');
    $('#das001_row03_button_annually').removeClass('active btn-info');

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
        //var dataset = [runningTime.getTime(), 0];
        var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
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
	    das001_row03_timeSwitcher_weekly_postHandler, 
	    params);
} // .end of das001_row03_timeSwitcher_weekly

function das001_row03_timeSwitcher_weekly_postHandler(successFlag, responseObj, params)
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
    
    das001_row03_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das001_row03_thisTotalOrder').html( thisTotalOrder );
    $('#das001_row03_lastTotalOrder').html( 0 );
    $('#das001_row03_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das001_row03_chart_haeder_menu').show();
    $('#das001_row03_chart_content').show();
    $('#das001_row03_chart_spinner').hide();
} // .end of das001_row03_timeSwitcher_weekly_postHandler

function das001_row03_timeSwitcher_monthly(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das001_row03_button_today').removeClass('active btn-info');
    $('#das001_row03_button_weekly').removeClass('active btn-info');
    $('#das001_row03_button_monthly').addClass('active btn-info');
    $('#das001_row03_button_annually').removeClass('active btn-info');

    thisBegin = new Date( $.now() );
    thisBegin.setDate( 1 );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row03_DAYS_IN_MONTHS_LEAP[thisEnd.getMonth()] : das001_row03_DAYS_IN_MONTHS[thisEnd.getMonth()] );
    thisEnd.setHours(23, 59, 59, 999);
    
    lastBegin = new Date( thisBegin.getTime() );
    lastBegin.setMonth( lastBegin.getMonth() - 1 );
    
    lastEnd = new Date( lastBegin.getTime() );
    lastEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row03_DAYS_IN_MONTHS_LEAP[lastEnd.getMonth()] : das001_row03_DAYS_IN_MONTHS[lastEnd.getMonth()] );
    lastEnd.setHours(23, 59, 59, 999);
    
    // Iterate through days of the month
    var runningTime = new Date( thisBegin.getTime() );
    for (i = 0 ; i < thisEnd.getDate() ; i++)
    {
        // Set incremented day
        runningTime.setDate( thisBegin.getDate() + i )
        // Create dataset [x, y]
        //var dataset = [runningTime.getTime(), 0];
        var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
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
	    das001_row03_timeSwitcher_monthly_postHandler, 
	    params);
} // .end of das001_row03_timeSwitcher_monthly

function das001_row03_timeSwitcher_monthly_postHandler(successFlag, responseObj, params)
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
    
    das001_row03_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das001_row03_thisTotalOrder').html( thisTotalOrder );
    $('#das001_row03_lastTotalOrder').html( 0 );
    $('#das001_row03_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das001_row03_chart_haeder_menu').show();
    $('#das001_row03_chart_content').show();
    $('#das001_row03_chart_spinner').hide();
} // .end of das001_row03_timeSwitcher_monthly_postHandler

function das001_row03_timeSwitcher_yearly(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var data_orderList = [];
    
    // Toggle Buttons
    $('#das001_row03_button_today').removeClass('active btn-info');
    $('#das001_row03_button_weekly').removeClass('active btn-info');
    $('#das001_row03_button_monthly').removeClass('active btn-info');
    $('#das001_row03_button_annually').addClass('active btn-info');
    
    thisBegin = new Date( $.now() );
    thisBegin.setDate( 1 );
    thisBegin.setMonth( 0 );
    thisBegin.setHours(0, 0, 0, 0);
    
    thisEnd = new Date( $.now() );
    thisEnd.setDate( das001_row03_DAYS_IN_MONTHS[11] );
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
        //var dataset = [runningTime.getTime(), 0];
        var dataset = [runningTime.getTime(), tycheesDateTime_getCurrentTimeInMillis()%20];
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
	    das001_row03_timeSwitcher_yearly_postHandler, 
	    params);
} // .end of das001_row03_timeSwitcher_yearly

function das001_row03_timeSwitcher_yearly_postHandler(successFlag, responseObj, params)
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
            var month = billingObjCreationDateObj.getMonth();
            
            // Increment number of order
            params.data_orderList[month][1] = params.data_orderList[month][1] + 1;
        }
    });
    
    das001_row03_plotGraph( params.timeframe, params.data_orderList );
    
    var thisTotalOrder = 0;
    $.each(params.data_orderList, function(i, data){
    	thisTotalOrder += data[1];
    });
    
    // Summary 
    $('#das001_row03_thisTotalOrder').html( thisTotalOrder );
    $('#das001_row03_lastTotalOrder').html( 0 );
    $('#das001_row03_thisTotalAmount').html( 0 );
    
    // Show/Hide
    $('#das001_row03_chart_haeder_menu').show();
    $('#das001_row03_chart_content').show();
    $('#das001_row03_chart_spinner').hide();
} // .end of das001_row03_timeSwitcher_yearly_postHandler

/**
 * Plot graph.  
 */
function das001_row03_plotGraph(timeframe, data_orderList)
{
    var tickSizeValue   = 1;
    var tickSizeUnit    = '';
    var orderNumberMin  = 0;
    var orderNumberMax  = 0;
    var barWidthVal = 0;
    
    if (timeframe == das001_row03_TIMEFRAME_TODAY)
    {
    	tickSizeValue = 2;
        tickSizeUnit = 'hour';
        barWidthVal = 60 * 60 * 1000;
    }
    
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == das001_row03_TIMEFRAME_WEEKLY)
    {
    	tickSizeValue = 1;
        tickSizeUnit = 'day';
        barWidthVal = 24 * 60 * 60 * 1000;
    }
    
    if (timeframe == das001_row03_TIMEFRAME_MONTHLY)
    {
    	tickSizeValue = 3;
        tickSizeUnit = 'day';
        barWidthVal = 24 * 60 * 60 * 600;
    }
    
    if (timeframe == das001_row03_TIMEFRAME_ANNUALLY)
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
} // .end of das001_row03_plotGraph

/**
 * UI Setup for Calendar panel.
 */
function das001_row03_updateUI_calendar()
{
    // Clear timeline list
    $('#das001_calendar_selection').empty();
    $('#das001_calendar_timeline').empty();
    
    // Create today object
    var today = new Date();
    // Current Place object & User object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userObj = tycheesCommon_getCurrentUserObject();
    
    // Populate available calendar from PlaceObj & UserObj
    var horizontalBreakLine = '<hr style="margin: 2px 0px 2px 0px;"/>';
    var allCalendar = "<li><span onclick='das001_row03_updateUI_calendar_updateTimeline(\''all\'')'>All Calendars</span></li>";
    var customerDobCalendar = "<li><span onclick='das001_row03_updateUI_calendar_updateTimeline(\''dob\'')'>Date of Birth</span></li>";
    var billingCalendar = "<li><span onclick='das001_row03_updateUI_calendar_updateTimeline(\''billing\'')'>All Calendars</span></li>";
    
    $('#das001_calendar_selection').append(allCalendar);
    $('#das001_calendar_selection').append(horizontalBreakLine);
    $('#das001_calendar_selection').append(customerDobCalendar);
    $('#das001_calendar_selection').append(billingCalendar);
    $('#das001_calendar_selection').append(horizontalBreakLine);

    // Populate Selected Calendars
    $.each(placeObj.calendarList, function(i, calendarObj) {
        
        var htmlLines = '';
        htmlLines += '<li>';
        htmlLines += '<span onclick="das001_row03_updateUI_calendar_updateTimeline(\'' + calendarObj.id + '\')">' + calendarObj.calendarName + '</span>';
        htmlLines += '</li>';
        
        $('#das001_calendar_selection').append(htmlLines);
    });
    $('#das001_calendar_selection').append(horizontalBreakLine);
    
    $.each(userObj.calendarList, function(i, calendarObj) {
    
        var htmlLines = '';
        htmlLines += '<li>';
        htmlLines += '<span onclick="das001_row03_updateUI_calendar_updateTimeline(\'' + calendarObj.id + '\')">' + calendarObj.calendarName + '</span>';
        htmlLines += '</li>';
        
        $('#das001_calendar_selection').append(htmlLines);
    });    

    das001_row03_updateUI_calendar_updateTimeline('all');
} // .end of das001_row03_updateUI_calendar

/**
 * Update portlet 'Calendar'.
 *
 * @param {String} calendarId - Calendar ID or 'all'/'dob'/'billing'
 */
function das001_row03_updateUI_calendar_updateTimeline(calendarId)
{
    var personalEventCount = 0;
    var showIndividualCalendar = true;
    if (calendarId == 'dob' || calendarId == 'billing')
        showIndividualCalendar = false;

    // Create today object
    var today = new Date();
    // Current Place object & User object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userObj = tycheesCommon_getCurrentUserObject();
    
    if (calendarId == 'all' || showIndividualCalendar == true) 
    {
        // Populate Selected Calendars
        $.each(placeObj.calendarList, function(i, calendarObj) {
            
            if (calendarId == 'all' || calendarId == calendarObj.id)
            {
                // Add calendar events into UI
                $.each(calendarObj.eventList, function(j, eventObj) {
                    if (tycheesDateTime_isSameDay(today, new Date(eventObj.start)))
                    {
                        das001_row03_updateUI_calendar_addEventAsTimeline(eventObj);
                    }
                });
            }
        });
    }
    
    if (calendarId == 'all' || showIndividualCalendar == true) 
    {
        $.each(userObj.calendarList, function(i, calendarObj) {
        
            if (calendarId == 'all' || calendarId == calendarObj.id)
            {
                // Add calendar events into UI
                $.each(calendarObj.eventList, function(j, eventObj) {
                    if (tycheesDateTime_isSameDay(today, new Date(eventObj.start)))
                    {
                        das001_row03_updateUI_calendar_addEventAsTimeline(eventObj);
                    }
                });
                
                personalEventCount++;
                
                if (i == 0)
                {
                    var htmlLines = '';
                    htmlLines += '<h3>You have ' + userObj.calendarList.length + ' personal events today!</h3>';
                    htmlLines += '<small>';
                    htmlLines += '<i class="fa fa-map-marker"></i> Check your schedule to see detail.';
                    htmlLines += '</small>';
                    
                    $('#das001_calendar_summary').append(htmlLines);
                }
            }
        }); 
    }

    if (calendarId == 'all' || calendarId == 'dob') 
    {
        // Add customer's DOB as calendar event
        var customerList = Cached_getCustomerList();
        $.each(customerList, function(i, customerObj) {
        	if (tycheesDateTime_isSameDay(today, new Date(customerObj.dob), true))
            {
                das001_row03_updateUI_calendar_addCustomerAsTimeline(customerObj);
            }
        });
    }
    
    if (calendarId == 'all' || calendarId == 'billing')
    {
        // Add billing calendar event
        var billingList = Cached_getBillingList();
        $.each(billingList, function(i, billingObj) {
        	$.each(billingObj.calendarList, function(j, calendarObj) {
    	        $.each(calendarObj.eventList, function(k, eventObj) {
    	            if (tycheesDateTime_isSameDay(today, new Date(eventObj.start)))
                    {
                        das001_row03_updateUI_calendar_addEventAsTimeline(eventObj);
                    }
                });
            });
        });
    }
    
    if (personalEventCount==0)
    {
        var htmlLines = '';
        htmlLines += '<h3>You have 0 personal event today!</h3>';
        htmlLines += '<small>';
        htmlLines += '<i class="fa fa-map-marker"></i> Check your schedule to see detail.';
        htmlLines += '</small>';
        
        $('#das001_calendar_summary').append(htmlLines);
    }
} // .end of das001_row03_updateUI_calendar_updateTimeline

function das001_row03_updateUI_calendar_addEventAsTimeline(eventObj)
{
    var now = new Date();

    var timeVal = tycheesDateTime_getFormattedDate_hhmm(eventObj.start) + ' ' + tycheesDateTime_getAmPm(eventObj.start);
    var hoursDiffVal = tycheesDateTime_getHoursInBetween(now.getTime(), eventObj.start);
    if (hoursDiffVal >= 0)
        hoursDiffVal += ' hours later';
    else
        hoursDiffVal += ' hours ago';

    var htmlLines = '';
    htmlLines += '<div class="timeline-item">';
    htmlLines += '<div class="row">';
    htmlLines += '<div class="col-xs-3 date">';
    htmlLines += '<i class="fa fa-calendar-o" aria-hidden="true"></i>';
    htmlLines += timeVal;
    htmlLines += '<br/>';
    htmlLines += '<small class="text-navy">' + hoursDiffVal + '</small>';
    htmlLines += '</div>';
    htmlLines += '<div class="col-xs-8 content">';
    htmlLines += '<p class="m-b-xs"><strong>' + eventObj.title + '</strong></p>';
    htmlLines += '<p>' + eventObj.remarks + '</p>';
    htmlLines += '</div>';
    htmlLines += '</div>';
    htmlLines += '</div>';
    
    $('#das001_calendar_timeline').append(htmlLines);
} // .end of das001_row03_updateUI_calendar_addEventAsTimeline

function das001_row03_updateUI_calendar_addCustomerAsTimeline(customerObj)
{
    var htmlLines = '';
    htmlLines += '<div class="timeline-item">';
    htmlLines += '<div class="row">';
    htmlLines += '<div class="col-xs-3 date">';
    htmlLines += '<i class="fa fa-birthday-cake" aria-hidden="true"></i>';
    htmlLines += 'All Day';
    htmlLines += '<br/>';
    htmlLines += '<small class="text-navy">Birthday</small>';
    htmlLines += '</div>';
    htmlLines += '<div class="col-xs-8 content">';
    htmlLines += '<p class="m-b-xs"><strong>' + customerObj.firstName + ' ' + customerObj.lastName + '</strong></p>';
    htmlLines += '<p>' + customerObj.remarks + '</p>';
    htmlLines += '</div>';
    htmlLines += '</div>';
    htmlLines += '</div>';
    
    $('#das001_calendar_timeline').append(htmlLines);
} // .end of das001_row03_updateUI_calendar_addCustomerAsTimeline

</script>