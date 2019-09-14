<style>
	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
    
<!-- Edit Contact -->
<div class="modal inmodal fade" id="set001_20_02_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-sm">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT CONTACT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="modalWindow-placeEdit-modalBody" class="modal-body">
			    <div class="row">
				    <div class="col-lg-12">
				    	<div class="ibox float-e-margins">
						    <form role="form">
							    <div class="form-group" style="margin-bottom:0px;">
								    <span class="mandatory-field">* </span>
								    <label>Type</label> 
								    <select class="form-control m-b" name="account" id="set001_20_02_mw002_input_type">
									    <option value="Home" selected>Home</option>
									    <option value="Office">Office</option>
									    <option value="Mobile">Mobile</option>
								    </select>
							    </div>
							    <div class="row">
								    <div class="col-md-6 form-group">
									    <span class="mandatory-field">* </span>
								    	<label>Phone Number</label> 
								    	<br>
								    	<input type="tel" placeholder="" class="form-control" id="set001_20_02_mw002_input_phoneNumber" value="">
								    	<span id="set001_20_02_mw002_input_phoneNumber_helpText"></span>
								    </div>
								    <div class="col-md-6 form-group">
								    	<label>Extension</label> 
								    	<input type="text" placeholder="" class="form-control" id="set001_20_02_mw002_input_extension" value="">
								    </div>		
							    </div>
							    <div id="set001_20_02_mw002_errorText_mandatoryFields" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Please fill in highlighted mandatory fields.
							    	</span>
							    </div>
						    </form>
						</div>
				    </div>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_20_02_mw002_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_02_mw002_initialized = false;
var set001_20_02_mw002_contactObj;

/**
 * Init Panel
 */
function set001_20_02_mw002_init()
{
    if (set001_20_02_mw002_initialized == true)
        return false;
    
    $('#set001_20_02_mw002_input_phoneNumber').intlTelInput({
    	initialCountry: "auto",
    	onlyCountries: ["my","sg"],
    	//preferredCountries: ["my","sg"],
    	utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/11.0.7/js/utils.js"
    });
    
    $("#set001_20_02_mw002_input_phoneNumber").on("countrychange", function(e, countryData) {
    	tycheesLogger_logInfo('countryData='+JSON.stringify(countryData),'countrychange');
    	set001_20_02_mw002_updateUI_phoneDataMask( countryData );
   	});
    
	set001_20_02_mw002_initialized = true;
} // .end of set001_20_02_mw002_init

/**
 * Event Listener for phone country data changed.
 */
function set001_20_02_mw002_updateUI_phoneDataMask(countryData)
{
	var mask = '';
	var phoneInput = $("#set001_20_02_mw002_input_phoneNumber");
	var inputmask = phoneInput.data('bs.inputmask');
	
	if (countryData.iso2.toUpperCase()=='MY') {
		mask = '999-9999 9999';
	}
    if (countryData.iso2.toUpperCase()=='SG') {
    	mask = '9999 9999';
    }
    
    $("#set001_20_02_mw002_input_phoneNumber").prop('placeholder', mask);
	$("#set001_20_02_mw002_input_phoneNumber_helpText").html('Format: '+mask);
	
    /*
    if(inputmask) {
        inputmask.mask = mask;
        inputmask.init();
        //var position = inputmask.checkVal(true)
        //inputmask.caret(position, position);
    } else {
    	phoneInput.inputmask({mask: mask});
    }*/
} // .end of set001_20_02_mw002_updateUI_phoneDataMask

/**
 * Show Panel
 * 
 * @params	{operatingHourObj}
 */
function set001_20_02_mw002_updateUI(contactObj)
{
    set001_20_02_mw002_init();
    
    set001_20_02_mw002_reset();
    
    set001_20_02_mw002_contactObj = contactObj;
    
    var number = tycheesBean_toString_commonContactBean(contactObj);
    $('#set001_20_02_mw002_input_phoneNumber').intlTelInput("setNumber", number);
    
    $("#set001_20_02_mw002_input_type").val(contactObj.type);
    $("#set001_20_02_mw002_input_extension").val(contactObj.extension);

    // Show Window
    module_showModalWindow('set001_20_02_mw002', true);
} // .end of set001_20_02_mw002_updateUI

