
<!-- 
    Title:			ADDRESS EDITOR
    Desc:			- Show address in details
    Author:			Ryan Chee
    Last Modified:	20170810
-->

<div class="modal inmodal fade" id="mw_addressEditor" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">ADDRESS EDITOR</span>
			</div>
		    <div class="modal-body">
			    <div class="row">
				    <div class="col-lg-12">
				    	<div class="ibox float-e-margins">
						    <form role="form">
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Type</label> 
								    	<br>
								    	<select id="mw_addressEditor_addressType"  class="form-control">
								    		<option value="Home">Home</option>
								    		<option value="Office">Office</option>
								    		<option value="Mobile">Mobile</option>
						                </select>
								    </div>	
							    </div>
							    <hr>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		Attention To
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_attentionTo">
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		<span class="mandatory-field">* </span>
								    		Street Line 1
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_streetLine1">
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		Street Line 2
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_streetLine2">
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		Street Line 3
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_streetLine3">
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		<span class="mandatory-field">* </span>
								    		Postal Code
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_postalCode">
								    </div>	
							    </div>
						    	<div class="row">
								    <div class="col-md-12 form-group">
								    	<label>
								    		Area
								    	</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_area">
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>City</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_city">
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>State</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_state">
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Country</label> 
								    	<br>
								    	<input type="text" class="form-control" id="mw_addressEditor_country">
								    </div>	
							    </div>
							    <div class="row">
								    <div class="col-md-12 form-group">
								    	<label>Default Address</label> 
								    	<br>
								    	<div class="mw_addressEditor_iCheck">
                                        	<label> 
                                        		<input type="checkbox" id="mw_addressEditor_defaultAddress"> 
                                        	</label>
                                        </div>
								    </div>	
							    </div>
							    <div id="mw_addressEditor_errorText_mandatoryFields" class="form-group" style="display:none;">
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
		    	<button type="button" id="mw_addressEditor_closeButton" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" id="mw_addressEditor_saveButton" class="btn btn-primary ladda-button" data-style="zoom-in" onclick="mw_addressEditor_save();">Save Changes</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var mw_addressEditor_initialized = false;
var mw_addressEditor_addressObj;
var mw_addressEditor_postHandlerFn;

function mw_addressEditor_init()
{
    if (mw_addressEditor_initialized == true)
        return false;

    $('.mw_addressEditor_iCheck').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#mw_addressEditor').on('shown.bs.modal', function () {
	});
        
	mw_addressEditor_initialized = true;
} // .end of mw_addressEditor_init

function mw_addressEditor_show(contactObj, postHandlerFn)
{
	// Get current user object
	mw_addressEditor_addressObj = contactObj;
	// Post Handler
	mw_addressEditor_postHandlerFn = postHandlerFn;
	// Init UI/data
	mw_addressEditor_updateUI();
} // .end of mw_addressEditor_show

function mw_addressEditor_updateUI()
{
	if (mw_addressEditor_addressObj == null)
		return false;
	
    mw_addressEditor_init();    
    mw_addressEditor_resetErrors();

    // Reset
    $('#mw_addressEditor_contactType').val( $.trim(mw_addressEditor_addressObj.type));
	$('#mw_addressEditor_attentionTo').val( $.trim(mw_addressEditor_addressObj.attentionTo) );
	$('#mw_addressEditor_streetLine1').val( $.trim(mw_addressEditor_addressObj.streetLine1) );
	$('#mw_addressEditor_streetLine2').val( $.trim(mw_addressEditor_addressObj.streetLine2) );
	$('#mw_addressEditor_streetLine3').val( $.trim(mw_addressEditor_addressObj.streetLine3) );
	$('#mw_addressEditor_postalCode').val( $.trim(mw_addressEditor_addressObj.postalCode) );
	$('#mw_addressEditor_area').val( $.trim(mw_addressEditor_addressObj.area) );
	$('#mw_addressEditor_city').val( $.trim(mw_addressEditor_addressObj.city) );
	$('#mw_addressEditor_state').val( $.trim(mw_addressEditor_addressObj.state) );
	$('#mw_addressEditor_country').val( $.trim(mw_addressEditor_addressObj.country) );
	if (mw_addressEditor_addressObj.defaultAddress)
		$('#mw_addressEditor_defaultAddress').iCheck('check');
	else
		$('#mw_addressEditor_defaultAddress').iCheck('uncheck');
 	            
    // Show Window
    module_showModalWindow('mw_addressEditor', true);
} // .end of mw_addressEditor_updateUI

function mw_addressEditor_resetErrors()
{
	$('#mw_addressEditor_errorText_mandatoryFields').hide();
	$('#mw_addressEditor_streetLine1').css('background-color','#FFF');
	$('#mw_addressEditor_postalCode').css('background-color','#FFF');
} // .end of mw_addressEditor_resetErrors

function mw_addressEditor_save()
{
	// Reset
	mw_addressEditor_resetErrors();
	
	// Get user inputs
	var addressType = $.trim( $('#mw_addressEditor_addressType').val() );
	var attentionTo = $.trim( $('#mw_addressEditor_attentionTo').val() );
	var streetLine1 = $.trim( $('#mw_addressEditor_streetLine1').val() );
	var streetLine2 = $.trim( $('#mw_addressEditor_streetLine2').val() );
	var streetLine3 = $.trim( $('#mw_addressEditor_streetLine3').val() );
	var postalCode = $.trim( $('#mw_addressEditor_postalCode').val() );
	var area = $.trim( $('#mw_addressEditor_area').val() );
	var city = $.trim( $('#mw_addressEditor_city').val() );
	var state = $.trim( $('#mw_addressEditor_state').val() );
	var country = $.trim( $('#mw_addressEditor_country').val() );
	var defaultAddress = $('#mw_addressEditor_defaultAddress').prop('checked');
    
    // Validation
    var errorFound = false;
    if (streetLine1=='') {
    	$('#mw_addressEditor_streetLine1').css('background-color','#FFB0B0');
    	$('#mw_addressEditor_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (postalCode=='') {
    	$('#mw_addressEditor_postalCode').css('background-color','#FFB0B0');
    	$('#mw_addressEditor_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
        
    mw_addressEditor_addressObj.hasChanged = true;
    mw_addressEditor_addressObj.type = addressType;
    mw_addressEditor_addressObj.attentionTo = attentionTo;
    mw_addressEditor_addressObj.streetLine1 = streetLine1;
    mw_addressEditor_addressObj.streetLine2 = streetLine2;
    mw_addressEditor_addressObj.streetLine3 = streetLine3;
    mw_addressEditor_addressObj.postalCode = postalCode;
    mw_addressEditor_addressObj.area = area;
    mw_addressEditor_addressObj.city = city;
    mw_addressEditor_addressObj.state = state;
    mw_addressEditor_addressObj.country = country;
    mw_addressEditor_addressObj.defaultAddress = defaultAddress;
    
	// Hide Modal Window
    $("#mw_addressEditor").modal('hide');
	// Pass to callback function
    mw_addressEditor_postHandlerFn(true, mw_addressEditor_addressObj);
} // .end of mw_addressEditor_save_postHandler

</script>
