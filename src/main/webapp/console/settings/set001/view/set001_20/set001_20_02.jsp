<style>	
	.table-thead-td {
   		padding-top: 2px !important; 
   		padding-bottom: 2px !important;
   	}
</style>

<!-- SET001_01_00: Store Settings - Phone -->
<div id="set001_20_02" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	CONTACT
	</span>
	<div class="ibox-content">
        <form user="form" class="form-inline">
        	<button class="btn btn-sm btn-white" type="button" onclick="set001_20_02_mw001_updateUI();">
        		<i class="fa fa-plus" aria-hidden="true"></i> 
        		Add New Contact
        	</button>
        	<div class="input-group pull-right">
                <input type="text" class="form-control input-sm" name="search" placeholder="Search contact">
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
                    <th class="table-thead-td">TYPE</th>
				    <th class="table-thead-td">COUNTRY</th>
				    <th class="table-thead-td">AREA</th>
				    <th class="table-thead-td">PHONE NUMBER</th>
				    <th class="table-thead-td">EXTENSION</th>
				    <th class="table-thead-td" width="170px">ACTION</th>
                </tr>
            </thead>
            <tbody id="set001_20_02_table">
            </tbody>
        </table>
    </div>
</div>

<!-- Add Contact -->	
<%@include file="/console/settings/set001/view/set001_20/set001_20_02_mw001.jsp" %>
<!-- Edit Contact -->	
<%@include file="/console/settings/set001/view/set001_20/set001_20_02_mw002.jsp" %>

<script>

var set001_20_02_initialized = false;

/**
 * Init Panel
 */
function set001_20_02_init()
{
    if (set001_20_02_initialized == true)
        return false;
    
	set001_20_02_initialized = true;
} // .end of set001_20_02_init

/**
 * Show Panel
 */
function set001_20_02_updateUI()
{
    set001_20_02_init();

 	// Empty table
    $('#set001_20_02_table').empty();
    
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.contactList, function(i, contactObj) { 
    
    	if (Cached_isDeletedBean(contactObj))
    		return true;
    	
        var htmlLines = '';
       	htmlLines += '<tr class="read">';

       	// COL #1
   		htmlLines += '<td style="font-size:12pt; padding:12px auto; vertical-align:top;">';
   		htmlLines += contactObj.type;
   		htmlLines += '</td>';
   		
   		// COL #2
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += '+' + contactObj.countryCode;
   		htmlLines += '</td>';
   		
   		// COL #3
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += contactObj.areaCode;
   		htmlLines += '</td>';

   		// COL #4
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += contactObj.phoneNumber;
   		htmlLines += '</td>';

   		// COL #5
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += contactObj.extension;
   		htmlLines += '</td>';
   		
   		// COL #6
   		var buttonVal_makePrimary = '<a onclick="set001_20_02_setToDefault(\'' + contactObj.id + '\');" href="#" class="btn btn-warning btn-xs">Set to Default</a>';
	    var buttonVal_edit = '<a onclick="set001_20_02_editRow(\'' + contactObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-pencil" aria-hidden="true"></i></a>';
	    var buttonVal_delete = '<a onclick="set001_20_02_deleteRow(\'' + contactObj.id + '\');" href="#" class="btn btn-white btn-xs"><i class="fa fa-times" aria-hidden="true"></i></a>';
	    
	    if (contactObj.defaultContact==true)
	    {
	        buttonVal_makePrimary = '<a href="#" class="btn btn-primary btn-xs disabled">Default</a>';
	    }
   		htmlLines += '<td class="mail-subject">';
   		htmlLines += buttonVal_makePrimary + ' ' + buttonVal_edit + ' ' + buttonVal_delete;
   		htmlLines += '</td>';
   		
   		// Add to html content
       	$('#set001_20_02_table').append(htmlLines);
    });
    $('#set001_20_02').show();
} // .end of set001_20_02_updateUI

/**
 * Hide Panel
 */
function set001_20_02_hide()
{
    $('#set001_20_02').hide();
} // .end of set001_20_02_hide

function set001_20_02_setToDefault(contactId) 
{    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var contactType = '';
    $.each(placeObj.contactList, function(i, contactObj){
    	if (contactObj.id == contactId)
    		contactType = contactObj.type;
    });
        
    $.each(placeObj.contactList, function(i, contactObj){
    	
    	if (contactObj.type == contactType)
    	{
    		if (contactId==contactObj.id)
            {
            	contactObj.defaultContact = true;
            	contactObj.hasChanged = true;
            	
            	if (contactObj.type=='Mobile')
                	placeObj.mobile = tycheesBean_toString_commonContactBean(contactObj);
            	else
            		placeObj.phone = tycheesBean_toString_commonContactBean(contactObj);
            }
            else
            {
            	contactObj.defaultContact = false;
            	contactObj.hasChanged = true;
            }
    	}
    });
    
    // Update UI
    set001_20_02_updateUI();
    // Save to IndexedDB
    tycheesIO_saveBean(placeObj);
} // .end of set001_20_01_setToDefault

function set001_20_02_editRow(contactId) 
{
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    $.each(placeObj.contactList, function(i, contactObj){
        if (contactId==contactObj.id)
        {
        	// Load/Open ModalWIndow - Contact Editor
        	set001_20_02_mw002_updateUI(contactObj);
        }
    });
} // .end of set001_20_02_editRow

function set001_20_02_deleteRow(contactId) 
{
    swal({
        title: "Are you sure?",
        text: "Delete this contact record [id=" + contactId + "]?",
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
            $.each(placeObj.contactList, function(index, contactObj){
                if (contactId==contactObj.id)
                {
                    Cached_deleteBean(contactObj);
        			
                    if (contactObj.defaultContact==true)
                    {
                    	if (contactObj.type='Mobile')
                    		placeObj.mobile = '';
                    	else
                    		placeObj.phone = '';
                    }
                    
                    // Update dataTable UI
                    set001_20_02_updateUI();
                    // Save to IndexedDB
                    tycheesIO_saveBean(placeObj);
                }
            });
        }
    });
} // .end of set001_20_02_deleteRow

</script>