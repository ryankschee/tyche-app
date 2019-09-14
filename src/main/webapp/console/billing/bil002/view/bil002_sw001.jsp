
<style>
    #bil002_sw001 {
        background-color: #fff;
        border-left: 1px solid #e7eaec;
        border-top: 1px solid #e7eaec;
        overflow: hidden;
        position: fixed;
        top: 60px;
        width: 50% !important;
        z-index: 1009;
        bottom: 0;
        right: -50%;
    }
    #bil002_sw001.sidebar-open {
        right: 0;
    }
    #bil002_sw001.sidebar-open.sidebar-top {
        top: 0;
        border-top: none;
    }

</style>

<div id="bil002_sw001" class="animated fadeInRight">
    <div class="sidebar-container">
        <div class="sidebar-title" style="padding:10px; background-color:#404040; color:#FFF;">
            <span id="bil002_sw001_tableNameElement" style="font-size:18px;display:none;"> 
                <span id="bil002_sw001_tableName" style="color:#f8ac59; font-size:24pt; padding:5px 5px;">TABLE NAME</span>
                <i id="bil002_sw001_header_slideInButton" class="fa fa-chevron-circle-right fa-2x pull-right" aria-hidden="true" style="color:#FFFFFF; cursor:pointer; margin:5px 5px;" onclick="bil002_sw001_slideIn();"></i>
                <i id="bil002_sw001_header_cancelBucketButton" class="fa fa-times-circle fa-2x pull-right ladda-button" data-style="zoom-in" aria-hidden="true" style="color:#ED5565; cursor:pointer; margin:5px 5px;" onclick="bil002_sw001_cancelBucket(this);"></i>
                <i id="bil002_sw001_header_saveBucketButton" class="fa fa-floppy-o fa-2x pull-right ladda-button" data-style="zoom-in" aria-hidden="true" style="color:#1AB394; cursor:pointer; margin:5px 5px;" onclick="bil002_sw001_saveBucket();"></i>
                <i id="bil002_sw001_header_printBucketButton" class="fa fa-print fa-2x pull-right ladda-button" data-style="zoom-in" aria-hidden="true" style="color:#1AB394; cursor:pointer; margin:5px 5px;" onclick="bil002_printBucket();"></i>
            </span>
            <div id="bil002_sw001_spinner" class="spiner-example" style="display:none; padding:0px; height:28px;">
				<div class="sk-spinner sk-spinner-wave">
				    <div class="sk-rect1"></div>
				    <div class="sk-rect2"></div>
				    <div class="sk-rect3"></div>
				    <div class="sk-rect4"></div>
				    <div class="sk-rect5"></div>
				</div>
			</div>
        </div>
        <div id="bil002_sw001_buttonPanel" class="row" style="padding:0px 25px; background-color:#ddd;">
            <div class="col-md-3 col-lg-3" style="cursor:pointer; padding:5px 5px;" onclick="bil002_sw001_openTable();">
                <div id="bil002_sw001_openTableButton" class="navy-bg" style="border-radius:5px; padding:5px 20px;">
                    <div class="row vertical-align">
                        <div class="col-xs-3" style="padding:2px 2px;">
                            <i class="fa fa-folder-open-o fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-9 text-right" style="padding:2px 5px;">
                            <span id="bil002_sw001_openTableButton_text" style="font-size:16px;">OPEN</span>
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-md-3 col-lg-3" style="cursor:pointer; padding:5px 5px;" onclick="bil002_sw001_reserveTable();">
                <div id="bil002_sw001_reserveTableButton" class="navy-bg" style="border-radius:5px; padding:5px 20px;">
                    <div class="row vertical-align">
                        <div class="col-xs-3" style="padding:2px 2px;">
                            <i class="fa fa-lock fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-9 text-right" style="padding:2px 5px;">
                            <span id="bil002_sw001_reserveTableButton_text" style="font-size:16px;">RESERVE</span>
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-md-3 col-lg-3" style="cursor:pointer; padding:5px 5px;" onclick="bil002_sw001_addItem();">
                <div id="bil002_sw001_addItemButton" class="navy-bg" style="border-radius:5px; padding:5px 20px;">
                    <div class="row vertical-align">
                        <div class="col-xs-3" style="padding:2px 2px;">
                            <i class="fa fa-cart-plus fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-9 text-right" style="padding:2px 5px;">
                            <span id="bil002_sw001_addItemButton_text" style="font-size:16px;">CART</span>
                        </div>
                    </div>
                </div>
            </div>   
            <div class="col-md-3 col-lg-3" style="cursor:pointer; padding:5px 5px;" onclick="bil002_sw001_goPayment();">
                <div id="bil002_sw001_payBillButton" class="navy-bg" style="border-radius:5px; padding:5px 20px;">
                    <div class="row vertical-align">
                        <div class="col-xs-3" style="padding:2px 2px;">
                            <i class="fa fa-usd fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-9 text-right" style="padding:2px 5px;">
                            <span id="bil002_sw001_payBillButton_text" style="font-size:16px;">PAY BILL</span>
                        </div>
                    </div>
                </div>
            </div>                
        </div>
        <ul id="bil002_sw001_tabHeaderRoot" class="nav nav-tabs navs-4">
            <li class="active" id="bil002_sw001_tabHeader1">
                <a data-toggle="tab" href="#tab-1">  
                    BASIC
                </a>
            </li>
            <li id="bil002_sw001_tabHeader2">
                <a data-toggle="tab" href="#tab-2">
                    TRACKING
                </a>
            </li>
            <li id="bil002_sw001_tabHeader3">
                <a data-toggle="tab" href="#tab-3">
                    ITEMS
                </a>
            </li>
            <li id="bil002_sw001_tabHeader4">
                <a data-toggle="tab" href="#tab-4">
                    BILLING
                </a>
            </li>
        </ul>
        
        <div id="bil002_sw001_tabContentRoot" class="tab-content">        	
            <div id="tab-1" class="tab-pane active">                
                <div class="sidebar-title">
                    <div id="bil002_sw001_tab1_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='bil002_sw001_tab1_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                
                <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    TABLE STATUS
					    </span>
					</div>
					<div class="col-md-12 input-group m-b">
						<input type="text" class="form-control" id="bil002_sw001_status" maxlength="90" disabled>
						<span class="input-group-btn"> 
							<button id="bil002_sw001_cancelBucketBtn" type="button" class="btn btn-grey ladda-button" data-style="zoom-in" style="width:100px;" onclick="bil002_sw001_cancelBucket(this)">
								<i class="fa fa-times-circle" aria-hidden="true"></i> CANCEL
							</button> 
					    </span>
					</div>
	            </div>  
                <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    PAX COUNT
					    </span>
					</div>
					<div class="col-md-12 input-group m-b">
						<input type="number" class="form-control tab1-input" id="bil002_sw001_paxCount" maxlength="90" required disabled oninput="bil002_sw001_saveBucket()">
						<span id="bil002_sw001_paxMaxCount" class="input-group-addon" style="width:100px;">MAX: 99</span>
					</div>
	            </div>	
	            <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    CUSTOMER NAME
					    </span>
					</div>
					<div class="col-md-12 input-group m-b">
						<input type="text" class="form-control tab1-input" id="bil002_sw001_customerName" maxlength="90" disabled>
						<span class="input-group-btn"> 
							<button id="bil002_sw001_customerSelector" type="button" class="btn btn-grey" style="width:100px;" onclick="bil002_sw001_selectCustomer()"><i class="fa fa-search" aria-hidden="true"></i> SELECT</button> 
					    </span>
					</div>
	            </div>	
	            <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    CUSTOMER CONTACT
					    </span>
					</div>
					<div class="col-md-12 input-group m-b">
						<input type="text" class="form-control tab1-input" id="bil002_sw001_customerContact" maxlength="90" disabled>
					</div>
	            </div>
                <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    SERVED BY
					    </span>
					</div>
					<div class="col-md-12 input-group m-b">
						<input type="text" class="form-control" id="bil002_sw001_servedBy" maxlength="90" disabled>
					</div>
	            </div>            
            </div>
            
            <div id="tab-2" class="tab-pane">                
                <div class="sidebar-title">
                    <div id="bil002_sw001_tab2_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='bil002_sw001_tab2_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                
                <div class="setings-item" id="bil002_sw001_reservedOn" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    RESERVED ON
					    </span>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_reservedOnDate" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_reservedOnTime" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
	            </div>	
	            <div class="setings-item" id="bil002_sw001_reservationOn" style="height:110px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    RESERVATION ON
					    </span>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_reservationOnDateFrom" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_reservationOnTimeFrom" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_reservationOnDateTo" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_reservationOnTimeTo" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
	            </div>	
	            <div class="setings-item" id="bil002_sw001_seatedOn" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    SEATED ON
					    </span>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_seatedOnDate" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_seatedOnTime" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
	            </div>	
	            <div class="setings-item" id="bil002_sw001_orderedOn" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    LAST ORDERED ON
					    </span>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_orderedOnDate" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_orderedOnTime" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
	            </div>	  
	            <div class="setings-item" id="bil002_sw001_completedOn" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    SERVED COMPLETEDLY ON
					    </span>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_completedOnDate" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_completedOnTime" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
	            </div>		  
	            <div class="setings-item" id="bil002_sw001_leftOn" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    CUSTOMERS LEFT ON
					    </span>
					</div>
					<div class="col-md-12">
						<div class="input-group date">
                            <span class="input-group-addon">
                            	<i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
	                        <input id="bil002_sw001_leftOnDate" type="text" class="form-control date-picker tab2-input" data-mask="99/99/9999" placeholder="dd/MM/yyyy" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon" style="background-color:#DDDDDD;">on</span>
							<input id="bil002_sw001_leftOnTime" type="text" class="form-control clock-picker tab2-input" value="12:00" data-mask="99:99" placeholder="hh:mm" oninput="bil002_sw001_saveBucket()">
							<span class="input-group-addon">
                            	<span class="fa fa-clock-o" aria-hidden="true"></span>
                            </span>
                        </div>
					</div>
	            </div>	            
            </div>

            <div id="tab-3" class="tab-pane">
                <div class="sidebar-title">
                    <div id="bil002_sw001_tab3_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='bil002_sw001_tab3_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                <div id="bil002_sw001_items">  
                	<div id="bil002_sw001_items_spinner" class="spiner-example" style="display:none; padding:20px; height:28px;">
						<div class="sk-spinner sk-spinner-wave">
						    <div class="sk-rect1"></div>
						    <div class="sk-rect2"></div>
						    <div class="sk-rect3"></div>
						    <div class="sk-rect4"></div>
						    <div class="sk-rect5"></div>
						</div>
					</div>   
					<div id="bil002_sw001_items_content" style="display:none; padding:10px 20px;">
	                	<table id="bil002_sw001_items_dataTable" class="table table-striped table-bordered table-hover">
	   	                    <thead>
	   	                        <tr>
	   	                            <th>ITEM</th>
	   	                            <th>PRICE</th>
	   	                            <th>QTY</th>
	   	                            <th>ACTION</th>
	   	                        </tr>
	   	                    </thead>
	   	                    <tbody>
	   	                    </tbody>
	   	                </table>      
	   	            </div>     	
                </div>
            </div>
            
            <div id="tab-4" class="tab-pane">
                <div class="sidebar-title">
                    <div id="bil002_sw001_tab4_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='bil002_sw001_tab4_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                <div id="bil002_sw001_billings">  
                	<div id="bil002_sw001_billings_spinner" class="spiner-example" style="display:none; padding:20px; height:28px;">
						<div class="sk-spinner sk-spinner-wave">
						    <div class="sk-rect1"></div>
						    <div class="sk-rect2"></div>
						    <div class="sk-rect3"></div>
						    <div class="sk-rect4"></div>
						    <div class="sk-rect5"></div>
						</div>
					</div>   
					<div id="bil002_sw001_billings_content" style="display:none; padding:10px 20px;">
	                	<table id="bil002_sw001_billings_dataTable" class="table table-striped table-bordered table-hover">
	   	                    <thead>
	   	                        <tr>
	   	                            <th>CREATED ON</th>
	   	                            <th>DATE</th>
	   	                            <th>BILLING NO</th>
	   	                            <th>AMOUNT</th>
	   	                            <th>STATUS</th>
	   	                        </tr>
	   	                    </thead>
	   	                    <tbody>
	   	                    </tbody>
	   	                </table>      
	   	            </div>     	
                </div>
            </div>
        </div>
    </div>
