/**
 * Check if current text is empty (null, null or no text).
 * 
 * @param {string} text - Text to be tested.
 * @returns {boolean} true if empty; otherwise false.
 */
function tycheesText_isEmptyText(text) {
    if (text === null || text === null)
        return true;

    var tmp_text = $.trim(text);
    if (tmp_text.length == 0)
        return true;
    else
        return false;
} // .end of tycheesText_isEmptyText

/**
 * Get index of val in string (delimited by comma)
 * e.g. val=a, listInString=t,2,def,ef,a,d -> return 4
 * 
 * @param {string} val - Value to find.
 * @param {string} listInString - string with list formatted (delimited by comma)
 * @returns {int} index of val; otherwise -1 if not found.
 */
function tycheesText_indexOf(val, listInString) {
    var position = -1;

    var list = listInString.split(',');
    $.each(list, function(i, element) {
        if ($.trim(element) == '')
            return true;

        if ($.trim(element) == val) {
            position = i;
            return false;
        }
    });

    return position;
} // .end of tycheesText_indexOf

/**
 * Pad 'character' to right side of 'text', in length 'length'.
 * 
 * @text {string} text - Text to be padded.
 * @character {string} character - Character to pad.
 * @length {int} length - Length of character to pad. 
 * @returns {string} Padded text.
 */
function tycheesText_rightPad(text, character, length) {
    var output = text + '';
    while (output.length < length) {
        output = output + character;
    }
    return output;
} // .end of tycheesText_rightPad

/**
 * Pad 'character' to left side of 'text', in length 'length'.
 * 
 * @text {string} text - Text to be padded.
 * @character {string} character - Character to pad.
 * @length {int} length - Length of character to pad. 
 * @returns {string} Padded text.
 */
function tycheesText_leftPad(text, character, length) {
    var output = text + '';
    while (output.length < length) {
        output = character + output;
    }
    return output;
} // .end of tycheesText_leftPad

/**
 * Replace all occurrence of 'character' in 'text', with 'replacement'. 
 * 
 * @param {string} text - Text to be searched.
 * @param {string} character - Character to be replaced.
 * @param {string} replacement - Replacement text.
 * @returns {string} text after replacement. 
 */
function tycheesText_replaceAll(text, character, replacement) {
    var str = text.split(character).join(replacement);
    return str;
} // .end of tycheesText_replaceAll

/**
 * Generate HTML selector ID.
 * 
 * @param {string} text00 - Text to be converted into Selector ID
 * @returns {string} selector ID
 */
function tycheesText_getSelectorIdFormat(text00) {
    // Note that \W is the equivalent of [^0-9a-zA-Z_] - it includes the underscore character. 
    return text00.replace(/\W/g, '');
} // .end of tycheesText_getSelectorIdFormat

/**
 * Remove all whitespace, and trim text.
 * 
 * @param {string} textVal - text value
 * @returns {string} formatted text
 */
function tycheesText_getSafeString_withoutSpace(textVal) {
    // The g character means to repeat the search through the entire string
    return tycheesText_getSafeString(textVal).replace(/ /g, '');
} // .end of tycheesText_getSafeString_withoutSpace

/**
 * Ensure returning string is not null or null.
 * 
 * @param {string} textVal - text value
 * @returns {string} trimmed text.
 */
function tycheesText_getSafeString(textVal) {
    return $.trim(textVal);
} // .end of tycheesText_getSafeString

/**
 * Get displayable text, with given textLimit.
 * 
 * @param {string} textVal - text
 * @param {int} textLimit - text limit length
 * @returns {string} displayable text
 */
function tycheesText_getDisplayText(textVal, textLimit) {
    if (textVal == null || $.trim(textVal).length == 0) {
        return '-';
    }
    else
    if (textLimit <= 0)
        return textVal;
    else
    if (textVal.length < textLimit) {
        return textVal;
    }
    else {
        return textVal.substring(0, textLimit) + "...";
    }
} // .end of tycheesText_getDisplayText

/**
 * Check if text starts with substr.
 * 
 * @param {string} textVal - text value.
 * @param {string} substr - substring
 * @returns {boolean} true if text starts with substring; otherwise false.
 */
function textStartsWith(textVal, substr) {
    var substr2 = textVal.substring(0, substr.length);

    if (substr == substr2)
        return true;
    else
        return false;
} // .end of textStartsWith

/**
 * Generate random string with length, in combination of chars.
 * a - lowercase alphabet
 * A - uppercase alphabet
 * # - number
 * ! - special characters
 * 
 * e.g. 
 * tycheesText_getRandomString(10, 'aA#!') = awY72d)#2u
 */
function tycheesText_getRandomString(length, chars) {
	if (chars == null)
		chars = 'aA#!';
	
    var mask = '';
    if (chars.indexOf('a') > -1) mask += 'abcdefghijklmnopqrstuvwxyz';
    if (chars.indexOf('A') > -1) mask += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (chars.indexOf('#') > -1) mask += '0123456789';
    if (chars.indexOf('!') > -1) mask += '~`!@#$%^&*()_+-={}[]:";\'<>?,./|\\';
    
    var result = '';
    for (var i = length; i > 0; --i) 
    	result += mask[Math.round(Math.random() * (mask.length - 1))];
    
    return result;
} // .end of tycheesText_getRandomString