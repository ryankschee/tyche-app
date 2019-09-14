<!-- REL001_01: Vendor -->
<div id="rel001_03" style="display:none;">
    <div class="mail-box-header">
        <h2>
            <i class="fa fa-truck" aria-hidden="true"></i> VENDOR MANAGEMENT
        </h2>
    </div>
    
    <div class="row">
        <div class="col-sm-8">	                    
            <div class="ibox float-e-margins">
            	<div class="ibox-title">
                    <!-- Toolbar: BEGIN -->
                	<div class="note-toolbar btn-toolbar">
                		<div class="note-font btn-group">
                			<button id="menu_refresh" type="button" class="btn btn-info" title="" tabindex="-1" data-original-title="Refresh" onclick="loadUI_refresh();">
                				<i class="fa fa-refresh" aria-hidden="true"></i>
                				Refresh
                			</button>
                			<button id="menu_addNewItem" type="button" class="btn btn-info" title="" tabindex="-1" data-toggle="modal" data-target="#modalWindow-vendorCreator">
                				<i class="fa fa-plus" aria-hidden="true"></i>
                				Add New Vendor
                			</button>
                		</div>
                	</div>
               	</div> <!-- .end of ibox-title -->
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover " id="tableVendor" >
                        <thead>
                            <tr>
                                <th>Vendor Full Name</th>
                                <th>Contact</th>
                            </tr>
                        </thead>
                        <tbody id="table-vendorList">	                                                    
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox ">

                <div class="ibox-content">
                    <div class="tab-content" id="frame-vendorList">	                                
                    </div><!-- .end of tab-content -->
                </div>
            </div>
        </div>
    </div>
</div>

<script>

/*******************************************************************************
 * Init Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_03_init()
{
    
} // .end of rel001_03_updateUI

/*******************************************************************************
 * Show Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_03_updateUI()
{
    rel001_03_init();
    
    $('#rel001_03').show();
} // .end of rel001_03_updateUI

/*******************************************************************************
 * Hide Panel
 * 
 * Change Logs
 * -----------
 * 20161005 Ryan Chee   Initial
 */
function rel001_03_hide()
{
    $('#rel001_03').hide();
} // .end of rel001_03_updateUI

</script>