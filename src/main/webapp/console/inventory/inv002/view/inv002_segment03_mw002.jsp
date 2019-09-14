<!-- MODAL WINDOW: New Component -->
<div class="modal inmodal" id="segment03_mw002" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">NEW COMPONENT</span>
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
		                	<input id="segment03_mw002_categoryId" type="hidden" placeholder="" class="form-control">
            				<label>Select Category (POS > Title)</label> 
	                		<select id="segment03_mw002_category" class="form-control">
							</select>
							
							<div id="segment03_mw002_col1_part0" style="display:none;">
			                	<label>Select Item Group</label> 
		                		<select id="segment03_mw002_itemGroupList" class="form-control" onchange="segment03_mw002_componentChanged();">
								</select>
								<br/>
							</div>
							<div id="segment03_mw002_col1_part1" style="display:none;padding-top:10px;">
			                	<label>Help Text (POS > Instruction Sentence)</label> 
			                	<input id="segment03_mw002_helpText" type="text" placeholder="" class="form-control">
			                	<label>Is this component selectable?</label> 
		                		<select id="segment03_mw002_selectable" class="form-control">
		                			<option value="0" selected>-- SELECT --</option>
		                			<option value="true">Yes</option>
		                			<option value="false">No</option>
								</select>
			                	<label>Default Quantity (Show when first selected in POS)</label> 
			                	<input id="segment03_mw002_defaultQuantity" type="number" placeholder="" class="form-control">
								<br/><br/>
							</div>
							<div id="segment03_mw002_col1_part2" style="display:none;">
			                	<label>
			                		<input type="checkbox" class="i-checks" id="segment03_mw002_allowDefaultQuantityOnly" data-toggle="tooltip" data-placement="left" title=""> 
			                		<i></i> Allow Default Quantity Only 
			                	</label> 
								<br/><br/>
			                	<label>Selection Mode</label> 
		                		<select id="segment03_mw002_selectionMode" class="form-control">
		                			<option value="0">-- SELECT --</option>
		                			<option value="single">Single Selection</option>
		                			<option value="multiple">Multiple Selection</option>
								</select>
			                	<label>Minimum Selection</label> 
			                	<input id="segment03_mw002_minimumSelection" type="number" placeholder="" class="form-control">
			                	<label>Maximum Selection</label> 
			                	<input id="segment03_mw002_maximumSelection" type="number" placeholder="" class="form-control">
			                </div>
		                </div>
            		</div>
            		<div class="col-lg-4">
            		    <div id="segment03_mw002_spinner" class="spiner-example" style="display:none; padding:0px; height:28px;">
							<div class="sk-spinner sk-spinner-three-bounce">
                                <div class="sk-bounce1"></div>
                                <div class="sk-bounce2"></div>
                                <div class="sk-bounce3"></div>
                            </div>
						</div>
            			<div id="segment03_mw002_col2_part1" style="display:none;">
            				<label>Select Individual Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw002_itemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
            			</div>
            			<div id="segment03_mw002_col2_part2" style="display:none;">
		                	<label>Select Items by Tag</label> 
		                	<br/>
	            			<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw002_tagList" data-placeholder="--- SELECT TAG ---" class="chosen-select" multiple tabindex="5" style="width:100%;">
					                </select>
				                </div>
			                </div>
                        </div>
                        <div id="segment03_mw002_col2_part3" style="display:none;">
            				<label>Exclude These Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw002_excludeItemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
            			</div>
            			<div id="segment03_mw002_col2_part4" style="display:none;">
            				<label>Default Selected Items</label> 
		                	<br/>
            				<div class="form-group">
				                <div class="input-group" style="width:100%;">
					                <select id="segment03_mw002_defaultItemList" data-placeholder="--- SELECT ITEM ---" multiple class="chosen-select" tabindex="2" style="width:100%;">
					                </select>
				                </div>
				            </div>
            			</div>
            		</div>
            		<div class="col-lg-4">
            			<div id="segment03_mw002_col3_part1" style="display:none;">
		                	<label>You've selected following item list:</label> 
		                	<br/>
			                <div class="form-group">
				                <div class="input-group" style="width:100%;">
                                    <select id="segment03_mw002_selected_items" class="form-control" multiple style="height:480px;">
                                    </select>
                                </div>
                            </div>
                        </div>
            		</div>
            	</div>	                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment03_mw002_onclick_saveComponent();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Create</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment03_mw002_initialized = false;
