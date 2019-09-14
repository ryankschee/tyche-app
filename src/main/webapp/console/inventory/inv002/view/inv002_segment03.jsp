
<style>
	/* iPad/iPad Air */
    @media only screen and (max-width: 768px) {
    	#inv002_segment03 {
	        background-color: #fff;
	        border-left: 1px solid #e7eaec;
	        border-top: 1px solid #e7eaec;
	        overflow: hidden;
	        position: fixed;
	        top: 60px;
	        width: 60% !important;
	        z-index: 1009;
	        bottom: 0;
	        right: -60%;
	    }
	    #inv002_segment03.sidebar-open {
	        right: 0;
	    }
	    #inv002_segment03.sidebar-open.sidebar-top {
	        top: 0;
	        border-top: none;
	    }
	   	.grid-item { 
	   		width: 180px; 
	   	}
		.grid-item--width2 { 
			width: 360px; 
		}
    }
    
    /* Medium/Large Monitor  */
    @media only screen and (min-width: 769px) {	    
	    #inv002_segment03 {
	        background-color: #fff;
	        border-left: 1px solid #e7eaec;
	        border-top: 1px solid #e7eaec;
	        overflow: hidden;
	        position: fixed;
	        top: 60px;
	        width: 50% !important;
	        z-index: 1009;
	        bottom: 0;
	        right: -50%;
	    }
	    #inv002_segment03.sidebar-open {
	        right: 0;
	    }
	    #inv002_segment03.sidebar-open.sidebar-top {
	        top: 0;
	        border-top: none;
	    }
	   	.grid-item { 
	   		width: 180px; 
	   	}
		.grid-item--width2 { 
			width: 360px; 
		}
    }
</style>

