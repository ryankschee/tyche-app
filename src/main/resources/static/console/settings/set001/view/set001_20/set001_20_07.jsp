
<!-- SET001_20_07: Place Settings - Account Membership -->
<div id="set001_20_07" style="display:none;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	ACCOUNT MEMBERSHIP
	</span>
    <div id="set001_20_07_panel">
        <table id="set001_20_05_table" class="table table-hover table-mail" style="margin-bottom:0px;">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td class="table-thead-td" width="auto"style="text-align:left;">SETTINGS</td>
                    <td class="table-thead-td" width="auto"style="text-align:right;">VALUE</td>
                    <td class="table-thead-td" width="auto"style="text-align:right;">USAGE</td>
                    <td class="table-thead-td" width="80px"style="text-align:right;">ACTION</td>
                </tr>
            </thead>
            <tbody id="set001_20_07_tableContent">
            </tbody>
        </table>
    </div>
    <div id="set001_20_07_spinner" class="spiner-example">
		<div class="sk-spinner sk-spinner-wave">
		    <div class="sk-rect1"></div>
		    <div class="sk-rect2"></div>
		    <div class="sk-rect3"></div>
		    <div class="sk-rect4"></div>
		    <div class="sk-rect5"></div>
		</div>
	    <div id="set001_20_07_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
	</div>
</div>

<script>

var set001_20_07_initialized = false;

function set001_20_07_init()
{
    if (set001_20_07_initialized == true)
        return false;
            
	set001_20_07_initialized = true;
} // .end of set001_20_07_init

function set001_20_07_updateUI()
{
    // Init, if any
	set001_20_07_init();
    // Show UI
    $('#set001_20_07').show();
    // Show Spinner, Hide Table
    $('#set001_20_07_panel').hide();
    $('#set001_20_07_spinner').show();
    
    var requestBody = new Object();    
    var params = new Object();
    
    tycheesdb_api_getAccountUsagesByPlace(requestBody, set001_20_07_updateUI_postHandler, params);
} // .end of set001_20_07_updateUI

function set001_20_07_updateUI_postHandler(success, responseObj, params) 
{
	if (!success)
		return false;
	
	// Get Place Object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    // Sort asc
    placeObj.propertiesList.sort(function(a, b){
		return a.propSeqno - b.propSeqno;
	});
	
	$('#set001_20_07_tableContent').empty();
    $.each(placeObj.propertiesList, function(i, propObj){
    	
    	var usageVal = '';
    	if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_USER_MAX_COUNT) {
    		usageVal = responseObj.userUsageCount;
    	}
    	if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_CUSTOMER_MAX_COUNT) {
    		usageVal = responseObj.customerUsageCount;
    	}
    	if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_INVENTORY_CATEGORY_MAX_COUNT) {
    		usageVal = responseObj.inventoryCategoryUsageCount;
    	}
    	if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT) {
    		usageVal = responseObj.inventoryItemUsageCount;
    	}
    	if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT) {
    		usageVal = Number(responseObj.monthlyBillingUsageAmount).toFixed(2);
    	}
    	
    	var htmlLines = '';
    	htmlLines += '<tr class="read">';
    	
    	// COL #1
		htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
		htmlLines += propObj.propName.toUpperCase();
		htmlLines += '</td>';
		
		// COL #2
		//htmlLines += '<td class="mail-date">' + settingsCommon_getInputComponent(propObj) + '</td>';
		htmlLines += '<td style="text-align:right;">' + propObj.propValue + '</td>';

		// COL #3
		htmlLines += '<td style="text-align:right;">' + usageVal + '</td>';

		// COL #4
		htmlLines += '<td style="text-align:right;">';
		htmlLines += '<button type="button" class="btn btn-xs btn-primary">'; 
		htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>'; 
		htmlLines += '</button>'; 
		htmlLines += '</td>';
		
		// Row Finishing
		htmlLines += '</tr>'
		
    	$('#set001_20_07_tableContent').append(htmlLines);
    	
    	// Register events
    	settingsCommon_addEventListeners( propObj );
    });
    
    // Hide Spinner, Show Table
    $('#set001_20_07_panel').show();
    $('#set001_20_07_spinner').hide();
} // .end of set001_20_07_updateUI_postHandler

function set001_20_07_hide()
{
    $('#set001_20_07').hide();
} // .end of set001_20_07_hide

</script>