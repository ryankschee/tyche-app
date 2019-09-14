<style>
    .set001-01-41-component-input {
	    font-size: 10px; 
	    height: 22px;
    }
</style>

<!-- set001_01_41: Document Configuration -->
<div id="set001_01_41" style="display:none; padding-top:10px;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	FLOOR PLAN CONFIGURATION
	</span>
	<div class="ibox-title" style="border:0px;">
    	<!-- Toolbar: BEGIN -->
        <div class="note-toolbar btn-toolbar">
        	<div class="note-font input-group">             	
	            <div>
	                <select id="set001_01_41_layoutList" class="form-control" style="width:350px;" onchange="set001_01_41_layoutChanged();">                	
	                </select>
	            </div>   			
          		<div>
		            <button class="btn btn-white" type="button" onclick="set001_01_41_addLayout();"><i class="fa fa-plus" aria-hidden="true"></i> </button>
		        </div>            			
          		<div>
		            <button class="btn btn-white" type="button" onclick="set001_01_41_editLayout();"><i class="fa fa-pencil" aria-hidden="true"></i> </button>
		        </div>            			
          		<div>
		            <button class="btn btn-white" type="button" onclick="set001_01_41_deleteLayout();"><i class="fa fa-times" aria-hidden="true"></i> </button>
		        </div>            			
          		<div class="input-group-btn" style="padding-left:5px;">
	  				<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" style="margin-right:5px;">
	  					Shape <i class="fa fa-caret-down" aria-hidden="true"></i> 
	  				</button>
				  	<ul class="dropdown-menu" role="menu" style="right:0px; left:auto;">
				    	<li><a href="#" onclick="set001_01_41_addLine();">Add Line</a></li>
				    	<li><a href="#" onclick="set001_01_41_addCircle();">Add Circle</a></li>
				    	<li><a href="#" onclick="set001_01_41_addRectangle();">Add Rectangle</a></li>
				  	</ul>
				</div>
          	</div>
        </div>
    </div> <!-- .end of ibox-title -->
    <div class="row">
	    <div class="col-lg-12" id="set001_01_41_canvas_parent">
	    </div>
    </div>
</div>

<!-- New layout -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_41_mw001.jsp" %>
<!-- Edit Layout -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_41_mw002.jsp" %>
<!-- Edit Shape -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_41_editShape.jsp" %>
<!-- Add Line -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_41_addLine.jsp" %>
<!-- Add Circle -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_41_addCircle.jsp" %>
<!-- Add Rectangle -->
<%@include file="/console/settings/set001/view/set001_01/set001_01_41_addRectangle.jsp" %>

<script>

var set001_01_41_initialized = false;
var set001_01_41_lastClickTime = 0;
var set001_01_41_placeObj;
var set001_01_41_placeLayoutObj;

function set001_01_41_init()
{
    if (set001_01_41_initialized == true)
        return false;
        
	set001_01_41_initialized = true;
} // .end of set001_01_41_init

function set001_01_41_hide()
{
    $('#set001_01_41').hide();
} // .end of set001_01_41_hide

function set001_01_41_updateUI(givenLayoutId)
{
    set001_01_41_init();
    
    // Get Place object
    set001_01_41_placeObj = tycheesCommon_getCurrentPlaceObject();
    // Sort list, by template name
    set001_01_41_placeObj.layoutList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.layoutName, b.layoutName);
		});
    
    // Populate Template List
    $('#set001_01_41_layoutList').empty();
    $('#set001_01_41_layoutList').append('<option value="0">-- SELECT --</option>');
    $.each(set001_01_41_placeObj.layoutList, function(i, layoutObj){
    	
    	var selectedVal = '';
    	if (givenLayoutId==layoutObj.id) {
    		selectedVal = 'selected';
    		set001_01_41_placeLayoutObj = layoutObj;
    	}
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + layoutObj.id + '" ' + selectedVal + '>';
    	htmlLines += layoutObj.layoutName + ' (' + layoutObj.width + 'px X ' + layoutObj.height + 'px)';
    	if (layoutObj.defaultLayout)
    		htmlLines += ' - default';
    	htmlLines += '</option>';
    	
    	$('#set001_01_41_layoutList').append( htmlLines );
    });
    
    // Reload properties based on selected template
    set001_01_41_reloadLayout();
    
    $('#set001_01_41').show();
} // .end of set001_01_41_updateUI

/**
 * Reload properties of document template.
 */