<div id="inv002_segment03">
    <div class="sidebar-container">
        <div class="sidebar-title" style="padding:5px 10px; background-color:#404040; color:#FFF; height:48px;">
            <span id="segment03_itemNameElement" style="display:none;"> 
                <i class="fa fa-archive fa-2x" aria-hidden="true" style="color:#FFF; margin:5px 5px;"></i> 
                <span id="segment03_itemName" style="padding-left:5px; color:#f8ac59; font-size:18pt;">ITEM NAME</span>
                <i id="segment03_slideInButton" class="fa fa-chevron-circle-right fa-2x pull-right" aria-hidden="true" style="color:#FFFFFF; cursor:pointer; margin:5px 5px;" onclick="segment03_slideIn();"></i>
                <i id="segment03_saveButton" class="fa fa-floppy-o fa-2x pull-right ladda-button" data-style="zoom-in" aria-hidden="true" style="color:#1AB394; cursor:pointer; margin:5px 5px;" onclick="segment03_saveItem();"></i>
            </span>
            <div id="segment03_itemNameElement_spinner" class="spiner-example" style="display:none; padding:0px; height:28px;">
				<div class="sk-spinner sk-spinner-wave">
				    <div class="sk-rect1"></div>
				    <div class="sk-rect2"></div>
				    <div class="sk-rect3"></div>
				    <div class="sk-rect4"></div>
				    <div class="sk-rect5"></div>
				</div>
			</div>
        </div>
        
        <ul id="segment03_tabHeaderElement" class="nav nav-tabs navs-5">
            <li class="active" id="inv003_segment03_tabHeader1">
                <a data-toggle="tab" href="#tab-1">
                    BASIC
                </a>
            </li>
            <li id="inv003_segment03_tabHeader2" onclick="segment03_updateUI_tab2_onclick();">
                <a data-toggle="tab" href="#tab-2">
                    ADDITIONAL
                </a>
            </li>
            <li id="inv003_segment03_tabHeader3">
                <a data-toggle="tab" href="#tab-3">
                    COMPONENTS
                </a>
            </li>
            <li id="inv003_segment03_tabHeader4">
                <a data-toggle="tab" href="#tab-4">
                    ACCESS
                </a>
            </li>
            <li id="inv003_segment03_tabHeader5">
                <a data-toggle="tab" href="#tab-5">
                    IMAGES <span id='inv003_segment03_tabHeader5_imageCount'></span>
                </a>
            </li>
        </ul>
        
        <div id="segment03_tabContentElement" class="tab-content">        	
            <div id="tab-1" class="tab-pane active"> 
                <div id="segment03_tab1_status" style="display:none; color:red;">
                    <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
	            	<span id='segment03_tab1_status_list'>
            	    	Status Messages
            		</span>
           		</div>
                <div class="setings-item" style="height:70px; padding: 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    ITEM NAME <span class="mandatory-field">*</span>
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control tab1-input" id="segment03_itemNameField" name="Item Name" placeholder="Item Name" maxlength="90" required oninput="segment03_onItemChanged();">						
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding: 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    SKU CODE
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control tab1-input" id="segment03_itemSkuCodeField" name="SKU Code" placeholder="SKU Code" maxlength="90" oninput="segment03_onItemChanged();">
					</div>
	            </div>          
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    ITEM TYPE
					    </span>
					</div>
					<div class="col-md-12">
						<input type="text" class="form-control tab1-input" id="segment03_itemTypeField" name="Item Type" placeholder="Item Type" maxlength="90" disabled>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    CATEGORY
					    </span>
					</div>
					<div class="col-md-12">
						<input type="text" class="form-control tab1-input" id="segment03_categoryNameField" name="Category Name" placeholder="Category Name" maxlength="90" disabled>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding: 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    ITEM GROUP
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control tab1-input" id="segment03_itemGroupField" name="Item Group" placeholder="Item Group" maxlength="90" oninput="segment03_onItemChanged();">
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    AVAILABILITY
					    </span>
					</div>
					<div class="col-md-12">
						<input type="text" class="form-control tab1-input" id="segment03_availabilityField" name="Availability" placeholder="Availability" maxlength="90" disabled>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    KEYWORDS
					    </span>
					</div>
					<div class="col-md-12">
						<input type="text" class="form-control tab1-input" id="segment03_keywordsField" name="Keywords" placeholder="Keywords" data-role="tagsinput" oninput="segment03_onItemChanged();">
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding: 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    DESCRIPTION
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control tab1-input" id="segment03_itemDescriptionField" name="Description" placeholder="Description" oninput="segment03_onItemChanged();">
					</div>
	            </div>
            </div>

            <div id="tab-2" class="tab-pane">
                <div id="segment03_tab2_status" style="display:none; color:red;">
                    <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
	            	<span id='segment03_tab2_status_list'>
            	    	Status Messages
            		</span>
           		</div>
                <div id="segment03_tab2_additional_part1">
                    <div class="setings-item non-tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
						    <span style="font-weight:bold;">
							    MEASUREMENT UNIT
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
							<input type="text" class="form-control tab2-input" id="segment03_additional_measurementUnit" name="Measurement Unit" placeholder="Measurement Unit" maxlength="90" oninput="segment03_onItemChanged();">							
						</div>
		            </div>
		            <div class="setings-item non-tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
						    <span style="font-weight:bold;">
							    UNIT COST <span class="mandatory-field">*</span>
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
							<span class="input-group-addon currency-unit">$</span>
							<input type="number" class="form-control tab2-input" id="segment03_additional_unitCost" name="Unit Cost" pattern="[0-9]+([\.,][0-9]+)?" step="0.01" required oninput="segment03_onItemChanged();">
						</div>
		            </div>
		            <div class="setings-item non-tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
						    <span style="font-weight:bold;">
							    UNIT PRICE <span class="mandatory-field">*</span>
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
						    <span class="input-group-addon currency-unit">$</span>
							<input type="number" class="form-control tab2-input" id="segment03_additional_unitPrice" name="Unit Price" pattern="[0-9]+([\.,][0-9]+)?" step="0.01" required oninput="segment03_onItemChanged();">
						</div>
		            </div>
                    <div class="setings-item non-tax-discount" style="padding-left: 36px; padding-right: 36px;">
	                    <span style="font-weight:bold;">
	                        IS QUANTITY OPTIONAL?
	                    </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="segment03_additional_quantityOptional" onchange="segment03_onItemChanged();">
                                <label class="onoffswitch-label" for="segment03_additional_quantityOptional">
                                    <span class="onoffswitch-inner"></span>
                                    <span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
		            <div class="setings-item non-tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
						    <span style="font-weight:bold;">
							    QUANTITY
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
							<span class="input-group-btn">
								<button type="button" class="btn btn-primary" onclick="segment03_adjustQuantity();">
									<i class="fa fa-pencil" aria-hidden="true"></i>
								</button>
							</span>
							<input type="text" class="form-control tab2-input" id="segment03_additional_quantity" name="Quantity" disabled>
							<span class="input-group-addon measurement-unit">Unit</span>
						</div>
		            </div>
		            <div class="setings-item non-tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
						    <span style="font-weight:bold;">
							    MINIMUM QUANTITY
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
							<input type="number" class="form-control tab2-input" id="segment03_additional_minimumQuantity" name="Minimum Quantity" pattern="[0-9]+([\.,][0-9]+)?" step="0.01" oninput="segment03_onItemChanged();">
							<span class="input-group-addon measurement-unit">Unit</span>
						</div>
		            </div>
                    <div class="setings-item tax" style="padding-left: 36px; padding-right: 36px;">
	                    <span style="font-weight:bold;">
	                        IS INCLUSIVE TAX?
	                    </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="segment03_additional_taxInclusive">
                                <label class="onoffswitch-label" for="segment03_additional_taxInclusive">
                                    <span class="onoffswitch-inner"></span>
                                    <span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12 input-group m-b" style="padding-top:5px; padding-left:0px; margin-bottom:0px;">		            
						    <span style="font-weight:bold;">
							    PERCENTAGE (%)
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
							<input type="number" class="form-control tab2-input" id="segment03_additional_taxDiscountPercentage" name="Percentage" pattern="[0-9]+([\.,][0-9]+)?" step="0.01" oninput="segment03_onItemChanged();">
							<span class="input-group-addon">%</span>
						</div>
		            </div>
                    <div class="setings-item tax-discount" style="height:70px; padding:0px 35px 0px 35px;">
	                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
						    <span style="font-weight:bold;">
							    AMOUNT
						    </span>
						</div>
						<div class="col-md-12 input-group m-b">
							<span class="input-group-addon currency-unit">$</span>
							<input type="number" class="form-control tab2-input" id="segment03_additional_taxDiscountAmount" name="Amount" pattern="[0-9]+([\.,][0-9]+)?" step="0.01" oninput="segment03_onItemChanged();">
						</div>
		            </div>
                </div>
                <div id="segment03_tab2_additional_part2">
                </div>
            </div>

            <div id="tab-3" class="tab-pane">
                <div id="segment03_tab3_status" style="display:none; color:red;">
                    <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
	            	<span id='segment03_tab3_status_list'>
            	    	Status Messages
            		</span>
           		</div>
                <div class="panel-body">   
                    <div class="row" style="padding-left:15px; padding-right:15px;">
                		<div class="well" id="segment03_tab3_mandatory" style="display:inherit;padding-bottom:28px;">
                			<span style="font-weight:bold;padding-left:5px;">Mandatory Components</span>
                			<div class="ui-sortable item-component-sortable" id="segment03_tab3_mandatory_sortable" style="margin-top:5px;">
                			</div>
                			<div style="padding-top:5px;">
                				<a href="#" class="pull-right btn btn-xs btn-white" onclick="segment03_onclick_addComponent(true);"> 
                					<i class="fa fa-plus" aria-hidden="true"></i> Add Mandatory Component...
                				</a>
                			</div>
                		</div>
                		<div class="well" id="segment03_tab3_optional" style="display:inherit;padding-bottom:28px;">
                			<span style="font-weight:bold;padding-left:5px;">Optional Components</span>
                			<div class="ui-sortable item-component-sortable" id="segment03_tab3_optional_sortable" style="margin-top:5px;">
                			</div>
                			<div style="padding-top:5px;">
                				<a href="#" class="pull-right btn btn-xs btn-white" onclick="segment03_onclick_addComponent(false);"> 
                					<i class="fa fa-plus" aria-hidden="true"></i> Add Optional Component...
                				</a>
                			</div>
                		</div>
                    </div>
                </div>
            </div>

            <div id="tab-4" class="tab-pane">
                <div id="segment03_tab4_status" style="display:none; color:red;">
                    <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
	            	<span id='segment03_tab4_status_list'>
            	    	Status Messages
            		</span>
           		</div>
                <div id="segment03_tab4_accessibility">
                	<div class="setings-item" style="padding-left:36px; padding-right:36px;">
	                    <span style="font-weight:bold;">
	                        POS Visible?
	                    </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="segment03_accessibility_posVisible">
                                <label class="onoffswitch-label" for="segment03_accessibility_posVisible">
                                    <span class="onoffswitch-inner"></span>
                                    <span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item" style="padding-left:36px; padding-right:36px;">
	                    <span style="font-weight:bold;">
	                        PWS Visible?
	                    </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="segment03_accessibility_pwsVisible">
                                <label class="onoffswitch-label" for="segment03_accessibility_pwsVisible">
                                    <span class="onoffswitch-inner"></span>
                                    <span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item" style="padding-left:36px; padding-right:36px;">
	                    <span style="font-weight:bold;">
	                        SCM Visible?
	                    </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="segment03_accessibility_scmVisible">
                                <label class="onoffswitch-label" for="segment03_accessibility_scmVisible">
                                    <span class="onoffswitch-inner"></span>
                                    <span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="sidebar-content">
                </div>
            </div>
            
            <div id="tab-5" class="tab-pane">
                <div id="segment03_tab5_status" style="display:none; color:red;">
                    <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
	            	<span id='segment03_tab5_status_list'>
            	    	Status Messages
            		</span>
           		</div>
                <div id="segment03_tab5_images">
                	<div class="setings-item" style="padding-left:36px; padding-right:36px; padding-top:6px; height:42px;">
	                    <div id="segment03_fileUpload_spinner" class="col-md-10 spiner-example" style="padding-top:0px; height:100%; display:none;">
		                    <div class="sk-spinner sk-spinner-wave">
		                        <div class="sk-rect1"></div>
		                        <div class="sk-rect2"></div>
		                        <div class="sk-rect3"></div>
		                        <div class="sk-rect4"></div>
		                        <div class="sk-rect5"></div>
		                    </div>
		                </div>
                		<div class="pull-right">
                			<button id="segment03_tab5_images_loadImages" class="ladda-button btn btn-sm btn-primary" type="button" data-style="expand-right" onclick="segment03_updateUI_tab5_images();">
            	    			<i class="fa fa-cloud-download" aria-hidden="true"></i> Load Images
            				</button>
                            <button class="btn btn-sm btn-primary" type="button" onclick="segment03_selectFiles();">
            	    			<i class="fa fa-upload" aria-hidden="true"></i> Upload
            				</button>
            				<input type="file" id="segment03_fileUpload" multiple style="display:none;">
                        </div>
                    </div>
                    <div id="segment03_gridTable" class="grid" style="padding:10px 10px;">
        			</div>
                </div>
            </div>
        </div>
    </div>