var segment03_mw002_selectedItemList = [];
var segment03_mw002_selectedTagList = []
var segment03_mw002_selectedExcludeItemList = [];
var segment03_mw002_selectedDefaultItemList = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 *
 * Change Logs
 * -----------
 * 20170110 Ryan Chee   Init
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function segment03_mw002_isOpen()
{
	return ($("#segment03_mw002").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw002_isOpen

function segment03_mw002_showSpinner()
{
	$('#segment03_mw002_spinner').show();
	$('#segment03_mw002_col2_part1').hide();
	$('#segment03_mw002_col2_part2').hide();
	$('#segment03_mw002_col2_part3').hide();
	$('#segment03_mw002_col2_part4').hide();
	$('#segment03_mw002_col3_part1').hide();
} // .end of segment03_mw002_showSpinner

function segment03_mw002_hideSpinner()
{
	$('#segment03_mw002_spinner').hide();
	$('#segment03_mw002_col2_part1').show();
	$('#segment03_mw002_col2_part2').show();
	$('#segment03_mw002_col2_part3').show();
	$('#segment03_mw002_col2_part4').show();
	$('#segment03_mw002_col3_part1').show();
} // .end of segment03_mw002_hideSpinner

/**
 * Init state of modal window
 *
 * Change Logs
 * -----------
 * 20160920	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function segment03_mw002_init()
{
	if (segment03_mw002_initialized)
		return false;
	
	$(".chosen-select").chosen({
		width: "100%"
	});
	
    $("#segment03_mw002_selectable").val("0");
	$("#segment03_mw002_selectionMode").val("0");
	
	$('#segment03_mw002_itemList').on('change', function(evt, params) {
       	segment03_mw002_onItemChanged($("#segment03_mw002_itemList").val(), params.selected, params.deselected);
    });
	
	$('#segment03_mw002_tagList').on('change', function(evt, params) {
       	segment03_mw002_onTagChanged($("#segment03_mw002_tagList").val(), params.selected, params.deselected);
    });
    
	$('#segment03_mw002_excludeItemList').on('change', function(evt, params) {
       	segment03_mw002_onExcludeItemChanged($("#segment03_mw002_excludeItemList").val(), params.selected, params.deselected);
    });

	$('#segment03_mw002_defaultItemList').on('change', function(evt, params) {
       	segment03_mw002_onDefaultItemChanged($("#segment03_mw002_defaultItemList").val(), params.selected, params.deselected);
    });
	
    $("#segment03_mw002_selectionMode").on('change', function() {
 	  	var currentCategoryId = $("#segment03_mw002_selectionMode").val();
 	  	segment03_mw002_selectionModeChanged(currentCategoryId);
 	});
 	
 	// EVENT LISTENER: Component name selection changed
    $( "#segment03_mw002_category" ).on('change', function() {
    	segment03_mw002_categoryChanged();
 	});
 	
 	// EVENT LISTENER: Component mandatory selection changed.
     $( "#segment03_mw002_selectable" ).on('change', function() {
 	  	var isSelectable = $( "#segment03_mw002_selectable" ).val();
 	  	
 	  	if ("true"==$.trim(isSelectable))
 	  	{
 	  		$("#segment03_mw002_col1_part2").show();
 	  	}
 	  	else
 	  	{
 	  		$("#segment03_mw002_col1_part2").hide();
 	  		$("#segment03_mw002_allowDefaultQuantityOnly").iCheck('check');
 	  	}	 		  		
 	});
    
    segment03_mw002_initialized = true;
} // .end of segment03_mw002_init

/**
 * Open modal window.
 */
function segment03_mw002_open(isMandatory)
{
	segment03_mw002_init();
	
	// Hide Panels
	$("#segment03_mw002_col1_part0").hide();
	$("#segment03_mw002_col1_part1").hide();
	$("#segment03_mw002_col1_part2").hide();
	$("#segment03_mw002_col2_part1").hide();
	$("#segment03_mw002_col2_part2").hide();
	$("#segment03_mw002_col2_part3").hide();
	$("#segment03_mw002_col2_part4").hide();
	$("#segment03_mw002_col3_part1").hide();
	
	// Reset
	$("#segment03_mw002_selectable").val('0');
	$("#segment03_mw002_selectionMode").val("0");
	$("#segment03_mw002_helpText").val("");
	$("#segment03_mw002_minimumSelection").val("");
	$("#segment03_mw002_maximumSelection").val("");
	
	// Load category into Select
	$("#segment03_mw002_category").empty();
	$("#segment03_mw002_category").append('<option value="0">-- SELECT --</option>');
	
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
			$("#segment03_mw002_category").append('<option value="' + categoryObj.id + '">' + categoryObj.name + '</option>');
		}
	});

	$("#segment03_mw002_itemList").empty();
	$('#segment03_mw002_itemList').trigger('chosen:updated');
	
	$("#segment03_mw002_tagList").empty();
	$('#segment03_mw002_tagList').trigger('chosen:updated');

	$("#segment03_mw002_excludeItemList").empty();
	$('#segment03_mw002_excludeItemList').trigger('chosen:updated');

	$("#segment03_mw002_defaultItemList").empty();
	$('#segment03_mw002_defaultItemList').trigger('chosen:updated');
	
	$("#segment03_mw002_selected_items").empty();

	// Show Modal Window
	module_showModalWindow('segment03_mw002', true);
} // .end of segment03_mw002_open

