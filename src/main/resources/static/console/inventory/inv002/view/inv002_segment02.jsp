<div class="ibox" id="inv02_segment02" style="display:none;">
    <div class="ibox-title" style="background-color:#404040;color:#ffffff;">
		<h5>
			<i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> 
			Category: <span id="segment02_categoryName" style="font-size:14pt;color:#f8ac59;padding-right:20px;">CATEGORY TITLE</span>
			Group Name: <span id="segment02_groupName" style="font-size:14pt;color:#f8ac59;">GROUP NAME</span>
		</h5> 
		<div id="segment02_posVisibilitySwitch" style="display:none;">
	        <div class="switch pull-right">
	            <div class="onoffswitch">
	                <input id="segment02_switch_pos" type="checkbox" class="onoffswitch-checkbox" onchange="segment02_onSwicthPos_category();">
	                <label class="onoffswitch-label" for="segment02_switch_pos">
	                    <span class="onoffswitch-inner"></span>
	                    <span class="onoffswitch-switch"></span>
	                </label>
	            </div>
	        </div>
	        <div class="pull-right" style="padding-left:10px;padding-right:5px;">POS</div>
	    </div>
    </div>
    <div class="ibox-content" style="padding:5px 5px;">
        <div id="segment02_spinner" class="spiner-example" style="display:none;">
			<div class="sk-spinner sk-spinner-three-bounce">
                <div class="sk-bounce1"></div>
                <div class="sk-bounce2"></div>
                <div class="sk-bounce3"></div>
            </div>
		    <div id="segment02_spinner_text" style="padding-top:10px; text-align:center;">loading...</div>
		</div>
		
		
		<table id="segment02_dataTable" class="table table-striped table-bordered table-hover" width="100%">
			<thead>
				<tr>
					<th>Item ID</th>						
					<th>Item Name</th>						
					<th>SKU Code</th>						
					<th>Label/Tag</th>						
					<th>Grouping</th>						
					<th class="text-right">Quantity</th>	
					<th class="text-right">Unit Price</th>
					<th class="text-right"></th>
				</tr>
			</thead>
			<tbody id="segment02_dataTable_tbody">                      
			</tbody>
		</table>
    </div> 
</div><!-- .end of ibox -->


<!-- Modal Window: Clone Item -->
<%@include file="/console/inventory/inv002/view/inv002_segment02_mw001.jsp" %>
<!-- Modal Window: Add New Item -->
<%@include file="/console/inventory/inv002/view/inv002_segment02_mw002.jsp" %>
<!-- Modal Window: Show Dependent Item in tabular form -->
<%@include file="/console/inventory/inv002/view/inv002_segment02_mw003.jsp" %>

<script>

var segment02_initialized = false;
var segment02_categoryId;
var segment02_groupName;
var segment02_itemViewList = [];
var segment02_itemId_inRequest;

function segment02_init()
{
	if (segment02_initialized)
		return false;
	
    // Init states
    $('#segment02-searchField').keyup(function() {
    	segment02_filterItemList();
    });
    
 	// Init DataTable
	$("#segment02_dataTable").DataTable({
        "columnDefs": [{"targets": [ 0 ], "visible": false, "searchable": false},
                       {"targets": [ 1 ], "visible": true,  "searchable": true, "orderData": [ 1, 4, 5 ]},
                       {"targets": [ 2 ], "width": 90, "visible": true, "searchable": true},
                       {"targets": [ 3 ], "visible": false, "searchable": true},
                       {"targets": [ 4 ], "visible": false, "searchable": true},
        			   {"targets": [ 5 ], "width": 90 },
        			   {"targets": [ 6 ], "width": 90 },
        			   {"targets": [ 7 ], "width": 50}],
        //"order": [[ 3, 'asc'], [1, 'asc']],
        "order": [[ 3, 'asc']],
        "displayLength": 50,	// Number of row / page,
        "fixedColumns": true,
        "drawCallback": function ( settings ) {
        	var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
 
            api.column(3, {page:'current'} ).data().each( function ( group, i ) {
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group"><td colspan="7" class="text-navy"><i class="fa fa-cubes" aria-hidden="true"></i> '+group+'</td></tr>'
                    );
 
                    last = group;
                }
            } );
        }
    });	
	
	segment02_initialized = true;
} // .end of segment02_init

