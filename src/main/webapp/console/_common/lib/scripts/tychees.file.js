/**
 * Get base64 representation (String) of file.
 * 
 * @param {Blob} fileObj - File object (subclass of Blob)
 * @returns {String} base64 representation.
 */
function tycheesFile_getBase64(fileObj, postHandlerFn) {
    var reader = new FileReader();
    reader.readAsDataURL(fileObj);
    reader.onload = function() {
        //tycheesLogger_logInfo(reader.result, 'tycheesFile_getBase64');
        //var fileType = reader.result.substring(reader.result.indexOf('/') + 1, reader.result.indexOf(';'));
        var fileName = fileObj.name;
        var fileType = fileObj.type;
        var fileSize = fileObj.size;
        if (tycheesFile_isImageSupported(fileType)) {
            tycheesFile_getImageDimension(reader.result, fileName, fileType, fileSize, postHandlerFn);
        }
        else {
            postHandlerFn(true, reader.result, fileName, fileType, fileSize);
        }
    };
    reader.onerror = function(error) {
        //tycheesLogger_logError('Error: ' + error, 'tycheesFile_getBase64');
        postHandlerFn(false, error);
    };
} // .end of tycheesFile_getBase64

function tycheesFile_getImageDimension(base64, fileName, fileType, fileSize, postHandlerFn) {
    var image = document.createElement('img');
    image.addEventListener('load', function() {
        postHandlerFn(true, base64, fileName, fileType, fileSize, image.width, image.height);
    });
    image.src = base64;
} // .end of tycheesFile_getImageDimension

function tycheesFile_isImageSupported(fileType) {
    if ('IMAGE/JPEG' == fileType.toUpperCase())
        return true;
    if ('IMAGE/JPG' == fileType.toUpperCase())
        return true;
    if ('IMAGE/GIF' == fileType.toUpperCase())
        return true;
    if ('IMAGE/PNG' == fileType.toUpperCase())
        return true;
    return false;
} // .end of tycheesFile_isImageSupported
