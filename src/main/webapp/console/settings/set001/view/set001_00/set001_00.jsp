<!-- SET001_01: General Settings -->
<div id="set001_00" style="display:none;">
    <div class="mail-box-header">
        <form method="get" action="index.html" class="pull-right mail-search">
            <div class="input-group">
                <input id="set001_00_searchField" type="text" class="form-control input-sm" name="search" placeholder="Search">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-primary">
                        Search
                    </button>
                </div>
            </div>
        </form>
        <h2>
            GENERAL SETTINGS
        </h2>
        <!--
        <div class="mail-tools tooltip-demo m-t-md" style="display:none;">
            <div class="btn-group pull-right">
                <button class="btn btn-white btn-sm"><i class="fa fa-arrow-left"></i></button>
                <button class="btn btn-white btn-sm"><i class="fa fa-arrow-right"></i></button>
            </div>
            <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="Refresh inbox"><i class="fa fa-refresh"></i> Refresh</button>
            <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as read"><i class="fa fa-eye"></i> </button>
            <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as important"><i class="fa fa-exclamation"></i> </button>
            <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Move to trash"><i class="fa fa-trash-o"></i> </button>
        </div>
        -->
    </div>
    
    <div class="mail-box">
        <table class="table table-hover table-mail">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td>NAME</td>
                    <td>VALUE</td>
                    <td>DESCRIPTION</td>
                </tr>
            </thead>
            <tbody id="set001_00_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var set001_00_initialized = false;

/*******************************************************************************
 * Init Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_00_init()
{
    if (set001_00_initialized == true)
        return false;
    
    // Register event for search field
    $('#set001_00_searchField').on('input propertychange paste', function() {
        
        var searchText = $('#set001_00_searchField').val();
        console.log( "Handler for .change() called. [searchText=" + searchText + ']' );
    });
        
	set001_00_initialized = true;
} // .end of set001_00_init

/*******************************************************************************
 * Show Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_00_updateUI()
{
    set001_00_init();
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
    // Extract & Process List
    var sortedList = [];
    $.each(placeObj.settingsList, function(i, settingsObj){
    	if (settingsObj.moduleId == ModuleConstants.MODULE_GENERAL)
    	{
    	    sortedList.push(settingsObj);
    	}
    });
    // Sort list, by group name
    sortedList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.groupName, b.groupName);
		});
    
    var lastGroupName = '';
    $('#set001_00_table').empty();
    $.each(sortedList, function(i, settingsObj){
    	
    	if (lastGroupName != settingsObj.groupName)
    	{
    	    lastGroupName = settingsObj.groupName;
    	    
    	    var dividerHtmlLines = '';
    	    dividerHtmlLines += '<tr class="unread">';
            dividerHtmlLines += '<td style="font-size:12pt;color:#337ab7;padding-top:6px;padding-bottom:6px;" colspan="3">';
            dividerHtmlLines += '<i class="fa fa-plus-square-o" aria-hidden="true" style="cursor:pointer;" onclick="set001_00_toggleGroup(this, \'' + tycheesText_getSafeString_withoutSpace(lastGroupName) + '\');"></i> ';
            dividerHtmlLines += lastGroupName;
            dividerHtmlLines += '</td>';
    	    dividerHtmlLines += '</tr>';
    	    
    	    $('#set001_00_table').append(dividerHtmlLines);
    	}
    	
    	var htmlLines = '';
    	htmlLines += '<tr class="read ' + tycheesText_getSafeString_withoutSpace(lastGroupName) + '" style="display:none;">';
    	
    	// COL #1
		htmlLines += '<td style="font-size:12pt;padding:12px auto;vertical-align:middle;">';
		htmlLines += '&nbsp;&nbsp;&nbsp;&nbsp;- ';
		htmlLines += settingsObj.propName;
		htmlLines += '</td>';
		
		// COL #2
		htmlLines += '<td class="mail-date">' + settingsCommon_getInputComponent(settingsObj) + '</td>';
		
		// COL #3
		htmlLines += '<td class="mail-subject">' + settingsObj.remarks + '</td>';
		htmlLines += '</tr>';
		
    	$('#set001_00_table').append(htmlLines);
    	
    	
    	if (settingsObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_TEXT)
    	{
    	    $('#'+settingsObj.id).on('input propertychange paste', function() {                
                settingsObj.propValue = $('#'+settingsObj.id).val();    
                settingsObj.hasChanged = true;
                
                tycheesIO_saveBean(placeObj);
            });
    	}
    	if (settingsObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_BOOLEAN)
        {
            $('#'+settingsObj.id).on('change', function() {
                settingsObj.propValue = $('#'+settingsObj.id).prop('checked').toString();     
                settingsObj.hasChanged = true;
                               
                tycheesIO_saveBean(placeObj); 
            });
        }
        if (settingsObj.propType==AppConstants.COMMON_PROPERTIES_TYPE_SELECT)
        {
            $('#'+settingsObj.id).on('change', function() {
                settingsObj.propValue = $('#'+settingsObj.id).val();         
                settingsObj.hasChanged = true;
                              
                tycheesIO_saveBean(placeObj);
            });
        }
    });
  	
    $('#set001_00').show();
} // .end of set001_00_updateUI

/*******************************************************************************
 * Hide Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_00_hide()
{
    $('#set001_00').hide();
} // .end of set001_00_hide

/*******************************************************************************
 * Refresh UI
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_00_reloadUI()
{

} // .end of set001_00_reloadUI

/*******************************************************************************
 * Toggle settings rows by groupName (expand/collapse)
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function set001_00_toggleGroup(element, groupNameClass)
{
    // now is expanded, so go collapse
    if ($(element).hasClass('fa-minus-square-o'))
    {
        $('.'+groupNameClass).hide();
        $(element).removeClass('fa-minus-square-o');
        $(element).addClass('fa-plus-square-o');
    }
    // now is collapsed, so go expand
    else
    {
        $('.'+groupNameClass).show();
        $(element).addClass('fa-minus-square-o');
        $(element).removeClass('fa-plus-square-o');
    }
} // .end of set001_00_toggleGroup
	  
</script>