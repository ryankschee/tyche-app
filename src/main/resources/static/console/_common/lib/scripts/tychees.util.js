function tycheesUtil_isFunction(functionToCheck) {
	var getType = {};
	return functionToCheck && getType.toString.call(functionToCheck) === '[object Function]';
} // .end of tycheesUtil_isFunction

/**
 * Ensure returning number is not null, null or NaN.
 * 
 * @param {String} varVal - number in text. 
 * @param {Number} decimalPoint - number of decimal point
 * @returns {String} formatted number in text.
 */
function tycheesUtil_getSafeNumber(varVal, decimalPoint) {
	var returningVal = 0;

	if (varVal == null || varVal == null || $.trim(varVal).length == 0) {
		returningVal = 0;
	}
	else {
		var numberVal = Number(varVal);

		if (isNaN(numberVal) == true)
			returningVal = 0;
		else
			returningVal = numberVal;
	}

	if (decimalPoint == null)
		return returningVal;
	else
		return Number(returningVal).toFixed(decimalPoint);
} // .end of tycheesUtil_getSafeNumber

/**
 * Ensure to return true/false (no null).
 * 
 * @param {String} varVal - boolean in text. 
 * @returns {Boolean} true/false
 */
function tycheesUtil_getSafeBoolean(varVal) {
	if (varVal == null || varVal == null || varVal == '') {
		return false;
	}
	else {
		if (varVal == '')
			return false;

		var upperCaseVal = varVal.toUpperCase();
		if (upperCaseVal == 'FALSE' || upperCaseVal == 'N' || upperCaseVal == 'NO')
			return false;
		else
		if (varVal == 0 || varVal == '0')
			return false;

		return true;
	}
} // .end of tycheesUtil_getSafeBoolean

/**
 * Get safe URL.
 * 
 * @param {String} varVal - URL in text. 
 * @returns {String} safe URL
 */
function tycheesUtil_getSafeURL(urlVal) {

	if (urlVal == null || urlVal == '') {
		return '#';
	}
	else
		return urlVal;
} // .end of tycheesUtil_getSafeURL

/**
 * Retrieve parameter from current URL string.
 * 
 * @param {String} name - Name of parameter
 * @returns {String} Value of parameter
 */
function tycheesUtil_getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		results = regex.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

/**
 * Set parameter into current URL string.
 * 
 * @param {String} name - Name of parameter
 * @param {String} value - Value for parameter
 */
function tycheesUtil_setParameterByName(name, value) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		results = regex.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
} // .end of tycheesUtil_setParameterByName

// .end of Text/URL processing

/**
 * Check if given 'val' is integer type. 
 * 
 * @param {String} val - Value to be checked.
 * @return {Boolean} true if 'val' is integer; otherwise false.
 */
function tycheesUtil_isInteger(val) {
	return val != "" && !isNaN(val) && Math.round(val) == val;
} // .end of tycheesUtil_isInteger

/**
 * Check if given 'val' is float/double type. 
 * 
 * @param {String} val - Value to be checked.
 * @return {Boolean} true if 'val' is float/double; otherwise false.
 */
function tycheesUtil_isFloat(val) {
	return val != "" && !isNaN(val) && Math.round(val) != val;
} // .end of tycheesUtil_isFloat

/**
 * Check if given 'val' is boolean type.
 * true 	-> Y, y, 1
 * false	-> N, n, 0
 * 
 * @param {String} val - Value to be checked.
 * @return {Boolean} true if 'val' has boolean value; otherwise false.
 */
function tycheesUtil_isBoolean(val) {
	if ($.trim(val) == 'Y')
		return true;
	if ($.trim(val) == 'y')
		return true;
	if ($.trim(val) == '1' || $.trim(val) == 1)
		return true;
	if ($.trim(val) == 'N')
		return true;
	if ($.trim(val) == 'n')
		return true;
	if ($.trim(val) == '0' || $.trim(val) == 0)
		return true;

	return false;
} // .end of tycheesUtil_isBoolean

/**
 * Get boolean value (true/false) of 'val'
 * true 	-> Y, y, 1, true
 * false	-> N, n, 0, false
 * 
 * @param {String} val - Value to get convert.
 * @returns {Boolean} true/false.
 */
function tycheesUtil_getBooleanValue(val) {
	if (val == 'Y' || val == 'y' || val == '1' || val == 1 || val == 'true' || val == true)
		return true;
	else
	if (val == 'N' || val == 'n' || val == '0' || val == 0 || val == 'false' || val == false)
		return false;
	else
		return false;
} // .end of tycheesUtil_getBooleanValue

/**
 * Get boolean as Yes/No.
 * 
 * @param {Boolean} boolVal - Boolean Value
 * @return {String} Yes/No
 */
function tycheesUtil_getYesNoFromBoolean(boolVal) {
	if (tycheesUtil_getBooleanValue(boolVal) == true)
		return 'Yes';

	return 'No';
} // .end of tycheesUtil_getYesNoFromBoolean

/**
 * Expect #XXXXXX, where X is range from 0-9 (48-57) or A-F (65-70)
 * 
 * @param {String} val - Color code.
 * @returns {Boolean} true/false.
 */
function tycheesUtil_isColorCode(val) {
	if ($.trim(val).length != 7)
		return false;

	if (val.startsWith('#') == false)
		return false;

	var validColorCode = true;
	for (var i = 1; i < 6; i++) {
		var charCode = val.toUpperCase().charCodeAt(i);

		var validNumber = false;
		if (charCode >= 48 && charCode <= 57)
			validNumber = true;

		var validCharacter = false;
		if (charCode >= 65 && charCode <= 70)
			validCharacter = true;

		if (validNumber == false && validCharacter == false) {
			validColorCode = false;
		}
	}

	return validColorCode;
} // .end of tycheesUtil_isColorCode


/******************************************************************************* 
 * Unit Converters
 ******************************************************************************/

/**
 * Convert degree value to radian value.
 * 
 * @param {Number} degrees - Degree value
 * @returns {Number} Radian value
 */
function tycheesUtil_degreeToRadian(degrees) {
	return degrees * (Math.PI / 180);
} // .end of tycheesUtil_degreeToRadian

/**
 * Convert radian value to degree value.
 * 
 * @param {Number} radians - radian Value
 * @returns {Number} Degree Value
 */
function tycheesUtil_radianToDegree(radians) {
	return radians * (180 / Math.PI);
} // .end of tycheesUtil_radianToDegree

// .end of Unit Converters

function tycheesUtil_fileExists(file_url) {
	var http = new XMLHttpRequest();
	http.open('HEAD', file_url, false);
	http.send();
	return http.status != 404;
} // .end of tycheesUtil_fileExists
