<!-- MODAL WINDOW: Edit Component -->
<div class="modal inmodal" id="segment03_mw003" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">EDIT COMPONENT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body" style="height:600px;">
            	<div class="row">
            		<div class="col-lg-4">
            			<div class="form-group">
		                	<input id="segment03_mw003_componentId" type="hidden" placeholder="" class="form-control">
		                	<input id="segment03_mw003_categoryId" type="hidden" placeholder="" class="form-control">
            				<label>Select Category (POS > Title)</label> 
	                		<select id="segment03_mw003_category" class="form-control" disabled>
							</select>
							
							<div id="segment03_mw003_col1_part0" style="display:none;">
			                	<label>Item Group</label> 
		                		<input id="segment03_mw003_itemGroupName" type="text" placeholder="" class="form-control" disabled>
								<br/>
							</div>
							<div id="segment03_mw003_col1_part1" style="display:none;">
			                	<label>Help Text (POS > Instruction Sentence)</label> 
			                	<input id="segment03_mw003_helpText" type="text" placeholder="" class="form-control">
			                	<label>Is this component selectable?</label> 
		                		<select id="segment03_mw003_selectable" class="form-control">
		                			<option value="0" selected>-- SELECT --</option>
		                			<option value="true" selected>Yes</option>
		                			<option value="false">No</option>
								</select>
			                	<label>Default Quantity (Show when first selected in POS)</label> 
			                	<input id="segment03_mw003_defaultQuantity" type="number" placeholder="" class="form-control">
								<br/><br/>
							</div>
							<div id="segment03_mw003_col1_part2" style="display:none;">
								<label>
			                		<input type="checkbox" class="i-checks" id="segment03_mw003_allowDefaultQuantityOnly" data-toggle="tooltip" data-placement="left" title=""> 
			                		<i></i> Allow Default Quantity Only 
			                	</label> 
								<br/><br/>
			                	<label>Selection Mode</label> 
		                		<select id="segment03_mw003_selectionMode" class="form-control">
		                			<option value="0">-- SELECT --</option>
		                			<option value="single">Single Selection</option>
		                			<option value="multiple">Multiple Selection</option>
								</select>
			                	<label>Minimum Selection</label> 
			                	<input id="segment03_mw003_minimumSelection" type="number" placeholder="" class="form-control">
			                	<label>Maximum Selection</label> 
			                	<input id="segment03_mw003_maximumSelection" type="number" placeholder="" class="form-control">				                	
			                </div>
		                	<br/>
		                	<span id="segment03_mw003_errorMessage" style="display:none;color:#FF0000;"></span>
		                </div>
            		</div>
            		<div class="col-lg-4">	
            			<div id="segment03_mw003_spinner" class="spiner-example" style="display:none; padding:0px; height:28px;">
							<div class="sk-spinner sk-spinner-three-bounce">
                                <div class="sk-bounce1"></div>
                                <div class="sk-bounce2"></div>
                                <div class="sk-bounce3"></div>
                            </div>
						</div>
						<div id="segment03_mw003_col2_part1" style="display:none;">
							<label>Select Individual Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw003_itemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
		                </div>
            			<div id="segment03_mw003_col2_part2" style="display:none;">
		                	<label>Select Items by Tag</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw003_tagList" data-placeholder="--- SELECT TAG ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
                        <div id="segment03_mw003_col2_part3" style="display:none;">
		                	<label>Exclude These Items</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw003_excludeItemList" data-placeholder="--- SELECT ITEM ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
                        <div id="segment03_mw003_col2_part4" style="display:none;">
		                	<label>Default Selected Items</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw003_defaultItemList" data-placeholder="--- SELECT ITEM ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
            		</div>
            		<div class="col-lg-4">
            			<div id="segment03_mw003_col3_part1" style="display:none;">
		                	<label>You've selected following item list:</label> 
		                	<br/>
			                <div class="form-group">
				                <div class="input-group" style="width:100%;">
                                    <select id="segment03_mw003_selected_items" class="form-control" multiple style="height:480px;">
                                    </select>
                                </div>
                            </div>
                        </div>
            		</div>
            	</div>	                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment03_mw003_onclick_saveComponent();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Update</button>
            </div>
        </div>
    </div>
</div>


<script>