</div>


<!-- MODAL WINDOW: Upload Image -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw001.jsp" %>
<!-- MODAL WINDOW: Edit Component -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw003.jsp" %>
<!-- MODAL WINDOW: Image Editor -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw004.jsp" %>
<!-- MODAL WINDOW: New Optional Component -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw005.jsp" %>
<!-- MODAL WINDOW: New Mandatory Component -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw006.jsp" %>
<!-- MODAL WINDOW: Edit Optional Component -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw007.jsp" %>
<!-- MODAL WINDOW: Edit Mandatory Component -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw008.jsp" %>  
<!-- MODAL WINDOW: Preview upload images -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw009.jsp" %>   
<!-- MODAL WINDOW: Image editor -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw010.jsp" %>   
<!-- MODAL WINDOW: Image editor -->
<%@include file="/console/inventory/inv002/view/inv002_segment03_mw_adjustQuantity.jsp" %>   

<script>

var segment03_masonry;
var segment03_initialized = false;
var segment03_itemObj;
var segment03_categoryObj;
var segment03_isUpdatingUI = false;

var segment03_selectedFiles;
var segment03_fileProcessCount = 0;
var segment03_imageFileList = [];

var segment03_unsavedChanges = false;

function segment03_init()
{
	if (segment03_initialized)
		return false;
	
    $('#segment03_fileUpload').on('change', function () {
		segment03_uploadImage();
    });            

    segment03_masonry = $('#segment03_gridTable').masonry({
   	    // options
   	    itemSelector: '.grid-item',
   	    columnWidth: 180,
		isAnimated: true,
   	    gutter: 10
   	});
    
    segment03_masonry.imagesLoaded()
	    .always(function(instance) {
			console.log('all images loaded');		
			segment03_masonry.masonry('reloadItems');
			segment03_masonry.masonry('layout');		
		})
		.done(function(instance) {
			console.log('all images successfully loaded');
			segment03_masonry.masonry('reloadItems');
			segment03_masonry.masonry('layout');
		})
		.fail(function() {
			//console.log('all images loaded, at least one is broken');
		})
		.progress(function(instance, image) {
			console.log('all images loading');	
			segment03_masonry.masonry('reloadItems');
			segment03_masonry.masonry('layout');
		});
    
    segment03_initialized = true;
} // .end of segment03_init

function segment03_updateUI(itemId) {
	segment03_slideOut();
	segment03_showSpinner(true);
	
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_INVENTORY,
			'itemId': itemId,
			'loadImages': false, 
			'fullBean': true
		};
	
	var params = new Object();
	params.itemId = itemId;
	
	tycheesdb_api_getItemById(requestBody, segment03_updateUI_postHandler, params);
} // .end of segment03_updateUI

function segment03_updateUI_postHandler(success, responseObj, params)
{
	if (!success)
		return false;
	
	segment03_isUpdatingUI = true;
	// Reset unsaved status
	segment03_triggerSavingNotification(false);

	segment03_init();
	
	// Reset to initial state
	$("#segment03_tab1_status_list").empty();
 	$("#segment03_tab1_status").hide();
 	$("#segment03_tab2_status_list").empty();
 	$("#segment03_tab2_status").hide();
 	$("#segment03_tab3_status_list").empty();
 	$("#segment03_tab3_status").hide();
 	$("#segment03_tab4_status_list").empty();
 	$("#segment03_tab4_status").hide();
 	$("#segment03_tab5_status_list").empty();
 	$("#segment03_tab5_status").hide();
 	
	segment03_itemObj = responseObj.itemObj;
	segment03_categoryObj = Cached_getCategoryById( segment03_itemObj.categoryId );
	
	$('#segment03_itemName').html( segment03_itemObj.name );
	$('#inv003_segment03_tabHeader5_imageCount').html( '(' + segment03_itemObj.imageCount + ')' );
	
	$('#inv003_segment03_tabHeader1').addClass('active');
	$('#inv003_segment03_tabHeader2').removeClass('active');
	$('#inv003_segment03_tabHeader3').removeClass('active');
	$('#inv003_segment03_tabHeader4').removeClass('active');
	$('#inv003_segment03_tabHeader5').removeClass('active');
	$('#tab-1').addClass('active');
	$('#tab-2').removeClass('active');
	$('#tab-3').removeClass('active');
	$('#tab-4').removeClass('active');
	$('#tab-5').removeClass('active');
	
	segment03_updateUI_tab1();
	segment03_updateUI_tab2();
	segment03_updateUI_tab3();
	segment03_updateUI_tab4();
	//segment03_updateUI_tab5();
	$('#segment03_gridTable').empty();

    // Display Units
    var currencyObj = Cached_getSettingsByKey(SettingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY);    
    $('.measurement-unit').html( segment03_itemObj.measurementUnit );
    $('.currency-unit').html( currencyObj.propValue );
    
	segment03_isUpdatingUI = false;
	// Show content / Hide Spinner
	segment03_showSpinner(false);
} // .end of segment03_updateUI_postHandler

function segment03_updateUI_tab1()
{
    // Set Fields
	$('#segment03_itemNameField').val( $.trim(segment03_itemObj.name) );
	$('#segment03_itemSkuCodeField').val( $.trim(segment03_itemObj.skuCode) );
	$('#segment03_itemTypeField').val( $.trim(segment03_itemObj.itemType) );
	$('#segment03_categoryNameField').val( $.trim(segment03_categoryObj.name) );
	$("#segment03_itemGroupField").val( $.trim(segment03_itemObj.groupName) );
	$("#segment03_itemDescriptionField").val( $.trim(segment03_itemObj.remarks) );
	$("#segment03_availabilityField").val( inventoryUtil_getAvailabilityDescription(segment03_itemObj.availability) );  
	$("#segment03_availabilityField").attr('style', inventoryUtil_getAvailabilityCSS(segment03_itemObj.availability) );

	$("#segment03_keywordsField").tagsinput('removeAll');
	var labelList = segment03_itemObj.labels.split(',');
	$.each(labelList, function(i, labelStr) {
		if ($.trim(labelStr).length > 0)
		{
			$("#segment03_keywordsField").tagsinput("add", labelStr);
		}
  	});

	$('#segment03_keywordsField').on('itemAdded', function(event) {
		segment03_onItemChanged();
	});
	$('#segment03_keywordsField').on('itemRemoved', function(event) {
		segment03_onItemChanged();
	});
} // .end of segment03_updateUI_tab1

