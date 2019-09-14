<!-- MODAL WINDOW: Edit MandatoryComponent -->
<div class="modal inmodal" id="segment03_mw008" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">EDIT MANDATORY COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body" style="height:480px;">
            	<div class="row" id="segment03_mw008_errorMessage" style="color:#FF0000;">
                </div>
            	<div class="row">
            		<div class="col-lg-4">
            			<div class="form-group">
            			    <div>
            				    <label>Selected Category (Show as title in POS)</label> 
							    <input id="segment03_mw008_category" type="text" placeholder="" class="form-control" disabled>
							</div>
							
							<div id="segment03_mw008_col1_part0" style="display:none;">
			                	<label>Selected Item Group</label> 
		                		<input id="segment03_mw008_itemGroupList" type="text" placeholder="" class="form-control" disabled>
								<br/>
							</div>
							
							<div id="segment03_mw008_col1_part1" style="display:none;">
			                	<label>Help Text (Show as instruction in POS)</label> 
			                	<input id="segment03_mw008_helpText" type="text" placeholder="" class="form-control">
			                	<label>Default Quantity (Show when first selected in POS)</label> 
			                	<input id="segment03_mw008_defaultQuantity" type="number" placeholder="" class="form-control">
								<br/><br/>
							</div>
							
							<div id="segment03_mw008_col1_part2" style="display:none;">
								<label>
			                		<input type="checkbox" class="i-checks" id="segment03_mw008_allowDefaultQuantityOnly" data-toggle="tooltip" data-placement="left" title=""> 
			                		<i></i> Allow Default Quantity Only 
			                	</label> 
								<br/><br/>
			                	<label>Selection Mode</label> 
		                		<select id="segment03_mw008_selectionMode" class="form-control">
		                			<option value="0">-- SELECT --</option>
		                			<option value="single">Single Selection</option>
		                			<option value="multiple">Multiple Selection</option>
								</select>
			                	<label>Minimum Selection</label> 
			                	<input id="segment03_mw008_minimumSelection" type="number" placeholder="" class="form-control">
			                	<label>Maximum Selection</label> 
			                	<input id="segment03_mw008_maximumSelection" type="number" placeholder="" class="form-control">				                	
			                </div>
		                </div>
            		</div>
            		<div class="col-lg-4">	
            			<div id="segment03_mw008_spinner" class="spiner-example" style="display:none; padding:0px; height:28px;">
							<div class="sk-spinner sk-spinner-three-bounce">
                                <div class="sk-bounce1"></div>
                                <div class="sk-bounce2"></div>
                                <div class="sk-bounce3"></div>
                            </div>
						</div>
						<div id="segment03_mw008_col2_part1" style="display:none;">
							<label>Select Individual Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw008_itemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
		                </div>
            			<div id="segment03_mw008_col2_part2" style="display:none;">
		                	<label>Select Items by Tag</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw008_tagList" data-placeholder="--- SELECT TAG ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
                        <div id="segment03_mw008_col2_part3" style="display:none;">
		                	<label>Exclude These Items</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw008_excludeItemList" data-placeholder="--- SELECT ITEM ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
                        <div id="segment03_mw008_col2_part4" style="display:none;">
		                	<label>Default Selected Items</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw008_defaultItemList" data-placeholder="--- SELECT ITEM ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
            		</div>
            		<div class="col-lg-4">
            			<div id="segment03_mw008_col3_part1" style="display:none;">
		                	<label>You've selected following item list:</label> 
		                	<br/>
			                <div class="form-group">
				                <div class="input-group" style="width:100%;">
                                    <select id="segment03_mw008_selected_items" class="form-control" multiple style="height:400px;">
                                    </select>
                                </div>
                            </div>
                        </div>
            		</div>
            	</div>	                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment03_mw008_onSave();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Update</button>
            </div>
        </div>
    </div>
</div>


<script>

var segment03_mw008_initialized = false;
var segment03_mw008_componentObj;
var segment03_mw008_categoryObj;
var segment03_mw008_itemViewList;