</div>


<script>

var bil002_sw001_initialized = false;
var bil002_sw001_isUpdatingUI = false;

function bil002_sw001_init()
{
	if (bil002_sw001_initialized)
		return false;
		
    // Init iCheck
    $('.bil002_sw001_ichecks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    		
	// Init DatePicker
	$('.date-picker').datepicker({
    	format: 'dd/mm/yyyy',
    	todayBtn: 'linked',
    	todayHighlight: true,
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
		 
	// Init ClockPicker
	$('.clock-picker').clockpicker({
	    placement: 'top',
	    align: 'left',
	    donetext: 'Done'
	});
	   
    // Init DataTable
    $('#bil002_sw001_items_dataTable').DataTable();
    $('#bil002_sw001_billings_dataTable').DataTable();
    
    $('#bil002_sw001_tabHeader3').on('click', function(event) {
    	bil002_sw001_updateUI_tab3();
    });
    $('#bil002_sw001_tabHeader4').on('click', function(event) {
    	bil002_sw001_updateUI_tab4();
    });
    
	$("#bil002_sw001 .date-picker").on('change', function(){				
	    // Auto-save Billing
	    bil002_sw001_saveBucket();			    
	});
	
	$("#bil002_sw001 .clock-picker").on('change', function(){				
	    // Auto-save Billing
	    bil002_sw001_saveBucket();			    
	});
	
    bil002_sw001_initialized = true;
} // .end of bil002_sw001_init

/**
 * Open this by sliding out from right-side.
 */
function bil002_sw001_slideOut()
{
	if ( $('#bil002_sw001').hasClass('sidebar-open')==false )
		$('#bil002_sw001').toggleClass('sidebar-open');	
} // .end of bil002_sw001_slideOut

/**
 * Close this by sliding into right-side.
 */
function bil002_sw001_slideIn()
{
	if ( $('#bil002_sw001').hasClass('sidebar-open')==true )
		$('#bil002_sw001').toggleClass('sidebar-open');
} // .end of bil002_sw001_slideIn

function bil002_sw001_showSpinner(showing)
{
	if (showing)
	{
		$('#bil002_sw001_tableNameElement').hide();
		$('#bil002_sw001_spinner').show();
		
		$('#bil002_sw001_buttonPanel').hide();
		$('#bil002_sw001_tabHeaderRoot').hide();
		$('#bil002_sw001_tabContentRoot').hide();
	}
	else
	{
		$('#bil002_sw001_tableNameElement').show();
		$('#bil002_sw001_spinner').hide();
		
		$('#bil002_sw001_buttonPanel').show();
		$('#bil002_sw001_tabHeaderRoot').show();
		$('#bil002_sw001_tabContentRoot').show();
		
	}
} // .end of bil002_sw001_showSpinner

function bil002_sw001_updateUI()
{
	if (global_placeLayoutComponentObj == null) {
		tycheesLogger_showToast('error', 'System Error', 'Null Layout Component Found')
		return false;
	}
	
	// Reset	
	$('#bil002_sw001_tabHeader1').addClass('active');
	$('#bil002_sw001_tabHeader2').removeClass('active');
	$('#bil002_sw001_tabHeader3').removeClass('active');
	$('#bil002_sw001_tabHeader4').removeClass('active');
	$('#tab-1').addClass('active');
	$('#tab-2').removeClass('active');
	$('#tab-3').removeClass('active');
	$('#tab-4').removeClass('active');
	
	// Init, if any.	
    bil002_sw001_init();
    bil002_sw001_isUpdatingUI = true;
    
    // HEADER PANEL: Update UI
    bil002_sw001_updateUI_headerPanel();    
    // BUTTON PANEL: Update UI
    bil002_sw001_updateUI_buttonPanel(); 
    // TAB 1: Update UI
    bil002_sw001_updateUI_tab1(); 
    // TAB 2: Update UI
    bil002_sw001_updateUI_tab2(); 
    
    // Paint background for each row of field
	$("#tab-1 .setings-item").each(function(i) {
		if (i%2==0)  
			$(this).css('background-color','#FFF');
		else
			$(this).css('background-color','#F9F9F9');
	});
	$("#tab-2 .setings-item").each(function(i) {
		if (i%2==0)  
			$(this).css('background-color','#FFF');
		else
			$(this).css('background-color','#F9F9F9');
	});
    
    bil002_sw001_isUpdatingUI = false;
    // Hide Sliding Window
    bil002_sw001_showSpinner(false);
} // .end of bil002_sw001_updateUI

function bil002_sw001_updateUI_headerPanel()
{
	// Set Bucket Name
	$('#bil002_sw001_tableName').html(global_placeLayoutComponentObj.name);
	
	if (global_billingBucketObj == null || 
		$.trim(global_billingBucketObj.bucketStatus) == '' || 
		$.trim(global_billingBucketObj.bucketStatus) == BillingConstants.BUCKET_STATUS_AVAILABLE)
	{
		$('#bil002_sw001_header_slideInButton').show();
		$('#bil002_sw001_header_cancelBucketButton').hide();
		$('#bil002_sw001_header_saveBucketButton').hide();
		$('#bil002_sw001_header_printBucketButton').hide();
	}
	else
	{
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING) {
			$('#bil002_sw001_header_slideInButton').show();
			$('#bil002_sw001_header_cancelBucketButton').show();
			$('#bil002_sw001_header_saveBucketButton').show();	
			$('#bil002_sw001_header_printBucketButton').show();
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
			$('#bil002_sw001_header_slideInButton').show();
			$('#bil002_sw001_header_cancelBucketButton').show();
			$('#bil002_sw001_header_saveBucketButton').show();	
			$('#bil002_sw001_header_printBucketButton').show();
		} else {
			$('#bil002_sw001_header_slideInButton').show();
			$('#bil002_sw001_header_cancelBucketButton').hide();
			$('#bil002_sw001_header_saveBucketButton').hide();	
			$('#bil002_sw001_header_printBucketButton').hide();
		}
	}
} // .end of bil002_sw001_updateUI_headerPanel

function bil002_sw001_updateUI_buttonPanel()
{
	if (global_billingBucketObj == null || 
		$.trim(global_billingBucketObj.bucketStatus) == '' || 
		$.trim(global_billingBucketObj.bucketStatus) == BillingConstants.BUCKET_STATUS_AVAILABLE)
	{
		$('#bil002_sw001_openTableButton').addClass('navy-bg');
		$('#bil002_sw001_openTableButton').removeClass('red-bg');
		$('#bil002_sw001_reserveTableButton').addClass('navy-bg');
		$('#bil002_sw001_reserveTableButton').removeClass('blue-bg');
		$('#bil002_sw001_addItemButton').addClass('grey-bg');
		$('#bil002_sw001_addItemButton').removeClass('navy-bg');
		$('#bil002_sw001_addItemButton').css('border','2pt');
		$('#bil002_sw001_addItemButton').css('border-color','#777');
		$('#bil002_sw001_addItemButton').css('border-style','dashed');
		$('#bil002_sw001_payBillButton').addClass('grey-bg');
		$('#bil002_sw001_payBillButton').removeClass('navy-bg');
		$('#bil002_sw001_payBillButton').css('border','2pt');
		$('#bil002_sw001_payBillButton').css('border-color','#777');
		$('#bil002_sw001_payBillButton').css('border-style','dashed');
		
		$('#bil002_sw001_openTableButton_text').html('OPEN');
		$('#bil002_sw001_reserveTableButton_text').html('RESERVE');
	}
	else
	{
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING) {
			$('#bil002_sw001_openTableButton').addClass('red-bg');
			$('#bil002_sw001_openTableButton').removeClass('navy-bg');
			$('#bil002_sw001_reserveTableButton').addClass('navy-bg');
			$('#bil002_sw001_reserveTableButton').removeClass('blue-bg');
			$('#bil002_sw001_addItemButton').addClass('navy-bg');
			$('#bil002_sw001_addItemButton').removeClass('grey-bg');
			$('#bil002_sw001_addItemButton').css('border','');
			$('#bil002_sw001_addItemButton').css('border-color','');
			$('#bil002_sw001_addItemButton').css('border-style','');
			$('#bil002_sw001_payBillButton').addClass('navy-bg');
			$('#bil002_sw001_payBillButton').removeClass('grey-bg');
			$('#bil002_sw001_payBillButton').css('border','');
			$('#bil002_sw001_payBillButton').css('border-color','');
			$('#bil002_sw001_payBillButton').css('border-style','');
			
			$('#bil002_sw001_openTableButton_text').html('OPENED');
			$('#bil002_sw001_reserveTableButton_text').html('RESERVE');
		}
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
			$('#bil002_sw001_openTableButton').addClass('navy-bg');
			$('#bil002_sw001_openTableButton').removeClass('red-bg');
			$('#bil002_sw001_reserveTableButton').addClass('blue-bg');
			$('#bil002_sw001_reserveTableButton').removeClass('navy-bg');
			$('#bil002_sw001_addItemButton').addClass('grey-bg');
			$('#bil002_sw001_addItemButton').removeClass('navy-bg');
			$('#bil002_sw001_addItemButton').css('border','2pt');
			$('#bil002_sw001_addItemButton').css('border-color','#777');
			$('#bil002_sw001_addItemButton').css('border-style','dashed');
			$('#bil002_sw001_payBillButton').addClass('grey-bg');
			$('#bil002_sw001_payBillButton').removeClass('navy-bg');
			$('#bil002_sw001_payBillButton').css('border','2pt');
			$('#bil002_sw001_payBillButton').css('border-color','#777');
			$('#bil002_sw001_payBillButton').css('border-style','dashed');
			
			$('#bil002_sw001_openTableButton_text').html('OPEN');
			$('#bil002_sw001_reserveTableButton_text').html('RESERVED');
		}
	}
} // .end of bil002_sw001_updateUI_buttonPanel

