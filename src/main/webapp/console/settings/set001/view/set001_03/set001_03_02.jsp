<!-- SET001_03_01: Customer Template -->
<div id="set001_03_02" style="display:none;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	PROFILE TEMPLATE
	</span>
    <div class="ibox-content">
        <form role="form" class="form-inline">
        	<span style="font-size:12pt;">Select Template: </span>
            <div class="form-group">
                <label for="set001_03_02_templateList" class="sr-only">Customer Profile Template List</label>
                <select id="set001_03_02_templateList" class="form-control" style="width:350px;" onchange="set001_03_02_templateChanged();">                	
                </select>
            </div>
            <button class="btn btn-white" type="button" onclick="set001_03_02_addTemplate();"><i class="fa fa-plus" aria-hidden="true"></i></button>
            <button class="btn btn-white" type="button" onclick="set001_03_02_editTemplate();"><i class="fa fa-pencil" aria-hidden="true"></i></button>
            <button class="btn btn-white" type="button" onclick="set001_03_02_deleteTemplate();"><i class="fa fa-times" aria-hidden="true"></i></button>
            <button class="btn btn-warning pull-right" type="button" onclick="set001_03_02_addProperties();"><i class="fa fa-plus" aria-hidden="true"></i> Properties</button>
        </form>
    </div>
    <div>
    	<ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
          	<span id="set001_03_02_propertiesList"></span>
        </ul>
    </div>
</div>

<!-- Add Template -->
<%@include file="/console/settings/set001/view/set001_03/set001_03_02_mw001.jsp" %>
<!-- Edit Template -->
<%@include file="/console/settings/set001/view/set001_03/set001_03_02_mw002.jsp" %>
<!-- Add Properties -->
<%@include file="/console/settings/set001/view/set001_03/set001_03_02_mw003.jsp" %>
<!-- Edit Properties -->
<%@include file="/console/settings/set001/view/set001_03/set001_03_02_mw004.jsp" %>

<script>

var set001_03_02_initialized = false;

/**
 * Init Panel
 */
function set001_03_02_init()
{
    if (set001_03_02_initialized == true)
        return false;
        
	set001_03_02_initialized = true;
} // .end of set001_03_02_init

/**
 * Show Panel
 */
function set001_03_02_updateUI(givenTemplateId)
{
    set001_03_02_init();
    
    // Get Place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    
 	// Extract & Process List
    var sortedTemplateList = [];
    $.each(placeObj.templateList, function(i, templateObj){
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	
    	if (templateObj.moduleId == ModuleConstants.MODULE_RELATION &&
    		templateObj.templateType == PlaceConstants.TEMPLATE_TYPE_CUSTOMER_PROFILE)
    	{
    		sortedTemplateList.push(templateObj);
    	}
    });
    // Sort list, by template name
    sortedTemplateList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.templateName, b.templateName);
		});

    var defaultTemplateId = '';
    
    // Populate Template List
    $('#set001_03_02_templateList').empty();
    $('#set001_03_02_templateList').append('<option value="">-- SELECT --</option>')
    $.each(sortedTemplateList, function(i, templateObj){

    	if (templateObj.defaultTemplate)
    		defaultTemplateId = templateObj.id;
    	
    	var selectedVal = '';
    	if (templateObj.id == givenTemplateId)
    		selectedVal = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + templateObj.id + '" ' + selectedVal + '>';
    	htmlLines += templateObj.templateName;
    	htmlLines += '</option>';
    	
    	$('#set001_03_02_templateList').append( htmlLines );
    });

    if (givenTemplateId == null && defaultTemplateId != '')
    	$('#set001_03_02_templateList').val(defaultTemplateId);
    
    // Reload properties based on selected template
    set001_03_02_reloadTemplate();
    
    $('#set001_03_02').show();
} // .end of set001_03_02_updateUI


