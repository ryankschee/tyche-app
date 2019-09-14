
<style>
    #rel001_customerPanel_sw001 {
        background-color: #fff;
        border-left: 1px solid #e7eaec;
        border-top: 1px solid #e7eaec;
        overflow: hidden;
        position: fixed;
        top: 60px;
        width: 55% !important;
        z-index: 1009;
        bottom: 0;
        right: -55%;
    }
    #rel001_customerPanel_sw001.sidebar-open {
        right: 0;
    }
    #rel001_customerPanel_sw001.sidebar-open.sidebar-top {
        top: 0;
        border-top: none;
    }

</style>

<div id="rel001_customerPanel_sw001">
    <div class="sidebar-container">
        <div class="sidebar-title" style="padding:0px 10px; background-color:#404040; color:#FFF; height:48px;">
            <span id="rel001_customerPanel_sw001_customerNameElement" style="font-size:18px;display:none;"> 
                <span id="rel001_customerPanel_sw001_customerName" style="padding-left:5px; color:#f8ac59; font-size:22pt;">CUSTOMER NAME</span>
                <span id="rel001_customerPanel_sw001_savingIndicator" style="padding-left:10px; color:#fff; font-size:12pt; display:none;">saving...</span>
                <i id="rel001_customerPanel_sw001_slideInButton" class="fa fa-chevron-circle-right fa-2x pull-right" aria-hidden="true" style="color:#ed5565; cursor:pointer; margin:5px 5px;" onclick="rel001_customerPanel_sw001_slideIn();"></i>
                <i id="rel001_customerPanel_sw001_saveButton" class="fa fa-floppy-o fa-2x pull-right ladda-button" data-style="zoom-in" aria-hidden="true" style="color:#1ab394; cursor:pointer; margin:5px 5px;" onclick="rel001_customerPanel_sw001_saveCustomer();"></i>
            </span>
            <div id="rel001_customerPanel_sw001_spinner" class="spiner-example" style="display:none; padding:10px; height:28px;">
				<div class="sk-spinner sk-spinner-wave">
				    <div class="sk-rect1"></div>
				    <div class="sk-rect2"></div>
				    <div class="sk-rect3"></div>
				    <div class="sk-rect4"></div>
				    <div class="sk-rect5"></div>
				</div>
			</div>
        </div>
        
        <ul id="rel001_customerPanel_sw001_tabHeaderRoot" class="nav nav-tabs navs-5">
            <li class="active" id="rel001_customerPanel_tabHeader1">
                <a data-toggle="tab" href="#rel001_customerPanel_sw001_tab-1">
                    Basic Info
                </a>
            </li>
            <li id="rel001_customerPanel_tabHeader2">
                <a data-toggle="tab" href="#rel001_customerPanel_sw001_tab-2">
                    Custom
                </a>
            </li>
            <li id="rel001_customerPanel_tabHeader3">
                <a data-toggle="tab" href="#rel001_customerPanel_sw001_tab-3">
                    Profiles
                </a>
            </li>
            <li id="rel001_customerPanel_tabHeader4">
                <a data-toggle="tab" href="#rel001_customerPanel_sw001_tab-4">
                    Opportunities
                </a>
            </li>
            <li id="rel001_customerPanel_tabHeader5">
                <a data-toggle="tab" href="#rel001_customerPanel_sw001_tab-5">
                    Billing 
                </a>
            </li>
        </ul>
        
        <div id="rel001_customerPanel_sw001_tabContentRoot" class="tab-content">        	
            <div id="rel001_customerPanel_sw001_tab-1" class="tab-pane active">                
                <div class="sidebar-title">
                    <div id="rel001_customerPanel_tab1_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='rel001_customerPanel_tab1_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">
                	<div class="row">
                		<div class="col-md-6" style="padding-top:5px; padding-left:30px;">		            
						    <span style="font-weight:bold;">
							    FIRST NAME
						    </span>
						</div>
						<div class="col-md-6" style="padding-top:5px;">		            
						    <span style="font-weight:bold;">
							    LAST NAME
						    </span>
						</div>
                	</div>
                	<div class="row">
						<div class="col-md-6" style="padding-left:30px;">
							<input type="text" class="form-control" id="rel001_customerPanel_sw001_firstName" name="First Name" maxlength="90" required oninput="rel001_customerPanel_sw001_onCustomerChanged()">
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" id="rel001_customerPanel_sw001_lastName" name="First Name" maxlength="90" required oninput="rel001_customerPanel_sw001_onCustomerChanged()">
						</div>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">
                	<div class="row">
                		<div class="col-md-6" style="padding-top:5px; padding-left:30px;">		            
						    <span style="font-weight:bold;">
							    CUSTOMER NO.
						    </span>
						</div>
						<div class="col-md-6" style="padding-top:5px;">		            
						    <span style="font-weight:bold;">
							    TYPE
						    </span>
						</div>
                	</div>
                	<div class="row">
						<div class="col-md-6" style="padding-left:30px;">
							<input type="text" class="form-control" id="rel001_customerPanel_sw001_customerNo" name="Customer No" maxlength="90" disabled>
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" id="rel001_customerPanel_sw001_customerType" name="Customer Type" maxlength="90" disabled>
						</div>
                	</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="row">
                		<div class="col-md-6" style="padding-top:5px; padding-left:30px;">		            
						    <span style="font-weight:bold;">
							    GENDER
						    </span>
						</div>
						<div class="col-md-6" style="padding-top:5px;">		            
						    <span style="font-weight:bold;">
							    DATE OF BIRTH
						    </span>
						</div>
                	</div>
                	<div class="row">
                	    <div class="col-md-6" style="padding-top:10px; padding-left:30px;">
							<div class="col-sm-8 rel001_customerPanel_ichecks" style="padding-left:0px;">
	                        	<label class="checkbox-inline i-checks"> 
	                        		<input id="rel001_customerPanel_sw001_gender_male" type="radio" value="Male" name="rel001_customerPanel_gender"> Male 
	                        	</label>
	                            <label class="checkbox-inline i-checks"> 
	                            	<input id="rel001_customerPanel_sw001_gender_female" type="radio" value="Female" name="rel001_customerPanel_gender"> Female 
	                            </label>
	                        </div>
						</div>
						<div class="col-md-6">
							<div class="input-group date">
	                            <span class="input-group-addon">
	                            	<i class="fa fa-calendar"></i>
	                            </span>
		                        <input id="rel001_customerPanel_sw001_dob" type="text" class="form-control" name="Date of Birth" value="03/04/2014" data-mask="99/99/9999" oninput="rel001_customerPanel_sw001_onCustomerChanged()">
	                        </div>
						</div>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;">
                	<div class="row">
                		<div class="col-md-12" style="padding-top:5px; padding-left:30px;">		            
						    <span style="font-weight:bold;">
							    SALES PERSON
						    </span>
						</div>
                	</div>
                	<div class="row">
						<div class="col-md-12 input-group" style="padding-left:30px; padding-right:30px;">
							<input type="text" class="form-control" id="rel001_customerPanel_sw001_employeeName" name="Employee Name" maxlength="90" disabled>
							<span class="input-group-btn">  
								<button  id="rel001_customerPanel_sw001_selectEmployeeButton" type="button" class="btn btn-info" onclick="rel001_customerPanel_sw001_selectEmployee();">
									<i class="fa fa-search" aria-hidden="true"></i>
	                            </button> 
	                        </span>
						</div>
                	</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px; background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    PRIMARY CONTACT
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control" id="rel001_customerPanel_sw001_primaryContact" name="Primary Contact" maxlength="90" disabled>
						<span class="input-group-btn">  
							<button  id="rel001_customerPanel_sw001_createContactButton" type="button" class="btn btn-info" onclick="rel001_customerPanel_sw001_createContact();">
								<i class="fa fa-plus" aria-hidden="true"></i>
                            </button> 
							<button  id="rel001_customerPanel_sw001_toggleContactListButton" type="button" class="btn btn-primary" onclick="rel001_customerPanel_sw001_toggleContactList(this);">
								<i class="fa fa-caret-down" aria-hidden="true"></i>
                            </button> 
                        </span>
					</div>
					<div class="row" id="rel001_customerPanel_sw001_contactList" style="display:none; padding:5px 15px;">
	                    <table class="table table-striped table-bordered table-hover" id="rel001_customerPanel_sw001_dataTable_contactList" >
	                        <thead>
	                            <tr>
	                                <th style="width:60px;">Type</th>
								    <th>Phone Number</th>
								    <th style="width:60px;">Action</th>
	                            </tr>
	                        </thead>
	                        <tbody>	                                                    
	                        </tbody>
	                    </table>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px; background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    PRIMARY EMAIL
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control" id="rel001_customerPanel_sw001_primaryEmail" name="Primary Email" maxlength="90" disabled>
						<span class="input-group-btn"> 
							<button  id="rel001_customerPanel_sw001_createEmailButton" type="button" class="btn btn-info" onclick="rel001_customerPanel_sw001_createEmail();">
								<i class="fa fa-plus" aria-hidden="true"></i>
                            </button> 
							<button  id="rel001_customerPanel_sw001_toggleEmailListButton" type="button" class="btn btn-primary" onclick="rel001_customerPanel_sw001_toggleEmailList(this);">
								<i class="fa fa-caret-down" aria-hidden="true"></i>
                            </button> 
                        </span>
					</div>
					<div class="row" id="rel001_customerPanel_sw001_emailList" style="display:none; padding:5px 15px;">
	                    <table class="table table-striped table-bordered table-hover" id="rel001_customerPanel_sw001_dataTable_emailList" >
	                        <thead>
	                            <tr>
									<th style="width:60px;">Type</th>
	                                <th>Email</th>
									<th style="width:60px;">Action</th>
	                            </tr>
	                        </thead>
	                        <tbody>	                                                    
	                        </tbody>
	                    </table>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding:0px 35px 0px 35px; background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px; padding-left:0px;">		            
					    <span style="font-weight:bold;">
						    PRIMARY ADDRESS
					    </span>
					</div>
					<div class="col-md-12 input-group">
						<input type="text" class="form-control" id="rel001_customerPanel_sw001_primaryAddress" name="Primary Address" maxlength="90" disabled>
						<span class="input-group-btn"> 
							<button id="rel001_customerPanel_sw001_createAddressButton" type="button" class="btn btn-info" onclick="rel001_customerPanel_sw001_createAddress();">
								<i class="fa fa-plus" aria-hidden="true"></i>
                            </button> 
							<button id="rel001_customerPanel_sw001_toggleAddressListButton" type="button" class="btn btn-primary" onclick="rel001_customerPanel_sw001_toggleAddressList(this);">
								<i class="fa fa-caret-down" aria-hidden="true"></i>
                            </button> 
                        </span>
					</div>
					<div class="row" id="rel001_customerPanel_sw001_addressList" style="display:none; padding:5px 15px;">
	                    <table class="table table-striped table-bordered table-hover" id="rel001_customerPanel_sw001_dataTable_addressList" >
	                        <thead>
	                            <tr>
	                                <th style="width:60px;">Type</th>
								    <th>Attn To:</th>
								    <th>Area</th>
								    <th>Address</th>
								    <th style="width:60px;">Action</th>
	                            </tr>
	                        </thead>
	                        <tbody>	                                                    
	                        </tbody>
	                    </table>
					</div>
	            </div>
	            <div class="setings-item" style="height:70px; padding-top:0px; padding-bottom:0px;background-color:#F9F9F9;">
                	<div class="col-md-12" style="padding-top:5px;">		            
					    <span style="font-weight:bold;">
						    PERSONAL DESCRIPTIONS
					    </span>
					</div>
					<div class="col-md-12">
						<input type="text" class="form-control" id="rel001_customerPanel_sw001_description" name="Personal Description" maxlength="500">
					</div>
	            </div>
                <br><br><br>
            </div>
            
            <div id="rel001_customerPanel_sw001_tab-2" class="tab-pane active">                
                <div class="sidebar-title">
                    <div id="rel001_customerPanel_tab2_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='rel001_customerPanel_tab2_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>                
                <div id="rel001_customerPanel_tab2_customList">
                </div>
            </div>

            <div id="rel001_customerPanel_sw001_tab-3" class="tab-pane">
                <div class="sidebar-title">
                    <div id="rel001_customerPanel_tab3_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='rel001_customerPanel_tab3_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                <div id="rel001_customerPanel_tab3_profileList" style="padding:20px;">
                	<div class="input-group" style="padding-top:0px; padding-bottom:10px;">
	            		<select id="rel001_customerPanel_tab3_profiles_select" class="form-control" onchange="rel001_customerPanel_reloadProfile();">
			            </select>
			            <span class="input-group-btn">
			                <button type="button" class="btn btn-info" onclick="rel001_customerPanel_executeAction('rel001_customerPanel_action_cloneProfile');"> 
			                    <i class="fa fa-clone" aria-hidden="true"></i> Clone
			                </button>
			                <button type="button" class="btn btn-primary" onclick="rel001_customerPanel_executeAction('rel001_customerPanel_action_addProfile');">
			                    <i class="fa fa-plus" aria-hidden="true"></i>
			                </button>
			                <button type="button" class="btn btn-primary" onclick="rel001_customerPanel_executeAction('rel001_customerPanel_action_editProfile');"> 
			                    <i class="fa fa-pencil" aria-hidden="true"></i>
			                </button>
			                <button type="button" class="btn btn-danger" onclick="rel001_customerPanel_executeAction('rel001_customerPanel_action_deleteProfile');"> 
			                    <i class="fa fa-trash-o" aria-hidden="true"></i>
			                </button>
			            </span>
			        </div>
			        <div>
						<button type="button" class="btn btn-info btn-xs" onclick="rel001_customerPanel_executeAction('rel001_customerPanel_action_addProperties');">
							<i class="fa fa-plus" aria-hidden="true"></i> Add Properties
						</button>								        	
			        </div>
	                <ul class="list-group clear-list" style="padding:10px 0px 10px 0px;">
	                	<span id="rel001_customerPanel_customer_propertiesList">
	                    </span>
	                </ul>
                </div>         
            </div>

            <div id="rel001_customerPanel_sw001_tab-4" class="tab-pane">
                <div class="sidebar-title">
                    <div id="rel001_customerPanel_tab4_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='rel001_customerPanel_tab4_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                <div id="rel001_customerPanel_tab4_opportunities">  
                	<div id="rel001_customerPanel_tab4_opportunities_spinner" class="spiner-example" style="display:none; padding:20px; height:28px;">
						<div class="sk-spinner sk-spinner-wave">
						    <div class="sk-rect1"></div>
						    <div class="sk-rect2"></div>
						    <div class="sk-rect3"></div>
						    <div class="sk-rect4"></div>
						    <div class="sk-rect5"></div>
						</div>
					</div>   
					<div id="rel001_customerPanel_tab4_opportunities_content" style="display:none; padding:10px 20px;">
	                	<table id="rel001_customerPanel_tab4_opportunities_dataTable" class="table table-striped table-bordered table-hover">
	   	                    <thead>
	   	                        <tr>
	   	                            <th>Date/Time</th>
	   	                            <th>Name</th>
	   	                            <th>Est. Value</th>
	   	                            <th>Status</th>
	   	                        </tr>
	   	                    </thead>
	   	                    <tbody>
	   	                    </tbody>
	   	                </table>      
	   	            </div>     	
                </div>
            </div>
            
            <div id="rel001_customerPanel_sw001_tab-5" class="tab-pane">
                <div class="sidebar-title">
                    <div id="rel001_customerPanel_tab5_status" style="display:none; color:red;">
                        <h3><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Please check following fields:</h3>
		            	<span id='rel001_customerPanel_tab5_status_list'>
	            	    	Status Messages
	            		</span>
            		</div>
                </div>
                <div id="rel001_customerPanel_tab5_billingHistory">  
                	<div id="rel001_customerPanel_tab5_billingHistory_spinner" class="spiner-example" style="display:none; padding:20px; height:28px;">
						<div class="sk-spinner sk-spinner-wave">
						    <div class="sk-rect1"></div>
						    <div class="sk-rect2"></div>
						    <div class="sk-rect3"></div>
						    <div class="sk-rect4"></div>
						    <div class="sk-rect5"></div>
						</div>
					</div>   
					<div id="rel001_customerPanel_tab5_billingHistory_content" style="display:none; padding:10px 20px;">
	                	<table id="rel001_customerPanel_tab5_billingHistory_dataTable" class="table table-striped table-bordered table-hover">
	   	                    <thead>
	   	                        <tr>
	   	                            <th>Created On</th>
	   	                            <th>Billing Date</th>
	   	                            <th>Billing No</th>
	   	                            <th>Amount</th>
	   	                            <th>Status</th>
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

