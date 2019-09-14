<!-- MODAL WINDOW: New Optional Component -->
<div class="modal inmodal" id="segment03_mw005" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg3">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">NEW OPTIONAL COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body" style="height:360px;">
                <div class="row" id="segment03_mw005_errorMessage" style="color:#FF0000;">
                </div>
            	<div class="row">
            		<div class="col-lg-6">
            			<div class="form-group">
            			
            				<label>Select Category (POS > Title)</label> 
	                		<select id="segment03_mw005_category" class="chosen-select" data-placeholder="-- SELECT CATEGORY --">
							</select>
							
							<div id="segment03_mw005_col1_part0" style="display:none;">
			                	<label>Select available Item Group in POS <small>(leave blank to show all)</small></label> 
		                		<select id="segment03_mw005_itemGroupList" class="chosen-select" multiple data-placeholder="-- SELECT ITEM GROUP --">
								</select>
								<br/>
							</div>
							
							<div id="segment03_mw005_col1_part1" style="display:none;padding-top:10px;">
			                	<label>Help Text (POS > Instruction Sentence)</label> 
			                	<input id="segment03_mw005_helpText" type="text" placeholder="" class="form-control" required>
			                	
			                	<label>Default Quantity (Show when first selected in POS)</label> 
			                	<input id="segment03_mw005_defaultQuantity" type="number" placeholder="" class="form-control">
								<br/>
								<label>
			                		<input type="checkbox" class="i-checks" id="segment03_mw005_allowDefaultQuantityOnly" data-toggle="tooltip" data-placement="left" title=""> 
			                		<i></i> Allow Default Quantity Only 
			                	</label> 
							</div>
		                </div>
            		</div>
            		<div class="col-lg-6">
						<div id="segment03_mw005_col2_part1" style="display:none;">
		                	<label>Selection Mode</label> 
	                		<select id="segment03_mw005_selectionMode" class="chosen-select" data-placeholder="-- SELECT MODE --">
	                			<option value="0">-- SELECT MODE --</option>
	                			<option value="single">Single Selection</option>
	                			<option value="multiple">Multiple Selection</option>
							</select>
		                	<label>Minimum Selection</label> 
		                	<input id="segment03_mw005_minimumSelection" type="number" placeholder="" class="form-control">
		                	<label>Maximum Selection</label> 
		                	<input id="segment03_mw005_maximumSelection" type="number" placeholder="" class="form-control">
		                </div>
            		</div>
            	</div>	                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment03_mw005_onSave();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Create</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment03_mw005_initialized = false;
