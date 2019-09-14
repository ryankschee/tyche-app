<!-- MODAL WINDOW: New Mandatory Component -->
<div class="modal inmodal" id="segment03_mw006" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">NEW MANDATORY COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body" style="height:480px;">
            	<div class="row" id="segment03_mw006_errorMessage" style="color:#FF0000;">
                </div>
            	<div class="row">
            		<div class="col-lg-4">
            			<div class="form-group">
            			    <div>
		                	    <label>Select Category (Show as title in POS)</label> 
	                		    <select id="segment03_mw006_category" class="chosen-select" data-placeholder="-- SELECT CATEGORY --">
							    </select>
							</div>
							
							<div id="segment03_mw006_col1_part0" style="display:none;">
			                	<label>Select Item Group</label> 
		                		<select id="segment03_mw006_itemGroupList" class="chosen-select" data-placeholder="-- SELECT ITEM GROUP --">
								</select>
								<br/>
							</div>
							
							<div id="segment03_mw006_col1_part1" style="display:none;padding-top:10px;">
			                	<label>Help Text (Show as instruction in POS)</label> 
			                	<input id="segment03_mw006_helpText" type="text" placeholder="" class="form-control">
			                	
			                	<label>Default Quantity (Show when first selected in POS)</label> 
			                	<input id="segment03_mw006_defaultQuantity" type="number" placeholder="" class="form-control">
								<br/>
								<label>
			                		<input type="checkbox" class="i-checks" id="segment03_mw006_allowDefaultQuantityOnly" data-toggle="tooltip" data-placement="left"> 
			                		<i></i> Allow Default Quantity Only 
			                	</label> 
							</div>
							
							<div id="segment03_mw006_col1_part2" style="display:none;">
			                	<br/><br/>
			                	<label>Selection Mode</label> 
		                		<select id="segment03_mw006_selectionMode" class="form-control">
		                			<option value="0">-- SELECT --</option>
		                			<option value="single">Single Selection</option>
		                			<option value="multiple">Multiple Selection</option>
								</select>
			                	<label>Minimum Selection</label> 
			                	<input id="segment03_mw006_minimumSelection" type="number" placeholder="" class="form-control">
			                	<label>Maximum Selection</label> 
			                	<input id="segment03_mw006_maximumSelection" type="number" placeholder="" class="form-control">
			                </div>
		                </div>
            		</div>
            		<div class="col-lg-4">
            		    <div id="segment03_mw006_spinner" class="spiner-example" style="display:none; padding:0px; height:28px;">
							<div class="sk-spinner sk-spinner-three-bounce">
                                <div class="sk-bounce1"></div>
                                <div class="sk-bounce2"></div>
                                <div class="sk-bounce3"></div>
                            </div>
						</div>
            			<div id="segment03_mw006_col2_part1" style="display:none;">
            				<label>Select Individual Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw006_itemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
            			</div>
            			<div id="segment03_mw006_col2_part2" style="display:none;">
		                	<label>Select Items by Tag</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw006_tagList" data-placeholder="--- SELECT TAG ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
                        <div id="segment03_mw006_col2_part3" style="display:none;">
            				<label>Exclude These Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw006_excludeItemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
            			</div>
            			<div id="segment03_mw006_col2_part4" style="display:none;">
            				<label>Default Selected Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw006_defaultItemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
            			</div>
            		</div>
            		<div class="col-lg-4">
            			<div id="segment03_mw006_col3_part1" style="display:none;">
		                	<label>You've selected following item list:</label> 
		                	<br/>
			                <div class="form-group">
				                <div class="input-group" style="width:100%;">
                                    <select id="segment03_mw006_selected_items" class="form-control" multiple style="height:400px;">
                                    </select>
                                </div>
                            </div>
                        </div>
            		</div>
            	</div>	                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment03_mw006_onSave();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Create</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment03_mw006_initialized = false;