var rel001_customerPanel_sw001_initialized = false;
var rel001_customerPanel_sw001_isUpdatingUI = false;
var rel001_customerPanel_sw001_unsavedChanges = false;
var rel001_customerPanel_sw001_customerObj;
var rel001_customerPanel_sw001_billingList = [];

function rel001_customerPanel_sw001_init()
{
	if (rel001_customerPanel_sw001_initialized)
		return false;
		
    $('.rel001_customerPanel_ichecks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    
    $('#rel001_customerPanel_tabHeader4').on('click', function(event) {
    	rel001_customerPanel_sw001_updateUI_tab4();
    });
    $('#rel001_customerPanel_tabHeader5').on('click', function(event) {
    	rel001_customerPanel_sw001_updateUI_tab5();
    });
    
    $('#rel001_customerPanel_sw001_gender_male').on('ifChecked', function(event){
    	rel001_customerPanel_sw001_onCustomerChanged();
    });
    $('#rel001_customerPanel_sw001_gender_female').on('ifChecked', function(event){
    	rel001_customerPanel_sw001_onCustomerChanged();
    });
    
    $('#rel001_customerPanel_sw001_dataTable_contactList').DataTable({
        "paging": false,
        "ordering": true,
        "info": false
    });
    $('#rel001_customerPanel_sw001_dataTable_contactList_filter').hide();
    $('#rel001_customerPanel_sw001_dataTable_contactList_wrapper').css('padding','0px');
    
    $('#rel001_customerPanel_sw001_dataTable_emailList').DataTable({
        "paging": false,
        "ordering": true,
        "info": false
    });
    $('#rel001_customerPanel_sw001_dataTable_emailList_filter').hide();
    $('#rel001_customerPanel_sw001_dataTable_emailList_filter').css('padding','0px');
    
    $('#rel001_customerPanel_sw001_dataTable_addressList').DataTable({
        "paging": false,
        "ordering": true,
        "info": false
    });
    $('#rel001_customerPanel_sw001_dataTable_addressList_filter').hide();
    $('#rel001_customerPanel_sw001_dataTable_addressList_filter').css('padding','0px');
    
    $('#rel001_customerPanel_tab4_billingHistory_dataTable').DataTable();
    
    rel001_customerPanel_sw001_initialized = true;
} // .end of rel001_customerPanel_sw001_init

/**
 * Open this by sliding out from right-side.
 */
function rel001_customerPanel_sw001_slideOut()
{
	if ( $('#rel001_customerPanel_sw001').hasClass('sidebar-open')==false ) {
		$('#rel001_customerPanel_sw001').toggleClass('sidebar-open');	
		$('#rel001_customerPanel_sw001').show();
	}
} // .end of rel001_customerPanel_sw001_slideOut

/**
 * Close this by sliding into right-side.
 */
function rel001_customerPanel_sw001_slideIn()
{
	if ( $('#rel001_customerPanel_sw001').hasClass('sidebar-open')==true ) {
		$('#rel001_customerPanel_sw001').toggleClass('sidebar-open');
		$('#rel001_customerPanel_sw001').hide();
	}
} // .end of rel001_customerPanel_sw001_slideIn

function rel001_customerPanel_sw001_showSpinner(showing)
{
	if (showing)
	{
		$('#rel001_customerPanel_sw001_customerNameElement').hide();
		$('#rel001_customerPanel_sw001_spinner').show();
		
		$('#rel001_customerPanel_sw001_tabHeaderRoot').hide();
		$('#rel001_customerPanel_sw001_tabContentRoot').hide();
	}
	else
	{
		$('#rel001_customerPanel_sw001_customerNameElement').show();
		$('#rel001_customerPanel_sw001_spinner').hide();
		
		$('#rel001_customerPanel_sw001_tabHeaderRoot').show();
		$('#rel001_customerPanel_sw001_tabContentRoot').show();
		
	}
} // .end of rel001_customerPanel_sw001_showSpinner

function rel001_customerPanel_sw001_updateUI(customerId, profileId)
{
	rel001_customerPanel_sw001_slideOut();
	rel001_customerPanel_sw001_showSpinner(true);
    
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerId': customerId,
			'fullBean': true
		};
	
	var params = new Object();
	params.profileId = profileId;
	
	tycheesdb_api_getCustomerById(requestBody, rel001_customerPanel_sw001_updateUI_postHandler, params);
	
} // .end of rel001_customerPanel_sw001_updateUI