function set001_03_02_reloadTemplate()
{
	var templateId = $('#set001_03_02_templateList').val();
	var templateObj = set001_03_02_getPlaceTemplateById(templateId);
	
	// Clear list of properties
	$('#set001_03_02_propertiesList').empty();
	
	if (templateObj != null) 
	{
		// Extract & Process List
	    var sortedList = [];
	    $.each(templateObj.propertiesList, function(i, propertiesObj){
	    	sortedList.push(propertiesObj);
	    });
	    // Sort list, by group name
	    sortedList.sort(
			function(a, b){ 
				return tycheesList_sortByString(a.groupName, b.groupName);
			});
		

	    var lastGroupName = '$TEMP_VALUE$';
		$('#set001_03_02_propertiesList').empty();
		$.each(sortedList, function(j, propertiesObj){

	    	if (Cached_isDeletedBean(propertiesObj))
	    		return true;
	    	
			if (lastGroupName != propertiesObj.groupName)
	    	{
				var groupName = propertiesObj.groupName=='' ? 'No Group' : propertiesObj.groupName;
	    		
	    	    var dividerHtmlLines = '';		    	    
	    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding-left:10px;">';
	    	    dividerHtmlLines += groupName;
	    	    dividerHtmlLines += '</li>';	    	    
	    	    $('#set001_03_02_propertiesList').append(dividerHtmlLines);
	    	    
				// For next iteration
	    	    lastGroupName = propertiesObj.groupName;	    	    
	    	}
			
			var htmlLines = '';
			htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
			htmlLines += '<span style="height:25px;margin-top:5px;">';
			htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
			htmlLines += propertiesObj.propKey;
			htmlLines += '</span>';
			htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
			htmlLines += '<span style="padding-left:10px;padding-right:5px;">';
			htmlLines += '<i class="fa fa-pencil" aria-hidden="true" style="cursor:pointer;" onclick="set001_03_02_editProperties(\'' + templateId + '\',\'' + propertiesObj.id  + '\');"></i>';
			htmlLines += '</span>';
			htmlLines += '<span style="padding-left:5px;padding-right:10px;">';
			htmlLines += '<i class="fa fa-times-circle" aria-hidden="true" style="cursor:pointer;color:#ff0000;" onclick="set001_03_02_deleteProperties(\'' + templateId + '\',\'' + propertiesObj.id  + '\');"></i>'; 
			htmlLines += '</span>';
			htmlLines += '</span>';
			htmlLines += '<span class="pull-right"> ';
			htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
			htmlLines += '</span>';
			htmlLines += '</li>';
			
			$('#set001_03_02_propertiesList').append(htmlLines);
		});
	}
} // .end of set001_03_02_reloadTemplate

/**
 * Hide Panel
 */
function set001_03_02_hide()
{
    $('#set001_03_02').hide();
} // .end of set001_03_02_hide

function set001_03_02_addTemplate()
{
	set001_03_02_mw001_show();
} // .end of set001_03_02_addTemplate

function set001_03_02_editTemplate()
{
	var selectedTemplateId = $('#set001_03_02_templateList').val();
	set001_03_02_mw002_show( selectedTemplateId );
} // .end of set001_03_02_editTemplate

function set001_03_02_deleteTemplate()
{
	var templateId = $('#set001_03_02_templateList').val();
	
	if (templateId==null || templateId=='') {
		tycheesLogger_showToast('warning','No template selected','Please select a template.');
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this template record!",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  confirmButtonText: "Yes, delete it!",
		  cancelButtonText: "No, cancel plx!",
		  closeOnConfirm: true,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  	if (isConfirm) 
		  	{
		  		var placeObj = tycheesCommon_getCurrentPlaceObject();
		  		$.each(placeObj.templateList, function(i, templateObj){
		  			if (templateObj.id == templateId)
		  			{
		  				Cached_deleteBean(templateObj);

				  		// Save to IndexedDB
				    	tycheesIO_saveBean(placeObj);
				  		// Refresh UI
				    	set001_03_02_updateUI();
		  			}
		  		});		  		
		  	}
		});
} // .end of set001_03_02_deleteTemplate

function set001_03_02_templateChanged()
{
	var selectedTemplateId = $('#set001_03_02_templateList').val();
	set001_03_02_updateUI( selectedTemplateId );
} // .end of set001_03_02_addTemplate

function set001_03_02_addProperties()
{
	var selectedTemplateId = $('#set001_03_02_templateList').val();
	set001_03_02_mw003_show( selectedTemplateId );
} // .end of set001_03_02_addProperties

function set001_03_02_editProperties(templateId, propertiesId)
{
	set001_03_02_mw004_show( templateId, propertiesId );
} // .end of set001_03_02_editProperties

function set001_03_02_deleteProperties(templateId, propertiesId)
{
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this properties record!",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  confirmButtonText: "Yes, delete it!",
		  cancelButtonText: "No, cancel plx!",
		  closeOnConfirm: true,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  	if (isConfirm) 
		  	{
		  		var templateObj = set001_03_02_getPlaceTemplateById(templateId);
		  		$.each(templateObj.propertiesList, function(i, propObj){
		  			if (propObj.id == propertiesId)
		  			{
		  				Cached_deleteBean(propObj);
				  		// Set Flag
				  		templateObj.hasChanged = true;
				  		// Save to IndexedDB
				    	tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
				  		// Refresh UI
				    	set001_03_02_updateUI(templateObj.id);
		  			}
		  		});
		  	}
		});
} // .end of set001_03_02_deleteProperties


/**
 * Get Template by Id
 */
function set001_03_02_getPlaceTemplateById(templateId)
{
	var l_placeObj = tycheesCommon_getCurrentPlaceObject();
	
	var foundObj;
	$.each(l_placeObj.templateList, function(i, templateObj){
		if (templateObj.id==templateId)	
			foundObj = templateObj;
	});
	
	return foundObj;
} // .end of set001_03_02_getPlaceTemplateById


</script>
