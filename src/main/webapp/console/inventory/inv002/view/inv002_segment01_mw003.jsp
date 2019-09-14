<!-- Modal Window: Show Affected Categories & Items in tabular form -->
<div class="modal inmodal fade" id="segment01_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
	<div id="segment01_mw003_modalSize" class="modal-dialog modal-lg4">
		<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">CONFIRM DELETE IMPACTS</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
			<div class="modal-body">
			
				<div id="segment01_mw003_noImpact" class="ibox-title" style="color:#1ab327;height:80px;display:none;">
					<h5>
						<i class="fa fa-info-circle" aria-hidden="true"></i>
						No impact on other categories or items. 
						<br><br>
						<span style="padding-left:16px;">You may click button "Execute Request" to delete now.</span>
					</h5>
				</div>
			
				<div id="segment01_mw003_table1_title" class="ibox-title" style="color:#ff0000;">
					<h5>
						<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
						Following child categories will RE-LINK to parent category.	
					</h5>
				</div>
				<div id="segment01_mw003_table1_content" class="ibox-content">
   	                <table class="table table-striped table-bordered table-hover " id="segment01_mw003_dataTable_childCategory" >
   	                    <thead>
   	                        <tr>
   	                            <th>No</th>
   	                            <th>Category</th>
   	                            <th>Old Parent Category</th>
   	                            <th>New Parent Category</th>
   	                            <th>Action</th>
   	                        </tr>
   	                    </thead>
   	                    <tbody>
   	                    </tbody>
   	                </table>
				</div> <!-- .end of ibox-content -->
				
				<div id="segment01_mw003_table2_title" class="ibox-title" style="color:#ff0000;">
					<h5>
						<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 
						Following child items will DELETE from database.	
					</h5>
				</div>
				<div id="segment01_mw003_table2_content" class="ibox-content">
					<table class="table table-striped table-bordered table-hover " id="segment01_mw003_dataTable_childItem" >
      	                    <thead>
      	                        <tr>
      	                            <th>No</th>
      	                            <th>Category</th>
      	                            <th>Item Name</th>
      	                            <th>Action</th>
      	                        </tr>
      	                    </thead>
      	                    <tbody>
      	                    </tbody>
      	                </table>
				</div> <!-- .end of ibox-content -->
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Cancel</button>
				<button type="button" class="btn btn-primary" onclick="segment01_mw003_execute();"><i class="fa fa-cog" aria-hidden="true"></i> Execute Request</button>
			</div>
		</div>
	</div>
</div>

<script>