var segment03_mw008_selectedItemList = [];
var segment03_mw008_selectedTagList = []
var segment03_mw008_selectedExcludeItemList = [];
var segment03_mw008_selectedDefaultItemList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw008_isOpen()
{
	return ($("#segment03_mw008").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw008_isOpen

/**
 * Init state of modal window
 */
function segment03_mw008_init()
{
	if (segment03_mw008_initialized)
		return false;
	
	$(".chosen-select").chosen({
		width: "100%",
    	allow_single_deselect:true, 
	   	search_contains: true
	});
	
	// EVENT LISTENER: on selection mode (single/multiple) changed.
	$("#segment03_mw008_selectionMode").on('change', function() {
 	  	var selectionMode = $("#segment03_mw008_selectionMode").val();
 	  	segment03_mw008_onSelectionModeChanged(selectionMode);
 	});
    
 	// EVENT LISTENER: on item changed.
	$('#segment03_mw008_itemList').on('change', function(evt, params) {
       	segment03_mw008_onItemChanged($("#segment03_mw008_itemList").val(), params.selected, params.deselected);
    });
	
	// EVENT LISTENER: on tag changed.
	$('#segment03_mw008_tagList').on('change', function(evt, params) {	
        segment03_mw008_onTagChanged($("#segment03_mw008_tagList").val(), params.selected, params.deselected);
    });
	
	// EVENT LISTENER: on excluded item changed.
	$('#segment03_mw008_excludeItemList').on('change', function(evt, params) {	
        segment03_mw008_onExcludeItemChanged($("#segment03_mw008_excludeItemList").val(), params.selected, params.deselected);
    });
    
	// EVENT LISTENER: on default item changed.
	$('#segment03_mw008_defaultItemList').on('change', function(evt, params) {	
        segment03_mw008_onDefaultItemChanged($("#segment03_mw008_defaultItemList").val(), params.selected, params.deselected);
    });
	
    segment03_mw008_initialized = true;
} // .end of segment03_mw008_init

function segment03_mw008_showSpinner()
{
	$('#segment03_mw008_spinner').show();
	$('#segment03_mw008_col2_part1').hide();
	$('#segment03_mw008_col2_part2').hide();
	$('#segment03_mw008_col2_part3').hide();
	$('#segment03_mw008_col2_part4').hide();
	$('#segment03_mw008_col3_part1').hide();
} // .end of segment03_mw008_showSpinner

function segment03_mw008_hideSpinner()
{
	$('#segment03_mw008_spinner').hide();
	$('#segment03_mw008_col2_part1').show();
	$('#segment03_mw008_col2_part2').show();
	$('#segment03_mw008_col2_part3').show();
	$('#segment03_mw008_col2_part4').show();
	$('#segment03_mw008_col3_part1').show();
} // .end of segment03_mw008_hideSpinner

/**
 * Open modal window
 */
function segment03_mw008_open(componentId)
{
	// Show progress status
	tycheesOverlay_startShortProgress('loading...');
	
	// Init states, if any
	segment03_mw008_init();
	
	// Reset to initial state
	$('#segment03_mw008_errorMessage').hide();
	
	// Show Spinner
	segment03_mw008_showSpinner();

	var params = new Object();
	params.componentId = componentId;
	
	$.each(segment03_itemObj.componentList, function(i, componentObj){    	
    	if ($.trim(componentId)==$.trim(componentObj.id))
    	{
    		segment03_mw008_componentObj = componentObj;
    	}
	});
	
	var filterByGroupName = true;
	if ($.trim(segment03_mw008_componentObj.itemGroupList)=='')
		filterByGroupName = false;
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': segment03_mw008_componentObj.categoryId,
		'filterByGroupName': filterByGroupName,
		'groupName': segment03_mw008_componentObj.itemGroupList,
		'fullBean': false,
		'viewBean': true
	};

	// Ajax Call
	tycheesdb_api_getItemsByCategory(requestBody, segment03_mw008_open_postHander, params);
} // .end of segment03_mw008_open

function segment03_mw008_open_postHander(successFlag, responseObj, params)
{
	// Hide Spinner
	segment03_mw008_hideSpinner();

	if (successFlag==false) 
	{
		tycheesOverlay_stopShortProgress();
		return false;
	}

	// Set item list
	segment03_mw008_itemViewList = responseObj.itemViewList;
	
	// Init variables
	segment03_mw008_selectedItemList        = $.trim(segment03_mw008_componentObj.itemIds)=='' ? [] : segment03_mw008_componentObj.itemIds.split(',');
	segment03_mw008_selectedTagList         = $.trim(segment03_mw008_componentObj.tags)=='' ? [] : segment03_mw008_componentObj.tags.split(',');
	segment03_mw008_selectedExcludeItemList = $.trim(segment03_mw008_componentObj.excludeItemIds)=='' ? [] : segment03_mw008_componentObj.excludeItemIds.split(',');
	segment03_mw008_selectedDefaultItemList = $.trim(segment03_mw008_componentObj.defaultItemIds)=='' ? [] : segment03_mw008_componentObj.defaultItemIds.split(',');

	// Show/Hide panels
	$("#segment03_mw008_col1_part0").show();
	$("#segment03_mw008_col1_part1").show();
	$("#segment03_mw008_col2_part1").show();
	
	// Load category into Select
	$.each(Cached_getCategoryList(), function(j, categoryObj){
		// Get currently selected Item ID
		if (segment03_mw008_componentObj.categoryId == categoryObj.id) 
		{
			segment03_mw008_categoryObj = categoryObj;
		}
	});

	// COLUMN #1
	// Set values
	$("#segment03_mw008_category").val(segment03_mw008_categoryObj.name);
	$('#segment03_mw008_itemGroupList').val(segment03_mw008_componentObj.itemGroupList);
	$("#segment03_mw008_helpText").val(segment03_mw008_componentObj.helpText);		
	$("#segment03_mw008_selectionMode").val(segment03_mw008_componentObj.selectionMode);
	$("#segment03_mw008_minimumSelection").prop('disabled', segment03_mw008_componentObj.selectionMode=='single');
	$("#segment03_mw008_maximumSelection").prop('disabled', segment03_mw008_componentObj.selectionMode=='single');
	$("#segment03_mw008_minimumSelection").val(segment03_mw008_componentObj.minimumSelection);
	$("#segment03_mw008_maximumSelection").val(segment03_mw008_componentObj.maximumSelection);
	$("#segment03_mw008_defaultQuantity").val(segment03_mw008_componentObj.defaultQuantity);
	
	// Hide/Show panels
	if (segment03_mw008_componentObj.categoryId=='0')
	{
		$("#segment03_mw008_col1_part0").hide();
		$("#segment03_mw008_col1_part1").hide();
		$("#segment03_mw008_col1_part2").hide();
		$("#segment03_mw008_col2_part1").hide();
		$("#segment03_mw008_col2_part2").hide();
		$("#segment03_mw008_col2_part3").hide();
		$("#segment03_mw008_col2_part4").hide();
		$("#segment03_mw008_col3_part1").hide();
	}
	else
	{
		$("#segment03_mw008_col1_part0").show();
		$("#segment03_mw008_col1_part1").show();
		$("#segment03_mw008_col2_part1").show();
		$("#segment03_mw008_col2_part2").show();
		$("#segment03_mw008_col2_part3").show();
		$("#segment03_mw008_col2_part4").show();
		$("#segment03_mw008_col3_part1").show();		
	}
	
	if (segment03_mw008_componentObj.allowDefaultQuantityOnly==true)
	{
		$('#segment03_mw008_allowDefaultQuantityOnly').iCheck('check');
	}
	else
	{
		$('#segment03_mw008_allowDefaultQuantityOnly').iCheck('uncheck');
	}
	
	// If component is MANDATORY, hide COL-01-PART-02
	$("#segment03_mw008_col1_part2").hide();
		
	// COLUMN #2
	// Step 1: 
	// a. Get item(s) that belong to this component
	// b. extract label(s) from each item, and insert into array list.
	var tagList = [], 
	    uniqueTagList = [], 
	    selectedTagList = [];
	
	$.each(responseObj.itemViewList, function(i, itemObj){
		var labelsVal = $.trim(itemObj.labels).split(',');
		$.each(labelsVal, function(j, labelVal){
			tagList.push( labelVal );
		});
	});
	
	// Step 2: 
	// a. filter array of labels into unique list (remove duplicates)
	$.each(tagList, function(i, tag){
	    if($.inArray(tag, uniqueTagList) === -1) 
	    	uniqueTagList.push(tag);
	});

	// Sorting asc
	uniqueTagList.sort();
	
	// Step 3: 
	// a. add list of labels into input component (select).
	$("#segment03_mw008_tagList").empty();
	$('#segment03_mw008_tagList').trigger('chosen:updated');
	
	$.each(uniqueTagList, function(i, tag) {
		if ( $.trim(tag).length != 0)
		{
			if (segment03_mw008_componentObj.tags.indexOf(tag) == -1)
			{
				$("#segment03_mw008_tagList").append('<option value="' + tag + '">' + tag + '</option>');
			}
			else
			{
				$("#segment03_mw008_tagList").append('<option value="' + tag + '" selected>' + tag + '</option>');
				selectedTagList.push(tag);
			}
		}
	});

	$('#segment03_mw008_tagList').trigger('chosen:updated');
    // .end of add tag
	
	// COLUMN #3
	// add items in given category to selection panel
	$("#segment03_mw008_itemList").empty();
	$('#segment03_mw008_itemList').trigger('chosen:updated');

	// 1. iterate thru items in the category
	// 2. Add to list if:
	//    - the item is not the component item, and
	//    - the item has label name same as the selected tag name(s)
	$.each(segment03_mw008_itemViewList, function(j, itemObj){

		// If the item is part of the selected tag, then do not add it into this selection list.
		var addToList = true;
		if (segment03_itemObj.id == itemObj.id)
		{
			addToList = false;
		}
		else
		{
			// Item has label(s), then check the label
			if ($.trim(itemObj.labels) != '')
			{								
				$.each(selectedTagList, function(k, tagName) {	
					// This item CONTAINS this selected tag, so can DO NOT add to selection list.
					if (itemObj.labels.indexOf(tagName) >= 0)
					{
						addToList = false;	
					}
				});
			}
		}
		
		// Check if item inside exclude list.
		if ($.inArray(itemObj.id, segment03_mw008_selectedExcludeItemList) >= 0)
			addToList = false;
		
		if (addToList==true)
		{
			var selectedVal = 'selected';
			if($.inArray(itemObj.id, segment03_mw008_selectedItemList) == -1) 
				selectedVal = '';
			
  	    	$("#segment03_mw008_itemList").append('<option value="' + itemObj.id + '" ' + selectedVal + '>' + itemObj.name + '</option>');				  	    	
		}
	});		
	
	$('#segment03_mw008_itemList').trigger('chosen:updated');
				
	// Col 2, Part 3 - Exclude Item List
	segment03_mw008_onExcludeItemChanged(segment03_mw008_selectedExcludeItemList, null, null);

	// Col 2, Part 4 - Default Item List
	segment03_mw008_onDefaultItemChanged(segment03_mw008_selectedDefaultItemList, null, null);
	
	// Col 3, Part 1 - Remove Selected items if tags hav cover it. 
	$.each(segment03_mw008_selectedTagList, function(i, tag){
		// Filter out items which appear in col-3 'Individual Item Selection'
		$("#segment03_mw008_itemList").children('option').each(function(i) { 
			var itemId = $(this).val();
			var itemObj = Cached_getItemById(itemId, segment03_mw008_itemViewList);			
			if ($.trim(itemObj.labels).indexOf( $.trim(tag) ) != -1)
			{
				this.remove();
			}
		});
	});
	
	segment03_mw008_updateUI_selectedItemList();

	tycheesOverlay_stopShortProgress();
	
	// Show modal window
	module_showModalWindow('segment03_mw008', true);
} // .end of segment03_mw008_open


/**
 * Listen to change of SELECT 'Selection Mode'.
 */
function segment03_mw008_onSelectionModeChanged(mode)
{
	if (mode=='single')
	{
		$("#segment03_mw008_minimumSelection").prop('disabled', true);
		$("#segment03_mw008_minimumSelection").val('1');

		$("#segment03_mw008_maximumSelection").prop('disabled', true);
		$("#segment03_mw008_maximumSelection").val('1');
	}
	else
	if (mode=='multiple')
	{
		$("#segment03_mw008_minimumSelection").prop('disabled', false);
		$("#segment03_mw008_maximumSelection").prop('disabled', false);
	}
} // .end of segment03_mw008_onSelectionModeChanged

/**
 * Event listener: As user select/deselect item from chosen-select, this
 * function will add/remove item id into the list.
 *
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw008_onItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw008_selectedItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw008_selectedItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw008_selectedItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw008_updateUI_selectedItemList();
} // .end of segment03_mw008_onItemChanged

/**
 * Event listener: As user select/deselect tag from chosen-select, this
 * function will add/remove tag into tag list.
 * 
 * @params	{Array}		tagList - List of Tag
 * @params	{String}	selectedTag - Selected tag
 * @params	{String}	deselectedTag - Deselected tag
 */
function segment03_mw008_onTagChanged(tagList, selectedTag, deselectedTag)
{
	if ( $.trim(selectedTag).length != 0 )
	{
		segment03_mw008_selectedTagList.push( selectedTag );
	
		// Filter out items which appear in col-3 'Individual Item Selection'
		$("#segment03_mw008_itemList").children('option').each(function(i) { 
			var itemId = $(this).val();
			var itemObj = Cached_getItemById(itemId, segment03_mw008_itemViewList);			
			if ($.trim(itemObj.labels).indexOf( $.trim(selectedTag) ) != -1)
			{
				this.remove();
			}
		});
	}
	
	if ( $.trim(deselectedTag).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw008_selectedTagList, function(i, tagVal){
			if (tagVal == deselectedTag) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw008_selectedTagList.splice(selectedIndex, 1);
		
		// add items in given category to selection panel
		var itemList = Cached_getItemListByCategoryId(segment03_mw008_categoryObj.id, true, segment03_mw008_itemViewList);
		$.each(itemList, function(i, itemObj) {
			if (segment03_itemObj.id != itemObj.id)
			{
				if ($.trim(itemObj.labels).indexOf(deselectedTag) != -1)
				{		
		  	    	$("#segment03_mw008_itemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
				}
			}
		});	
		$('#segment03_mw008_itemList').trigger('chosen:updated');
	}
	
	// Update UI - selected items
	segment03_mw008_updateUI_selectedItemList();
} // .end of segment03_mw008_onTagChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into exclude list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw008_onExcludeItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw008_selectedExcludeItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw008_selectedExcludeItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw008_selectedExcludeItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw008_updateUI_selectedItemList();
} // .end of segment03_mw008_onExcludeItemChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into default list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw008_onDefaultItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw008_selectedDefaultItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw008_selectedDefaultItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw008_selectedDefaultItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw008_updateUI_selectedItemList();
} // .end of segment03_mw008_onExcludeItemChanged

/**
 * Update UI, after user select/deselect items/tags from middle column chosen-select 
 * components (Select Items, Select Tags & Select Excluded Items). 
 */
function segment03_mw008_updateUI_selectedItemList()
{
	// #1. Check repeated item between selected items and tags.
	var removedItemIdList = [];
	$.each(segment03_mw008_selectedItemList, function(i, itemId){
		$.each(segment03_mw008_selectedTagList, function(j, tagVal){		
			var itemObj = Cached_getItemById(itemId, true);			
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
			{
				removedItemIdList.push( itemId );
			}
		});
	});
	
	$.each(removedItemIdList, function(i, itemId){ 
		segment03_mw008_selectedItemList.splice(i, 1);
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
	$.each(segment03_mw008_selectedItemList, function(i, itemId){
		itemList.push(itemId);
	});
	
	// extract item id from tag (chosen-select)
	$.each(segment03_mw008_itemViewList, function(i, itemObj){
		$.each(segment03_mw008_selectedTagList, function(j, tagVal){
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
				itemList.push( itemObj.id );
		});
	});
	
	// #3. Compile unique list
	$.each(itemList, function(i, itemId){
	    if($.inArray(itemId, selectedItemIdList) == -1 &&
	       $.inArray(itemId, segment03_mw008_selectedExcludeItemList) == -1) 
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
    	var itemObj = Cached_getItemById( itemId, segment03_mw008_itemViewList );
    	if (itemObj != null)
    		selectedItemList.push( itemObj );
	});
	$.each(excludeItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId, segment03_mw008_itemViewList );
    	if (itemObj != null)
    		excludeItemList.push( itemObj );
	});
	$.each(defaultItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId, segment03_mw008_itemViewList );
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
	$("#segment03_mw008_selected_items").empty();	
	$.each(selectedItemList, function(i, itemObj){		
		$("#segment03_mw008_selected_items").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	
	// #4.2 Append list to excluded items
	$("#segment03_mw008_excludeItemList").empty();	
	$.each(excludeItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw008_selectedExcludeItemList) >= 0)
			$("#segment03_mw008_excludeItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw008_excludeItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw008_excludeItemList').trigger('chosen:updated');
	
	// #4.3 Append list to default items
	$("#segment03_mw008_defaultItemList").empty();	
	$.each(defaultItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw008_selectedDefaultItemList) >= 0)
			$("#segment03_mw008_defaultItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw008_defaultItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw008_defaultItemList').trigger('chosen:updated');
} // .end of segment03_mw008_updateUI_selectedItemList

/**
 * Save component.
 */
function segment03_mw008_onSave()
{
	// Input Validation
	var selectionMode       = $("#segment03_mw008_selectionMode").val();
	var minimumSelectionVal = $("#segment03_mw008_minimumSelection").val();
	var maximumSelectionVal = $("#segment03_mw008_maximumSelection").val();

	// Reset/Hide error messages
	$("#segment03_mw008_errorMessage").hide();
	$("#segment03_mw008_errorMessage").html('');
	
	// START Validation
	if (isNaN(minimumSelectionVal))
    {
		$("#segment03_mw008_errorMessage").show();
    	$("#segment03_mw008_errorMessage").html("Invalid Minimum Selection. It must be a Integer value.");
		return false;
    }
    if (isNaN(maximumSelectionVal))
    {
		$("#segment03_mw008_errorMessage").show();
    	$("#segment03_mw008_errorMessage").html("Invalid Maximum Selection. It must be a Integer value.");
		return false;
    }    
    // .end of Input Validation
    
    // Prepare variables
	var itemIdList = [];
	$("#segment03_mw008_itemList").children('option').each(function(i) { 
		var itemId = $(this).val();
		var itemCheck = $(this).is(":selected");				
		if (itemCheck==true)
		{
			itemIdList.push( $.trim(itemId) );
		}
	});

	var tagsList = $("#segment03_mw008_tagList").val();
	if (tagsList==null)
		tagsList = [];
	var tagsVal = tagsList.toString();	

	var selectionModeVal = $("#segment03_mw008_selectionMode").val();
	if (selectionModeVal == '')
		selectionModeVal = 'multiple';
	
	var defaultQuantityVal = $.trim( $("#segment03_mw008_defaultQuantity").val() );
	if (defaultQuantityVal=='')
		defaultQuantityVal = 0;
	
	var allowDefaultQuantityOnlyVal = $("#segment03_mw008_allowDefaultQuantityOnly").is(":checked");
	
	// Update values into existing JSON object
	segment03_mw008_componentObj.title = segment03_mw008_categoryObj.name;
	segment03_mw008_componentObj.helpText = $.trim( $("#segment03_mw008_helpText").val() );
	segment03_mw008_componentObj.selectionMode = selectionModeVal;
	segment03_mw008_componentObj.minimumSelection = minimumSelectionVal;
	segment03_mw008_componentObj.maximumSelection = maximumSelectionVal;
	segment03_mw008_componentObj.defaultQuantity = defaultQuantityVal;
	segment03_mw008_componentObj.allowDefaultQuantityOnly = allowDefaultQuantityOnlyVal;
	segment03_mw008_componentObj.tags = tagsVal;
	segment03_mw008_componentObj.itemIds = itemIdList.toString();
	segment03_mw008_componentObj.excludeItemIds = segment03_mw008_selectedExcludeItemList.toString();
	segment03_mw008_componentObj.defaultItemIds = segment03_mw008_selectedDefaultItemList.toString();
	segment03_mw008_componentObj.hasChanged = true;
	
    // Save inventory item
    tycheesIO_saveBean(segment03_itemObj);
    // Update UI
    segment03_updateUI_tab3( segment03_itemObj );
	// Hide Modal Window
	$('#segment03_mw008').modal('hide');
} // .end of segment03_mw008_onSave


</script>