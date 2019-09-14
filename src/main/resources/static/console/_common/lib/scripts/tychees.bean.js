

/**
 * get formatted string of CommonContactBean.
 * 
 * @param {CommonContactBean} contactObj - Contact object
 * @returns {String} formatted output.
 */
function tycheesBean_toString_commonContactBean(contactObj) {
	if (contactObj == null) {
		return '000-0000-0000';
	}
	else {
		var phone_htmlLines = '';

		if (contactObj.countryCode != null && $.trim(contactObj.countryCode).length > 0)
			phone_htmlLines += ('(+' + contactObj.countryCode + ') ');

		if (contactObj.areaCode != null && $.trim(contactObj.areaCode).length > 0)
			phone_htmlLines += (contactObj.areaCode + ' ');

		if (contactObj.phoneNumber != null && $.trim(contactObj.phoneNumber).length > 0)
			phone_htmlLines += (contactObj.phoneNumber);

		//if (contactObj.extension!=null && $.trim(contactObj.extension).length>0)
		//phone_htmlLines += ('ext:' + contactObj.extension);

		if ($.trim(phone_htmlLines).length == 0)
			phone_htmlLines = '000-0000-0000';

		return phone_htmlLines;
	}
} // .end of tycheesBean_toString_commonContactBean

/**
 * get formatted string of CommonAddressBean.
 * 
 * @param {CommonContactBean} contactObj - Contact object
 * @returns {String} formatted output.
 */
function tycheesBean_toString_commonAddressBean(addressObj) {
	if (addressObj == null) {
		return 'No Address';
	}
	else {
		var address_htmlLines = '';

		if (addressObj.streetLine1 != null && $.trim(addressObj.streetLine1).length > 0)
			address_htmlLines += ($.trim(addressObj.streetLine1).endsWith('.') ? $.trim(addressObj.streetLine1) + ' ' : $.trim(addressObj.streetLine1) + ', ');

		if (addressObj.streetLine2 != null && $.trim(addressObj.streetLine2).length > 0)
			address_htmlLines += ($.trim(addressObj.streetLine2).endsWith('.') ? $.trim(addressObj.streetLine2) + ' ' : $.trim(addressObj.streetLine2) + ', ');

		if (addressObj.streetLine3 != null && $.trim(addressObj.streetLine3).length > 0)
			address_htmlLines += ($.trim(addressObj.streetLine3).endsWith('.') ? $.trim(addressObj.streetLine3) + ' ' : $.trim(addressObj.streetLine3) + '. ');

		if (addressObj.postalCode != null && $.trim(addressObj.postalCode).length > 0)
			address_htmlLines += (addressObj.postalCode + ' ');

		if (addressObj.city != null && $.trim(addressObj.city).length > 0)
			address_htmlLines += (addressObj.city + ', ');

		if (addressObj.state != null && $.trim(addressObj.state).length > 0)
			address_htmlLines += (addressObj.state + ', ');

		if (addressObj.country != null && $.trim(addressObj.country).length > 0)
			address_htmlLines += (addressObj.country + '.');

		if ($.trim(address_htmlLines).length == 0)
			address_htmlLines = 'No Address';

		return address_htmlLines;
	}
} // .end of tycheesBean_toString_commonAddressBean

/**
 * dayIndex: 0-6
 * hourIndex: 0-23
 * minuteIndex: 0-59
 * --
 * Output: DDD, HH:MM.
 *    e.g: Mon, 21:30
 *    
 * @param {int} dayIndex - Day in index
 * @param {int} hourIndex - Hour in index
 * @param {int} minuteIndex - Minute in index
 * @returns {String} formatted output.
 */
function tycheesBean_toString_commonOperatingHour(dayIndex, hourIndex, minuteIndex) {
	if (dayIndex == null || dayIndex < 0 || dayIndex > 6 ||
		hourIndex == null || hourIndex < 0 || hourIndex > 23 ||
		minuteIndex == null || minuteIndex < 0 || minuteIndex > 59) {
		return 'Incorrect Day/Time Values';
	}
	else {
		var DAY = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

		var htmlLines = '';
		htmlLines += DAY[dayIndex];
		htmlLines += ', ';
		htmlLines += tycheesText_leftPad(hourIndex, '0', 2);
		htmlLines += ':';
		htmlLines += tycheesText_leftPad(minuteIndex, '0', 2);

		return htmlLines;
	}
} // .end of tycheesBean_toString_commonOperatingHour

/**
 * Get person's full name.
 * 
 * @param {Object} personObj - CommonPersonBean object
 * @returns {String} customer full name; otherwise empty string.
 */
function tycheesBean_person_getFullName(personObj) {
	if (personObj == null)
		return '';

	return $.trim($.trim(personObj.firstName) + ' ' + $.trim(personObj.lastName));
} // .end of tycheesBean_person_getFullName

function tycheesBean_customer_getDefaultContact(customerObj) {
	if (customerObj == null)
		return '';

	var contactObj;
	$.each(customerObj.contactList, function(i, contact) {
		if (contact.defaultContact) {
			contactObj = contact;
			return false;
		}
	});

	if (contactObj == null)
		return '';
	else
		return tycheesBean_toString_commonContactBean(contactObj);
} // .end of
