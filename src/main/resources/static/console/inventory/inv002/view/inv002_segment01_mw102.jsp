<!-- Modal Window: Edit Category Field -->
<div class="modal inmodal fade" id="segment01_mw102" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">EDIT CATEGORY FIELD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
                <div class="form-group">
                	<label>Field Name</label> 
                	<input id="segment01_mw102_propName" type="text" placeholder="Enter the name for this custom field" class="form-control">
                	<label>Field Type</label> 
                	<select id="segment01_mw102_propType" class="form-control" onchange="segment01_mw102_onChange_propType(this);">
					  <option value="Text">Text</option>
					  <option value="Number">Number</option>
					  <option value="List">List</option>
					  <option value="Tag">Tags Input</option>
					  <option value="Boolean">Yes/No</option>
					  <option value="Date">Date</option>
					  <option value="Time">Time</option>
					</select>					
					<div id="segment01_mw102_propContent_tags" style="display:none;">
						<label id="segment01_mw102_propContent_label">Selection List <small>(separate each selection with comma)</small></label>
						<br/> 
                		<input id="segment01_mw102_propContent" type="text" placeholder="" class="form-control" data-role="tagsinput" />
					</div>
					
					<br>
					<label>Visibility</label> 
					<br>
					<input type="checkbox" id="segment01_mw102_fieldRequired" class="i-checks" name="segment01_mw102_fieldRequired" checked /> 
					<label id="segment01_mw102_fieldLabelRequired" for='segment01_mw102_fieldRequired'>Is this mandatory field?</label>
					<!-- 
					<br><br>
					<label>Inherited Field?</label> 
					<br>
					<input type='checkbox' id='segment01_mw102_fieldInherited' class="i-checks" name="segment01_mw102_fieldInherited" checked /> 
					<label id="modalWindow_editField_fieldLabelInherited" for='modalWindow_editField_fieldLabelInherited'>Check for Yes</label>	
					 -->
					<input type="hidden" id="segment01_mw102_categoryId" value="" />
					<input type="hidden" id="segment01_mw102_propId" value="" />
					<input type="hidden" id="segment01_mw102_fieldInheritedCategoryId" value="" />
					<input type="hidden" id="segment01_mw102_fieldRowNo" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment01_mw102_saveChanges();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Update Field</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment01_mw102_callbackFn;
var segment01_mw102_callbackFnParams;

/**
 * Response to user selection change on field type.
 */ 
function segment01_mw102_onChange_propType(element)
{
	var selectedValue = $(element).val();
	if (selectedValue == InventoryConstants.PROP_TYPE_TAG || 
		selectedValue == InventoryConstants.PROP_TYPE_LIST)
	{
		$('#segment01_mw102_propContent_tags').show();
	}
	else
	{
		$('#segment01_mw102_propContent_tags').hide();
	}
	
} // .end of segment01_mw102_onChange_propType

