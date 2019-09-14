
/**
 * Calculate image's height, by ratio.
 * 
 * @param	{integer} originalWidth - Original width
 * @param	{integer} originalHeight - Origianl height
 * @param	{integer} currentWidth - Current width
 * @return	{integer} Current height, after calculate from ratio
 */
function tycheesImage_getImageHeightByRatio(originalWidth, originalHeight, currentWidth) {
	var ratio = currentWidth / originalWidth;
	return originalHeight * ratio;
} // .end of tycheesImage_getImageHeightByRatio

/**
 * Calculate image's width, by ratio.
 * 
 * @param	{integer} originalWidth - Original width
 * @param	{integer} originalHeight - Origianl height
 * @param	{integer} currentHeight	- Current height
 * @return	{integer} Current width, after calculate from ratio
 */
function tycheesImage_getImageWidthByRatio(originalWidth, originalHeight, currentHeight) {
	var ratio = currentHeight / originalHeight;
	return originalWidth * ratio;
} // .end of tycheesImage_getImageWidthByRatio

