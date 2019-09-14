<style>
    .jstree-open > .jstree-anchor > .fa-folder:before {
        content: "\f07c";
    }

    .jstree-default .jstree-icon.none {
        width: 0;
    }
</style>

<div class="ibox" id="inv002_segment01">
    <div class="ibox-title" style="background-color:#404040;color:#ffffff;">
        <h5>Category Explorer</h5>
        <div class="ibox-tools">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="fa fa-wrench"></i>
            </a>
            <ul class="dropdown-menu dropdown-user" style="color:#000000;">
                <li>
                	<a href="#" onclick="segment01_onExpandAll_category();">Expand All</a>
                </li>
                <li>
                	<a href="#" onclick="segment01_onCollapseAll_category();">Collapse All</a>
                </li>
            </ul>
        </div>                          
    </div>
    <div class="ibox-content" style="padding:5px 5px;">
    	<div class="input-group">
            <input type="text" id="segment01_searchField" placeholder="Search category... " class="input input-sm form-control">
            <span class="input-group-btn">
                <button type="button" class="btn btn-sm btn-primary" onclick="segment01_resetSearch()"> <i class="fa fa-eraser" aria-hidden="true"></i> Reset</button>
            </span>
        </div>
        
		<div id="segment01_spinner" class="spiner-example">
			<div class="sk-spinner sk-spinner-wave">
			    <div class="sk-rect1"></div>
			    <div class="sk-rect2"></div>
			    <div class="sk-rect3"></div>
			    <div class="sk-rect4"></div>
			    <div class="sk-rect5"></div>
			</div>
		    <div id="segment01_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
		</div>
		
        <div id="segment01_jstree" style="display:none;"></div>
		<input type="file" id="segment01_batchFileUpload" style="display:none;">
		
    </div> 
</div><!-- .end of ibox -->


<!-- Modal Window: Add Category -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw001.jsp" %>
<!-- Modal Window: Edit Category -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw002.jsp" %>
<!-- Modal Window: Show Affected Categories & Items in tabular form -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw003.jsp" %>

<!-- Modal Window: Add Category Field -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw101.jsp" %>
<!-- Modal Window: Edit Category Field -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw102.jsp" %>
<!-- Modal Window: Delete Category Field -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw103.jsp" %>

<!-- Modal Window: Batch File Upload Validation -->
<%@include file="/console/inventory/inv002/view/inv002_segment01_mw201.jsp" %>

<script>

var segment01_initialized = false;
var segment01_categoryList = [];
var segment01_categoryId_inRequest;
var segment01_groupName_inRequest;
var segment01_systemResetFileUpload = false;

/**
 * Init function.
 */
function segment01_init()
{
	if (segment01_initialized)
		return false;
		
    // Init state here
    $('#segment01_searchField').keyup(function() {
    	segment01_filterCategoryList();    	
    });
    $('#segment01_batchFileUpload').on('change', function () {
    	if (segment01_systemResetFileUpload==false)
			segment01_validateBatchFile();
    	
    	segment01_systemResetFileUpload = false;
    }); 
    segment01_initialized = true;
} // .end of segment01_init

/**
 * Init jstree.
 */ 
function segment01_init_jstree()
{
    // Init jstree
	$('#segment01_jstree')
		// listen for event
	  	.on('changed.jstree', function (e, data) {
	  	
	  		var isTreeRootNode = $('#'+data.node.id).hasClass('tree-root-node');
	  		if (isTreeRootNode)
	  			return false;
	  	
	  		// Expand tree node
	  		$('#segment01_jstree').jstree().open_node( $('#'+data.node.id) );
	  	
	  		var isItemGroupNode = $('#'+data.node.id).hasClass('item-group-node');
	  		if (isItemGroupNode)
	  		{
	  			var categoryId	  = $.trim( $('#'+data.node.id+'_categoryId').html() );
	  			var itemGroupName = $.trim( $('#'+data.node.id+'_itemGroupName').html() );
	  			
	  			segment01_prePopulateItemList(categoryId, $.trim(itemGroupName));
	  		}
	  		else
	  		{
	  			var categoryId = data.node.id;
	  			var itemGroupName = null;
	  			
	  			segment01_prePopulateItemList(categoryId, $.trim(itemGroupName));
	  		}
	  	})
	  	// create the instance
		.jstree({
	        'plugins' : [ 'types', 'dnd', 'sort', 'contextmenu', 'search' ],
        	'core' : {
            	'check_callback' : true
        	},
	        'types' : {
	            'default' : {
	                'icon' : 'fa fa-folder'
	            },
	            'html' : {
	                'icon' : 'fa fa-file-code-o'
	            },
	            'svg' : {
	                'icon' : 'fa fa-file-picture-o'
	            },
	            'css' : {
	                'icon' : 'fa fa-file-code-o'
	            },
	            'img' : {
	                'icon' : 'fa fa-file-image-o'
	            },
	            'js' : {
	                'icon' : 'fa fa-file-text-o'
	            }
        	},
        	'contextmenu':{         
        	    'select_node': true,
    			'items': jstree_contextMenu
			},
			'search':{  
				 'fuzzy': true,
                 'case_insensitive': true,  
                 'show_only_matches': true,
                 'show_only_matches_children': true/*,
                 'ajax' : {
                     //'url' : 'jstree.xml' 
                	 //tycheesLogger_logInfo('123', 'jstree:ajax');
                 },
                 'search_callback': function(obj) {
                     tycheesLogger_logInfo('obj='+obj, 'jstree:search_callback');
                 }*/
             }, 
             'sort': jstree_sort
    	});
} // .end of segment01_init_jstree

