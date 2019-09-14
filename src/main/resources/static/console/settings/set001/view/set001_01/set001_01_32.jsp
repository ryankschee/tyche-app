
<!-- set001_01_32: Billing Settings - Printable Documents -->
<div id="set001_01_32" style="display:none; padding-top:10px;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	SEARCH WINDOW: Billing Search
	</span>
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <tbody id="set001_01_32_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var set001_01_32_initialized = false;

/**
 * Init Panel
 */
function set001_01_32_init()
{
    if (set001_01_32_initialized == true)
        return false;
            
	set001_01_32_initialized = true;
} // .end of set001_01_32_init

/**
 * Show Panel
 */
function set001_01_32_updateUI()
{
    set001_01_32_init();

    var settingsList = Cached_getSettingsListByModule( 
			            ModuleConstants.MODULE_BILLING, 
			            ModuleConstants.MODULE_BILLING_SUB_ORDER_SEARCH);
	// Sort asc
	settingsList.sort(function(a, b){
		return a.propSeqno - b.propSeqno;
	});

    var lastGroupName = '';
    var thisGroupName = '';
    
	$('#set001_01_32_table').empty();
    $.each(settingsList, function(i, settingsObj){
    	
    	thisGroupName = settingsObj.groupName;
    	
    	if (lastGroupName != thisGroupName)
    	{
    		var group_htmlLines = '';
    		group_htmlLines += '<tr style="background-color:#555;">';
    		group_htmlLines += '<td colspan="2" style="font-weight:bold; color:#fff; padding-top:2px; padding-bottom:2px;">';
    		group_htmlLines += thisGroupName
    		group_htmlLines += '</td>';
    		group_htmlLines += '</tr>';
    		
        	$('#set001_01_32_table').append(group_htmlLines);
    	}
    	  
       	var htmlLines = '';
       	htmlLines += '<tr class="read">';
       	
       	// COL #1
   		htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
   		htmlLines += settingsObj.propName;
   		htmlLines += '</td>';
   		
   		// COL #2
   		htmlLines += '<td class="mail-date">' + settingsCommon_getInputComponent(settingsObj) + '</td>';
   		
   		// COL #3
   		//htmlLines += '<td class="mail-subject">' + settingsObj.remarks + '</td>';
   		//htmlLines += '</tr>';
   		
       	$('#set001_01_32_table').append(htmlLines);

       	// Register events
       	settingsCommon_addEventListeners( settingsObj );
	    // Set lastGroupName
	    lastGroupName = thisGroupName;
    });
    
    $('#set001_01_32').show();
} // .end of set001_01_32_updateUI

/**
 * Hide Panel
 */
function set001_01_32_hide()
{
    $('#set001_01_32').hide();
} // .end of set001_01_32_hide

</script>