function bil002_sw001_updateUI_tab1()
{
	if (global_billingBucketObj == null)
	{
		$('#bil002_sw001_status').val(BillingConstants.BUCKET_STATUS_AVAILABLE);	
		$('#bil002_sw001_status').css('color','#1AB394');
		$('#bil002_sw001_status').css('font-weight','bold');

		$('#bil002_sw001_paxCount').attr('disabled', true);
		$('#bil002_sw001_paxCount').val('0');
		$('#bil002_sw001_paxMaxCount').html('MAX: ' + global_placeLayoutComponentObj.paxCount);
		
		$('#bil002_sw001_servedBy').val('');
		
		$('#bil002_sw001_customerName').val('');
		$('#bil002_sw001_customerContact').val('');
		$('#bil002_sw001_cancelBucketBtn').removeClass('btn-danger');
		$('#bil002_sw001_cancelBucketBtn').addClass('btn-grey');
		$('#bil002_sw001_customerSelector').removeClass('btn-primary');
		$('#bil002_sw001_customerSelector').addClass('btn-grey');
	}
	else
	{
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
			$('#bil002_sw001_status').val(global_billingBucketObj.bucketStatus);	
			$('#bil002_sw001_status').css('color','#428BCA');
			$('#bil002_sw001_status').css('font-weight','bold');
			
			$('#bil002_sw001_paxCount').attr('disabled', false);
			$('#bil002_sw001_paxCount').val(global_billingBucketObj.paxCount);
			$('#bil002_sw001_paxMaxCount').html('MAX: ' + global_placeLayoutComponentObj.paxCount);
			
			$('#bil002_sw001_servedBy').val(global_billingBucketObj.servedBy);
			
			$('#bil002_sw001_customerName').val(global_billingBucketObj.customerName);
			$('#bil002_sw001_customerContact').val(global_billingBucketObj.customerContact);
			$('#bil002_sw001_cancelBucketBtn').addClass('btn-danger');
			$('#bil002_sw001_cancelBucketBtn').removeClass('btn-grey');
			$('#bil002_sw001_customerSelector').addClass('btn-primary');
			$('#bil002_sw001_customerSelector').removeClass('btn-grey');
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING) {
			$('#bil002_sw001_status').val(global_billingBucketObj.bucketStatus);	
			$('#bil002_sw001_status').css('color','#ED5565');
			$('#bil002_sw001_status').css('font-weight','bold');

			$('#bil002_sw001_paxCount').attr('disabled', false);
			$('#bil002_sw001_paxCount').val(global_billingBucketObj.paxCount);
			$('#bil002_sw001_paxMaxCount').html('MAX: ' + global_placeLayoutComponentObj.paxCount);
			
			$('#bil002_sw001_servedBy').val(global_billingBucketObj.servedBy);
			
			$('#bil002_sw001_customerName').val(global_billingBucketObj.customerName);
			$('#bil002_sw001_customerContact').val(global_billingBucketObj.customerContact);
			$('#bil002_sw001_cancelBucketBtn').addClass('btn-danger');
			$('#bil002_sw001_cancelBucketBtn').removeClass('btn-grey');
			$('#bil002_sw001_customerSelector').addClass('btn-primary');
			$('#bil002_sw001_customerSelector').removeClass('btn-grey');
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_UNDER_PAID) {
			$('#bil002_sw001_status').val(global_billingBucketObj.bucketStatus);	
			$('#bil002_sw001_status').css('color','#F8AC59');
			$('#bil002_sw001_status').css('font-weight','bold');

			$('#bil002_sw001_paxCount').attr('disabled', false);
			$('#bil002_sw001_paxCount').val(global_billingBucketObj.paxCount);
			$('#bil002_sw001_paxMaxCount').html('MAX: ' + global_placeLayoutComponentObj.paxCount);
			
			$('#bil002_sw001_servedBy').val(global_billingBucketObj.servedBy);
			
			$('#bil002_sw001_customerName').val(global_billingBucketObj.customerName);
			$('#bil002_sw001_customerContact').val(global_billingBucketObj.customerContact);
			$('#bil002_sw001_cancelBucketBtn').removeClass('btn-danger');
			$('#bil002_sw001_cancelBucketBtn').addClass('btn-grey');
			$('#bil002_sw001_customerSelector').addClass('btn-primary');
			$('#bil002_sw001_customerSelector').removeClass('btn-grey');
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_FULLY_PAID) {
			$('#bil002_sw001_status').val(global_billingBucketObj.bucketStatus);	
			$('#bil002_sw001_status').css('color','#1AB394');
			$('#bil002_sw001_status').css('font-weight','bold');

			$('#bil002_sw001_paxCount').attr('disabled', true);
			$('#bil002_sw001_paxCount').val(global_billingBucketObj.paxCount);
			$('#bil002_sw001_paxMaxCount').html('MAX: ' + global_placeLayoutComponentObj.paxCount);
			
			$('#bil002_sw001_servedBy').val(global_billingBucketObj.servedBy);
			
			$('#bil002_sw001_customerName').val(global_billingBucketObj.customerName);
			$('#bil002_sw001_customerContact').val(global_billingBucketObj.customerContact);
			$('#bil002_sw001_cancelBucketBtn').removeClass('btn-danger');
			$('#bil002_sw001_cancelBucketBtn').addClass('btn-grey');
			$('#bil002_sw001_customerSelector').removeClass('btn-primary');
			$('#bil002_sw001_customerSelector').addClass('btn-grey');
		} else {
			
		}
	}
} // .end of bil002_sw001_updateUI_tab1

