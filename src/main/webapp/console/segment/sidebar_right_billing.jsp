<style>
.sidebar-component-wrapper {
    float: right;
    margin-top: -8px;
}
.sidebar-component-input {
    width: 160px;
    text-align: right;
}

</style>

<div id="right-sidebar">
    <div class="sidebar-container">

        <ul class="nav nav-tabs navs-3">

            <li class="active">
                <a data-toggle="tab" href="#tab-1">
                   <i class="fa fa-gear" aria-hidden="true"></i> General
                </a>
            </li>
            <li>
                <a data-toggle="tab" href="#tab-2">
                    <i class="fa fa-file-text-o" aria-hidden="true"></i> Reports
                </a>
            </li>
            <li>
                <a data-toggle="tab" href="#tab-3">
                    <i class="fa fa-history" aria-hidden="true"></i> History
                </a>
            </li>
        </ul>

        <div class="tab-content">


            <div id="tab-1" class="tab-pane active">

                <div class="sidebar-title">
                    <h3><i class="fa fa-gears"></i> Billing Settings</h3>
                    <small><i class="fa fa-tim"></i> footnote about settings...</small>
                </div>
				
				<div class="setings-item">
                    <span>
                        Currency Code
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <select class="form-control m-b" id="general_currencyCode">
                            <option value="">- Select -</option>
                            <option value="BND">Brunei Dollar</option>
                            <option value="KHR">Cambodian Riel</option>
                            <option value="IDR">Indonesian Rupiah</option>
                            <option value="LAK">Lao Kip</option>
                            <option value="MYR">Malaysian Ringgit</option>
                            <option value="MMK">Myanmar Kyat</option>
                            <option value="PHP">Philippine Peso</option>
                            <option value="SGD">Singapore Dollar</option>
                            <option value="THB">Thai Baht</option>
                            <option value="VND">Vietnamese Dong</option>
                        </select>

                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        GST Enabled
                    </span>
                    <div class="switch" onclick="stateChanged_gstEnabled();">
                        <div class="onoffswitch">
                            <input id="general_gstEnabled" type="checkbox" name="collapsemenu" class="onoffswitch-checkbox">
                            <label class="onoffswitch-label" for="example">
                                <span class="onoffswitch-inner"></span>
                                <span class="onoffswitch-switch"></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        GST Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_gstNumber" type="text" placeholder="GST Number" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                
                <div class="setings-item">
                    <span>
                        Billing No - Prefix
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_billingPrefix" type="text" placeholder="e.g. BIL-" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Billing No - Next Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_billingNextNo" type="text" placeholder="" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Billing No - Max Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_billingMaxNo" type="text" placeholder="e.g. 9999999" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                
                <div class="setings-item">
                    <span>
                        Delivery No - Prefix
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_deliveryPrefix" type="text" placeholder="e.g. DO-" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Delivery No - Next Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_deliveryNextNo" type="text" placeholder="" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Delivery No - Max Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_deliveryMaxNo" type="text" placeholder="e.g. 9999999" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                
                <div class="setings-item">
                    <span>
                        Invoice No - Prefix
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_invoicePrefix" type="text" placeholder="e.g. INV" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Invoice No - Next Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_invoiceNextNo" type="text" placeholder="" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Invoice No - Max Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_invoiceMaxNo" type="text" placeholder="e.g. 9999999" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                
                <div class="setings-item">
                    <span>
                        Receipt No - Prefix
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_receiptPrefix" type="text" placeholder="e.g. RCP-" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Receipt No - Next Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_receiptNextNo" type="text" placeholder="" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                <div class="setings-item">
                    <span>
                        Receipt No - Max Number
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <input id="general_receiptMaxNo" type="text" placeholder="e.g. 9999999" class="form-control sidebar-component-input" value>
                    </div>
                </div>
                
                <div class="sidebar-content">
                    <div class="text-center">
                        <a data-toggle="modal" class="btn btn-sm btn-warning pull-right" href="#modal-form" style="margin-left:5px;" onclick="closeSettings();">Close</a>
                        <a data-toggle="modal" class="btn btn-sm btn-primary pull-right" href="#modal-form" onclick="saveSettings();">Save Changes</a>
                    </div>
                </div>

            </div>

            <div id="tab-2" class="tab-pane">

                <div class="sidebar-title">
                    <h3> <i class="fa fa-cube"></i> Available Documents for Printing</h3>
                    <small><i class="fa fa-tim"></i> Select document as template.</small>
                </div>

                <div class="setings-item">
                    <span>
                        Tax Invoice Template
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <select id="invoice-selection" class="form-control m-b" style="margin:0;" onclick="selectionChanged_invoice();">
				            <option value="">Select</option>
			            </select>
                    </div>
                </div>
                
                <div id="invoice-fieldList">	                
	            </div>
                
                <div class="setings-item">
                    <span>
                        Receipt Template
                    </span>
                    <div class="form-group sidebar-component-wrapper">
                        <select id="receipt-selection" class="form-control m-b" style="margin:0;" onclick="selectionChanged_receipt();">
				            <option value="">Select</option>
			            </select>
                    </div>
                </div>
                
                <div id="receipt-fieldList">	                
	            </div>
                
                <div class="sidebar-content">
                    <div class="text-center">
                        <a data-toggle="modal" class="btn btn-sm btn-warning pull-right" href="#modal-form" style="margin-left:5px;" onclick="closeSettings();">Close</a>
                        <a data-toggle="modal" class="btn btn-sm btn-primary pull-right" href="#modal-form" onclick="saveSettings();">Save Changes</a>
                    </div>
                </div>
            </div>

            <div id="tab-3" class="tab-pane">

                <div class="sidebar-title">
                    <h3><i class="fa fa-gears"></i> Settings</h3>
                    <small><i class="fa fa-tim"></i> You have 14 projects. 10 not completed.</small>
                </div>

                <ul class="sidebar-list">
                    <li>
                        <a href="#">
                            <div class="small pull-right m-t-xs">9 hours ago</div>
                            <h4>Business valuation</h4>
                            It is a long established fact that a reader will be distracted.

                            <div class="small">Completion with: 22%</div>
                            <div class="progress progress-mini">
                                <div style="width: 22%;" class="progress-bar progress-bar-warning"></div>
                            </div>
                            <div class="small text-muted m-t-xs">Project end: 4:00 pm - 12.06.2014</div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="small pull-right m-t-xs">9 hours ago</div>
                            <h4>Contract with Company </h4>
                            Many desktop publishing packages and web page editors.

                            <div class="small">Completion with: 48%</div>
                            <div class="progress progress-mini">
                                <div style="width: 48%;" class="progress-bar"></div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="small pull-right m-t-xs">9 hours ago</div>
                            <h4>Meeting</h4>
                            By the readable content of a page when looking at its layout.

                            <div class="small">Completion with: 14%</div>
                            <div class="progress progress-mini">
                                <div style="width: 14%;" class="progress-bar progress-bar-info"></div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="label label-primary pull-right">NEW</span>
                            <h4>The generated</h4>
                            There are many variations of passages of Lorem Ipsum available.
                            <div class="small">Completion with: 22%</div>
                            <div class="small text-muted m-t-xs">Project end: 4:00 pm - 12.06.2014</div>
                        </a>
                    </li>
                </ul>

            </div>
        </div>
    </div>
