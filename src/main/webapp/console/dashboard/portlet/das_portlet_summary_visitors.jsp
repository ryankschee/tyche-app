<div id="das_portlet_summary_visitors" class="ibox float-e-margins">
    <div id="das_portlet_summary_visitors_header" class="ibox-title" style="padding-left:10px; padding-right:10px;">
        <h5>
        	PWS <span id="das_portlet_summary_visitors_subtitle" class="small"></span>
        </h5>
        <div class="ibox-tools open">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">
	            <i class="fa fa-filter"></i>
	        </a>
	        <ul class="dropdown-menu dropdown-user">
	            <li>
	            	<a href="#" onclick="das_portlet_summary_visitors_timeSwitcher('das_portlet_summary_visitors_timeframe_today');">Today</a>
	            </li>
	            <li>
	            	<a href="#" onclick="das_portlet_summary_visitors_timeSwitcher('das_portlet_summary_visitors_timeframe_thisWeek');">This Week</a>
	            </li>
	            <li>
	            	<a href="#" onclick="das_portlet_summary_visitors_timeSwitcher('das_portlet_summary_visitors_timeframe_thisMonth');">This Month</a>
	            </li>
	        </ul>	        
	    </div>
    </div>
    <div id="das_portlet_summary_visitors_header" class="ibox-content" style="height:100%; padding-left:10px; padding-right:10px;">
        <h1 class="no-margins">0</h1>
        <br/>
        <div class="stat-percent font-bold text-navy">44% <i class="fa fa-level-up"></i></div>
        <small>New visits</small>
    </div>
    <div id="das_portlet_summary_visitors_spinner" class="ibox-content" style="height:90px; display:none;">
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

var das_portlet_summary_visitors_initialized            = false;

var DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_TODAY        = 'das_portlet_summary_visitors_timeframe_today';
var DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_THISWEEK     = 'das_portlet_summary_visitors_timeframe_thisWeek';
var DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_THISMONTH    = 'das_portlet_summary_visitors_timeframe_thisMonth';

/**
 * Init variables / states / components. 
 */
function das_portlet_summary_visitors_init()
{
    if (das_portlet_summary_visitors_initialized==true)
        return false;
        
    das_portlet_summary_visitors_initialized = true;
} // .end of das_portlet_summary_visitors_init

/**
 * Update UI.
 */
function das_portlet_summary_visitors_updateUI()
{
    // Init segment
    das_portlet_summary_visitors_init();
    // Default set to TODAY
    das_portlet_summary_visitors_timeSwitcher(DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_TODAY);
    // Show segment
    $('#das_portlet_summary_visitors').show();
} // .end of das_portlet_summary_visitors_updateUI

/**
 * In response to user selection on timeframe, for sales boxlet
 *
 * @param {String} timeframe - timeframe option.
 */
function das_portlet_summary_visitors_timeSwitcher(timeframe)
{
    var thisBegin;
    var thisEnd;
    var lastBegin;
    var lastEnd;
    var comparedTo = '';

    if (timeframe == DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_TODAY)
    {
    	// Set small title
    	$('#das_portlet_summary_visitors_subtitle').html(' (TODAY)');
        
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
    if (timeframe == DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_THISWEEK)
    {
    	// Set small title
    	$('#das_portlet_summary_visitors_subtitle').html(' (THIS WEEK)');
        
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
    
    if (timeframe == DAS_PORTLET_SUMMARY_VISITORS_TIMEFRAME_THISMONTH)
    {
    	// Set small title
    	$('#das_portlet_summary_visitors_subtitle').html(' (THIS MONTH)');
        
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
} // .end of das_portlet_summary_visitors_timeSwitcher

</script>