function jstree_contextMenu(node) 
{
	var tree = $('#segment01_jstree').jstree(true);
    // The default set of all items
    var categoryNodeMenu = {
   		'CreateItem': {
	        'separator_before': false,
	        'separator_after': true,
	        'label': 'New Item',
	        'action': function (obj) { 	        
	            segment02_onAddItem(node.id);
	        }
		},
		'DownloadBatchFile': {
	        'separator_before': false,
	        'separator_after': false,
	        'label': 'Download Batch File',
	        'action': function (obj) { 	        
	            segment01_onDownloadBatchFile(node.id);
	        }
		},
		'CreateItems': {
	        'separator_before': false,
	        'separator_after': true,
	        'label': 'Upload Batch File',
	        'action': function (obj) { 	        
	            segment01_onUploadBatchFile(node.id);
	        }
		},
		'Create': {
            'separator_before': false,
            'separator_after': false,
            'label': 'New Category',
            'action': function (obj) { 
            
                segment01_onAddCategory(node.id, node);
                		
                //$node = tree.create_node($node);
                //tree.edit($node);
            }
		},
        'Rename': {
            'separator_before': false,
            'separator_after': false,
            'label': 'Edit',
            'action': function (obj) { 
                //tree.edit($node);
                segment01_onEditCategory(node.id, true);
            }
        },                         
        'Remove': {
            'separator_before': false,
            'separator_after': false,
            'label': 'Remove',
            'action': function (obj) { 
                //tree.delete_node($node);
                segment01_onDeleteCategory(node.id)
            }
        },
        /*'Refresh': {
            'separator_before': true,
            'separator_after': false,
            'label': 'Refresh',
            'action': function (obj) { 
                //tree.delete_node($node);
                segment01_onRefreshCategory(node.id);
            }
        },*/
        'Properties': {
            'separator_before': true,
            'separator_after': false,
            'label': 'Properties',
            'action': function (obj) { 
                //tree.delete_node($node);
                segment01_onEditCategory(node.id, false);
            }
        }
    };
    
    var groupNodeMenu = {
   		'CreateItem': {
	        'separator_before': false,
	        'separator_after': true,
	        'label': 'New Item',
	        'action': function (obj) { 	        
	            segment02_onAddItem(node.id);
	        }
		},
		'DownloadBatchFile': {
	        'separator_before': false,
	        'separator_after': false,
	        'label': 'Download Batch File',
	        'action': function (obj) { 	        
	            segment01_onDownloadBatchFile(node.id);
	        }
		},
		'CreateItems': {
	        'separator_before': false,
	        'separator_after': true,
	        'label': 'Upload Batch File',
	        'action': function (obj) { 	        
	            segment01_onUploadBatchFile(node.id);
	        }
		}
    };
    
    var treeRootNodeMenu = {};
    
    var categoryRootNodeMenu = {
   		'Create': {
            'separator_before': false,
            'separator_after': false,
            'label': 'New Category',
            'action': function (obj) {             
                segment01_onAddCategory(node.id, node);
            }
   		},
   		'Properties': {
	        'separator_before': true,
	        'separator_after': false,
	        'label': 'Properties',
	        'action': function (obj) { 	        
	        	segment01_onEditCategory(node.id, false);
	        }
		}
    };
    
    var isTreeRootNode = $('#'+node.id).hasClass('tree-root-node');
	var isCategoryRootNode = $('#'+node.id).hasClass('root-node');
    var isItemGroupNode = node.icon.indexOf('fa fa-cubes') >= 0;
    
    if (isTreeRootNode) {
    	return treeRootNodeMenu;
    }
    
    if (isCategoryRootNode) {
    	return categoryRootNodeMenu;
    }
    
    if (isItemGroupNode) {
        return groupNodeMenu;
    }
    
    return categoryNodeMenu;
} // .end of jstree_contextMenu

