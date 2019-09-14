function module_initApp() {
    console.log('[module_initApp] - BEGIN 3');

    // Init header
    tycheesCommon_loadUI_header();
    // Init sidebar
    tycheesCommon_loadUI_sidebar();
    // Call function in inventory-item-main.jsp
    loadUI_custom();
    // Init language pack
    tycheesCommon_initI18N();
    // Stop page loading indicator
    tycheesOverlay_stopShortProgress();
    tycheesOverlay_stopLongProgress();
    // Call to update UI
    cal001_updateUI();

	// Post Init
	tycheesCommon_onModulePostInit();
	
    console.log('[module_initApp] - END');
} // .end of initApp

function onTransactionCompleted(returnArray, actionName) {
    tycheesLogger_logInfo('onTransactionCompleted', 'BEGIN');
    tycheesLogger_logInfo('onTransactionCompleted', 'END');
} // .end of onTransactionCompleted

/**
 * Call to save data in IDB, to remote DB immediately.
 */
function module_sync() {
    //tycheesdb_syncDatabaseNow(APP_NAME_CALENDAR);
} // .end of module_sync

function module_showModalWindow(selectorId, stickToTop) {
    // Show Modal Window
    $('#' + selectorId).modal({
        backdrop: 'static',
        keyboard: false
    });
    // Move Modal Window to top of browser window
    if (stickToTop)
        $($('#' + selectorId).children()[0]).css('margin-top', '10px');
} // .end of module_showModalWindow

/**
 * Init Panel
 */
function cal001_init() {
    if (cal001_initialized == true)
        return false;

    $('#external-events div.external-event').each(function() {

        // store data so the calendar knows to render an event upon drop
        $(this).data('event', {
            title: $.trim($(this).text()), // use the element's text as the event title
            stick: true // maintain when user navigates (see docs on the renderEvent method)
        });

        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 1111999,
            revert: true, // will cause the event to go back to its
            revertDuration: 0 //  original position after the drag
        });
    });


    /* initialize the calendar
     * Documentation: http://arshaw.com/fullcalendar/
     -----------------------------------------------------------------*/
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#cal001_calendar').fullCalendar({
        header: {
            left: 'prev, next today',
            center: 'title',
            right: 'month, agendaWeek, agendaDay'
        },
        editable: true,
        droppable: true, // this allows things to be dropped onto the calendar
        drop: function() {
            // Doc Ref: https://fullcalendar.io/docs/dropping/drop/
            // is the "remove after drop" checkbox checked?
            if ($('#drop-remove').is(':checked')) {
                // if so, remove the element from the "Draggable Events" list
                $(this).remove();
            }
        },
        dayClick: function(date, jsEvent, view) {
            // Doc Ref: https://fullcalendar.io/docs/mouse/dayClick/
            //alert('Clicked on: ' + date.format());
            //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
            //alert('Current view: ' + view.name);

            // change the day's background color just for fun
            //$(this).css('background-color', 'red');

            cal001_mw004_show(date);
        },
        eventClick: function(event, jsEvent, view) {
            // Doc Ref: https://fullcalendar.io/docs/mouse/eventClick/
            //alert('Event: ' + event.title);
            //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
            //alert('View: ' + view.name);

            // change the border color just for fun
            //$(this).css('border-color', 'red');

            cal001_mw005_show(event);
        },
        eventRender: function(event, element, view) {
            var eventStartDate = new Date(event.start);
            var viewStartDate = new Date(view.start);

            // Hide not-this-month events from showing
            if (eventStartDate.getMonth() != viewStartDate.getMonth()) {
                //return false; 
            }
            // handle awesome icon
            //   To get asterisk icon class: 'fa fa-asterisk'
            //   howto: add event.icon = 'asterisk' 
            if (event.icon) {
                element.find(".fc-title").prepend("<i class='fa fa-" + event.icon + "'></i>");
            }
        },
        eventMouseover: function(event, element, view) {

            var selectedCalendarObj;
            var placeObj = tycheesCommon_getCurrentPlaceObject();
            var userObj = Cached_getUserById(tycheesCommon_getCurrentUserId());
            $.each(placeObj.calendarList, function(i, calendarObj) {
                $.each(calendarObj.eventList, function(j, eventObj) {
                    if (eventObj.id == event.id)
                        selectedCalendarObj = calendarObj;
                });
            });
            if (selectedCalendarObj == null) {
                $.each(userObj.calendarList, function(i, calendarObj) {
                    $.each(calendarObj.eventList, function(j, eventObj) {
                        if (eventObj.id == event.id)
                            selectedCalendarObj = calendarObj;
                    });
                });
            }

            var tooltip = '';
            tooltip += '<div class="tooltiptopicevent" style="width:auto;height:auto;background:#feb811;position:absolute;z-index:10001;padding:10px 10px 10px 10px ;  line-height: 200%;">';
            if (selectedCalendarObj != null)
                tooltip += '<span style="font-weight:bold;">Calendar:</span> ' + selectedCalendarObj.calendarName + '</br>';
            tooltip += '<span style="font-weight:bold;">Event:</span> ' + '<i class="fa fa-' + event.icon + '"></i>' + event.title + '</br>';
            if (event.allDay == true)
                tooltip += '<span style="font-weight:bold;">All Day:</span> ' + tycheesDateTime_getFormattedDate_ddMMyyyy(event.start) + '</br>';
            else
                tooltip += '<span style="font-weight:bold;">Start Time:</span> ' + tycheesDateTime_getFormattedDate_ddMMyyyy(event.start) + ' ' + tycheesDateTime_getFormattedDate_hhmm(event.start) + '</br>';
            tooltip += '</div>';

            $("body").append(tooltip);
            $(this).mouseover(function(e) {
                $(this).css('z-index', 10000);
                $('.tooltiptopicevent').fadeIn('500');
                $('.tooltiptopicevent').fadeTo('10', 1.9);
            }).mousemove(function(e) {
                $('.tooltiptopicevent').css('top', e.pageY + 10);
                $('.tooltiptopicevent').css('left', e.pageX + 20);
            });
        },
        eventMouseout: function(event, element, view) {
            $(this).css('z-index', 8);

            $('.tooltiptopicevent').remove();
        },
        //dayClick: function () {
        //    tooltip.hide()
        //},
        eventResizeStart: function() {
            tooltip.hide()
        },
        eventDragStart: function() {
            tooltip.hide()
        },
        viewDisplay: function() {
            tooltip.hide()
        },
        events: []
    });

    cal001_initialized = true;
} // .end of cal001_init