function rel001_customerPanel_sw001_updateUI_postHandler(success, responseObj, params)
{
	if (responseObj.customerObj == null) {
		// Show error
		sweetAlert('Oops...', 'The Customer record is not available yet!', 'warning');
	    // Hide Sliding Window
	    rel001_customerPanel_sw001_slideIn();
	    rel001_customerPanel_sw001_showSpinner(false);
	    // Discontinue
		return false;
	}

	// Assign customer to global object	
	rel001_customerPanel_sw001_customerObj = responseObj.customerObj;
	// Reset unsaved status
	rel001_customerPanel_sw001_triggerSavingNotification(false);
	
	// Reset	
	$('#rel001_customerPanel_tabHeader1').addClass('active');
	$('#rel001_customerPanel_tabHeader2').removeClass('active');
	$('#rel001_customerPanel_tabHeader3').removeClass('active');
	$('#rel001_customerPanel_tabHeader4').removeClass('active');
	$('#rel001_customerPanel_tabHeader5').removeClass('active');
	$('#rel001_customerPanel_sw001_tab-1').addClass('active');
	$('#rel001_customerPanel_sw001_tab-2').removeClass('active');
	$('#rel001_customerPanel_sw001_tab-3').removeClass('active');
	$('#rel001_customerPanel_sw001_tab-4').removeClass('active');
	$('#rel001_customerPanel_sw001_tab-5').removeClass('active');

	$($('#rel001_customerPanel_sw001_toggleContactListButton').children()[0]).addClass('fa-caret-down');
	$($('#rel001_customerPanel_sw001_toggleContactListButton').children()[0]).removeClass('fa-caret-up');

	$($('#rel001_customerPanel_sw001_toggleEmailListButton').children()[0]).addClass('fa-caret-down');
	$($('#rel001_customerPanel_sw001_toggleEmailListButton').children()[0]).removeClass('fa-caret-up');

	$($('#rel001_customerPanel_sw001_toggleAddressListButton').children()[0]).addClass('fa-caret-down');
	$($('#rel001_customerPanel_sw001_toggleAddressListButton').children()[0]).removeClass('fa-caret-up');
	
	$('#rel001_customerPanel_sw001_contactList').hide();
	$('#rel001_customerPanel_sw001_emailList').hide();
	$('#rel001_customerPanel_sw001_addressList').hide();
	$('#rel001_customerPanel_tab5_billingHistory_content').hide();
	
	// Init, if any.	
    rel001_customerPanel_sw001_init();
    rel001_customerPanel_sw001_isUpdatingUI = true;
    
    // COMMON
    var customerName = $.trim(rel001_customerPanel_sw001_customerObj.firstName);
    if ($.trim(rel001_customerPanel_sw001_customerObj.lastName) != '') {
    	customerName += (', ' + $.trim(rel001_customerPanel_sw001_customerObj.lastName));
    }
    $('#rel001_customerPanel_sw001_customerName').html(customerName);
    
    // TAB 1
    rel001_customerPanel_sw001_updateUI_tab1();    
    // TAB 2
    rel001_customerPanel_sw001_updateUI_tab2();
    // TAB 3
    rel001_customerPanel_sw001_updateUI_tab3();
    // TAB 4
    // TAB 5	
    
    // Paint background for each row of field
	$("#tab-1 .setings-item").each(function(i) {
		if (i%2==0)  
			$(this).css('background-color','#FFF');
		else
			$(this).css('background-color','#F9F9F9');
	});
    
    rel001_customerPanel_sw001_isUpdatingUI = false;
    // Hide Sliding Window
    rel001_customerPanel_sw001_showSpinner(false);
} // .end of rel001_customerPanel_sw001_updateUI_postHandler

function rel001_customerPanel_sw001_updateUI_tab1()
{
	$('#rel001_customerPanel_sw001_firstName').val( rel001_customerPanel_sw001_customerObj.firstName );
    $('#rel001_customerPanel_sw001_lastName').val( rel001_customerPanel_sw001_customerObj.lastName );
    $('#rel001_customerPanel_sw001_customerNo').val( rel001_customerPanel_sw001_customerObj.customerNo );
    $('#rel001_customerPanel_sw001_customerType').val( $.trim(rel001_customerPanel_sw001_customerObj.templateName)=='' ? '-' : $.trim(rel001_customerPanel_sw001_customerObj.templateName) );
    $('#rel001_customerPanel_sw001_dob').val( tycheesDateTime_getFormattedDate_ddMMyyyy(rel001_customerPanel_sw001_customerObj.dob) );
    if (rel001_customerPanel_sw001_customerObj.gender==AppConstants.GENDER_MALE)
    	$('#rel001_customerPanel_sw001_gender_male').iCheck('check');
    if (rel001_customerPanel_sw001_customerObj.gender==AppConstants.GENDER_FEMALE)
    	$('#rel001_customerPanel_sw001_gender_female').iCheck('check');
    $('#rel001_customerPanel_sw001_employeeName').val( rel001_customerPanel_sw001_customerObj.employeeName );
    $('#rel001_customerPanel_sw001_primaryContact').val( rel001_customerPanel_sw001_customerObj.contact );
    $('#rel001_customerPanel_sw001_primaryEmail').val( rel001_customerPanel_sw001_customerObj.email );
    $('#rel001_customerPanel_sw001_primaryAddress').val( rel001_customerPanel_sw001_customerObj.address );
    $('#rel001_customerPanel_sw001_description').val( rel001_customerPanel_sw001_customerObj.description );
} // .end of rel001_customerPanel_sw001_updateUI_tab1

