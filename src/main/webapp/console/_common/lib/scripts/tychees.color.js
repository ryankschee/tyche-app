
/**
 * Input:	
 * Return:	#FFFFFF
 */
function tycheesColor_invertHEX(hex, bwMode) 
{
	if (hex.indexOf('#') === 0) {
        hex = hex.slice(1);
    }
    // convert 3-digit hex to 6-digits.
    if (hex.length === 3) {
        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
    }
    if (hex.length !== 6) {
        throw new Error('Invalid HEX color.');
    }
    var r = parseInt(hex.slice(0, 2), 16),
        g = parseInt(hex.slice(2, 4), 16),
        b = parseInt(hex.slice(4, 6), 16);
    
    if (bwMode) {
        // http://stackoverflow.com/a/3943023/112731
        return (r * 0.299 + g * 0.587 + b * 0.114) > 186
            ? '#000000'
            : '#FFFFFF';
    }
    // invert color components
    r = (255 - r).toString(16);
    g = (255 - g).toString(16);
    b = (255 - b).toString(16);
    // pad each with zeros and return
    return "#" + tycheesColor_padZero(r) + tycheesColor_padZero(g) + tycheesColor_padZero(b);
} // .end of tycheesColor_invertHEX

function tycheesColor_padZero(str, len) 
{
    len = len || 2;
    var zeros = new Array(len).join('0');
    return (zeros + str).slice(-len);
} // .end of tycheesColor_padZero

/**
 * Input:	#FFFFFF
 * Return:	{r:255, g:255, b:255}
 */
function tycheesColor_rgbToNumber(rgbInHEX) 
{
	if (rgbInHEX.indexOf('#') === 0) {
		rgbInHEX = rgbInHEX.slice(1);
    }
    // convert 3-digit hex to 6-digits.
    if (rgbInHEX.length === 3) {
    	rgbInHEX = rgbInHEX[0] + rgbInHEX[0] + rgbInHEX[1] + rgbInHEX[1] + rgbInHEX[2] + rgbInHEX[2];
    }
    
    var rgb = new Object();
    rgb.r = parseInt(rgbInHEX.slice(0, 2), 16);
    rgb.g = parseInt(rgbInHEX.slice(2, 4), 16);
    rgb.b = parseInt(rgbInHEX.slice(4, 6), 16);
	
    return rgb;	
} // .end of tycheesColor_rgbToNumber