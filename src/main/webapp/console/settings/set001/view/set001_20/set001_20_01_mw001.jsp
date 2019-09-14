<style>
	#set001_20_01_mw001_map {
    	height: 400px;
    	width: 100%;
   	}
   	
   	.mandatory-field {
   		color: #F00;
   	}
   	
   	.error-text {
   		color: #F00;
   	}
</style>
    
<!-- Add New Address -->
<div class="modal inmodal fade" id="set001_20_01_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW ADDRESS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="modalWindow-placeEdit-modalBody" class="modal-body">
			    <div class="row">
				    <div class="col-lg-5">
				    	<div class="ibox float-e-margins">
						    <form role="form">
						    	<div class="row">
								    <div class="col-md-4 form-group" style="margin-bottom:0px;">
									    <span class="mandatory-field">* </span>
									    <label>Type</label> 
									    <select class="form-control m-b" name="account" id="set001_20_01_mw001_input_type">
										    <option value="Home" selected>Home</option>
										    <option value="Office">Office</option>
									    </select>
								    </div>
								    <div class="col-md-8 form-group" style="margin-bottom:0px;">
									    <span class="mandatory-field">* </span>
								    	<label>Attention To</label> 
								    	<input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_attentionTo" value="">
								    </div>
								</div>
							    <div class="form-group">
								    <span class="mandatory-field">* </span>
							    	<label>Street Line 1</label> 
							    	<input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_streetLine1" value="">
							    </div>
							    <div class="form-group">
							    	<label>Street Line 2</label> 
							    	<input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_streetLine2" value="">
							    </div>
							    <div class="form-group">
							    	<label>Street Line 3</label> 
							    	<input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_streetLine3" value="">
							    </div>
							    <div class="row">
								    <div class="col-md-4 form-group">
								    	<span class="mandatory-field">* </span>
									    <label>Postal Code</label> 
									    <input type="number" placeholder="" class="form-control" id="set001_20_01_mw001_input_postalCode" value="">
								    </div>
								    <div class="col-md-8 form-group">
									    <label>City</label> 
									    <input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_city" value="">
								    </div>
							    </div>
							    <div class="row">
								    <div class="col-md-6 form-group">
									    <label>State</label> 
									    <input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_state" value="">
								    </div>
								    <div class="col-md-6 form-group">
								    	<span class="mandatory-field">* </span>
									    <label>Country</label> 
									    <input type="text" placeholder="" class="form-control" id="set001_20_01_mw001_input_country" value="">
								    </div>
							    </div>							    
							    <div id="set001_20_01_mw001_errorText_mandatoryFields" class="form-group" style="display:none;">
							    	<span class="error-text">
							    		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
							    		Please fill in highlighted mandatory fields.
							    	</span>
							    </div>
						    </form>
						</div>
				    </div>
				    <div class="col-lg-7">
				    	<div class="ibox float-e-margins">
				    		<div class="ibox-title">
				    			<h5>Map <small>Drag the marker to change address.</small></h5>
				    		</div>
				    		<div class="ibox-content">
				    			<div class="row">
								    <div id="set001_20_01_mw001_map"></div>
							    </div>
				    		</div>
					    </div>
				    </div>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_20_01_mw001_save();">Create New</button>
		    </div>
	    </div>
    </div>
</div>
	
<script>

var set001_20_01_mw001_initialized = false;

/**
 * Init Panel
 */
function set001_20_01_mw001_init()
{
    if (set001_20_01_mw001_initialized == true)
        return false;
       
    set001_20_01_mw001_initMap();
    
	set001_20_01_mw001_initialized = true;
} // .end of set001_20_01_mw001_init

function set001_20_01_mw001_initMap() 
{
    var uluru = {lat: -25.363, lng: 131.044};
    var map = new google.maps.Map(document.getElementById('set001_20_01_mw001_map'), {
      	zoom: 4,
      	center: uluru
    });
    var marker = new google.maps.Marker({
      	position: uluru,
      	map: map
    });
} // .end of set001_20_01_mw001_initMap
  
function initMap_geolocation() 
{
    var map = new google.maps.Map(document.getElementById('set001_20_01_mw001_map'), {
      	center: {lat: -34.397, lng: 150.644},
      	zoom: 6
    });
    var infoWindow = new google.maps.InfoWindow({map: map});

    // Try HTML5 geolocation.
    if (navigator.geolocation) 
    {
      	navigator.geolocation.getCurrentPosition(function(position) {
	        var pos = {
	          	lat: position.coords.latitude,
	          	lng: position.coords.longitude
	        };
	
	        infoWindow.setPosition(pos);
	        infoWindow.setContent('Location found.');
	        map.setCenter(pos);
      	}, function() {
        	handleLocationError(true, infoWindow, map.getCenter());
      	});
    } 
    else 
    {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    }
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) 
{
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
                          'Error: The Geolocation service failed.' :
                          'Error: Your browser doesn\'t support geolocation.');
}