/**
 * When SELECT 'Selection Mode' change value. 
 */
function segment03_mw002_selectionModeChanged(mode)
{
	if (mode=='single')
	{
		$("#segment03_mw002_minimumSelection").prop('disabled', true);
		$("#segment03_mw002_minimumSelection").val('1');

		$("#segment03_mw002_maximumSelection").prop('disabled', true);
		$("#segment03_mw002_maximumSelection").val('1');
	}
	else
	if (mode=='multiple')
	{
		$("#segment03_mw002_minimumSelection").prop('disabled', false);
		$("#segment03_mw002_maximumSelection").prop('disabled', false);
	}
} // .end of segment03_mw002_selectionModeChanged


function segment03_mw002_categoryChanged()
{
	var categoryId = $("#segment03_mw002_category").val();
	
	if (categoryId == '0')
	{
		$("#segment03_mw002_col1_part0").hide();
		$("#segment03_mw002_col1_part1").hide();
		$("#segment03_mw002_col1_part2").hide();
		$("#segment03_mw002_col2_part1").hide();
		$("#segment03_mw002_col2_part2").hide();
		$("#segment03_mw002_col2_part3").hide();
		$("#segment03_mw002_col2_part4").hide();
		$("#segment03_mw002_col3_part1").hide();
		
		return false;
	}
	else
	{
		$("#segment03_mw002_col1_part1").hide();
		$("#segment03_mw002_col1_part2").hide();
		$("#segment03_mw002_col2_part1").hide();
		$("#segment03_mw002_col2_part2").hide();
		$("#segment03_mw002_col2_part3").hide();
		$("#segment03_mw002_col2_part4").hide();
		$("#segment03_mw002_col3_part1").hide();
	}
	
	$('#segment03_mw002_itemGroupList').empty();
	$('#segment03_mw002_itemGroupList').append( '<option value="">-- NO GROUP --</option>' );
	
	var categoryObj = Cached_getCategoryById( categoryId );
	// Sort by itemGroupName
	categoryObj.itemGroupList.sort(function(a, b){
		if(a < b) return -1;
    	if(a > b) return 1;
    	return 0;
	});
	
	$.each(categoryObj.itemGroupList, function(i, itemGroupName) {
		var htmlLines = '';
    	htmlLines += '<option value="' + itemGroupName + '">';
    	htmlLines += itemGroupName;
    	htmlLines += '</option>';
		
		$('#segment03_mw002_itemGroupList').append( htmlLines );
	});	
	
	$('#segment03_mw002_col1_part0').show();
} // .end of segment03_mw002_categoryChanged

/**
 * Listen to selection changed on Component name
 */
function segment03_mw002_componentChanged()
{
	// Show Spinner
	segment03_mw002_showSpinner();

	var categoryId = $("#segment03_mw002_category").val();
	var itemGroupName = $("#segment03_mw002_itemGroupList").val();
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': categoryId,
		'filterByGroupName': true,
		'groupName': itemGroupName,
		'fullBean': false,
		'viewBean': true
	};

	var params = new Object();
	params.categoryId = categoryId;

	// Ajax Call
	tycheesdb_api_getItemsByCategory(requestBody, segment03_mw002_componentChanged_postHandler, params);
} // .end of segment03_mw002_componentChanged

