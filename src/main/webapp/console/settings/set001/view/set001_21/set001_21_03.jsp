<!-- SET001_01_06: Billing Settings - Workflow -->
<div id="set001_21_03" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	ACCESS RIGHTS
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
            <tbody id="set001_21_03_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var set001_21_03_initialized = false;

/**
 * Init Panel
 */
function set001_21_03_init()
{
    if (set001_21_03_initialized == true)
        return false;
            
	set001_21_03_initialized = true;
} // .end of set001_21_03_init

/**
 * Show Panel
 */
function set001_21_03_updateUI()
{
    set001_21_03_init();
    
  	
    $('#set001_21_03').show();
} // .end of set001_21_03_updateUI

/**
 * Hide Panel
 */
function set001_21_03_hide()
{
    $('#set001_21_03').hide();
} // .end of set001_21_03_hide

</script>