function bil002_sw001_updateUI_tab2()
{
	if (global_billingBucketObj == null)
	{
		$('#bil002_sw001_reservedOn').hide();
		$('#bil002_sw001_reservationOn').hide();
		$('#bil002_sw001_seatedOn').hide();
		$('#bil002_sw001_orderedOn').hide();
		$('#bil002_sw001_completedOn').hide();
		$('#bil002_sw001_leftOn').hide();
		
		$("#bil002_sw001_reservedOnDate").val( '' );
		$("#bil002_sw001_reservedOnTime").val( '' );
		$("#bil002_sw001_reservationOnDateFrom").val( '' );
		$("#bil002_sw001_reservationOnTimeFrom").val( '' );
		$("#bil002_sw001_reservationOnDateTo").val( '' );
		$("#bil002_sw001_reservationOnTimeTo").val( '' );
		$("#bil002_sw001_seatedOnDate").val( '' );
		$("#bil002_sw001_seatedOnTime").val( '' );
		$("#bil002_sw001_orderedOnDate").val( '' );
		$("#bil002_sw001_orderedOnTime").val( '' );
		$("#bil002_sw001_completedOnDate").val( '' );
		$("#bil002_sw001_completedOnTime").val( '' );
		$("#bil002_sw001_leftOnDate").val( '' );
		$("#bil002_sw001_leftOnTime").val( '' );
	}
	else
	{
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
			$('#bil002_sw001_reservedOn').show();
			$('#bil002_sw001_reservationOn').show();
			
			$("#bil002_sw001_reservedOnDate").prop('disabled', true);
			$("#bil002_sw001_reservedOnTime").prop('disabled', true);
			$("#bil002_sw001_reservationOnDateFrom").prop('disabled', true);
			$("#bil002_sw001_reservationOnTimeFrom").prop('disabled', true);
			$("#bil002_sw001_reservationOnDateTo").prop('disabled', true);
			$("#bil002_sw001_reservationOnTimeTo").prop('disabled', true);
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING) {
			$('#bil002_sw001_reservedOn').hide();
			$('#bil002_sw001_reservationOn').hide();
			
			$("#bil002_sw001_reservedOnDate").prop('disabled', false);
			$("#bil002_sw001_reservedOnTime").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateTo").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeTo").prop('disabled', false);			
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_UNDER_PAID) {
			$('#bil002_sw001_reservedOn').hide();
			$('#bil002_sw001_reservationOn').hide();
			$("#bil002_sw001_reservedOnDate").prop('disabled', false);
			$("#bil002_sw001_reservedOnTime").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateTo").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeTo").prop('disabled', false);			
		} else
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_FULLY_PAID) {
			$('#bil002_sw001_reservedOn').hide();
			$('#bil002_sw001_reservationOn').hide();
			$("#bil002_sw001_reservedOnDate").prop('disabled', false);
			$("#bil002_sw001_reservedOnTime").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateTo").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeTo").prop('disabled', false);			
		} else {
			$('#bil002_sw001_reservedOn').hide();
			$('#bil002_sw001_reservationOn').hide();
			$("#bil002_sw001_reservedOnDate").prop('disabled', false);
			$("#bil002_sw001_reservedOnTime").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeFrom").prop('disabled', false);
			$("#bil002_sw001_reservationOnDateTo").prop('disabled', false);
			$("#bil002_sw001_reservationOnTimeTo").prop('disabled', false);			
		}

		if (global_billingBucketObj.seatedOn == null) 
			$('#bil002_sw001_seatedOn').hide();
		else
			$('#bil002_sw001_seatedOn').show();

		if (global_billingBucketObj.orderedOn == null) 
			$('#bil002_sw001_orderedOn').hide();
		else
			$('#bil002_sw001_orderedOn').show();

		if (global_billingBucketObj.completedOn == null) 
			$('#bil002_sw001_completedOn').hide();
		else
			$('#bil002_sw001_completedOn').show();

		if (global_billingBucketObj.leftOn == null) 
			$('#bil002_sw001_leftOn').hide();
		else
			$('#bil002_sw001_leftOn').show();
				
		$("#bil002_sw001_reservedOnDate").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.reservedOn ) );
		$("#bil002_sw001_reservedOnTime").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.reservedOn ) );
		$("#bil002_sw001_reservationOnDateFrom").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.reservedFrom )  );
		$("#bil002_sw001_reservationOnTimeFrom").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.reservedFrom ) );
		$("#bil002_sw001_reservationOnDateTo").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.reservedTo )  );
		$("#bil002_sw001_reservationOnTimeTo").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.reservedTo ) );
		$("#bil002_sw001_seatedOnDate").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.seatedOn ) );
		$("#bil002_sw001_seatedOnTime").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.seatedOn ) );
		$("#bil002_sw001_orderedOnDate").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.orderedOn ) );
		$("#bil002_sw001_orderedOnTime").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.orderedOn ) );
		$("#bil002_sw001_completedOnDate").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.completedOn ) );
		$("#bil002_sw001_completedOnTime").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.completedOn ) );
		$("#bil002_sw001_leftOnDate").val( tycheesDateTime_getFormattedDate_ddMMyyyy( global_billingBucketObj.leftOn ) );
		$("#bil002_sw001_leftOnTime").val( tycheesDateTime_getFormattedDate_hhmm( global_billingBucketObj.leftOn ) );
	}
} // .end of bil002_sw001_updateUI_tab2

