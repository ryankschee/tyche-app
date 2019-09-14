<!-- Modal Window: Delete Category Field -->
<div class="modal inmodal fade" id="segment01_mw103" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">DELETE CATEGORY FIELD CONFIRMATION</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
                <div class="form-group">
                	<input type='checkbox' id='segment01_mw103_applyToChild' class="i-checks" /> 
					<label for='segment01_mw103_applyToSubCategories'>Delete Child Categories and Items</label>	
					
					<input type="hidden" id="segment01_mw103_categoryId" value="" />
					<input type="hidden" id="segment01_mw103_propId" value="" />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i> Close</button>
                <button type="button" class="btn btn-primary" onclick="segment01_mw103_delete();"><i class="fa fa-floppy-o" aria-hidden="true"></i> Delete Field</button>
            </div>
        </div>
    </div>
</div>

<script>

var segment01_mw103_callbackFn;
var segment01_mw103_callbackFnParams;

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment01_mw103_isOpen()
{
	return ($("#segment01_mw103").data('bs.modal') || {}).isShown;	
} // .end of segment01_mw103_isOpen

function segment01_mw103_init(categoryId, propId)
{
	$('#segment01_mw103_applyToChild').iCheck('uncheck');
	
	$('#segment01_mw103_categoryId').val(categoryId);
	$('#segment01_mw103_propId').val(propId);
} // .end of segment01_mw103_init

function segment01_mw103_open(postHandlerFn, postHandlerFnParams)
{
	// Set callback 
	segment01_mw103_callbackFn = postHandlerFn;
	segment01_mw103_callbackFnParams = postHandlerFnParams;

	segment01_mw103_init(segment01_mw103_callbackFnParams.categoryObj.id, segment01_mw103_callbackFnParams.propObj.id);
	
	module_showModalWindow('segment01_mw103', false);
	//$('#segment01_mw103').modal({backdrop: 'static', keyboard: false});
} // .end of segment01_mw103_open

/**
 * Triggered by: button 'Add Field' (main screen) was clicked.
 * Action: open Modal Window.
 */ 
function segment01_mw103_delete() 
{
	tycheesOverlay_startShortProgress('Deleting...');
	
	// Get Value
	var categoryId = $('#segment01_mw103_categoryId').val();
	var propId = $('#segment01_mw103_propId').val();
	var propKey = '';
	var applyToChild = $('#segment01_mw103_applyToChild').is(":checked");
	
	// 1. Remove field from current category.
	var categoryObj = segment01_mw103_callbackFnParams.categoryObj;
	var propObj = segment01_mw103_callbackFnParams.propObj;
	
	// Set delete flag
	Cached_deleteBean(propObj);
	// Update to IDB
	tycheesIO_saveBean(categoryObj);
	// Hide Modal Window
	$('#segment01_mw103').modal('hide');	
	// Callback
	segment01_mw103_callbackFn(true, segment01_mw103_callbackFnParams);
} // .end of segment01_mw001_addField


/**
 * Recursive function, to delete field (match root_propKey) from child category
 * and their containing items.
 */ 
function segment01_mw103_recursive_removeField(categoryId, root_propId, root_propKey)
{
	var childCategoryList = Cached_getCategoryListByParentId(categoryId);
	
	$.each(childCategoryList, function(i, childCategoryObj){
		
		// Remove field from child category
		$.each(childCategoryObj.propertiesList, function(j, propObj){
			if (propObj.propKey == root_propKey)
			{			
				Cached_deleteBean(propObj);
				
				// Save to localDB
        		tycheesIO_saveBean(childCategoryObj);
				// Update UI - segment 01
				segment01_updateUI_categoryProperties(categoryId);
				
        		return false;
			}
		});
		
		// Remove field from child items
		var childItemList = Cached_getItemListByCategoryId(categoryId);
		$.each(childItemList, function(j, childItemObj){
			
			// Remove field from child category
			$.each(childItemObj.propertiesList, function(k, propObj){
				if (propObj.propKey == root_propKey)
				{		
					Cached_deleteBean(propObj);
					
					// Save to localDB
	        		tycheesIO_saveBean(childItemObj);
					
	        		return false;
				}
			});
		});
		
		// Recursive call
		segment01_mw103_recursive_removeField(childCategoryObj.id, root_propId, root_propKey);
	});
} // .end of segment01_mw103_recursive_removeField

</script>