/**
 * Show Panel
 */
function cal001_updateUI() {
    cal001_init();

    // Remove all event objects from Calendar
    $('#cal001_calendar').fullCalendar('removeEvents');

    // Update calendar list
    cal001_updateUI_calendarList();
    // Update event objects into Calendar
    cal001_updateUI_calendarEvents();

    // Set Default View
    // Ref Doc: https://fullcalendar.io/docs/views/changeView/
    $('#cal001_calendar').fullCalendar('changeView', 'month');
    // Load calendar to TODAY
    $('#cal001_calendar').fullCalendar('today');
} // .end of cal001_updateUI

function cal001_updateUI_calendarList() {
    // Current Place object & User object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userObj = tycheesCommon_getCurrentUserObject();

    // Populate Selected Calendars
    $('#cal001_placeCalendarList').empty();
    $.each(placeObj.calendarList, function(i, calendarObj) {

        // Set showing state of Calendar object
        var htmlLines_checked = 'checked="false"';
        if (calendarObj.showing == true)
            htmlLines_checked = 'checked=""';

        var htmlLines = '';
        htmlLines += '<p class="gray-bg" style="margin-bottom:3px;padding:4px 2px 4px 36px;">';
        htmlLines += '<input id="' + calendarObj.id + '" type="checkbox" class="i-checks" ' + htmlLines_checked + '>';
        htmlLines += '<label for="' + calendarObj.id + '" style="font-style:normal; font-weight:400; padding: 0px 10px 2px 10px;margin-bottom:0px;">';
        htmlLines += calendarObj.calendarName;
        htmlLines += '</label>';
        htmlLines += '</p>';
        $('#cal001_placeCalendarList').append(htmlLines);

        // Init iCheck
        $('#' + calendarObj.id).iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });
        // Set event handlers
        $('#' + calendarObj.id).on('ifChecked', function(event) {
            tycheesOverlay_startShortProgress('reloading calendars...');
            cal001_toggleCalendar(calendarObj.id, true);
            cal001_updateUI_calendarEvents();
            tycheesOverlay_stopShortProgress();
        });
        $('#' + calendarObj.id).on('ifUnchecked', function(event) {
            tycheesOverlay_startShortProgress('reloading calendars...');
            cal001_toggleCalendar(calendarObj.id, false);
            cal001_updateUI_calendarEvents();
            tycheesOverlay_stopShortProgress();
        });
    });

    $('#cal001_userCalendarList').empty();
    $.each(userObj.calendarList, function(i, calendarObj) {

        // Set showing state of Calendar object
        var htmlLines_checked = 'checked="false"';
        if (calendarObj.showing == true)
            htmlLines_checked = 'checked=""';

        var htmlLines = '';
        htmlLines += '<p class="gray-bg" style="margin-bottom:3px;padding:4px 2px 4px 36px;">';
        htmlLines += '<input id="' + calendarObj.id + '" type="checkbox" class="i-checks" ' + htmlLines_checked + '>';
        htmlLines += '<label for="' + calendarObj.id + '" style="font-style:normal; font-weight:400; padding: 0px 10px 2px 10px;margin-bottom:0px;">';
        htmlLines += calendarObj.calendarName;
        htmlLines += '</label>';
        //htmlLines += '<span style="padding: 0px 10px 2px 10px;margin-bottom:0px; background-color:#1ab394;" class="button btn-xs">event</span>';
        htmlLines += '<span class="pull-right" style="padding:0px 10px 5px 5px; cursor:pointer;">';
        htmlLines += '<i class="fa fa-times" aria-hidden="true" onclick="cal001_mw003_show(\'' + calendarObj.id + '\',\'user\');"></i> ';
        htmlLines += '</span>';
        htmlLines += '<span class="pull-right" style="padding:0px 5px 5px 5px; cursor:pointer;">';
        htmlLines += '<i class="fa fa-pencil" aria-hidden="true" onclick="cal001_mw002_show(\'' + calendarObj.id + '\',\'user\');"></i> ';
        htmlLines += '</span>';
        htmlLines += '</p>';
        $('#cal001_userCalendarList').append(htmlLines);

        // Init iCheck
        $('#' + calendarObj.id).iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });
        // Set event handlers
        $('#' + calendarObj.id).on('ifChecked', function(event) {
            tycheesOverlay_startShortProgress('reloading calendars...');
            cal001_toggleCalendar(calendarObj.id, true);
            cal001_updateUI_calendarEvents();
            tycheesOverlay_stopShortProgress();
        });
        $('#' + calendarObj.id).on('ifUnchecked', function(event) {
            tycheesOverlay_startShortProgress('reloading calendars...');
            cal001_toggleCalendar(calendarObj.id, false);
            cal001_updateUI_calendarEvents();
            tycheesOverlay_stopShortProgress();
        });
    });

    // Update count
    $('#cal001_myCalendars_count').html(userObj.calendarList.length);
} // .end of cal001_updateUI_calendarList

