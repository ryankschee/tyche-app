<div class="row" id="das001_row02">
    <div class="col-lg-4">
        <div class="ibox float-e-margins">
            <div id="das001_row02_sales_header" class="ibox-title">
                <h5><i class="fa fa-usd" aria-hidden="true"></i> Sales</h5>
                <div id="das001_row02_sales_haeder_menu" class="pull-right">
                    <div class="btn-group">
                        <button id="das001_row02_sales_btn01" class="btn btn-xs active" onclick="das001_row02_sales_timeSwitcher('das002_row02_timeframe_today');">Today</button>
                        <button id="das001_row02_sales_btn02" class="btn btn-xs" onclick="das001_row02_sales_timeSwitcher('das002_row02_timeframe_thisWeek');">This Week</button>
                        <button id="das001_row02_sales_btn03" class="btn btn-xs" onclick="das001_row02_sales_timeSwitcher('das002_row02_timeframe_thisMonth');">This Month</button>
                    </div>
                </div>
            </div>
            <div id="das001_row02_sales_content" class="ibox-content" style="height:90px;">
                <h1 class="no-margins" id="das001_row02_sales_amount">0.00</h1>
                <div class="stat-percent font-bold text-info" id="das001_row02_sales_percentage">
                    20% <i class="fa fa-level-up"></i>
                </div>
                <small>Received: MYR <span id="das001_row02_sales_paid_amount"></span></small>
            </div>
            <div id="das001_row02_sales_spinner" class="ibox-content" style="height:90px; display:none;">
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
    <div class="col-lg-4">
        <div class="ibox float-e-margins">
            <div id="das001_row02_orders_header" class="ibox-title">
                <h5><i class="fa fa-file" aria-hidden="true"></i> New Orders</h5>
                <div id="das001_row02_orders_header_menu" class="pull-right">
                    <div class="btn-group">
                        <button id="das001_row02_order_btn01" class="btn btn-xs active" onclick="das001_row02_order_timeSwitcher('das002_row02_timeframe_today');">Today</button>
                        <button id="das001_row02_order_btn02" class="btn btn-xs" onclick="das001_row02_order_timeSwitcher('das002_row02_timeframe_thisWeek');">This Week</button>
                        <button id="das001_row02_order_btn03" class="btn btn-xs" onclick="das001_row02_order_timeSwitcher('das002_row02_timeframe_thisMonth');">This Month</button>
                    </div>
                </div>
            </div>
            <div id="das001_row02_orders_content" class="ibox-content" style="height:90px;">
                <h1 class="no-margins" id="das001_row02_order_count">0</h1>
                <div class="stat-percent font-bold text-info" id="das001_row02_order_percentage">
                    20% <i class="fa fa-level-up"></i>
                </div>
                <small>Amount: MYR <span id="das001_row02_order_amount"></span></small>
            </div>
            <div id="das001_row02_orders_spinner" class="ibox-content" style="height:90px; display:none;">
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
    <div class="col-lg-4">
        <div class="ibox float-e-margins">
            <div id="das001_row02_visitors_header" class="ibox-title">
                <h5>PWS Visitors</h5>
                <div class="pull-right">
                    <div  id="das001_row02_visitors_header_menu" class="btn-group">
                        <button id="das001_row02_visit_btn01" class="btn btn-xs active" onclick="das001_row02_visit_timeSwitcher('das002_row02_timeframe_today');">Today</button>
                        <button id="das001_row02_visit_btn02" class="btn btn-xs" onclick="das001_row02_visit_timeSwitcher('das002_row02_timeframe_thisWeek');">This Week</button>
                        <button id="das001_row02_visit_btn03" class="btn btn-xs" onclick="das001_row02_visit_timeSwitcher('das002_row02_timeframe_thisMonth');">This Month</button>
                    </div>
                </div>
            </div>
            <div id="das001_row02_visitors_header" class="ibox-content" style="height:90px;">
                <h1 class="no-margins">0</h1>
                <div class="stat-percent font-bold text-navy">44% <i class="fa fa-level-up"></i></div>
                <small>New visits</small>
            </div>
            <div id="das001_row02_visitors_spinner" class="ibox-content" style="height:90px; display:none;">
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
    <!--
    <div class="col-lg-3">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>User activity</h5>
                <div class="pull-right">
                    <div class="btn-group">
                        <button class="btn btn-xs active">Today</button>
                        <button class="btn btn-xs">This Week</button>
                        <button class="btn btn-xs">This Month</button>
                    </div>
                </div>
            </div>
            <div class="ibox-content">
                <h1 class="no-margins">0</h1>
                <div class="stat-percent font-bold text-danger">38% <i class="fa fa-level-down"></i></div>
                <small>In first month</small>
            </div>
        </div>
    </div>
    -->