function set001_01_41_reloadLayout()
{
	if (set001_01_41_placeLayoutObj == null)
		return false;
	
	// first we need to create a stage
	var stage = new Konva.Stage({
	    container: 'set001_01_41_canvas_parent',   // id of container <div>
	    width: set001_01_41_placeLayoutObj.width,
	    height: set001_01_41_placeLayoutObj.height
	});
	// then create layer
	var layer = new Konva.Layer();
	
	// Repaint components into canvas
    $.each(set001_01_41_placeLayoutObj.componentList, function(i, componentObj) {
    	
    	if (Cached_isDeletedBean(componentObj))
    		return true;
    	
	    // Add component into Canvas
	    var shape = commonCanvas_settings_drawKonva(layer, componentObj);
	    
	 	// write out drag and drop events
	    shape.on('dragstart', function(e) {
	    	
	    });
	    shape.on('dragend', function(e) {
	    	// Update position
	    	var updated = set001_01_41_updatePosition(componentObj, e.target.attrs.x, e.target.attrs.y);
	    	if (updated) {
	    		set001_01_41_placeLayoutObj.hasChanged = true;
	        	tycheesIO_saveBean( set001_01_41_placeObj );
	    	}
	    });
	    
	    shape.on('mouseenter', function () {
            stage.container().style.cursor = 'move';
        });
	    shape.on('mouseleave', function () {
            stage.container().style.cursor = 'default';
        });
	    
	    shape.on('dblclick', function() {
	    	set001_01_41_editShape_show(set001_01_41_placeLayoutObj, componentObj, set001_01_41_editShape_callbackFn);
	    });

	    shape.on('click', function() {
	    	var doubleClicked = false;
	    	var clickTime = tycheesDateTime_getCurrentTimeInMillis();
	    	
	    	if (set001_01_41_lastClickTime == 0) {
	    		set001_01_41_lastClickTime = clickTime;
	    	} else {
	    		
		    	if (clickTime - set001_01_41_lastClickTime < 500)
		    		doubleClicked = true;
		    	
		    	if (doubleClicked) {
		    		set001_01_41_editShape_show(set001_01_41_placeLayoutObj, componentObj, set001_01_41_editShape_callbackFn);
		    	}
	    	}
	    	
	    	set001_01_41_lastClickTime = clickTime;
	    });
    });
	
	// add the layer to the stage
	stage.add(layer);
	
	$('#set001_01_41_canvas_parent').children().css({'border':'1px solid #d3d3d3'});
} // .end of set001_01_41_reloadLayout

function set001_01_41_editShape_callbackFn()
{
	// Set Flag
	set001_01_41_placeLayoutObj.hasChanged = true;
    // Save into IndexedDB
    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
    // Update UI
	set001_01_41_reloadLayout();
} // .end of set001_01_41_editShape_callbackFn

function set001_01_41_updatePosition(componentObj, offsetX, offsetY)
{
	if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_LINE) {
		
	}
	if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_RECTANGLE) {
		var attributes = JSON.parse(componentObj.attributes);		
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		var posX = curX + offsetX;
		var posY = curY + offsetY;
		
		if (curX == posX && curY == posY)
			return false;
		if (Math.abs(posX) > set001_01_41_placeLayoutObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(posX) + ') is out of bound.');
			return false;
		}
		if (Math.abs(posY) > set001_01_41_placeLayoutObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(posY) + ') is out of bound.');
			return false;
		}		
		
		attributes.x1 = Math.abs(posX);
		attributes.y1 = Math.abs(posY);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}
	if (componentObj.objectType == PlaceConstants.PLACE_LAYOUT_OBJECT_TYPE_CIRCLE) {
		var attributes = JSON.parse(componentObj.attributes);		
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		var posX = curX + offsetX;
		var posY = curY + offsetY;
		
		if (curX == posX && curY == posY)
			return false;
		if (Math.abs(posX) > set001_01_41_placeLayoutObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(posX) + ') is out of bound.');
			return false;
		}
		if (Math.abs(posY) > set001_01_41_placeLayoutObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(posY) + ') is out of bound.');
			return false;
		}		
		
		attributes.x1 = Math.abs(posX);
		attributes.y1 = Math.abs(posY);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}
} // .end of set001_01_41_updatePosition

/**
 * Event listener when selection of document changed.
 */
function set001_01_41_layoutChanged()
{
	var layoutId = $.trim( $('#set001_01_41_layoutList').val() );
	
	if (layoutId=='' || layoutId=='0')
	{
		$('#set001_01_41_accordion').empty();
	}
	else
	{
		// Get Place object
	    var placeObj = tycheesCommon_getCurrentPlaceObject();
	    $.each(placeObj.layoutList, function(i, layoutObj){
	    	
	    	if (layoutId==layoutObj.id) 
	    	{
	    		set001_01_41_placeLayoutObj = layoutObj;
	    		set001_01_41_reloadLayout(true);
	    	}
	    });
	}
} // .end of set001_01_41_documentChanged();

/**
 * Add new template
 */
function set001_01_41_addLayout()
{
	set001_01_41_mw001_show();
} // .end of set001_01_41_addTemplate

/**
 * Edit new template
 */