var segment03_mw003_initialized = false;
var segment03_mw003_selectedItemList = [];
var segment03_mw003_selectedTagList = []
var segment03_mw003_selectedExcludeItemList = [];
var segment03_mw003_selectedDefaultItemList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw003_isOpen()
{
	return ($("#segment03_mw003").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw003_isOpen

/**
 * Init state of modal window
 */
function segment03_mw003_init()
{
	if (segment03_mw003_initialized)
		return false;
	
	$(".chosen-select").chosen({
		width: "100%"
	});
	
	$("#segment03_mw003_selectable").val("0");
	$("#segment03_mw003_selectionMode").val("0");
	
	$('#segment03_mw003_itemList').on('change', function(evt, params) {
       	segment03_mw003_onItemChanged($("#segment03_mw003_itemList").val(), params.selected, params.deselected);
    });
	
	$('#segment03_mw003_tagList').on('change', function(evt, params) {	
        segment03_mw003_onTagChanged($("#segment03_mw003_tagList").val(), params.selected, params.deselected);
    });
	
	$('#segment03_mw003_excludeItemList').on('change', function(evt, params) {	
        segment03_mw003_onExcludeItemChanged($("#segment03_mw003_excludeItemList").val(), params.selected, params.deselected);
    });

	$('#segment03_mw003_defaultItemList').on('change', function(evt, params) {	
        segment03_mw003_onDefaultItemChanged($("#segment03_mw003_defaultItemList").val(), params.selected, params.deselected);
    });
	
	$("#segment03_mw003_selectionMode").on('change', function() {
 	  	var currentCategoryId = $("#segment03_mw003_selectionMode").val();
 	  	segment03_mw003_selectionModeChanged(currentCategoryId);
 	});
    
 	// EVENT LISTENER: Component mandatory selection changed.
     $( "#segment03_mw003_selectable" ).on('change', function() {
 	  	var isSelectable = $( "#segment03_mw003_selectable" ).val();
 	  	
 	  	if ("true"== $.trim(isSelectable) )
 	  	{
 	  		$("#segment03_mw003_col1_part2").show();
 	  	}
 	  	else
 	  	{
 	  		$("#segment03_mw003_col1_part2").hide();
 	  		$("#segment03_mw003_allowDefaultQuantityOnly").iCheck('check');
 	  	}	 		  		
 	});
	
     segment03_mw003_initialized = true;
} // .end of segment03_mw003_init

function segment03_mw003_showSpinner()
{
	$('#segment03_mw003_spinner').show();
	$('#segment03_mw003_col2_part1').hide();
	$('#segment03_mw003_col2_part2').hide();
	$('#segment03_mw003_col2_part3').hide();
	$('#segment03_mw003_col2_part4').hide();
	$('#segment03_mw003_col3_part1').hide();
} // .end of segment03_mw002_showSpinner

function segment03_mw003_hideSpinner()
{
	$('#segment03_mw003_spinner').hide();
	$('#segment03_mw003_col2_part1').show();
	$('#segment03_mw003_col2_part2').show();
	$('#segment03_mw003_col2_part3').show();
	$('#segment03_mw003_col2_part4').show();
	$('#segment03_mw003_col3_part1').show();
} // .end of segment03_mw002_hideSpinner

/**
 * Open modal window
 */
function segment03_mw003_open(componentId)
{
	tycheesOverlay_startShortProgress('loading...');
	
	segment03_mw003_init();
	
	// Show Spinner
	segment03_mw003_showSpinner();

	var params = new Object();
	params.componentId = componentId;
	
	$.each(segment03_itemObj.componentList, function(i, componentObj){    	
    	if ($.trim(componentId)==$.trim(componentObj.id))
    	{
    		params.componentObj = componentObj;
    	}
	});
	
	var filterByGroupName = true;
	if ($.trim(params.componentObj.itemGroupName)=='')
		filterByGroupName = false;
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': params.componentObj.categoryId,
		'filterByGroupName': filterByGroupName,
		'groupName': params.componentObj.itemGroupName,
		'fullBean': false,
		'viewBean': false
	};

	// Ajax Call
	tycheesdb_api_getItemsByCategory(requestBody, segment03_mw003_open_postHander, params);
} // .end of segment03_mw003_open

function segment03_mw003_open_postHander(successFlag, responseObj, params)
{
	// Hide Spinner
	segment03_mw003_hideSpinner();

	if (successFlag==false) {
		tycheesOverlay_stopShortProgress();
		return false;
	}

	// Set item list
	Cached_setItemList(responseObj.itemList);
	// Set component object
	var componentObj = params.componentObj;

	// Init variables
	segment03_mw003_selectedItemList = $.trim(componentObj.itemIds)=='' ? [] : componentObj.itemIds.split(',');
	segment03_mw003_selectedTagList = $.trim(componentObj.tags)=='' ? [] : componentObj.tags.split(',');
	segment03_mw003_selectedExcludeItemList = $.trim(componentObj.excludeItemIds)=='' ? [] : componentObj.excludeItemIds.split(',');
	segment03_mw003_selectedDefaultItemList = $.trim(componentObj.defaultItemIds)=='' ? [] : componentObj.defaultItemIds.split(',');

	// Show/Hide panels
	$("#segment03_mw003_col1_part0").show();
	$("#segment03_mw003_col1_part1").show();
	$("#segment03_mw003_col2_part1").show();
	
	// Load category into Select
	$("#segment03_mw003_category").empty();
	$("#segment03_mw003_category").append('<option value="0">-- SELECT --</option>');
	$.each(Cached_getCategoryList(), function(j, categoryObj){
		// Get currently selected Item ID
		if (segment03_itemObj.categoryId == categoryObj.id && categoryObj.itemSize == 1)
		{
			// Do not disply the category, if:
			// - current category is selected item's category, and
			// - current category has only one item (which is current item).
			return true;
		}
		
		if (categoryObj.itemSize > 0)
		{
			$("#segment03_mw003_category").append('<option value="' + categoryObj.id + '">' + categoryObj.name + '</option>');
		}
	});

	// COLUMN #1
	// Set values
	$("#segment03_mw003_componentId").val(componentObj.id);
	$("#segment03_mw003_categoryId").val(componentObj.categoryId);
	$("#segment03_mw003_category").val(componentObj.categoryId);
	$('#segment03_mw003_itemGroupName').val(componentObj.itemGroupName);
	$("#segment03_mw003_helpText").val(componentObj.helpText);
	$("#segment03_mw003_selectable").val(componentObj.selectable==true ? "true" : "false");			
	$("#segment03_mw003_selectionMode").val(componentObj.selectionMode);
	$("#segment03_mw003_minimumSelection").prop('disabled', componentObj.selectionMode=='single');
	$("#segment03_mw003_maximumSelection").prop('disabled', componentObj.selectionMode=='single');
	$("#segment03_mw003_minimumSelection").val(componentObj.minimumSelection);
	$("#segment03_mw003_maximumSelection").val(componentObj.maximumSelection);
	$("#segment03_mw003_defaultQuantity").val(componentObj.defaultQuantity);
	
	// Hide/Show panels
	if (componentObj.categoryId=='0')
	{
		$("#segment03_mw003_col1_part0").hide();
		$("#segment03_mw003_col1_part1").hide();
		$("#segment03_mw003_col1_part2").hide();
		$("#segment03_mw003_col2_part1").hide();
		$("#segment03_mw003_col2_part2").hide();
		$("#segment03_mw003_col2_part3").hide();
		$("#segment03_mw003_col2_part4").hide();
		$("#segment03_mw003_col3_part1").hide();
	}
	else
	{
		$("#segment03_mw003_col1_part0").show();
		$("#segment03_mw003_col1_part1").show();
		$("#segment03_mw003_col2_part1").show();
		$("#segment03_mw003_col2_part2").show();
		$("#segment03_mw003_col2_part3").show();
		$("#segment03_mw003_col2_part4").show();
		$("#segment03_mw003_col3_part1").show();		
	}
	
	if (componentObj.allowDefaultQuantityOnly==true)
	{
		$('#segment03_mw003_allowDefaultQuantityOnly').iCheck('check');
	}
	else
	{
		$('#segment03_mw003_allowDefaultQuantityOnly').iCheck('uncheck');
	}
	
	// If component is OPTIONAL, show COL-01-PART-02
	if (componentObj.selectable == true)
	{
		$("#segment03_mw003_col1_part2").show();
	}
	else
	{
		$("#segment03_mw003_col1_part2").hide();				
	}	
		
	// COLUMN #2
	// Step 1: 
	// a. Get item(s) that belong to this component
	// b. extract label(s) from each item, and insert into array list.
	var tagList = [], 
	    uniqueTagList = [], 
	    selectedTagList = [];
	
	$.each(responseObj.itemList, function(i, itemObj){
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
	$("#segment03_mw003_tagList").empty();
	$('#segment03_mw003_tagList').trigger('chosen:updated');
	
	$.each(uniqueTagList, function(index, tag) {
		if ( $.trim(tag).length != 0)
		{
			if (componentObj.tags.indexOf(tag) == -1)
			{
				$("#segment03_mw003_tagList").append('<option value="' + tag + '">' + tag + '</option>');
			}
			else
			{
				$("#segment03_mw003_tagList").append('<option value="' + tag + '" selected>' + tag + '</option>');
				selectedTagList.push(tag);
			}
		}
	});

	$('#segment03_mw003_tagList').trigger('chosen:updated');
    // .end of add tag
	
	// COLUMN #3
	// add items in given category to selection panel
	$("#segment03_mw003_itemList").empty();
	$('#segment03_mw003_itemList').trigger('chosen:updated');

	$.each(Cached_getCategoryList(), function(i, categoryObj){
		if (componentObj.categoryId==categoryObj.id)
		{	
			// 1. iterate thru items in the category
			// 2. Add to list if:
			//    - the item is not the component item, and
			//    - the item has label name same as the selected tag name(s)
			$.each(responseObj.itemList, function(j, itemObj){

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
				if ($.inArray(itemObj.id, segment03_mw003_selectedExcludeItemList) >= 0)
					addToList = false;
				
				if (addToList==true)
				{
					var selectedVal = 'selected';
					if($.inArray(itemObj.id, segment03_mw003_selectedItemList) == -1) 
						selectedVal = '';
					
		  	    	var htmlLines = '';
			    	htmlLines += '<option value="' + itemObj.id + '" ' + selectedVal + '>';
			    	htmlLines += itemObj.name;
			    	htmlLines += '</option>';
		  	    	
		  	    	$("#segment03_mw003_itemList").append(htmlLines);				  	    	
				}
			});			
		}
	});
	$('#segment03_mw003_itemList').trigger('chosen:updated');
				
	// Col 2, Part 3 - Exclude Item List
	segment03_mw003_onExcludeItemChanged(segment03_mw003_selectedExcludeItemList, null, null);

	// Col 2, Part 4 - Default Item List
	segment03_mw003_onDefaultItemChanged(segment03_mw003_selectedDefaultItemList, null, null);
	
	// Col 3, Part 1 - Remove Selected items if tags hav cover it. 
	$.each(segment03_mw003_selectedTagList, function(i, tag){
		// Filter out items which appear in col-3 'Individual Item Selection'
		$("#segment03_mw003_itemList").children('option').each(function(i) { 
			var itemId = $(this).val();
			var itemObj = Cached_getItemById(itemId);			
			if ($.trim(itemObj.labels).indexOf( $.trim(tag) ) != -1)
			{
				this.remove();
			}
		});
	});
	
	segment03_mw003_updateUI_selectedItemList();

	tycheesOverlay_stopShortProgress();
	
	// Show modal window
	module_showModalWindow('segment03_mw003', true);
} // .end of segment03_mw003_open


/**
 * Listen to change of SELECT 'Selection Mode'.
 *
 * Change Logs
 * -----------
 * 20160920	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function segment03_mw003_selectionModeChanged(mode)
{
	if (mode=='single')
	{
		$("#segment03_mw003_minimumSelection").prop('disabled', true);
		$("#segment03_mw003_minimumSelection").val('1');

		$("#segment03_mw003_maximumSelection").prop('disabled', true);
		$("#segment03_mw003_maximumSelection").val('1');
	}
	else
	if (mode=='multiple')
	{
		$("#segment03_mw003_minimumSelection").prop('disabled', false);
		$("#segment03_mw003_maximumSelection").prop('disabled', false);
	}
} // .end of segment03_mw003_selectionModeChanged

/**
 * Event listener: As user select/deselect item from chosen-select, this
 * function will add/remove item id into the list.
 * 
 * Change Logs
 * -----------
 * 20170216	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw003_onItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw003_selectedItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw003_selectedItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw003_selectedItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw003_updateUI_selectedItemList();
} // .end of segment03_mw003_onItemChanged

/**
 * Event listener: As user select/deselect tag from chosen-select, this
 * function will add/remove tag into tag list.
 * 
 * Change Logs
 * -----------
 * 20170216	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 * @params	{Array}		tagList - List of Tag
 * @params	{String}	selectedTag - Selected tag
 * @params	{String}	deselectedTag - Deselected tag
 */
function segment03_mw003_onTagChanged(tagList, selectedTag, deselectedTag)
{
	if ( $.trim(selectedTag).length != 0 )
	{
		segment03_mw003_selectedTagList.push( selectedTag );
	
		// Filter out items which appear in col-3 'Individual Item Selection'
		$("#segment03_mw003_itemList").children('option').each(function(i) { 
			var itemId = $(this).val();
			var itemObj = Cached_getItemById(itemId);			
			if ($.trim(itemObj.labels).indexOf( $.trim(selectedTag) ) != -1)
			{
				this.remove();
			}
		});
	}
	
	if ( $.trim(deselectedTag).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw003_selectedTagList, function(i, tagVal){
			if (tagVal == deselectedTag) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw003_selectedTagList.splice(selectedIndex, 1);
		
		var categoryId = $("#segment03_mw003_categoryId").val();
		// add items in given category to selection panel
		$.each(Cached_getCategoryList(), function(index, categoryObj){
			if (categoryId==categoryObj.id)
			{
				var itemList = Cached_getItemListByCategoryId(categoryObj.id);
				$.each(itemList, function(index, itemObj){
					
					if (segment03_itemObj.id != itemObj.id)
					{
						if ($.trim(itemObj.labels).indexOf(deselectedTag) != -1)
						{							
				  	    	var htmlLines = '';
					    	htmlLines += '<option value="' + itemObj.id + '">';
					    	htmlLines += itemObj.name;
					    	htmlLines += '</option>';
				  	    	
				  	    	$("#segment03_mw003_itemList").append(htmlLines);
						}
					}
				});	
				$('#segment03_mw003_itemList').trigger('chosen:updated');
			}
		});
	}
	
	// Update UI - selected items
	segment03_mw003_updateUI_selectedItemList();
} // .end of segment03_mw003_onTagChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into exclude list.
 * 
 * Change Logs
 * -----------
 * 20170216	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw003_onExcludeItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw003_selectedExcludeItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw003_selectedExcludeItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw003_selectedExcludeItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw003_updateUI_selectedItemList();
} // .end of segment03_mw003_onExcludeItemChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into default list.
 * 
 * Change Logs
 * -----------
 * 20170216	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw003_onDefaultItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw003_selectedDefaultItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw003_selectedDefaultItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw003_selectedDefaultItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw003_updateUI_selectedItemList();
} // .end of segment03_mw003_onExcludeItemChanged

/**
 * Update UI, after user select/deselect items/tags from middle column chosen-select 
 * components (Select Items, Select Tags & Select Excluded Items). 
 * 
 * Change Logs
 * -----------
 * 20170216	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 *
 */
function segment03_mw003_updateUI_selectedItemList()
{
	// #1. Check repeated item between selected items and tags.
	var removedItemIdList = [];
	$.each(segment03_mw003_selectedItemList, function(i, itemId){
		$.each(segment03_mw003_selectedTagList, function(j, tagVal){		
			var itemObj = Cached_getItemById(itemId);			
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
			{
				removedItemIdList.push( itemId );
			}
		});
	});
	
	$.each(removedItemIdList, function(i, itemId){ 
		segment03_mw003_selectedItemList.splice(i, 1);
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
	$.each(segment03_mw003_selectedItemList, function(i, itemId){
		itemList.push(itemId);
	});
	
	// extract item id from tag (chosen-select)
	$.each(Cached_getItemList(), function(i, itemObj){
		$.each(segment03_mw003_selectedTagList, function(j, tagVal){
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
				itemList.push( itemObj.id );
		});
	});
	
	// #3. Compile unique list
	$.each(itemList, function(i, itemId){
	    if($.inArray(itemId, selectedItemIdList) == -1 &&
	       $.inArray(itemId, segment03_mw003_selectedExcludeItemList) == -1) 
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
    	var itemObj = Cached_getItemById( itemId );
    	if (itemObj != null)
    		selectedItemList.push( itemObj );
	});
	$.each(excludeItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId );
    	if (itemObj != null)
    		excludeItemList.push( itemObj );
	});
	$.each(defaultItemIdList, function(i, itemId){	    
    	var itemObj = Cached_getItemById( itemId );
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
	$("#segment03_mw003_selected_items").empty();	
	$.each(selectedItemList, function(i, itemObj){		
		$("#segment03_mw003_selected_items").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	
	// #4.2 Append list to excluded items
	$("#segment03_mw003_excludeItemList").empty();	
	$.each(excludeItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw003_selectedExcludeItemList) >= 0)
			$("#segment03_mw003_excludeItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw003_excludeItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw003_excludeItemList').trigger('chosen:updated');
	
	// #4.3 Append list to default items
	$("#segment03_mw003_defaultItemList").empty();	
	$.each(defaultItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw003_selectedDefaultItemList) >= 0)
			$("#segment03_mw003_defaultItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw003_defaultItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw003_defaultItemList').trigger('chosen:updated');
} // .end of segment03_mw003_updateUI_selectedItemList

/**
 * Save component into cache
 *
 * Change Logs
 * -----------
 * 20160920	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function segment03_mw003_onclick_saveComponent()
{
	// Input Validation
	var isSelectableOption = $("#segment03_mw003_selectable").val();
	var selectionMode = $("#segment03_mw003_selectionMode").val();
	var minimumSelectionVal = $("#segment03_mw003_minimumSelection").val();
	var maximumSelectionVal = $("#segment03_mw003_maximumSelection").val();

	// Reset/Hide error messages
	$("#segment03_mw003_errorMessage").hide();
	$("#segment03_mw003_errorMessage").html('');
	
	// START Validation
	if (isSelectableOption=='0')
    {
		$("#segment03_mw003_errorMessage").show();
    	$("#segment03_mw003_errorMessage").html("Please choose 'If this component selectable?'.");
		return false;
    }
	if (isSelectableOption=='true' && selectionMode=='0')
    {
		$("#segment03_mw003_errorMessage").show();
    	$("#segment03_mw003_errorMessage").html("Please choose 'Selection Mode'.");
		return false;
    }
	if (isNaN(minimumSelectionVal))
    {
		$("#segment03_mw003_errorMessage").show();
    	$("#segment03_mw003_errorMessage").html("Invalid Minimum Selection. It must be a Integer value.");
		return false;
    }
    if (isNaN(maximumSelectionVal))
    {
		$("#segment03_mw003_errorMessage").show();
    	$("#segment03_mw003_errorMessage").html("Invalid Maximum Selection. It must be a Integer value.");
		return false;
    }    
    // .end of Input Validation
    
    // Prepare variables
	var componentId = $("#segment03_mw003_componentId").val();
	var categoryId = $("#segment03_mw003_categoryId").val();
	
	$.each(segment03_itemObj.componentList, function(index, componentObj){
		if (componentObj.id==componentId)
		{
			var itemIdList = [];
			$("#segment03_mw003_itemList").children('option').each(function(i) 
			{ 
				var itemId = $(this).val();
				var itemCheck = $(this).is(":selected");				
				if (itemCheck==true)
				{
					itemIdList.push( $.trim(itemId) );
				}
			});

			var tagsList = $("#segment03_mw003_tagList").val();
			if (tagsList==null)
				tagsList = [];
			var tagsVal = tagsList.toString();	

			var selectableVal = false;
			if ($("#segment03_mw003_selectable").val() == 'true')
				selectableVal = true;
				
			var selectionModeVal = $("#segment03_mw003_selectionMode").val();
			if (selectionModeVal == '')
				selectionModeVal = 'multiple';
			
			var defaultQuantityVal = $.trim( $("#segment03_mw003_defaultQuantity").val() );
			if (defaultQuantityVal=='')
				defaultQuantityVal = 0;
			
			var allowDefaultQuantityOnlyVal = $("#segment03_mw003_allowDefaultQuantityOnly").is(":checked");
			
			// Update values into existing JSON object
			componentObj.title = $.trim( $("#segment03_mw003_category option:selected").html() );
			componentObj.helpText = $.trim( $("#segment03_mw003_helpText").val() );
			componentObj.selectable = selectableVal;
			componentObj.selectionMode = selectionModeVal;
			componentObj.minimumSelection = minimumSelectionVal;
			componentObj.maximumSelection = maximumSelectionVal;
			componentObj.defaultQuantity = defaultQuantityVal;
			componentObj.allowDefaultQuantityOnly = allowDefaultQuantityOnlyVal;
			componentObj.tags = tagsVal;
			componentObj.itemIds = itemIdList.toString();
			componentObj.excludeItemIds = segment03_mw003_selectedExcludeItemList.toString();
			componentObj.defaultItemIds = segment03_mw003_selectedDefaultItemList.toString();
			componentObj.hasChanged = true;
			
		    // Save inventory item
		    tycheesIO_saveBean(segment03_itemObj);
		}
	});
	
    // Immediate Sync
    //module_sync();
	// Hide Modal Window
	$('#segment03_mw003').modal('hide');
    // Update UI
    segment03_updateUI_tab3( segment03_itemObj );
	//segment03_updateUI_components( $('#segment03_itemId').val() );
} // .end of segment03_mw003_onclick_saveComponent


</script>