function bil002_sw001_updateUI_tab3()
{
	// Show Spinner
	$('#bil002_sw001_items_spinner').show();
	$('#bil002_sw001_items_content').hide();
	
	$("#bil002_sw001_items_dataTable").DataTable().clear().draw();
	if (global_billingBucketObj != null) {
	   	$.each(global_billingBucketObj.lineList, function(i, lineObj) {
			
			if (Cached_isDeletedBean(lineObj)==true)
				return true;
			
		    // COL #1
		    var htmlLines_col1 = '';
		    if (lineObj.addToBilling) {
				htmlLines_col1 += '<span style="text-decoration: line-through;">';
				htmlLines_col1 += lineObj.itemName;
				htmlLines_col1 += '</span>';
			}
			else {
				htmlLines_col1 += lineObj.itemName;
			}
		    
		    // COL #2
		    var htmlLines_col2 = '';
		    htmlLines_col2 += lineObj.billableAmount;
		    
		    // COL #3
		    var htmlLines_col3 = '';
		    htmlLines_col3 += lineObj.quantity;
		    
		    // COL #4
		    var htmlLines_col4 = '';
		    if (lineObj.addToBilling) {
				htmlLines_col4 += '<span class="pull-right" style="font-style:italic;">Added to Bill</span>';
			}
			else {
				htmlLines_col4 += '<span class="pull-right">';
				htmlLines_col4 += '<button class="btn btn-xs btn-info ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_incrementBucketLine(this, \'' + lineObj.id + '\');" style="margin-right:2px;"><i class="fa fa-plus-circle fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-info ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_decrementBucketLine(this, \'' + lineObj.id + '\');" style="margin-right:2px;"><i class="fa fa-minus-circle fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-danger ladda-button" data-style="zoom-in" onclick="bil002_removeBucketLine(this, \'' + lineObj.id + '\');"><i class="fa fa-times fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '</span>';
			}
		    
		    var rowSet = [];
		    rowSet.push( htmlLines_col1 );
		    rowSet.push( htmlLines_col2 );
		    rowSet.push( htmlLines_col3 );
		    rowSet.push( htmlLines_col4 );
		    
		    $('#bil002_sw001_items_dataTable').dataTable().fnAddData( rowSet, false );
		});
		
		$('#bil002_sw001_items_dataTable').DataTable().draw();
	}

	$('#bil002_sw001_items_spinner').hide();
	$('#bil002_sw001_items_content').show();
} // .end of bil002_sw001_updateUI_tab3