</div> <!-- .end of row  -->


<script>

var das001_row02_initialized            = false;

var das001_row02_TIMEFRAME_TODAY        = 'das002_row02_timeframe_today';
var das001_row02_TIMEFRAME_THISWEEK     = 'das002_row02_timeframe_thisWeek';
var das001_row02_TIMEFRAME_THISMONTH    = 'das002_row02_timeframe_thisMonth';

var das001_row02_DAYS_IN_MONTHS         = [31,28,31,30,31,30,31,31,30,31,30,31];
var das001_row02_DAYS_IN_MONTHS_LEAP    = [31,29,31,30,31,30,31,31,30,31,30,31];

/**
 * Init variables / states / components. 
 */
function das001_row02_init()
{
    if (das001_row02_initialized==true)
        return false;
        
    das001_row02_initialized = true;
} // .end of das001_row02_init


/**
 * Setup values. 
 */
function das001_row02_updateUI()
{
    // Init segment
    das001_row02_init();
    
    das001_row02_sales_timeSwitcher(das001_row02_TIMEFRAME_TODAY);
    das001_row02_order_timeSwitcher(das001_row02_TIMEFRAME_TODAY);
    das001_row02_visit_timeSwitcher(das001_row02_TIMEFRAME_TODAY);
    
    // Show segment
    $('#das001_row02').show();
} // .end of das001_row02_updateUI


/**
 * In response to user selection on timeframe, for sales boxlet
 */
function das001_row02_sales_timeSwitcher(timeframe)
{
    // Show/Hide
    $('#das001_row02_sales_haeder_menu').hide();
    $('#das001_row02_sales_content').hide();
    $('#das001_row02_sales_spinner').show();

	var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var comparedTo = '';

    if (timeframe == das001_row02_TIMEFRAME_TODAY)
    {
        // Toggle Buttons
        $('#das001_row02_sales_btn01').addClass('active btn-info');
        $('#das001_row02_sales_btn02').removeClass('active btn-info');
        $('#das001_row02_sales_btn03').removeClass('active btn-info');
    
        thisBegin = new Date( $.now() );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setDate( lastBegin.getDate() - 1 );
        
        lastEnd = new Date( thisEnd.getTime() );
        lastEnd.setDate( lastEnd.getDate() - 1 );
        
        comparedTo = 'Compared to Yesterday';
        
        //console.log('ORDER: TODAY');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
    
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == das001_row02_TIMEFRAME_THISWEEK)
    {
        // Toggle Buttons
        $('#das001_row02_sales_btn01').removeClass('active btn-info');
        $('#das001_row02_sales_btn02').addClass('active btn-info');
        $('#das001_row02_sales_btn03').removeClass('active btn-info');
    
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
        
        comparedTo = 'Compared to Last Week';
        
        //console.log('ORDER: THIS WEEK');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
    
    if (timeframe == das001_row02_TIMEFRAME_THISMONTH)
    {
        // Toggle Buttons
        $('#das001_row02_sales_btn01').removeClass('active btn-info');
        $('#das001_row02_sales_btn02').removeClass('active btn-info');
        $('#das001_row02_sales_btn03').addClass('active btn-info');
    
        thisBegin = new Date( $.now() );
        thisBegin.setDate( 1 );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row02_DAYS_IN_MONTHS_LEAP[thisEnd.getMonth()] : das001_row02_DAYS_IN_MONTHS[thisEnd.getMonth()] );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setMonth( lastBegin.getMonth() - 1 );
        
        lastEnd = new Date( lastBegin.getTime() );
        lastEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row02_DAYS_IN_MONTHS_LEAP[lastEnd.getMonth()] : das001_row02_DAYS_IN_MONTHS[lastEnd.getMonth()] );
        lastEnd.setHours(23, 59, 59, 999);
        
        comparedTo = 'Compared to Last Month';
        
        //console.log('ORDER: THIS MONTH');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
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
	params.comparedTo = comparedTo;
	params.thisBegin = thisBegin;
	params.thisEnd = thisEnd;
	params.lastBegin = lastBegin;
	params.lastEnd = lastEnd;
	
	tycheesdb_api_getBillingsByTimePeriod(
	    requestBody, 
	    das001_row02_sales_timeSwitcher_postHandler, 
	    params);
    
} // .end of das001_row02_sales_timeSwitcher