var segment03_mw006_categoryObj;
var segment03_mw006_itemViewList;
var segment03_mw006_selectedItemList = [];
var segment03_mw006_selectedTagList = []
var segment03_mw006_selectedExcludeItemList = [];
var segment03_mw006_selectedDefaultItemList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw006_isOpen()
{
	return ($("#segment03_mw006").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw006_isOpen

/**
 * Show spinner on Column 2
 */
function segment03_mw006_showSpinner()
{
	$('#segment03_mw006_spinner').show();
	$('#segment03_mw006_col2_part1').hide();
	$('#segment03_mw006_col2_part2').hide();
	$('#segment03_mw006_col2_part3').hide();
	$('#segment03_mw006_col2_part4').hide();
	$('#segment03_mw006_col3_part1').hide();
} // .end of segment03_mw006_showSpinner

/**
 * Hide spinner on Column 2
 */
function segment03_mw006_hideSpinner()
{
	$('#segment03_mw006_spinner').hide();
	$('#segment03_mw006_col2_part1').show();
	$('#segment03_mw006_col2_part2').show();
	$('#segment03_mw006_col2_part3').show();
	$('#segment03_mw006_col2_part4').show();
	$('#segment03_mw006_col3_part1').show();
} // .end of segment03_mw006_hideSpinner

/**
 * Init state of modal window
 */
function segment03_mw006_init()
{
	if (segment03_mw006_initialized)
		return false;
	
	$(".chosen-select").chosen({
		width: "100%",
    	allow_single_deselect:true, 
	   	search_contains: true
	});
	
 	// EVENT LISTENER: Category changed
    $("#segment03_mw006_category").on('change', function() {
    	segment03_mw006_onCategoryChanged();
 	});
 	
 	// EVENT LISTENER: Item group name changed
 	$( "#segment03_mw006_itemGroupList" ).on('change', function() {
    	segment03_mw006_onItemGroupChanged();
 	});
 	
 	// EVENT LISTENER: Selection Mode Changed (Single/Multiple)
    $("#segment03_mw006_selectionMode").on('change', function() {
 	  	var selectionMode = $("#segment03_mw006_selectionMode").val();
 	  	segment03_mw006_onSelectionModeChanged(selectionMode);
 	});
 	
    // EVENT LISTENER: item list changed
	$('#segment03_mw006_itemList').on('change', function(evt, params) {
       	segment03_mw006_onItemChanged($("#segment03_mw006_itemList").val(), params.selected, params.deselected);
    });
	
    // EVENT LISTENER: tag list changed
	$('#segment03_mw006_tagList').on('change', function(evt, params) {
       	segment03_mw006_onTagChanged($("#segment03_mw006_tagList").val(), params.selected, params.deselected);
    });
    
    // EVENT LISTENER: excluded item list changed
	$('#segment03_mw006_excludeItemList').on('change', function(evt, params) {
       	segment03_mw006_onExcludeItemChanged($("#segment03_mw006_excludeItemList").val(), params.selected, params.deselected);
    });

    // EVENT LISTENER: default item list changed
	$('#segment03_mw006_defaultItemList').on('change', function(evt, params) {
       	segment03_mw006_onDefaultItemChanged($("#segment03_mw006_defaultItemList").val(), params.selected, params.deselected);
    });
    
    segment03_mw006_initialized = true;
} // .end of segment03_mw006_init

/**
 * Open modal window.
 */
function segment03_mw006_open()
{
	segment03_mw006_init();
	
	// Hide Panels
	$("#segment03_mw006_col1_part0").hide();
	$("#segment03_mw006_col1_part1").hide();
	$("#segment03_mw006_col1_part2").hide();
	$("#segment03_mw006_col2_part1").hide();
	$("#segment03_mw006_col2_part2").hide();
	$("#segment03_mw006_col2_part3").hide();
	$("#segment03_mw006_col2_part4").hide();
	$("#segment03_mw006_col3_part1").hide();
	
	// Reset to Initial State
	$('#segment03_mw006_errorMessage').hide();
	$("#segment03_mw006_selectionMode").val("0");
	$("#segment03_mw006_helpText").val("");
	$("#segment03_mw006_minimumSelection").val("");
	$("#segment03_mw006_maximumSelection").val("");
   	$("#segment03_mw006_allowDefaultQuantityOnly").iCheck('uncheck');
	
	// Load category into Select
	$("#segment03_mw006_category").empty();
	$("#segment03_mw006_category").append('<option value="0">-- SELECT CATEGORY --</option>');
	
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
			$("#segment03_mw006_category").append('<option value="' + categoryObj.id + '">' + categoryObj.name + '</option>');
		}
	});

	$('#segment03_mw006_category').trigger('chosen:updated');
		
	$("#segment03_mw006_itemList").empty();
	$('#segment03_mw006_itemList').trigger('chosen:updated');
	
	$("#segment03_mw006_tagList").empty();
	$('#segment03_mw006_tagList').trigger('chosen:updated');

	$("#segment03_mw006_excludeItemList").empty();
	$('#segment03_mw006_excludeItemList').trigger('chosen:updated');

	$("#segment03_mw006_defaultItemList").empty();
	$('#segment03_mw006_defaultItemList').trigger('chosen:updated');
	
	$("#segment03_mw006_selected_items").empty();

	// Show Modal Window
	module_showModalWindow('segment03_mw006', true);
} // .end of segment03_mw006_open