function segment03_updateUI_tab2()
{
	// Reset
	$('.non-tax-discount').hide();
	$('.tax-discount').hide();
	$('.tax').hide();
	
	// Part 1
	if (segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_RAW ||
		segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
		segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
	    segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_EVENT)
	{
		$('.non-tax-discount').show();
		$('.tax-discount').hide();
		$('.tax').hide();
	
		$('#segment03_additional_measurementUnit').val(segment03_itemObj.measurementUnit);
		$('#segment03_additional_unitCost').val(segment03_itemObj.unitCost);
		$('#segment03_additional_unitPrice').val(segment03_itemObj.unitPrice);
		$('#segment03_additional_quantityOptional').prop('checked', segment03_itemObj.quantityOptional);
		$('#segment03_additional_quantity').val(segment03_itemObj.quantity);
		$('#segment03_additional_minimumQuantity').val(segment03_itemObj.minimumQuantity);
		
		$('#segment03_additional_measurementUnit').prop('required', false);
		$('#segment03_additional_unitCost').prop('required', false);
		$('#segment03_additional_unitPrice').prop('required', true);
		$('#segment03_additional_quantity').prop('required', false);
		$('#segment03_additional_minimumQuantity').prop('required', false);
		$('#segment03_additional_taxDiscountPercentage').prop('required', false);
		$('#segment03_additional_taxDiscountAmount').prop('required', false);
	}
	else
	if (segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX)
	{
		$('.non-tax-discount').hide();
		$('.tax-discount').show();
		$('.tax').show();
		
		$('#segment03_additional_taxInclusive').prop('checked', segment03_itemObj.taxInclusive);
		$('#segment03_additional_taxDiscountPercentage').val(segment03_itemObj.taxDiscountPercentage);
		$('#segment03_additional_taxDiscountAmount').val(segment03_itemObj.taxDiscountAmount);
		
		$('#segment03_additional_measurementUnit').prop('required', false);
		$('#segment03_additional_unitCost').prop('required', false);
		$('#segment03_additional_unitPrice').prop('required', false);
		$('#segment03_additional_quantity').prop('required', false);
		$('#segment03_additional_minimumQuantity').prop('required', false);
		$('#segment03_additional_taxDiscountPercentage').prop('required', true);
		$('#segment03_additional_taxDiscountAmount').prop('required', true);
	}
	else
	if (segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT)
	{
		$('.non-tax-discount').hide();
		$('.tax-discount').show();
		$('.tax').hide();
		
		$('#segment03_additional_taxDiscountPercentage').val(segment03_itemObj.taxDiscountPercentage);
		$('#segment03_additional_taxDiscountAmount').val(segment03_itemObj.taxDiscountAmount);
		
		$('#segment03_additional_measurementUnit').prop('required', false);
		$('#segment03_additional_unitCost').prop('required', false);
		$('#segment03_additional_unitPrice').prop('required', false);
		$('#segment03_additional_quantity').prop('required', false);
		$('#segment03_additional_minimumQuantity').prop('required', false);
		$('#segment03_additional_taxDiscountPercentage').prop('required', true);
		$('#segment03_additional_taxDiscountAmount').prop('required', true);
	}
	
	// Create input components for each item field
	$("#segment03_tab2_additional_part2").empty();
	$.each(segment03_itemObj.propertiesList, function(i, itemPropObj) {
	
		// find associated categoryProperties
		var matchedCategoryPropObj;
		$.each(segment03_categoryObj.propertiesList, function(j, categoryPropertiesObj) {
			if (categoryPropertiesObj.id==$.trim(itemPropObj.categoryPropertiesId))	
			{
				matchedCategoryPropObj = categoryPropertiesObj;
				return false;
			}
		});

		if (matchedCategoryPropObj != null)	
		{	   
			// Create input component	    		   	   		    	
	      	var htmlLines = inventoryCommon_createInputComponent_withValue(matchedCategoryPropObj, itemPropObj);
	      	$("#segment03_tab2_additional_part2").append(htmlLines);

			segment03_createInputComponent_postHandler( itemPropObj );
		}
	});
	
	$('.bootstrap-tagsinput').css('width','100%');
	
    if (segment03_itemObj.quantityOptional) {
		$('#segment03_additional_quantity').css('text-decoration', 'line-through');
		$('#segment03_additional_minimumQuantity').css('text-decoration', 'line-through');
		$('#segment03_additional_minimumQuantity').prop('background-color', '#e5e6e7');
		$('#segment03_additional_minimumQuantity').prop('disabled', true);
	} else {
		$('#segment03_additional_quantity').css('text-decoration', '');
		$('#segment03_additional_minimumQuantity').css('text-decoration', '');		
		$('#segment03_additional_minimumQuantity').prop('background-color', '#fff');
		$('#segment03_additional_minimumQuantity').prop('disabled', false);
	}	    
	
	// init iCheck components
    tycheesCommon_initCheckBox();
	
    $('#segment03_additional_quantityOptional').on('change', function(event) {
		segment03_onItemChanged();
	});
    $('#segment03_additional_taxInclusive').on('change', function(event) {
		segment03_onItemChanged();
	});
} // .end of segment03_updateUI_tab2

function segment03_updateUI_tab2_onclick()
{
	// Paint background for each row of field
	$("#tab-2 .setings-item:visible").each(function(i) {
		if (i%2 == 0)  
			$(this).css('background-color','#FFF');
		else
			$(this).css('background-color','#F9F9F9');
	});
} // .end of segment03_updateUI_tab2_onclick

