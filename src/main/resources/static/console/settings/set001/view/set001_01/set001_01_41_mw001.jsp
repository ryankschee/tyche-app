<!-- Modal Window: New Layout -->
<div class="modal inmodal fade" id="set001_01_41_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		    <div class="modal-header">
		    	<span class="modal-title">NEW LAYOUT</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
		    </div>
		    <div id="set001_01_41_mw001_modalBody" class="modal-body">
			    <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox float-e-margins">
	                        <div class="ibox-content">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Layout Name</label>
	                                    <div class="col-sm-8">
	                                    	<input type="text" class="form-control" id="set001_01_41_mw001_layoutName">
	                                    	<span id="set001_01_41_mw001_layoutName_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    	<span id="set001_01_41_mw001_layoutName_error_duplication" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Duplication found</span>
	                                    </div>
	                                </div>
	                            	<div class="hr-line-dashed"></div>
	                            	<div class="form-group">
	                                	<label class="col-sm-4 control-label">Width (px)</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_01_41_mw001_layoutWidth">
	                                    	<span id="set001_01_41_mw001_layoutWidth_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">Height (px)</label>
	                                    <div class="col-sm-8">
	                                    	<input type="number" class="form-control" id="set001_01_41_mw001_layoutHeight">
	                                    	<span id="set001_01_41_mw001_layoutHeight_error" class="help-block m-b-none" style="display:none; color:#FF0000;">Error: Invalid Value</span>
	                                    </div>
	                                </div>
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group">
	                                	<label class="col-sm-4 control-label">
	                                		Default Layout <br>
	                                	</label>
	                                    <div class="col-sm-8">
	                                        <div class="set001_01_41_mw001_i-checks">
	                                        	<label> 
	                                        		<input type="checkbox" id="set001_01_41_mw001_defaultLayout" value=""> 
	                                        		<i></i> Check it to enable. 
	                                        	</label>
	                                        </div>
	                                        <span class="help-block m-b-none">**Note: Making this layout default will de-select other templates.</span>
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
		    	<button type="button" class="btn btn-primary" onclick="set001_01_41_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_01_41_mw001_initialized = false;
var set001_01_41_mw001_validInput = false;

function set001_01_41_mw001_isOpen()
{
	return ($("#set001_01_41_mw001").data('bs.modal') || {}).isShown;	
} // .end of set001_01_41_mw001_isOpen

function set001_01_41_mw001_init()
{
    if (set001_01_41_mw001_initialized == true)
        return false;

    $('.set001_01_41_mw001_i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#set001_01_41_mw001').on('shown.bs.modal', function () {
	    $("#set001_01_41_mw001_layoutName").focus();
	});
    
	set001_01_41_mw001_initialized = true;
} // .end of set001_01_41_mw001_init

function set001_01_41_mw001_show()
{
    set001_01_41_mw001_updateUI();
} // .end of set001_01_41_mw001_show

function set001_01_41_mw001_updateUI()
{
    set001_01_41_mw001_init();
    
    // Setup inputs
    $('#set001_01_41_mw001_layoutName').val( '' );
    $('#set001_01_41_mw001_layoutWidth').val( '' );
    $('#set001_01_41_mw001_layoutHeight').val( '' );
    $('#set001_01_41_mw001_defaultTemplate').iCheck('uncheck');
    // Reset
    $('#set001_01_41_mw001_layoutName_error').hide();
    $('#set001_01_41_mw001_layoutName_error_duplication').hide();
    $('#set001_01_41_mw001_layoutWidth_error').hide();
    $('#set001_01_41_mw001_layoutHeight_error').hide();
        
    // Show Modal Window on Top
    module_showModalWindow('set001_01_41_mw001', true);
} // .end of set001_01_41_mw001_updateUI

function set001_01_41_mw001_save()
{
	// reset
    $('#set001_01_41_mw001_layoutName_error').hide();
    $('#set001_01_41_mw001_layoutName_error_duplication').hide();
    $('#set001_01_41_mw001_layoutWidth_error').hide();
    $('#set001_01_41_mw001_layoutHeight_error').hide();
    
    // Get user input
    var layoutName = $.trim( $('#set001_01_41_mw001_layoutName').val() );
    var layoutWidth = parseInt( $('#set001_01_41_mw001_layoutWidth').val() );
    var layoutHeight = parseInt( $('#set001_01_41_mw001_layoutHeight').val() );
    var defaultLayout = $('#set001_01_41_mw001_defaultLayout').prop('checked');

	// Get place object
	var placeObj = tycheesCommon_getCurrentPlaceObject();

    // Validation #1: if empty value
    if (layoutName == '')
    {
    	$('#set001_01_41_mw001_layoutName_error').show();
    	$('#set001_01_41_mw001_layoutName').focus();
    	return false;
    }
    
    // Validation #2: if duplication found
    set001_01_41_mw001_validInput = true;
    $.each(placeObj.layoutList, function(i, layoutObj){
    	if (layoutName == $.trim(layoutObj.layoutName))
    	{
    		set001_01_41_mw001_validInput = false;
    		return false;
    	}
    });
        
    if ( set001_01_41_mw001_validInput==false )
    {
    	$('#set001_01_41_mw001_layoutName_error_duplication').show();
    	$('#set001_01_41_mw001_layoutName').focus();
    	return false;
    }
    
    // Validation #3: non-integer width
    if (layoutWidth == NaN)
    {
    	$('#set001_01_41_mw001_layoutWidth_error').show();
    	$('#set001_01_41_mw001_layoutWidth').focus();
    	return false;
    }
    
    // Validation #4: non-integer height
    if (layoutHeight == NaN)
    {
    	$('#set001_01_41_mw001_layoutHeight_error').show();
    	$('#set001_01_41_mw001_layoutHeight').focus();
    	return false;
    }
    
    // Create layout object
    var placeLayoutObj = createNew_PlaceLayout();     
    placeLayoutObj.layoutName = layoutName;
    placeLayoutObj.width = layoutWidth;
    placeLayoutObj.height = layoutHeight;
    placeLayoutObj.defaultLayout = defaultLayout;    
    // Add to place
    placeObj.layoutList.push( placeLayoutObj );

    if (defaultLayout) {
    	$.each(placeObj.layoutList, function(i, layoutObj) {
    		if (layoutObj.id != placeLayoutObj.id) {
    			layoutObj.defaultLayout = false;
    			layoutObj.hasChanged = true;
    		}
    	});
    }
    
    // Save into IndexedDB
    tycheesIO_saveBean( placeObj );
    // Reload UI
    set001_01_41_updateUI( placeLayoutObj.id );
    
    // Close Modal Window
    $('#set001_01_41_mw001').modal('hide');
} // .end of set001_01_41_mw001_save

</script>