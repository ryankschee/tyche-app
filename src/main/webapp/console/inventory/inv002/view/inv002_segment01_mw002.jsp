<!-- Modal Window: Edit Category -->
<div class="modal inmodal fade" id="segment01_mw002" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg2" id="segment01_mw002_frame">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">EDIT INVENTORY CATEGORY</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
				<div class="row">
	                <div class="col-lg-12">  
	                	<form role="form" id="segment01_mw002_theForm">
		                    <div id="segment01_mw002_statusMessageList" style="display:none;">
		                    	<span>
		                    	</span>
		                    </div>
		                	<div class="tabs-container">
			                    <ul class="nav nav-tabs">
			                        <li id="segment01_mw002_tab_header_1" class="active">
			                            <a data-toggle="tab" href="#segment01_mw002_tab_1"> 
			                                Basic Info
			                            </a>
			                        </li>	
			                        <li id="segment01_mw002_tab_header_2">
			                            <a data-toggle="tab" href="#segment01_mw002_tab_2"> 
			                                Properties
			                            </a>
			                        </li>	                        
			                    </ul>
		                        <div class="tab-content">
		                            <div id="segment01_mw002_tab_1" class="tab-pane active">
		                                <div class="panel-body">
		                                    <fieldset class="form-horizontal">
		                                    	<div class="form-group">
		                                    		<label class="col-sm-3 control-label">
		                                    		    Parent Category
		                                    		</label>
		                                            <div class="col-sm-9 input-group">
		                                                <select class="form-control" id="segment01_mw002_parentClass">
		                                                </select>
		                                            </div>
		                                        </div> 
		                                        
						                        <div class="hr-line-dashed"></div>
						                        
		                                        <div class="form-group">
		                                        	<label class="col-sm-3 control-label">
		                                        	    * Category Name
		                                        	</label>
		                                            <div class="col-sm-9 input-group">
		                                            	<input type="text" class="form-control" id="segment01_mw002_name" name="Category Name" placeholder="Class Name" maxlength="45" autofocus required>
		                                            </div>
		                                        </div>  
		                                        <div class="form-group">
		                                        	<label class="col-sm-3 control-label">
		                                        	    Seq.No. in POS
		                                        	</label>
		                                            <div class="col-sm-9 input-group">
		                                            	<input type="number" class="form-control" id="segment01_mw002_seqno" name="Sequence Number in POS" placeholder="Sequence Number in POS">
		                                            	<small>Smaller number in higher (left-most) position.</small>
		                                            </div>
		                                        </div>  
		                                    </fieldset>
		                                </div>
		                            </div> <!-- .end of tab-2 -->
		                            <div id="segment01_mw002_tab_2" class="tab-pane">
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
		                                        	<div id="segment01_mw002_inherited_fields" class="col-sm-9 input-group">	
								                    </div>
							                    </div>	
							                    
						                        <div class="hr-line-dashed"></div>
						                        
		                                        <div class="form-group">	                                        	
		                                        	<label class="col-sm-3 control-label">
		                                        	    User-defined Fields
		                                        	    <br><br>
  														<span id="segment01_mw002_addProperties" class="btn btn-sm btn-warning" onclick="segment01_mw002_onAddProperties();">
  															<i class="fa fa-plus" aria-hidden="true"></i> Add Field
  														</span>
		                                        	</label>
		                                        	<div id="segment01_mw002_userDefined_fields" class="col-sm-9 input-group">	
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
                <button id="segment01_mw002_button_reset" type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button id="segment01_mw002_button_saveChanges" type="button" class="btn btn-primary" onclick="segment01_mw002_save();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save Changes</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment01_mw002_categoryObj;