function bil002_sw001_updateUI_tab4()
{
	if (global_billingBucketObj == null) {
		$('#bil002_sw001_billings_spinner').hide();
		$('#bil002_sw001_billings_content').show();	
		$("#bil002_sw001_billings_dataTable").DataTable().clear().draw();	
	} else {
		$('#bil002_sw001_billings_spinner').show();
		$('#bil002_sw001_billings_content').hide();
		
		// Prepare request body
		var requestBody = {
				'appName': APP_NAME_POS,
				'bucketId': global_billingBucketObj.id,
				'fullBean': true
			};
		
		var params = new Object();
		
		tycheesdb_api_getBillingsByBucket(requestBody, bil002_sw001_updateUI_tab4_postHandler, params);
	}
} // .end of bil002_sw001_updateUI_tab4

function bil002_sw001_updateUI_tab4_postHandler(success, responseObj, params)
{
	$("#bil002_sw001_billings_dataTable").DataTable().clear().draw();
   	$.each(responseObj.billingList, function(i, billingObj) {
		
	    // COL #1
	    var htmlLines_col1 = '';
	    htmlLines_col1 += tycheesDateTime_getFormattedDate_MMMddyyyy(billingObj.createdOn);
	    htmlLines_col1 += ' ';
	    htmlLines_col1 += tycheesDateTime_getFormattedDate_hhmm(billingObj.createdOn);
	    
	    // COL #2
	    var htmlLines_col2 = '';
	    htmlLines_col2 += tycheesDateTime_getFormattedDate_MMMddyyyy(billingObj.billingDate);
	    
	    // COL #3
	    var htmlLines_col3 = '';
	    htmlLines_col3 += '<a onclick="bil002_openBilling(\'' + billingObj.id + '\')">';
	    htmlLines_col3 += billingObj.billingNo;
	    htmlLines_col3 += ' <i class="fa fa-external-link" aria-hidden="true"></i>';
	    htmlLines_col3 += '</a>'
	    
	    // COL #4
	    var htmlLines_col4 = '';
	    htmlLines_col4 += Number(billingObj.totalAmount).toFixed(2);
	    
	    // COL #5
	    var htmlLines_col5 = '';
	    htmlLines_col5 += billingObj.stateDesc;
	    
	    var rowSet = [];
	    rowSet.push( htmlLines_col1 );
	    rowSet.push( htmlLines_col2 );
	    rowSet.push( htmlLines_col3 );
	    rowSet.push( htmlLines_col4 );
	    rowSet.push( htmlLines_col5 );
	    
	    $('#bil002_sw001_billings_dataTable').dataTable().fnAddData( rowSet, false );
	});
	
	$('#bil002_sw001_billings_dataTable').DataTable().draw();

	$('#bil002_sw001_billings_spinner').hide();
	$('#bil002_sw001_billings_content').show();
} // .end of bil002_sw001_updateUI_tab4_postHandler

/**
 * Open table for order.
 */
function bil002_sw001_openTable()
{
	if (global_placeLayoutComponentObj == null)
	{
		return false;
	}

	if (global_billingBucketObj != null)
	{
		swal("Table Unavailable", "This table is being served now! Please select another table.", "error")
	}
	else
	{
		swal({
		    title: "Open This Table?",
		    text: "",
		    type: "warning",
		    showCancelButton: true,
		    confirmButtonColor: "#DD6B55",
		    confirmButtonText: "Yes, open it!",
		    closeOnConfirm: true,
		    closeOnCancel: true
		},
		function(isConfirm) {
			if (isConfirm) {
				// Create new bucket
				global_billingBucketObj = bil002_createBucket(global_placeLayoutComponentObj, BillingConstants.BUCKET_STATUS_SERVING);
				// Save bucket
				bil002_sw001_saveBucket(false);
				
				// Update Place Layout Component
				global_placeLayoutComponentObj.bucketId = global_billingBucketObj.id;
				tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());

				// Update UI
				bil002_sw001_updateUI_buttonPanel();
				bil002_sw001_updateUI_tab1(); 
				bil002_sw001_updateUI_tab2(); 
				// Update Canvas
				bil002_tablePanel_canvas_repaint();
			} 			
		});		
	}
} // .end of bil002_sw001_openTable

/**
 * Add item to bucket.
 */
function bil002_sw001_reserveTable()
{
	if (global_placeLayoutComponentObj == null)
		return false;

	if (global_billingBucketObj != null)
	{
		swal("Table Unavailable", "This table is being served now! Please select another table.", "error");
	}
	else
	{
		bil002_mw001_updateUI();
	}
} // .end of bil002_sw001_reserveTable

/**
 * Add item to bucket.
 */
function bil002_sw001_addItem()
{
	if (global_placeLayoutComponentObj == null)
		return false;

	if (global_billingBucketObj == null)
		return false;
	
	if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) 
		return false;
	
	bil002_sw001_slideIn();
	bil002_cartPanel_show();
} // .end of bil002_sw001_addItem

/**
 * Add item to bucket.
 */
function bil002_sw001_goPayment()
{
	if (global_placeLayoutComponentObj == null)
		return false;

	if (global_billingBucketObj == null)
		return false;

	if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) 
		return false;
	
	bil002_sw001_slideIn();
	bil002_paymentPanel_show();
} // .end of bil002_sw001_goPayment

function bil002_sw001_deleteBucket(callerElement)
{
	if (global_billingBucketObj == null)
		return false;

	// Show Progress
	$(callerElement).ladda().ladda('start');
	
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_POS,
			'bucketId': global_billingBucketObj.id,
			'fullBean': true
		};
	
	var params = new Object();
	params.callerElement = callerElement;
	
	tycheesdb_api_getBillingsByBucket(requestBody, bil002_sw001_deleteBucket_postHandler, params);
} // .end of bil002_sw001_deleteBucket