function segment03_mw002_componentChanged_postHandler(successFlag, responseObj, params)
{
	// Hide Spinner
	segment03_mw002_hideSpinner();

	// If fail at ajax, then stop
	if (successFlag==false)
		return false;

	Cached_setItemList(responseObj.itemViewList);

	// Set categoryId into hidden field
	$("#segment03_mw002_categoryId").val(params.categoryId);

	// Reset
	segment03_mw002_selectedItemList = [];
	segment03_mw002_selectedTagList = []
	segment03_mw002_selectedExcludeItemList = [];
	segment03_mw002_selectedDefaultItemList = [];
	
	// empty item selection
	$("#segment03_mw002_itemList").empty();
	$("#segment03_mw002_tagList").empty();
	$("#segment03_mw002_excludeItemList").empty();
	$("#segment03_mw002_defaultItemList").empty();
	$("#segment03_mw002_selected_items").empty();
	
	// Hide/Show panels
	if (params.categoryId=='0')
	{
		$("#segment03_mw002_col1_part0").hide();
		$("#segment03_mw002_col1_part1").hide();
		$("#segment03_mw002_col1_part2").hide();
		$("#segment03_mw002_col2_part1").hide();
		$("#segment03_mw002_col2_part2").hide();
		$("#segment03_mw002_col2_part3").hide();
		$("#segment03_mw002_col2_part4").hide();
		$("#segment03_mw002_col3_part1").hide();
	}
	else
	{
		$("#segment03_mw002_col1_part0").show();
		$("#segment03_mw002_col1_part1").show();
		$("#segment03_mw002_col2_part1").show();
		$("#segment03_mw002_col2_part2").show();
		$("#segment03_mw002_col2_part3").show();
		$("#segment03_mw002_col2_part4").show();
		$("#segment03_mw002_col3_part1").show();
		
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
            $("#segment03_mw002_tagList").append('<option value="' + tag + '">' + tag + '</option>');
		});
		$('#segment03_mw002_tagList').trigger('chosen:updated');
        // .end of add tag
		
		// add items in given category to selection panel
		$.each(responseObj.itemViewList, function(i, itemObj){
			if (segment03_itemObj.id != itemObj.id)
			{
	  	    	var htmlLines = '';
		    	htmlLines += '<option value="' + itemObj.id + '">';
		    	htmlLines += itemObj.name;
		    	htmlLines += '</option>';
	  	    	
	  	    	$("#segment03_mw002_itemList").append(htmlLines);
			}
		});

		$('#segment03_mw002_itemList').trigger('chosen:updated');
	}
} // .end of segment03_mw002_componentChanged

/**
 * Event listener: As user select/deselect item from chosen-select, this
 * function will add/remove item id into the list.
 *
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw002_onItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw002_selectedItemList.push( selectedItem );
	
	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw002_selectedItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw002_selectedItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw002_updateUI_selectedItemList();
} // .end of segment03_mw002_onItemChanged

/**
 * Event listener: As user select/deselect tag from chosen-select, this
 * function will add/remove tag into tag list.
 * 
 * @params	{Array}		tagList - List of Tag
 * @params	{String}	selectedTag - Selected tag
 * @params	{String}	deselectedTag - Deselected tag
 */
function segment03_mw002_onTagChanged(tagList, selectedTag, deselectedTag)
{
	if ( $.trim(selectedTag).length != 0 )
	{
		segment03_mw002_selectedTagList.push( selectedTag );
		
		// Filter out items which appear in col-2 'Individual Item Selection'
		$("#segment03_mw002_itemList").children('option').each(function(i) { 
			var itemId = $(this).val();
			var itemObj = Cached_getItemById(itemId);			
			if ($.trim(itemObj.labels).indexOf( $.trim(selectedTag) ) != -1)
			{
				this.remove();
			}
		});
		
		$("#segment03_mw002_itemList").trigger("chosen:updated");
	}
	
	if ( $.trim(deselectedTag).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw002_selectedTagList, function(i, tagVal){
			if (tagVal == deselectedTag) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw002_selectedTagList.splice(selectedIndex, 1);
		
		var categoryId = $("#segment03_mw002_categoryId").val();
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
			    	
				  	    	$("#segment03_mw002_itemList").append(htmlLines);
						}
					}
				});	

				$('#segment03_mw002_itemList').trigger('chosen:updated');
			}
		});
	}
	
	// Update UI - selected items
	segment03_mw002_updateUI_selectedItemList();
} // .end of segment03_mw002_onTagChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into exclude list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw002_onExcludeItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw002_selectedExcludeItemList.push( selectedItem );

	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw002_selectedExcludeItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw002_selectedExcludeItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw002_updateUI_selectedItemList();
} // .end of segment03_mw002_onExcludeItemChanged

