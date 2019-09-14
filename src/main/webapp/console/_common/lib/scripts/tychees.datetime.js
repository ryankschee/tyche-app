var tycheesDateTime_daysInMonth_normalYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var tycheesDateTime_daysInMonth_leapYear = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var tycheesDateTime_months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
var tycheesDateTime_fullMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];


/**
 * Get current time in milliseconds.
 * 
 * @returns {long} time in milliseconds
 */
function tycheesDateTime_getCurrentTimeInMillis() {
    var d = new Date();
    return d.getTime();
} // .end of tycheesDateTime_getCurrentTimeInMillis

/**
 * Convert UTC date to Local Date
 */
function tycheesDateTime_convertUTCDateToLocalDate(date) {
	var localDate = new Date(date.getTime());
    var offset = date.getTimezoneOffset() / 60;
    var hours = date.getHours();

    localDate.setHours(hours - offset);

    return localDate;   
} // .end of tycheesDateTime_convertUTCDateToLocalDate

/**
 * Date Formatter: printout is MMM dd, yyyy.
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} formatted date
 */
function tycheesDateTime_getFormattedDate_MMMddyyyy(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesDateTime_months[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear();
} // .end of tycheesDateTime_getFormattedDate_MMMddyyyy

/**
 * Date Formatter: printout is dd MMMM yyyy.
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} formatted date
 */
function tycheesDateTime_getFormattedDate_ddMMMMyyyy(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return date.getDate() + ' ' + tycheesDateTime_fullMonths[date.getMonth()] + ' ' + date.getFullYear();
} // .end of tycheesDateTime_getFormattedDate_ddMMMMyyyy

/**
 * Date Formatter: printout is MMyyyy. e.g. 102017
 * 
 * @param {long} milliseconds - date time in milliseconds (UTC)
 * @returns {string} formatted date
 */
function tycheesDateTime_getFormattedDate_MMyyyy(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesText_leftPad(date.getMonth() + 1, '0', 2) + tycheesText_leftPad(date.getFullYear(), '0', 4);
} // .end of tycheesDateTime_getFormattedDate_MMyyyy

/**
 * Date Formatter: printout is dd/MM/yyyy.
 * 
 * @param {long} milliseconds - date time in milliseconds (UTC)
 * @returns {string} formatted date
 */
function tycheesDateTime_getFormattedDate_ddMMyyyy(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesText_leftPad(date.getDate(), '0', 2) + '/' + tycheesText_leftPad(date.getMonth() + 1, '0', 2) + '/' + tycheesText_leftPad(date.getFullYear(), '0', 4);
} // .end of tycheesDateTime_getFormattedDate_ddMMyyyy

/**
 * Date Formatter: printout is MM/dd/yyyy.
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} formatted date
 */
function tycheesDateTime_getFormattedDate_MMddyyyy(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesText_leftPad(date.getMonth() + 1, '0', 2) + '/' + tycheesText_leftPad(date.getDate(), '0', 2) + '/' + tycheesText_leftPad(date.getFullYear(), '0', 4);
} // .end of tycheesDateTime_getFormattedDate_MMddyyyy

/**
 * Date Formatter: printout is yyyy/MM/dd.
 * 
 * @param {long} milliseconds - date time in milliseconds (UTC)
 * @returns {string} formatted date
 */
function tycheesDateTime_getFormattedDate_yyyyMMdd(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesText_leftPad(date.getFullYear(), '0', 4) + '/' + tycheesText_leftPad(date.getMonth() + 1, '0', 2) + '/' + tycheesText_leftPad(date.getDate(), '0', 2);
} // .end of tycheesDateTime_getFormattedDate_yyyyMMdd

/**
 * Date Formatter: printout is hh:mm:ss
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} formatted time
 */
function tycheesDateTime_getFormattedDate_hhmmss(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesText_leftPad(date.getHours(), '0', 2) + ':' + tycheesText_leftPad(date.getMinutes(), '0', 2) + ':' + tycheesText_leftPad(date.getSeconds(), '0', 2);
} // .end of tycheesDateTime_getFormattedDate_hhmmss

/**
 * Date Formatter: printout is hh:mm
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} formatted time
 */
function tycheesDateTime_getFormattedDate_hhmm(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return tycheesText_leftPad(date.getHours(), '0', 2) + ':' + tycheesText_leftPad(date.getMinutes(), '0', 2);
} // .end of tycheesDateTime_getFormattedDate_hhmm

/**
 * Date Formatter: printout is hh:mm MMM dd, yyyy.
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} formatted date/time
 */
function tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss(milliseconds) {
    if (milliseconds == null)
        return '';
    return tycheesDateTime_getFormattedDate_MMMddyyyy(milliseconds) + " " + tycheesDateTime_getFormattedDate_hhmmss(milliseconds);
} // .end of tycheesDateTime_getFormattedDate_MMMddyyyy_hhmmss

/**
 * Return 'am' or 'pm' of given time.
 * 
 * @param {long} milliseconds - date time in milliseconds
 * @returns {string} am/pm
 */
function tycheesDateTime_getAmPm(milliseconds) {
    if (milliseconds == null)
        return '';
    var date = new Date(milliseconds);
    return date.getHours() >= 12 ? "pm" : "am";
} // .end of tycheesDateTime_getAmPm

/**
 * Check if given year is leap year.
 * 
 * @param {int} year - Year in integer
 * @returns {boolean} true if leap year; otherwise false.
 */
function tycheesDateTime_isLeapYear(year) {
    if (isNaN(year))
        return false;

    var remainder = year % 4;
    if (remainder == 0)
        return true;
    else
        return false;
} // .end of tycheesDateTime_isLeapYear

/**
 * Date Converter: MM/dd/yyyy to millisecond
 * 
 * @param {string} dateStr - Date in string (MM/dd/yyyy)
 * @returns {long} date in milliseconds
 */
function tycheesDateTime_toMilliseconds_MMddyyyy(dateStr) {
    if (dateStr == null || dateStr.length == 0)
        return 0;

    if (dateStr.length != 10)
        return 0;

    if (dateStr.charAt(2) != '/' || dateStr.charAt(5) != '/')
        return 0;

    var month = Number(dateStr.substring(0, 2));
    var day = Number(dateStr.substring(3, 5));
    var year = Number(dateStr.substring(6, 10));

    if (isNaN(month) || isNaN(day) || isNaN(year))
        return 0;

    var dateObj = new Date(year, month, day, 0, 0, 0, 0);

    return dateObj.getTime();
} // .end of tycheesDateTime_toMilliseconds_MMddyyyy

/**
 * Date Converter: dd/MM/yyyy
 * 
 * @param {string} dateStr - Date in string (dd/MM/yyyy)
 * @returns {long} date in milliseconds
 */
function tycheesDateTime_toMilliseconds_ddMMyyyy(dateStr) {
    // VALIDATION
    if (tycheesDateTime_isValidDate_ddmmyyyy(dateStr) == false)
        return 0;

    var day = Number(dateStr.substring(0, 2));
    var month = Number(dateStr.substring(3, 5));
    var year = Number(dateStr.substring(6, 10));

    var dateObj = new Date(year, month - 1, day, 12, 0, 0, 0);

    return dateObj.getTime();
} // .end of tycheesDateTime_toMilliseconds_ddMMyyyy

/**
 * Time Converter: hh:mm
 * 
 * @param {string} timeStr - Date in string (hh:mm)
 * @returns {long} date in milliseconds
 */
function tycheesDateTime_toMilliseconds_hhmm(timeStr) {
    // VALIDATION
    if (tycheesDateTime_isValidTime_hhmm(timeStr) == false)
        return 0;

    var hour = Number(timeStr.substring(0, 2));
    var minute = Number(timeStr.substring(3, 5));

    var today = new Date();
    var dateObj = new Date(today.getFullYear(), today.getMonth(), today.getDate(), hour, minute, 0, 0);

    return dateObj.getTime();
} // .end of tycheesDateTime_toMilliseconds_hhmm

/**
 * Date Converter: dd/MM/yyyy hh:mm
 * 
 * @param {string} dateStr - Date in string (dd/MM/yyyy)
 * @param {string} timeStr - Date in string (hh:mm)
 * @returns {long} date in milliseconds
 */
function tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(dateStr, timeStr) {
    // VALIDATION
    if (tycheesDateTime_isValidDate_ddmmyyyy(dateStr) == false)
        return null;
    if (tycheesDateTime_isValidTime_hhmm(timeStr) == false)
    	timeStr = '12:00';

    // 1. Process date
    var day = Number(dateStr.substring(0, 2));
    var month = Number(dateStr.substring(3, 5));
    var year = Number(dateStr.substring(6, 10));

    // 2. Process time
    var hour = Number(timeStr.substring(0, 2));
    var minute = Number(timeStr.substring(3, 5));

    // 3. Combine
    var dateObj = new Date(year, month - 1, day, hour, minute, 0, 0);

    return dateObj.getTime();
} // .end of tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm

/**
 * Check if dateStr in format dd/mm/yyyy.
 * 
 * @param {string} dateStr - Date in string
 * @returns {boolean} true if match format; otherwise false.
 */
function tycheesDateTime_isValidDate_ddmmyyyy(dateStr) {
    if ($.trim(dateStr) == '')
        return false;

    if (dateStr.length != 10)
        return false;

    if (dateStr.charAt(2) != '/' || dateStr.charAt(5) != '/')
        return false;

    var day = Number(dateStr.substring(0, 2));
    var month = Number(dateStr.substring(3, 5));
    var year = Number(dateStr.substring(6, 10));

    if (isNaN(month) || isNaN(day) || isNaN(year))
        return false;

    if (month < 1 || month > 12)
        return false;

    if (tycheesDateTime_isLeapYear(year) == true) {
        if (day < 1 || day > tycheesDateTime_daysInMonth_leapYear[month - 1])
            return false;
    }
    else {
        if (day < 1 || day > tycheesDateTime_daysInMonth_normalYear[month - 1])
            return false;
    }

    return true;
} // .end of tycheesDateTime_isValidDate_ddmmyyyy

/**
 * Check if timeStr in format hh:mm.
 * 
 * @param {string} timeStr - Time in string
 * @returns {boolean} true if match format; otherwise false.
 */
function tycheesDateTime_isValidTime_hhmm(timeStr) {
    if ($.trim(timeStr) == '')
        return false;

    if (timeStr.length != 5)
        return false;

    if (timeStr.charAt(2) != ':')
        return false;

    var hour = Number(timeStr.substring(0, 2));
    var minute = Number(timeStr.substring(3, 5));

    if (isNaN(hour) || isNaN(minute))
        return false;

    if (hour < 1 || hour > 24)
        return false;

    if (minute < 0 || minute > 59)
        return false;

    return true;
} // .end of tycheesDateTime_isValidTime_hhmm

/**
 * Get days difference in between day start and day end.
 * 
 * @param {long} dayStart - day start in milliseconds
 * @param {long} dayEnd - day end in milliseconds
 * @returns {int} day differences.
 */
function tycheesDateTime_getDaysInBetween(dayStart, dayEnd) {
    if (isNaN(dayStart) || isNaN(dayEnd))
        return 0;

    var diffMillis = dayEnd - dayStart;

    return Math.round(diffMillis / (24 * 60 * 60 * 1000));
} // .end of tycheesDateTime_getDaysInBetween

/**
 * Get hours difference in between time start and time end.
 * 
 * @param {long} timeStart - time start in milliseconds
 * @param {long} timeEnd - time end in milliseconds
 * @returns {int} hour differences.
 */
function tycheesDateTime_getHoursInBetween(timeStart, timeEnd) {
    if (isNaN(timeStart) || isNaN(timeEnd))
        return 0;

    var diffMillis = timeEnd - timeStart;

    return Math.round(diffMillis / (60 * 60 * 1000));
} // .end of tycheesDateTime_getHoursInBetween

/**
 * Return true if day1 and day2 are in the same day, otherwise return false.
 * 
 * @param {Date} day1 - Date object of day 1.
 * @param {Date} day2 - Date object of day 2.
 * @returns {boolean} true if same day; otherwise false.
 */
function tycheesDateTime_isSameDay(day1, day2, ignoreYear) {
    if (day1 == null || day2 == null)
        return false;

    if (typeof day1 != 'object' || typeof day2 != 'object')
        return false;

    if (day1.getDate() != day2.getDate())
        return false;
    if (day1.getMonth() != day2.getMonth())
        return false;

    if (ignoreYear == null || ignoreYear == false) {
        if (day1.getFullYear() != day2.getFullYear())
            return false;
    }

    return true;
} // .end of tycheesDateTime_isSameDay
