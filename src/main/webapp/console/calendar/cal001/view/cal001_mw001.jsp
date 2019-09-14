<!-- Modal Window: Create New Calendar -->
<div class="modal inmodal fade" id="cal001_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW CALENDAR</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="cal001_mw001_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">New Calendar Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="cal001_mw001_calendarName">
	                                    	<span id="cal001_mw004_calendarName_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Background Color</label>
	                                    <div class="col-sm-8 input-group colorpicker-component">
	                                    	<input type="text" class="form-control" id="cal001_mw001_backgroundColor" value="#1ab394">
	                                    	<span class="input-group-addon"><i></i></span>
	                                    	<span id="cal001_mw004_backgroundColor_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Text Color</label>
	                                    <div class="col-sm-8 input-group colorpicker-component">
	                                    	<input type="text" class="form-control" id="cal001_mw001_textColor" value="#00000">
	                                    	<span class="input-group-addon"><i></i></span>
	                                    	<span id="cal001_mw004_textColor_error" style="color:#FF0000;display:none;">
	                                    	    <i class="fa fa-exclamation-circle" aria-hidden="true"></i> ERROR: Invalid Value.
	                                    	</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="cal001_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var cal001_mw001_initialized = false;

/**
 * Init Panel
 */
function cal001_mw001_init()
{
    if (cal001_mw001_initialized == true)
        return false;
    
    $('.cal001_mw001_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#cal001_mw001').on('shown.bs.modal', function () {
	    $("#cal001_mw001_calendarName").focus();
	})
    
    // init ColorPicker
    // Doc Ref: https://itsjavi.com/bootstrap-colorpicker/
    $('#cal001_mw001_backgroundColor').colorpicker();
    $('#cal001_mw001_textColor').colorpicker();

	cal001_mw001_initialized = true;
} // .end of cal001_mw001_init

/**
 * Show Panel
 */
function cal001_mw001_updateUI()
{
    cal001_mw001_init();
      
    module_showModalWindow('cal001_mw001', true);  
} // .end of cal001_mw001_updateUI

/**
 * Show Panel
 */
function cal001_mw001_show()
{
    cal001_mw001_updateUI();
} // .end of cal001_mw001_show

/**
 * Save changes and hide panel.
 */
function cal001_mw001_save()
{
	// Reset Error Messages
	$('#cal001_mw004_calendarName_error').hide();
	$('#cal001_mw004_backgroundColor_error').hide();
	$('#cal001_mw004_textColor_error').hide();

	// Extract user input
    var calendarName = $('#cal001_mw001_calendarName').val();
    var backgroundColor = $('#cal001_mw001_backgroundColor').val();
    var textColor = $('#cal001_mw001_textColor').val();
    
    // Validation
    if ($.trim(calendarName) == '')
    {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Calendar Name.');
        $('#cal001_mw004_calendarName_error').show();
        return false;
    }
    if (tycheesUtil_isColorCode(backgroundColor) == false)
    {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Background Color.');
        $('#cal001_mw004_calendarName_error').show();
        return false;
    }
    if (tycheesUtil_isColorCode(textColor) == false)
    {
        tycheesLogger_showToast('error', 'Invalid Input', 'Please provide valid value for Text Color.');
        $('#cal001_mw004_calendarName_error').show();
        return false;
    }
    
    var calendarObj = createNew_CommonCalendar();
    calendarObj.userId = tycheesCommon_getCurrentUserId();
    calendarObj.calendarName = calendarName;
    calendarObj.backgroundColor = backgroundColor;
    calendarObj.textColor = textColor;
    calendarObj.showing = true;
    
    var userObj = Cached_getUserById( tycheesCommon_getCurrentUserId() );
    userObj.calendarList.push( calendarObj );
    // Write to IndexedDB
    tycheesIO_saveBean( userObj );
    // Update UI
    cal001_updateUI_calendarList();
    
    // Close Modal Window
    $('#cal001_mw001').modal('hide');
} // .end of cal001_mw001_save

</script>