function segment03_updateUI_tab3()
{
    if (segment03_itemObj.itemType==InventoryConstants.ITEM_TYPE_DISCOUNT)
	{
    	$('#segment03_tabHeaderElement').removeClass('navs-3');
    	$('#segment03_tabHeaderElement').removeClass('navs-5');
    	$('#segment03_tabHeaderElement').addClass('navs-4');
		$('#inv003_segment03_tabHeader3').hide();
		$('#tab-3').hide();
		return false;
	}
	else
	if (segment03_itemObj.itemType==InventoryConstants.ITEM_TYPE_TAX)
	{
    	$('#segment03_tabHeaderElement').removeClass('navs-3');
    	$('#segment03_tabHeaderElement').removeClass('navs-5');
    	$('#segment03_tabHeaderElement').addClass('navs-4');
		$('#inv003_segment03_tabHeader3').hide();
		$('#tab-3').hide();
		return false;
	}
	else
	{
    	$('#segment03_tabHeaderElement').removeClass('navs-3');
    	$('#segment03_tabHeaderElement').removeClass('navs-4');
    	$('#segment03_tabHeaderElement').addClass('navs-5');
		$('#inv003_segment03_tabHeader3').show();
		$('#tab-3').show();		
    	$('#tab-3').css('display','');
	}	
	
   	$('#segment03_tab3_mandatory_sortable').empty();
   	$('#segment03_tab3_optional_sortable').empty();
   	
   	$.each(segment03_itemObj.componentList, function(i, componentObj) {
   	
   		if (Cached_isDeletedBean(componentObj)==true)
   			return true;
   		
		var quantitySelectionText = '';
		if (componentObj.allowDefaultQuantityOnly==true) 
		{
			quantitySelectionText = componentObj.defaultQuantity + ' (Default Only)';
		}
		else
		{
			quantitySelectionText = componentObj.minimumSelection + '-' + componentObj.maximumSelection + ' (default=' + componentObj.defaultQuantity + ')';
		}
		
   		// MANDATORY
   		if (componentObj.selectable==false)
   		{
   			var htmlLines = '';
   			htmlLines += '<li id="' + componentObj.id + '" class="ui-state-default" style="line-height:22px;">';
   			htmlLines += '<input type="hidden" class="segment03_componentId" value="' + componentObj.id + '">';
   			htmlLines += '<span style="cursor:pointer;" onclick="segment03_onEditComponent(true, \'' + componentObj.id + '\');">';
   			htmlLines += componentObj.helpText + ' ';
   			htmlLines += '<span style="font-weight:normal;">';
   			htmlLines += '<i>(' + componentObj.title + ')</i>';
   			htmlLines += '</span>';
   			htmlLines += '</span>';
   			htmlLines += '<span class="label label-success" style="float:right;margin:1px;height:22px;padding-top:5px;font-size:12px;"> ' + quantitySelectionText + ' </span>';
	  		htmlLines += '<button type="button" class="btn btn-danger btn-xs field-button pull-right" onclick="segment03_onDeleteComponent(\'' + componentObj.id + '\');">';
	  		htmlLines += '<i class="fa fa-times" aria-hidden="true"></i> ';
	  		htmlLines += '</button> ';
	  		htmlLines += '<button type="button" class="btn btn-info btn-xs field-button pull-right" onclick="segment03_onEditComponent(true, \'' + componentObj.id + '\');">';
	  		htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i> ';
	  		htmlLines += '</button> ';
   			htmlLines += '</li>';
   			
   			$('#segment03_tab3_mandatory_sortable').append(htmlLines);
   		}
   		// OPTIONAL
   		else
   		{
   			var htmlLines = '';
   			htmlLines += '<li id="' + componentObj.id + '" class="ui-state-default" style="line-height:22px;">';
   			htmlLines += '<input type="hidden" class="segment03_componentId" value="' + componentObj.id + '">';
   			htmlLines += '<span style="cursor:pointer;" onclick="segment03_onEditComponent(false, \'' + componentObj.id + '\');">';
   			htmlLines += componentObj.helpText + ' ';
   			htmlLines += '<span style="font-weight:normal;">';
   			htmlLines += '<i>(' + componentObj.title + ')</i>';
   			htmlLines += '</span>';
   			htmlLines += '</span>';
   			htmlLines += '<span class="label label-success" style="float:right;margin:1px;height:22px;padding-top:5px;font-size:12px;"> ' + quantitySelectionText + ' </span>';
	  		htmlLines += '<button type="button" class="btn btn-danger btn-xs field-button pull-right" onclick="segment03_onDeleteComponent(\'' + componentObj.id + '\');">';
	  		htmlLines += '<i class="fa fa-times" aria-hidden="true"></i> ';
	  		htmlLines += '</button> ';
	  		htmlLines += '<button type="button" class="btn btn-info btn-xs field-button pull-right" onclick="segment03_onEditComponent(false, \'' + componentObj.id + '\');">';
	  		htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i> ';
	  		htmlLines += '</button> ';
   			htmlLines += '</li>';
   			
   			$('#segment03_tab3_optional_sortable').append(htmlLines);
   		}
   	});
   	
   	// Init sortable with event handling
   	$('.item-component-sortable').sortable({
   		placeholder: "sortable-component-placeholder",
   		// Triggered when element is moving.
        change: function(event, ui) { 
            //console.log('change', event, ui); 
        },
        // Triggered when element's position has changed.
        update: function(event, ui) {
            console.log('update', event, ui); 
            
            var componentList = $(event.target).find('.segment03_componentId');			
			$.each(componentList, function(i, componentId){
				
				$.each(segment03_itemObj.componentList, function(j, componentObj){
					if (componentObj.id == componentId)
					{
						componentObj.seqno = i;
						componentObj.hasChnaged = true;
					}
				});
			});
			
			tycheesIO_saveBean(segment03_itemObj);
        }
   	});
} // .end of segment03_updateUI_tab3

function segment03_updateUI_tab4()
{
	// IF Tax-type, THEN DO NOT SHOW 
	if (segment03_itemObj.itemType==InventoryConstants.ITEM_TYPE_TAX)
	{
    	$('#segment03_tabHeaderElement').removeClass('navs-4');
    	$('#segment03_tabHeaderElement').removeClass('navs-5');
    	$('#segment03_tabHeaderElement').addClass('navs-3');
		$('#inv003_segment03_tabHeader4').hide();
		$('#tab-4').hide();
		return false;
	}
	else
	{
    	//$('#segment03_tabHeaderElement').removeClass('navs-4');
    	//$('#segment03_tabHeaderElement').addClass('navs-5');
		$('#inv003_segment03_tabHeader4').show();
		$('#tab-4').show();		
    	$('#tab-4').css('display','');
	}	
	
	$('#segment03_accessibility_posVisible').prop('checked', segment03_itemObj.posVisible);
	$('#segment03_accessibility_pwsVisible').prop('checked', segment03_itemObj.pwsVisible);
	$('#segment03_accessibility_scmVisible').prop('checked', segment03_itemObj.scmVisible);
	
	$('#segment03_accessibility_posVisible').on('change', function(event) {
		segment03_onItemChanged();
	});
	$('#segment03_accessibility_pwsVisible').on('change', function(event) {
		segment03_onItemChanged();
	});
	$('#segment03_accessibility_scmVisible').on('change', function(event) {
		segment03_onItemChanged();
	});
	
	// Paint background for each row of field
	$("#tab-4 .setings-item").each(function(i) {
		if (i%2==0)  
			$(this).css('background-color','#FFF');
		else
			$(this).css('background-color','#F9F9F9');
	});
	
} // .end of segment03_updateUI_tab4

