<!-- SET001_31_00: Search Filter: General -->
<div id="set001_31_00" style="display:none;">
    <span style="font-family:inherit; font-size:16pt; font-weight:normal;">
    	BILLING SEARCH FILTER
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
            <tbody id="set001_31_00_table">
            </tbody>
        </table>
    </div>
</div>

<script>

var set001_31_00_initialized = false;

/**
 * Init Panel
 */
function set001_31_00_init()
{
    if (set001_31_00_initialized == true)
        return false;
            
	set001_31_00_initialized = true;
} // .end of set001_31_00_init

/**
 * Show Panel
 */
function set001_31_00_updateUI()
{
    set001_31_00_init();
    
  	
    $('#set001_31_00').show();
} // .end of set001_31_00_updateUI

/**
 * Hide Panel
 */
function set001_31_00_hide()
{
    $('#set001_31_00').hide();
} // .end of set001_31_00_hide

</script>