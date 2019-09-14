<!-- REP001_00_00: Reports -->
<div id="rep001_00_00" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	GENERAL
	</span>
    <div class="mail-box">
        <table class="table table-hover table-mail" style="margin-bottom:0px;">
            <thead style="background-color:#555;color:#ffffff;font-weight:bold;">
                <tr>
                    <td>NAME</td>
                    <td>VALUE</td>
                    <td>DESCRIPTION</td>
                </tr>
            </thead>
            <tbody id="rep001_00_00_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var rep001_00_00_initialized = false;

/**
 * Init Panel
 */
function rep001_00_00_init()
{
    if (rep001_00_00_initialized == true)
        return false;
            
	rep001_00_00_initialized = true;
} // .end of rep001_00_00_init

/**
 * Show Panel
 */
function rep001_00_00_updateUI()
{
    rep001_00_00_init();
    
  	
    $('#rep001_00_00').show();
} // .end of rep001_00_00_updateUI

/**
 * Hide Panel
 */
function rep001_00_00_hide()
{
    $('#rep001_00_00').hide();
} // .end of rep001_00_00_hide

</script>