function jstree_sort(a, b)
{
	a1 = this.get_node(a);
    b1 = this.get_node(b);
    
    // If same icon, then sort in alphabetical order
    if (a1.icon == b1.icon) 
    {
        return (a1.text > b1.text) ? 1 : -1;
    } 
    else 
    {
    	return (a1.icon <= b1.icon) ? 1 : -1;
    }
} // .end of jstree_sort

function segment01_jstree_selectNode(categoryId) {
	//$('#segment01_jstree').jstree("deselect_all");
	$('#segment01_jstree').jstree('select_node', categoryId);
} // .end of segment01_jstree_selectNode

/**
 * Construct and update UI of category panel from zero. 
 */ 
function segment01_updateUI()
{
	// Show spinner loading
	$('#segment01_spinner').show();
	// Hide in-constructing jstree
	$('#segment01_jstree').hide();
	
	// Init, if any
	segment01_init();
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'fullBean': true,
		'filterByPosVisible': false,
		'posVisible': false
	};
	
	var params = new Object();
	
	// Ajax Call
	tycheesdb_api_listCategoryByPlace(requestBody, segment01_updateUI_postHandler, params);
} // .end of segment01_updateUI

/**
 * Handler function, after Ajax call (success or failure).
 *
 * @param {Boolean} successFlag - true if ajax call succeeded; otherwise false.
 * @param {Array}	categoryList - List of InventoryCategoryBean
 */ 
function segment01_updateUI_postHandler(successFlag, responseObj, params) 
{
	segment01_categoryList = responseObj.categoryList;
		
	Cached_setCategoryList( responseObj.categoryList );
	
	var showRawCategory = settingsCommon_getSettingsValue(
				ModuleConstants.MODULE_INVENTORY, 
				ModuleConstants.MODULE_INVENTORY_SUB_GENERAL, 
				SettingsConstants.SETTINGS_INVENTORY_KEY_SHOW_RAW_CATEGORY);
	var showProductCategory = settingsCommon_getSettingsValue(
				ModuleConstants.MODULE_INVENTORY, 
				ModuleConstants.MODULE_INVENTORY_SUB_GENERAL,  
				SettingsConstants.SETTINGS_INVENTORY_KEY_SHOW_PRODUCT_CATEGORY);
	var showServiceCategory = settingsCommon_getSettingsValue(
				ModuleConstants.MODULE_INVENTORY, 
				ModuleConstants.MODULE_INVENTORY_SUB_GENERAL, 
				SettingsConstants.SETTINGS_INVENTORY_KEY_SHOW_SERVICE_CATEGORY);
	var showEventCategory = settingsCommon_getSettingsValue(
				ModuleConstants.MODULE_INVENTORY, 
				ModuleConstants.MODULE_INVENTORY_SUB_GENERAL, 
				SettingsConstants.SETTINGS_INVENTORY_KEY_SHOW_EVENT_CATEGORY);
	var showDiscountCategory = settingsCommon_getSettingsValue(
				ModuleConstants.MODULE_INVENTORY, 
				ModuleConstants.MODULE_INVENTORY_SUB_GENERAL, 
				SettingsConstants.SETTINGS_INVENTORY_KEY_SHOW_DISCOUNT_CATEGORY);
	var showTaxCategory = settingsCommon_getSettingsValue(
				ModuleConstants.MODULE_INVENTORY, 
				ModuleConstants.MODULE_INVENTORY_SUB_GENERAL, 
				SettingsConstants.SETTINGS_INVENTORY_KEY_SHOW_TAX_CATEGORY);
	
	var rootNode_htmlLines = '';
	rootNode_htmlLines += '<ul>';
	rootNode_htmlLines += '<li class="tree-root-node jstree-open">';
	rootNode_htmlLines += 'Inventory';
	rootNode_htmlLines += '<ul id="segment01_jstree_root">';
	rootNode_htmlLines += '</ul>';
	rootNode_htmlLines += '</li>';
	rootNode_htmlLines += '</ul>';
	
	$('#segment01_jstree').empty();	
	$('#segment01_jstree').append( rootNode_htmlLines );
	
	$.each(Cached_getSystemCategoryList(true), function(i, categoryObj) {
		if (categoryObj.systemDefined==true) 
		{
			if ($.trim(categoryObj.name)=='Root Raw' && showRawCategory==false)
				return true;
			if ($.trim(categoryObj.name)=='Root Product' && showProductCategory==false)
				return true;
			if ($.trim(categoryObj.name)=='Root Service' && showServiceCategory==false)
				return true;
			if ($.trim(categoryObj.name)=='Root Event' && showEventCategory==false)
				return true;
			if ($.trim(categoryObj.name)=='Root Discount' && showDiscountCategory==false)
				return true;
			if ($.trim(categoryObj.name)=='Root Tax' && showTaxCategory==false)
				return true;
	
			var htmlLines = segment01_constructHTML_categoryTreeNode(categoryObj, 'root-node');			
			$('#segment01_jstree_root').append(htmlLines);
		}
	});
    
    // Init JSTree
    segment01_init_jstree();
    // Hide spinner loading
	$('#segment01_spinner').hide();
	// Show just-constructed jstree
	$('#segment01_jstree').show();
	
	// If open category on load
	if (global_openOnPageLoad_byCategory)
	{
		segment01_jstree_selectNode(global_openOnPageLoad_categoryId);
	}
	
	// If open item on load
	if (global_openOnPageLoad_byItem)
	{
		segment03_updateUI(global_openOnPageLoad_itemId);
	}
} // .end of segment01_updateUI_postHandler