function rel001_customerPanel_sw001_updateUI_tab2()
{
	// Sort list, by seqno
    rel001_customerPanel_sw001_customerObj.propertiesList.sort(
		function(a, b){ 
			return tycheesList_sortByNumber(a.propSeqno, b.propSeqno);
		});
	 
    $('#rel001_customerPanel_tab2_customList').empty(); 
	$.each(rel001_customerPanel_sw001_customerObj.propertiesList, function(i, propObj) {
		if (Cached_isDeletedBean(propObj))
			return true;
		
		// Get input component in HTML
		var htmlLines = customerCommon_createInputComponent(propObj, true);
      	$("#rel001_customerPanel_tab2_customList").append(htmlLines);
		// Set event listener
      	customerCommon_createInputComponent_onEvent(propObj, rel001_customerPanel_sw001_onCustomerChanged);
	});
} // .end of rel001_customerPanel_sw001_updateUI_tab2

function rel001_customerPanel_sw001_updateUI_tab3()
{
	// Sort list, by profileName
    rel001_customerPanel_sw001_customerObj.profileList.sort(
		function(a, b){ 
			return tycheesList_sortByString(a.profileName, b.profileName);
		});
	
	$('#rel001_customerPanel_tab3_profiles_select').empty();
	$.each(rel001_customerPanel_sw001_customerObj.profileList, function(i, profileObj){
		if (Cached_isDeletedBean(profileObj))
			return true;
		
		var defaultVal = '';
		if (profileObj.defaultProfile==true)
		    defaultVal = ' (Default)';
		
		var selectedVal = '';
		var profile_htmlLines = '';
		profile_htmlLines += '<option value="' + profileObj.id + '" ' + selectedVal + '>' + profileObj.profileName + defaultVal + '</option>';		
		$('#rel001_customerPanel_tab3_profiles_select').append(profile_htmlLines);	
		
	});
	// Reload profile's properties by current selection
	rel001_customerPanel_reloadProfile();
} // .end of rel001_customerPanel_sw001_updateUI_tab2

function rel001_customerPanel_reloadProfile()
{
	var profileId = $('#rel001_customerPanel_tab3_profiles_select').val();
	
	$.each(rel001_customerPanel_sw001_customerObj.profileList, function(i, profileObj){
		if (Cached_isDeletedBean(profileObj))
			return true;
		
		if (profileId==profileObj.id) 
		{
			// Extract & Process List
		    var sortedList = [];
		    $.each(profileObj.propertiesList, function(i, propertiesObj){
		    	sortedList.push(propertiesObj);
		    });
		    // Sort list, by group name
		    sortedList.sort(
				function(a, b){ 
					return tycheesList_sortByString(a.groupName, b.groupName);
				});
			

		    var lastGroupName = '';
			$('#rel001_customerPanel_customer_propertiesList').empty();
			$.each(sortedList, function(j, propertiesObj){
				
				if (lastGroupName != propertiesObj.groupName)
		    	{
		    	    lastGroupName = propertiesObj.groupName;
		    	    
		    	    var dividerHtmlLines = '';		    	    
		    	    dividerHtmlLines += '<li class="list-group-item list-group-item-custom" style="background-color:#333;color:#FFF;font-weight:bold;padding-left:10px;">';
		    	    dividerHtmlLines += lastGroupName;
		    	    dividerHtmlLines += '</li>';
		    	    
		    	    $('#rel001_customerPanel_customer_propertiesList').append(dividerHtmlLines);
		    	}
				
				var htmlLines = '';
				htmlLines += '<li class="list-group-item list-group-item-custom" style="height:50px;padding-left:10px;padding-right:10px;">';
				htmlLines += '<span style="height:25px;margin-top:5px;">';
				htmlLines += '<i class="fa fa-cube" aria-hidden="true"></i> ';
				htmlLines += propertiesObj.propKey;
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right" style="height:25px;margin-top:5px;"> ';
				htmlLines += '<span style="padding-left:10px;padding-right:5px;">';
				htmlLines += '<i class="fa fa-pencil" aria-hidden="true" style="cursor:pointer;" onclick="rel001_customerPanel_executeAction(\'' + REL001_02_ACTION_EDIT_PROPERTIES + '\',\'' + propertiesObj.id  + '\');"></i>';
				htmlLines += '</span>';
				htmlLines += '<span style="padding-left:5px;padding-right:10px;">';
				htmlLines += '<i class="fa fa-times-circle" aria-hidden="true" style="cursor:pointer;color:#ff0000;" onclick="rel001_customerPanel_executeAction(\'' + REL001_02_ACTION_DELETE_PROPERTIES + '\',\'' + propertiesObj.id  + '\');"></i>'; 
				htmlLines += '</span>';
				htmlLines += '</span>';
				htmlLines += '<span class="pull-right"> ';
				htmlLines += '<input class="form-control input-sm" id="inputsm" type="text" value="' + tycheesText_getDisplayText(propertiesObj.propValue, 0) + '" disabled>';
				htmlLines += '</span>';
				htmlLines += '</li>';
				
				$('#rel001_customerPanel_customer_propertiesList').append(htmlLines);
			});
		}
	});	
} // .end of rel001_customerPanel_reloadProfile

function rel001_customerPanel_sw001_updateUI_tab4()
{
	$('#rel001_customerPanel_tab4_opportunities_spinner').show();
	$('#rel001_customerPanel_tab4_opportunities_content').hide();
	
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerId': rel001_customerPanel_sw001_customerObj.id,
			'fullBean': false
		};
	
	var params = new Object();
	
	tycheesdb_api_getOpportunitiesByCustomer(requestBody, rel001_customerPanel_sw001_updateUI_tab4_postHandler, params);
} // .end of rel001_customerPanel_sw001_updateUI_tab3

function rel001_customerPanel_sw001_updateUI_tab4_postHandler(successFlag, responseObj, params) 
{
	if (successFlag==false)
	{
		rel001_customerPanel_sw001_opportunityList = [];
		return false;
	}
	
	rel001_customerPanel_sw001_opportunityList = responseObj.opportunityList;

	// Sort list, by created day
    rel001_customerPanel_sw001_opportunityList.sort(
		function(a, b){ 
			return a.createdOn - b.createdOn;
		});
	
	$("#rel001_customerPanel_tab4_opportunities_dataTable").DataTable().clear().draw();
   	$.each(rel001_customerPanel_sw001_opportunityList, function(i, opportunityObj){
		
	    // COL #1
	    var htmlLines_col1 = '';
	    htmlLines_col1 += tycheesDateTime_getFormattedDate_MMMddyyyy(opportunityObj.createdOn);
	    htmlLines_col1 += ' ';
	    htmlLines_col1 += tycheesDateTime_getFormattedDate_hhmm(opportunityObj.createdOn);
	    
	    // COL #2
	    var htmlLines_col2 = '';
	    //htmlLines_col2 += '<a onclick="rel001_customerPanel_executeAction(\'' + REL001_02_ACTION_OPEN_POS_BY_BILLING + '\',\'' + opportunityObj.id + '\')">';
	    htmlLines_col2 += opportunityObj.name;
	    htmlLines_col2 += ' <i class="fa fa-external-link" aria-hidden="true"></i>';
	    //htmlLines_col2 += '</a>'
	    
	    // COL #3
	    var htmlLines_col3 = '';
	    htmlLines_col3 += Number(opportunityObj.estimationValue).toFixed(2);
	    
	    // COL #4
	    var htmlLines_col4 = '';
	    htmlLines_col4 += opportunityObj.stateDesc;
	    
	    var rowSet = [];
	    rowSet.push( htmlLines_col1 );
	    rowSet.push( htmlLines_col2 );
	    rowSet.push( htmlLines_col3 );
	    rowSet.push( htmlLines_col4 );
	    
	    $('#rel001_customerPanel_tab4_opportunities_dataTable').dataTable().fnAddData( rowSet, false );
	});
	$('#rel001_customerPanel_tab4_opportunities_dataTable').DataTable().draw();

	$('#rel001_customerPanel_tab4_opportunities_spinner').hide();
	$('#rel001_customerPanel_tab4_opportunities_content').show();
} // .end of rel001_customerPanel_sw001_updateUI_tab4_postHandler

function rel001_customerPanel_sw001_updateUI_tab5()
{
	$('#rel001_customerPanel_tab5_billingHistory_spinner').show();
	$('#rel001_customerPanel_tab5_billingHistory_content').hide();
	
	// Prepare request body
	var requestBody = {
			'appName': APP_NAME_RELATION,
			'customerId': rel001_customerPanel_sw001_customerObj.id,
			'fullBean': false
		};
	
	var params = new Object();
	
	tycheesdb_api_getBillingsByCustomer(requestBody, rel001_customerPanel_sw001_updateUI_tab5_postHandler, params);
} // .end of rel001_customerPanel_sw001_updateUI_tab5