</div>

<script>

function init_billingSidebar() 
{	 /*
	// Tab 1: General
    var settingsObj_selectedCurrencyCode= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_SELECTED_CURRENCY_CODE);
    var settingsObj_gstEnabled      	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_GST_ENABLED);
    var settingsObj_gstNumber       	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_GST_NUMBER);
    var settingsObj_billingPrefix   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_BILLING_NUMBER_PREFIX);
    var settingsObj_billingNextNo   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_BILLING_NUMBER_NEXT_NO);
    var settingsObj_billingMaxNo    	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_BILLING_NUMBER_MAX_NO);
    var settingsObj_deliveryPrefix  	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_DELIVERY_NUMBER_PREFIX);
    var settingsObj_deliveryNextNo  	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_DELIVERY_NUMBER_NEXT_NO);
    var settingsObj_deliveryMaxNo   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_DELIVERY_NUMBER_MAX_NO);
    var settingsObj_invoicePrefix   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_INVOICE_NUMBER_PREFIX);
    var settingsObj_invoiceNextNo   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_INVOICE_NUMBER_NEXT_NO);
    var settingsObj_invoiceMaxNo    	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_INVOICE_NUMBER_MAX_NO);
    var settingsObj_receiptPrefix   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_RECEIPT_NUMBER_PREFIX);
    var settingsObj_receiptNextNo   	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_RECEIPT_NUMBER_NEXT_NO);
    var settingsObj_receiptMaxNo    	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_RECEIPT_NUMBER_MAX_NO);
    var settingsObj_selectedInvoiceCode	= Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_SELECTED_INVOICE_CODE);
    var settingsObj_selectedReceiptCode = Cached_getSettingsByKey(AppConstants.BILLING_SETTINGS_KEY_SELECTED_RECEIPT_CODE);
    
    console.log('settingsObj_gstEnabled='+settingsObj_gstEnabled.propValue);
    if (settingsObj_gstNumber.propValue=='true') {
        $('#general_gstEnabled').prop('checked', true);
        $('#general_gstNumber').prop('disabled', false);
    } else {
        $('#general_gstEnabled').prop('checked', false);
        $('#general_gstNumber').prop('disabled', true);
    }
    
    $('#general_currencyCode').val(settingsObj_selectedCurrencyCode.propValue);
    $('#general_gstNumber').val(settingsObj_gstNumber.propValue);
    $('#general_billingPrefix').val(settingsObj_billingPrefix.propValue);
    $('#general_billingNextNo').val(settingsObj_billingNextNo.propValue);
    $('#general_billingMaxNo').val(settingsObj_billingMaxNo.propValue);
    $('#general_deliveryPrefix').val(settingsObj_deliveryPrefix.propValue);
    $('#general_deliveryNextNo').val(settingsObj_deliveryNextNo.propValue);
    $('#general_deliveryMaxNo').val(settingsObj_deliveryMaxNo.propValue);
    $('#general_invoicePrefix').val(settingsObj_invoicePrefix.propValue);
    $('#general_invoiceNextNo').val(settingsObj_invoiceNextNo.propValue);
    $('#general_invoiceMaxNo').val(settingsObj_invoiceMaxNo.propValue);
    $('#general_receiptPrefix').val(settingsObj_receiptPrefix.propValue);
    $('#general_receiptNextNo').val(settingsObj_receiptNextNo.propValue);
    $('#general_receiptMaxNo').val(settingsObj_receiptMaxNo.propValue);
    
    // Tab 2: Tax Invoice
	$('#invoice-selection').empty();
	$('#invoice-selection').append('<option value="">--- SELECT ---</option>');
    $.each(Cached_getDocumentList(), function(i, documentObj){
    	
    	if (documentObj.docType=='billing_invoice') 
    	{
    		$('#invoice-selection').append('<option value="' + documentObj.docCode + '">' + documentObj.docName + '</option>');
    	}
    });
    $('#invoice-selection').val(settingsObj_selectedInvoiceCode.propValue);
    selectionChanged_invoice();
    
    // Tab 2: Receipt
    $('#receipt-selection').empty();
	$('#receipt-selection').append('<option value="">--- SELECT ---</option>');
    $.each(Cached_getDocumentList(), function(i, documentObj){
    	
    	if (documentObj.docType=='billing_receipt') 
    	{
    		$('#receipt-selection').append('<option value="' + documentObj.docCode + '">' + documentObj.docName + '</option>');
    	}
    });
    $('#receipt-selection').val(settingsObj_selectedReceiptCode.propValue);
    selectionChanged_receipt();
    
    // Tab 3
    */
}