function segment01_constructHTML_categoryTreeNode(categoryObj, className)
{
	var htmlLines = '';		
	htmlLines += '<li id="' + categoryObj.id + '" class="' + className + '">';
	htmlLines += categoryObj.name;
	htmlLines += segment01_constructHTML_childCategoryTreeNode(categoryObj);
	htmlLines += '</li>';
	
	return htmlLines;
} // .end of segment01_constructHTML_categoryTreeNode

function segment01_constructHTML_itemGroupTreeNode(categoryId, itemGroupName)
{
	var nodeId = segment01_generateTreeNodeId(categoryId, itemGroupName);
	
	var htmlLines = '';		
	htmlLines += '<li id="' + nodeId + '" class="text-navy item-group-node" data-jstree=\'{"icon":"fa fa-cubes"}\'>';
	htmlLines += '<span id="' + nodeId + '_categoryId" style="display:none;">' + categoryId + '</span>';
	htmlLines += '<span id="' + nodeId + '_itemGroupName" style="display:none;">' + itemGroupName + '</span>';
	htmlLines += itemGroupName;
	htmlLines += '</li>';
	return htmlLines;
} // .end of segment01_constructHTML_itemGroupTreeNode

function segment01_generateTreeNodeId(categoryId, itemGroupName)
{
	if (itemGroupName==null)
		return categoryId;
	else
		return categoryId + '_' + tycheesText_getSelectorIdFormat(itemGroupName);
} // .end of segment01_generateTreeNodeId

/**
 * Recursive function, to construct tree of child category.
 *
 * @param {String}	parentCategoryId - Parent Category Id
 */ 
function segment01_constructHTML_childCategoryTreeNode(parentCategoryObj)
{
	var childCategoryList = Cached_getCategoryListByParentId(parentCategoryObj.id);
	
	var groupHtmlLines = '<ul>';
	$.each(childCategoryList, function(i, categoryObj) {		
		groupHtmlLines += segment01_constructHTML_categoryTreeNode(categoryObj, 'category-node');
	});
	
	if (parentCategoryObj.itemGroupList != null)
	{
		$.each(parentCategoryObj.itemGroupList, function(i, itemGroup) {
			if ($.trim(itemGroup) != '')
				groupHtmlLines += segment01_constructHTML_itemGroupTreeNode(parentCategoryObj.id, itemGroup);
		});
	}
	
	groupHtmlLines += '</ul>';	
	return groupHtmlLines;
} // .end of segment01_constructHTML_childCategoryTreeNode

/**
 * Event on item object changed (saved) at segment03.
 */