/**
 * Event Listener: on category changed.
 */
function segment03_mw006_onCategoryChanged()
{
	var categoryId = $("#segment03_mw006_category").val();
	
	if (categoryId == '0')
	{
		$("#segment03_mw006_col1_part0").hide();
		$("#segment03_mw006_col1_part1").hide();
		$("#segment03_mw006_col1_part2").hide();
		$("#segment03_mw006_col2_part1").hide();
		$("#segment03_mw006_col2_part2").hide();
		$("#segment03_mw006_col2_part3").hide();
		$("#segment03_mw006_col2_part4").hide();
		$("#segment03_mw006_col3_part1").hide();
		
		return false;
	}
	else
	{
		$("#segment03_mw006_col1_part0").show();
		$("#segment03_mw006_col1_part1").hide();
		$("#segment03_mw006_col1_part2").hide();
		$("#segment03_mw006_col2_part1").hide();
		$("#segment03_mw006_col2_part2").hide();
		$("#segment03_mw006_col2_part3").hide();
		$("#segment03_mw006_col2_part4").hide();
		$("#segment03_mw006_col3_part1").hide();
	}
	
	$('#segment03_mw006_itemGroupList').empty();
	$("#segment03_mw006_itemGroupList").append('<option value="0">-- SELECT ITEM GROUP --</option>');
	
	segment03_mw006_categoryObj = Cached_getCategoryById( categoryId );
	// Sort by itemGroupName
	segment03_mw006_categoryObj.itemGroupList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	$.each(segment03_mw006_categoryObj.itemGroupList, function(i, itemGroupName) {
		$('#segment03_mw006_itemGroupList').append( '<option value="' + itemGroupName + '">' + itemGroupName + '</option>' );
	});	
	$('#segment03_mw006_itemGroupList').trigger('chosen:updated');
} // .end of segment03_mw006_onCategoryChanged

/**
 * Listen to selection changed on Component name
 */
function segment03_mw006_onItemGroupChanged()
{
	var itemGroupList = $("#segment03_mw006_itemGroupList").val();
	if (itemGroupList == '0')
		return false;
	
	// Show Spinner
	segment03_mw006_showSpinner();

	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': segment03_mw006_categoryObj.id,
		'filterByGroupName': true,
		'groupName': itemGroupList,
		'fullBean': false,
		'viewBean': true
	};

	var params = new Object();
	params.itemGroupList = itemGroupList;

	// Ajax Call
	tycheesdb_api_getItemsByCategory(requestBody, segment03_mw006_onItemGroupChanged_postHandler, params);
} // .end of segment03_mw006_onItemGroupChanged