/**
 * Show Panel
 */
function set001_20_01_mw001_updateUI()
{
    set001_20_01_mw001_init();
    
    set001_20_01_mw001_reset();
    
    $("#set001_20_01_mw001_input_type").val('Home');
    $("#set001_20_01_mw001_input_attentionTo").val('');
    $("#set001_20_01_mw001_input_streetLine1").val('');
    $("#set001_20_01_mw001_input_streetLine2").val('');
    $("#set001_20_01_mw001_input_streetLine3").val('');
    $("#set001_20_01_mw001_input_postalCode").val('');
    $("#set001_20_01_mw001_input_city").val('');
    $("#set001_20_01_mw001_input_state").val('');
    $("#set001_20_01_mw001_input_country").val('');

    // Show Window
    module_showModalWindow('set001_20_01_mw001', true);
} // .end of set001_20_01_mw001_updateUI

function set001_20_01_mw001_reset()
{
	$('#set001_20_01_mw001_errorText_mandatoryFields').hide();
	$('#set001_20_01_mw001_input_type').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_attentionTo').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_streetLine1').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_streetLine2').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_streetLine3').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_postalCode').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_city').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_state').css('background-color','#FFF');
	$('#set001_20_01_mw001_input_country').css('background-color','#FFF');	
} // .end of set001_20_01_mw001_reset

/**
 * Update Place Address Object.
 */ 
function set001_20_01_mw001_save()
{
	// Reset
	set001_20_01_mw001_reset();
	
	// Get user inputs
    var typeVal = $.trim( $("#set001_20_01_mw001_input_type").val() );
    var attentionToVal = $.trim( $("#set001_20_01_mw001_input_attentionTo").val() );
    var streetLine1Val = $.trim( $("#set001_20_01_mw001_input_streetLine1").val() );
    var streetLine2Val = $.trim( $("#set001_20_01_mw001_input_streetLine2").val() );
    var streetLine3Val = $.trim( $("#set001_20_01_mw001_input_streetLine3").val() );
    var postalCodeVal = $.trim( $("#set001_20_01_mw001_input_postalCode").val() );
    var cityVal = $.trim( $("#set001_20_01_mw001_input_city").val() );
    var stateVal = $.trim( $("#set001_20_01_mw001_input_state").val() );
    var countryVal = $.trim( $("#set001_20_01_mw001_input_country").val() );
    
    // Validation
    var errorFound = false;
    if (typeVal=='') {
    	$('#set001_20_01_mw001_input_type').css('background-color','#FFB0B0');
    	$('#set001_20_01_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (attentionToVal=='') {
    	$('#set001_20_01_mw001_input_attentionTo').css('background-color','#FFB0B0');
    	$('#set001_20_01_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (streetLine1Val=='') {
    	$('#set001_20_01_mw001_input_streetLine1').css('background-color','#FFB0B0');
    	$('#set001_20_01_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (postalCodeVal=='') {
    	$('#set001_20_01_mw001_input_postalCode').css('background-color','#FFB0B0');
    	$('#set001_20_01_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    if (countryVal=='') {
    	$('#set001_20_01_mw001_input_country').css('background-color','#FFB0B0');
    	$('#set001_20_01_mw001_errorText_mandatoryFields').show();
    	errorFound = true;
    }
    
    if (errorFound)
    	return false;
    // .end of Validation
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    var newAddressObj = createNew_PlaceAddress();
    newAddressObj.placeId = placeObj.id;
    newAddressObj.type = typeVal;
    newAddressObj.attentionTo = attentionToVal;
    newAddressObj.streetLine1 = streetLine1Val;
    newAddressObj.streetLine2 = streetLine2Val;
    newAddressObj.streetLine3 = streetLine3Val;
    newAddressObj.postalCode = postalCodeVal;
    newAddressObj.city = cityVal;
    newAddressObj.state = stateVal;
    newAddressObj.country = countryVal;
    newAddressObj.latitude = 0.0;
    newAddressObj.longitude = 0.0;

    // Add into current place's address list
    placeObj.addressList.push(newAddressObj);
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
    // Hide Modal Window
    $("#set001_20_01_mw001").modal("hide");
    // Update UI
    set001_20_01_updateUI();
} // .end of set001_20_01_mw001_save        

</script>

<!-- Google Map API -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAjfF1IR66SQABR26H6MR0IZWm4A6nVjsY"></script>
 