function set001_01_41_editLayout()
{
	var layoutId = $('#set001_01_41_layoutList').val();
	if (layoutId=='' || layoutId=='0') {
		tycheesLogger_showToast('warning','No layout selected','Please select a layout.');
    	return false;
	}
		
	set001_01_41_mw002_show(layoutId);
} // .end of set001_01_41_editLayout

/**
 * Remove document template.
 */
function set001_01_41_deleteLayout()
{
	var layoutId = $.trim( $('#set001_01_41_layoutList').val() );
	
	if (layoutId=='' || layoutId=='0') {
		tycheesLogger_showToast('warning','No layout selected','Please select a layout.');
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this layout record!",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  confirmButtonText: "Yes, delete it!",
		  cancelButtonText: "No, cancel plx!",
		  closeOnConfirm: true,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  	if (isConfirm) 
		  	{
		  		var placeObj = tycheesCommon_getCurrentPlaceObject();
		  		$.each(placeObj.layoutList, function(i, layoutObj){
		  			if (layoutObj.id == layoutId)
		  			{
		  				Cached_deleteBean(layoutObj);
				  		
				  		// Save to IndexedDB
				    	tycheesIO_saveBean(placeObj);
				  		// Refresh UI
				    	set001_01_41_updateUI();
		  			}
		  		});
		  	}
		});
} // .end of set001_01_41_deleteLayout

function set001_01_41_addLine()
{
	if (set001_01_41_placeLayoutObj == null)
		return false;
		
	set001_01_41_addLine_show(set001_01_41_addLine_callbackFn);
} // .end of set001_01_41_addLine

function set001_01_41_addLine_callbackFn(newComponentObj) 
{
	if (newComponentObj != null) {

		// Assign layout ID
		newComponentObj.layoutId = set001_01_41_placeLayoutObj.id;
		// Add to layout
		set001_01_41_placeLayoutObj.componentList.push(newComponentObj);
		set001_01_41_placeLayoutObj.hasChanged = true;		
	    // Save into IndexedDB
	    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
		// Repaint Canvas UI
		set001_01_41_reloadLayout();
	}
} // .end of set001_01_41_addLine_callbackFn

function set001_01_41_addRectangle()
{
	if (set001_01_41_placeLayoutObj == null)
		return false;
		
	set001_01_41_addRectangle_show(set001_01_41_addRectangle_callbackFn);
} // .end of set001_01_41_addRectangle

function set001_01_41_addRectangle_callbackFn(newComponentObj) 
{
	if (newComponentObj != null) {

		// Assign layout ID
		newComponentObj.layoutId = set001_01_41_placeLayoutObj.id;
		// Add to layout
		set001_01_41_placeLayoutObj.componentList.push(newComponentObj);
		set001_01_41_placeLayoutObj.hasChanged = true;		
	    // Save into IndexedDB
	    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
		// Repaint Canvas UI
		set001_01_41_reloadLayout();
	}
} // .end of set001_01_41_addRectangle_callbackFn

function set001_01_41_addCircle()
{
	if (set001_01_41_placeLayoutObj == null)
		return false;
		
	set001_01_41_addCircle_show(set001_01_41_addCircle_callbackFn);
} // .end of set001_01_41_addCircle

function set001_01_41_addCircle_callbackFn(newComponentObj) 
{
	if (newComponentObj != null) {

		// Assign layout ID
		newComponentObj.layoutId = set001_01_41_placeLayoutObj.id;
		// Add to layout
		set001_01_41_placeLayoutObj.componentList.push(newComponentObj);	
		set001_01_41_placeLayoutObj.hasChanged = true;	
	    // Save into IndexedDB
	    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
		// Repaint Canvas UI
		set001_01_41_reloadLayout();
	}
} // .end of set001_01_41_addCircle_callbackFn

/**
 * Delete individual component, and repaint UI.
 */
function set001_01_41_deleteComponent(componentId)
{
	if (set001_01_41_placeLayoutObj == null)
		return false;
	if ($.trim(componentId) == '')
		return false;
		
	var index = -1;
	$.each(set001_01_41_placeLayoutObj.componentList, function(i, componentObj) {
		if (componentObj.id == componentId)
		{
			Cached_deleteBean(componentObj);
			index = i;
		}
	});
	
	if (index >= 0)
	{
		// Set Flag
		set001_01_41_placeLayoutObj.hasChanged = true;
	    // Save into IndexedDB
	    tycheesIO_saveBean( set001_01_41_placeObj );
	    // Remove from cached object
		set001_01_41_placeLayoutObj.componentList.splice(index, 1);
	    // Repaint Canvas UI
		set001_01_41_reloadLayout(false);
	    // break FOR-LOOP iteration
	    return false;
	}	
} // .end of set001_01_41_deleteComponent

</script>
