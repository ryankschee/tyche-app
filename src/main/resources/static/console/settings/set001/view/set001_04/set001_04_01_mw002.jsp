<!-- Modal Window: Edit Template -->
<div class="modal inmodal fade" id="set001_04_01_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT EMPLOYEE TEMPLATE</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_04_01_mw002_modalBody" class="modal-body">
			    
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Template Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_04_01_mw002_templateName">
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Default Template <br>
	                                		<small class="text-navy">Custom elements</small>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="set001_04_01_mw002_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_04_01_mw002_defaultTemplate" value=""> 
	                                        		<i></i> Check it to enable. 
	                                        	</label>
	                                        </div>
	                                        <span class="help-block m-b-none">Making this template default will de-select other templates.</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_04_01_mw002_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_04_01_mw002_initialized = false;
var set001_04_01_mw002_templateId;

/**
 * Init Panel
 */
function set001_04_01_mw002_init()
{
    if (set001_04_01_mw002_initialized == true)
        return false;
    
    $('.set001_04_01_mw002_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_04_01_mw002').on('shown.bs.modal', function () {
	    $("#set001_04_01_mw002_templateName").focus();
	})
    
	set001_04_01_mw002_initialized = true;
} // .end of set001_04_01_mw002_init

/***
 * Show Panel
 */
function set001_04_01_mw002_updateUI()
{
    set001_04_01_mw002_init();
    
    var templateObj = 
    	set001_04_01_getPlaceTemplateById(set001_04_01_mw002_templateId);
        
    // Reset
    $('#set001_04_01_mw002_templateName').val(templateObj.templateName);
    if (templateObj.defaultTemplate == true)
    	$('#set001_04_01_mw002_defaultTemplate').iCheck('check');
    else
    	$('#set001_04_01_mw002_defaultTemplate').iCheck('uncheck');
    
    $('#set001_04_01_mw002').modal({backdrop: 'static', keyboard: false});
} // .end of set001_04_01_mw002_updateUI

/**
 * Show Panel
 */
function set001_04_01_mw002_show(selectedTemplateId)
{
	if (selectedTemplateId==null || selectedTemplateId=='')
	{
		tycheesLogger_showToast('warning', 'No Template Selected', 'Please select a template to edit.')
		return false;	
	}
	
	set001_04_01_mw002_templateId = selectedTemplateId;	
    set001_04_01_mw002_updateUI();
} // .end of set001_04_01_mw002_show

/**
 * Save changes and hide panel.
 */
function set001_04_01_mw002_save()
{
    var templateName = $('#set001_04_01_mw002_templateName').val();
    var defaultTemplate = $('#set001_04_01_mw002_defaultTemplate').prop('checked');
	var l_placeObj = tycheesCommon_getCurrentPlaceObject();
	
	var existingTemplateObj = 
		set001_04_01_getPlaceTemplateById( set001_04_01_mw002_templateId );
    existingTemplateObj.templateName = templateName;
    existingTemplateObj.defaultTemplate = defaultTemplate;
    existingTemplateObj.hasChanged = true;
    
    if (defaultTemplate==true)
    {
    	$.each(l_placeObj.templateList, function(i, templateObj){
    		if (templateObj.templateType==PlaceConstants.TEMPLATE_TYPE_EMPLOYEE) {
	    		if (existingTemplateObj.id != templateObj.id) {
	    			templateObj.defaultTemplate = false;
	    			templateObj.hasChanged = true;
	    		}
    		}
    	});
    }
        
    // Save into IndexedDB
    tycheesIO_saveBean(l_placeObj);
    // Update Employee UI
    set001_04_01_updateUI(existingTemplateObj.id);
    // Close Modal Window
    $('#set001_04_01_mw002').modal('hide');
} // .end of set001_04_01_mw002_save

</script>