function segment01_onItemChanged(itemObj)
{
	var categoryObj;
	$.each(segment01_categoryList, function(i, obj) {
		if (obj.id == itemObj.categoryId)
			categoryObj = obj;
	});
	
	if (categoryObj != null) {
		var newItemGroup = true;
		$.each(categoryObj.itemGroupList, function(i, itemGroup) {
			if ($.trim(itemGroup) == itemObj.groupName)
				newItemGroup = false;
		});
		
		if (newItemGroup) {
			// Add to category object
			categoryObj.itemGroupList.push(itemObj.groupName);
			
			var nodeId = segment01_generateTreeNodeId(categoryObj.id, itemObj.groupName);			
			var insertAtIndex = $( $('#'+categoryObj.id).children('.jstree-children')[0] ).children('li').length;
			
			$('#segment01_jstree').jstree()
				.create_node(categoryObj.id, {"id":nodeId, "text":itemObj.groupName,"icon":"fa fa-cubes"}, insertAtIndex);			
		}
		
		// Check deleted node
		var deletedGroupName = null;
		$.each(segment02_itemViewList, function(i, itemViewObj) {
			if (itemViewObj.id == itemObj.id) {
				deletedGroupName = itemViewObj.groupName;
				itemViewObj.groupName = itemObj.groupName;
			}
		});
		
		// Currently selecting Category
		if ($.trim(segment02_groupName)=='') {
			var itemGroupIndex = -1;
			$.each(categoryObj.itemGroupList, function(i, itemGroup) {
				
				var itemGroupFound = false;
				$.each(segment02_itemViewList, function(j, itemViewObj) {
					if (itemGroup == itemViewObj.groupName) {
						itemGroupFound = true;
					}
				});
				
				if (itemGroupFound == false) {
					itemGroupIndex = i;
					// Get node ID
					var nodeId = segment01_generateTreeNodeId(categoryObj.id, itemGroup);
					// Delete tree node from UI
					segment01_deleteNode(nodeId);
				}
			});
			
			if (itemGroupIndex >= 0)
				categoryObj.itemGroupList.splice(itemGroupIndex, 1);
		} 
		// Currently selecting group of Category
		else {
			if (segment02_itemViewList.length == 1) {
				var itemGroupIndex = -1;
				$.each(categoryObj.itemGroupList, function(i, itemGroup) {
					if (itemGroup == deletedGroupName)
						itemGroupIndex = i;
				});
				if (itemGroupIndex >= 0)
					categoryObj.itemGroupList.splice(itemGroupIndex, 1);
				
				// Get node ID
				var nodeId = segment01_generateTreeNodeId(categoryObj.id, deletedGroupName);
				// Delete tree node from UI
				segment01_deleteNode(nodeId);
			}
		}
		
		var nodeElementList = $( $('#'+categoryObj.id).children('.jstree-children')[0] ).children('li');
		$.each(nodeElementList, function(i, nodeElementObj) {
			if (!$(nodeElementObj).hasClass('category-node') && !$(nodeElementObj).hasClass('item-group-node')) {
				var currentNodeId = $(nodeElementObj).attr('id');
				var currentGroupName = $('#'+currentNodeId+'_anchor').html().substring($('#'+currentNodeId+'_anchor').html().indexOf('</i>')+4);
				
				$(nodeElementObj).addClass('item-group-node');
				$(nodeElementObj).addClass('text-navy');
				
				$(nodeElementObj).append(
					'<span id="' + currentNodeId + '_categoryId" style="display:none;">' + categoryObj.id + '</span>');
				$(nodeElementObj).append(
					'<span id="' + currentNodeId + '_itemGroupName" style="display:none;">' + currentGroupName + '</span>');
			}
		});
	}
} // .end of segment01_onItemChanged

/**
 * Get list count of item list, under given category id.
 */ 
function segment01_prePopulateItemList(categoryId, groupName)
{
	segment02_showLoading('loading...');

    // Set Checkpoint
    segment01_categoryId_inRequest = categoryId;
    segment01_groupName_inRequest  = groupName;

	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': categoryId,
		'filterByGroupName': $.trim(groupName)=='' ? false : true,
		'groupName': groupName,
		'fullBean': false
	};
	
	tycheesLogger_logDebug('requestBody='+JSON.stringify(requestBody));
	
	// Params object
	var params = new Object();
	params.categoryId = categoryId;
	params.itemGroupName = groupName;
	
	// Ajax Call
	tycheesdb_api_getItemCountByCategory(requestBody, segment01_prePopulateItemList_postHandler, params);
} // .end of segment01_prePopulateItemList

/**
 * Post handling for segment01_prePopulateItemList.
 */ 
function segment01_prePopulateItemList_postHandler(successFlag, responseObj, params)
{
	if (successFlag == false)
	{
		return false;
	}

	if (responseObj.itemCount > 350)
	{
		// Clear list
		$('#segment02_dataTable').DataTable().clear().draw();
		
		segment02_hideLoading();
	}
	else
	{
		segment02_updateUI(params.categoryId, params.itemGroupName, responseObj.itemCount);
	}
} // .end of segment01_prePopulateItemList_postHandler

