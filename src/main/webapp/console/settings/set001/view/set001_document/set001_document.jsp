
<!-- SET001_01: Document Settings -->
<div id="set001_document" style="display:none;">
	<span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	DOCUMENTS
	</span>	
	<div id="set001_document_spinner" class="spiner-example" style="padding-top:0px; height:100%; display:none;">
        <div class="sk-spinner sk-spinner-wave">
            <div class="sk-rect1"></div>
            <div class="sk-rect2"></div>
            <div class="sk-rect3"></div>
            <div class="sk-rect4"></div>
            <div class="sk-rect5"></div>
        </div>
    </div>
	<div id="set001_document_menu" class="ibox-title" style="border:0px;">
    	<!-- Toolbar: BEGIN -->
        <div class="note-toolbar btn-toolbar">
        	<div class="note-font input-group">             	
	            <div>
	                <select id="set001_document_documentList" class="form-control" style="width:350px;" onchange="set001_document_documentChanged();">                	
	                </select>
	            </div>   			
          		<div>
		            <button class="btn btn-primary" type="button" onclick="set001_document_addDocument();" style="margin-left:5px;">
		            	<i class="fa fa-plus" aria-hidden="true"></i> 
		            </button>
		        </div>            			
          		<div>
		            <button class="btn btn-primary" type="button" onclick="set001_document_editDocument();" style="margin-left:5px;">
		            	<i class="fa fa-pencil" aria-hidden="true"></i> 
		            </button>
		        </div>            			
          		<div>
		            <button class="btn btn-info" type="button" onclick="set001_document_cloneDocument();" style="margin-left:5px;">
		            	<i class="fa fa-clone" aria-hidden="true"></i> 
		            </button>
		        </div>            			
          		<div>
		            <button class="btn btn-danger" type="button" onclick="set001_document_deleteDocument();" style="margin-left:5px;">
		            	<i class="fa fa-times" aria-hidden="true"></i> 
		            </button>
		        </div>            			
          		<div class="input-group-btn" style="padding-left:5px;">
	  				<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" style="margin-right:5px;">
	  					Insert <i class="fa fa-caret-down" aria-hidden="true"></i> 
	  				</button>
				  	<ul class="dropdown-menu" role="menu" style="right:0px; left:auto;">
				    	<li><a href="#" onclick="set001_document_addText();">Text</a></li>
				    	<li><a href="#" onclick="set001_document_addLine();">Line</a></li>
				    	<li><a href="#" onclick="set001_document_addBox();">Box</a></li>
				    	<li><a href="#" onclick="set001_document_addDate();">Date</a></li>
				    	<li><a href="#" onclick="set001_document_addImage();">Image</a></li>
				    	<li><a href="#" onclick="set001_document_addPlaceField();">Place Field</a></li>
				    	<li><a href="#" onclick="set001_document_addCustomerField();">Customer Field</a></li>
				    	<li><a href="#" onclick="set001_document_addBillingField();">Billing Field</a></li>
				  	</ul>
				</div>            			
          		<div>
		            <button class="btn btn-info" type="button" onclick="set001_document_preview();">
		            	<i class="fa fa-file-pdf-o" aria-hidden="true"></i> PDF View
		            </button>
		        </div> 
          	</div>
        </div>
    </div> <!-- .end of ibox-title -->
    <div id="set001_document_workspace" class="row" style="background-color:#FFFFFF; margin-left: 0px; margin-right:0px;">    
	    <div class="col-md-3" id="set001_document_componentList" style="display:none;">
	        <ul class="sortable-list connectList agile-list ui-sortable" id="set001_document_componentList_content">
            </ul>
	    </div>
	    <div class="col-md-9" id="set001_document_canvas" style="display:none;">
	    </div>
	    <div class="col-md-9" id="set001_document_canvas_spinner" style="display:none;">
	    	<div class="sk-spinner sk-spinner-wave">
			    <div class="sk-rect1"></div>
			    <div class="sk-rect2"></div>
			    <div class="sk-rect3"></div>
			    <div class="sk-rect4"></div>
			    <div class="sk-rect5"></div>
			</div>
		    <div id="set001_document_canvas_spinner_text" style="padding-top:10px; text-align:center;">loading template...</div>
	    </div>
    </div>
</div>