function segment01_mw102_isOpen()
{
	return ($("#segment01_mw102").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw102_isOpen

function segment01_mw102_init()
{
	$('#segment01_mw102').on('shown.bs.modal', function () {
	    $("#segment01_mw102_propName").focus();
	});
}

/**
 * Triggered by: button 'Edit' (main screen) on any class field was clicked.
 * Action: copy value from field in Main Screen, into field in Modal Window (edit)
 */ 
function segment01_mw102_open(postHandlerFn, postHandlerFnParams) 
{
	// Set callback 
	segment01_mw102_callbackFn = postHandlerFn;
	segment01_mw102_callbackFnParams = postHandlerFnParams;

	var rowNo = segment01_mw102_callbackFnParams.rowNo;
	var propObj = segment01_mw102_callbackFnParams.propObj;
	
    // Get check/uncheck status from page screen.
	var rowCheckbox = $("#required-"+propObj.id+'-'+rowNo)[0].checked;
    	
	// IF current row checkbox is TRUE AND modalWindow checkbox is FALSE, THEN set checkbox to TRUE. 
	if (rowCheckbox==true && $('input:checkbox[name=segment01_mw102_fieldRequired]')[0].checked==false)
		$("#segment01_mw102_fieldLabelRequired").click();
	// IF current row checkbox is FALSE AND modalWindow checkbox is TRUE, THEN set checkbox to FALSE. 
	if (rowCheckbox==false && $('input:checkbox[name=segment01_mw102_fieldRequired]')[0].checked==true)
		$("#segment01_mw102_fieldLabelRequired").click();
	
	// Set values into modalWindow
	$("#segment01_mw102_propId").val(propObj.id);
	$("#segment01_mw102_categoryId").val(propObj.categoryId);
	$("#segment01_mw102_propName").val(propObj.propName);
	$("#segment01_mw102_propType").val(propObj.propType);
	$("#segment01_mw102_fieldRowNo").val(rowNo);
	
	if (propObj.propType == InventoryConstants.PROP_TYPE_TAG || 
	    propObj.propType == InventoryConstants.PROP_TYPE_LIST)
	{
		// Add into tagsinput
		$('#segment01_mw102_propContent').tagsinput('removeAll');
		var propContentArray = propObj.propContent.split(',');
		$.each(propContentArray, function(i, tagVal){
			if ($.trim(tagVal).length > 0)
				$("#segment01_mw102_propContent").tagsinput('add', tagVal);
		});
		$("#segment01_mw102_propContent").tagsinput('refresh');
	
		$('#segment01_mw102_propContent_tags').show();
	}
	else
	{
		$("#segment01_mw102_propContent").tagsinput('removeAll');
		$('#segment01_mw102_propContent_tags').hide();
	}
	
	// Show Modal Dialog
	module_showModalWindow('segment01_mw102', false);	
} // .end of segment01_mw102_open

/**
 * Save updated Category Field
 */ 
function segment01_mw102_saveChanges()
{
	tycheesOverlay_startShortProgress('Saving...');
	
    //var categoryObj = Cached_getCategoryById( $("#segment01_mw102_categoryId").val() );
	var categoryObj = segment01_mw102_callbackFnParams.categoryObj;
	
	// Get value from input
	var propId = $("#segment01_mw102_propId").val();
	var propName = $("#segment01_mw102_propName").val();
	var propType = $("#segment01_mw102_propType").val();
	var propContent = $("#segment01_mw102_propContent").val();
	var fieldRequired = $("#segment01_mw102_fieldRequired").is(":checked");
	//var fieldInherited = $("#segment01_mw102_fieldInherited").is(":checked");
	//var fieldInheritedCategoryId = $("#segment01_mw102_fieldInheritedCategoryId").val();
	var rowNo = $("#segment01_mw102_fieldRowNo").val();
	
	// CHECK #1: If propName is empty
	var errorFound = false;
	if ( $.trim(propName).length==0)
	{
		errorFound = true;
		swal({
        	title: 'Invalid Properties Name',
            text: 'Please enter a valid Properties Name',
            type: "error"
	        },
  	    function(){
  	    });	
	}
	
	if (errorFound==true)
		return "ERROR";
	
	// CHECK #2: If duplication of field name found
	var sameFieldNameCount = 0;
	var duplicateNameFound = false;
	var matchPropObj = null;
	
	$.each(categoryObj.propertiesList, function(i, propObj){
	    // Different field entry, but same name
		if (propId != propObj.id && $.trim(propName) == propObj.propName) 
		{
			duplicateNameFound = true;
			swal({
           	   title: 'Duplicated Properties Name found',
               text: 'Please enter different Properties name.',
               type: "error"
   	        },
     	    function(){
     	    });	
		}
		
		if (propObj.id == propId)
		    matchPropObj = propObj;
	});
	
	if (duplicateNameFound==true || sameFieldNameCount > 1)
		return "ERROR";
		    	
	var checkedVal = '';
	if (fieldRequired == true)
		checkedVal = 'checked';
		
    matchPropObj.propName 		= tycheesText_getSafeString(propName);
    matchPropObj.propKey 		= tycheesText_getSafeString('propKey' + tycheesText_getSafeString_withoutSpace(propName));
    matchPropObj.propType 		= tycheesText_getSafeString(propType);
    matchPropObj.propContent 	= tycheesText_getSafeString(propContent);
    matchPropObj.required 		= fieldRequired;
    matchPropObj.hasChanged     = true;
    
	// Save
	tycheesIO_saveBean(categoryObj);
	// Hide Modal Window
	$('#segment01_mw102').modal('hide');	
	// Callback
	segment01_mw102_callbackFnParams.categoryObj = categoryObj;
	segment01_mw102_callbackFn(true, segment01_mw102_callbackFnParams);
} // .end of segment01_mw102_saveChanges

</script>