function das001_row02_sales_timeSwitcher_postHandler(successFlag, responseObj, params)
{
    if (successFlag == false)
    {
        tycheesLogger_logError('Ajax Failure.','das001_row02_sales_timeSwitcher_postHandler');
        return false;    
    }
    
    var thisList = [];
    var lastList = [];
    var thisTotalAmount = 0.0;
    var lastTotalAmount = 0.0;
    var thisTotalPaidAmount = 0.0;
    var lastTotalPaidAmount = 0.0;
    
    $.each(responseObj.billingList, function(i, billingObj){
        
        if (billingObj.billingDate > params.thisBegin.getTime() && 
            billingObj.billingDate < params.thisEnd.getTime() )
        {
            thisList.push(billingObj);
            thisTotalAmount += billingObj.totalAmount;
        }
        
        if (billingObj.billingDate > params.lastBegin.getTime() && 
            billingObj.billingDate < params.lastEnd.getTime() )
        {
            lastList.push(billingObj);
            lastTotalAmount += billingObj.totalAmount;
        }
    });
    
    var countPercentage = 0;
    if (lastTotalAmount == 0)
    	countPercentage = thisTotalAmount * 100;
    else
    	countPercentage = ( (lastTotalAmount - thisTotalAmount) / lastTotalAmount ) * 100;
    
    var arrowSign = '<i class="fa fa-level-up"></i>';
    var upColorSign = 'text-info';
    
    if (countPercentage >= 0)
    {
        $('#das001_row02_sales_percentage').addClass('text-info');
        $('#das001_row02_sales_percentage').removeClass('text-danger');
    }
    else
    {
        arrowSign = '<i class="fa fa-level-down"></i>';
        $('#das001_row02_sales_percentage').addClass('text-danger');
        $('#das001_row02_sales_percentage').removeClass('text-info');
    }
    
    $('#das001_row02_sales_amount').html( Number(thisTotalAmount).toFixed(2) );
    $('#das001_row02_sales_paid_amount').html( Number(thisTotalPaidAmount).toFixed(2) );
    $('#das001_row02_sales_percentage').html( params.comparedTo + ': ' + Number(countPercentage).toFixed(1) + '% ' + arrowSign);
    
    // Show/Hide
    $('#das001_row02_sales_haeder_menu').show();
    $('#das001_row02_sales_content').show();
    $('#das001_row02_sales_spinner').hide();
} // .end of das001_row02_sales_timeSwitcher_postHandler

/**
 * In response to user selection on timeframe, for order boxlet
 */