/**
 * Reset Form
 * 
 * @params	{operatingHourObj}
 */
function set001_20_02_mw002_reset()
{
	$('#set001_20_02_mw002_errorText_mandatoryFields').hide();
	$('#set001_20_02_mw002_input_type').css('background-color','#FFF');
	$('#set001_20_02_mw002_input_phoneNumber').css('background-color','#FFF');
	$('#set001_20_02_mw002_input_extension').css('background-color','#FFF');
} // .end of set001_20_02_mw002_reset

/**
 * Save into bean object at IDB level. 
 * 
 * @params	{operatingHourObj}
 */
function set001_20_02_mw002_save()
{
	// Reset
	set001_20_02_mw002_reset();
	
	// Get user inputs
	var idVal = $.trim( $("#set001_20_02_mw002_input_id").val() );
    var typeVal = $.trim( $("#set001_20_02_mw002_input_type").val() );
    var countryDataVal = $("#set001_20_02_mw002_input_phoneNumber").intlTelInput("getSelectedCountryData");
    var countryCodeVal = $.trim( countryDataVal.dialCode );
    var phoneNumberVal = $.trim( $("#set001_20_02_mw002_input_phoneNumber").val() );
    var extensionVal = $.trim( $("#set001_20_02_mw002_input_extension").val() );
    var areaCodeVal = '';
    if (phoneNumberVal.includes('-'))
    {
    	areaCodeVal = phoneNumberVal.substring(0, phoneNumberVal.indexOf('-'));
    	phoneNumberVal = phoneNumberVal.substring(phoneNumberVal.indexOf('-')+1, phoneNumberVal.length);
    }
    
    tycheesLogger_logInfo('typeVal='+typeVal,'set001_20_02_mw002_save');
    tycheesLogger_logInfo('countryDataVal='+JSON.stringify(countryDataVal),'set001_20_02_mw002_save');
    tycheesLogger_logInfo('areaCodeVal='+areaCodeVal,'set001_20_02_mw002_save');
    tycheesLogger_logInfo('phoneNumberVal='+phoneNumberVal,'set001_20_02_mw002_save');
    tycheesLogger_logInfo('extensionVal='+extensionVal,'set001_20_02_mw002_save');
    
    // Validation
    var errorFound = false;
    if (typeVal=='') {
    	$('#set001_20_02_mw002_input_type').css('background-color','#FFB0B0');
    	$('#set001_20_02_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (countryCodeVal=='') {
    	$('#set001_20_02_mw002_input_phoneNumber').css('background-color','#FFB0B0');
    	$('#set001_20_02_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (phoneNumberVal=='') {
    	$('#set001_20_02_mw002_input_phoneNumber').css('background-color','#FFB0B0');
    	$('#set001_20_02_mw002_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
    
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    $.each(placeObj.contactList, function(i, contactObj){
        if (contactObj.id==set001_20_02_mw002_contactObj.id)
        {
        	contactObj.type = typeVal;
        	contactObj.countryCode = countryCodeVal;
        	contactObj.areaCode = areaCodeVal;
        	contactObj.phoneNumber = phoneNumberVal;
        	contactObj.extension = extensionVal;
        	contactObj.hasChanged = true;
            
            if (contactObj.defaultContact==true)
            {
            	if (contactObj.type=='Mobile')
            		placeObj.mobile = tycheesBean_toString_commonContactBean(contactObj);
            	else
            		placeObj.phone = tycheesBean_toString_commonContactBean(contactObj);
            }
        }
    });

    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
    // Hide Modal Window
    $("#set001_20_02_mw002").modal("hide");
    // Update UI
    set001_20_02_updateUI();
} // .end of set001_20_02_mw002_save        

</script>