function segment01_filterCategoryList()
{
    var keyword = $.trim( $('#segment01_searchField').val() );    
    $("#segment01_jstree").jstree("search", keyword);
} // .end of segment01_filterCategoryList

function segment01_resetSearch()
{
	// Reset
	$('#segment01_searchField').val('');
	// Search
	segment01_filterCategoryList();
} // .end of segment01_resetSearch

/**
 * Expecting unformatted ID in format '$categoryID'_anchor. 
 * e.g. 68601e20-a425-4088-6384-93d1cacc5cc4_anchor
 * 
 * After parsing, the returning id is 68601e20-a425-4088-6384-93d1cacc5cc4.
 */
function segment01_parseCategoryIdFromTreeNode(unformattedId)
{
	return unformatted.substring(0, unformattedId.indexOf('_anchor'));
} // .end of segment01_parseCategoryIdFromTreeNode

function segment01_addItemGroupAsTreeNode(categoryId, itemGroupName)
{
	var nodeId = segment01_generateTreeNodeId(categoryId, itemGroupName);
	
	// Check existence of tree node
	var nodeExist = false;
	if ($('#'+nodeId).length > 0)
		nodeExist = true;
	
	if (nodeExist == false)
	{
		$('#segment01_jstree').jstree().create_node(
			categoryId,  
			{
				"id": nodeId, 
				"text": itemGroupName,
				"icon": "fa fa-cubes"
			}, 
			"last", 
			function(){
			}
		);
		
		// Set text color
		$('#'+nodeId).addClass('text-navy');
		// Add identifier node
		$('#'+nodeId).addClass('item-group-node');
		// Add hidden values to anchor node
		var htmlLines = '';
		htmlLines += '<span id="' + nodeId + '_categoryId" style="display:none;">' + categoryId + '</span>';
		htmlLines += '<span id="' + nodeId + '_itemGroupName" style="display:none;">' + itemGroupName + '</span>';
		$('#'+nodeId+'_anchor').append( htmlLines );
	}
} // .end of segment01_addItemGroupAsTreeNode

function segment01_deleteNode(nodeId)
{
	$('#segment01_jstree').jstree().delete_node( $('#'+nodeId) );
} // .end of segment01_deleteNode

/**
 * Event listener for user click on 'New Category'. 
 *
 * @param	{String} parentCategoryId - Id of parent category.
 * @param	{String} treeNodeId - jstree node id
 * @return	nil
 */
function segment01_onAddCategory(parentCategoryId, treeNodeId)
{
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var categoryMaxCount = 0;
	var categoryUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_INVENTORY_CATEGORY_MAX_COUNT) {
			categoryMaxCount = Number(propObj.propValue);
			categoryUsageCount = Number(propObj.propContent);
		}
	});
	
	if (categoryUsageCount >= categoryMaxCount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	// Show spinner before ajax call.
	tycheesOverlay_startShortProgress('Loading...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': parentCategoryId,
		'fullBean': true
	};

	var params = new Object();
	params.parentCategoryId = parentCategoryId;
	params.treeNodeId = treeNodeId;
	
	tycheesdb_api_getCategoryById(requestBody, segment01_onAddCategory_postValidation, params);
} // .end of segment01_onAddCategory

function segment01_onAddCategory_postValidation(successFlag, responseObj, params)
{
	tycheesOverlay_stopShortProgress();
	
	if (successFlag==false) 
		return false;
	
	segment01_mw001_open(params.parentCategoryId, segment01_onAddCategory_postHandler, params, responseObj.categoryObj);	
} // .end of segment01_onAddCategory_postValidation

/**
 * Post Handler for user click on 'New Category', right after Modal Window (mw001)
 * is close.
 *
 * @param	{boolean} successFlag - true if new category has been saved.
 * @param	{Object} params - parameter object.
 * @return	nil
 */
function segment01_onAddCategory_postHandler(successFlag, params, categoryObj)
{
	if (successFlag==true)
	{
		$('#segment01_jstree').jstree().create_node(
			params.parentCategoryId,  
			{
				"id": categoryObj.id, 
				"text": categoryObj.name
			}, 
			"last", 
			function(){
		    	tycheesLogger_logInfo('Category Node [' + categoryObj.name + '] created.','segment01_onAddCategory_postHandler');
			}
		);
	}
} // .end of segment01_onAddCategory_postHandler