function das001_row02_order_timeSwitcher(timeframe)
{
    // Show/Hide
    $('#das001_row02_orders_header_menu').hide();
    $('#das001_row02_orders_content').hide();
    $('#das001_row02_orders_spinner').show();

    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var comparedTo = '';

    if (timeframe == das001_row02_TIMEFRAME_TODAY)
    {
        // Toggle Buttons
        $('#das001_row02_order_btn01').addClass('active btn-info');
        $('#das001_row02_order_btn02').removeClass('active btn-info');
        $('#das001_row02_order_btn03').removeClass('active btn-info');
    
        thisBegin = new Date( $.now() );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setDate( lastBegin.getDate() - 1 );
        
        lastEnd = new Date( thisEnd.getTime() );
        lastEnd.setDate( lastEnd.getDate() - 1 );
        
        comparedTo = 'Compared to Yesterday';
        
        //console.log('ORDER: TODAY');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
    
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == das001_row02_TIMEFRAME_THISWEEK)
    {
        // Toggle Buttons
        $('#das001_row02_order_btn01').removeClass('active btn-info');
        $('#das001_row02_order_btn02').addClass('active btn-info');
        $('#das001_row02_order_btn03').removeClass('active btn-info');
    
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
        
        comparedTo = 'Compared to Last Week';
        
        //console.log('ORDER: THIS WEEK');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
    
    if (timeframe == das001_row02_TIMEFRAME_THISMONTH)
    {
        // Toggle Buttons
        $('#das001_row02_order_btn01').removeClass('active btn-info');
        $('#das001_row02_order_btn02').removeClass('active btn-info');
        $('#das001_row02_order_btn03').addClass('active btn-info');
    
        thisBegin = new Date( $.now() );
        thisBegin.setDate( 1 );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row02_DAYS_IN_MONTHS_LEAP[thisEnd.getMonth()] : das001_row02_DAYS_IN_MONTHS[thisEnd.getMonth()] );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setMonth( lastBegin.getMonth() - 1 );
        
        lastEnd = new Date( lastBegin.getTime() );
        lastEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row02_DAYS_IN_MONTHS_LEAP[lastEnd.getMonth()] : das001_row02_DAYS_IN_MONTHS[lastEnd.getMonth()] );
        lastEnd.setHours(23, 59, 59, 999);
        
        comparedTo = 'Compared to Last Month';
        
        //console.log('ORDER: THIS MONTH');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
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
	params.comparedTo = comparedTo;
	params.thisBegin = thisBegin;
	params.thisEnd = thisEnd;
	params.lastBegin = lastBegin;
	params.lastEnd = lastEnd;
	
	tycheesdb_api_getBillingsByTimePeriod(
	    requestBody, 
	    das001_row02_order_timeSwitcher_postHandler, 
	    params);
    
} // .end of das001_row02_order_timeSwitcher

function das001_row02_order_timeSwitcher_postHandler(successFlag, responseObj, params)
{
    if (successFlag == false)
    {
        tycheesLogger_logError('Ajax Failure.','das001_row02_sales_timeSwitcher_postHandler');
        return false;    
    }
    
    var thisList = [];
    var lastList = [];
    var thisTotalAmount = 0.0;
    var lastTotalAmount = 0.0;
    
    $.each(responseObj.billingList, function(i, billingObj){
        
        if (billingObj.billingDate > params.thisBegin.getTime() && 
            billingObj.billingDate < params.thisEnd.getTime() )
        {
            thisList.push(billingObj);
            thisTotalAmount += billingObj.totalAmount;
        }
        
        if (billingObj.billingDate > params.lastBegin.getTime() && 
            billingObj.billingDate < params.lastEnd.getTime() )
        {
            lastList.push(billingObj);
            lastTotalAmount += billingObj.totalAmount;
        }
    });
    
    var countPercentage = 0;
    if (lastList.length == 0)
    	countPercentage = thisList.length * 100;
    else
    	countPercentage = ( (lastList.length - thisList.length) / lastList.length ) * 100;
    
    var arrowSign = '<i class="fa fa-level-up"></i>';
    var upColorSign = 'text-info';
    
    if (countPercentage >= 0)
    {
        $('#das001_row02_order_percentage').addClass('text-info');
        $('#das001_row02_order_percentage').removeClass('text-danger');
    }
    else
    {
        arrowSign = '<i class="fa fa-level-down"></i>';
        $('#das001_row02_order_percentage').addClass('text-danger');
        $('#das001_row02_order_percentage').removeClass('text-info');
    }
    
    $('#das001_row02_order_count').html( thisList.length );
    $('#das001_row02_order_amount').html( Number(thisTotalAmount).toFixed(2) );
    $('#das001_row02_order_percentage').html( params.comparedTo + ': ' + Number(countPercentage).toFixed(1) + '% ' + arrowSign);
    
    // Show/Hide
    $('#das001_row02_orders_header_menu').show();
    $('#das001_row02_orders_content').show();
    $('#das001_row02_orders_spinner').hide();

} // .end of das001_row02_order_timeSwitcher_postHandler

