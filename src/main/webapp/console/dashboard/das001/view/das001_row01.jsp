<div class="row" id="das001_row01">
    <div class="col-lg-3">
        <div id="moduleButton_pos" class="widget style1 yellow-bg" onclick="tycheesCommon_gotoModule('ModuleBilling')" style="cursor:pointer;">
            <div class="row vertical-align">
                <div class="col-xs-3">
                    <i class="fa fa-shopping-bag fa-3x" aria-hidden="true"></i>
                </div>
                <div class="col-xs-9 text-right">
                    <h3 class="font-bold" data-i18n="module.row01-billing-title">$POS_TITLE</h3>
                    <span data-i18n="module.row01-billing-desc">$POS_DESC</span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div id="moduleButton_inventoryCategory" class="widget style1 navy-bg" onclick="tycheesCommon_gotoModule('ModuleInventory')" style="cursor:pointer;">
            <div class="row vertical-align">
                <div class="col-xs-3">
                    <i class="fa fa-sitemap fa-3x" aria-hidden="true"></i>
                </div>
                <div class="col-xs-9 text-right">
                    <h3 class="font-bold" data-i18n="module.row01-inventory-title">$INV_TITLE</h3>
                    <span data-i18n="module.row01-inventory-desc">$INV_DESC</span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div id="moduleButton_inventoryItem" class="widget style1 navy-bg" onclick="tycheesCommon_gotoModule('ModuleRelation')" style="cursor:pointer;">
            <div class="row vertical-align">
                <div class="col-xs-3">
                    <i class="fa fa-product-hunt fa-3x" aria-hidden="true"></i>
                </div>
                <div class="col-xs-9 text-right">
                    <h3 class="font-bold" data-i18n="module.row01-relation-title">$REL_TITLE</h3>
                    <span data-i18n="module.row01-relation-desc">$REL_DESC</span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div id="moduleButton_inventoryTransaction" class="widget style1 navy-bg" onclick="tycheesCommon_gotoModule('ModulePlace')" style="cursor:pointer;">
            <div class="row vertical-align">
                <div class="col-xs-3">
                    <i class="fa fa-cart-arrow-down fa-3x" aria-hidden="true"></i>
                </div>
                <div class="col-xs-9 text-right">
                    <h3 class="font-bold" data-i18n="module.row01-mystores-title">$STORE_TITLE</h3>
                    <span data-i18n="module.row01-mystores-desc">$STORE_DESC</span>
                </div>
            </div>
        </div>
    </div>
    <!--
    <div class="col-lg-2">
        <div id="moduleButton_customer" class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule(MODULE_PAGE_NAME_CUSTOMER)" style="cursor:pointer;">
            <div class="row vertical-align">
                <div class="col-xs-3">
                    <i class="fa fa-user fa-3x" aria-hidden="true"></i>
                </div>
                <div class="col-xs-9 text-right">
                    <h3 class="font-bold">Customer</h3>
                    <span> Settings </span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-2">
        <div id="moduleButton_vendor" class="widget style1 lazur-bg" onclick="tycheesCommon_gotoModule(MODULE_PAGE_NAME_VENDOR)" style="cursor:pointer;">
            <div class="row vertical-align">
                <div class="col-xs-3">
                    <i class="fa fa-truck fa-3x" aria-hidden="true"></i>
                </div>
                <div class="col-xs-9 text-right">
                    <h3 class="font-bold">Vendor</h3>
                    <span> Settings </span>
                </div>
            </div>
        </div>
    </div>
    -->
</div> <!-- .end of row -->


<script>

var das001_row01_initialized = false;

/**
 * Init variables / states / components. 
 */
function das001_row01_init()
{
    if (das001_row01_initialized==true)
        return false;
        
    
    das001_row01_initialized = true;
} // .end of das001_row01_init


/**
 * Setup values. 
 */
function das001_row01_updateUI()
{
    // Init segment
    das001_row01_init();
    
    // Show segment
    $('#das001_row01').show();
} // .end of das001_row01_updateUI

</script>