<!-- Modal Window:  -->
<div class="modal inmodal fade" id="set001_21_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">CHANGE EMAIL</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_21_mw001_modalBody" class="modal-body">
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_21_mw001_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_21_mw001_initialized = false;

/**
 * Init Panel
 */
function set001_21_mw001_init()
{
    if (set001_21_mw001_initialized == true)
        return false;
        
	set001_21_mw001_initialized = true;
} // .end of set001_21_mw001_init

/**
 * Show Panel
 */
function set001_21_mw001_updateUI()
{
    set001_21_mw001_init();
    
    
    $('#set001_21_mw001').modal({backdrop: 'static', keyboard: false});
} // .end of set001_21_mw001_updateUI

/**
 * Save changes and hide panel.
 */
function set001_21_mw001_save()
{
    
} // .end of set001_21_mw001_save

</script>