/**
 * In response to user selection on timeframe, for PWS visit boxlet
 */
function das001_row02_visit_timeSwitcher(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var comparedTo = '';

    if (timeframe == das001_row02_TIMEFRAME_TODAY)
    {
        // Toggle Buttons
        $('#das001_row02_visit_btn01').addClass('active btn-info');
        $('#das001_row02_visit_btn02').removeClass('active btn-info');
        $('#das001_row02_visit_btn03').removeClass('active btn-info');
    
        thisBegin = new Date( $.now() );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setDate( lastBegin.getDate() - 1 );
        
        lastEnd = new Date( thisEnd.getTime() );
        lastEnd.setDate( lastEnd.getDate() - 1 );
        
        comparedTo = 'Compared to Yesterday';
        
        //console.log('ORDER: TODAY');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
    
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == das001_row02_TIMEFRAME_THISWEEK)
    {
        // Toggle Buttons
        $('#das001_row02_visit_btn01').removeClass('active btn-info');
        $('#das001_row02_visit_btn02').addClass('active btn-info');
        $('#das001_row02_visit_btn03').removeClass('active btn-info');
    
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
        
        comparedTo = 'Compared to Last Week';
        
        //console.log('ORDER: THIS WEEK');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
    
    if (timeframe == das001_row02_TIMEFRAME_THISMONTH)
    {
        // Toggle Buttons
        $('#das001_row02_visit_btn01').removeClass('active btn-info');
        $('#das001_row02_visit_btn02').removeClass('active btn-info');
        $('#das001_row02_visit_btn03').addClass('active btn-info');
    
        thisBegin = new Date( $.now() );
        thisBegin.setDate( 1 );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row02_DAYS_IN_MONTHS_LEAP[thisEnd.getMonth()] : das001_row02_DAYS_IN_MONTHS[thisEnd.getMonth()] );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setMonth( lastBegin.getMonth() - 1 );
        
        lastEnd = new Date( lastBegin.getTime() );
        lastEnd.setDate( thisEnd.getYear() % 4 == 0 ? das001_row02_DAYS_IN_MONTHS_LEAP[lastEnd.getMonth()] : das001_row02_DAYS_IN_MONTHS[lastEnd.getMonth()] );
        lastEnd.setHours(23, 59, 59, 999);
        
        comparedTo = 'Compared to Last Month';
        
        //console.log('ORDER: THIS MONTH');
        //console.log('  1.FROM [' + thisBegin.getTime() + ']: ' + thisBegin.toDateString() + ' ' + thisBegin.toTimeString());
        //console.log('  1.TO   [' + thisEnd.getTime() + ']: ' + thisEnd.toDateString() + ' ' + thisEnd.toTimeString());
        //console.log('  2.FROM [' + lastBegin.getTime() + ']: ' + lastBegin.toDateString() + ' ' + lastBegin.toTimeString());
        //console.log('  2.TO   [' + lastEnd.getTime() + ']: ' + lastEnd.toDateString() + ' ' + lastEnd.toTimeString());
    }
} // .end of das001_row02_visit_timeSwitcher

</script>