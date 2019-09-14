<!-- Modal Window: Add Profile -->
<div class="modal inmodal fade" id="rel001_customerPanel_mw003" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW CUSTOMER PROFILE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="rel001_customerPanel_mw003_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Profile Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="rel001_customerPanel_mw003_profileName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Import Template</label>
	                                    <div class="col-sm-8">
	                                    	<select class="form-control" id="rel001_customerPanel_mw003_profileTemplateList">
	                                    	</select>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Default Profile <br>
	                                		<small class="text-navy">Custom elements</small>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="rel001_customerPanel_mw003_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="rel001_customerPanel_mw003_defaultProfile" value=""> 
	                                        		<i></i> Check it to enable. 
	                                        	</label>
	                                        </div>
	                                        <span class="help-block m-b-none">Making this profile default will deselect other profiles.</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="rel001_customerPanel_mw003_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var rel001_customerPanel_mw003_initialized = false;

/**
 * Init Panel
 */
function rel001_customerPanel_mw003_init()
{
    if (rel001_customerPanel_mw003_initialized == true)
        return false;
    
    $('.rel001_customerPanel_mw003_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_customerPanel_mw003').on('shown.bs.modal', function () {
	    $("#rel001_customerPanel_mw003_profileName").focus();
	});
    
	rel001_customerPanel_mw003_initialized = true;
} // .end of rel001_customerPanel_mw003_init

/**
 * Show Panel
 */
function rel001_customerPanel_mw003_updateUI()
{
    rel001_customerPanel_mw003_init();
        
    // Reset
    $('#rel001_customerPanel_mw003_profileName').val('');
    $('#rel001_customerPanel_mw003_defaultProfile').iCheck('uncheck');
    
    var placeObj = tycheesCommon_getCurrentPlaceObject();
    var sortedList = [];
    $.each(placeObj.templateList, function(i, templateObj){
		if (Cached_isDeletedBean(templateObj))
			return true;
		
    	if (templateObj.moduleId == ModuleConstants.MODULE_RELATION &&
       		templateObj.templateType == PlaceConstants.TEMPLATE_TYPE_CUSTOMER_PROFILE)
       	{    		
    		sortedList.push(templateObj);
       	}
    });
    
 	// Sort list, by template name
    sortedList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.templateName, b.templateName);
		});
    
 	// Populate Template List
    $('#rel001_customerPanel_mw003_profileTemplateList').empty();
    $('#rel001_customerPanel_mw003_profileTemplateList').append('<option value="">-- USE NO TEMPLATE --</option>')
    $.each(sortedList, function(i, templateObj){
    	
    	var selectedVal = '';
    	if (templateObj.defaultTemplate)
    		selectedVal = 'selected';
    	
    	var htmlLines = '';
    	htmlLines += '<option value="' + templateObj.id + '" ' + selectedVal + '>';
    	htmlLines += templateObj.templateName;
    	htmlLines += '</option>';
    	
    	$('#rel001_customerPanel_mw003_profileTemplateList').append( htmlLines );
    });
 	
    // Show Modal Window
    module_showModalWindow('rel001_customerPanel_mw003', true);
} // .end of rel001_customerPanel_mw003_updateUI

/**
 * Show Panel
 */
function rel001_customerPanel_mw003_show()
{
    rel001_customerPanel_mw003_updateUI();
} // .end of rel001_customerPanel_mw003_show

/**
 * Save changes and hide panel.
 */
function rel001_customerPanel_mw003_save()
{
    var profileName	= $('#rel001_customerPanel_mw003_profileName').val();
    var defaultProfile = $('#rel001_customerPanel_mw003_defaultProfile').prop('checked');
    
    var newProfileObj = createNew_CustomerProfile();
    newProfileObj.customerId = rel001_customerPanel_customerObj.id;
    newProfileObj.profileName = profileName;
    newProfileObj.defaultProfile = defaultProfile;
    newProfileObj.propertiesList = [];
    
    if (defaultProfile)
    {
    	$.each(rel001_customerPanel_customerObj.profileList, function(i, profileObj){
    		if (newProfileObj.id != profileObj.id)
    			profileObj.defaultProfile = false;
    			profileObj.hasChanged = true;
    	});
    }
    
    // Import Template (if any)
    var templateId = $.trim( $('#rel001_customerPanel_mw003_profileTemplateList').val() );
    if (templateId != '') {
    	var placeObj = tycheesCommon_getCurrentPlaceObject();
    	$.each(placeObj.templateList, function(i, templateObj) {
    		if (templateObj.id == templateId) {
    			
    			// Clone begin
    			$.each(templateObj.propertiesList, function(i, propertiesObj) {
    				var newPropertiesObj = createNew_CustomerProfileProperties();
    				newPropertiesObj.profileId = newProfileObj.id;
    				newPropertiesObj.groupName = propertiesObj.groupName;
    				newPropertiesObj.propKey = propertiesObj.propKey;
    				newPropertiesObj.propName = propertiesObj.propName;
    				newPropertiesObj.propType = propertiesObj.propType;
    				newPropertiesObj.propContent = propertiesObj.propContent;
    				newPropertiesObj.propValue = propertiesObj.propValue;
    				newPropertiesObj.remarks = propertiesObj.remarks;
    				
    				newProfileObj.propertiesList.push(newPropertiesObj);
    			});
    		}
    	});
    }
    
    // Push new object into profileList
    rel001_customerPanel_customerObj.profileList.push(newProfileObj);
    // Save into IndexedDB
    tycheesIO_saveBean(rel001_customerPanel_customerObj);
    // Update Customer UI - Only Profiles
    rel001_customerPanel_sw001_updateUI_tab2();
    // Close Modal Window
    $('#rel001_customerPanel_mw003').modal('hide');
} // .end of rel001_customerPanel_mw003_save

</script>