function stateChanged_gstEnabled() 
{
    var gstEnabled = $('#general_gstEnabled').prop('checked');
    
    if (gstEnabled==false || gstEnabled=='false') // equiv false
    {
        $('#general_gstEnabled').prop('checked', true);
        $('#general_gstNumber').prop('disabled', false);
    }
    else
    {
        $('#general_gstEnabled').prop('checked', false);
        $('#general_gstNumber').prop('disabled', true);
    }
    
} // .end of stateChanged_gstEnabled

function selectionChanged_invoice()
{
	var elementObj = $('#invoice-selection');
	$('#invoice-fieldList').empty();
	
	if (elementObj.val() != '')
	{		
		var documentObj = Cached_getDocumentByCode(elementObj.val());
		$.each(documentObj.propertiesList, function(i, propObj){
			
			var htmlLines = '<div class="setings-item">';
			htmlLines += '<span>';
			htmlLines += propObj.propName;
			htmlLines += '</span>';
			htmlLines += '<div class="form-group">';
			
			if (propObj.propType=='textarea') 
			{
				htmlLines += '<textarea id="' + propObj.id + '" rows="4" cols="50" class="form-control m-b" style="margin:0;">';
				htmlLines += propObj.propValue;
				htmlLines += '</textarea>';
			}
			
			if (propObj.propType=='text')
			{
				htmlLines += '<input id="' + propObj.id + '" type="text" placeholder="" class="form-control" style="margin:0;" value="' + propObj.propValue + '">';
			}
			
			htmlLines += '</div>';
			htmlLines += '</div>';		

			$('#invoice-fieldList').append(htmlLines);
		});
	}
	
} // .end of selectionChanged_invoice


function selectionChanged_receipt()
{
	var elementObj = $('#receipt-selection');
	console.log('You selected ' + elementObj.val());
	
} // .end of selectionChanged_receipt

function saveSettings()
{
} // .end of saveSettings


function closeSettings()
{
    $('#right-sidebar').removeClass('sidebar-open');
} // .end of closeSettings

</script>