/**
 * Event listener for user click on 'Edit Category'. 
 *
 * @param	{String} parentCategoryId - Id of parent category.
 * @param	{String} treeNodeId - jstree node id
 * @return	nil
 */
function segment01_onEditCategory(categoryId, editable)
{
	tycheesOverlay_startShortProgress('Loading...');
		
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': categoryId,
		'fullBean': true
	};

	var params = new Object();
	params.categoryId = categoryId;
	params.editable = editable;
	
	tycheesdb_api_getCategoryById(requestBody, segment01_onEditCategory_postValidation, params);	
} // .end of segment01_onEditCategory

function segment01_onEditCategory_postValidation(successFlag, responseObj, params)
{
	if (successFlag == false)
	{
		return false;
	}

	tycheesOverlay_stopShortProgress();
	
	segment01_mw002_open(params.categoryId, segment01_onEditCategory_postHandler, params, responseObj.categoryObj);
} // .end of segment01_onEditCategory_postValidation

/**
 * Post Handler for user click on 'Edit Category', right after Modal Window 
 * (mw002) is close.
 *
 * @param	{boolean} successFlag - true if new category has been saved.
 * @param	{Object} params - parameter object.
 * @return	nil
 */
function segment01_onEditCategory_postHandler(successFlag, params, categoryObj)
{
	if (successFlag==true)
	{
		var nodeObj = $("#segment01_jstree").jstree().get_node(categoryObj.id);
		
		$("#segment01_jstree").jstree().rename_node(
			nodeObj,
			categoryObj.name
		);
	}
} // .end of segment01_onEditCategory_postHandler

/**
 * Event listener for user click on 'Edit Category'. 
 *
 * @param	{String} parentCategoryId - Id of parent category.
 * @param	{String} treeNodeId - jstree node id
 * @return	nil
 */
function segment01_onDeleteCategory(categoryId)
{
	var categoryObj = Cached_getCategoryById(categoryId);
	
	if (categoryObj==null)
    {
    	swal(
			"System Error", 
			"Our system unable to process your request. Please contact our customer service for solution.", 
			"error");
		return false;
    }
    
	if (inventoryUtil_isRootCategory(categoryObj))
	{
		swal(
			"Prohibited Action", 
			"This is a System Generated Item, you are not allowed to delete it.", 
			"error");
		return false;
	}
    
	var params = new Object();
	params.categoryId = categoryId;
	
	segment01_mw003_open(categoryId, segment01_onDeleteCategory_postHandler, params);
} // .end of segment01_onDeleteCategory

/**
 * Post Handler for user click on 'Edit Category', right after Modal Window 
 * (mw002) is close.
 *
 * @param	{boolean} successFlag - true if new category has been saved.
 * @param	{Object} params - parameter object.
 * @return	nil
 */
function segment01_onDeleteCategory_postHandler(successFlag, params)
{
	if (successFlag==true)
	{
		// Remove jstree node
		var nodeObj = $("#segment01_jstree").jstree().get_node(params.categoryId);		
		$("#segment01_jstree").jstree().delete_node(nodeObj);
		
		// Hide panel (assume currently shown category is deleted category)
		$('#inv02_segment02').hide();
	}
} // .end of segment01_onDeleteCategory_postHandler

function segment01_onRefreshCategory(categoryId)
{
	// Show Progress
	tycheesOverlay_startShortProgress('refreshing...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': categoryId,
		'fullBean': false
	};
	
	var params = new Object();
	params.categoryId = categoryId;
	
	tycheesdb_api_listCategoryByParentCategory(requestBody, segment01_onRefreshCategory_postHandler, params);
} // .end of segment01_onRefreshCategory

function segment01_onRefreshCategory_postHandler(successFlag, responseObj, params)
{
	if (successFlag == false)
	{
		return false;
	}

	// Stop Progressing Message
	tycheesOverlay_stopShortProgress();
	
	$.each(responseObj.categoryList, function(i, categoryObj) {
		tycheesLogger_logDebug('Child Category ['+i+']=' + categoryObj.name,'segment01_onRefreshCategory_postHandler');
	});
} // .end of segment01_onRefreshCategory_postHandler


