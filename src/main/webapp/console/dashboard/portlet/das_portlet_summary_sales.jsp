<div id="das_portlet_summary_sales" class="ibox float-e-margins">
    <div id="das_portlet_summary_sales_header" class="ibox-title" style="padding-left:10px; padding-right:10px;">
        <h5>
        	Sales <span id="das_portlet_summary_sales_subtitle" class="small"></span>
        </h5>        
        <div class="ibox-tools open">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">
	            <i class="fa fa-filter"></i>
	        </a>
	        <ul class="dropdown-menu dropdown-user">
	            <li>
	            	<a href="#" onclick="das_portlet_summary_sales_timeSwitcher('das_portlet_summary_sales_timeframe_today');">Today</a>
	            </li>
	            <li>
	            	<a href="#" onclick="das_portlet_summary_sales_timeSwitcher('das_portlet_summary_sales_timeframe_thisWeek');">This Week</a>
	            </li>
	            <li>
	            	<a href="#" onclick="das_portlet_summary_sales_timeSwitcher('das_portlet_summary_sales_timeframe_thisMonth');">This Month</a>
	            </li>
	        </ul>	        
	    </div>
    </div>
    <div id="das_portlet_summary_sales_content" class="ibox-content" style="height:100%; padding-left:10px; padding-right:10px;">
        <h1 class="no-margins" id="das_portlet_summary_sales_amount">0.00</h1>
        <br/>
        <div class="stat-percent font-bold text-info" id="das_portlet_summary_sales_percentage">
            20% <i class="fa fa-level-up"></i>
        </div>
        <small>
            Received<br>
            <span class="currency">MYR</span> 
            <span id="das_portlet_summary_sales_paid_amount"></span>
        </small>
    </div>
    <div id="das_portlet_summary_sales_spinner" class="ibox-content" style="height:90px; display:none;">
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

var das_portlet_summary_sales_initialized            = false;
var das_portlet_summary_sales_currency;

var DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_TODAY        = 'das_portlet_summary_sales_timeframe_today';
var DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_THISWEEK     = 'das_portlet_summary_sales_timeframe_thisWeek';
var DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_THISMONTH    = 'das_portlet_summary_sales_timeframe_thisMonth';

/**
 * Init variables / states / components. 
 */
function das_portlet_summary_sales_init()
{
    if (das_portlet_summary_sales_initialized==true)
        return false;
        
    das_portlet_summary_sales_currency = 
        settingsCommon_getSettingsValue(
			ModuleConstants.MODULE_BILLING, 
			ModuleConstants.MODULE_BILLING_SUB_GENERAL, 
			SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);    
	
	$('.currency').html( das_portlet_summary_sales_currency.toUpperCase() );
        
    das_portlet_summary_sales_initialized = true;
} // .end of das_portlet_summary_sales_init

/**
 * Update UI.
 */
function das_portlet_summary_sales_updateUI()
{
    // Init segment
    das_portlet_summary_sales_init();
    // Default set to TODAY
    das_portlet_summary_sales_timeSwitcher(DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_TODAY);
    // Show segment
    $('#das_portlet_summary_sales').show();
} // .end of das_portlet_summary_sales_updateUI

/**
 * In response to user selection on timeframe, for sales boxlet
 *
 * @param {String} timeframe - timeframe option.
 */
function das_portlet_summary_sales_timeSwitcher(timeframe)
{
    // Show/Hide
    $('#das_portlet_summary_sales_header_menu').hide();
    $('#das_portlet_summary_sales_content').hide();
    $('#das_portlet_summary_sales_spinner').show();

	var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var comparedTo = '';

    if (timeframe == DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_TODAY)
    {
    	// Set small title
    	$('#das_portlet_summary_sales_subtitle').html(' (TODAY)');
        
        thisBegin = new Date( $.now() );
        thisBegin.setHours(0, 0, 0, 0);
        
        thisEnd = new Date( $.now() );
        thisEnd.setHours(23, 59, 59, 999);
        
        lastBegin = new Date( thisBegin.getTime() );
        lastBegin.setDate( lastBegin.getDate() - 1 );
        
        lastEnd = new Date( thisEnd.getTime() );
        lastEnd.setDate( lastEnd.getDate() - 1 );
        
        //comparedTo = 'Compared to Yesterday';
        comparedTo = 'In Comparison';
    }
    
    // WEEK: Monday - Sunday (ISO 8601)
    if (timeframe == DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_THISWEEK)
    {
    	// Set small title
    	$('#das_portlet_summary_sales_subtitle').html(' (THIS WEEK)');
        
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
        
        //comparedTo = 'Compared to Last Week';
        comparedTo = 'In Comparison';
    }
    
    if (timeframe == DAS_PORTLET_SUMMARY_SALES_TIMEFRAME_THISMONTH)
    {
    	// Set small title
    	$('#das_portlet_summary_sales_subtitle').html(' (THIS MONTH)');
        
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
        
        //comparedTo = 'Compared to Last Month';
        comparedTo = 'In Comparison';
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
	    das_portlet_summary_sales_timeSwitcher_postHandler, 
	    params);
    
} // .end of das_portlet_summary_sales_timeSwitcher

/**
 * Ajax post-handler.
 *
 * @param {Boolean} successFlag - true/false.
 * @param {Object} responseObj - Ajax http response object
 * @param {Object} params - Parameter object
 */
function das_portlet_summary_sales_timeSwitcher_postHandler(successFlag, responseObj, params)
{
    if (successFlag == false)
    {
        tycheesLogger_logError('Ajax Failure.','das_portlet_summary_sales_timeSwitcher_postHandler');
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
        $('#das_portlet_summary_sales_percentage').addClass('text-info');
        $('#das_portlet_summary_sales_percentage').removeClass('text-danger');
    }
    else
    {
        arrowSign = '<i class="fa fa-level-down"></i>';
        $('#das_portlet_summary_sales_percentage').addClass('text-danger');
        $('#das_portlet_summary_sales_percentage').removeClass('text-info');
    }
    
    $('#das_portlet_summary_sales_amount').html( Number(thisTotalAmount).toFixed(2) );
    $('#das_portlet_summary_sales_paid_amount').html( Number(thisTotalPaidAmount).toFixed(2) );
    $('#das_portlet_summary_sales_percentage').html( params.comparedTo + '<br>' + Number(countPercentage).toFixed(1) + '% ' + arrowSign);
    
    // Show/Hide
    $('#das_portlet_summary_sales_header_menu').show();
    $('#das_portlet_summary_sales_content').show();
    $('#das_portlet_summary_sales_spinner').hide();
} // .end of das_portlet_summary_sales_timeSwitcher_postHandler

</script>