function segment02_showLoading(text)
{
	// Mask Info
	$('#segment02_categoryName').html('---');
	$('#segment02_groupName').html('---');
	$('#segment02_posVisibilitySwitch').hide();	
	// Show panel
	$('#inv02_segment02').show();
	// Set spinner loading text
	$('#segment02_spinner_text').html(text);
	// Show spinner loading
	$('#segment02_spinner').show();
	// Hide just-constructed dataTable
	$('#segment02_dataTable_wrapper').hide();
	$('#segment02_dataTable').hide();
} // .end of segment02_showLoading

function segment02_hideLoading()
{
	// Set spinner loading text
	$('#segment02_spinner_text').html('');
	// Show spinner loading
	$('#segment02_spinner').hide();
	// Hide just-constructed dataTable
	$('#segment02_dataTable').show();
	$('#segment02_dataTable_wrapper').show();
} // .end of segment02_hideLoading

/**
 * Response to user action on selecting category, followed by showing list of
 * items under the category.
 */ 
function segment02_updateUI(categoryId, groupName, itemCount)
{	
	// If user triggers context menu to delete category, it will call this function.
	// Therefore ignore this update, if trigger point is from delete category.
	if (segment01_mw003_executed==true)
	{
		segment01_mw003_executed = false;
		return false;
	}
	
	// Hide item details
	segment03_slideIn();
	
	// Show loading
	segment02_showLoading('remote loading ' + itemCount + ' items...');
	
	// Init, if any.
	segment02_init();
	
	// Reset
	segment02_categoryId = categoryId;
	segment02_groupName = groupName;
	
	if ($.trim(segment02_groupName)=='')
		$('#segment02_posVisibilitySwitch').show();
	else
		$('#segment02_posVisibilitySwitch').hide();	
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'categoryId': segment02_categoryId,
		'filterByGroupName': $.trim(groupName)=='' ? false : true,
		'groupName': groupName,
		'fullBean': false,
		'viewBean': true
	};
	
	var params = new Object();
	params.categoryId = segment02_categoryId;
	params.groupName = groupName;
	params.viewBean = true;
	
	// Ajax Call
	if (itemCount==0)
	{
		var object = new Object();
		object.itemViewList = [];
		segment02_updateUI_postHandler(true, object, params);
	}
	else
	{
		tycheesdb_api_getItemsByCategory(requestBody, segment02_updateUI_postHandler, params);
	}
} // .end of segment02_updateUI.

function segment02_updateUI_postHandler(successFlag, responseObj, params)
{
	if (successFlag == false)
	{
		return false;
	}

	// Only proceed to update display if given result is not the last requested. 
    if (params.categoryId != segment01_categoryId_inRequest || params.groupName != segment01_groupName_inRequest)
		return false;
		
	// Set item view list
	segment02_itemViewList = responseObj.itemViewList;
    
    var categoryObj = Cached_getCategoryById(segment02_categoryId); 
    if (categoryObj == null)
    {
    	segment02_hideLoading();
    	return false;
    }
    
    var groupNameOnTitle = '*';
    if ($.trim(segment02_groupName) != '')
    	groupNameOnTitle = segment02_groupName;
    
	// Set title
	$('#segment02_categoryName').html( categoryObj.name );	
	$('#segment02_groupName').html( groupNameOnTitle );
	// Set POS/PWS status
	$('#segment02_switch_pos').prop( "checked", categoryObj.posVisible );
	
	//$('#item-groups').empty();

	// Clear list
	$('#segment02_dataTable').DataTable().clear().draw();
	
	// Show items in category, by groupName
	$.each(segment02_itemViewList, function(i, itemObj) {
		segment02_insertItemIntoDataTable(itemObj);
	});
	
	// Hide spinner loading
	segment02_hideLoading();
} // .end of segment02_updateUI_postHandler