<!-- New Template -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addTemplate.jsp" %>
<!-- Edit Template -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editTemplate.jsp" %>
<!-- Add Place Field -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addPlaceField.jsp" %>
<!-- Edit Place Field -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editPlaceField.jsp" %>
<!-- Add Customer Field -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addCustomerField.jsp" %>
<!-- Edit Customer Field -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editCustomerField.jsp" %>
<!-- Add Billing Field -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addBillingField.jsp" %>
<!-- Edit Billing Field -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editBillingField.jsp" %>
<!-- Clone Template -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_cloneTemplate.jsp" %>
<!-- Add Shape -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addShape.jsp" %>
<!-- Edit Shape -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editShape.jsp" %>
<!-- Add Date -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addDate.jsp" %>
<!-- Edit Date -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editDate.jsp" %>
<!-- Add Image -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_addImage.jsp" %>
<!-- Edit Image -->
<%@include file="/console/settings/set001/view/set001_document/set001_document_mw_editImage.jsp" %>

<script>

var set001_document_initialized = false;
var set001_document_documentTemplateObj;
var set001_document_lastClickTime = 0;

var set001_document_konvaStageObj;
var set001_document_konvaLayerObj;

function set001_document_init()
{
    if (set001_document_initialized == true)
        return false;
    
	set001_document_initialized = true;
} // .end of set001_document_init

function set001_document_hide()
{
    $('#set001_document').hide();
} // .end of set001_document_hide

function set001_document_show()
{
	set001_document_updateUI();
} // .end of set001_document_hide

function set001_document_updateUI(documentTemplateId)
{
	// Init, if any
    set001_document_init();
	
    $('#set001_document').show();
	$('#set001_document_spinner').show();
	$('#set001_document_menu').hide();
	$('#set001_document_workspace').hide();
	
    // Prepare Ajax
    var requestBody = new Object();
    requestBody.onlyTypeLogo = false;    
    var params = new Object();
    params.documentTemplateId = documentTemplateId;
    
    tycheesdb_api_getPlaceImagesByPlace(requestBody, set001_document_updateUI_postHandler, params); 
	
} // .end of set001_document_updateUI

function set001_document_updateUI_postHandler(success, responseObj, params) 
{
	if (!success) {
		$('#set001_document_spinner').hide();
		swal("Oops", "Something went wrong!", "error");
		return false;
	}

    // Show panel
	$('#set001_document_spinner').hide();
	$('#set001_document_menu').show();
	$('#set001_document_workspace').show();
	
    // Get current place object
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    placeObj.imageList = responseObj.imageList;
    // Sort list, by group name
    placeObj.documentTemplateList.sort(function(a, b){ 
		return tycheesList_sortByString(a.name, b.name);
	});

    $('#set001_document_documentList').empty();
    $('#set001_document_documentList').append('<option value="">-- SELECT TEMPLATE --</option>');
	
    $.each(placeObj.documentTemplateList, function(i, templateObj) {
    	if (Cached_isDeletedBean(templateObj))
    		return true;
    	        	
       	var selectedVal = '';
       	if (params.documentTemplateId == null) {
       		set001_document_updateCanvas(null);
       	} else {
       		if (templateObj.id == params.documentTemplateId) {
       			selectedVal = 'selected';
       			// Set object
       			set001_document_documentTemplateObj = templateObj;
       			// Upate Canvas UI
       			set001_document_updateCanvas(templateObj);
       		}
       	}
       	
       	var htmlLines = '';
       	htmlLines += '<option value="' + templateObj.id + '" ' + selectedVal + '>';
       	htmlLines += templateObj.name;
       	htmlLines += ' (' + templateObj.width + ' x ' + templateObj.height + ')'
       	htmlLines += '</option>';
       	
       	$('#set001_document_documentList').append( htmlLines );
    });
} // .end of set001_document_updateUI_postHandler

function set001_document_updateCanvas(templateObj)
{
	if (templateObj == null) {
		$('#set001_document_canvas').hide();
		$('#set001_document_componentList').hide();
		return false;
	}
	
	// Show Spinner
	$('#set001_document_canvas').hide();
	$('#set001_document_canvas_spinner').show();
	
	var placeObj = tycheesCommon_getCurrentPlaceObject();
	if (placeObj.imageList.length == 0) {
		// Load images
		var requestBody = new Object();
	    requestBody.onlyTypeLogo = true;
	    
	    var params = new Object();
	    params.templateObj = templateObj;
	    
	    tycheesdb_api_getPlaceImagesByPlace(requestBody, set001_document_updateCanvas_afterImagesLoaded, params); 
	} else {
		set001_document_updateCanvas_draw(templateObj);
	}	
	
} // .end of set001_document_updateCanvas

