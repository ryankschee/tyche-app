<div id="das_portlet_calendar_timeline" class="ibox float-e-margins">
    <div class="ibox-title">
        <h5><i class="fa fa-calendar" aria-hidden="true"></i> My Calendar</h5>
        <div class="ibox-tools">
            <a class="collapse-link">
                <i class="fa fa-chevron-up"></i>
            </a>
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="fa fa-wrench"></i>
            </a>
            <ul id="das_portlet_calendar_timeline_selection" class="dropdown-menu dropdown-user">
            </ul>
        </div>
    </div>
    <div id="das_portlet_calendar_timeline_summary" class="ibox-content ibox-heading">
    </div>
    <div id="das_portlet_calendar_timeline_listview" class="ibox-content inspinia-timeline">
    </div>
    <div id="das_portlet_calendar_timeline_spinner" class="ibox-content" style="height:90px; display:none;">
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

var das_portlet_calendar_timeline_initialized = false;

/**
 * Init variables / states / components. 
 */
function das_portlet_calendar_timeline_init()
{
    if (das_portlet_calendar_timeline_initialized==true)
        return false;
        
    das_portlet_calendar_timeline_initialized = true;
} // .end of das_portlet_calendar_timeline_init

/**
 * UI Setup for Calendar panel.
 */
function das_portlet_calendar_updateUI()
{
    // Init, if any
    das_portlet_calendar_timeline_init();
    // Clear timeline list
    $('#das_portlet_calendar_timeline_selection').empty();
    $('#das_portlet_calendar_timeline_listview').empty();
    // Hide/Show
    $('#das_portlet_calendar_timeline_summary').hide();
    $('#das_portlet_calendar_timeline_listview').hide();
    $('#das_portlet_calendar_timeline_spinner').show();
    
    // Create today object
    var today = new Date();
    // Current Place object & User object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userObj = tycheesCommon_getCurrentUserObject();
    
    // Populate available calendar from PlaceObj & UserObj
    var horizontalBreakLine = '<hr style="margin: 2px 0px 2px 0px;"/>';
    var allCalendar = "<li><span onclick='das_portlet_calendar_updateTimeline(\''all\'')'>All Calendars</span></li>";
    var customerDobCalendar = "<li><span onclick='das_portlet_calendar_updateTimeline(\''dob\'')'>Date of Birth</span></li>";
    var billingCalendar = "<li><span onclick='das_portlet_calendar_updateTimeline(\''billing\'')'>All Calendars</span></li>";
    
    $('#das_portlet_calendar_timeline_selection').append(allCalendar);
    $('#das_portlet_calendar_timeline_selection').append(horizontalBreakLine);
    $('#das_portlet_calendar_timeline_selection').append(customerDobCalendar);
    $('#das_portlet_calendar_timeline_selection').append(billingCalendar);
    $('#das_portlet_calendar_timeline_selection').append(horizontalBreakLine);

    // Populate Selected Calendars
    $.each(placeObj.calendarList, function(i, calendarObj) {
        
        var htmlLines = '';
        htmlLines += '<li>';
        htmlLines += '<span onclick="das_portlet_calendar_updateTimeline(\'' + calendarObj.id + '\')">' + calendarObj.calendarName + '</span>';
        htmlLines += '</li>';
        
        $('#das_portlet_calendar_timeline_selection').append(htmlLines);
    });
    $('#das_portlet_calendar_timeline_selection').append(horizontalBreakLine);
    
    $.each(userObj.calendarList, function(i, calendarObj) {
    
        var htmlLines = '';
        htmlLines += '<li>';
        htmlLines += '<span onclick="das_portlet_calendar_updateTimeline(\'' + calendarObj.id + '\')">' + calendarObj.calendarName + '</span>';
        htmlLines += '</li>';
        
        $('#das_portlet_calendar_timeline_selection').append(htmlLines);
    });    

    das_portlet_calendar_updateTimeline('all');
    // Show segment
    $('#das_portlet_calendar_timeline').show();
} // .end of das_portlet_calendar_updateUI

/**
 * Update portlet 'Calendar'.
 *
 * @param {String} calendarId - Calendar ID or 'all'/'dob'/'billing'
 */
function das_portlet_calendar_updateTimeline(calendarId)
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
    
    // Place's event
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
                        das_portlet_calendar_addEventAsTimeline(eventObj);
                    }
                });
            }
        });
    }
    
    // User's event
    if (calendarId == 'all' || showIndividualCalendar == true) 
    {
        $.each(userObj.calendarList, function(i, calendarObj) {
        
            if (calendarId == 'all' || calendarId == calendarObj.id)
            {
                // Add calendar events into UI
                $.each(calendarObj.eventList, function(j, eventObj) {
                    if (tycheesDateTime_isSameDay(today, new Date(eventObj.start)))
                    {
                        das_portlet_calendar_addEventAsTimeline(eventObj);
                        personalEventCount++;
                    }
                });
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
                das_portlet_calendar_addCustomerAsTimeline(customerObj);
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
                        das_portlet_calendar_addEventAsTimeline(eventObj);
                    }
                });
            });
        });
    }
    
    var messageHeader = '';
    if (personalEventCount <= 1)
        messageHeader = 'You have ' + personalEventCount + ' event today!';
    else
        messageHeader = 'You have ' + personalEventCount + ' events today!';

    var htmlLines = '';
    htmlLines += '<h3>' + messageHeader + '</h3>';
    htmlLines += '<small>';
    htmlLines += '<i class="fa fa-map-marker"></i> Check your schedule to see detail.';
    htmlLines += '</small>';
    
    $('#das_portlet_calendar_timeline_summary').empty();
    $('#das_portlet_calendar_timeline_summary').append(htmlLines);
    
    // Hide/Show
    $('#das_portlet_calendar_timeline_summary').show();
    $('#das_portlet_calendar_timeline_listview').show();
    $('#das_portlet_calendar_timeline_spinner').hide();
} // .end of das_portlet_calendar_updateTimeline

function das_portlet_calendar_addEventAsTimeline(eventObj)
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
    
    $('#das_portlet_calendar_timeline_listview').append(htmlLines);
} // .end of das_portlet_calendar_addEventAsTimeline

function das_portlet_calendar_addCustomerAsTimeline(customerObj)
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
    
    $('#das_portlet_calendar_timeline_listview').append(htmlLines);
} // .end of das_portlet_calendar_addCustomerAsTimeline

</script>