function segment02_insertItemIntoDataTable(itemObj)
{
	var cssVal = 'color:#333;';
	var rowClickAction = 'segment02_prePopulateItemDetails(\'' + itemObj.id + '\')';
	
	// Col #1
	var col1_itemId = itemObj.id;	
	
	// Col #2
	var col2_itemName = '';
	col2_itemName += '<div class="i-checks" id="checkbox-' + itemObj.id + '" style="padding-left:20px;">';	
	col2_itemName += '<label>';
	//col2_itemName += iconCell;
	col2_itemName += '<i class="fa fa-archive" aria-hidden="true" style="' + cssVal + '"></i> ';
	col2_itemName += '<a id="itemView-list-' + itemObj.id + '" class="client-link" onclick="' + rowClickAction + '">' + $.trim(itemObj.name) + '</a>';
	col2_itemName += '</label>'; 
	col2_itemName += '</div>';

	// Col #3
	var col3_skuCode	= itemObj.skuCode;
	
	// Col #3
	var col3_labels	= itemObj.labels;

	// Col #4
	var col4_groupName	= $.trim(itemObj.groupName) == '' ? 'No Group' : $.trim(itemObj.groupName);

	// Col #5
	var col5_quantity = '<span class="pull-right" id="item-quantity-' + itemObj.id + '" style="'+cssVal+'">' + itemObj.quantity + '</span>';
	
	// Col #6
	var col6_unitPrice = '<span class="pull-right">' + itemObj.unitPrice + '</span>';
	
	// Col #7
	var col7_actions = '';
	col7_actions += '<span class="pull-right btn btn-xs btn-danger" style="font-size:10px;margin:1px;" onclick="segment02_onDeleteItem(\'' + itemObj.id + '\',this)">';
	col7_actions += '<i class="fa fa-trash-o" aria-hidden="true"></i>';
	col7_actions += '</span>';
	col7_actions += '<span class="pull-right btn btn-xs btn-info" style="font-size:10px;margin:1px;" onclick="segment02_onCloneItem(\'' + itemObj.id + '\')">';
	col7_actions += '<i class="fa fa-files-o" aria-hidden="true"></i>';
	col7_actions += '</span>';
	
	// Add to dataTable as row
	$("#segment02_dataTable").DataTable().row.add( [
	    col1_itemId,  
        col2_itemName,
        col3_skuCode,
        col3_labels,
        col4_groupName, 
        col5_quantity,
        col6_unitPrice,
        col7_actions])
        .draw(false);
} // .end of segment02_insertItemIntoDataTable

/**
 * Show Clone Item modal window
 */ 
function segment02_onCloneItem(itemId)
{	    	
	var params = new Object();
	params.itemId = itemId;
	
    segment02_mw001_open(segment02_onCloneItem_postHanlder, params);
} // .end of segment02_onCloneItem

function segment02_onCloneItem_postHanlder(successFlag, params)
{
	if (successFlag==true)
	{
		segment02_insertItemIntoDataTable(params.newItemObj);
	}
} // .end of segment02_onCloneItem_postHanlder

/**
 * Show Clone Item modal window
 */ 
function segment02_onDeleteItem(itemId, rowElement)
{	    	
	tycheesOverlay_startShortProgress('Checking dependency...');
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'itemId': itemId,
		'fullBean': false
	};
	
	var params = new Object();
	params.itemId = itemId;	
	params.rowElement = rowElement;
	
	// Ajax Call
	tycheesdb_api_getItemById(requestBody, segment02_onDeleteItem_step1, params);	
} // .end of segment02_onDeleteItem

function segment02_onDeleteItem_step1(success, responseObj, params)
{
	if (!success) {
		tycheesOverlay_stopShortProgress();
		swal("Oops", "Something went wrong!", "error");
		return false;
	}
	
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'itemId': params.itemId,
		'fullBean': false
	};
		
	params.itemObj = responseObj.itemObj;	
	
	// Ajax Call
	tycheesdb_api_getDependentItemsByItemId(requestBody, segment02_onDeleteItem_postValidation, params);
} //.end of segment02_onDeleteItem_step1

function segment02_onDeleteItem_postValidation(success, responseObj, params)
{
	if (!success) {
		tycheesOverlay_stopShortProgress();
		swal("Oops", "Something went wrong!", "error");
		return false;
	}

	// Stop Progressing Message
	tycheesOverlay_stopShortProgress();
	
	if (responseObj.dependentItemList==null)
		responseObj.dependentItemList = [];

	if (responseObj.dependentItemList.length > 0)
	{
		segment02_mw003_open(params.itemObj, responseObj.dependentItemList);
	}
	else
	{
		swal({   
			title: "Are you sure?",   
			text: "You will not be able to recover this item [" + params.itemObj.name + "]!",   
			type: "warning",   
			showCancelButton: true,   
			confirmButtonColor: "#DD6B55",   
			confirmButtonText: "Yes, delete it!",   
			closeOnConfirm: true 
		}, function(confirm) {
			
			if (confirm) {
				// Show status
				tycheesOverlay_startShortProgress('deleting item...');
				// delete item
				segment02_onDeleteItem_postHandler(params);
			}
		});
	}
} // .end of segment02_onDeleteItem_postValidation

