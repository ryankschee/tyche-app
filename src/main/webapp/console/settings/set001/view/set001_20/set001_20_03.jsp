<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- SET001_01_00: Store Settings - Operating Hours -->
<div id="set001_20_03" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	OPERATING HOURS
	</span>
	<div class="ibox-content">
        <form user="form" class="form-inline">
        	<button class="btn btn-sm btn-white" type="button" onclick="set001_20_03_mw001_updateUI();">
        		<i class="fa fa-plus" aria-hidden="true"></i> 
        		Add New Operating Hours
        	</button>
        	<div class="input-group pull-right">
                <input type="text" class="form-control input-sm" name="search" placeholder="Search operating hours">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-primary">
                        Reset
                    </button>
                </div>
            </div>
        </form>
    </div>        
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td class="table-thead-td" width="auto"></td>
                    <td class="table-thead-td" width="auto">OPEN ON</td>
                    <td class="table-thead-td" width="auto">CLOSE ON</td>
                    <td class="table-thead-td" width="170px">ACTION</td>
                </tr>
            </thead>
            <tbody id="set001_20_03_table">
            </tbody>
        </table>
    </div>
</div>

<!-- Add Operating Hour -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_03_mw001.jsp" %>
<!-- Edit Operating Hour -->
<%@include file="/console/settings/set001/view/set001_20/set001_20_03_mw002.jsp" %>

<script>

var set001_20_03_initialized = false;

/**
 * Init Panel
 */
function set001_20_03_init()
{
    if (set001_20_03_initialized == true)
        return false;

	set001_20_03_initialized = true;
} // .end of set001_20_03_init

/**
 * Show Panel
 */
function set001_20_03_updateUI()
{
    set001_20_03_init();
    
    var rowCount = 1;
    
 	// Empty table
    $('#set001_20_03_table').empty();
    
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.operatingHourList, function(i, operatingHourObj) { 
    
    	if (Cached_isDeletedBean(operatingHourObj))
    		return true;
    	
        var htmlLines = '';
       	htmlLines += '<tr class="read">';

       	// COL #1
   		htmlLines += '<td style="font-size:12pt; padding:12px auto; vertical-align:top;">';
   		htmlLines += rowCount++;
   		htmlLines += '</td>';
   		
   		// COL #2
   		htmlLines += '<td class="mail-subject" style="vertical-align:middle;">';
   		htmlLines += tycheesBean_toString_commonOperatingHour(operatingHourObj.openTimeDay, operatingHourObj.openTimeHour, operatingHourObj.openTimeMinute);
   		htmlLines += '</td>';
   		
   		// COL #3
   		htmlLines += '<td class="mail-subject" style="vertical-align:middle;">';
   		htmlLines += tycheesBean_toString_commonOperatingHour(operatingHourObj.closeTimeDay, operatingHourObj.closeTimeHour, operatingHourObj.closeTimeMinute);
   		htmlLines += '</td>';
   		
   		// COL #4
   		var buttonVal_makePublic = '<a onclick="set001_20_03_setToPublic(\'' + operatingHourObj.id + '\');" href="#" class="btn btn-warning btn-xs">Set to Default</a>';
	    var buttonVal_edit = '<a onclick="set001_20_03_editRow(\'' + operatingHourObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-pencil" aria-hidden="true"></i></a>';
	    var buttonVal_delete = '<a onclick="set001_20_03_deleteRow(\'' + operatingHourObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-times" aria-hidden="true"></i></a>';

	    if (operatingHourObj.showing==true)
	    {
	    	buttonVal_makePublic = '<a onclick="set001_20_03_makePublic(\'' + operatingHourObj.id + '\', false);" href="#" class="btn btn-danger btn-xs" style="color:#FFF;">Unpublish</a> ';
	    }
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += buttonVal_makePublic + ' ' + buttonVal_edit + ' ' + buttonVal_delete;
   		htmlLines += '</td>';
   		
   		// Add to html content
       	$('#set001_20_03_table').append(htmlLines);
    });
    
    $('#set001_20_03').show();
} // .end of set001_20_03_updateUI

/**
 * Hide Panel
 */
function set001_20_03_hide()
{
    $('#set001_20_03').hide();
} // .end of set001_20_03_hide

function set001_20_03_addNew()
{
    // Init contact object
    var operatingHourObj = createNew_PlaceOperatingHours();
    operatingHourObj.placeId = Cached_placeObj.id;
    operatingHourObj.openTimeDay = '0';
    operatingHourObj.openTimeHour = '0';
    operatingHourObj.openTimeMinute = '0';
    operatingHourObj.closeTimeDay = '0';
    operatingHourObj.closeTimeHour = '0';
    operatingHourObj.closeTimeMinute = '0';
    
    // Add into current place's address list
    Cached_placeObj.operatingHourList.push(operatingHourObj);
    // Display to UI
    set001_20_03_addRow(operatingHourObj);
    // Save to IndexedDB
    tycheesIO_saveBean(Cached_placeObj);
} // .end of set001_20_03_addNew

