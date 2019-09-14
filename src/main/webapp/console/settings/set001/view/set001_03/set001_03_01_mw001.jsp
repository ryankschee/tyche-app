<!-- Modal Window: Add Template -->
<div class="modal inmodal fade" id="set001_03_01_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">NEW CUSTOMER TEMPLATE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_03_01_mw001_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Template Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_03_01_mw001_templateName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Default Template <br>
	                                		<!-- small class="text-navy">Custom elements</small-->
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="set001_03_01_mw001_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_03_01_mw001_defaultTemplate" value=""> 
	                                        		<i></i> Check it to enable. 
	                                        	</label>
	                                        </div>
	                                        <span class="help-block m-b-none">**Note: Making this template default will de-select other templates.</span>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_03_01_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_03_01_mw001_initialized = false;

/**
 * Init Panel
 */
function set001_03_01_mw001_init()
{
    if (set001_03_01_mw001_initialized == true)
        return false;
    
    $('.set001_03_01_mw001_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_03_01_mw001').on('shown.bs.modal', function () {
	    $("#set001_03_01_mw001_templateName").focus();
	});
    
	set001_03_01_mw001_initialized = true;
} // .end of set001_03_01_mw001_init

/**
 * Show Panel
 */
function set001_03_01_mw001_updateUI()
{
    set001_03_01_mw001_init();
        
    // Reset
    $('#set001_03_01_mw001_templateName').val('');
    $('#set001_03_01_mw001_defaultTemplate').iCheck('uncheck');
    
    $('#set001_03_01_mw001').modal({backdrop: 'static', keyboard: false});
} // .end of set001_03_01_mw001_updateUI

/**
 * Show Panel
 */
function set001_03_01_mw001_show()
{
    set001_03_01_mw001_updateUI();
} // .end of set001_03_01_mw001_show

/**
 * Save changes and hide panel.
 */
function set001_03_01_mw001_save()
{
	var l_placeObj = tycheesCommon_getCurrentPlaceObject();
    var templateName	= $('#set001_03_01_mw001_templateName').val();
    var defaultTemplate = $('#set001_03_01_mw001_defaultTemplate').prop('checked');
    
    var newTemplateObj = createNew_CommonTemplate();
    newTemplateObj.parentId = l_placeObj.id;
    newTemplateObj.moduleId = ModuleConstants.MODULE_RELATION;
    newTemplateObj.templateName = templateName;
    newTemplateObj.templateType = PlaceConstants.TEMPLATE_TYPE_CUSTOMER;
    newTemplateObj.defaultTemplate = defaultTemplate;
    newTemplateObj.propertiesList = [];
    
    if (defaultTemplate==true)
    {
    	$.each(l_placeObj.templateList, function(i, templateObj){
    		if (templateObj.templateType==PlaceConstants.TEMPLATE_TYPE_CUSTOMER) {
	    		if (newTemplateObj.id != templateObj.id) {
	    			templateObj.defaultTemplate = false;
	    			templateObj.hasChanged = true;
	    		}
    		}
    	});
    }
    
    // Push new object into templateList
    l_placeObj.templateList.push(newTemplateObj);
    // Save into IndexedDB
    tycheesIO_saveBean(l_placeObj);
    // Update Customer UI
    set001_03_01_updateUI(newTemplateObj.id);
    // Close Modal Window
    $('#set001_03_01_mw001').modal('hide');
} // .end of set001_03_01_mw001_save

</script>