function segment02_onDeleteItem_postHandler(params)
{
	// Update UI - remove DataTable row
	$('#segment02_dataTable').DataTable().row( $(params.rowElement).parents('tr') ).remove().draw();
	// Update UI - remove jstree node of item group name, if any
	if ( $.trim(params.itemObj.groupName) != '' ) 
	{		
		var itemInSameGroup = false;
		$.each(segment02_itemViewList, function(i, obj) {
			if (obj.id == params.itemObj.id)
				return true;
			
			if (obj.groupName == params.itemObj.groupName) {
				itemInSameGroup = true;
				return false;
			}
		});
		
		if (itemInSameGroup==false)
		{
			var nodeId = segment01_generateTreeNodeId(params.itemObj.categoryId, params.itemObj.groupName);
			segment01_deleteNode( nodeId );
		}
	}
	
	// Remove from local DB
	Cached_deleteBean(params.itemObj);
	// Save to IDB
	tycheesIO_saveBean(params.itemObj);	
	// Stop Progressing Message
	tycheesOverlay_stopShortProgress();
	// Show toast message
	tycheesLogger_showToast("success", "Deleted", "Your inventory item has been deleted!");
} // .end of segment02_onDeleteItem_postHandler

function segment02_prePopulateItemDetails(itemId)
{
	// Set checkpoint
	segment02_itemId_inRequest = itemId;
	
	// Show Item
	segment03_updateUI(itemId);
} // .end of segment02_prePopulateItemDetails

/**
 * Response to user click on ON/OFF switch at top of segment. 
 */ 
function segment02_onSwicthPos_category()
{
	// Prepare request body
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'fullBean': true,
		'categoryId': segment02_categoryId
	};
	
	var params = new Object();
	params.categoryId = segment02_categoryId;
	
	// API Call
	tycheesdb_api_getCategoryById(requestBody, segment02_onSwicthPos_category_postHandler, params);
} // .end of segment02_onSwicthPos_category

function segment02_onSwicthPos_category_postHandler(successFlag, responseObj, params)
{
	if (successFlag==false)
		return false;
		
	// Get user input
	var posCheckStatus = $('#segment02_switch_pos').prop('checked');
	// Set to object
	responseObj.categoryObj.posVisible = posCheckStatus;
	// Write to IDB
	tycheesIO_saveBean(responseObj.categoryObj);
	// Update Cache
	Cached_updateCategory(responseObj.categoryObj);
} // .end of segment02_onSwicthPos_category_postHandler

function segment02_onAddItem(nodeId)
{
	// Check if reach max count
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	var itemMaxCount = 0;
	var itemUsageCount = 0;
	
	$.each(placeObj.propertiesList, function(i, propObj) {
		if (propObj.propKey == PlaceConstants.PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT) {
			itemMaxCount = Number(propObj.propValue);
			itemUsageCount = Number(propObj.propContent);
		}
	});
	
	if (itemUsageCount >= itemMaxCount)	{
		swal({
			type: 'warning',
		    title: 'Max Usage Exceeded',
			text: 'Please increase the usage limit at Settings > My Place > Account Membership'
		});
		return false;
	}
	
	var categoryId = nodeId;
	var groupName  = '';
	
	if ($('#'+nodeId).hasClass('item-group-node'))
	{
		categoryId = $('#'+nodeId+'_categoryId').html();
		groupName  = $('#'+nodeId+'_itemGroupName').html();
	}
	
	var params = new Object();
	params.categoryId = categoryId;
	params.groupName = groupName;
	
	segment02_mw002_open(categoryId, groupName, segment02_onAddItem_postHandler, params);
} // .end of segment02_onAddItem

function segment02_onAddItem_postHandler(successFlag, params)
{
	if (successFlag==true)
	{
		// Add dataTable row
		segment02_insertItemIntoDataTable(params.newItemObj);
		
		// Add new node
		segment01_addItemGroupAsTreeNode(params.newItemObj.categoryId, params.newItemObj.groupName);
	}
} // .end of segment02_onAddItem_postHandler

</script>