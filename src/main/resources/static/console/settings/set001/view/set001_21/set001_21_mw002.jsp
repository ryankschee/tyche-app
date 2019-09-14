<!-- Modal Window:  -->
<div class="modal inmodal fade" id="set001_21_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">CHANGE PASSWORD</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div id="set001_21_mw002_modalBody" class="modal-body">
			    
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
		    	<button type="button" class="btn btn-primary" onclick="set001_21_mw002_save();">Save changes</button>
		    </div>
	    </div>
    </div>
</div>

<script>

var set001_21_mw002_initialized = false;

/**
 * Init Panel
 */
function set001_21_mw002_init()
{
    if (set001_21_mw002_initialized == true)
        return false;
        
	set001_21_mw002_initialized = true;
} // .end of set001_21_mw002_init

/**
 * Show Panel
 */
function set001_21_mw002_updateUI()
{
    set001_21_mw002_init();
    
    
    $('#set001_21_mw002').modal({backdrop: 'static', keyboard: false});
} // .end of set001_21_mw002_updateUI

/**
 * Save changes and hide panel.
 */
function set001_21_mw002_save()
{
    
} // .end of set001_21_mw002_save

</script>