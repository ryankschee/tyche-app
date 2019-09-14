<!-- SET001_01_05: Billing Settings - Payments -->
<div id="set001_03_00" style="display:none;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	GENERAL
	</span>
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <tbody id="set001_03_00_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var set001_03_00_initialized = false;

/**
 * Init Panel
 */
function set001_03_00_init()
{
    if (set001_03_00_initialized == true)
        return false;
            
	set001_03_00_initialized = true;
} // .end of set001_03_00_init

/**
 * Show Panel
 */
function set001_03_00_updateUI()
{
    set001_03_00_init();
    
    var settingsList = Cached_getSettingsListByModule( 
                        ModuleConstants.MODULE_RELATION, 
                        ModuleConstants.MODULE_RELATION_SUB_CUSTOMER);
    // Sort asc
    settingsList.sort(function(a, b){
		return a.propSeqno - b.propSeqno;
	});
    
    var lastGroupName = '';
    var thisGroupName = '';
    
	$('#set001_03_00_table').empty();
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
    		
        	$('#set001_03_00_table').append(group_htmlLines);
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
		
    	$('#set001_03_00_table').append(htmlLines);
        	
	    // Register events
	    settingsCommon_addEventListeners( settingsObj );
	    
	    lastGroupName = thisGroupName;
    });
  	
    $('#set001_03_00').show();
} // .end of set001_03_00_updateUI

/**
 * Hide Panel
 */
function set001_03_00_hide()
{
    $('#set001_03_00').hide();
} // .end of set001_03_00_hide

</script>