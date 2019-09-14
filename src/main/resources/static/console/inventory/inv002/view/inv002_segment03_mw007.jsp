<!-- MODAL WINDOW: Edit Optional Component -->
<div class="modal inmodal" id="segment03_mw007" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg3">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">EDIT OPTIONAL COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body" style="height:360px;">
            	<div class="row" id="segment03_mw007_errorMessage" style="color:#FF0000;">
                </div>
            	<div class="row">
            		<div class="col-lg-6">
            			<div class="form-group">
            			    
            				<label>Select Category (POS > Title)</label> 
						    <input id="segment03_mw007_category" type="text" placeholder="" class="form-control" disabled>
	                		
							<div id="segment03_mw007_col1_part0" style="display:none;">
			                	<label>Select available Item Group in POS <small>(leave blank to show all)</small></label> 
		                		<select id="segment03_mw007_itemGroupList" class="chosen-select" multiple data-placeholder="-- SELECT ITEM GROUP --">
								</select>
								<br/>
							</div>
							
							<div id="segment03_mw007_col1_part1" style="display:none;padding-top:10px;">
			                	<label>Help Text (POS > Instruction Sentence)</label> 
			                	<input id="segment03_mw007_helpText" type="text" placeholder="" class="form-control" required>
			                	
			                	<label>Default Quantity (Show when first selected in POS)</label> 
			                	<input id="segment03_mw007_defaultQuantity" type="number" placeholder="" class="form-control">
								<br/>
								<label>
			                		<input type="checkbox" class="i-checks" id="segment03_mw007_allowDefaultQuantityOnly" data-toggle="tooltip" data-placement="left" title=""> 
			                		<i></i> Allow Default Quantity Only 
			                	</label> 
							</div>
		                </div>
            		</div>
            		<div class="col-lg-6">	
            			<div id="segment03_mw007_col2_part1" style="display:none;">
		                	<label>Selection Mode</label> 
	                		<select id="segment03_mw007_selectionMode" class="chosen-select" data-placeholder="-- SELECT MODE --">
							</select>
		                	<label>Minimum Selection</label> 
		                	<input id="segment03_mw007_minimumSelection" type="number" placeholder="" class="form-control">
		                	<label>Maximum Selection</label> 
		                	<input id="segment03_mw007_maximumSelection" type="number" placeholder="" class="form-control">
		                </div>
            		</div>
            	</div>	                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment03_mw007_onSave();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Update</button>
            </div>
        </div>
    </div>
</div>


<script>

