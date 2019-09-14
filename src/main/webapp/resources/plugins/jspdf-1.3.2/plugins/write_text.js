/*
 * Usage
 *
 * var doc = new jsPDF('p', 'pt', 'a4');
 * //Alignment based on page width
 * doc.writeText(0, 40 ,'align - center ', { align: 'center' });
 * doc.writeText(0, 80 ,'align - right ', { align: 'right' });
 * //Alignment based on text container width
 * doc.writeText(0, 120 ,'align - center : inside container',{align:'center',width:100});
*/
(function (api, $) {
'use strict';
api.writeText = function (x, y, text, options) {
    options = options || {};

    var defaults = {
        align: 'left',
        width: this.internal.pageSize.width
    }

    var settings = $.extend({}, defaults, options);

    // Get current font size
    var fontSize = this.internal.getFontSize();

    // Get the actual text's width
    /* You multiply the unit width of your string by your font size and divide
     * by the internal scale factor. The division is necessary
     * for the case where you use units other than 'pt' in the constructor
     * of jsPDF.
    */
    var txtWidth = this.getStringUnitWidth(text) * fontSize / this.internal.scaleFactor;

    if (settings.align === 'center')
        x += (settings.width - txtWidth) / 2;
    else if (settings.align === 'right')
        x += (settings.width - txtWidth);

    //default is 'left' alignment
    this.text(text, x, y);

}
})(jsPDF.API, jQuery);