function cal001_updateUI_calendarEvents() {
    // Current Place object & User object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userObj = tycheesCommon_getCurrentUserObject();

    // Remove all event objects from Calendar
    $('#cal001_calendar').fullCalendar('removeEvents');

    // Populate Selected Calendars
    $.each(placeObj.calendarList, function(i, calendarObj) {

        // If calendar is unchecked, then continue to skip current object.
        if (calendarObj.showing == false)
            return true;

        // Add calendar events into UI
        $.each(calendarObj.eventList, function(j, eventObj) {
            cal001_addEvent(eventObj);
        });
    });

    $.each(userObj.calendarList, function(i, calendarObj) {

        // If calendar is unchecked, then continue to skip current object.
        if (calendarObj.showing == false)
            return true;

        // Add calendar events into UI
        $.each(calendarObj.eventList, function(j, eventObj) {
            cal001_addEvent(eventObj);
        });
    });

    // Add customer's DOB as calendar event
    var customerList = Cached_getCustomerList();
    $.each(customerList, function(i, customerObj) {
        cal001_addCustomerDobAsEvent(customerObj);
    });

    // Add billing calendar event
    var billingList = Cached_getBillingList();
    $.each(billingList, function(i, billingObj) {
        $.each(billingObj.calendarList, function(j, calendarObj) {
            cal001_addBillingCalendarAsEvent(calendarObj);
        });
    });

} // .end of cal001_updateUI_calendarEvents

function cal001_toggleCalendar(calendarId, showing) {
    // Current Place object & User object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var userObj = tycheesCommon_getCurrentUserObject();

    $.each(placeObj.calendarList, function(i, calendarObj) {
        if (calendarObj.id == calendarId) {
            calendarObj.showing = showing;
            calendarObj.hasChanged = true;
        }
    });
    $.each(userObj.calendarList, function(i, calendarObj) {
        if (calendarObj.id == calendarId) {
            calendarObj.showing = showing;
            calendarObj.hasChanged = true;
        }
    });

    tycheesIO_saveBean(placeObj);
    tycheesIO_saveBean(userObj);
} // .end of cal001_toggleCalendar

