<!-- Modal Window: Add Category -->
<div class="modal inmodal fade" id="segment01_mw001" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg2" id="segment01_mw001_frame">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">NEW INVENTORY CATEGORY</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
				<div class="row">
	                <div class="col-lg-12">  
	                	<form role="form" id="segment01_mw001_theForm">
		                    <div id="segment01_mw001_statusMessageList" style="display:none;">
		                    	<span>
		                    	</span>
		                    </div>
		                	<div class="tabs-container">
			                    <ul class="nav nav-tabs">
			                        <li class="active">
			                            <a data-toggle="tab" href="#segment01_mw001_tab_1"> 
			                                Basic Info
			                            </a>
			                        </li>
			                        <li>
			                            <a data-toggle="tab" href="#segment01_mw001_tab_2"> 
			                                Properties
			                            </a>
			                        </li>		                        
			                    </ul>
		                        <div class="tab-content">
		                            <div id="segment01_mw001_tab_1" class="tab-pane active">
		                                <div class="panel-body">
		                                    <fieldset class="form-horizontal">
		                                    	<div class="form-group">
		                                    		<label class="col-sm-3 control-label">
		                                    		    Parent Category
		                                    		</label>
		                                            <div class="col-sm-9 input-group">
		                                                <select class="form-control" id="segment01_mw001_parentClass">
		                                                </select>
		                                            </div>
		                                        </div> 
						                        <div class="hr-line-dashed"></div>
		                                        <div class="form-group">
		                                        	<label class="col-sm-3 control-label">
		                                        	    * Category Name
		                                        	</label>
		                                            <div class="col-sm-9 input-group">
		                                            	<input type="text" class="form-control" id="segment01_mw001_name" name="Category Name" placeholder="Category Name" maxlength="45" autofocus required>
		                                            </div>
		                                        </div>  
		                                        <div class="form-group">
		                                        	<label class="col-sm-3 control-label">
		                                        	    Seq.No. in POS
		                                        	</label>
		                                            <div class="col-sm-9 input-group">
		                                            	<input type="number" class="form-control" id="segment01_mw001_seqno" name="Sequence Number in POS" placeholder="Sequence Number in POS">
		                                            	<small>Smaller number in higher (left-most) position.</small>
		                                            </div>
		                                        </div>  
		                                    </fieldset>
		                                </div>
		                            </div> <!-- .end of tab-1 -->
		                            <div id="segment01_mw001_tab_2" class="tab-pane">
		                                <div class="panel-body">
		                                    <fieldset class="form-horizontal">
		                                    	<div class="form-group">	                                        	
		                                        	<label class="col-sm-3 control-label">
		                                        	    Inherited Fields
		                                        	    <br>
		                                        	    <span style="color:#337ab7;font-weight:normal;font-style: italic;">
															Check if mandatory
														</span>
		                                        	</label>
		                                        	<div id="segment01_mw001_inherited_fields" class="col-sm-9 input-group">	
								                    </div>
							                    </div>	  
		                                    </fieldset>
		                                </div>
		                            </div> <!-- .end of tab-2 -->
		                            
		                        </div><!-- ./end of tab-content -->
		                    </div><!-- end of tab-container -->
		                </form>
	                </div>
	            </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment01_mw001_save();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Create Category</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment01_mw001_callbackFn;