function bil002_sw001_deleteBucket_postHandler(success, responseObj, params)
{
	if (success == false) {
		swal('Oppps... Sorry', 'Something went wrong! Please inform us about this technical failure.', 'error');

		// Hide Progress
		$(params.callerElement).ladda().ladda('stop');
		
		return false;	
	}
	
	if (responseObj.billingList != null && responseObj.billingList.length > 0) {
		swal('Oppps... Sorry', 'You cannot delete this table, as there is one or more billing associated with it.', 'warning');

		// Hide Progress
		$(params.callerElement).ladda().ladda('stop');		
	} else {
		swal({
		  title: "Are you sure?",
		  text: "You will not be able to recover this table record!",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  confirmButtonText: "Yes, delete it!",
		  cancelButtonText: "No, cancel plx!",
		  closeOnConfirm: true,
		  closeOnCancel: true
		},
		function(isConfirm){
			if (isConfirm) {
				
				// Set delete flag
				global_billingBucketObj.bucketStatus = BillingConstants.BUCKET_STATUS_DELETED;
				Cached_deleteBean(global_billingBucketObj);
				// Save object (with delete flag) to DB
				bil002_sw001_saveBucket(false);
				// Hide Slide Window
				bil002_sw001_slideIn();
				// Save layout component
				global_placeLayoutComponentObj.bucketId = '';
				tycheesIO_saveBean( tycheesCommon_getCurrentPlaceObject() );

				// Repaint Canvas
				bil002_tablePanel_canvas_repaint();
				// Show Sweet Alert
		    	swal("Deleted!", "Your table record has been deleted.", "success");
			} 

			// Hide Progress
			$(params.callerElement).ladda().ladda('stop');			
		});
	}
} // .end of bil002_sw001_deleteBucket_postHandler

function bil002_sw001_cancelBucket(callerElement)
{
	var cancellable = $('#bil002_sw001_cancelBucketBtn').hasClass('btn-danger');
	
	if (cancellable) {

		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_RESERVED) {
		
			// Show Progress
			$(callerElement).ladda().ladda('start');
			
			swal({
			  title: "Are you sure?",
			  text: "Do you want to cancel this table reservation?",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "Yes, cancel it!",
			  cancelButtonText: "No",
			  closeOnConfirm: true,
			  closeOnCancel: true
			},
			function(isConfirm){
				if (isConfirm) {
					// Update Place
					global_placeLayoutComponentObj.bucketId = '';	
					// Save Place
					tycheesIO_saveBean(tycheesCommon_getCurrentPlaceObject());
					
					// Cancel bucket
					bil002_cancelBucket();
					
					// Update UI
					bil002_sw001_updateUI_buttonPanel();
					bil002_sw001_updateUI_tab1();
					bil002_sw001_updateUI_tab2(); 
					bil002_sw001_updateUI_tab3(); 
					bil002_sw001_updateUI_tab4(); 
					bil002_tablePanel_canvas_repaint();
					
			    	swal("Cancel Success!", "Your table reservation has been cancelled.", "success");
				} 
				

				// Hide Progress
				$(callerElement).ladda().ladda('stop');
			});
		}
		
		if (global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_SERVING ||
			global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_UNDER_PAID ||
			global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_FULLY_PAID ||
			global_billingBucketObj.bucketStatus == BillingConstants.BUCKET_STATUS_CLOSE) {
			
			bil002_sw001_deleteBucket(callerElement);
		}
	}
} // .end of bil002_sw001_cancelBucket

function bil002_sw001_selectCustomer()
{
	if ($('#bil002_sw001_customerSelector').hasClass('btn-grey')==false) {
		var customerNo;
		if (global_billingBucketObj != null)
			customerNo = global_billingBucketObj.customerNo;
		
		mw_customerSearch_show(bil002_sw001_selectCustomer_callbackFn, null, customerNo);
	}
} // .end of bil002_sw001_selectCustomer

function bil002_sw001_selectCustomer_callbackFn(customerObj)
{
	if (customerObj == null) 
	{	
		global_billingBucketObj.customerNo = '';
		global_billingBucketObj.customerName = '';
		global_billingBucketObj.customerContact = '';
	} 
	else 
	{
		global_billingBucketObj.customerNo = customerObj.customerNo;
		global_billingBucketObj.customerName = tycheesBean_person_getFullName(customerObj);
		global_billingBucketObj.customerContact = customerObj.contact;
	}
	
	// Update UI
	bil002_sw001_updateUI_tab1();
	// Save Bucket
	bil002_sw001_saveBucket();
} // .end of bil002_sw001_selectCustomer