var segment01_mw003_initialized = false;
var segment01_mw003_executed = false;
var segment01_mw003_categoryId;
var segment01_mw003_callbackFn;
var segment01_mw003_callbackFnParams;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment01_mw003_isOpen()
{
	return ($("#segment01_mw003").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw003_isOpen

/**
 * Modal Window Init.
 */
function segment01_mw003_init()
{
	if (segment01_mw003_initialized==true)
		return false;
	
	$('#segment01_mw003_dataTable_childItem').dataTable();
	$('#segment01_mw003_dataTable_childCategory').dataTable();
	
	segment01_mw003_initialized = true;
} // .end of segment01_mw003_init

/**
 * Open Modal Window
 */
function segment01_mw003_open(categoryId, postHandlerFn, params)
{
	// Set callback
	segment01_mw003_categoryId = categoryId;
	segment01_mw003_callbackFn = postHandlerFn;
	segment01_mw003_callbackFnParams = params;
	// Get Category object
	var categoryObj = Cached_getCategoryById(segment01_mw003_categoryId);

	// Init
	segment01_mw003_init();	
	
	var parentCategoryObj = Cached_getCategoryById(categoryObj.parentCategoryId);
	var childItemList = Cached_getItemListByCategoryId(categoryObj.id);
	var childCategoryList = Cached_getCategoryListByParentId(categoryObj.id);

	if (childCategoryList.length == 0 && childItemList.length == 0) 
	{
		$('#segment01_mw003_noImpact').show();
		$('#segment01_mw003_modalSize').addClass('modal-lg');
		$('#segment01_mw003_modalSize').removeClass('modal-lg4');
	}
	else
	{
		$('#segment01_mw003_noImpact').hide();
		$('#segment01_mw003_modalSize').addClass('modal-lg4');
		$('#segment01_mw003_modalSize').removeClass('modal-lg');
	}

	// Table 1: Child categories
	$('#segment01_mw003_dataTable_childCategory').DataTable().clear().draw();
	$.each(childCategoryList, function(i, childCategoryObj){
		$('#segment01_mw003_dataTable_childCategory').dataTable().fnAddData( 
			[
			 String(i+1),
			 childCategoryObj.name,
			 categoryObj.name,
			 parentCategoryObj.name,
			 '<i class="fa fa-link" aria-hidden="true"></i>'
	        ], false);
	});
	$('#segment01_mw003_dataTable_childCategory').DataTable().draw();
	
	
	if (childCategoryList.length == 0)
	{
		$('#segment01_mw003_table1_title').hide();
		$('#segment01_mw003_table1_content').hide();
	}
	else
	{		
		$('#segment01_mw003_table1_title').show();
		$('#segment01_mw003_table1_content').show();
	}

	// Table 2: Child items
	$('#segment01_mw003_dataTable_childItem').DataTable().clear().draw();
	$.each(childItemList, function(i, childItemObj){
		$('#segment01_mw003_dataTable_childItem').dataTable().fnAddData( 
			[
			 String(i+1),
			 categoryObj.name,
			 childItemObj.name,
			 '<i class="fa fa-trash" aria-hidden="true"></i>'
	        ], false);
	});
	$('#segment01_mw003_dataTable_childItem').DataTable().draw();
	
	if (childItemList.length == 0)
	{
		$('#segment01_mw003_table2_title').hide();
		$('#segment01_mw003_table2_content').hide();
	}
	else
	{		
		$('#segment01_mw003_table2_title').show();
		$('#segment01_mw003_table2_content').show();
	}
	
	// Show Modal Window
	module_showModalWindow('segment01_mw003', true);
} // .end of segment01_mw003_open

function segment01_mw003_execute()
{
	// Set Flag
	segment01_mw003_executed = true;
	// Get category object
	var categoryObj = Cached_getCategoryById(segment01_mw003_categoryId);
	
	// 1. Link child categories to parent category
	var childCategoryList = Cached_getCategoryListByParentId(segment01_mw003_categoryId);
	$.each(childCategoryList, function(i, childCategoryObj){
		childCategoryObj.parentCategoryId = categoryObj.parentCategoryId;
		childCategoryObj.parentCategoryName = categoryObj.parentCategoryName;
	});
	// Save child category list
	tycheesIO_saveBeanList(childCategoryList);
	
	// 2. Remove items under the selected category
	var childItemList = Cached_getItemListByCategoryId(segment01_mw003_categoryId);
	$.each(childItemList, function(i, childItemObj){
		Cached_deleteItemById(childItemObj.id);
		// Delete From localDB
		Cached_deleteBean(childItemObj);
		tycheesIO_saveBean(childItemObj);
	});
	
	// 3. Remove from Cached_categoryList
	var flag = Cached_deleteCategoryById(segment01_mw003_categoryId);
	
	// Remove from local DB
	Cached_deleteBean(categoryObj);
	tycheesIO_saveBean(categoryObj);  
    
	// Show toast message
	tycheesLogger_showToast("success", "Deleted", "Your inventory category has been deleted!"); 
	// Hide Modal Window
	$('#segment01_mw003').modal('hide');	
	// Invoke CallBack function
	segment01_mw003_callbackFn(true, segment01_mw003_callbackFnParams);
} // .end of segment01_mw003_execute

</script>