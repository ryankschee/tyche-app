/**
 * Get safe list (no null)
 * 
 * @param {Array} list - list array
 * @returns {Array} safe list
 */
function tycheesList_getSafeList(list) {
	if (list == null)
		list = [];
	return list;
} // .end of tycheesList_getSafeList

/**
 * Util function for sorting: compare text
 *  
 * @param {string} aText - text 1
 * @param {string} bText - text 2
 * @returns {Number} 0 if same; 
 *                  -1 if aText smaller than bText; 
 *                   1 if aText greater than bText.
 */
function tycheesList_sortByString(aText, bText) {
	if (aText < bText)
		return -1;
	if (aText > bText)
		return 1;
	return 0;
} // .end of tycheesList_sortByString

/**
 * Util function for sorting: compare number
 * 
 * @param {Number} aNumber - number 1
 * @param {Number} bNumber - number 2
 * @returns {Number} 0 if same; 
 *                  -1 if aNumber smaller than bNumber; 
 *                   1 if aNumber greater than bNumber.
 */
function tycheesList_sortByNumber(aNumber, bNumber) {
	return aNumber - bNumber;
} // .end of tycheesList_sortByNumber