function set001_document_updateCanvas_afterImagesLoaded(success, responseObj, params)
{
	if (!success) {
		tycheesLogger_logError('Ajax Error.', 'set001_document_updateCanvas_afterImagesLoaded');
		return false;
	}

	var placeObj = tycheesCommon_getCurrentPlaceObject();
	placeObj.imageList = responseObj.imageList;
	
	Cached_updatePlace(placeObj);
	
	set001_document_updateCanvas_draw(params.templateObj);
} // .end of set001_document_updateCanvas_afterImagesLoaded

function set001_document_updateCanvas_draw(templateObj)
{
	// first we need to create a stage
	set001_document_konvaStageObj = new Konva.Stage({
	    container: 'set001_document_canvas',   // id of container <div>
	    width: templateObj.width,
	    height: templateObj.height
	});
	// then create layer
	set001_document_konvaLayerObj = new Konva.Layer();

 	// Sorting
 	templateObj.componentList.sort(function(a, b) {
 		if (a.name < b.name) return -1;
		if (a.name > b.name) return 1;
		return 0;
 	});    
	
	// Empty component list
	$('#set001_document_componentList_content').empty();	
	// Repaint components into canvas
    $.each(templateObj.componentList, function(i, componentObj) {
    	
    	if (Cached_isDeletedBean(componentObj))
    		return true;
    	
	    // Add component into Canvas
	    commonCanvas_documents_drawKonva(set001_document_konvaLayerObj, componentObj, set001_document_postDrawingFn);
	    
	    // Add component to sidebar	
	    var htmlLines = '';
	    htmlLines += '<li class="success-element" id="' + componentObj.id + '" style="height:56px;" onclick="set001_document_onComponentClicked(\'' + componentObj.id + '\');">';
	    htmlLines += componentObj.name;
	    htmlLines += '<div class="agile-detail">';
	    htmlLines += '<a href="#" class="pull-right btn btn-xs btn-white">' + componentObj.objectType + '</a>';
	    htmlLines += '</div>';
		htmlLines += '</li>';
		
		$('#set001_document_componentList_content').append(htmlLines);
    });
	
	// add the layer to the stage
	set001_document_konvaStageObj.add(set001_document_konvaLayerObj);
	// Set canvas border
	$('#set001_document_canvas').children().css({'border':'1px solid #d3d3d3'});
	// Show/Hide
	$('#set001_document_canvas').show();
	$('#set001_document_componentList').show();
	$('#set001_document_canvas_spinner').hide();
	
} // .end of set001_document_updateCanvas_draw

function set001_document_onComponentClicked(componentId)
{
	$.each(set001_document_documentTemplateObj.componentList, function(i, componentObj) {
		if (componentObj.id == componentId) {
			if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_IMAGE)
				set001_document_mw_editImage_show(set001_document_documentTemplateObj, componentObj, set001_document_editShape_callbackFn);
			else
			if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_DATE)
				set001_document_mw_editDate_show(set001_document_documentTemplateObj, componentObj, set001_document_editShape_callbackFn);
			else
			if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_PLACE_FIELD)
				set001_document_mw_editPlaceField_show(set001_document_documentTemplateObj, componentObj, set001_document_editShape_callbackFn);
			else
			if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_CUSTOMER_FIELD)
				set001_document_mw_editCustomerField_show(set001_document_documentTemplateObj, componentObj, set001_document_editShape_callbackFn);
			else
			if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BILLING_FIELD)
				set001_document_mw_editBillingField_show(set001_document_documentTemplateObj, componentObj, set001_document_editShape_callbackFn);
			else
				set001_document_mw_editShape_show(set001_document_documentTemplateObj, componentObj, set001_document_editShape_callbackFn);
		}
	});
	
} // .end of set001_document_onComponentClicked

