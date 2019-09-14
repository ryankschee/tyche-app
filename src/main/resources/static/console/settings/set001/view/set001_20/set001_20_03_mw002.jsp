<style>
	.helptext-field {
   		color: #00F;
   		font-style: italic;
   	}
   	
	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
   
<!-- My Store: Edit Operating Hours-->
<div class="modal inmodal fade" id="set001_20_03_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-sm">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT OPERATING HOURS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_20_03_mw002_input_modalBody" class="modal-body">
			    <div class="row">
				    <div class="col-lg-6">
				    	<div class="ibox float-e-margins">
						    <form role="form">
						    	<input type="hidden" placeholder="" class="form-control" id="set001_20_03_mw002_input_id" value="">
							    <div class="form-group">
								    <span class="mandatory-field">* </span>
							    	<label>Open From</label> 
							    	<select id="set001_20_03_mw002_input_openFromDay" style="width:100%;height:28px;">
									  	<option value="0">Monday</option>
									  	<option value="1">Tuesday</option>
									  	<option value="2">Wednesday</option>
									  	<option value="3">Thursday</option>
									  	<option value="4">Friday</option>
									  	<option value="5">Saturday</option>
									  	<option value="6">Sunday</option>
									</select>
							    </div>
							    <div class="input-group clockpicker" data-placement="left" data-align="top" data-autoclose="true">
								    <input id="set001_20_03_mw002_input_openFromHourMinute" type="text" class="form-control" value="13:14">
								    <span class="input-group-addon">
								        <span class="glyphicon glyphicon-time"></span>
								    </span>
								    <span class="helptext-field">24-Hours Format. e.g. 14:30</span>
								</div>
						    </form>
					    </div>
				    </div>
				    
				    <div class="col-lg-6">
				    	<div class="ibox float-e-margins">
				    		<div class="ibox float-e-margins">
						    <form role="form">
							    <div class="form-group">
								    <span class="mandatory-field">* </span>
							    	<label>Close On</label> 
							    	<select id="set001_20_03_mw002_input_closeOnDay" style="width:100%;height:28px;">
									  	<option value="0">Monday</option>
									  	<option value="1">Tuesday</option>
									  	<option value="2">Wednesday</option>
									  	<option value="3">Thursday</option>
									  	<option value="4">Friday</option>
									  	<option value="5">Saturday</option>
									  	<option value="6">Sunday</option>
									</select>
							    </div>
							    <div class="input-group clockpicker" data-placement="left" data-align="top" data-autoclose="true">
								    <input id="set001_20_03_mw002_input_closeOnHourMinute" type="text" class="form-control" value="13:14">
								    <span class="input-group-addon">
								        <span class="glyphicon glyphicon-time"></span>
								    </span>
								    <span class="helptext-field">24-Hours Format. e.g. 14:30</span>
								</div>
						    </form>
					    </div>
					    </div>
				    </div>
			    </div>
			    
			    <div id="set001_20_03_mw002_errorText_mandatoryFields" class="row form-group" style="display:none;">
			    	<span class="error-text">
			    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
			    		Please fill in highlighted mandatory fields.
			    	</span>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_20_03_mw002_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_20_03_mw002_initialized = false;
var set001_20_03_mw002_operatingHourObj;

/**
 * Init Panel
 */
function set001_20_03_mw002_init()
{
    if (set001_20_03_mw002_initialized == true)
        return false;
        
	set001_20_03_mw002_initialized = true;
} // .end of set001_20_03_mw002_init

/**
 * Show Panel
 */