var segment03_mw005_itemGroupList;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw005_isOpen()
{
	return ($("#segment03_mw005").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw005_isOpen

/**
 * Init state of modal window.
 */
function segment03_mw005_init()
{
	if (segment03_mw005_initialized)
		return false;
	
	$(".chosen-select").chosen({
		width: "100%",
    	allow_single_deselect:true, 
	   	search_contains: true
	});
	
 	// EVENT LISTENER: Category Changed
    $( "#segment03_mw005_category" ).on('change', function() {
    	segment03_mw005_onCategoryChanged();
 	});
 	
 	// EVENT LISTENER: Single/Multiple selection
    $("#segment03_mw005_selectionMode").on('change', function() {
 	  	var selectionMode = $("#segment03_mw005_selectionMode").val();
 	  	segment03_mw005_onSelectionModeChanged(selectionMode);
 	});
 	
 	// EVENT LISTENER: User select/deselect item group from chosen-select list
	$('#segment03_mw005_itemGroupList').on('change', function(evt, params) {
		var itemGroupList = $("#segment03_mw005_itemGroupList").val();
       	segment03_mw005_onItemGroupChanged(itemGroupList, params.selected, params.deselected);
    });
		
    segment03_mw005_initialized = true;
} // .end of segment03_mw005_init

/**
 * Open modal window.
 */
function segment03_mw005_open()
{
	segment03_mw005_init();
	
	// Hide Panels
	$("#segment03_mw005_col1_part0").hide();
	$("#segment03_mw005_col1_part1").hide();
	$("#segment03_mw005_col1_part2").hide();
	$("#segment03_mw005_col2_part1").hide();
	
	// Reset to initial state
	$('#segment03_mw005_errorMessage').hide();
	$("#segment03_mw005_helpText").val("");
	$('#segment03_mw005_defaultQuantity').val("");
	$('#segment03_mw005_allowDefaultQuantityOnly').iCheck('uncheck');
	$("#segment03_mw005_selectionMode").val("0").trigger("chosen:updated");
	$("#segment03_mw005_minimumSelection").val("");
	$("#segment03_mw005_maximumSelection").val("");
	segment03_mw005_itemGroupList = [];
	
	// Load category into Select
	$("#segment03_mw005_category").empty();
	$("#segment03_mw005_category").append('<option value="0">-- SELECT CATEGORY --</option>');
	
	// Sort Category
	Cached_getCategoryList().sort(function(a, b) {
		if (a.name < b.name) return -1;
		if (a.name > b.name) return 1;
		return 0;
	});
	// Populate Category
	$.each(Cached_getCategoryList(), function(i, categoryObj){
		if (segment03_itemObj.categoryId == categoryObj.id && categoryObj.itemSize == 1)
		{
			// Do not disply the category, if:
			// - current category is selected item's category, and
			// - current category has only one item (which is current item).
			return true;
		}
		
		if (categoryObj.itemSize > 0)
		{
			$("#segment03_mw005_category").append('<option value="' + categoryObj.id + '">' + categoryObj.name + '</option>');
		}
	});
	$('#segment03_mw005_category').trigger('chosen:updated');

	// Show Modal Window
	module_showModalWindow('segment03_mw005', true);
} // .end of segment03_mw005_open

/**
 * Event Listener: on category changed
 */
function segment03_mw005_onCategoryChanged()
{
	var categoryId = $("#segment03_mw005_category").val();
	
	if (categoryId == '0' || categoryId == '')
	{
		$("#segment03_mw005_col1_part0").hide();
		$("#segment03_mw005_col1_part1").hide();
		$("#segment03_mw005_col2_part1").hide();
		
		return false;
	}
	else
	{
		$("#segment03_mw005_col1_part0").show();
		$("#segment03_mw005_col1_part1").show();
		$("#segment03_mw005_col2_part1").show();
	}
	
	// Reset list of item group 
	$('#segment03_mw005_itemGroupList').empty();
	
	var categoryObj = Cached_getCategoryById( categoryId );
	// Sort by itemGroupName
	categoryObj.itemGroupList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	$.each(categoryObj.itemGroupList, function(i, itemGroupName) {
		$('#segment03_mw005_itemGroupList').append( '<option value="' + itemGroupName + '">' + itemGroupName + '</option>' );
	});	
	$('#segment03_mw005_itemGroupList').trigger('chosen:updated');
} // .end of segment03_mw005_onCategoryChanged

/**
 * Event Listener: Listen to selection changed on Component name.
 */
function segment03_mw005_onItemGroupChanged(itemGroupList, selectedItemGroup, deselectedItemGroup)
{
	if (selectedItemGroup != null)
		segment03_mw005_itemGroupList.push(selectedItemGroup);
	
	if (deselectedItemGroup != null)
	{
		var selectedIndex = -1;
		$.each(segment03_mw005_itemGroupList, function(i, itemGroupVal){
			if (itemGroupVal == deselectedItemGroup) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw005_itemGroupList.splice(selectedIndex, 1);
		
	}
} // .end of segment03_mw005_onItemGroupChanged

/**
 * Event Listener: When SELECT 'Selection Mode' change value. 
 */
function segment03_mw005_onSelectionModeChanged(selectionMode)
{
	if (selectionMode=='single')
	{
		$("#segment03_mw005_minimumSelection").prop('disabled', true);
		$("#segment03_mw005_minimumSelection").val('1');

		$("#segment03_mw005_maximumSelection").prop('disabled', true);
		$("#segment03_mw005_maximumSelection").val('1');
	}
	else
	if (selectionMode=='multiple')
	{
		$("#segment03_mw005_minimumSelection").prop('disabled', false);
		$("#segment03_mw005_maximumSelection").prop('disabled', false);
	}
} // .end of segment03_mw005_onSelectionModeChanged

/**
 * Save components.
 */
function segment03_mw005_onSave()
{
	// Input Validation
	var selectionMode		= $("#segment03_mw005_selectionMode").val();
	var minimumSelectionVal = $("#segment03_mw005_minimumSelection").val();
	var maximumSelectionVal = $("#segment03_mw005_maximumSelection").val();
	var categoryId			= $("#segment03_mw005_category").val();
	var categoryObj         = Cached_getCategoryById(categoryId);

	// Reset/Hide error messages
	$("#segment03_mw005_errorMessage").hide();
	$("#segment03_mw005_errorMessage").html('');
	
	// START Validation
	if (categoryObj==null)
    {
		$("#segment03_mw005_errorMessage").show();
    	$("#segment03_mw005_errorMessage").html("Please select 'Category'.");
		return false;
    }
	if (isNaN(minimumSelectionVal))
    {
		$("#segment03_mw005_errorMessage").show();
    	$("#segment03_mw005_errorMessage").html("Invalid Minimum Selection. It must be a Integer value.");
		return false;
    }
    if (isNaN(maximumSelectionVal))
    {
		$("#segment03_mw005_errorMessage").show();
    	$("#segment03_mw005_errorMessage").html("Invalid Maximum Selection. It must be a Integer value.");
		return false;
    }    
    // .end of Input Validation
    
    // Prepare data for saving
	var selectionModeVal = selectionMode;
	if (selectionModeVal == '')
		selectionModeVal = 'multiple';
	
	var defaultQuantityVal = $.trim( $("#segment03_mw005_defaultQuantity").val() );
	if (defaultQuantityVal=='')
		defaultQuantityVal = 0;
	
	var allowDefaultQuantityOnlyVal = $("#segment03_mw005_allowDefaultQuantityOnly").is(":checked");
	
	// Init component JSON object
	var newComponentObj = createNew_InventoryItemComponent();
	newComponentObj.itemId = '';
	newComponentObj.seqno = segment03_itemObj.componentList.length + 1;
	newComponentObj.categoryId = categoryObj.id;
	newComponentObj.itemGroupList = segment03_mw005_itemGroupList.toString();
	newComponentObj.title = categoryObj.name;
	newComponentObj.helpText = $.trim( $("#segment03_mw005_helpText").val() );
	newComponentObj.selectable = true;
	newComponentObj.selectionMode = selectionModeVal;
	newComponentObj.minimumSelection = Number(minimumSelectionVal).toFixed(0);
	newComponentObj.maximumSelection = Number(maximumSelectionVal).toFixed(0);
	newComponentObj.defaultQuantity = defaultQuantityVal;
	newComponentObj.allowDefaultQuantityOnly = allowDefaultQuantityOnlyVal;
	newComponentObj.tags = '';
	newComponentObj.itemIds = '';
	newComponentObj.excludeItemIds = '';
	newComponentObj.defaultItemIds = '';
	
	// Push into list
	segment03_itemObj.componentList.push(newComponentObj);	
	
    // Save inventory item
    tycheesIO_saveBean(segment03_itemObj);
	// Hide Modal Window
	$('#segment03_mw005').modal('hide');
	// Update UI
	segment03_updateUI_tab3( segment03_itemObj );
} // .end of segment03_mw005_onSave

</script>