function bil002_sw001_saveBucket(syncNow)
{
	if (bil002_sw001_isUpdatingUI==true)
	{
		tycheesLogger_logInfo("Other process is running, this process abort.", "bil002_sw001_saveBucket");
		return false;
	}
	
	// Clear status message
 	$("#bil002_sw001_tab1_status_list").empty();
 	$("#bil002_sw001_tab1_status_list").hide();
 	$("#bil002_sw001_tab2_status_list").empty();
 	$("#bil002_sw001_tab2_status_list").hide();
 	$("#bil002_sw001_tab3_status_list").empty();
 	$("#bil002_sw001_tab3_status_list").hide();
 	$("#bil002_sw001_tab4_status_list").empty();
 	$("#bil002_sw001_tab4_status_list").hide();
	
	// Form Validation Check
 	var inputValidity = true;
    $('#bil002_sw001_tabContentRoot :input').each(function()
	{
 		// reset to white
 		if(this.type=="text" || this.type=="number" || this.type=="textarea" || this.type=="select-one") 
 		{
 			if ($(this).prop('disabled')==true) {
 				
 			} 
 			else {
 				$(this).css('background-color','#FFFFFF');
 			}
 		}
 		
 		// Field with invalid value
  	    if(this.validity.valid==false)
  	    {
  	    	// Set flag to false
  	    	inputValidity = false;
  	    	
  	        //$(this).focus();
  	        $(this).css('background-color','#F6CECE');  	      
  	        
  	        if ($(this).hasClass('tab1-input'))
  	      		$("#bil002_sw001_tab1_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab2-input'))
  	      		$("#bil002_sw001_tab2_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab3-input'))
  	      		$("#bil002_sw001_tab3_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab4-input'))
  	      		$("#bil002_sw001_tab4_status_list").append("Invalid value found: " + this.name + "<br/>");
  	    }
	});
	    
	var reservedOn_date = $.trim( $('#bil002_sw001_reservedOnDate').val() );
    var reservedOn_time = $.trim( $('#bil002_sw001_reservedOnTime').val() ); 
    var reservedOn_valid = true;
    if (reservedOn_date!='' && tycheesDateTime_isValidDate_ddmmyyyy(reservedOn_date)==false)
    	reservedOn_valid = false;
    if (reservedOn_time!='' && tycheesDateTime_isValidTime_hhmm(reservedOn_time)==false)
    	reservedOn_valid = false;    
    if (reservedOn_valid == false) {
    	inputValidity = false;
    	$("#bil002_sw001_tab2_status_list").append("Invalid value found: Reserved On");
    }
    
	var reservationOn_dateFrom = $.trim( $('#bil002_sw001_reservationOnDateFrom').val() );
	var reservationOn_timeFrom = $.trim( $('#bil002_sw001_reservationOnTimeFrom').val() );
	var reservationOn_dateTo = $.trim( $('#bil002_sw001_reservationOnDateTo').val() );
	var reservationOn_timeTo = $.trim( $('#bil002_sw001_reservationOnTimeTo').val() );
    var reservationOn_valid = true;
    if (reservationOn_dateFrom!='' && tycheesDateTime_isValidDate_ddmmyyyy(reservationOn_dateFrom)==false)
    	reservationOn_valid = false;
    if (reservationOn_timeFrom!='' && tycheesDateTime_isValidTime_hhmm(reservationOn_timeFrom)==false)
    	reservationOn_valid = false;  
    if (reservationOn_dateTo!='' && tycheesDateTime_isValidDate_ddmmyyyy(reservationOn_dateTo)==false)
    	reservationOn_valid = false;
    if (reservationOn_timeTo!='' && tycheesDateTime_isValidTime_hhmm(reservationOn_timeTo)==false)
    	reservationOn_valid = false;    
    if (reservationOn_valid == false) {
    	inputValidity = false;
    	$("#bil002_sw001_tab2_status_list").append("Invalid value found: Reservation On");
    }
	    
    var seatedOn_date = $.trim( $('#bil002_sw001_seatedOnDate').val() );
    var seatedOn_time = $.trim( $('#bil002_sw001_seatedOnTime').val() );
    var seatedOn_valid = true;
    if (seatedOn_date!='' && tycheesDateTime_isValidDate_ddmmyyyy(seatedOn_date)==false)
    	seatedOn_valid = false;
    if (seatedOn_time!='' && tycheesDateTime_isValidTime_hhmm(seatedOn_time)==false)
    	seatedOn_valid = false;    
    if (seatedOn_valid == false) {
    	inputValidity = false;
    	$("#bil002_sw001_tab2_status_list").append("Invalid value found: Seated On");
    }
    
    var orderedOn_date = $.trim( $('#bil002_sw001_orderedOnDate').val() );
    var orderedOn_time = $.trim( $('#bil002_sw001_orderedOnTime').val() );
    var orderedOn_valid = true;
    if (orderedOn_date!='' && tycheesDateTime_isValidDate_ddmmyyyy(orderedOn_date)==false)
    	orderedOn_valid = false;
    if (orderedOn_time!='' && tycheesDateTime_isValidTime_hhmm(orderedOn_time)==false)
    	orderedOn_valid = false;
    if (orderedOn_valid == false) {
    	inputValidity = false;
    	$("#bil002_sw001_tab2_status_list").append("Invalid value found: Last Ordered On");
    }
    
    var completedOn_date = $.trim( $('#bil002_sw001_completedOnDate').val() );
    var completedOn_time = $.trim( $('#bil002_sw001_completedOnTime').val() );
    var completedOn_valid = true;
    if (completedOn_date!='' && tycheesDateTime_isValidDate_ddmmyyyy(completedOn_date)==false) 
    	completedOn_valid = false;
    if (completedOn_time!='' && tycheesDateTime_isValidTime_hhmm(completedOn_time)==false)
    	completedOn_valid = false;
    if (completedOn_valid == false) {
    	inputValidity = false;
    	$("#bil002_sw001_tab2_status_list").append("Invalid value found: Serve Completed On");
    }
    
    var leftOn_date = $.trim( $('#bil002_sw001_leftOnDate').val() );
    var leftOn_time = $.trim( $('#bil002_sw001_leftOnTime').val() );
    var leftOn_valid = true;
    if (leftOn_date!='' && tycheesDateTime_isValidDate_ddmmyyyy(leftOn_date)==false) 
    	leftOn_valid = false;
    if (leftOn_time!='' && tycheesDateTime_isValidTime_hhmm(leftOn_time)==false)
    	leftOn_valid = false;
    if (leftOn_valid == false) {
    	inputValidity = false;
    	$("#bil002_sw001_tab2_status_list").append("Invalid value found: Left On");
    }
    
    if (inputValidity==false)
    { 
        tycheesLogger_showToast("error", "Input Error", "Errors found on input value(s). Save action aborted.");	        
        
        // Print fields with error validation
 		if ( $.trim($("#bil002_sw001_tab1_status_list").html()) != '' )
 			$("#bil002_sw001_tab1_status").show();
 		if ( $.trim($("#bil002_sw001_tab2_status_list").html()) != '' )
 			$("#bil002_sw001_tab2_status").show();
 		if ( $.trim($("#bil002_sw001_tab3_status_list").html()) != '' )
 			$("#bil002_sw001_tab3_status").show();
 		if ( $.trim($("#bil002_sw001_tab4_status_list").html()) != '' )
 			$("#bil002_sw001_tab4_status").show();
 		
    	return false;
    }
    // Form Validation Check - END
    
    // TAB 1
    global_billingBucketObj.paxCount 		= $.trim( $('#bil002_sw001_paxCount').val() );
    global_billingBucketObj.reservedOn  	= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(reservedOn_date, reservedOn_time);
    global_billingBucketObj.reservedFrom	= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(reservationOn_dateFrom, reservationOn_timeFrom);
    global_billingBucketObj.reservedTo  	= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(reservationOn_dateTo, reservationOn_timeTo);
    global_billingBucketObj.seatedOn		= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(seatedOn_date, seatedOn_time);
    global_billingBucketObj.orderedOn		= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(orderedOn_date, orderedOn_time);
    global_billingBucketObj.completedOn		= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(completedOn_date, completedOn_time);
    global_billingBucketObj.leftOn			= tycheesDateTime_toMilliseconds_ddMMyyyy_hhmm(leftOn_date, leftOn_time);
    
    // Validate timestamp (DB not accept 0 as timestamp)
    if (global_billingBucketObj.reservedOn == 0)
    	global_billingBucketObj.reservedOn = null;
    if (global_billingBucketObj.reservedFrom == 0)
    	global_billingBucketObj.reservedFrom = null;
    if (global_billingBucketObj.reservedTo == 0)
        global_billingBucketObj.reservedTo = null;
    if (global_billingBucketObj.seatedOn == 0)
        global_billingBucketObj.seatedOn = null;
    if (global_billingBucketObj.orderedOn == 0)
        global_billingBucketObj.orderedOn = null;
    if (global_billingBucketObj.completedOn == 0)
        global_billingBucketObj.completedOn = null;
    if (global_billingBucketObj.leftOn == 0)
        global_billingBucketObj.leftOn = null;
    
    if (syncNow == null)
    	syncNow = true;
    
	// Save item
    bil002_saveBucket(syncNow);
} // .end of bil002_sw001_saveBucket

</script>