<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- SET001_20_00: Store Settings - General -->
<div id="set001_20_00" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	BASIC INFO
	</span>
    <div class="mail-box">
        <table class="table table-hover table-mail">
	        <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
	            <tr>
	                <td class="table-thead-td" width="auto">NAME</td>
	                <td class="table-thead-td" width="auto">VALUE</td>
	            </tr>
	        </thead>
	        <tbody id="set001_20_tab_general_table">
	        	<tr class="unread">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Company Registration Name</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_20_tab_general_companyName" name="Company Name" placeholder="Unique Place Name" value="" >
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_20_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                </tr>
	        	<tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Company Registration Number</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_20_tab_general_companyRegistrationNo" name="Registration Name" placeholder="Unique Place Name" value="" >
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_20_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                </tr>
	        	<tr class="unread">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Store Name</td>
                    <td class="input-group">
                    	<input type="text" class="form-control" id="set001_20_tab_general_placeName" name="Place Name" placeholder="Unique Place Name" value="" >
                    	<span class="input-group-btn">
							<button type="button" class="btn btn-primary" onclick="set001_20_00_save();">
								<i class="fa fa-floppy-o" aria-hidden="true"></i>
							</button>
						</span>
                    </td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Category</td>
                    <td>
                    	<select id="set001_20_tab_general_placeCategory" data-placeholder="Choose a Category..." style="width:100%;" class="form-control chosen-select-deselect" tabindex="2">
						</select>
                    </td>
                </tr>
                <tr class="unread">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Keywords</td>
                    <td>
                    	<input type="text" class="form-control" id="set001_20_tab_general_placeLabels" name="Keywords" placeholder="labels" data-role="tagsinput" maxlength="180">
                       	<span class="help-block" style="margin-top:0px; margin-bottom:0px;">
                       	    <small><i>Separate each keyword with Comma (,)</i></small>
                       	</span>
                    </td>
                </tr>
                <tr class="read">
                    <td style="font-size:11pt;padding:12px auto;vertical-align:middle;">Description</td>
                    <td>
                        <div class="input-group">
                        	<textarea class="form-control" id="set001_20_tab_general_placeDescription" rows="3" cols="50" placeholder="Place's description"></textarea>
                        	<span style="padding-left:5px; vertical-align:top;" class="input-group-btn">
                        	    <button id="button-632aa587-dda2-59a3-03cb-8b0c543469d8" class="btn btn-primary" onclick="set001_20_00_save();">
                        	        <i class="fa fa-floppy-o" aria-hidden="true"></i>
                        	    </button>
                        	</span>>
    					</div>
                    </td>
                </tr>
	        </tbody>
	    </table>
    </div>
</div>

<script>

var set001_20_00_initialized = false;
var set001_20_00_initializing = false;

/**
 * Init Panel
 */
function set001_20_00_init()
{
    if (set001_20_00_initialized == true)
        return false;

	// Add place category
    $("#set001_20_tab_general_placeCategory").empty();
    $("#set001_20_tab_general_placeCategory").append('<option value="">-- SELECT --</option>');
	//$.each(CommonConstants.placeCategoryList, function(i, placeCategoryObj){
	//	$("#set001_20_tab_general_placeCategory").append('<option value="' + placeCategoryObj.code + '">' + placeCategoryObj.name + '</option>');
	//});
	
    // Event handler for TAB General
    $('#set001_20_tab_general_companyName').on('input propertychange paste', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
    });
    $('#set001_20_tab_general_companyRegistrationNo').on('input propertychange paste', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
    });
    $('#set001_20_tab_general_placeName').on('input propertychange paste', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
    });
    $('#set001_20_tab_general_placeCategory').on('change', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
    });
    $('#set001_20_tab_general_placeLabels').on('input propertychange paste', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
    });
    $('#set001_20_tab_general_placeLabels').on('itemAdded', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
	});
    $('#set001_20_tab_general_placeLabels').on('itemRemoved', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
	});
    $('#set001_20_tab_general_placeDescription').on('input propertychange paste', function(event) {
        if (set001_20_00_initializing==false)
    	    set001_20_00_save();
    });
    
	set001_20_00_initialized = true;
} // .end of set001_20_00_init

/**
 * Show Panel
 */
function set001_20_00_updateUI()
{
    set001_20_00_init();
    
    set001_20_00_initializing = true;
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    $("#set001_20_tab_general_companyName").val(tycheesText_getDisplayText(placeObj.companyName, 0));
	$("#set001_20_tab_general_companyRegistrationNo").val(tycheesText_getDisplayText(placeObj.companyRegistrationNo, 0));
	$("#set001_20_tab_general_placeName").val(tycheesText_getDisplayText(placeObj.name, 0));
	//$("#set001_20_tab_general_placeCategory").val(placeObj.category).trigger("chosen:updated");
	$("#set001_20_tab_general_placeCategory").val(placeObj.category);
	$("#set001_20_tab_general_placeDescription").val(tycheesText_getDisplayText(placeObj.description, 0));
	
	$("#set001_20_tab_general_placeLabels").tagsinput('removeAll');
	$.each(placeObj.labelList, function(index, labelObj) {
		$("#set001_20_tab_general_placeLabels").tagsinput("add",labelObj.keyword);
  	});
  	
  	set001_20_00_initializing = false;
  	
    $('#set001_20_00').show();
} // .end of set001_20_00_updateUI

/**
 * Hide Panel
 */
function set001_20_00_hide()
{
    $('#set001_20_00').hide();
} // .end of set001_20_00_hide

/**
 * Save Place/Store.
 */
function set001_20_00_save()
{
	// TAB: General
	var companyName = $.trim( $("#set001_20_tab_general_companyName").val() );
	var companyRegistrationNo = $.trim( $("#set001_20_tab_general_companyRegistrationNo").val() );
	var placeName = $.trim( $("#set001_20_tab_general_placeName").val() );
    var category = $("#set001_20_tab_general_placeCategory").val();
    var labels = $("#set001_20_tab_general_placeLabels").val();
    var description = $.trim( $("#set001_20_tab_general_placeDescription").val() );

    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    placeObj.companyName = tycheesText_getSafeString(companyName);
    placeObj.companyRegistrationNo = tycheesText_getSafeString(companyRegistrationNo);
    placeObj.name = tycheesText_getSafeString(placeName);
    placeObj.category = tycheesText_getSafeString(category);
    placeObj.labels = tycheesText_getSafeString(labels);
    placeObj.description = tycheesText_getSafeString(description);
    
    // Save into IndexedDB
	tycheesIO_saveBean(Cached_placeObj);
} // .end of set001_20_00_save

</script>