function rel001_customerPanel_sw001_updateUI_tab5_postHandler(successFlag, responseObj, params) 
{
	if (successFlag==false)
	{
		rel001_customerPanel_sw001_billingList = [];
		return false;
	}
	
	rel001_customerPanel_sw001_billingList = responseObj.billingList;
	
	// Sort list, by created day
    rel001_customerPanel_sw001_billingList.sort(
		function(a, b){ 
			return a.createdOn - b.createdOn;
		});
	
	$("#rel001_customerPanel_tab5_billingHistory_dataTable").DataTable().clear().draw();
   	$.each(rel001_customerPanel_sw001_billingList, function(i, billingObj){
		
   		if (Cached_isDeletedBean(billingObj))
   			return true;
   		
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
	    htmlLines_col3 += '<a onclick="billingCommon_openBilling(\'' + billingObj.id + '\')">';
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
	    
	    $('#rel001_customerPanel_tab5_billingHistory_dataTable').dataTable().fnAddData( rowSet, false );
	});
	$("#rel001_customerPanel_tab5_billingHistory_dataTable").DataTable().draw();

	$('#rel001_customerPanel_tab5_billingHistory_spinner').hide();
	$('#rel001_customerPanel_tab5_billingHistory_content').show();
} // .end of rel001_customerPanel_sw001_updateUI_tab5_postHandler

function rel001_customerPanel_sw001_selectEmployee()
{
	mw_employeeSearch_show(rel001_customerPanel_sw001_selectEmployee_callbackFn, null, $.trim(rel001_customerPanel_sw001_customerObj.employeeId));
} // .end of rel001_customerPanel_sw001_selectEmployee