function segment01_onDownloadBatchFile(nodeId)
{	
	var categoryId = nodeId;
	var groupName  = '';
	
	if ($('#'+nodeId).hasClass('item-group-node'))
	{
		categoryId = $('#'+nodeId+'_categoryId').html();
		groupName  = $('#'+nodeId+'_itemGroupName').html();
	}
	
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': categoryId,
		'filterByGroupName': $.trim(groupName)=='' ? false : true,
		'groupName': groupName,
		'fullBean': true,
		'loadImages': false,
		'viewBean': false
	};
	
	var params = new Object();
	params.categoryId = categoryId;
	params.groupName = groupName;
	
	// Batch Download Request
	tycheesdb_api_batchDownloadItems(requestBody, segment01_batchDownloadItems_postHandler, params);
	//  Show message
	swal({
		type: 'success',
	    title: 'Preprocessing in Progress',
		text: 'We will notify (few minutes) you once the batch file is ready for download.',
		//imageUrl: 'images/thumbs-up.jpg',
		html: true
	});
} // .end of segment01_onDownloadBatchFile

function segment01_onDownloadBatchFile_preCheck(success, responseObj, params)
{
	if (!success)
		return false;
	
	// Hide progress overlay
	tycheesOverlay_stopShortProgress();
	
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': params.categoryId,
		'filterByGroupName': $.trim(params.groupName)=='' ? false : true,
		'groupName': params.groupName,
		'fullBean': true,
		'loadImages': false,
		'viewBean': false
	};
	
	// Batch Download Request
	tycheesdb_api_batchDownloadItems(requestBody, segment01_batchDownloadItems_postHandler, params);
	//  Show message
	swal({
		type: 'success',
	    title: 'Preprocessing in Progress',
		text: 'We will notify (few minutes) you once the batch file is ready for download.',
		//imageUrl: 'images/thumbs-up.jpg',
		html: true
	});
} // .end of segment01_onDownloadBatchFile_preCheck

function segment01_batchDownloadItems_postHandler(success, responseObj, params)
{
	if (!success) {
		return false;
	}
	
	/*if (success) {
		swal({
			type: 'success',
		    title: 'Batch File is Available Soon',
			text: 'Please check at the notification <i class="fa fa-bell" aria-hidden="true"></i> when batch file is ready for download.',
			//imageUrl: 'images/thumbs-up.jpg',
			html: true
		});
	} else {
		swal({
			type: 'error',
		    title: 'Request Failed',
			text: 'Please try to download again.',
			//imageUrl: "images/thumbs-up.jpg",
			html: true
		});
	}*/
} // .end of segment01_batchDownloadItems_postHandler

function segment01_onUploadBatchFile(nodeId)
{
	var categoryId = nodeId;
	var groupName  = '';
	
	if ($('#'+nodeId).hasClass('item-group-node'))
	{
		categoryId = $('#'+nodeId+'_categoryId').html();
		groupName  = $('#'+nodeId+'_itemGroupName').html();
	}
	
	$('#segment01_batchFileUpload').click();
} // .end of segment01_onUploadBatchFile

function segment01_validateBatchFile()
{
	var files = $('#segment01_batchFileUpload')[0].files;
	if (files != null && files.length > 0) 
	{
		tycheesOverlay_stopShortProgress('Validating batch file format...');
		tycheesFile_getBase64(files[0], segment01_validateBatchFile_postHander);
	}
	
	// Reset
   	segment01_systemResetFileUpload = true;
	$('#segment01_batchFileUpload').val("");
} // .end of segment01_validateBatchFile

function segment01_validateBatchFile_postHander(success, base64, fileName, fileType, fileSize)
{
	//var excelDoc = new ExcelPlus();
	//var header = dataURI.substr(0, dataURI.indexOf(","));
	//var data = dataURI.substr(dataURI.indexOf(","));
	//var type = header.match(/;base64/) ? "base64" : "binary";
	/*
	excelDoc.open(base64.substr(base64.indexOf(",")), {type:'base64'});

	var cellVal_categoryId		= excelDoc.read("B2");
	var cellVal_categoryName	= excelDoc.read("D2");
	var cellVal_itemType    	= excelDoc.read("F2");
	
	var categoryObj = Cached_getCategoryById(cellVal_categoryId);
	
	var itemListForInsert = [];
	var itemListForUpdate = [];
	var itemListForDelete = [];
	*/
	tycheesOverlay_startShortProgress('Preprocessing file...');
	var params = inventoryUtil_processBatchUpload(base64);
/*
	var params = new Object();
	params.itemListForInsert = itemListForInsert;
	params.itemListForUpdate = itemListForUpdate;
	params.itemListForDelete = itemListForDelete;
*/	
	segment01_mw201_updateUI(params);
	//tycheesLogger_logInfo(excelDoc.read("A1"), 'segment01_validateBatchFile_postHander');
	
	tycheesOverlay_stopShortProgress();
} // .end of segment01_validateBatchFile_postHander
</script>