function set001_document_postDrawingFn(componentObj, konvaObj)
{
	if (konvaObj == null) {
    	tycheesLogger_showToast('error', 'Invalid Object Creation', 'Shape object is undefined.');	
    	return true;
    }
    
    // Register for events
    konvaObj.on('dragend', function(e) {
    	// Update position
    	var updated = set001_document_updatePosition(componentObj, e.target.attrs.x, e.target.attrs.y);
    	if (updated) {
    		// Set flag
    		set001_document_documentTemplateObj.hasChanged = true;
    		// Get current place object
    		var placeObj = tycheesCommon_getCurrentPlaceObject();
    	    // Save into IndexedDB
    	    tycheesIO_saveBean( placeObj );
    	}
    });
    
    konvaObj.on('mouseenter', function () {
    	set001_document_konvaStageObj.container().style.cursor = 'move';
    });
    konvaObj.on('mouseleave', function () {
    	set001_document_konvaStageObj.container().style.cursor = 'default';
    });
    /*
    konvaObj.on('dblclick', function() {
    	set001_document_onComponentClicked(componentObj.id);
    });
	*/
	konvaObj.on('click', function() {
    	var doubleClicked = false;
    	var clickTime = tycheesDateTime_getCurrentTimeInMillis();
    	
    	if (set001_document_lastClickTime == 0) {
    		set001_document_lastClickTime = clickTime;
    	} else {
    		
	    	if (clickTime - set001_document_lastClickTime < 500)
	    		doubleClicked = true;
	    	
	    	if (doubleClicked) {
	    		set001_document_onComponentClicked(componentObj.id);
	    	}
    	}
    	
    	set001_document_lastClickTime = clickTime;
    });	
} // .end of set001_document_postDrawingFn

function set001_document_editShape_callbackFn()
{
	// Set Flag
	set001_document_documentTemplateObj.hasChanged = true;
    // Save into IndexedDB
    tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );
    // Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_01_41_editShape_callbackFn

function set001_document_updatePosition(componentObj, x, y)
{
	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT) {
		
		var attributes = JSON.parse(componentObj.attributes);		
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		
		if (curX == x && curY == y)
			return false;
		if (Math.abs(x) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
			return false;
		}
		if (Math.abs(y) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = Math.abs(x);
		attributes.y1 = Math.abs(y);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}
	
	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_LINE) {
		
		var attributes = JSON.parse(componentObj.attributes);		
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		var posX = attributes.x1 + x;
		var posY = attributes.y1 + y;
		
		if (curX == posX && curY == posY)
			return false;
		if (Math.abs(posX) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(posX) + ') is out of bound.');
			return false;
		}
		if (Math.abs(posY) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(posY) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = attributes.x1 + x;
		attributes.y1 = attributes.y1 + y;
		attributes.x2 = attributes.x2 + x;
		attributes.y2 = attributes.y2 + y;

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}
	
	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BOX) {
		
		var attributes = JSON.parse(componentObj.attributes);		
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		
		if (curX == x && curY == y)
			return false;
		if (Math.abs(x) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
			return false;
		}
		if (Math.abs(y) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = Math.abs(x);
		attributes.y1 = Math.abs(y);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}
	
	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_DATE) {
		
		var attributes = JSON.parse(componentObj.attributes);		
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		
		if (curX == x && curY == y)
			return false;
		if (Math.abs(x) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
			return false;
		}
		if (Math.abs(y) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = Math.abs(x);
		attributes.y1 = Math.abs(y);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}

	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_IMAGE) {
		
		var attributes = JSON.parse(componentObj.attributes);	
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		
		if (curX == x && curY == y)
			return false;
		if (Math.abs(x) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
			return false;
		}
		if (Math.abs(y) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = Math.abs(x);
		attributes.y1 = Math.abs(y);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}
	
	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_PLACE_FIELD) {
		
		var attributes = JSON.parse(componentObj.attributes);		
		if (attributes.fieldType == 'place.logo') {
			var curX = Math.abs(attributes.x1);
			var curY = Math.abs(attributes.y1);
			
			if (curX == x && curY == y)
				return false;
			if (Math.abs(x) > set001_document_documentTemplateObj.width) {
				tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
				return false;
			}
			if (Math.abs(y) > set001_document_documentTemplateObj.height) {
				tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
				return false;
			}				
	
			attributes.x1 = Math.abs(x);
			attributes.y1 = Math.abs(y);
	
			componentObj.attributes = JSON.stringify(attributes);
			return true;
		} else {
			var curX = Math.abs(attributes.x1);
			var curY = Math.abs(attributes.y1);
			
			if (curX == x && curY == y)
				return false;
			if (Math.abs(x) > set001_document_documentTemplateObj.width) {
				tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
				return false;
			}
			if (Math.abs(y) > set001_document_documentTemplateObj.height) {
				tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
				return false;
			}				
	
			attributes.x1 = Math.abs(x);
			attributes.y1 = Math.abs(y);
	
			componentObj.attributes = JSON.stringify(attributes);
			return true;
		}
	}
	
	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_CUSTOMER_FIELD) {
		
		var attributes = JSON.parse(componentObj.attributes);
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		
		if (curX == x && curY == y)
			return false;
		if (Math.abs(x) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
			return false;
		}
		if (Math.abs(y) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = Math.abs(x);
		attributes.y1 = Math.abs(y);

		componentObj.attributes = JSON.stringify(attributes);
		return true;
	}

	if (componentObj.objectType == DocumentConstants.COMPONENT_OBJECT_TYPE_BILLING_FIELD) {
		
		var attributes = JSON.parse(componentObj.attributes);
		var curX = Math.abs(attributes.x1);
		var curY = Math.abs(attributes.y1);
		
		if (curX == x && curY == y)
			return false;
		if (Math.abs(x) > set001_document_documentTemplateObj.width) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position X (' + Math.abs(x) + ') is out of bound.');
			return false;
		}
		if (Math.abs(y) > set001_document_documentTemplateObj.height) {
			tycheesLogger_showToast('error', 'Invalid Position', 'Position Y (' + Math.abs(y) + ') is out of bound.');
			return false;
		}				

		attributes.x1 = Math.abs(x);
		attributes.y1 = Math.abs(y);

		componentObj.attributes = JSON.stringify(attributes);
		return true;		
	}
} // .end of set001_document_updatePosition