function segment03_mw006_onItemGroupChanged_postHandler(successFlag, responseObj, params)
{
	// Hide Spinner
	segment03_mw006_hideSpinner();

	// If fail at ajax, then stop
	if (successFlag==false)
		return false;

	segment03_mw006_itemViewList = responseObj.itemViewList;

	// Reset
	segment03_mw006_selectedItemList = [];
	segment03_mw006_selectedTagList = []
	segment03_mw006_selectedExcludeItemList = [];
	segment03_mw006_selectedDefaultItemList = [];
	
	// empty item selection
	$("#segment03_mw006_itemList").empty();
	$("#segment03_mw006_tagList").empty();
	$("#segment03_mw006_excludeItemList").empty();
	$("#segment03_mw006_defaultItemList").empty();
	$("#segment03_mw006_selected_items").empty();
	
	// Show panel
	$("#segment03_mw006_col1_part0").show();
	$("#segment03_mw006_col1_part1").show();
	$("#segment03_mw006_col2_part1").show();
	$("#segment03_mw006_col2_part2").show();
	$("#segment03_mw006_col2_part3").show();
	$("#segment03_mw006_col2_part4").show();
	$("#segment03_mw006_col3_part1").show();
	
	// add tags in given category to selection panel
	var tagList = [], uniqueTagList = [];
	$.each(responseObj.itemViewList, function(i, itemObj){
		var labelsVal = $.trim(itemObj.labels).split(',');
		$.each(labelsVal, function(j, labelVal){
			tagList.push( labelVal );
		});
	});
	
	// Compile unique list
	$.each(tagList, function(index, tag){
	    if($.inArray(tag, uniqueTagList) === -1) 
	    	uniqueTagList.push(tag);
	});
	
	// Sorting asc
	uniqueTagList.sort();
	
	// Add to chosen-select
	$.each(uniqueTagList, function(index, tag){
        $("#segment03_mw006_tagList").append('<option value="' + tag + '">' + tag + '</option>');
	});
	$('#segment03_mw006_tagList').trigger('chosen:updated');
    // .end of add tag
	
	// add items in given category to selection panel
	$.each(responseObj.itemViewList, function(i, itemObj){
		if (segment03_itemObj.id != itemObj.id)
		{
  	    	$("#segment03_mw006_itemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
		}
	});
	$('#segment03_mw006_itemList').trigger('chosen:updated');
} // .end of segment03_mw006_onItemGroupChanged

/**
 * When SELECT 'Selection Mode' change value. 
 */
function segment03_mw006_onSelectionModeChanged(selectionMode)
{
	if (selectionMode=='single')
	{
		$("#segment03_mw006_minimumSelection").prop('disabled', true);
		$("#segment03_mw006_minimumSelection").val('1');

		$("#segment03_mw006_maximumSelection").prop('disabled', true);
		$("#segment03_mw006_maximumSelection").val('1');
	}
	else
	if (selectionMode=='multiple')
	{
		$("#segment03_mw006_minimumSelection").prop('disabled', false);
		$("#segment03_mw006_maximumSelection").prop('disabled', false);
	}
} // .end of segment03_mw006_onSelectionModeChanged

/**
 * Event listener: As user select/deselect item from chosen-select, this
 * function will add/remove item id into the list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw006_onItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw006_selectedItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw006_selectedItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw006_selectedItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw006_updateUI_selectedItemList();
} // .end of segment03_mw006_onItemChanged

/**
 * Event listener: As user select/deselect tag from chosen-select, this
 * function will add/remove tag into tag list.
 *
 * @params	{Array}		tagList - List of Tag
 * @params	{String}	selectedTag - Selected tag
 * @params	{String}	deselectedTag - Deselected tag
 */
function segment03_mw006_onTagChanged(tagList, selectedTag, deselectedTag)
{
	if ( $.trim(selectedTag).length != 0 )
	{
		segment03_mw006_selectedTagList.push( selectedTag );
		
		// Filter out items which appear in col-2 'Individual Item Selection'
		$("#segment03_mw006_itemList").children('option').each(function(i) { 
			var itemId = $(this).val();
			var itemObj = Cached_getItemById(itemId, segment03_mw006_itemViewList);			
			if ($.trim(itemObj.labels).indexOf( $.trim(selectedTag) ) != -1)
			{
				this.remove();
			}
		});
		
		$("#segment03_mw006_itemList").trigger("chosen:updated");
	}
	
	if ( $.trim(deselectedTag).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw006_selectedTagList, function(i, tagVal){
			if (tagVal == deselectedTag) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw006_selectedTagList.splice(selectedIndex, 1);
		
		// add items in given category to selection panel
		var itemList = Cached_getItemListByCategoryId(segment03_mw006_categoryObj.id, true, segment03_mw006_itemViewList);				
		$.each(itemList, function(j, itemObj) {
			if (segment03_itemObj.id != itemObj.id)
			{
				if ($.trim(itemObj.labels).indexOf(deselectedTag) != -1)
				{
		  	    	$("#segment03_mw006_itemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
				}
			}
		});	

		$('#segment03_mw006_itemList').trigger('chosen:updated');
	}
	
	// Update UI - selected items
	segment03_mw006_updateUI_selectedItemList();
} // .end of segment03_mw006_onTagChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into exclude list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw006_onExcludeItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw006_selectedExcludeItemList.push( selectedItem );

	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw006_selectedExcludeItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw006_selectedExcludeItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw006_updateUI_selectedItemList();
} // .end of segment03_mw006_onExcludeItemChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into default list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw006_onDefaultItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw006_selectedDefaultItemList.push( selectedItem );

	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw006_selectedDefaultItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw006_selectedDefaultItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw006_updateUI_selectedItemList();
} // .end of segment03_mw006_onExcludeItemChanged

/**
 * Update UI, after user select/deselect items/tags from middle column chosen-select 
 * components (Select Items, Select Tags & Select Excluded Items). 
 */
function segment03_mw006_updateUI_selectedItemList()
{
	// #1. Check repeated item between selected items and tags.
	var removedItemIdList = [];
	$.each(segment03_mw006_selectedItemList, function(i, itemId){
		$.each(segment03_mw006_selectedTagList, function(j, tagVal){		
			var itemObj = Cached_getItemById(itemId, segment03_mw008_itemViewList);			
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
			{
				removedItemIdList.push( itemId );
			}
		});
	});
	
	$.each(removedItemIdList, function(i, itemId){ 
		segment03_mw006_selectedItemList.splice(i, 1);
	});
	
	// #2. Compile item list
	var itemList = [];
	var selectedItemIdList = [];
	var selectedItemList = [];
	var excludeItemIdList = [];
	var excludeItemList = [];
	var defaultItemIdList = [];
	var defaultItemList = [];
	
	// extract item id from list (chosen-select)
	$.each(segment03_mw006_selectedItemList, function(i, itemId){
		itemList.push(itemId);
	});
	
	// extract item id from tag (chosen-select)
	$.each(segment03_mw006_itemViewList, function(i, itemObj){
		$.each(segment03_mw006_selectedTagList, function(j, tagVal){
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
			{
				itemList.push( itemObj.id );
			}
		});
	});
	
	// #3. Compile unique list (and Not inside exclude list)
	$.each(itemList, function(i, itemId){
	    if($.inArray(itemId, selectedItemIdList) == -1 &&
	       $.inArray(itemId, segment03_mw006_selectedExcludeItemList) == -1) 
	    {
	    	selectedItemIdList.push( itemId );
	    	defaultItemIdList.push( itemId );
	    }
	    
	    if($.inArray(itemId, selectedItemIdList)) 
	    {
	    	excludeItemIdList.push( itemId );
	    }
	});
	
	$.each(selectedItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId, segment03_mw006_itemViewList );
    	if (itemObj != null)
    		selectedItemList.push( itemObj );
	});
	$.each(excludeItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId, segment03_mw006_itemViewList );
    	if (itemObj != null)
    		excludeItemList.push( itemObj );
	});
	$.each(defaultItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId, segment03_mw006_itemViewList);
    	if (itemObj != null)
    		defaultItemList.push( itemObj );
	});
	
	// Sorting item objects
	selectedItemList.sort(function(a, b){
		if(a.name < b.name) return -1;
    	if(a.name > b.name) return 1;
    	return 0;
	});
	excludeItemList.sort(function(a, b){
		if(a.name < b.name) return -1;
    	if(a.name > b.name) return 1;
    	return 0;
	});
	defaultItemList.sort(function(a, b){
		if(a.name < b.name) return -1;
    	if(a.name > b.name) return 1;
    	return 0;
	});

	// #4.1 Append list to selected items
	$("#segment03_mw006_selected_items").empty();	
	$.each(selectedItemList, function(i, itemObj){		
		$("#segment03_mw006_selected_items").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	
	// #4.2 Append list to excluded items
	$("#segment03_mw006_excludeItemList").empty();	
	$.each(excludeItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw006_selectedExcludeItemList) >= 0)
			$("#segment03_mw006_excludeItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw006_excludeItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw006_excludeItemList').trigger('chosen:updated');
	
	// #4.3 Append list to default items
	$("#segment03_mw006_defaultItemList").empty();	
	$.each(defaultItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw006_selectedDefaultItemList) >= 0)
			$("#segment03_mw006_defaultItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw006_defaultItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw006_defaultItemList').trigger('chosen:updated');
} // .end of segment03_mw006_updateUI_selectedItemList

/**
 * Save components into cache. 
 */
function segment03_mw006_onSave()
{
	// Input Validation
	var selectionMode       = $("#segment03_mw006_selectionMode").val();
	var minimumSelectionVal = $("#segment03_mw006_minimumSelection").val();
	var maximumSelectionVal = $("#segment03_mw006_maximumSelection").val();

	// Reset/Hide error messages
	$("#segment03_mw006_errorMessage").hide();
	$("#segment03_mw006_errorMessage").html('');
	
	// START Validation
	if (isNaN(minimumSelectionVal))
    {
		$("#segment03_mw006_errorMessage").show();
    	$("#segment03_mw006_errorMessage").html("Invalid Minimum Selection. It must be a Integer value.");
		return false;
    }
    if (isNaN(maximumSelectionVal))
    {
		$("#segment03_mw006_errorMessage").show();
    	$("#segment03_mw006_errorMessage").html("Invalid Maximum Selection. It must be a Integer value.");
		return false;
    }    
    // .end of Input Validation
    
    // Prepare variables
	var itemIdList = [];
	$("#segment03_mw006_itemList").children('option').each(function(i) { 
		var itemId = $(this).val();
		var itemCheck = $(this).is(":selected");
		
		if (itemCheck==true)
		{
			itemIdList.push( $.trim(itemId));
		}
	});
	
	var tagsList = $("#segment03_mw006_tagList").val();
	if (tagsList==null)
		tagsList = [];
	var tagsVal = tagsList.toString();	

	var selectionModeVal = $("#segment03_mw006_selectionMode").val();
	if (selectionModeVal == '')
		selectionModeVal = 'multiple';
	
	var defaultQuantityVal = $.trim( $("#segment03_mw006_defaultQuantity").val() );
	if (defaultQuantityVal=='')
		defaultQuantityVal = 0;
	
	var allowDefaultQuantityOnlyVal = $("#segment03_mw006_allowDefaultQuantityOnly").is(":checked");
	
	// Init component JSON object
	var newComponentObj = createNew_InventoryItemComponent();
	newComponentObj.itemId = $('#segment03_itemId').val();
	newComponentObj.seqno = segment03_itemObj.componentList.length + 1;
	newComponentObj.categoryId = segment03_mw006_categoryObj.id;
	newComponentObj.itemGroupList = $('#segment03_mw006_itemGroupList').val();
	newComponentObj.title = segment03_mw006_categoryObj.name;
	newComponentObj.helpText = $.trim( $("#segment03_mw006_helpText").val() );
	newComponentObj.selectable = false;
	newComponentObj.selectionMode = selectionModeVal;
	newComponentObj.minimumSelection = Number(minimumSelectionVal).toFixed(0);
	newComponentObj.maximumSelection = Number(maximumSelectionVal).toFixed(0);
	newComponentObj.defaultQuantity = defaultQuantityVal;
	newComponentObj.allowDefaultQuantityOnly = allowDefaultQuantityOnlyVal;
	newComponentObj.tags = tagsVal;
	newComponentObj.itemIds = itemIdList.toString();
	newComponentObj.excludeItemIds = segment03_mw006_selectedExcludeItemList.toString();
	newComponentObj.defaultItemIds = segment03_mw006_selectedDefaultItemList.toString();
	
	// Push into list
	segment03_itemObj.componentList.push(newComponentObj);	
    // Save inventory item
    tycheesIO_saveBean(segment03_itemObj);
	// Hide Modal Window
	$('#segment03_mw006').modal('hide');
    // Update UI
    segment03_updateUI_tab3( segment03_itemObj );
} // .end of segment03_mw006_onSave

</script>