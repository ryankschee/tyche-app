<!-- rep001_01_01: Custom Report - Orders -->
<div id="rep001_01_01" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	CUSTOM REPORT 1
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
            <tbody id="rep001_01_01_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var rep001_01_01_initialized = false;

/**
 * Init Panel
 */
function rep001_01_01_init()
{
    if (rep001_01_01_initialized == true)
        return false;
            
	rep001_01_01_initialized = true;
} // .end of rep001_01_01_init

/**
 * Show Panel
 */
function rep001_01_01_updateUI()
{
    rep001_01_01_init();
    
  	
    $('#rep001_01_01').show();
} // .end of rep001_01_01_updateUI

/**
 * Hide Panel
 */
function rep001_01_01_hide()
{
    $('#rep001_01_01').hide();
} // .end of rep001_01_01_hide

</script>