function set001_20_03_mw002_updateUI(operatingHourObj)
{
    set001_20_03_mw002_init();
    
	// Reset Form
	set001_20_03_mw002_reset();
	
    // Set selected operatingHourObj, when ModalWindow opens.
    set001_20_03_mw002_operatingHourObj = operatingHourObj;
  	
    // Set values
    $("#set001_20_03_mw002_input_id").val(operatingHourObj.id);
    $("#set001_20_03_mw002_input_openFromDay").val(operatingHourObj.openTimeDay);
    $("#set001_20_03_mw002_input_openFromHourMinute").val(tycheesText_leftPad(operatingHourObj.openTimeHour, '0', 2) + ':' + tycheesText_leftPad(operatingHourObj.openTimeMinute,2));
    $("#set001_20_03_mw002_input_closeOnDay").val(operatingHourObj.closeTimeDay);
    $("#set001_20_03_mw002_input_closeOnHourMinute").val(tycheesText_leftPad(operatingHourObj.closeTimeHour, '0', 2) + ':' + tycheesText_leftPad(operatingHourObj.closeTimeMinute,2));
    
    //tycheesCommon_initClockPicker();
            
    // Show Window
    module_showModalWindow('set001_20_03_mw002', true);
} // .end of set001_20_03_mw002_updateUI

/**
 * Reset Form
 */
function set001_20_03_mw002_reset()
{
	$('#set001_20_03_mw002_errorText_mandatoryFields').hide();
	$('#set001_20_03_mw002_input_openFromDay').css('background-color','#FFF');
	$('#set001_20_03_mw002_input_openFromHourMinute').css('background-color','#FFF');
	$('#set001_20_03_mw002_input_closeOnDay').css('background-color','#FFF');
	$('#set001_20_03_mw002_input_closeOnHourMinute').css('background-color','#FFF');
} // .end of set001_20_03_mw002_reset

/**
 * Save into bean object at IDB level. 
 *
 * @params	{operatingHourObj}
 */
function set001_20_03_mw002_save()
{
	// Reset Form
	set001_20_03_mw002_reset();
	
    // Get input values
    var idVal = $("#set001_20_03_mw002_input_id").val();
    var openFromDay = $("#set001_20_03_mw002_input_openFromDay").val();
    var openFromHourMinute = $("#set001_20_03_mw002_input_openFromHourMinute").val();
    var closeOnDay = $("#set001_20_03_mw002_input_closeOnDay").val();
    var closeOnHourMinute = $("#set001_20_03_mw002_input_closeOnHourMinute").val();
    
    // Parse input values
    var openFromHour = openFromHourMinute.substr(0, 2);
    var openFromMinute = openFromHourMinute.substr(3, 2);
    var closeOnHour = closeOnHourMinute.substr(0, 2);
    var closeOnMinute = closeOnHourMinute.substr(3, 2);

    console.log("openFromHourMinute >> " + openFromHourMinute);
    console.log("closeOnHourMinute >> " + closeOnHourMinute);
    console.log("openFromHour >> " + openFromHour);
    console.log("openFromMinute >> " + openFromMinute);
    console.log("closeOnHour >> " + closeOnHour);
    console.log("closeOnMinute >> " + closeOnMinute);
    
    // Validation
    var errorFound = false;
    if (openFromDay=='') {
    	$('#set001_20_03_mw002_input_type').css('background-color','#FFB0B0');
    	$('#set001_20_03_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (openFromHourMinute=='') {
    	$('#set001_20_03_mw002_input_phoneNumber').css('background-color','#FFB0B0');
    	$('#set001_20_03_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (closeOnDay=='') {
    	$('#set001_20_03_mw002_input_phoneNumber').css('background-color','#FFB0B0');
    	$('#set001_20_03_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (closeOnHourMinute=='') {
    	$('#set001_20_03_mw002_input_phoneNumber').css('background-color','#FFB0B0');
    	$('#set001_20_03_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.operatingHourList, function(i, operatingHourObj){
        if (operatingHourObj.id==idVal)
        {
        	operatingHourObj.openTimeDay = Number(openFromDay);
            operatingHourObj.openTimeHour = Number(openFromHour);
            operatingHourObj.openTimeMinute = Number(openFromMinute);
        	operatingHourObj.closeTimeDay = Number(closeOnDay);
            operatingHourObj.closeTimeHour = Number(closeOnHour);
            operatingHourObj.closeTimeMinute = Number(closeOnMinute);
            operatingHourObj.hasChanged = true;
        }
    });
    
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
    // Hide Modal Window
    $("#set001_20_03_mw002").modal("hide");
    // Update UI
    set001_20_03_updateUI();
} // .end of set001_20_03_mw002_save

</script>