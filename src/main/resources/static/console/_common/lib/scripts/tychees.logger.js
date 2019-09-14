// LOGGING
var LOGGING_LEVEL_INFO_ENABLED = true;
var LOGGING_LEVEL_DEBUG_ENABLED = true;
var LOGGING_LEVEL_ERROR_ENABLED = true; 

/**
 * Print log message on console, in standard format. 
 * 
 * @param {string} pi_type - range {info, debug, error}
 * @param {string} pi_function - function name in String
 * @param {string} pi_message - logged message
 */
function tycheesLogger_logConsole(pi_type, pi_message, pi_function) {
	if (pi_function==null)
		pi_function = '';
	
	var logText = pi_type.toUpperCase();
	logText += ' ';
	logText += '[' + pi_function + ']';
	logText += ' ';
	logText += pi_message;
	
	console.log(logText);	
} // .end of tycheesLogger_logConsole

/**
 * Print log message on console, in standard format. 
 * 
 * @param {string} pi_function - function name in String
 * @param {string} pi_message - logged message
 */
function tycheesLogger_logInfo(pi_message, pi_function) {
	if (LOGGING_LEVEL_INFO_ENABLED)
		tycheesLogger_logConsole('info', pi_message, pi_function);
} // .end of tycheesLogger_logInfo

/**
 * Print log message on console, in standard format. 
 * 
 * @param {string} pi_function - function name in String
 * @param {string} pi_message - logged message
 */
function tycheesLogger_logDebug(pi_message, pi_function) {
	if (LOGGING_LEVEL_DEBUG_ENABLED && !tycheesCommon_isProduction())
		tycheesLogger_logConsole('debug', pi_message, pi_function);
} // .end of tycheesLogger_logDebug

/**
 * Print log message on console, in standard format. 
 * 
 * @param {string} pi_function - function name in String
 * @param {string} pi_message - logged message
 */
function tycheesLogger_logError(pi_message, pi_function) {
	if (LOGGING_LEVEL_ERROR_ENABLED)
		tycheesLogger_logConsole('error', pi_message, pi_function);
} // .end of tycheesLogger_logError

/**
 * Show text message at top-bottom of screen. 
 * 
 * @param {string} type - range [success, info, warning, error]
 * @param {string} title - title on toast
 * @param {string} content - message on toast
 */
function tycheesLogger_showToast(type, title, content) {
	toastr.options = {
		closeButton: true,
		debug: false,
		progressBar: true,
		preventDuplicates: true,
		positionClass: 'toast-bottom-right',
		onclick: null,
		showDuration: 400,
		hideDuration: 1000,
		timeOut: 5000,
		extendedTimeOut: 1000,
		showEasing: 'swing',
		hideEasing: 'linear',
		showMethod: 'fadeIn',
		hideMethod: 'fadeOut'
	};

	if (type == 'success')
		toastr.success(content, title);
	if (type == 'info')
		toastr.info(content, title);
	if (type == 'warning')
		toastr.warning(content, title);
	if (type == 'error')
		toastr.error(content, title);
} // .end of tycheesLogger_showToast