function set001_document_documentChanged() 
{
	var selectedTemplateId = $.trim( $('#set001_document_documentList').val() );
	
	if (selectedTemplateId == '') {
		set001_document_updateCanvas(null);
	} else {
		var placeObj = tycheesCommon_getCurrentPlaceObject();
		$.each(placeObj.documentTemplateList, function(i, templateObj) {
			if (templateObj.id == selectedTemplateId) {
				set001_document_documentTemplateObj = templateObj;
				set001_document_updateCanvas(templateObj);				
				return false;
			}
		});
	}
} // .end of set001_document_documentChanged

function set001_document_addDocument()
{
	set001_document_mw_addTemplate_show();
} // .end of set001_document_addDocument

function set001_document_editDocument()
{
	var selectedTemplateId = $.trim( $('#set001_document_documentList').val() );
	
	if (selectedTemplateId != '') {
		set001_document_mw_editTemplate_show(selectedTemplateId);
	}
} // .end of set001_document_editDocument

function set001_document_cloneDocument()
{
	var selectedTemplateId = $.trim( $('#set001_document_documentList').val() );
	
	if (selectedTemplateId != '') {
		set001_document_mw_cloneTemplate_show(selectedTemplateId);
	}
} // .end of set001_document_cloneDocument

function set001_document_saveDocument()
{
	
} // .end of set001_document_saveDocument

function set001_document_deleteDocument()
{
	var selectedTemplateId = $.trim( $('#set001_document_documentList').val() );
	
	if (selectedTemplateId=='' || selectedTemplateId=='0') {
		tycheesLogger_showToast('warning','No template selected','Please select a template.');
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this template record!",
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
		  		$.each(placeObj.documentTemplateList, function(i, templateObj){
		  			if (templateObj.id == selectedTemplateId)
		  			{
		  				Cached_deleteBean(templateObj);				  		
				  		// Save to IndexedDB
				    	tycheesIO_saveBean(placeObj);
				  		// Refresh UI
				    	set001_document_updateUI();
				  		// Update Canvas
				    	set001_document_updateCanvas(null);
		  			}
		  		});
		  	}
		});
} // .end of set001_document_deleteDocument

function set001_document_preview()
{
	// Get pdf object
	documentProcessor_preview(
			set001_document_preview_callback, 
			set001_document_documentTemplateObj);	
} // .end of set001_document_preview

function set001_document_preview_callback(pdfDoc)
{
	// Call PDF preview pane
	if (tycheesCommon_isMobileDevice())
		pdfDoc.output('dataurlnewwindow');
	else
		mw_pdfPreview_show(pdfDoc.output('datauri'));		
} // .end of set001_document_preview_callback