function set001_20_03_addRow(operatingHourObj)
{
    var buttonVal_makePublic = '<a onclick="set001_20_03_makePublic(\'' + operatingHourObj.id + '\', true);" href="#" class="btn btn-primary btn-xs">Make Public</a> ';
    var buttonVal_edit = '<a onclick="set001_20_03_editRow(\'' + operatingHourObj.id + '\');" href="#" class="btn btn-white btn-xs">Edit</a> ';
    var buttonVal_delete = '<a onclick="set001_20_03_deleteRow(\'' + operatingHourObj.id + '\');" href="#" class="btn btn-white btn-xs">Delete</a>';
    
    if (operatingHourObj.showing==true)
    {
        buttonVal_makePublic = '<a onclick="set001_20_03_makePublic(\'' + operatingHourObj.id + '\', false);" href="#" class="btn btn-primary btn-xs">Unpublish</a> ';
    }
    
    $('#set001_20_tab_operation_dataTable').dataTable().fnAddData( [
        tycheesBean_toString_commonOperatingHour(operatingHourObj.openTimeDay, operatingHourObj.openTimeHour, operatingHourObj.openTimeMinute),
        tycheesBean_toString_commonOperatingHour(operatingHourObj.closeTimeDay, operatingHourObj.closeTimeHour, operatingHourObj.closeTimeMinute),
        buttonVal_makePublic + buttonVal_edit + buttonVal_delete] );
} // .end of set001_20_03_addRow


function set001_20_03_makePublic(operatingHourId, showing) 
{
    $.each(Cached_placeObj.operatingHourList, function(index, operatingHourObj){
        if (operatingHourId==operatingHourObj.id)
        {
            operatingHourObj.showing = showing;
            operatingHourObj.hasChanged = true;
        }
    });

    // Save to indexedDB
    tycheesIO_saveBean(Cached_placeObj);
} // .end of set001_20_03_makePublic

function set001_20_03_editRow(operatingHourId) 
{
    $.each(Cached_placeObj.operatingHourList, function(i, operatingHourObj) {
        if (operatingHourId==operatingHourObj.id)
        {
            // Open PlaceOperatingHourBean editor
            set001_20_03_mw002_updateUI(operatingHourObj);
        }
    });
} // .end of set001_20_03_editRow

function set001_20_03_deleteRow(operatingHourId) 
{
    swal({
        title: "Are you sure?",
        text: "Delete this operating hour record [id=" + operatingHourId + "]?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete it!",
        closeOnConfirm: true,
        closeOnCancel: true
    }, 
    function (isConfirm) {
        
        if (isConfirm)
        {
            var removedIndex = -1;
            $.each(Cached_placeObj.operatingHourList, function(i, operatingHourObj){
                if (operatingHourId==operatingHourObj.id)
                {
                	// Remove object from memory cache
                	Cached_deleteBean(operatingHourObj);
                    // Update DataTable UI
                    set001_20_03_updateUI();
                    // Save to IndexedDB
                    tycheesIO_saveBean(Cached_placeObj);
                }
            });
        }
    });
    
} // .end of set001_20_03_deleteRow


/**
 * Update Place Address Object.
 */ 
function placeOperatingHour_save()
{
    // Get input values
    var idVal = $("#modalWindow-placeOperatingHour-editor-id").val();
    var openFromDay = $("#modalWindow-placeOperatingHour-editor-openFromDay").val();
    var openFromHourMinute = $("#modalWindow-placeOperatingHour-editor-openFromHourMinute").val();
    var closeOnDay = $("#modalWindow-placeOperatingHour-editor-closeOnDay").val();
    var closeOnHourMinute = $("#modalWindow-placeOperatingHour-editor-closeOnHourMinute").val();
    
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
    
    $.each(Cached_placeObj.operatingHourList, function(index, operatingHourObj){
        if (operatingHourObj.id==idVal)
        {
        	operatingHourObj.openTimeDay = Number(openFromDay);
            operatingHourObj.openTimeHour = Number(openFromHour);
            operatingHourObj.openTimeMinute = Number(openFromMinute);
        	operatingHourObj.closeTimeDay = Number(closeOnDay);
            operatingHourObj.closeTimeHour = Number(closeOnHour);
            operatingHourObj.closeTimeMinute = Number(closeOnMinute);
            
            $("#modalWindow-placeOperatingHour-editor").modal("hide");
            
            modalWindow_save();
        }
    });
} // .end of placeAddress_update

</script>