function cal001_addEvent(eventObj) {
    // Documentation: https://fullcalendar.io/docs/event_data/Event_Object/
    // Construct Event Object
    /*var event = {
        id: 1, 
        title: 'New event', 
        start:  new Date(),
        end: new Date(),
        allDay: false,
        url: 'www.google.com'
    };*/

    // Add Event Object
    $('#cal001_calendar').fullCalendar('renderEvent', eventObj, true);

} // .end of cal001_addEvent

/**
 * Add customer DOB as calendar event.
 * 
 * @param	{CustomerBean} customerObj - Customer Object.
 */
function cal001_addCustomerDobAsEvent(customerObj) {
    if (customerObj == null || customerObj.dob == null || customerObj.dob == 0)
        return false;

    for (var i = -1; i <= 1; i++) {
        var titleVal = ' ' + customerObj.firstName + ' ' + customerObj.lastName;

        var today = new Date(tycheesDateTime_getCurrentTimeInMillis());
        var dateVal = new Date(customerObj.dob);
        dateVal.setFullYear(today.getFullYear() + i);

        var urlVal = tycheesCommon_getModulePath(ModuleConstants.MODULE_RELATION)
        urlVal += '?' + AppConstants.PARAMETER_NAME_SUB_MODULE + '=' + ModuleConstants.MODULE_RELATION_SUB_CUSTOMER;
        urlVal += '&' + AppConstants.PARAMETER_NAME_CUSTOMER_ID + '=' + customerObj.id;

        // Documentation: https://fullcalendar.io/docs/event_data/Event_Object/
        // Construct Event Object
        var eventObj = {
            id: customerObj.id,
            title: titleVal,
            start: dateVal,
            end: dateVal,
            allDay: true,
            url: urlVal,
            color: '#428bca',
            backgroundColor: '#428bca',
            textColor: '#ffffff',
            icon: 'birthday-cake'
        };

        // Add Event Object
        $('#cal001_calendar').fullCalendar('renderEvent', eventObj, true);
    }
} // .end of cal001_addCustomerDobAsEvent

/**
 * Add Billing Calendar as calendar event.
 * 
 * @param	{CustomerBean} customerObj - Customer Object.
 */
function cal001_addBillingCalendarAsEvent(calendarObj) {
    if (calendarObj == null || calendarObj.eventList == null)
        return false;

    $.each(calendarObj.eventList, function(k, eventObj) {

        var billingObj = Cached_getBillingById(calendarObj.foreignId);

        var titleVal = ' ' + billingObj.billingNo + ': ' + eventObj.title;
        var dateStartVal = new Date(eventObj.start);
        var dateEndVal = new Date(eventObj.start);
        dateEndVal.setHours(dateStartVal.getHours() + 1);
        var urlVal = tycheesCommon_getModulePath(ModuleConstants.MODULE_BILLING) + '?' + 'openByBillingId' + '=' + calendarObj.foreignId;

        // Documentation: https://fullcalendar.io/docs/event_data/Event_Object/
        // Construct Event Object
        var eventObj = {
            id: eventObj.id,
            title: titleVal,
            start: dateStartVal,
            end: dateEndVal,
            allDay: false,
            url: urlVal,
            color: '#1ab394',
            backgroundColor: '#1ab394',
            textColor: '#ffffff',
            icon: 'bell-o'
        };

        // Add Event Object
        $('#cal001_calendar').fullCalendar('renderEvent', eventObj, true);
    });
} // .end of cal001_addCustomerDobAsEvent

function cal001_myCalendars_toggleList(element) {
    var nodeExpanded = false;
    if ($(element).hasClass('mycalendars-expanded'))
        nodeExpanded = true;

    if (nodeExpanded) {
        $(element).addClass('mycalendars-collapsed');
        $(element).removeClass('mycalendars-expanded');
        $(element).html('<i class="fa fa-plus-square-o" aria-hidden="true"></i>');
        $('#cal001_userCalendarList').hide();
    }
    else {
        $(element).addClass('mycalendars-expanded');
        $(element).removeClass('mycalendars-collapsed');
        $(element).html('<i class="fa fa-minus-square-o" aria-hidden="true"></i>');
        $('#cal001_userCalendarList').show();
    }
} // .end of cal001_myCalendars_toggleList