var segment01_mw001_callbackFnParams;
var segment01_mw001_parentCategoryObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment01_mw001_isOpen()
{
	return ($("#segment01_mw001").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw001_isOpen

/**
 * Init modal window.
 */ 
function segment01_mw001_init()
{
    $("#segment01_mw001_inherited_fields").sortable({
        placeholder: "highlight"
    });
    
    // Reset
	$("#segment01_mw001_parentClass").empty();
	$("#segment01_mw001_inherited_fields").empty();
	$("#segment01_mw001_statusMessageList").empty();
	$("#segment01_mw001_statusMessageList").hide();
	
    // Setup category selection list
    var htmlLines = '';
  	htmlLines += '<option value="0">';
  	htmlLines += '- Select Parent Category -';
  	htmlLines += '</option>';
  	$("#segment01_mw001_parentClass").append(htmlLines);
    		
	$.each(Cached_getCategoryList(), function(i, categoryObj) {   	   	    	  			
		var systemDefinedClass = '';
		if (inventoryUtil_isRootCategory(categoryObj))
			systemDefinedClass = ' (System Defined)';
				
		var htmlLines = '';
		htmlLines += '<option value="' + categoryObj.id + '">';
		htmlLines += categoryObj.name;
		htmlLines += systemDefinedClass;
		htmlLines += '</option>';
		
		$("#segment01_mw001_parentClass").append(htmlLines);
	});
	
	$('#segment01_mw001').on('shown.bs.modal', function () {
	    $("#segment01_mw001_name").focus();
	})
} // .end of segment01_mw001_init

/**
 * Called to open modal window.
 */ 
function segment01_mw001_open(parentCategoryId, postHandlerFn, params, categoryObj)
{
	// Setup callback function/params
	segment01_mw001_callbackFn			= postHandlerFn;
	segment01_mw001_callbackFnParams	= params;
	segment01_mw001_parentCategoryObj 	= categoryObj;
	
	// Modal Window init
	segment01_mw001_init();
	segment01_mw001_parentChanged(parentCategoryId);	
	
	$('#segment01_mw001_parentClass').val(parentCategoryId);
	$('#segment01_mw001_parentClass').attr('disabled',true);	
	
	// Set seqno to Max
	var maxSeqno = 0;
	$.each(Cached_getCategoryList(), function(i, categoryObj){
		if (categoryObj.parentCategoryId==parentCategoryId)
		{
			if (categoryObj.seqno > maxSeqno)
				maxSeqno = categoryObj.seqno;	
		}
	});
	
	$('#segment01_mw001_name').val( '' );
	$('#segment01_mw001_seqno').val( maxSeqno + 1 );

	module_showModalWindow('segment01_mw001', true);
} // .end of segment01_mw001_open

/**
 * Response to user click on button 'Create'.
 */ 
function segment01_mw001_save()
{
	// Validate inputs
	var inputVal_categoryName = $("#segment01_mw001_name").val();
	var inputVal_categorySeqno = $("#segment01_mw001_seqno").val();
	
	if (inputVal_categoryName==null || $.trim(inputVal_categoryName)=='')
	{
		// Show alert - error
		swal({
       		title: 'Invalid Input',
            text: 'Please enter \'Category Name\'.',
            type: "error"},
 	        function(){
 	    });	
		
		return false;
	}	    	
	// .end of Validation
	
	var inputVal_parentCategoryId = $.trim( $("#segment01_mw001_parentClass").val() );
	var parentCategoryObj = Cached_getCategoryById(inputVal_parentCategoryId);
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	
	// Prepare InventoryClassBean
	var newCategoryObj = createNew_InventoryCategory();
	
	newCategoryObj.placeId				= tycheesCommon_getCurrentPlaceId();
	newCategoryObj.parentCategoryId 	= tycheesText_getSafeString(parentCategoryObj.id);
	newCategoryObj.parentCategoryName	= tycheesText_getSafeString(parentCategoryObj.name);
	newCategoryObj.businessTypeId		= tycheesText_getSafeString(placeObj.subcategory);
	newCategoryObj.itemType 			= tycheesText_getSafeString(parentCategoryObj.itemType);
	newCategoryObj.name 				= tycheesText_getSafeString(inputVal_categoryName);
	newCategoryObj.seqno				= inputVal_categorySeqno;
	
	// Prepare local variables
	$("#segment01_mw001_inherited_fields").children('li').each(function(i) { 
	    var newFieldObj = createNew_InventoryCategoryProperties();
	    
	    newFieldObj.seqno				= i;
	    newFieldObj.categoryId 			= newCategoryObj.id;
	    newFieldObj.propName			= tycheesText_getSafeString($(this).find('#segment01_mw001_propName').html());
	    newFieldObj.propKey				= tycheesText_getSafeString($(this).find('#segment01_mw001_propKey').val());
	    newFieldObj.propType			= tycheesText_getSafeString($(this).find('#segment01_mw001_propType').html());
	    newFieldObj.propContent			= tycheesText_getSafeString($(this).find('#segment01_mw001_propContent').val());
	    newFieldObj.required			= $(this).find('input').is(":checked");
	    newFieldObj.inherited			= true;
	    newFieldObj.inheritedCategoryId = tycheesText_getSafeString(newCategoryObj.parentCategoryId);	    
	    	
	    newCategoryObj.propertiesList.push(newFieldObj);
	});
	
	// Update cache memory
	Cached_addCategory(newCategoryObj);
	// Save to Local DB	
    tycheesIO_saveBean(newCategoryObj); 
    
    // Hide Modal Window
	$('#segment01_mw001').modal('hide');
	
	// Invoke CallBack function
	segment01_mw001_callbackFn(true, segment01_mw001_callbackFnParams, newCategoryObj);
} // .end of segment01_mw001_save

/**
 * Response to user selection on parent category.
 */ 
function segment01_mw001_parentChanged(categoryId)
{
	if (categoryId=='0')
	{
		$("#segment01_mw001_inherited_fields").empty();
		return false;
	}
	
	var categoryObj = Cached_getCategoryById(categoryId);
	if (categoryObj != null) 
	{
	    // Clear inherited fields
		$("#segment01_mw001_inherited_fields").empty();
		// Add inherited fields
		$.each(categoryObj.propertiesList, function(index, propObj) {
			var rowNo = index + 1;
  	    	var checkedVal = '';
      		if (propObj.required == true)
      			checkedVal = 'checked';
      		    	
      		var htmlLines = '';
      		htmlLines += '<li class="navy-bg" id="segment01_mw001_field-' + rowNo + '">';
			htmlLines += '<input type="hidden" id="segment01_mw001_propContent" value="' + propObj.propContent + '"/>';
      		htmlLines += '<input type="hidden" id="segment01_mw001_propId" value=""/> '; // leave id value empty for backend to know this is new field.
      		htmlLines += '<input type="hidden" id="segment01_mw001_propKey" value="' + propObj.propKey + '"/> ';
      		htmlLines += '<input type="checkbox" class="i-checks" id="required-' + rowNo + '" ' + checkedVal +' data-toggle="tooltip" data-placement="left" title="Check this if this is mandatory field." /> ';	
  			htmlLines += '<span id="segment01_mw001_propName">  ' + propObj.propName + '</span> | ';
      		htmlLines += '<span id="segment01_mw001_propType"> ' + propObj.propType + '</span>';
  			htmlLines += '</li>';
  	    	
  	    	$("#segment01_mw001_inherited_fields").append(htmlLines);
  	    	
  	    	tycheesCommon_initCheckBox();							
		});
	}
} // .end of segment01_mw001_parentChanged

</script>