function segment03_updateUI_tab5()
{
	// Empty table
    $('#segment03_gridTable').empty();
    
    // Sort
    segment03_itemObj.imageList.sort(function(a, b) {
		if (a.seqno < b.seqno) return -1;
		if (a.seqno > b.seqno) return 1;
		return 0;
	});
    
    $.each(segment03_itemObj.imageList, function(i, imageObj){
        
    	if (Cached_isDeletedBean(imageObj))
    		return true;
    	
    	//var imageExist = $.trim(imageObj.base64) == '' ? false : true;
    	
    	var htmlLines = '';
    	htmlLines += '<div class="grid-item">';
        htmlLines += '<div class="ibox">';
        htmlLines += '<div class="ibox-content product-box">';
        htmlLines += '<div class="product-imitation" style="padding: 0px 0px;" onclick="segment03_editImage(\'' + imageObj.id + '\');">';
        //if (imageExist)
            htmlLines += '<img src="' + $.trim(imageObj.base64) + '" style="width:100%; height:100%">';
        //else
        //    htmlLines += '[ NO IMAGE ]';
        htmlLines += '</div>';
        htmlLines += '<div class="product-desc">';
        if (imageObj.pwsVisible) {
            htmlLines += '<span class="product-price"><i class="fa fa-eye" aria-hidden="true"></i></span>';
        } else {
            htmlLines += '<span class="product-price"><i class="fa fa-eye-slash" aria-hidden="true"></i></span>';
        }
        htmlLines += '<small class="text-muted">' + $.trim(imageObj.fileType).toUpperCase() + '</small>';
        htmlLines += '<a href="#" class="product-name" onclick="segment03_editImage(\'' + imageObj.id + '\');"> ' + $.trim(imageObj.name).toUpperCase() + '</a>';
        htmlLines += '<div class="small m-t-xs">';
        htmlLines += $.trim(imageObj.longDesc).toUpperCase();
        htmlLines += '</div>';
        htmlLines += '<div class="m-t text-righ">';
        htmlLines += '<a href="#" class="btn btn-xs btn-outline btn-primary" onclick="segment03_editImage(\'' + imageObj.id + '\');">';
        htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
        htmlLines += ' Edit';
        htmlLines += '</a>';
        htmlLines += '<span style="padding:2px;"></span>';
        htmlLines += '<a href="#" class="btn btn-xs btn-outline btn-danger" onclick="segment03_deleteImage(\'' + imageObj.id + '\');">';
        htmlLines += '<i class="fa fa-times" aria-hidden="true"></i>';
        htmlLines += ' Delete';
        htmlLines += '</a>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        htmlLines += '</div>';
        
        segment03_masonry.append(htmlLines);
    });
    
    segment03_masonry.masonry('reloadItems');
    segment03_masonry.masonry('layout');
} // .end of segment03_updateUI_tab5

function segment03_updateUI_tab5_images()
{
	$('#segment03_tab5_images_loadImages').ladda().ladda('start');
	
	var requestBody = {
		'appName': APP_NAME_INVENTORY,
		'itemId': segment03_itemObj.id,
		'loadImages': true, 
		'fullBean': true
	};
	
	var params = new Object();
	
	tycheesdb_api_getItemById(requestBody, segment03_updateUI_tab5_images_postHandler, params);
} // .end of segment03_updateUI_tab5_images

function segment03_updateUI_tab5_images_postHandler(success, responseObj, params)
{
	if (!success)
		return false;
	
	segment03_itemObj = responseObj.itemObj;
	
	segment03_updateUI_tab5();

	$('#segment03_tab5_images_loadImages').ladda().ladda('stop');
} // .end of segment03_updateUI_tab5_images_postHandler

function segment03_onItemChanged()
{
	if (segment03_isUpdatingUI==true) {
		tycheesLogger_logInfo("Other process is running, this process abort.", "segment03__onItemChanged");
		return false;
	}
	
	segment03_triggerSavingNotification(true);
} // .end of segment03_onItemChanged

function segment03_triggerSavingNotification(turnOn) {

	if (turnOn) {
		segment03_unsavedChanges = true;	
		$('#segment03_saveButton').css('color', '#ed5565');
		$('#segment03_saveButton').addClass('blink');
	} else {
		segment03_unsavedChanges = false;	
		$('#segment03_saveButton').css('color', '#1ab394');
		$('#segment03_saveButton').removeClass('blink');
	}
} // .end of segment03_triggerSavingNotification

function segment03_adjustQuantity()
{
	if (segment03_itemObj == null)
		return false;
	
	mw_adjustQuantity_show(segment03_itemObj, segment03_adjustQuantity_saveCallback);
} // .end of segment03_adjustQuantity

function segment03_adjustQuantity_saveCallback(itemId, itemName, operator, newQuantity) 
{
	if (operator == 'add')
		tycheesLogger_showToast('success', 'Quantity Updated', itemName + ' has been increased to ' + newQuantity);
	if (operator == 'sub')
		tycheesLogger_showToast('success', 'Quantity Updated', itemName + ' has been decreased to ' + newQuantity);
	
	segment03_updateUI(itemId);
} // .end of segment03_adjustQuantity_saveCallback

function segment03_selectFiles()
{
	// Reset
	segment03_selectedFiles = [];
	// Programmatically trigger file selector
	$('#segment03_fileUpload').click();
} // ,end of segment03_selectFiles

/**
 * Validate & Process image upload.
 */
function segment03_uploadImage()
{
    segment03_selectedFiles = $('#segment03_fileUpload')[0].files;
    
    if (segment03_selectedFiles != null) 
    {
        // Show Spinner
        $('#segment03_fileUpload_spinner').show();
        // Reset
        segment03_fileProcessCount = 0;
        segment03_imageFileList = [];
        
        // iterate each file object to get base64 representation
	    $.each(segment03_selectedFiles, function(i, fileObj) {
	        tycheesFile_getBase64(fileObj, segment03_uploadImage_postHandler);
	    });
	}
} // .end of segment03_uploadImage

function segment03_uploadImage_postHandler(successFlag, base64, fileName, fileType, fileSize, width, height) 
{
    if (successFlag==false)
        return false;
    
    var imageObj = createNew_InventoryItemImage();    
    imageObj.itemId = segment03_itemObj.id;
    imageObj.name = fileName.substring(0, fileName.indexOf('.'));
    imageObj.url = '';
    imageObj.type = '';
    imageObj.altText = '';
    imageObj.longDesc = '';
    imageObj.width = width==null ? 0 : width;
    imageObj.height = height==null ? 0 : width;
    imageObj.base64 = base64;
    imageObj.fileName = fileName;
    imageObj.fileType = fileType;
    imageObj.fileExtension = fileName.substring(fileName.indexOf('.') + 1);
    imageObj.fileSize = fileSize;
    
    segment03_imageFileList.push(imageObj);
    
    // Increment process count
    segment03_fileProcessCount++;
    
    // If all file image(s) have been converted to base64
    if (segment03_fileProcessCount >= segment03_selectedFiles.length)
    {
        // Hide spinner
        $('#segment03_fileUpload_spinner').hide();
        
        // Show modal window
        inv002_segment03_mw009_updateUI(segment03_imageFileList);
    }
} // .end of segment03_uploadImage_postHandler


/**
 * Edit given image.
 *
 * @param {String} imageId - Image ID
 */
function segment03_editImage(imageId)
{
    var selectedImageObj; 
    $.each(segment03_itemObj.imageList, function(i, imageObj){    
    	if (Cached_isDeletedBean(imageObj))
    		return true;
    	
    	if (imageId == imageObj.id)
    		selectedImageObj = imageObj;
    });
    
    inv002_segment03_mw010_open(selectedImageObj);
} // .end of segment03_editImage

/**
 * Confirm & Delete given image.
 *
 * @param {String} imageId - Image ID
 */