var segment03_mw007_initialized = false;
var segment03_mw007_itemGroupList = [];
var segment03_mw007_componentObj;
var segment03_mw007_categoryObj;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw007_isOpen()
{
	return ($("#segment03_mw007").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw007_isOpen

/**
 * Init state of modal window
 */
function segment03_mw007_init()
{
	if (segment03_mw007_initialized)
		return false;
	
	$(".chosen-select").chosen({
		width: "100%",
    	allow_single_deselect:true, 
	   	search_contains: true
	});
	
	// EVENT LISTENER: User select Single/Multiple
	$("#segment03_mw007_selectionMode").on('change', function() {
 	  	var selectionMode = $("#segment03_mw007_selectionMode").val();
 	  	if (selectionMode=='0')
 	  		return false;
 	  	segment03_mw007_onSelectionModeChanged(selectionMode);
 	});
    
 	// EVENT LISTENER: User select/deselect item group from chosen-select list
	$('#segment03_mw007_itemGroupList').on('change', function(evt, params) {
		var itemGroupList = $("#segment03_mw007_itemGroupList").val();
       	segment03_mw007_onItemGroupChanged(itemGroupList, params.selected, params.deselected);
    });

    segment03_mw007_initialized = true;
} // .end of segment03_mw007_init

/**
 * Open modal window
 */
function segment03_mw007_open(componentId)
{
	tycheesOverlay_startShortProgress('loading...');
	
	segment03_mw007_init();
	
	// Reset to initial state
	$('#segment03_mw007_errorMessage').hide();
	
	$.each(segment03_itemObj.componentList, function(i, componentObj){    	
    	if ($.trim(componentId)==$.trim(componentObj.id))
    	{
    		segment03_mw007_componentObj = componentObj;
    		//segment03_mw007_categoryObj  = Cached_getCategoryById(componentObj.categoryId);
    		return false;
    	}
	});
	
	if (segment03_mw007_componentObj==null)
	{
		tycheesLogger_logError('SYSTEM BUG: No component object found.','segment03_mw007_open');
		return false;
	}
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': segment03_mw007_componentObj.categoryId,
		'fullBean': true
	};

	var params = new Object();
	params.categoryId = segment03_mw007_componentObj.categoryId;
	
	tycheesdb_api_getCategoryById(requestBody, segment03_mw007_open_postHandler, params);
} // .end of segment03_mw007_open

function segment03_mw007_open_postHandler(successFlag, responseObj, params)
{
	segment03_mw007_categoryObj = responseObj.categoryObj;
	
	if (segment03_mw007_categoryObj==null)
	{
		tycheesLogger_logError('SYSTEM BUG: No category object found.','segment03_mw007_open');
		return false;
	}
	
	$("#segment03_mw007_category").val(segment03_mw007_categoryObj.name);

	// Sort by itemGroupName
	segment03_mw007_categoryObj.itemGroupList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	// Populate list of item group
	$('#segment03_mw007_itemGroupList').empty();
	$.each(segment03_mw007_categoryObj.itemGroupList, function(i, itemGroupName) {
	    var itemGroupPosition = tycheesText_indexOf(itemGroupName, segment03_mw007_componentObj.itemGroupList);
	    if (itemGroupPosition >= 0) 
	    {
			$('#segment03_mw007_itemGroupList').append( 
			    '<option value="' + itemGroupName + '" selected>' + itemGroupName + '</option>');
			segment03_mw007_itemGroupList.push(itemGroupName);
	    }
	    else
		{
	    	$('#segment03_mw007_itemGroupList').append( 
			    '<option value="' + itemGroupName + '">' + itemGroupName + '</option>');
		}
	});	
	$('#segment03_mw007_itemGroupList').trigger('chosen:updated');

	// COLUMN #1
	// Set values
	$("#segment03_mw007_helpText").val(segment03_mw007_componentObj.helpText);		
	$("#segment03_mw007_minimumSelection").prop('disabled', segment03_mw007_componentObj.selectionMode=='single');
	$("#segment03_mw007_maximumSelection").prop('disabled', segment03_mw007_componentObj.selectionMode=='single');
	$("#segment03_mw007_minimumSelection").val(segment03_mw007_componentObj.minimumSelection);
	$("#segment03_mw007_maximumSelection").val(segment03_mw007_componentObj.maximumSelection);
	$("#segment03_mw007_defaultQuantity").val(segment03_mw007_componentObj.defaultQuantity);
	if (segment03_mw007_componentObj.allowDefaultQuantityOnly)
		$('#segment03_mw007_allowDefaultQuantityOnly').iCheck('check');
	else
		$('#segment03_mw007_allowDefaultQuantityOnly').iCheck('uncheck');
	
	// COLUMN #2
	var singleSelected = segment03_mw007_componentObj.selectionMode=='single'?'selected':'';
	var multipleSelected = segment03_mw007_componentObj.selectionMode=='multiple'?'selected':'';
	
	$("#segment03_mw007_selectionMode").empty();
	$("#segment03_mw007_selectionMode").append('<option value="0">-- SELECT MODE --</option>');
	$("#segment03_mw007_selectionMode").append('<option value="single" ' + singleSelected + '>Single Selection</option>');
	$("#segment03_mw007_selectionMode").append('<option value="multiple" ' + multipleSelected + '>Multiple Selection</option>');
	$('#segment03_mw007_selectionMode').trigger('chosen:updated');
			
	$("#segment03_mw007_col1_part0").show();
	$("#segment03_mw007_col1_part1").show();
	$("#segment03_mw007_col2_part1").show();
	
	tycheesOverlay_stopShortProgress();
	
	// Show Modal Window
	module_showModalWindow('segment03_mw007', true);
} // .end of segment03_mw007_open_postHandler

/**
 * Event Listener: Listen to selection changed on Component name.
 */
function segment03_mw007_onItemGroupChanged(itemGroupList, selectedItemGroup, deselectedItemGroup)
{
	if (selectedItemGroup != null)
		segment03_mw007_itemGroupList.push(selectedItemGroup);
	
	if (deselectedItemGroup != null)
	{
		var selectedIndex = -1;
		$.each(segment03_mw007_itemGroupList, function(i, itemGroupVal){
			if (itemGroupVal == deselectedItemGroup) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw007_itemGroupList.splice(selectedIndex, 1);
		
	}
} // .end of segment03_mw007_onItemGroupChanged

/**
 * Listen to change of SELECT 'Selection Mode'.
 */
function segment03_mw007_onSelectionModeChanged(selectionMode)
{
	if (selectionMode=='single')
	{
		$("#segment03_mw007_minimumSelection").prop('disabled', true);
		$("#segment03_mw007_minimumSelection").val('1');

		$("#segment03_mw007_maximumSelection").prop('disabled', true);
		$("#segment03_mw007_maximumSelection").val('1');
	}
	else
	if (selectionMode=='multiple')
	{
		$("#segment03_mw007_minimumSelection").prop('disabled', false);
		$("#segment03_mw007_maximumSelection").prop('disabled', false);
	}
} // .end of segment03_mw007_onSelectionModeChanged

/**
 * Save component.
 */
function segment03_mw007_onSave()
{
	// Input Validation
	var selectionMode		= $("#segment03_mw007_selectionMode").val();
	var minimumSelectionVal = $("#segment03_mw007_minimumSelection").val();
	var maximumSelectionVal = $("#segment03_mw007_maximumSelection").val();

	// Reset/Hide error messages
	$("#segment03_mw007_errorMessage").hide();
	$("#segment03_mw007_errorMessage").html('');
	
	// START Validation
	if (isNaN(minimumSelectionVal))
    {
		$("#segment03_mw007_errorMessage").show();
    	$("#segment03_mw007_errorMessage").html("Invalid Minimum Selection. It must be a Integer value.");
		return false;
    }
    if (isNaN(maximumSelectionVal))
    {
		$("#segment03_mw007_errorMessage").show();
    	$("#segment03_mw007_errorMessage").html("Invalid Maximum Selection. It must be a Integer value.");
		return false;
    }    
    // .end of Input Validation
    
    // Prepare data for saving
    var selectionModeVal = selectionMode;
	if (selectionModeVal == '')
		selectionModeVal = 'multiple';
	
	var defaultQuantityVal = $.trim( $("#segment03_mw007_defaultQuantity").val() );
	if (defaultQuantityVal=='')
		defaultQuantityVal = 0;
	
	var allowDefaultQuantityOnlyVal = $("#segment03_mw007_allowDefaultQuantityOnly").is(":checked");
	
	// Update Component
	segment03_mw007_componentObj.itemGroupList = segment03_mw007_itemGroupList.toString();
	segment03_mw007_componentObj.helpText = $.trim( $("#segment03_mw007_helpText").val() );
	segment03_mw007_componentObj.selectionMode = selectionModeVal;
	segment03_mw007_componentObj.minimumSelection = Number(minimumSelectionVal).toFixed(0);
	segment03_mw007_componentObj.maximumSelection = Number(maximumSelectionVal).toFixed(0);
	segment03_mw007_componentObj.defaultQuantity = defaultQuantityVal;
	segment03_mw007_componentObj.allowDefaultQuantityOnly = allowDefaultQuantityOnlyVal;
	segment03_mw007_componentObj.hasChanged = true;
	
    // Save inventory item
    tycheesIO_saveBean(segment03_itemObj);
	// Hide Modal Window
	$('#segment03_mw007').modal('hide');
	// Update UI
	segment03_updateUI_tab3( segment03_itemObj );
} // .end of segment03_mw007_onSave


</script>