function rel001_customerPanel_sw001_selectEmployee_callbackFn(employeeObj)
{
	if (employeeObj == null) {
		rel001_customerPanel_sw001_customerObj.employeeId = '';
		rel001_customerPanel_sw001_customerObj.employeeName = '';
	} else {
		rel001_customerPanel_sw001_customerObj.employeeId = employeeObj.id;
		rel001_customerPanel_sw001_customerObj.employeeName = tycheesBean_person_getFullName(employeeObj);
	}
	
	rel001_customerPanel_sw001_updateUI_tab1();
	rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_selectEmployee_callbackFn

function rel001_customerPanel_sw001_toggleContactList(buttonElement)
{
	var iconElement = $(buttonElement).children()[0];
	var isCollapsed = $(iconElement).hasClass('fa-caret-down');
	
	if (isCollapsed) {
		$(iconElement).addClass('fa-caret-up');
		$(iconElement).removeClass('fa-caret-down');
		
		$('#rel001_customerPanel_sw001_contactList').parent().css('height','100%');
		$('#rel001_customerPanel_sw001_contactList').show();	
		
		rel001_customerPanel_sw001_updateContactList();
	} else {
		$(iconElement).addClass('fa-caret-down');
		$(iconElement).removeClass('fa-caret-up');
		$('#rel001_customerPanel_sw001_contactList').parent().css('height','70px');
		$('#rel001_customerPanel_sw001_contactList').hide();		
	}
} // .end of rel001_customerPanel_sw001_toggleContactList

function rel001_customerPanel_sw001_updateContactList()
{
	$('#rel001_customerPanel_sw001_dataTable_contactList').DataTable().clear().draw();
    if (rel001_customerPanel_sw001_customerObj.contactList != null) {
	    $.each(rel001_customerPanel_sw001_customerObj.contactList, function(i, contactObj) {
	    	if (Cached_isDeletedBean(contactObj))
	    		return true;
	    	
	    	// COL #1
	        var htmlLines_col1 = '';
	        htmlLines_col1 += $.trim(contactObj.type)=='' ? '-' : $.trim(contactObj.type);
	        
	        // COL #2
	        var htmlLines_col2 = '';
	        htmlLines_col2 += tycheesBean_toString_commonContactBean(contactObj);
	        
	        // COL #3
	        var buttonVal_makePrimary = '';
	        buttonVal_makePrimary += '<a onclick="rel001_customerPanel_sw001_makePrimaryContact(\'' + contactObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
	        buttonVal_makePrimary += '<i class="fa fa-check" aria-hidden="true"></i> ';
	        buttonVal_makePrimary += '</a>';

	        var buttonVal_edit = '';
	        buttonVal_edit += '<a onclick="rel001_customerPanel_sw001_editContact(\'' + contactObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
	        buttonVal_edit += '<i class="fa fa-pencil" aria-hidden="true"></i> ';
	        buttonVal_edit += '</a>';
	        
	        var buttonVal_delete = '';
	        buttonVal_delete += '<a onclick="rel001_customerPanel_sw001_deleteContact(\'' + contactObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
	        buttonVal_delete += '<i class="fa fa-times" aria-hidden="true"></i> ';
	        buttonVal_delete += '</a>';
	        
	        if (contactObj.defaultContact==true)
	        {
	            buttonVal_makePrimary = '';
	            
	            htmlLines_col2 = '';
	            htmlLines_col2 += '<span style="font-weight:bold;">'
	            htmlLines_col2 += tycheesBean_toString_commonContactBean(contactObj);
	            htmlLines_col2 += '</span>';
	            htmlLines_col2 += ' <i class="fa fa-check-circle" aria-hidden="true"></i>';
	        }
	        
	        var htmlLines_col3 = '';
	        htmlLines_col3 += buttonVal_makePrimary;
	        htmlLines_col3 += ' ';
	        htmlLines_col3 += buttonVal_edit;
	        htmlLines_col3 += ' ';
	        htmlLines_col3 += buttonVal_delete;
	        
	        // Prepare row set.
	        var rowSet = [];
	        rowSet.push( htmlLines_col1 );
	        rowSet.push( htmlLines_col2 );
	        rowSet.push( htmlLines_col3 );
	        
	        $('#rel001_customerPanel_sw001_dataTable_contactList').dataTable().fnAddData(rowSet, false);
	    });
    }
    $('#rel001_customerPanel_sw001_dataTable_contactList').DataTable().draw();
} // .end of rel001_customerPanel_sw001_updateContactList

function rel001_customerPanel_sw001_createContact()
{
	// Init contact object
    var newContactObj = createNew_CustomerContact();
    newContactObj.customerId = rel001_customerPanel_sw001_customerObj.id;
    newContactObj.countryCode = '';
    newContactObj.areaCode = '';
    newContactObj.phoneNumber = '';
    newContactObj.extension = '';
    
    // Add into current customer's contact list
    rel001_customerPanel_sw001_customerObj.contactList.push(newContactObj);
    
    // If only one record, then set it as primary record
    if (rel001_customerPanel_sw001_customerObj.contactList.length==1) {
    	newContactObj.defaultContact = true;
    	rel001_customerPanel_sw001_customerObj.contact = tycheesBean_toString_commonContactBean(newContactObj);
    }

    // Display to UI
    rel001_customerPanel_sw001_updateContactList();    
    rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_createContact

function rel001_customerPanel_sw001_makePrimaryContact(contactId)
{
	$.each(rel001_customerPanel_sw001_customerObj.contactList, function(i, contactObj){
        if (contactId==contactObj.id) {
            contactObj.defaultContact = true;
            rel001_customerPanel_sw001_customerObj.contact = tycheesBean_toString_commonContactBean(contactObj);	
        } else {
            contactObj.defaultContact = false;
        }
    });
	
	$('#rel001_customerPanel_sw001_primaryContact').val(rel001_customerPanel_sw001_customerObj.contact);
    
    // Refresh UI
    rel001_customerPanel_sw001_updateContactList();
    rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_makePrimaryContact

function rel001_customerPanel_sw001_editContact(contactId)
{
	var foundObj;
	$.each(rel001_customerPanel_sw001_customerObj.contactList, function(i, contactObj){
		if (Cached_isDeletedBean(contactObj))
			return true;
		
        if (contactId==contactObj.id) {
        	foundObj = contactObj;
        } 
    });

	if (foundObj != null)
		mw_contactEditor_show(foundObj, rel001_customerPanel_sw001_editContact_postHandler);
} // .end of rel001_customerPanel_sw001_editContact

function rel001_customerPanel_sw001_editContact_postHandler(saved, savedContactObj)
{
	if (saved) {		
		if (savedContactObj.defaultContact) {
			rel001_customerPanel_sw001_customerObj.contact = tycheesBean_toString_commonContactBean(savedContactObj);
				
			$.each(rel001_customerPanel_sw001_customerObj.contactList, function(i, contactObj){
				if (Cached_isDeletedBean(contactObj))
					return true;
				
		        if (savedContactObj.id != contactObj.id) {
		        	contactObj.defaultContact = false;
		        }
		    });
		}
		
		// Update UI - Primary Contact
		$('#rel001_customerPanel_sw001_primaryContact').val(rel001_customerPanel_sw001_customerObj.contact);
		
	    // Refresh UI
	    rel001_customerPanel_sw001_updateContactList();
	    rel001_customerPanel_sw001_onCustomerChanged();
	}	
} // .end of rel001_customerPanel_sw001_editContact_postHandler

function rel001_customerPanel_sw001_deleteContact(contactId)
{
	swal({
	  title: "Are you sure?",
	  text: "You will not be able to recover this contact record!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, delete it!",
	  cancelButtonText: "No, cancel plx!",
	  closeOnConfirm: true,
	  closeOnCancel: true
	},
	function(isConfirm) {
	  	if (isConfirm) 
	  	{
	  		$.each(rel001_customerPanel_sw001_customerObj.contactList, function(i, contactObj){
	  			if (Cached_isDeletedBean(contactObj))
	  				return true;
	  			
	  	        if (contactId==contactObj.id) {
	  	        	Cached_deleteBean(contactObj);
	  	       
	  	        	// Reset if this contact is primary
	  	            if (contactObj.defaultContact==true)
	  	            {
	  	            	rel001_customerPanel_sw001_customerObj.contact = '';
	  	            }
	  	        } 
	  	    });
	  		
	  		$.each(rel001_customerPanel_sw001_customerObj.contactList, function(i, contactObj){
	  			if (Cached_isDeletedBean(contactObj))
	  				return true;
	  			
	  			if (i == 0) {
		  			contactObj.defaultContact = true;
		            rel001_customerPanel_sw001_customerObj.contact = tycheesBean_toString_commonContactBean(contactObj);
	  			}
	  	    });
	  		
	  		
	  		$('#rel001_customerPanel_sw001_primaryContact').val(rel001_customerPanel_sw001_customerObj.contact);
	  	    
	  	    // Refresh UI
	  	    rel001_customerPanel_sw001_updateContactList();
	  	    rel001_customerPanel_sw001_onCustomerChanged();
	  	}
	});	
} // .end of rel001_customerPanel_sw001_deleteContact

function rel001_customerPanel_sw001_toggleEmailList(buttonElement)
{
	var iconElement = $(buttonElement).children()[0];
	var isCollapsed = $(iconElement).hasClass('fa-caret-down');
	
	if (isCollapsed) {
		$(iconElement).addClass('fa-caret-up');
		$(iconElement).removeClass('fa-caret-down');
		
		$('#rel001_customerPanel_sw001_emailList').parent().css('height','100%');
		$('#rel001_customerPanel_sw001_emailList').show();	
		
		rel001_customerPanel_sw001_updateEmailList();
	} else {
		$(iconElement).addClass('fa-caret-down');
		$(iconElement).removeClass('fa-caret-up');
		$('#rel001_customerPanel_sw001_emailList').parent().css('height','70px');
		$('#rel001_customerPanel_sw001_emailList').hide();		
	}
} // .end of rel001_customerPanel_sw001_toggleEmailList

function rel001_customerPanel_sw001_updateEmailList()
{
	$('#rel001_customerPanel_sw001_dataTable_emailList').DataTable().clear().draw();
    if (rel001_customerPanel_sw001_customerObj.emailList != null) {
	    $.each(rel001_customerPanel_sw001_customerObj.emailList, function(i, emailObj) {
	    	if (Cached_isDeletedBean(emailObj))
	    		return true;
	    	
	    	// COL #1
	        var htmlLines_col1 = '';
	        htmlLines_col1 += $.trim(emailObj.type)=='' ? '-' : $.trim(emailObj.type);

	    	// COL #2
	        var htmlLines_col2 = '';
	        htmlLines_col2 += $.trim(emailObj.emailAddress)=='' ? '-' : $.trim(emailObj.emailAddress);
	        		        
	        // COL #2
	        var buttonVal_makePrimary = '';
	        buttonVal_makePrimary += '<a onclick="rel001_customerPanel_sw001_makePrimaryEmail(\'' + emailObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
	        buttonVal_makePrimary += '<i class="fa fa-check" aria-hidden="true"></i> ';
	        buttonVal_makePrimary += '</a>';

	        var buttonVal_edit = '';
	        buttonVal_edit += '<a onclick="rel001_customerPanel_sw001_editEmail(\'' + emailObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
	        buttonVal_edit += '<i class="fa fa-pencil" aria-hidden="true"></i> ';
	        buttonVal_edit += '</a>';
	        
	        var buttonVal_delete = '';
	        buttonVal_delete += '<a onclick="rel001_customerPanel_sw001_deleteEmail(\'' + emailObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
	        buttonVal_delete += '<i class="fa fa-times" aria-hidden="true"></i> ';
	        buttonVal_delete += '</a>';
	        
	        if (emailObj.defaultEmail==true)
	        {
	            buttonVal_makePrimary = '';

	            htmlLines_col2 = '';
	            htmlLines_col2 += '<span style="font-weight:bold;">'
	            htmlLines_col2 += $.trim(emailObj.emailAddress)=='' ? '-' : $.trim(emailObj.emailAddress);
	            htmlLines_col2 += '</span>';
	            htmlLines_col2 += ' <i class="fa fa-check-circle" aria-hidden="true"></i>';
	        }
	        
	        var htmlLines_col3 = '';
	        htmlLines_col3 += buttonVal_makePrimary;
	        htmlLines_col3 += ' ';
	        htmlLines_col3 += buttonVal_edit;
	        htmlLines_col3 += ' ';
	        htmlLines_col3 += buttonVal_delete;
	        
	        // Prepare row set.
	        var rowSet = [];
	        rowSet.push( htmlLines_col1 );
	        rowSet.push( htmlLines_col2 );
	        rowSet.push( htmlLines_col3 );
	        
	        $('#rel001_customerPanel_sw001_dataTable_emailList').dataTable().fnAddData(rowSet, false);
	    });
    }
    $('#rel001_customerPanel_sw001_dataTable_emailList').DataTable().draw();
} // .end of rel001_customerPanel_sw001_updateEmailList

function rel001_customerPanel_sw001_createEmail()
{
	// Init contact object
    var newEmailObj = createNew_CustomerEmail();
    newEmailObj.customerId = rel001_customerPanel_sw001_customerObj.id;
    newEmailObj.emailAddress = '';
    
    // Add into current customer's contact list
    rel001_customerPanel_sw001_customerObj.emailList.push(newEmailObj);
    
    // If only one record, then set it as primary record
    if (rel001_customerPanel_sw001_customerObj.emailList.length==1) {
    	newEmailObj.defaultEmail = true;
    	rel001_customerPanel_sw001_customerObj.email = newEmailObj.emailAddress;
    }

    // Display to UI
    rel001_customerPanel_sw001_updateEmailList();
    rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_createContact

function rel001_customerPanel_sw001_makePrimaryEmail(emailId)
{
	$.each(rel001_customerPanel_sw001_customerObj.emailList, function(i, emailObj){
        if (emailId==emailObj.id) {
        	emailObj.defaultEmail = true;
            rel001_customerPanel_sw001_customerObj.email = emailObj.emailAddress;	
        } else {
        	emailObj.defaultEmail = false;
        }
    });

	$('#rel001_customerPanel_sw001_primaryEmail').val(rel001_customerPanel_sw001_customerObj.email);
    
    // Refresh UI
    rel001_customerPanel_sw001_updateEmailList();
    rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_makePrimaryEmail

function rel001_customerPanel_sw001_editEmail(emailId)
{
	var foundObj;
	$.each(rel001_customerPanel_sw001_customerObj.emailList, function(i, emailObj){
		if (Cached_isDeletedBean(emailObj))
			return true;
		
        if (emailId==emailObj.id) {
        	foundObj = emailObj;
        } 
    });

	if (foundObj != null)
		mw_emailEditor_show(foundObj, rel001_customerPanel_sw001_editEmail_postHandler);
} // .end of rel001_customerPanel_sw001_editEmail

function rel001_customerPanel_sw001_editEmail_postHandler(saved, savedEmailObj)
{
	if (saved) {		
		if (savedEmailObj.defaultEmail) {
			rel001_customerPanel_sw001_customerObj.email = savedEmailObj.emailAddress;
				
			$.each(rel001_customerPanel_sw001_customerObj.emailList, function(i, emailObj){
				if (Cached_isDeletedBean(emailObj))
					return true;
				
		        if (savedEmailObj.id != emailObj.id) {
		        	emailObj.defaultEmail = false;
		        }
		    });
		}
		
		// Update UI - Primary Contact
		$('#rel001_customerPanel_sw001_primaryEmail').val(rel001_customerPanel_sw001_customerObj.email);
		
	    // Refresh UI
	    rel001_customerPanel_sw001_updateEmailList();
	    rel001_customerPanel_sw001_onCustomerChanged();
	}	
} // .end of rel001_customerPanel_sw001_editEmail_postHandler

function rel001_customerPanel_sw001_deleteEmail(emailId)
{
	swal({
	  title: "Are you sure?",
	  text: "You will not be able to recover this email record!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, delete it!",
	  cancelButtonText: "No, cancel plx!",
	  closeOnConfirm: true,
	  closeOnCancel: true
	},
	function(isConfirm) {
	  	if (isConfirm) 
	  	{
	  		$.each(rel001_customerPanel_sw001_customerObj.emailList, function(i, emailObj){
	  			if (Cached_isDeletedBean(emailObj))
	  				return true;
	  			
	  	        if (emailId==emailObj.id) {
	  	        	Cached_deleteBean(emailObj);
	  	       
	  	        	// Reset if this contact is primary
	  	            if (emailObj.defaultEmail==true)
	  	            {
	  	            	rel001_customerPanel_sw001_customerObj.email = '';
	  	            }
	  	        } 
	  	    });
	  		
	  		$.each(rel001_customerPanel_sw001_customerObj.emailList, function(i, emailObj){
	  			if (Cached_isDeletedBean(emailObj))
	  				return true;
	  			
	  			if (i == 0) {
	  				emailObj.defaultContact = true;
		            rel001_customerPanel_sw001_customerObj.email = emailObj.emailAddress;
	  			}
	  	    });
	  		
	  		
	  		$('#rel001_customerPanel_sw001_primaryEmail').val(rel001_customerPanel_sw001_customerObj.email);
	  	    
	  	    // Refresh UI
	  	    rel001_customerPanel_sw001_updateEmailList();
	  	    rel001_customerPanel_sw001_onCustomerChanged();
	  	}
	});	
} // .end of rel001_customerPanel_sw001_deleteEmail

function rel001_customerPanel_sw001_toggleAddressList(buttonElement)
{
	var iconElement = $(buttonElement).children()[0];
	var isCollapsed = $(iconElement).hasClass('fa-caret-down');
	
	if (isCollapsed) {
		$(iconElement).addClass('fa-caret-up');
		$(iconElement).removeClass('fa-caret-down');
		
		$('#rel001_customerPanel_sw001_addressList').parent().css('height','100%');
		$('#rel001_customerPanel_sw001_addressList').show();	
		
		rel001_customerPanel_sw001_updateAddressList();
	} else {
		$(iconElement).addClass('fa-caret-down');
		$(iconElement).removeClass('fa-caret-up');
		$('#rel001_customerPanel_sw001_addressList').parent().css('height','70px');
		$('#rel001_customerPanel_sw001_addressList').hide();		
	}
} // .end of rel001_customerPanel_sw001_toggleAddressList

function rel001_customerPanel_sw001_updateAddressList()
{
	$('#rel001_customerPanel_sw001_dataTable_addressList').DataTable().clear().draw();
    if (rel001_customerPanel_sw001_customerObj.contactList != null) {
	    $.each(rel001_customerPanel_sw001_customerObj.addressList, function(i, addressObj) {
	    	if (Cached_isDeletedBean(addressObj))
	    		return true;
	    	
	    	// COL #1
	        var htmlLines_col1 = '';
	        htmlLines_col1 += $.trim(addressObj.type)=='' ? '-' : $.trim(addressObj.type);
	        
	    	// COL #2
	        var htmlLines_col2 = '';
	        htmlLines_col2 += $.trim(addressObj.attentionTo)=='' ? '-' : $.trim(addressObj.attentionTo);

	    	// COL #3
	        var htmlLines_col3 = '';
	        htmlLines_col3 += $.trim(addressObj.area)=='' ? '-' : $.trim(addressObj.area);
	        
	    	// COL #4
	        var htmlLines_col4 = '';
	        htmlLines_col4 += tycheesBean_toString_commonAddressBean(addressObj);
	        
	        // COL #5
	        var buttonVal_makePrimary = '';
	        buttonVal_makePrimary += '<a onclick="rel001_customerPanel_sw001_makePrimaryAddress(\'' + addressObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
	        buttonVal_makePrimary += '<i class="fa fa-check" aria-hidden="true"></i> ';
	        buttonVal_makePrimary += '</a>';

	        var buttonVal_edit = '';
	        buttonVal_edit += '<a onclick="rel001_customerPanel_sw001_editAddress(\'' + addressObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
	        buttonVal_edit += '<i class="fa fa-pencil" aria-hidden="true"></i> ';
	        buttonVal_edit += '</a>';
	        
	        var buttonVal_delete = '';
	        buttonVal_delete += '<a onclick="rel001_customerPanel_sw001_deleteAddress(\'' + addressObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
	        buttonVal_delete += '<i class="fa fa-times" aria-hidden="true"></i> ';
	        buttonVal_delete += '</a>';
	        
	        if (addressObj.defaultAddress==true)
	        {
	            buttonVal_makePrimary = '';

	            htmlLines_col4 = '';
	            htmlLines_col4 += '<span style="font-weight:bold;">';
		        htmlLines_col4 += tycheesBean_toString_commonAddressBean(addressObj);
		        htmlLines_col4 += '</span>';
	            htmlLines_col4 += ' <i class="fa fa-check-circle" aria-hidden="true"></i>';
	        }
	        
	        var htmlLines_col5 = '';
	        htmlLines_col5 += buttonVal_makePrimary;
	        htmlLines_col5 += ' ';
	        htmlLines_col5 += buttonVal_edit;
	        htmlLines_col5 += ' ';
	        htmlLines_col5 += buttonVal_delete;
	        
	        // Prepare row set.
	        var rowSet = [];
	        rowSet.push( htmlLines_col1 );
	        rowSet.push( htmlLines_col2 );
	        rowSet.push( htmlLines_col3 );
	        rowSet.push( htmlLines_col4 );
	        rowSet.push( htmlLines_col5 );
	        
	        $('#rel001_customerPanel_sw001_dataTable_addressList').dataTable().fnAddData(rowSet, false);
	    });
    }
    $('#rel001_customerPanel_sw001_dataTable_addressList').DataTable().draw();
} // .end of rel001_customerPanel_sw001_updateAddressList

function rel001_customerPanel_sw001_createAddress()
{
	// Init contact object
    var newAddressObj = createNew_CustomerAddress();
    newAddressObj.attentionTo = '';
    newAddressObj.streetLine1 = '';
    newAddressObj.postalCode = '';
    newAddressObj.area = '';
    newAddressObj.city = '';
    newAddressObj.state = '';
    newAddressObj.country = '';
    
    // Add into current customer's contact list
    rel001_customerPanel_sw001_customerObj.addressList.push(newAddressObj);
    
    // Display to UI
    rel001_customerPanel_sw001_updateAddressList();
    
    // If only one record, then set it as primary record
    if (rel001_customerPanel_sw001_customerObj.addressList.length==1) {
    	newAddressObj.defaultAddress = true;
    	rel001_customerPanel_sw001_customerObj.address = tycheesBean_toString_commonAddressBean(newAddressObj);
    	rel001_customerPanel_sw001_customerObj.area = '';
    }
    
    rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_createAddress

function rel001_customerPanel_sw001_makePrimaryAddress(addressId)
{
	$.each(rel001_customerPanel_sw001_customerObj.addressList, function(i, addressObj){
        if (addressId==addressObj.id) {
        	addressObj.defaultAddress = true;
            rel001_customerPanel_sw001_customerObj.address = tycheesBean_toString_commonAddressBean(addressObj);
            rel001_customerPanel_sw001_customerObj.area = addressObj.area;
        } else {
        	addressObj.defaultAddress = false;
        }
    });

	$('#rel001_customerPanel_sw001_primaryAddress').val(rel001_customerPanel_sw001_customerObj.address);
    
    // Refresh UI
    rel001_customerPanel_sw001_updateAddressList();
    rel001_customerPanel_sw001_onCustomerChanged();
} // .end of rel001_customerPanel_sw001_makePrimaryAddress

function rel001_customerPanel_sw001_editAddress(addressId)
{
	var foundObj;
	$.each(rel001_customerPanel_sw001_customerObj.addressList, function(i, addressObj){
		if (Cached_isDeletedBean(addressObj))
			return true;
		
        if (addressId==addressObj.id) {
        	foundObj = addressObj;
        } 
    });

	if (foundObj != null)
		mw_addressEditor_show(foundObj, rel001_customerPanel_sw001_editAddress_postHandler);
} // .end of rel001_customerPanel_sw001_editAddress

function rel001_customerPanel_sw001_editAddress_postHandler(saved, savedAddressObj)
{
	if (saved) {		
		if (savedAddressObj.defaultAddress) {
			rel001_customerPanel_sw001_customerObj.address = tycheesBean_toString_commonAddressBean(savedAddressObj);
			rel001_customerPanel_sw001_customerObj.area = savedAddressObj.area;
				
			$.each(rel001_customerPanel_sw001_customerObj.addressList, function(i, addressObj){
				if (Cached_isDeletedBean(addressObj))
					return true;
				
		        if (savedAddressObj.id != addressObj.id) {
		        	addressObj.defaultAddress = false;
		        }
		    });
		}
		
		// Update UI - Primary Contact
		$('#rel001_customerPanel_sw001_primaryAddress').val(rel001_customerPanel_sw001_customerObj.address);
		
	    // Refresh UI
	    rel001_customerPanel_sw001_updateAddressList();
	    rel001_customerPanel_sw001_onCustomerChanged();
	}	
} // .end of rel001_customerPanel_sw001_editAddress_postHandler

function rel001_customerPanel_sw001_deleteAddress(addressId)
{
	swal({
	  title: "Are you sure?",
	  text: "You will not be able to recover this address record!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, delete it!",
	  cancelButtonText: "No, cancel plx!",
	  closeOnConfirm: true,
	  closeOnCancel: true
	},
	function(isConfirm) {
	  	if (isConfirm) 
	  	{
	  		$.each(rel001_customerPanel_sw001_customerObj.addressList, function(i, addressObj){
	  			if (Cached_isDeletedBean(addressObj))
	  				return true;
	  			
	  	        if (addressId==addressObj.id) {
	  	        	Cached_deleteBean(addressObj);
	  	       
	  	        	// Reset if this contact is primary
	  	            if (addressObj.defaultAddress==true)
	  	            {
	  	            	rel001_customerPanel_sw001_customerObj.address = '';
	  	            	rel001_customerPanel_sw001_customerObj.area = '';
	  	            }
	  	        } 
	  	    });
	  		
	  		$.each(rel001_customerPanel_sw001_customerObj.addressList, function(i, addressObj){
	  			if (Cached_isDeletedBean(addressObj))
	  				return true;
	  			
	  			if (i == 0) {
	  				addressObj.defaultAddress = true;
		            rel001_customerPanel_sw001_customerObj.address = tycheesBean_toString_commonAddressBean(addressObj);
		            rel001_customerPanel_sw001_customerObj.area = addressObj.area;
	  			}
	  	    });
	  		
	  		
	  		$('#rel001_customerPanel_sw001_primaryEmail').val(rel001_customerPanel_sw001_customerObj.address);
	  	    
	  	    // Refresh UI
	  	    rel001_customerPanel_sw001_updateAddressList();
	  	    rel001_customerPanel_sw001_onCustomerChanged();
	  	}
	});	
} // .end of rel001_customerPanel_sw001_deleteAddress

function rel001_customerPanel_sw001_onCustomerChanged()
{
	if (rel001_customerPanel_sw001_isUpdatingUI==true) {
		tycheesLogger_logInfo("Other process is running, this process abort.", "rel001_customerPanel_sw001_onCustomerChanged");
		return false;
	}
	
	rel001_customerPanel_sw001_triggerSavingNotification(true);
} // .end of rel001_customerPanel_sw001_onCustomerChanged

function rel001_customerPanel_sw001_triggerSavingNotification(turnOn) {

	if (turnOn) {
		rel001_customerPanel_sw001_unsavedChanges = true;	
		$('#rel001_customerPanel_sw001_saveButton').css('color', '#ed5565');
		$('#rel001_customerPanel_sw001_saveButton').addClass('blink');
	} else {
		rel001_customerPanel_sw001_unsavedChanges = false;	
		$('#rel001_customerPanel_sw001_saveButton').css('color', '#1ab394');
		$('#rel001_customerPanel_sw001_saveButton').removeClass('blink');
	}
} // .end of rel001_customerPanel_sw001_triggerSavingNotification

function rel001_customerPanel_sw001_saveCustomer()
{
	if (rel001_customerPanel_sw001_isUpdatingUI==true) {
		tycheesLogger_logInfo("Other process is running, this process abort.", "rel001_customerPanel_sw001_saveCustomer");
		return false;
	}

	// Show progressing status
    $('#rel001_customerPanel_sw001_savingIndicator').show();
    $('#rel001_customerPanel_sw001_savingIndicator').html('validating...');
    $('#rel001_customerPanel_sw001_saveButton').ladda().ladda('start');
    
	// Clear status message
 	$("#rel001_customerPanel_tab1_status_list").empty();
 	$("#rel001_customerPanel_tab1_status_list").hide();
 	$("#rel001_customerPanel_tab2_status_list").empty();
 	$("#rel001_customerPanel_tab2_status_list").hide();
 	$("#rel001_customerPanel_tab3_status_list").empty();
 	$("#rel001_customerPanel_tab3_status_list").hide();
 	$("#rel001_customerPanel_tab4_status_list").empty();
 	$("#rel001_customerPanel_tab4_status_list").hide();
	
 	var validationStartTime = tycheesDateTime_getCurrentTimeInMillis();
 	
	// Form Validation Check
 	var inputValidity = true;
    $('#rel001_customerPanel_sw001_tabContentRoot :input').each(function()
	{
 		// reset to white
 		if(this.type=="text" || this.type=="number" || this.type=="textarea" || this.type=="select-one") 
 		{
 			if ($(this).prop('disabled')==true) 
 			{
 				
 			} 
 			else 
 			{
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
  	      		$("#rel001_customerPanel_tab1_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab2-input'))
  	      		$("#rel001_customerPanel_tab2_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab3-input'))
  	      		$("#rel001_customerPanel_tab3_status_list").append("Invalid value found: " + this.name + "<br/>");
  	        if ($(this).hasClass('tab4-input'))
  	      		$("#rel001_customerPanel_tab4_status_list").append("Invalid value found: " + this.name + "<br/>");
  	    }
	});

 	var validationEndTime = tycheesDateTime_getCurrentTimeInMillis();
 	tycheesLogger_logDebug('Validation Time: ' + (validationEndTime-validationStartTime) + 'ms');
 	
    if (inputValidity==false)
    { 
        tycheesLogger_showToast("error", "Input Error", "Errors found on input value(s). Save action aborted.");	        
        
        // Print fields with error validation
 		if ( $.trim($("#rel001_customerPanel_tab1_status_list").html()) != '' )
 			$("#rel001_customerPanel_tab1_status").show();
 		if ( $.trim($("#rel001_customerPanel_tab2_status_list").html()) != '' )
 			$("#rel001_customerPanel_tab2_status").show();
 		if ( $.trim($("#rel001_customerPanel_tab3_status_list").html()) != '' )
 			$("#rel001_customerPanel_tab3_status").show();
 		if ( $.trim($("#rel001_customerPanel_tab4_status_list").html()) != '' )
 			$("#rel001_customerPanel_tab4_status").show();

 	    $('#rel001_customerPanel_sw001_savingIndicator').hide();
 	    $('#rel001_customerPanel_sw001_saveButton').ladda().ladda('stop');
 		
    	return false;
    }
    // Form Validation Check - END
    
    $('#rel001_customerPanel_sw001_savingIndicator').html('saving...');
    
    // TAB 1
    rel001_customerPanel_sw001_customerObj.firstName 	= $.trim( $('#rel001_customerPanel_sw001_firstName').val() );
    rel001_customerPanel_sw001_customerObj.lastName 	= $.trim( $('#rel001_customerPanel_sw001_lastName').val() );
    rel001_customerPanel_sw001_customerObj.gender		= $('#rel001_customerPanel_sw001_gender_male').prop('checked') ? AppConstants.GENDER_MALE : AppConstants.GENDER_FEMALE;
    rel001_customerPanel_sw001_customerObj.description 	= $.trim( $('#rel001_customerPanel_sw001_description').val() );
        
    // TAB 2
    $.each(rel001_customerPanel_sw001_customerObj.propertiesList, function(i, propObj) {
		if (Cached_isDeletedBean(propObj))
			return true;
		
		propObj.propValue = customerCommon_getInputComponentValue(propObj);
		propObj.hasChanged = true;
	});
    
    // TAB 3
    
    // TAB 4
    
    // TAB 5
        
	// Save item
    tycheesIO_saveBean(rel001_customerPanel_sw001_customerObj, rel001_customerPanel_sw001_saveCustomer_callback);
    // Update UI
    rel001_customerPanel_updateUI(false);
} // .end of rel001_customerPanel_sw001_saveCustomer

function rel001_customerPanel_sw001_saveCustomer_callback() {

    // Reset state
    rel001_customerPanel_sw001_triggerSavingNotification(false);
    $('#rel001_customerPanel_sw001_savingIndicator').html('');
    $('#rel001_customerPanel_sw001_savingIndicator').hide();
    $('#rel001_customerPanel_sw001_saveButton').ladda().ladda('stop');
} // .end of rel001_customerPanel_sw001_saveCustomer_callback

</script>