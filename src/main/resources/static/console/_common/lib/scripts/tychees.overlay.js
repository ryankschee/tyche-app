// Long Progress init status
var tychees_common_overlay_longProgress_init = false;
var tychees_common_overlay_longProgress_showing = false;
// Short Progress init status
var tychees_common_overlay_shortProgress_init = false;
var tychees_common_overlay_shortProgress_showing = false;

/**
 * Show long progress message on top of opaque overlay.
 * 
 * @param {String} progressMessage - Showing message.
 */
function tycheesOverlay_startLongProgress(progressMessage) {
	// Create overlay html, if not init yet.
	if (tychees_common_overlay_longProgress_init == false) {
		// Set init to true
		tychees_common_overlay_longProgress_init = true;

		var htmlLines = '';
		htmlLines += '<div id="console_longProgress" style="display:none">';
		htmlLines += '<div>';
		htmlLines += '<div style="font-size:48pt;text-align:center;width:400px;">TYCHEES</div>';
		htmlLines += '<div style="font-size:28pt;text-align:center;width:400px;">Business Suite</div>';
		htmlLines += '<div id="console_longProgressStatus" style="text-align:center;width:400px;"></div>';
		htmlLines += '<br/>';
		htmlLines += '<div class="progress progress-striped active" style="width:400px;">';
		htmlLines += '<div style="width:100%;" aria-valuemax="100" aria-valuemin="0" aria-valuenow="100" role="progressbar" class="progress-bar progress-bar-primary">';
		htmlLines += '<span class="sr-only">75% Complete</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '<div class="bg"></div>';
		htmlLines += '</div>';

		if ($('body').find('#console_longProgress').attr('id') != 'console_longProgress') {
			$('body').append(htmlLines);
		}

		$('#console_longProgress').css({
			'width': '100%',
			'height': '100%',
			'position': 'fixed',
			'z-index': '10000000',
			'top': '0',
			'left': '0',
			'right': '0',
			'bottom': '0',
			'margin': 'auto'
		});

		$('#console_longProgress .bg').css({
			'background': '#000000',
			'opacity': '0.7',
			'width': '100%',
			'height': '100%',
			'position': 'absolute',
			'top': '0'
		});

		$('#console_longProgress>div:first').css({
			'width': '400px',
			'height': '75px',
			'text-align': 'center',
			'position': 'fixed',
			'top': '0',
			'left': '0',
			'right': '0',
			'bottom': '0',
			'margin': 'auto',
			'font-size': '16px',
			'z-index': '10',
			'color': '#ffffff'
		});
	}

	// Set Message
	$('#console_longProgressStatus').html(progressMessage);
	// Set CSS
	$('#console_longProgress .bg').height('100%');
	$('#console_longProgress').fadeIn(300);
	$('body').css('cursor', 'wait');
} // .end of tycheesOverlay_startLongProgress

/**
 * Hide long progress message.
 */
function tycheesOverlay_stopLongProgress() {
	$('#console_longProgress .bg').height('100%');
	$('#console_longProgress').fadeOut(300);
	$('body').css('cursor', 'default');

	tychees_common_longProgressState_showing = false;
} // .end of tycheesOverlay_stopLongProgress

/**
 * true/false if long progress overlay is showing
 * 
 * @returns {boolean} true if long progress overlay is showing; otherwise false.
 */
function tycheesOverlay_isLongProgressShowing() {
	return tychees_common_overlay_longProgress_showing;
} // .end of tycheesOverlay_isLongProgressShowing

/**
 * Show short progress message on top of semi-transparent overlay.
 * 
 * @param {String} progressMessage - Showing message.
 */
function tycheesOverlay_startShortProgress(progressMessage) {
	// Create overlay html, if not init yet.
	if (tychees_common_overlay_shortProgress_init == false) {
		// Set init to true
		tychees_common_overlay_shortProgress_init = true;

		var htmlLines = '';
		htmlLines += '<div id="console_shortProgress" style="display:none">';
		htmlLines += '<div>';
		htmlLines += '<div style="font-size:48pt;text-align:center;width:400px;">TYCHEES</div>';
		//htmlLines += '<div style="font-size:28pt;text-align:center;width:400px;">Business Suite</div>';
		htmlLines += '<div id="console_shortProgressStatus" style="text-align:center;width:400px;font-size:18pt;"></div>';
		htmlLines += '<br/>';
		htmlLines += '<div class="progress progress-striped active" style="width:400px;">';
		htmlLines += '<div style="width:100%;" aria-valuemax="100" aria-valuemin="0" aria-valuenow="100" role="progressbar" class="progress-bar progress-bar-primary">';
		htmlLines += '<span class="sr-only">75% Complete</span>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '</div>';
		htmlLines += '<div class="bg"></div>';
		htmlLines += '</div>';

		if ($('body').find('#console_shortProgress').attr('id') != 'console_shortProgress') {
			$('body').append(htmlLines);
		}

		$('#console_shortProgress').css({
			'width': '100%',
			'height': '100%',
			'position': 'fixed',
			'z-index': '10000000',
			'top': '0',
			'left': '0',
			'right': '0',
			'bottom': '0',
			'margin': 'auto'
		});

		$('#console_shortProgress .bg').css({
			'background': '#000000',
			'opacity': '0.7',
			'width': '100%',
			'height': '100%',
			'position': 'absolute',
			'top': '0'
		});

		$('#console_shortProgress>div:first').css({
			'width': '400px',
			'height': '75px',
			'text-align': 'center',
			'position': 'fixed',
			'top': '0',
			'left': '0',
			'right': '0',
			'bottom': '0',
			'margin': 'auto',
			'font-size': '16px',
			'z-index': '10',
			'color': '#ffffff'
		});
	}

	// Set Message
	$('#console_shortProgressStatus').html(progressMessage);
	// Show progress message
	$('#console_shortProgress .bg').height('100%');
	$('#console_shortProgress').fadeIn(300);
	$('body').css('cursor', 'wait');

	tychees_common_overlay_shortProgress_showing = true;
} // .end of tycheesOverlay_startShortProgress

/**
 * Hide short progress message.
 */
function tycheesOverlay_stopShortProgress() {
	$('#console_shortProgress .bg').height('100%');
	$('#console_shortProgress').fadeOut(300);
	$('body').css('cursor', 'default');

	tychees_common_overlay_shortProgress_showing = false;
} // .end of tycheesOverlay_stopShortProgress

/**
 * true/false if short progress overlay is showing
 * 
 * @returns {boolean} true if short progress overlay is showing; otherwise false.
 */
function tycheesOverlay_isShortProgressShowing() {
	return tychees_common_overlay_shortProgress_showing;
} // .end of tycheesOverlay_isShortProgressShowing