function segment03_deleteImage(imageId)
{
	if (imageId==null || imageId=='') {
		tycheesLogger_showToast('warning','No image selected','Please select a image.');
    	return false;
	}
		
	swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this image record!",
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
		  		$.each(segment03_itemObj.imageList, function(i, imageObj){
		  			if (imageObj.id == imageId)
		  			{
		  				Cached_deleteBean(imageObj);
				  		// Save to IndexedDB
				    	tycheesIO_saveBean(segment03_itemObj);
				  		// Refresh UI
				    	segment03_updateUI_tab5();
				  		// Update Image Count
				  		segment03_itemObj.imageCount = 0;
				  		$.each(segment03_itemObj.imageList, function(i, imageObj) {
				  			if (Cached_isDeletedBean(imageObj)==false)
				  				segment03_itemObj.imageCount++;
				  		});
				    	$('#inv003_segment03_tabHeader5_imageCount').html( '(' + segment03_itemObj.imageCount + ')' );
		  			}
		  		});
		  	}
		});
} // .end of segment03_deleteImage

function segment03_createInputComponent_postHandler(itemPropObj)
{
    if (itemPropObj.propType==InventoryConstants.PROP_TYPE_TEXT)
  	{
  		//$('#button-' + itemPropObj.id).on('click', function() {
  		//	segment03_saveItem();
  	    //});
  		$('#' + itemPropObj.id).on('input', function(event) {
  			segment03_onItemChanged();
  		});
  	}
      
    if (itemPropObj.propType==InventoryConstants.PROP_TYPE_NUMBER)
	{	
  		//$('#button-' + itemPropObj.id).on('click', function() {
  		//	segment03_saveItem();
  	    //});
  		$('#' + itemPropObj.id).on('input', function(event) {
  			segment03_onItemChanged();
  		});
	}
  	
	if (itemPropObj.propType==InventoryConstants.PROP_TYPE_LIST)
	{
  		$('#' + itemPropObj.id).on('change', function(event) {
  			segment03_onItemChanged();
  		});
	}
  	
	if (itemPropObj.propType==InventoryConstants.PROP_TYPE_TAG)
	{
      	$('#' + itemPropObj.id).on('itemAdded', function(event) {
      		segment03_onItemChanged();
  		});
		
  		$('#' + itemPropObj.id).on('itemRemoved', function(event) { 
  			segment03_onItemChanged();
  		});

  		$('#' + itemPropObj.id).tagsinput('add', 'test');	// temp, as buffer for first entry
  		$('#' + itemPropObj.id).tagsinput('add', itemPropObj.propValue);
  		$('#' + itemPropObj.id).tagsinput('refresh');
  		
  		// Override CSS's style - width=100%
  		$('.bootstrap-tagsinput').css('width','100%');
  		$('.bootstrap-tagsinput input').css('width','100%');
	}
  	
	if (itemPropObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
	{
      	if (itemPropObj.propValue=='true' || itemPropObj.propValue==true)
      		$('#' + itemPropObj.id).prop('checked', true);
      	else
      		$('#' + itemPropObj.id).prop('checked', false);
      	
  		$('#' + itemPropObj.id).on('change', function(event) {
  			segment03_onItemChanged();
  		});
	}	      	
    
    // init for input component type DATE	
    if (itemPropObj.propType==InventoryConstants.PROP_TYPE_DATE)
    {
    	$('.date-group .input-group.date').datepicker({
	      	todayBtn: "linked",
	      	keyboardNavigation: false,
	      	forceParse: false,
	      	calendarWeeks: true,
	      	autoclose: true
	    }).on('changeDate', function(e) {
	        // 'e' here contains the extra attributes
	        segment03_onItemChanged();
	    });
   	}

    // init for input component type TIME	
  	if (itemPropObj.propType==InventoryConstants.PROP_TYPE_TIME)
  	{
  		$('.clockpicker').clockpicker({
  			init: function() { 
            	//console.log("clockpicker initiated");
        	},
        	afterDone: function() {
            	//console.log("after done");
            	segment03_onItemChanged();
            }
  		});
  	}
} // .end of segment03_createInputComponent_postHandler

function segment03_slideOut()
{
	if ( $('#inv002_segment03').hasClass('sidebar-open')==false )
		$('#inv002_segment03').toggleClass('sidebar-open');	
} // .end of segment03_slideOut

function segment03_slideIn()
{
	if ( $('#inv002_segment03').hasClass('sidebar-open')==true )
		$('#inv002_segment03').toggleClass('sidebar-open');
} // .end of segment03_slideIn

function segment03_showSpinner(showing)
{
	if (showing)
	{
		$('#segment03_itemNameElement').hide();
		$('#segment03_itemNameElement_spinner').show();
		
		$('#segment03_tabHeaderElement').hide();
		$('#segment03_tabContentElement').hide();
	}
	else
	{
		$('#segment03_itemNameElement').show();
		$('#segment03_itemNameElement_spinner').hide();
		
		$('#segment03_tabHeaderElement').show();
		$('#segment03_tabContentElement').show();
		
	}
} // .end of segment03_showSpinner

/**
 * When user click on button 'Add Component'
 */
function segment03_onclick_addComponent(isMandatory)
{
	if (isMandatory)
    	segment03_mw006_open();
    else
    	segment03_mw005_open();
} // .end of segment03_onclick_addComponent

/**
 * When user click on button 'Edit Component'
 */
function segment03_onEditComponent(isMandatory, componentId)
{
	if (isMandatory)
        segment03_mw008_open(componentId);
    else
        segment03_mw007_open(componentId);
} // .end of segment03_onEditComponent

function segment03_onDeleteComponent(componentId)
{
	tycheesOverlay_startShortProgress('Checking dependency...');
	
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_INVENTORY,
			'itemId': segment03_itemObj.id,
			'fullBean': true
		};
	
	var params = new Object();
	params.componentId = componentId;
	
	tycheesdb_api_getItemById(requestBody, segment03_onDeleteComponent_postValidation_getItem, params);
} // .end of segment03_onDeleteComponent

/**
 * When user click on button 'Delete Component'
 */
function segment03_onDeleteComponent_postValidation_getItem(successFlag, responseObj, params)
{
	if (successFlag == false)
	{
		return false;
	}

	tycheesOverlay_stopShortProgress();
	
	// Validation
	if (responseObj.itemObj==null)
	{
		swal(
			"Invalid Item Found", 
			"Unable to find item with ID="+itemId, 
			"warning");
		return false;
	}
	// .end of Validation
	
	swal({   
		title: "Are you sure?",   
		text: "You will not be able to recover this component!",   
		type: "warning",   
		showCancelButton: true,   
		confirmButtonColor: "#DD6B55",   
		confirmButtonText: "Yes, delete it!",
        cancelButtonText: "No, cancel please!",
		closeOnConfirm: true,
        closeOnCancel: true
	}, function(isConfirm){  
		
        if (isConfirm) 
        {	        	
			// Remove from cache object
			$.each(segment03_itemObj.componentList, function(i, componentObj){
				if (componentObj.id == params.componentId) 
				{
					// Set delete status
					Cached_deleteBean(componentObj);
					// Save into IDB
					tycheesIO_saveBean(segment03_itemObj);
					// Update UI
					$('#'+componentObj.id).remove();
					// Break from iteration
					return false;
				}
			});			
        }
	});
} // .end of segment03_onclick_deleteComponent