var segment01_mw002_callbackFn;
var segment01_mw002_callbackFnParams;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment01_mw002_isOpen()
{
	return ($("#segment01_mw002").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw002_isOpen

/**
 * Init modal window.
 */ 
function segment01_mw002_init()
{
    $("#segment01_mw002_inherited_fields").sortable({
        placeholder: "highlight"
    });
    $("#segment01_mw002_userDefined_fields").sortable({
        placeholder: "highlight"
    });
    
	//$("#segment01_mw002_inherited_fields").empty();
	$("#segment01_mw002_statusMessageList").empty();
	$("#segment01_mw002_statusMessageList").hide();
	
    // Clear list - Parent Category List
	$("#segment01_mw002_parentClass").empty();
	
    // Setup category selection list
    var htmlLines = '';
  	htmlLines += '<option value="0">- Select Parent Category -</option>';
  	$("#segment01_mw002_parentClass").append(htmlLines);
    		
	$.each(Cached_getCategoryList(), function(index, categoryObj) {   	   	    	  			
		var systemDefinedClass = '';
		if (categoryObj.id != null && categoryObj.id.startsWith('system-master'))
			systemDefinedClass = ' (System Defined)';
				
		var htmlLines = '';
		htmlLines += '<option value="' + categoryObj.id + '">' + categoryObj.name + systemDefinedClass + '</option>';
		$("#segment01_mw002_parentClass").append(htmlLines);
	});
	
	$('#segment01_mw002').on('shown.bs.modal', function () {
	    $("#segment01_mw002_name").focus();
	})
} // .end of segment01_mw002_init

/**
 * Called to open modal window.
 */ 
function segment01_mw002_open(categoryId, postHandlerFn, params, categoryObj)
{
	segment01_mw002_callbackFn 		 = postHandlerFn;
	segment01_mw002_callbackFnParams = params;
	segment01_mw002_categoryObj 	 = categoryObj;

	segment01_mw002_init();
	segment01_mw002_parentChanged(segment01_mw002_categoryObj.parentCategoryId);	
	
	// Reset
	$('#segment01_mw002_tab_header_1').addClass('active');
	$('#segment01_mw002_tab_header_2').removeClass('active');
	$('#segment01_mw002_tab_1').addClass('active');
	$('#segment01_mw002_tab_2').removeClass('active');
	
	// Update UI
	segment01_mw002_updateUI_tab1();
	// Update UI
	segment01_mw002_updateUI_tab2();	
	
	if (segment01_mw002_callbackFnParams.editable)
		$('#segment01_mw002_button_saveChanges').show();
	else
		$('#segment01_mw002_button_saveChanges').hide();
	
	module_showModalWindow('segment01_mw002', true);
} // .end of segment01_mw002_open

function segment01_mw002_updateUI_tab1()
{
	// TAB #1: Basic Info
	$('#segment01_mw002_parentClass').val(segment01_mw002_categoryObj.parentCategoryId);
	$('#segment01_mw002_parentClass').attr('disabled',true);	
	
	$('#segment01_mw002_name').val(segment01_mw002_categoryObj.name);
	$('#segment01_mw002_seqno').val(segment01_mw002_categoryObj.seqno);		
	
	$('#segment01_mw002_name').attr('disabled', segment01_mw002_callbackFnParams.editable ? false : true);
	$('#segment01_mw002_seqno').attr('disabled', segment01_mw002_callbackFnParams.editable ? false : true);
} // .end of segment01_mw002_updateUI_tab1

function segment01_mw002_updateUI_tab2()
{
	// TAB #2: Properties
	if (segment01_mw002_categoryObj != null) 
	{
	    // Clear inherited fields
		$("#segment01_mw002_inherited_fields").empty();
		$("#segment01_mw002_userDefined_fields").empty();
	    
		// Add inherited fields
		var rowNo = 0;
		$.each(segment01_mw002_categoryObj.propertiesList, function(i, propObj) {
			
			if (Cached_isDeletedBean(propObj) == true)
				return true;
			
			rowNo++;
  	    	var checkedVal = '';
      		if (propObj.required == true)
      			checkedVal = 'checked';
      		
      		var checkboxDisabled = '';
      		if (segment01_mw002_callbackFnParams.editable == false)
      			checkboxDisabled = 'disabled';      		
      		
      		var htmlLines = '';
      		htmlLines += '<li class="navy-bg" id="segment01_mw001_field-' + rowNo + '">';
			htmlLines += '<input type="hidden" id="segment01_mw001_propContent" value="' + propObj.propContent + '"/>';
      		htmlLines += '<input type="hidden" id="segment01_mw001_propId" value=""/> '; // leave id value empty for backend to know this is new field.
      		htmlLines += '<input type="hidden" id="segment01_mw001_propKey" value="' + propObj.propKey + '"/> ';
      		htmlLines += '<input type="checkbox" class="i-checks" id="required-' + propObj.id + '-' + rowNo + '" ' + checkedVal + ' ' + checkboxDisabled + ' data-toggle="tooltip" data-placement="left" title="Check this if this is mandatory field." /> ';	
  			htmlLines += '<span id="segment01_mw001_propName">  ' + propObj.propName + '</span> | ';
      		htmlLines += '<span id="segment01_mw001_propType"> ' + propObj.propType + '</span>';
      		
      		if (propObj.inherited==false && segment01_mw002_callbackFnParams.editable)
      		{
      			htmlLines += '<span class="btn btn-xs btn-danger pull-right" onclick="segment01_mw002_onDeleteProperties(' + rowNo + ',\'' + propObj.id + '\');">';
      			htmlLines += '<i class="fa fa-times" aria-hidden="true"></i>';
    			htmlLines += '</span>';
    			htmlLines += '<span class="btn btn-xs btn-danger pull-right" onclick="segment01_mw002_onEditProperties(' + rowNo + ',\'' + propObj.id + '\');" style="margin-right:2px;">';
   				htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
				htmlLines += '</span>';	
      		}
      		
  			htmlLines += '</li>';

			if (propObj.inherited)
  	    		$("#segment01_mw002_inherited_fields").append(htmlLines);
			else
  	    		$("#segment01_mw002_userDefined_fields").append(htmlLines);
				
  	    	tycheesCommon_initCheckBox();							
		});
		
		if (segment01_mw002_callbackFnParams.editable)
		{
			$('#segment01_mw002_addProperties').show();
			$("#segment01_mw002_inherited_fields").sortable('enable');
			$("#segment01_mw002_userDefined_fields").sortable('enable');
		}
		else
		{
			$('#segment01_mw002_addProperties').hide();
			$("#segment01_mw002_inherited_fields").sortable('disable');
			$("#segment01_mw002_userDefined_fields").sortable('disable');
		}
	}
} // .end of segment01_mw002_updateUI_tab2

function segment01_mw002_onAddProperties()
{
	var params = new Object();
	
	segment01_mw101_open(segment01_mw002_categoryObj, segment01_mw002_onAddProperties_postHandler, params);
} // .end of segment01_mw002_onAddProperties

function segment01_mw002_onAddProperties_postHandler(successFlag, params)
{
	if (successFlag==false)
		return false;

	segment01_mw002_categoryObj = params.categoryObj;
	segment01_mw002_updateUI_tab2();	
	
	tycheesOverlay_stopShortProgress();
} // .end of segment01_mw002_onAddProperties_postHandler

function segment01_mw002_onEditProperties(rowNo, propId)
{	
	var params = new Object();
	params.rowNo = rowNo;
	params.categoryObj = segment01_mw002_categoryObj;
		
	$.each(segment01_mw002_categoryObj.propertiesList, function(i, propObj) {
		if (propObj.id == propId) {
			params.propObj = propObj;
			return false;
		}
	});
	
	segment01_mw102_open(segment01_mw002_onEditProperties_postHandler, params);
} // .end of segment01_mw002_onEditProperties

function segment01_mw002_onEditProperties_postHandler(successFlag, params)
{
	if (successFlag==false)
		return false;

	//segment01_mw002_categoryObj = params.categoryObj;
	segment01_mw002_updateUI_tab2();	
	
	tycheesOverlay_stopShortProgress();
} // .end of segment01_mw002_onEditProperties_postHandler

function segment01_mw002_onDeleteProperties(rowNo, propId)
{
	var params = new Object();
	params.rowNo = rowNo;
	params.categoryObj = segment01_mw002_categoryObj;
		
	$.each(segment01_mw002_categoryObj.propertiesList, function(i, propObj) {
		if (propObj.id == propId) {
			params.propObj = propObj;
			return false;
		}
	});
		
	segment01_mw103_open(segment01_mw002_onDeleteProperties_postHandler, params);
} // .end of segment01_mw002_onDeleteProperties

function segment01_mw002_onDeleteProperties_postHandler(successFlag, params)
{
	if (successFlag==false)
		return false;
	
	//segment01_mw002_categoryObj = params.categoryObj;
	segment01_mw002_updateUI_tab2();	
	
	tycheesOverlay_stopShortProgress();
} // .end of segment01_mw002_onDeleteProperties_postHandler

/**
 * Response to user click on button 'Save Changes'.
 */ 
function segment01_mw002_save()
{
	// Validate inputs
	var inputVal_categoryName = $("#segment01_mw002_name").val();
	var inputVal_categorySeqno = $("#segment01_mw002_seqno").val();
	
	if (inputVal_categoryName==null || $.trim( inputVal_categoryName )=='')
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
	
	segment01_mw002_categoryObj.name  	= inputVal_categoryName;
	segment01_mw002_categoryObj.seqno 	= inputVal_categorySeqno;
	
	// Temporary Fix: To Re-Insert 'name' of parent category object
	var parentCategoryObj = Cached_getCategoryById(segment01_mw002_categoryObj.parentCategoryId);
	segment01_mw002_categoryObj.parentCategoryName	= parentCategoryObj.name;
		
	// Update cache memory
	Cached_updateCategory(segment01_mw002_categoryObj);
	// Save to Local DB	
    tycheesIO_saveBean(segment01_mw002_categoryObj); 
    
    // Hide Modal Window
	$('#segment01_mw002').modal('hide');
	
	// Invoke Callback
	segment01_mw002_callbackFn(true, segment01_mw002_callbackFnParams, segment01_mw002_categoryObj);
} // .end of segment01_mw002_save

/**
 * Response to user selection on parent category.
 */ 
function segment01_mw002_parentChanged(categoryId)
{
	if (categoryId=='0')
	{
		return false;
	}	
} // .end of segment01_mw002_parentChanged

</script>