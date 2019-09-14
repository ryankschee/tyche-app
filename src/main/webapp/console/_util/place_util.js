/**
 * Return default address of place; otherwise return empty String.
 * 
 * @param {Object} placeObj - PlaceBean object.
 * @returns {String} default address; otherwise return empty String.
 */
function placeUtil_getDefaultAddress(placeObj) {
    if (placeObj == null)
        return '';
    if (placeObj.addressList == null || placeObj.addressList.length == 0)
        return '';

    var defaultAddress = '';
    $.each(placeObj.addressList, function(i, addressObj) {
        if (addressObj.type == AppConstants.CONTACT_TYPE_OFFICE && addressObj.defaultAddress == true) {
            defaultAddress = tycheesBean_toString_commonAddressBean(addressObj);
            return false;
        }
    });

    return $.trim(defaultAddress);
} // .end of placeUtil_getDefaultAddress

/**
 * Return default contact of place; otherwise return empty String.
 * 
 * @param {Object} placeObj - PlaceBean object.
 * @param {String} contactType - AppConstants.CONTACT_TYPE_XXX
 * @returns {String} default contact; otherwise return empty String.
 */
function placeUtil_getDefaultContact(placeObj, contactType) {
    if (placeObj == null)
        return '';
    if (placeObj.addressList == null || placeObj.addressList.length == 0)
        return '';

    var defaultContact = '';
    $.each(placeObj.contactList, function(i, contactObj) {
        if (contactType == AppConstants.CONTACT_TYPE_OFFICE && contactObj.defaultContact == true) {
            defaultContact = tycheesBean_toString_commonContactBean(contactObj);
            return false;
        }

        if (contactType == AppConstants.CONTACT_TYPE_MOBILE && contactObj.defaultContact == true) {
            defaultContact = tycheesBean_toString_commonContactBean(contactObj);
            return false;
        }
    });

    return $.trim(defaultContact);
} // .end of placeUtil_getDefaultContact

/**
 * Return image object with default company logo; otherwise return null.
 * 
 * @param {Object} placeObj - PlaceBean object
 * @returns {Object} PlaceImageBean object
 */
function placeUtil_getDefaultCompanyLogoImage(placeObj) {
    if (placeObj == null)
        return null;
    if (placeObj.imageList == null || placeObj.imageList.length == 0)
        return null;

    var companyLogoImage;
    $.each(placeObj.imageList, function(i, imageObj) {
        if (imageObj.typeLogo) {
            companyLogoImage = imageObj;
            return false;
        }
    });
    return companyLogoImage;
} // .end of placeUtil_getDefaultCompanyLogoImage