function set001_document_addText()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}
	
	// Show modal window (Add new text)
	set001_document_mw_addShape_show(
		set001_document_documentTemplateObj, 
		DocumentConstants.COMPONENT_OBJECT_TYPE_TEXT,
		set001_document_addShape_callbackFn);
} // .end of set001_document_addText

function set001_document_addLine()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.');
		return false;
	}

	// Show modal window (Add new text)
	set001_document_mw_addShape_show(
		set001_document_documentTemplateObj, 
		DocumentConstants.COMPONENT_OBJECT_TYPE_LINE,
		set001_document_addShape_callbackFn);
} // .end of set001_document_addLine

function set001_document_addBox()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}

	// Show modal window (Add new text)
	set001_document_mw_addShape_show(
		set001_document_documentTemplateObj, 
		DocumentConstants.COMPONENT_OBJECT_TYPE_BOX,
		set001_document_addShape_callbackFn);
} // .end of set001_document_addBox

function set001_document_addShape_callbackFn(componentObj) 
{
	if (componentObj == null) {
		tycheesLogger_showToast('error', 'No component found', 'Please report this error to our technical team. Thanks!');
		return false;
	}	

	// Push newly created component into list.
	set001_document_documentTemplateObj.componentList.push(componentObj);
	// Get current place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
	// Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_document_addShape_callbackFn

function set001_document_addDate()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}
	
	// Show modal window (Add new text)
	set001_document_mw_addDate_show(
		set001_document_documentTemplateObj, 
		DocumentConstants.COMPONENT_OBJECT_TYPE_DATE,
		set001_document_addDate_callbackFn);
} // .end of set001_document_addDate

function set001_document_addDate_callbackFn(componentObj) 
{
	if (componentObj == null) {
		tycheesLogger_showToast('error', 'No component found', 'Please report this error to our technical team. Thanks!');
		return false;
	}	

	// Push newly created component into list.
	set001_document_documentTemplateObj.componentList.push(componentObj);
	// Get current place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
	// Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_document_addDate_callbackFn

function set001_document_addPlaceField()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}
	
	set001_document_mw_addPlaceField_show(set001_document_addPlaceField_saveCallbackFn);
} // .end of set001_document_addPlaceObject

function set001_document_addPlaceField_saveCallbackFn(componentObj)
{
	// Set template id	
	componentObj.placeDocumentTemplateId = set001_document_documentTemplateObj.id;
	// Add component into list
	set001_document_documentTemplateObj.componentList.push(componentObj);	
	// Get current place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
	// Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_document_addPlaceField_saveCallbackFn

function set001_document_addCustomerField()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}
	
	set001_document_mw_addCustomerField_show(set001_document_addCustomerField_saveCallbackFn);
} // .end of set001_document_addCustomerField

function set001_document_addCustomerField_saveCallbackFn(componentObj)
{
	// Set template id	
	componentObj.placeDocumentTemplateId = set001_document_documentTemplateObj.id;
	// Add component into list
	set001_document_documentTemplateObj.componentList.push(componentObj);	
	// Get current place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
	// Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_document_addCustomerField_saveCallbackFn

function set001_document_addBillingField()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}
	
	set001_document_mw_addBillingField_show(set001_document_addBillingField_saveCallbackFn);
} // .end of set001_document_addBillingField

function set001_document_addBillingField_saveCallbackFn(componentObj)
{
	// Set template id	
	componentObj.placeDocumentTemplateId = set001_document_documentTemplateObj.id;
	// Add component into list
	set001_document_documentTemplateObj.componentList.push(componentObj);	
	// Get current place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
	// Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_document_addBillingField_saveCallbackFn

function set001_document_addImage()
{
	if (set001_document_documentTemplateObj == null) {
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a document template.')
		return false;
	}
	
	set001_document_mw_addImage_show(set001_document_addImage_saveCallbackFn);
} // .end of set001_document_addImage

function set001_document_addImage_saveCallbackFn(componentObj)
{
	// Set template id	
	componentObj.placeDocumentTemplateId = set001_document_documentTemplateObj.id;
	// Add component into list
	set001_document_documentTemplateObj.componentList.push(componentObj);	
	// Get current place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
	// Update UI
	set001_document_updateCanvas(set001_document_documentTemplateObj);
} // .end of set001_document_addImage_saveCallbackFn

</script>