/**
 * Event listener: As user select/deselect exclude item from chosen-select, this
 * function will add/remove item id into default list.
 * 
 * @params	{Array}		itemList - List of Item ID
 * @params	{String}	selectedItem - Selected item ID
 * @params	{String}	deselectedItem - Deselected item ID
 */
function segment03_mw002_onDefaultItemChanged(itemList, selectedItem, deselectedItem)
{	
	if ( $.trim(selectedItem).length != 0 )
		segment03_mw002_selectedDefaultItemList.push( selectedItem );

	if ( $.trim(deselectedItem).length != 0 )
	{
		var selectedIndex = -1;
		$.each(segment03_mw002_selectedDefaultItemList, function(i, itemIdVal){
			if (itemIdVal == deselectedItem) 
			{
				selectedIndex = i;
				return false;
			}
		});
		
		if (selectedIndex != -1)
			segment03_mw002_selectedDefaultItemList.splice(selectedIndex, 1);
		
	}
	
	// Update UI - selected items
	segment03_mw002_updateUI_selectedItemList();
} // .end of segment03_mw002_onExcludeItemChanged

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
function segment03_mw002_updateUI_selectedItemList()
{
	// #1. Check repeated item between selected items and tags.
	var removedItemIdList = [];
	$.each(segment03_mw002_selectedItemList, function(i, itemId){
		$.each(segment03_mw002_selectedTagList, function(j, tagVal){		
			var itemObj = Cached_getItemById(itemId);			
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
			{
				removedItemIdList.push( itemId );
			}
		});
	});
	
	$.each(removedItemIdList, function(i, itemId){ 
		segment03_mw002_selectedItemList.splice(i, 1);
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
	$.each(segment03_mw002_selectedItemList, function(i, itemId){
		itemList.push(itemId);
	});
	
	// extract item id from tag (chosen-select)
	$.each(Cached_getItemList(), function(i, itemObj){
		$.each(segment03_mw002_selectedTagList, function(j, tagVal){
			if ($.trim(itemObj.labels).indexOf( $.trim(tagVal) ) != -1)
			{
				itemList.push( itemObj.id );
			}
		});
	});
	
	// #3. Compile unique list (and Not inside exclude list)
	$.each(itemList, function(i, itemId){
	    if($.inArray(itemId, selectedItemIdList) == -1 &&
	       $.inArray(itemId, segment03_mw002_selectedExcludeItemList) == -1) 
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
	$("#segment03_mw002_selected_items").empty();	
	$.each(selectedItemList, function(i, itemObj){		
		$("#segment03_mw002_selected_items").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	
	// #4.2 Append list to excluded items
	$("#segment03_mw002_excludeItemList").empty();	
	$.each(excludeItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw002_selectedExcludeItemList) >= 0)
			$("#segment03_mw002_excludeItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw002_excludeItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw002_excludeItemList').trigger('chosen:updated');
	
	// #4.3 Append list to default items
	$("#segment03_mw002_defaultItemList").empty();	
	$.each(defaultItemList, function(i, itemObj){	
		if ($.inArray(itemObj.id, segment03_mw002_selectedDefaultItemList) >= 0)
			$("#segment03_mw002_defaultItemList").append('<option value="' + itemObj.id + '" selected>' + itemObj.name + '</option>');
		else
			$("#segment03_mw002_defaultItemList").append('<option value="' + itemObj.id + '">' + itemObj.name + '</option>');
	});
	$('#segment03_mw002_defaultItemList').trigger('chosen:updated');
} // .end of segment03_mw002_updateUI_selectedItemList

/**
 * Save components into cache. 
 *
 * Change Logs
 * -----------
 * 20160920	Ryan Chee	Init
 *
 * @author	Ryan Chee
 * @version	1.0
 */
function segment03_mw002_onclick_saveComponent()
{
	// Input Validation
	var isSelectableOption = $("#segment03_mw002_selectable").val();
	var selectionMode = $("#segment03_mw002_selectionMode").val();
	var minimumSelectionVal = $("#segment03_mw002_minimumSelection").val();
	var maximumSelectionVal = $("#segment03_mw002_maximumSelection").val();

	// Reset/Hide error messages
	$("#segment03_mw002_errorMessage").hide();
	$("#segment03_mw002_errorMessage").html('');
	
	// START Validation
	if (isSelectableOption=='0')
    {
		$("#segment03_mw002_errorMessage").show();
    	$("#segment03_mw002_errorMessage").html("Please choose 'If this component selectable?'.");
		return false;
    }
	if (isSelectableOption=='true' && selectionMode=='0')
    {
		$("#segment03_mw002_errorMessage").show();
    	$("#segment03_mw002_errorMessage").html("Please choose 'Selection Mode'.");
		return false;
    }
	if (isNaN(minimumSelectionVal))
    {
		$("#segment03_mw002_errorMessage").show();
    	$("#segment03_mw002_errorMessage").html("Invalid Minimum Selection. It must be a Integer value.");
		return false;
    }
    if (isNaN(maximumSelectionVal))
    {
		$("#segment03_mw002_errorMessage").show();
    	$("#segment03_mw002_errorMessage").html("Invalid Maximum Selection. It must be a Integer value.");
		return false;
    }    
    // .end of Input Validation
    
    // Prepare variables
	var categoryId = $("#segment03_mw002_categoryId").val();
    
	$.each(Cached_getCategoryList(), function(index, categoryObj){
		if (categoryId==categoryObj.id)
		{
			var itemIdList = [];
			$("#segment03_mw002_itemList").children('option').each(function(i) 
			{ 
				var itemId = $(this).val();
				var itemCheck = $(this).is(":selected");
				
				if (itemCheck==true)
				{
					itemIdList.push( $.trim(itemId));
				}
			});
			
			var tagsList = $("#segment03_mw002_tagList").val();
			if (tagsList==null)
				tagsList = [];
			var tagsVal = tagsList.toString();	

			var selectableVal = false;
			if ($("#segment03_mw002_selectable").val() == 'true')
				selectableVal = true;
			
			var selectionModeVal = $("#segment03_mw002_selectionMode").val();
			if (selectionModeVal == '')
				selectionModeVal = 'multiple';
			
			var defaultQuantityVal = $.trim( $("#segment03_mw002_defaultQuantity").val() );
			if (defaultQuantityVal=='')
				defaultQuantityVal = 0;
			
			var allowDefaultQuantityOnlyVal = $("#segment03_mw002_allowDefaultQuantityOnly").is(":checked");
			
			// Init component JSON object
			var newComponentObj = createNew_InventoryItemComponent();
			newComponentObj.itemId = $('#segment03_itemId').val();
			newComponentObj.seqno = segment03_itemObj.componentList.length + 1;
			newComponentObj.categoryId = categoryObj.id;
			newComponentObj.itemGroupName = $('#segment03_mw002_itemGroupList').val();
			newComponentObj.title = categoryObj.name;
			newComponentObj.helpText = $.trim( $("#segment03_mw002_helpText").val() );
			newComponentObj.selectable = selectableVal;
			newComponentObj.selectionMode = selectionModeVal;
			newComponentObj.minimumSelection = Number(minimumSelectionVal).toFixed(0);
			newComponentObj.maximumSelection = Number(maximumSelectionVal).toFixed(0);
			newComponentObj.defaultQuantity = defaultQuantityVal;
			newComponentObj.allowDefaultQuantityOnly = allowDefaultQuantityOnlyVal;
			newComponentObj.tags = tagsVal;
			newComponentObj.itemIds = itemIdList.toString();
			newComponentObj.excludeItemIds = segment03_mw002_selectedExcludeItemList.toString();
			newComponentObj.defaultItemIds = segment03_mw002_selectedDefaultItemList.toString();
			
			// Push into list
			segment03_itemObj.componentList.push(newComponentObj);	
			
		    // Save inventory item
		    tycheesIO_saveBean(segment03_itemObj);
		}
	});
	
    // Immediate Sync
    //module_sync();
	// Hide Modal Window
	$('#segment03_mw002').modal('hide');
		
    // Update UI
	//segment03_updateUI_components( $('#segment03_itemId').val() );
    segment03_updateUI_tab3( segment03_itemObj );
} // .end of segment03_mw002_onclick_saveComponent

</script>