function segment03_saveItem()
{	
	if (segment03_isUpdatingUI==true)
	{
		tycheesLogger_logInfo("Other process is running, this process abort.", "segment03_saveItem");
		return false;
	}
	
	// Clear status message
 	$("#segment03_tab1_status_list").empty();
 	$("#segment03_tab1_status").hide();
 	$("#segment03_tab2_status_list").empty();
 	$("#segment03_tab2_status").hide();
 	$("#segment03_tab3_status_list").empty();
 	$("#segment03_tab3_status").hide();
 	$("#segment03_tab4_status_list").empty();
 	$("#segment03_tab4_status").hide();
 	
    // Form Validation Check
 	var inputValidity = true;
    $('#segment03_tabContentElement :input').each(function()
	{
    	// ENABLE for Debug only
 		//console.log("Check Field=" + this.name + " [" + this.id + "] is "+this.validity.valid);
        
 		// reset to white
 		if(this.type=="text" || this.type=="number" || this.type=="textarea" || this.type=="select-one") 
 		{
 			if ($(this).prop('disabled')==true) 
 			{
 				
 			} 
 			else 
 			{
 				$(this).css('background-color','#FFFFFF');
 			}
 		}
 		
 		// Field with invalid value
  	    //if(this.validity.valid==false)
  	    if(this.checkValidity()==false)
  	    {
  	    	// Set flag to false
  	    	inputValidity = false;
  	    	
  	        //$(this).focus();
  	        $(this).css('background-color','#F6CECE');  	      
  	        
  	        if ($(this).hasClass('tab1-input'))
  	      		$("#segment03_tab1_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab2-input'))
  	      		$("#segment03_tab2_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab3-input'))
  	      		$("#segment03_tab3_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab4-input'))
  	      		$("#segment03_tab4_status_list").append("Invalid value found: " + this.name + "<br/>");
  	    }
	});
	    
    if (inputValidity==false)
    { 
        tycheesLogger_showToast("error", "Input Error", "Errors found on input value(s). Save action aborted.");	        
        
        // Print fields with error validation
 		if ( $.trim($("#segment03_tab1_status_list").html()) != '' )
 			$("#segment03_tab1_status").show();
 		if ( $.trim($("#segment03_tab2_status_list").html()) != '' )
 			$("#segment03_tab2_status").show();
 		if ( $.trim($("#segment03_tab3_status_list").html()) != '' )
 			$("#segment03_tab3_status").show();
 		if ( $.trim($("#segment03_tab4_status_list").html()) != '' )
 			$("#segment03_tab4_status").show();
 		
    	return false;
    }
    // Form Validation Check - END
    
    // TAB 1
    segment03_itemObj.name		= $.trim( $("#segment03_itemNameField").val() );
    segment03_itemObj.skuCode	= $.trim( $("#segment03_itemSkuCodeField").val() );
    segment03_itemObj.groupName	= $.trim( $("#segment03_itemGroupField").val() );
    segment03_itemObj.labels	= $.trim( $("#segment03_keywordsField").val() );
    segment03_itemObj.remarks 	= $.trim( $("#segment03_itemDescriptionField").val() );
       	   
    // TAB 2 - Part 1
	if (segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_RAW ||
	    segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_PRODUCT ||
	    segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_SERVICE ||
	    segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_EVENT)
	{
    	segment03_itemObj.measurementUnit	=  $.trim( $("#segment03_additional_measurementUnit").val() );
		segment03_itemObj.unitCost			= Number( $('#segment03_additional_unitCost').val() );
		segment03_itemObj.unitPrice			= Number( $('#segment03_additional_unitPrice').val() );
		segment03_itemObj.quantityOptional	= $('#segment03_additional_quantityOptional').prop('checked');
		segment03_itemObj.quantity			= Number( $('#segment03_additional_quantity').val() );
		segment03_itemObj.minimumQuantity	= Number( $('#segment03_additional_minimumQuantity').val() );
	}
	else
	if (segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_TAX)
	{
		segment03_itemObj.taxInclusive				= $('#segment03_additional_taxInclusive').prop('checked');
		segment03_itemObj.taxDiscountPercentage		= Number( $('#segment03_additional_taxDiscountPercentage').val() );
		segment03_itemObj.taxDiscountAmount			= Number( $('#segment03_additional_taxDiscountAmount').val() );
		segment03_itemObj.taxDiscountInPercentage	= segment03_itemObj.taxDiscountPercentage > 0 ? true : false;
		segment03_itemObj.taxDiscountInAmount		= segment03_itemObj.taxDiscountAmount > 0 ? true : false;
	}
	else
	if (segment03_itemObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT)
	{
		segment03_itemObj.taxDiscountPercentage		= Number( $('#segment03_additional_taxDiscountPercentage').val() );
		segment03_itemObj.taxDiscountAmount			= Number( $('#segment03_additional_taxDiscountAmount').val() );
		segment03_itemObj.taxDiscountInPercentage	= segment03_itemObj.taxDiscountPercentage > 0 ? true : false;
		segment03_itemObj.taxDiscountInAmount		= segment03_itemObj.taxDiscountAmount > 0 ? true : false;
	}   	   
       	   
    // TAB 2 - Part 2
    $.each(segment03_itemObj.propertiesList, function(i, propObj) {
    
		var fieldVal = $('#'+propObj.id).val();				
		
		if (propObj.propType==InventoryConstants.PROP_TYPE_BOOLEAN)
		{
			fieldVal = $('#'+propObj.id).prop('checked');
		}
		if (propObj.propType==InventoryConstants.PROP_TYPE_DATE)
		{
			fieldVal = tycheesDateTime_toMilliseconds_MMddyyyy( $('#'+propObj.id).val() );
		}
		if (propObj.propType==InventoryConstants.PROP_TYPE_TIME)
		{
			fieldVal = tycheesDateTime_toMilliseconds_hhmm( $('#'+propObj.id).val() );
		}
		
		propObj.propValue = String(fieldVal);
	});
    
    // TAB-4
    segment03_itemObj.pwsVisible = $('#segment03_accessibility_pwsVisible').prop('checked');
    segment03_itemObj.posVisible = $('#segment03_accessibility_posVisible').prop('checked');
    segment03_itemObj.scmVisible = $('#segment03_accessibility_scmVisible').prop('checked');

    // Update Measurement Unit
    $('.measurement-unit').html( segment03_itemObj.measurementUnit );
	// Update Quantity
    if (segment03_itemObj.quantityOptional) {
		$('#segment03_additional_quantity').css('text-decoration', 'line-through');
		$('#segment03_additional_minimumQuantity').css('text-decoration', 'line-through');
		$('#segment03_additional_minimumQuantity').prop('background-color', '#e5e6e7');
		$('#segment03_additional_minimumQuantity').prop('disabled', true);
	} else {
		$('#segment03_additional_quantity').css('text-decoration', '');
		$('#segment03_additional_minimumQuantity').css('text-decoration', '');		
		$('#segment03_additional_minimumQuantity').prop('background-color', '#fff');
		$('#segment03_additional_minimumQuantity').prop('disabled', false);
	}	
    
	// Notify segment01
    segment01_onItemChanged(segment03_itemObj);
	
	// Save item
    tycheesIO_saveBean(segment03_itemObj);
    // Reset state
    segment03_triggerSavingNotification(false);
} // .end of segment03_saveItem

</script>