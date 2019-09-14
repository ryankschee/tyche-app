<style>
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- SET001_01_00: Store Settings - Address -->
<div id="set001_20_01" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	ADDRESS
	</span>
    <div class="ibox-content">
        <form user="form" class="form-inline">
        	<button class="btn btn-sm btn-white" type="button" onclick="set001_20_01_mw001_updateUI();">
        		<i class="fa fa-plus" aria-hidden="true"></i> 
        		Add New Address
        	</button>
        	<div class="input-group pull-right">
                <input type="text" class="form-control input-sm" name="search" placeholder="Search address">
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
                    <td class="table-thead-td" width="auto">TYPE</td>
                    <td class="table-thead-td" width="150px">ATTN TO</td>
                    <td class="table-thead-td" width="auto">ADDRESS</td>
                    <td class="table-thead-td" width="170px">ACTION</td>
                </tr>
            </thead>
            <tbody id="set001_20_01_table">
            </tbody>
        </table>
    </div>
</div>

<!-- Add Address -->	
<%@include file="/console/settings/set001/view/set001_20/set001_20_01_mw001.jsp" %>
<!-- Edit Address -->	
<%@include file="/console/settings/set001/view/set001_20/set001_20_01_mw002.jsp" %>

<script>

var set001_20_01_initialized = false;

/**
 * Init Panel
 */
function set001_20_01_init()
{
    if (set001_20_01_initialized == true)
        return false;
	
	set001_20_01_initialized = true;
} // .end of set001_20_01_init

/**
 * Show Panel
 */
function set001_20_01_updateUI()
{
    set001_20_01_init();
    
 	// Empty table
    $('#set001_20_01_table').empty();
    
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.addressList, function(i, addressObj) { 
    
    	if (Cached_isDeletedBean(addressObj))
    		return true;
    	
        var htmlLines = '';
       	htmlLines += '<tr class="read">';

       	// COL #1
   		htmlLines += '<td style="font-size:12pt; padding:12px auto; vertical-align:top;">';
   		htmlLines += addressObj.type;
   		htmlLines += '</td>';
   		
   		// COL #2
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += addressObj.attentionTo;
   		htmlLines += '</td>';
   		
   		// COL #3
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += tycheesBean_toString_commonAddressBean(addressObj);
   		htmlLines += '</td>';
   		
   		// COL #4
   		var buttonVal_makePrimary = '<a onclick="set001_20_01_setToDefault(\'' + addressObj.id + '\');" href="#" class="btn btn-warning btn-xs">Set to Default</a>';
	    var buttonVal_edit = '<a onclick="set001_20_01_editRow(\'' + addressObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-pencil" aria-hidden="true"></i></a>';
	    var buttonVal_delete = '<a onclick="set001_20_01_deleteRow(\'' + addressObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-times" aria-hidden="true"></i></a>';
	    
	    if (addressObj.defaultAddress==true)
	    {
	        buttonVal_makePrimary = '<a href="#" class="btn btn-primary btn-xs disabled">Default</a>';
	    }
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += buttonVal_makePrimary + ' ' + buttonVal_edit + ' ' + buttonVal_delete;
   		htmlLines += '</td>';
   		
   		// Add to html content
       	$('#set001_20_01_table').append(htmlLines);
    });
  	
    $('#set001_20_01').show();
} // .end of set001_20_01_updateUI

/**
 * Hide Panel
 */
function set001_20_01_hide()
{
    $('#set001_20_01').hide();
} // .end of set001_20_01_hide

function set001_20_01_setToDefault(addressId) 
{    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.addressList, function(i, addressObj){
        if (addressId==addressObj.id)
        {
            addressObj.defaultAddress = true;
            addressObj.hasChanged = true;
            placeObj.address = tycheesBean_toString_commonAddressBean(addressObj);
        }
        else
        {
            addressObj.defaultAddress = false;
            addressObj.hasChanged = true;
        }
    });
    
    // Update UI
    set001_20_01_updateUI();
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
} // .end of set001_20_01_setToDefault

function set001_20_01_editRow(addressId) 
{
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.addressList, function(i, addressObj){
        if (addressId==addressObj.id)
        {
        	// Load/Open ModalWIndow - Address Editor
        	set001_20_01_mw002_updateUI(addressObj);
        }
    });
} // .end of set001_20_01_editRow

function set001_20_01_deleteRow(addressId) 
{
    swal({
        title: "Are you sure?",
        text: "Delete this address record [id=" + addressId + "]?",
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
            var placeObj = tycheesCommon_getCurrentPlaceObject();
            $.each(placeObj.addressList, function(index, addressObj){
                if (addressId==addressObj.id)
                {
                    Cached_deleteBean(addressObj);
        			
                    if (addressObj.defaultAddress==true)
                    {
                    	placeObj.address = '';
                    }
                    
                    // Update dataTable UI
                    set001_20_01_updateUI();
                    // Save to IndexedDB
                    tycheesIO_saveBean(placeObj);
                }
            });
        }
    });
} // .end of set001_20_01_deleteRow


</script>