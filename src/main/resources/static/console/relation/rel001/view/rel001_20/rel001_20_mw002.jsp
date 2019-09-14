<!-- MODAL WINDOW: Edit User -->
<div class="modal inmodal fade" id="rel001_20_mw002" tabindex="-1" role="dialog"  aria-hidden="true">
	<input type="hidden" id="rel001_20_mw002_customerId" value="">
    <div class="modal-dialog modal-xl">
	    <div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">EDIT USER</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
		    <div class="modal-body">
			    <div>
				    <ul class="nav nav-tabs">
					    <li class="active"><a data-toggle="tab" href="#rel001_20_mw002_tabBasicInfo"><i class="fa fa-info"></i> Basic Info</a></li>
					    <li class=""><a data-toggle="tab" href="#rel001_20_mw002_tabContact"><i class="fa fa-phone-square"></i> Contacts</a></li>
					    <li class=""><a data-toggle="tab" href="#rel001_20_mw002_tabEmail"><i class="fa fa-envelope"></i> Emails</a></li>
					    <li class=""><a data-toggle="tab" href="#rel001_20_mw002_tabAddress"><i class="fa fa-map-marker"></i> Addresses</a></li>
					    <li class=""><a data-toggle="tab" href="#rel001_20_mw002_tabCustom"><i class="fa fa-th-list"></i> Custom Fields</a></li>
				    </ul>
			    	<div id="rel001_20_mw002_customerEdit-tabContent" class="tab-content">
			    	
			    		<div id="rel001_20_mw002_tabBasicInfo" class="tab-pane active">
			    			<div class="ibox float-e-margins" style="margin:0px;">
						    	<div class="ibox-content">
						    		<div class="row">
						    			<div class="col-lg-12">
						    				<form method="get" class="form-horizontal">
						    					<div class="form-group">
						    						<label class="col-sm-2 control-label">Customer No.</label>
						    						<div class="col-sm-10">
						    							<input type="text" class="form-control" id="rel001_20_mw002_customerNo" name="Customer Number" placeholder="Customer Number" value="">
						    						</div>
						    					</div>
						    					<div class="form-group">
						    						<label class="col-sm-2 control-label">First Name</label>
						    						<div class="col-sm-10">
						    							<input type="text" class="form-control" id="rel001_20_mw002_customerFirstName" name="First Name" placeholder="Given Name" value="">
						    						</div>
						    					</div>
						    					<div class="form-group">
						    						<label class="col-sm-2 control-label">Last Name</label>
						    						<div class="col-sm-10">
						    							<input type="text" class="form-control" id="rel001_20_mw002_customerLastName" name="Last Name" placeholder="Family Surname" value="">
						    						</div>
						    					</div>
						    					<div class="form-group">
						    						<label class="col-sm-2 control-label">Gender</label>
						    						<div class="col-sm-10">
													    <div class="col-sm-8 rel001_02_mw001_i-checks">
                	                                    	<label class="checkbox-inline i-checks"> 
                	                                    	    <input id="rel001_20_mw002_customerGender_male" type="radio" value="Male" name="rel001_20_mw002_customerGender"> Male 
                	                                    	</label>
                                                            <label class="checkbox-inline i-checks"> 
                                                                <input id="rel001_20_mw002_customerGender_female" type="radio" value="Female" name="rel001_20_mw002_customerGender"> Female 
                                                            </label>
                	                                    </div>
						    						</div>
											    </div>
											    <div class="form-group" id="data_2">
												    <label class="col-sm-2 control-label">Date of Birth</label>
												    <div class="col-sm-10 input-group date" style="padding-left:15px;padding-right:15px;">
												    	<input type="text" class="form-control" id="rel001_20_mw002_customerDob" value="' + tycheesDateTime_getFormattedDate_ddMMyyyy(rel001_20_mw002_customerObj.dob) + '" data-mask="99/99/9999">
                                    					<span class="help-block">Date Format: dd/mm/yyyy</span>													    	
												    </div>
						    					</div>
						    					<div class="form-group">
						    						<label class="col-sm-2 control-label">Description</label>
						    						<div class="col-sm-10">
						    							<textarea id="rel001_20_mw002_customerDescription" rows="3" cols="50" style="width:100%;"></textarea>							    							
						    						</div>
						    					</div>
										    </form>
									    </div>
									    <div class="col-lg-5">
									    </div>
								    </div>
							    </div>
						    </div>
					    </div> 
					    <!-- .end of rel001_20_mw002_tabBasicInfo -->
					    
					    <div id="rel001_20_mw002_tabContact" class="tab-pane">
						    <div class="row">
							    <div class="col-lg-12">
								    <div class="ibox float-e-margins" style="margin:0px;">
									    <div class="ibox-title" style="border-top:2px;">
									    	<div class="note-toolbar btn-toolbar">
				                        		<div class="note-font btn-group">
				                        			<button type="button" class="btn btn-xs btn-info" title="" tabindex="-1" onclick="rel001_20_mw002_contact_addNew();">
				                        				<i class="fa fa-plus" aria-hidden="true"></i>
				                        			    Add New Contact
				                        			</button>
				                        		</div>
				                        	</div>
									    </div>
									    <div class="ibox-content">
										    <table class="table table-striped table-bordered table-hover " id="rel001_20_mw002_customerContactTable" >
											    <thead>
												    <tr>
													    <th>Type</th>
													    <th>Country Code</th>
													    <th>Area Code</th>
													    <th>Phone Number</th>
													    <th>Extension</th>
													    <th>Action</th>
												    </tr>
											    </thead>
										    	<tbody id="rel001_20_mw002_customerEdit-tableContact">
										    	</tbody>
										    </table>
									    </div>
								    </div>
							    </div>
						    </div>
					    </div>
					    <!-- .end of rel001_20_mw002_tabContact -->
					    
					    <div id="rel001_20_mw002_tabEmail" class="tab-pane">
						    <div class="row">
							    <div class="col-lg-12">
							    	<div class="ibox float-e-margins" style="margin:0px;">
							    		<div class="ibox-title" style="border-top:2px;">
							    			<div class="note-toolbar btn-toolbar">
				                        		<div class="note-font btn-group">
				                        			<button type="button" class="btn btn-xs btn-info" title="" tabindex="-1" onclick="rel001_20_mw002_email_addNew();">
				                        				<i class="fa fa-plus" aria-hidden="true"></i>
				                        			    Add New Email
				                        			</button>
				                        		</div>
				                        	</div>
							    		</div>
							    		<div class="ibox-content">
							    			<table class="table table-striped table-bordered table-hover " id="rel001_20_mw002_customerEmailTable" >
							    				<thead>
												    <tr>
													    <th>Email</th>
													    <th>Action</th>
												    </tr>
							    				</thead>
							    				<tbody id="rel001_20_mw002_customerEdit-tableEmail">
							    				</tbody>
							    			</table>
							    		</div>
							    	</div>
							    </div>
						    </div>
					    </div>
					    <!-- .end of rel001_20_mw002_tabEmail -->
					    
					    <div id="rel001_20_mw002_tabAddress" class="tab-pane">
						    <div class="row">
							    <div class="col-lg-12">
								    <div class="ibox float-e-margins" style="margin:0px;">
									    <div class="ibox-title" style="border-top:2px;">
									    	<div class="note-toolbar btn-toolbar">
				                        		<div class="note-font btn-group">
				                        			<button type="button" class="btn btn-xs btn-info" title="" tabindex="-1" onclick="rel001_20_mw002_address_addNew();">
				                        				<i class="fa fa-plus" aria-hidden="true"></i>
				                        			    Add New Address
				                        			</button>
				                        		</div>
				                        	</div>
									    </div>
									    <div class="ibox-content">
									    	<table class="table table-striped table-bordered table-hover " id="rel001_20_mw002_customerAddressTable" >
											    <thead>
												    <tr>
													    <th>Type</th>
													    <th>Attn To:</th>
													    <th>Street</th>
													    <th>Postal Code</th>
													    <th>City</th>
													    <th>State</th>
													    <th>Country</th>
													    <th>Action</th>
												    </tr>
											    </thead>
											    <tbody id="rel001_20_mw002_customerEdit-tableAddress">
											    </tbody>
										    </table>
									    </div>
								    </div>
							    </div>
						    </div>
					    </div>
					    <!-- .end of rel001_20_mw002_tabAddress -->
					    
					    <div id="rel001_20_mw002_tabCustom" class="tab-pane">
						    <div class="row">
							    <div class="col-lg-12">
								    <div class="ibox float-e-margins" style="margin:0px;">
									    <div class="ibox-title" style="border-top:2px;">
									    	<div class="note-toolbar btn-toolbar">
				                        		<div class="note-font btn-group">
				                        			<button type="button" class="btn btn-xs btn-info" title="" tabindex="-1" onclick="rel001_20_mw002_custom_addNew();">
				                        				<i class="fa fa-plus" aria-hidden="true"></i>
				                        			    Add New Custom Field
				                        			</button>
				                        		</div>
				                        	</div>
									    </div>
									    <div class="ibox-content">
										    <table class="table table-striped table-bordered table-hover " id="rel001_20_mw002_customerPropertiesTable" >
											    <thead>
												    <tr>
													    <th>Key</th>
													    <th>Value</th>
													    <th>Remarks</th>
													    <th>Action</th>
												    </tr>
											    </thead>
											    <tbody id="rel001_20_mw002_customerEdit-tableCustom">
											    </tbody>
										    </table>
									    </div>
								    </div>
							    </div>
						    </div>
					    </div>
					    <!-- .end of rel001_20_mw002_tabCustom -->
			    	</div>
			    </div>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn btn-primary" onclick="rel001_20_mw002_saveChanges();">Save Changes</button>
		    	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		    </div>
	    </div>
    </div>
</div>

<style>
.input_text_small {
    width: 100%;
    height: 24px;
    font-size: 13px;
}
.input_select_small {
    height: 24px;
    font-size: 13px;
    padding-top: 0px;
    padding-bottom: 0px;"
}
</style>

<script>

var rel001_20_mw002_initialized = false;
var rel001_20_mw002_onUpdating = false;
var rel001_20_mw002_customerObj;

/**
 * Init components.
 */
function rel001_20_mw002_init()
{
    if (rel001_20_mw002_initialized==true)
        return false;

    $('#rel001_20_mw002_customerContactTable').DataTable();
    $('#rel001_20_mw002_customerEmailTable').DataTable();
    $('#rel001_20_mw002_customerAddressTable').DataTable();
    $('#rel001_20_mw002_customerPropertiesTable').DataTable();
    
    $('#rel001_20_mw002_customerGender_male').on('ifChecked', function(event){
        tycheesLogger_logDebug('male','rel001_20_mw002_init');
    	rel001_20_mw002_customerObj.gender = AppConstants.GENDER_MALE;
    });
    $('#rel001_20_mw002_customerGender_female').on('ifChecked', function(event){
        tycheesLogger_logDebug('female','rel001_20_mw002_init');
    	rel001_20_mw002_customerObj.gender = AppConstants.GENDER_FEMALE;
    });
    
    rel001_20_mw002_initialized = true;
} // .end of rel001_02_mw001_init

/**
 * Init components.
 */
function rel001_20_mw002_open(customerId)
{
	// Set customer ID to page context
	$('#rel001_20_mw002_customerId').val(customerId);
	
	rel001_20_mw002_updateUI();
} // .end of rel001_02_mw001_open

// -----------------------------------------------------------------------------
// UPDATE UI

/**
 * Update UI panels.
 */
function rel001_20_mw002_updateUI()
{
    var customerId = $('#rel001_20_mw002_customerId').val();
    rel001_20_mw002_customerObj = Cached_getCustomerById(customerId);
    
    if (rel001_20_mw002_customerObj == null)
        return false;
        
	// init
	rel001_20_mw002_init();
	// Basic Info Tab
	rel001_20_mw002_updateUI_tab01();
    // Contact Tab
    rel001_20_mw002_updateUI_tab02();
    // Email Tab
    rel001_20_mw002_updateUI_tab03();
    // Address Tab
    rel001_20_mw002_updateUI_tab04();
    // Custom Tab
    rel001_20_mw002_updateUI_tab05();
    
    $('#rel001_20_mw002').modal({backdrop: 'static', keyboard: false});
} // .end of rel001_20_mw002_updateUI

/**
 * Update UI of Basic Info (TAB #1)
 */
function rel001_20_mw002_updateUI_tab01()
{
	rel001_20_mw002_onUpdating = true;
	
	var identityVal = rel001_20_mw002_customerObj.firstName + ' ' + rel001_20_mw002_customerObj.lastName + 
					  ' (' + rel001_20_mw002_customerObj.id + ')';

	// Set frame title & subtitles
    $("#rel001_20_mw002_customerNo").val(rel001_20_mw002_customerObj.customerNo);
    $("#rel001_20_mw002_customerFirstName").val(rel001_20_mw002_customerObj.firstName);
    $("#rel001_20_mw002_customerLastName").val(rel001_20_mw002_customerObj.lastName);
    $("#rel001_20_mw002_customerDob").val(tycheesDateTime_getFormattedDate_ddMMyyyy(rel001_20_mw002_customerObj.dob));
    $("#rel001_20_mw002_customerDescription").val(rel001_20_mw002_customerObj.description);
    
    if (rel001_20_mw002_customerObj.gender==AppConstants.GENDER_MALE)
        $('#rel001_20_mw002_customerGender_male').iCheck('check');
    else
    if (rel001_20_mw002_customerObj.gender==AppConstants.GENDER_FEMALE)
        $('#rel001_20_mw002_customerGender_female').iCheck('check');
    else 
    {
        $('#rel001_20_mw002_customerGender_male').iCheck('uncheck');
        $('#rel001_20_mw002_customerGender_female').iCheck('uncheck');
    }
    
	rel001_20_mw002_onUpdating = false;
} // .end of rel001_20_mw002_updateUI_tab01

/**
 * Update UI of Contact Panel (TAB #2)
 */
function rel001_20_mw002_updateUI_tab02()
{
	rel001_20_mw002_onUpdating = true;
	
    $('#rel001_20_mw002_customerContactTable').DataTable().clear().draw();
    $.each(rel001_20_mw002_customerObj.contactList, function(index, contactObj) {
    	if (Cached_isDeletedBean(contactObj)==false)
    		rel001_20_mw002_contact_addRow(contactObj);
    });
    $('#rel001_20_mw002_customerContactTable').DataTable().draw();
    
	rel001_20_mw002_onUpdating = false;
} // .end of rel001_20_mw002_updateUI_tab02

/**
 * Update UI of Email Panel (TAB #3)
 */
function rel001_20_mw002_updateUI_tab03()
{
	rel001_20_mw002_onUpdating = true;
	
    $('#rel001_20_mw002_customerEmailTable').DataTable().clear().draw();
    $.each(rel001_20_mw002_customerObj.emailList, function(index, emailObj) {
    	if (Cached_isDeletedBean(emailObj)==false)
    		rel001_20_mw002_email_addRow(emailObj);
    });
    $('#rel001_20_mw002_customerEmailTable').DataTable().draw();
    
	rel001_20_mw002_onUpdating = false;
} // .end of rel001_20_mw002_updateUI_tab03

/**
 * Update UI of Address Panel (TAB #4)
 */
function rel001_20_mw002_updateUI_tab04()
{
	rel001_20_mw002_onUpdating = true;
 
	$('#rel001_20_mw002_customerAddressTable').DataTable().clear().draw();
    $.each(rel001_20_mw002_customerObj.addressList, function(index, addressObj) {
    	if (Cached_isDeletedBean(addressObj)==false)
    		rel001_20_mw002_address_addRow(addressObj);
    });
    $('#rel001_20_mw002_customerAddressTable').DataTable().draw();
    
	rel001_20_mw002_onUpdating = false;
} // .end of rel001_20_mw002_updateUI_tab04

/**
 * Update UI of Custom Properties Panel (TAB #5)
 */
function rel001_20_mw002_updateUI_tab05()
{
	rel001_20_mw002_onUpdating = true;
	
    $('#rel001_20_mw002_customerPropertiesTable').DataTable().clear().draw();
    $.each(rel001_20_mw002_customerObj.propertiesList, function(index, propertiesObj) {
    	if (Cached_isDeletedBean(propertiesObj)==false)
    		rel001_20_mw002_custom_addRow(propertiesObj);
    });
    $('#rel001_20_mw002_customerPropertiesTable').DataTable().draw();
    
	rel001_20_mw002_onUpdating = false;
} // .end of rel001_20_mw002_updateUI_tab05

// .end of UPDATE UI
// -----------------------------------------------------------------------------
// ADD DataTable Row

/**
 * Add row into dataTable, displaying currently passed in contactObj.
 *
 * @param   {CustomerContactBean} contactObj - Contact Object.
 */
function rel001_20_mw002_contact_addRow(contactObj) 
{
    // COL #1
    var htmlLines_col1 = '';
    htmlLines_col1 += '<select id="rel001_20_mw002_contactType_' + contactObj.id + '" onchange="rel001_20_mw002_save_tab02();" style="width:90px;" class="form-control input_select_small">';
    htmlLines_col1 += '<option value="' + CustomerConstants.CONTACT_TYPE_MOBILE + '" ' + (contactObj.type==CustomerConstants.CONTACT_TYPE_MOBILE ? 'selected' : '') + '>' + CustomerConstants.CONTACT_TYPE_MOBILE + '</option>';
    htmlLines_col1 += '<option value="' + CustomerConstants.CONTACT_TYPE_HOME + '" ' + (contactObj.type==CustomerConstants.CONTACT_TYPE_HOME ? 'selected' : '') + '>' + CustomerConstants.CONTACT_TYPE_HOME + '</option>';
    htmlLines_col1 += '<option value="' + CustomerConstants.CONTACT_TYPE_OFFICE + '" ' + (contactObj.type==CustomerConstants.CONTACT_TYPE_OFFICE ? 'selected' : '') + '>' + CustomerConstants.CONTACT_TYPE_OFFICE + '</option>';
    htmlLines_col1 += '</select>';
    
    // COL #2
    var htmlLines_col2 = '';
    htmlLines_col2 += '<input type="text" id="rel001_20_mw002_contactCountryCode_' + contactObj.id + '" value="' + contactObj.countryCode + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab02();">';
    
    // COL #3
    var htmlLines_col3 = '';
    htmlLines_col3 += '<input type="text" id="rel001_20_mw002_contactAreaCode_' + contactObj.id + '" value="' + contactObj.areaCode + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab02();">';
    
    // COL #4
    var htmlLines_col4 = '';
    htmlLines_col4 += '<input type="text" id="rel001_20_mw002_contactNumber_' + contactObj.id + '" value="' + contactObj.phoneNumber + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab02();">';
    
    // COL #5
    var htmlLines_col5 = '';
    htmlLines_col5 += '<input type="text" id="rel001_20_mw002_contactExtension_' + contactObj.id + '" value="' + contactObj.extension + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab02();">';
    
    // COL #6
    var buttonVal_makePrimary = '';
    buttonVal_makePrimary += '<a onclick="rel001_20_mw002_contact_makePrimary(\'' + contactObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
    buttonVal_makePrimary += '<i class="fa fa-circle-o" aria-hidden="true"></i> ';
    buttonVal_makePrimary += '</a>';
    
    var buttonVal_delete = '';
    buttonVal_delete += '<a onclick="rel001_20_mw002_contact_deleteRow(\'' + contactObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
    buttonVal_delete += '<i class="fa fa-times" aria-hidden="true"></i> ';
    buttonVal_delete += '</a>';
    
    if (contactObj.defaultContact==true)
    {
        buttonVal_makePrimary = '';
        buttonVal_makePrimary += '<a href="#" class="btn btn-primary btn-xs disabled">';
        buttonVal_makePrimary += '<i class="fa fa-check" aria-hidden="true"></i> ';
        buttonVal_makePrimary += '</a>';
    }
    
    var htmlLines_col6 = '';
    htmlLines_col6 += buttonVal_makePrimary;
    htmlLines_col6 += ' ';
    htmlLines_col6 += buttonVal_delete;
    
    // Prepare row set.
    var rowSet = [];
    rowSet.push( htmlLines_col1 );
    rowSet.push( htmlLines_col2 );
    rowSet.push( htmlLines_col3 );
    rowSet.push( htmlLines_col4 );
    rowSet.push( htmlLines_col5 );
    rowSet.push( htmlLines_col6 );
    
    $('#rel001_20_mw002_customerContactTable').dataTable().fnAddData( rowSet, false );
} // .end of rel001_20_mw002_contact_addRow

/**
 * Add row into dataTable, displaying currently passed in emailObj.
 * 
 * @param   {CustomerEmailBean} emailObj - Email Object.
 */
function rel001_20_mw002_email_addRow(emailObj) 
{
    // COL #1
    var htmlLines_col1 = '';
    htmlLines_col1 += '<input type="text" id="rel001_20_mw002_emailAddress_' + emailObj.id + '" value="' + emailObj.emailAddress + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab03();">';
    
    // COL #2
    var buttonVal_makePrimary = '';
    buttonVal_makePrimary += '<a onclick="rel001_20_mw002_email_makePrimary(\'' + emailObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
    buttonVal_makePrimary += '<i class="fa fa-circle-o" aria-hidden="true"></i> ';
    buttonVal_makePrimary += '</a>';
    
    var buttonVal_delete = '';
    buttonVal_delete += '<a onclick="rel001_20_mw002_email_deleteRow(\'' + emailObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
    buttonVal_delete += '<i class="fa fa-times" aria-hidden="true"></i> ';
    buttonVal_delete += '</a>';
    
    if (emailObj.primaryEmail==true)
    {
        buttonVal_makePrimary = '';
        buttonVal_makePrimary += '<a href="#" class="btn btn-primary btn-xs disabled">';
        buttonVal_makePrimary += '<i class="fa fa-check" aria-hidden="true"></i> ';
        buttonVal_makePrimary += '</a>';
    }
    
    var htmlLines_col2 = '';
    htmlLines_col2 += buttonVal_makePrimary;
    htmlLines_col2 += ' ';
    htmlLines_col2 += buttonVal_delete;
    
    // Prepare Row Set
    var rowSet = [];
    rowSet.push(htmlLines_col1);
    rowSet.push(htmlLines_col2);
    
    $('#rel001_20_mw002_customerEmailTable').dataTable().fnAddData( rowSet, false );
} // .end of rel001_20_mw002_email_addRow

/**
 * Add row into dataTable, displaying currently passed in addressObj.
 * 
 * @param   {CustomerAddressBean} addressObj - Address Object.
 */
function rel001_20_mw002_address_addRow(addressObj) 
{
    // COL #1
    var htmlLines_col1 = '';
    htmlLines_col1 += '<select id="rel001_20_mw002_addressType_' + addressObj.id + '" onchange="rel001_20_mw002_save_tab04();" style="width:90px;" class="form-control input_select_small">';
    htmlLines_col1 += '<option value="mobile" ' + (addressObj.type==CustomerConstants.CONTACT_TYPE_HOME ? 'selected' : '') + '>Mobile</option>';
    htmlLines_col1 += '<option value="home" ' + (addressObj.type==CustomerConstants.CONTACT_TYPE_HOME ? 'selected' : '') + '>Home</option>';
    htmlLines_col1 += '<option value="office" ' + (addressObj.type==CustomerConstants.CONTACT_TYPE_HOME ? 'selected' : '') + '>Office</option>';
    htmlLines_col1 += '</select>';
    
    // COL #2
    var htmlLines_col2 = '';
    htmlLines_col2 += '<input type="text" id="rel001_20_mw002_addressAttentionTo_' + addressObj.id + '" value="' + addressObj.attentionTo + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab04();">';
    
    // COL #3
    var htmlLines_col3 = '';
    htmlLines_col3 += '<input type="text" id="rel001_20_mw002_addressStreetLine1_' + addressObj.id + '" value="' + addressObj.streetLine1 + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab04();">';
    
    // COL #4
    var htmlLines_col4 = '';
    htmlLines_col4 += '<input type="text" id="rel001_20_mw002_addressPostalCode_' + addressObj.id + '" value="' + addressObj.postalCode + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab04();">';
    
    // COL #5
    var htmlLines_col5 = '';
    htmlLines_col5 += '<input type="text" id="rel001_20_mw002_addressCity_' + addressObj.id + '" value="' + addressObj.city + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab04();">';
    
    // COL #6
    var htmlLines_col6 = '';
    htmlLines_col6 += '<input type="text" id="rel001_20_mw002_addressState_' + addressObj.id + '" value="' + addressObj.state + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab04();">';
    
    // COL #7
    var htmlLines_col7 = '';
    htmlLines_col7 += '<input type="text" id="rel001_20_mw002_addressCountry_' + addressObj.id + '" value="' + addressObj.country + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab04();">';
    
    // COL #8
    var buttonVal_makePrimary = '';
    buttonVal_makePrimary += '<a onclick="rel001_20_mw002_address_makePrimary(\'' + addressObj.id + '\');" href="#" class="btn btn-primary btn-xs">';
    buttonVal_makePrimary += '<i class="fa fa-circle-o" aria-hidden="true"></i> ';
    buttonVal_makePrimary += '</a>';
    
    var buttonVal_delete = '';
    buttonVal_delete += '<a onclick="rel001_20_mw002_address_deleteRow(\'' + addressObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
    buttonVal_delete += '<i class="fa fa-times" aria-hidden="true"></i> ';
    buttonVal_delete += '</a>';
    
    if (addressObj.defaultAddress==true)
    {
        buttonVal_makePrimary = '';
        buttonVal_makePrimary += '<a href="#" class="btn btn-primary btn-xs disabled">';
        buttonVal_makePrimary += '<i class="fa fa-check" aria-hidden="true"></i> ';
        buttonVal_makePrimary += '</a>';
    }
    
    var htmlLines_col8 = ''
    htmlLines_col8 += buttonVal_makePrimary;
    htmlLines_col8 += ' ';
    htmlLines_col8 += buttonVal_delete;
    
    // Prepare Row Set
    var rowSet = [];
    rowSet.push(htmlLines_col1);
    rowSet.push(htmlLines_col2);
    rowSet.push(htmlLines_col3);
    rowSet.push(htmlLines_col4);
    rowSet.push(htmlLines_col5);
    rowSet.push(htmlLines_col6);
    rowSet.push(htmlLines_col7);
    rowSet.push(htmlLines_col8);
    
    $('#rel001_20_mw002_customerAddressTable').dataTable().fnAddData( rowSet, false );
} // .end of rel001_20_mw002_address_addRow

/**
 * Add row into dataTable, displaying currently passed in propertiesObj.
 * 
 * @param   {CustomerPropertiesBean} addressObj - Address Object.
 */
function rel001_20_mw002_custom_addRow(propertiesObj) 
{
    // COL #1
    var htmlLines_col1 = '';
    htmlLines_col1 += '<input type="text" id="rel001_20_mw002_key_' + propertiesObj.id + '" value="' + propertiesObj.propKey + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab05();">';
    
    // COL #2
    var htmlLines_col2 = '';
    htmlLines_col2 += '<input type="text" id="rel001_20_mw002_value_' + propertiesObj.id + '" value="' + propertiesObj.propValue + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab05();">';
    
    // COL #3
    var htmlLines_col3 = '';
    htmlLines_col3 += '<input type="text" id="rel001_20_mw002_remarks_' + propertiesObj.id + '" value="' + propertiesObj.remarks + '" style="width:100%;" class="form-control input_text_small" oninput="rel001_20_mw002_save_tab05();">';
    
    // COL #4
    var htmlLines_col4 = '';
    htmlLines_col4 += '<a onclick="rel001_20_mw002_custom_deleteRow(\'' + propertiesObj.id + '\');" href="#" class="btn btn-danger btn-xs">';
    htmlLines_col4 += '<i class="fa fa-times" aria-hidden="true"></i>';
    htmlLines_col4 += '</a>';
    
    // Prepare Row Set
    var rowSet = [];
    rowSet.push(htmlLines_col1);
    rowSet.push(htmlLines_col2);
    rowSet.push(htmlLines_col3);
    rowSet.push(htmlLines_col4);
    
    $('#rel001_20_mw002_customerPropertiesTable').dataTable().fnAddData( rowSet, false );
} // .end of rel001_20_mw002_custom_addRow

// .end of ADD DataTable Row
// -----------------------------------------------------------------------------
// ADD NEW ROW

/**
 * Add new dummy row into DataTable.
 */
function rel001_20_mw002_contact_addNew() 
{
    // Init contact object
    var newContactObj = createNew_CustomerContact();
    newContactObj.customerId = rel001_20_mw002_customerObj.id;
    newContactObj.countryCode = '+00';
    newContactObj.areaCode = '00';
    newContactObj.phoneNumber = '00000000';
    newContactObj.extension = '';
    
    // Add into current customer's contact list
    rel001_20_mw002_customerObj.contactList.push(newContactObj);
    
    // Display to UI
    rel001_20_mw002_contact_addRow(newContactObj);
    
    // If only one record, then set it as primary record
    if (rel001_20_mw002_customerObj.contactList.length==1)
    	rel001_20_mw002_contact_makePrimary(newContactObj.id);
} // .end of rel001_20_mw002_contact_addNew
	  
/**
 * Add new dummy row into DataTable.
 */
function rel001_20_mw002_email_addNew() 
{
    // Init contact object
    var newEmailObj = createNew_CustomerEmail();
    newEmailObj.customerId = rel001_20_mw002_customerObj.id;
    newEmailObj.emailAddress = 'NO VALUE';
    
    // Add into current customer's contact list
    rel001_20_mw002_customerObj.emailList.push(newEmailObj);
    
    // Display to UI
    rel001_20_mw002_email_addRow(newEmailObj);
    
    // If only one record, then set it as primary record
    if (rel001_20_mw002_customerObj.emailList.length==1)
    	rel001_20_mw002_email_makePrimary(newEmailObj.id);
} // .end of rel001_20_mw002_contact_addNew

/**
 * Add new dummy row into DataTable.
 */
function rel001_20_mw002_address_addNew() 
{
    // Init contact object
    var newAddressObj = createNew_CustomerAddress();
    newAddressObj.attentionTo = 'NO VALUE';
    newAddressObj.streetLine1 = 'NO VALUE';
    newAddressObj.postalCode = 'NO VALUE';
    newAddressObj.city = 'NO VALUE';
    newAddressObj.state = 'NO VALUE';
    newAddressObj.country = 'NO VALUE';
    
    // Add into current customer's address list
    rel001_20_mw002_customerObj.addressList.push(newAddressObj);
    
    // Display to UI
    rel001_20_mw002_address_addRow(newAddressObj);
    
    // If only one record, then set it as primary record
    if (rel001_20_mw002_customerObj.addressList.length==1)
    	rel001_20_mw002_address_makePrimary(newAddressObj.id);
} // .end of rel001_20_mw002_address_addNew
  
/**
 * Add new dummy row into DataTable.
 */
function rel001_20_mw002_custom_addNew() 
{
    // Init contact object
    var newCustomObj = createNew_CustomerProperties();
    newCustomObj.customerId = rel001_20_mw002_customerObj.id;
    newCustomObj.propKey = 'No Key';
    newCustomObj.propValue = 'No Value';
    newCustomObj.remarks = 'No Remark';
    
    // Add into current customer's address list
    rel001_20_mw002_customerObj.propertiesList.push(newCustomObj);
    
    // Display to UI
    rel001_20_mw002_custom_addRow(newCustomObj);
} // .end of rel001_20_mw002_custom_addNew
  
// .end of ADD NEW ROW
// -----------------------------------------------------------------------------
// MAKE PRIMARY

/**
 * Make this contact as primary, and update customerObj.contact. 
 * 
 * @param   {String} contactId - Contact ID
 */
function rel001_20_mw002_contact_makePrimary(contactId) 
{
    $.each(rel001_20_mw002_customerObj.contactList, function(index, contactObj){
        if (contactId==contactObj.id)
        {
            contactObj.defaultContact = true;
            rel001_20_mw002_customerObj.contact = tycheesBean_toString_commonContactBean(contactObj);	// @refer tychees.common-1.0.js
        }
        else
        {
            contactObj.defaultContact = false;
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab02();
} // .end of rel001_20_mw002_contact_makePrimary

/**
 * Make this email as primary, and update customerObj.email. 
 * 
 * @param   {String} emailId - Email ID
 */
function rel001_20_mw002_email_makePrimary(emailId) 
{
    $.each(rel001_20_mw002_customerObj.emailList, function(index, emailObj){
        if (emailId==emailObj.id)
        {
            emailObj.primaryEmail = true;
            rel001_20_mw002_customerObj.email = customerEmail_getFullEmail(emailObj);		// @refer self UTIL section
        }
        else
        {
            emailObj.primaryEmail = false;
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab03();
} // .end of rel001_20_mw002_email_makePrimary

/**
 * Make this address as primary, and update customerObj.address. 
 * 
 * @param   {String} addressId - Address ID
 */
function rel001_20_mw002_address_makePrimary(addressId) 
{
    $.each(rel001_20_mw002_customerObj.addressList, function(index, addressObj){
        if (addressId==addressObj.id)
        {
            addressObj.defaultAddress = true;
            rel001_20_mw002_customerObj.address = tycheesBean_toString_commonAddressBean(addressObj);	// @refer tychees.common-1.0.js
        }
        else
        {
            addressObj.defaultAddress = false;
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab04();
} // .end of rel001_20_mw002_address_makePrimary

// .end of MAKE PRIMARY
// -----------------------------------------------------------------------------
// DELETE ROW
	
/**
 * Delete this contact from current customer object.
 * 
 * @param   {String} contactId - Contact ID
 */
function rel001_20_mw002_contact_deleteRow(contactId) 
{
    $.each(rel001_20_mw002_customerObj.contactList, function(i, contactObj){
        if (contactId==contactObj.id)
        {
            Cached_deleteBean(contactObj);

        	// Reset if this contact is primary
            if (contactObj.defaultContact==true)
            {
            	rel001_20_mw002_customerObj.contact = '';
            }
        }
        else
        {
        	if (rel001_20_mw002_customerObj.contactList.length == 2)
        	{
        		rel001_20_mw002_contact_makePrimary( contactObj.id );
        	}
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab02();   
} // .end of rel001_20_mw002_contact_deleteRow

/**
 * Delete this email from current customer object.
 * 
 * @param   {String} emailId - Email ID
 */
function rel001_20_mw002_email_deleteRow(emailId) 
{
    $.each(rel001_20_mw002_customerObj.emailList, function(i, emailObj){
    	if (emailId==emailObj.id)
        {
            Cached_deleteBean( emailObj );

        	// Reset if this contact is primary
            if (emailObj.primaryEmail==true)
            {
            	rel001_20_mw002_customerObj.email = '';
            }      
        }
        else
        {
        	if (rel001_20_mw002_customerObj.emailList.length == 2)
        	{
        		rel001_20_mw002_email_makePrimary( emailObj.id );
        	}
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab03();   
} // .end of rel001_20_mw002_email_deleteRow

/**
 * Delete this address from current customer object.
 * 
 * @param   {String} emailId - Email ID
 */
function rel001_20_mw002_address_deleteRow(addressId) 
{
    $.each(rel001_20_mw002_customerObj.addressList, function(i, addressObj){
    	if (addressId==addressObj.id)
        {
            Cached_deleteBean(addressObj);

        	// Reset if this contact is primary
            if (addressObj.defaultAddress==true)
            {
            	rel001_20_mw002_customerObj.address = '';
            }
            
            rel001_20_mw002_updateUI_tab04();            
        }
        else
        {
        	if (rel001_20_mw002_customerObj.addressList.length == 2)
        	{
        		rel001_20_mw002_address_makePrimary( addressObj.id );
        	}
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab04();   
} // .end of rel001_20_mw002_address_deleteRow

/**
 * Delete this custom field from current customer object.
 * 
 * @param   {String} emailId - Email ID
 */
function rel001_20_mw002_custom_deleteRow(propId) 
{
    $.each(rel001_20_mw002_customerObj.propertiesList, function(index, propObj){
        if (propId==propObj.id)
        {
            Cached_deleteBean(propObj);
        }
    });
    
    // Refresh UI
    rel001_20_mw002_updateUI_tab05();  
} // .end of rel001_20_mw002_custom_deleteRow

// .end of DELETE ROW
// -----------------------------------------------------------------------------
// SAVE

/**
 * Save TAB #1.
 */
function rel001_20_mw002_save_tab01()
{
	if (rel001_20_mw002_onUpdating==true)
		return false;

    var customerNo = $.trim( $("#rel001_20_mw002_customerNo").val() );
	var firstName = $.trim( $("#rel001_20_mw002_customerFirstName").val() );
    var lastName = $.trim( $("#rel001_20_mw002_customerLastName").val() );
    var gender = $.trim( $( "#rel001_20_mw002_customerGender" ).val() );
    var dob = $.trim( $("#rel001_20_mw002_customerDob").val() );
    var description = $( "#rel001_20_mw002_customerDescription" ).val();
   
    rel001_20_mw002_customerObj.customerNo = customerNo;
    rel001_20_mw002_customerObj.firstName = firstName;
    rel001_20_mw002_customerObj.lastName = lastName;
    rel001_20_mw002_customerObj.dob = tycheesDateTime_toMilliseconds_ddMMyyyy(dob);
    //rel001_20_mw002_customerObj.gender = gender;
    rel001_20_mw002_customerObj.description = description;
} // .end of rel001_20_mw002_save_tab01

/**
 * Save TAB #2.
 */
function rel001_20_mw002_save_tab02()
{
	if (rel001_20_mw002_onUpdating==true)
		return false;
	
	$.each(rel001_20_mw002_customerObj.contactList, function(i, contactObj){
	
		var typeVal 		= tycheesText_getSafeString( $('#rel001_20_mw002_contactType_'+contactObj.id).val() );
		var countryCodeVal	= tycheesText_getSafeString( $('#rel001_20_mw002_contactCountryCode_'+contactObj.id).val() );
		var areaCodeVal		= tycheesText_getSafeString( $('#rel001_20_mw002_contactAreaCode_'+contactObj.id).val() );
		var phoneNumberVal	= tycheesText_getSafeString( $('#rel001_20_mw002_contactNumber_'+contactObj.id).val() );
		var extensionVal	= tycheesText_getSafeString( $('#rel001_20_mw002_contactExtension_'+contactObj.id).val() );
		
		contactObj.type			= typeVal;
		contactObj.countryCode	= countryCodeVal;
		contactObj.areaCode		= areaCodeVal;
		contactObj.phoneNumber	= phoneNumberVal;
		contactObj.extension	= extensionVal;
		contactObj.hasChanged   = true;
			
		if (contactObj.defaultContact==true)
			rel001_20_mw002_customerObj.contact = tycheesBean_toString_commonContactBean(contactObj);	// @refer tychees.common-1.0.js
	});
} // .end of rel001_20_mw002_save_tab02

/**
 * Save TAB #3.
 */
function rel001_20_mw002_save_tab03()
{
	if (rel001_20_mw002_onUpdating==true)
		return false;
	
    $.each(rel001_20_mw002_customerObj.emailList, function(i, emailObj){
	
		var addressVal 			= tycheesText_getSafeString( $('#rel001_20_mw002_emailAddress_'+emailObj.id).val() );
		emailObj.emailAddress	= addressVal;
		emailObj.hasChanged     = true;

		if (emailObj.primaryEmail==true)
			rel001_20_mw002_customerObj.email = customerEmail_getFullEmail(emailObj);		// @refer self UTIL section
	});
} // .end of rel001_20_mw002_save_tab03

/**
 * Save TAB #4.
 */
function rel001_20_mw002_save_tab04()
{
	if (rel001_20_mw002_onUpdating==true)
		return false;
	
	$.each(rel001_20_mw002_customerObj.addressList, function(i, addressObj){
	
		var typeVal 		= tycheesText_getSafeString( $('#rel001_20_mw002_addressType_'+addressObj.id).val() );
		var attentionToVal	= tycheesText_getSafeString( $('#rel001_20_mw002_addressAttentionTo_'+addressObj.id).val() );
		var streetLine1Val	= tycheesText_getSafeString( $('#rel001_20_mw002_addressStreetLine1_'+addressObj.id).val() );
		var postalCodeVal	= tycheesText_getSafeString( $('#rel001_20_mw002_addressPostalCode_'+addressObj.id).val() );
		var cityVal			= tycheesText_getSafeString( $('#rel001_20_mw002_addressCity_'+addressObj.id).val() );
		var stateVal		= tycheesText_getSafeString( $('#rel001_20_mw002_addressState_'+addressObj.id).val() );
		var countryVal		= tycheesText_getSafeString( $('#rel001_20_mw002_addressCountry_'+addressObj.id).val() );
		
		addressObj.type			= typeVal;
		addressObj.attentionTo	= attentionToVal;
		addressObj.streetLine1	= streetLine1Val;
		addressObj.postalCode	= postalCodeVal;
		addressObj.city			= cityVal;
		addressObj.state		= stateVal;
		addressObj.country		= countryVal;
		addressObj.hasChanged   = true;
		
		if (addressObj.defaultAddress==true)
			rel001_20_mw002_customerObj.address = tycheesBean_toString_commonAddressBean(addressObj);	// @refer tychees.common-1.0.js
	});
} // .end of rel001_20_mw002_save_tab04

/**
 * Save TAB #5.
 */
function rel001_20_mw002_save_tab05()
{
	if (rel001_20_mw002_onUpdating==true)
		return false;
	
	$.each(rel001_20_mw002_customerObj.propertiesList, function(i, propertiesObj){
	
		var keyVal 		= tycheesText_getSafeString( $('#rel001_20_mw002_key_'+propertiesObj.id).val() );
		var valueVal	= tycheesText_getSafeString( $('#rel001_20_mw002_value_'+propertiesObj.id).val() );
		var remarksVal	= tycheesText_getSafeString( $('#rel001_20_mw002_remarks_'+propertiesObj.id).val() );
		
		propertiesObj.propKey	 = keyVal;
		propertiesObj.propValue	 = valueVal;
		propertiesObj.remarks	 = remarksVal;
		propertiesObj.hasChanged = true;
	});
} // .end of rel001_20_mw002_save_tab05

function rel001_20_mw002_saveChanges()
{
	rel001_20_mw002_save_tab01();
	rel001_20_mw002_save_tab02();
	rel001_20_mw002_save_tab03();
	rel001_20_mw002_save_tab04();
	rel001_20_mw002_save_tab05();
    
    // Save to localDB
    tycheesIO_saveBean(rel001_20_mw002_customerObj);
	// Update UI of parent screen.
    rel001_02_updateUI(false);        

    $('#rel001_20_mw002').modal('hide');
} // .end of rel001_20_mw002_saveChanges

// .end of SAVE
// -----------------------------------------------------------------------------
// UTIL

function customerEmail_getFullEmail(emailObj)
{
    if (emailObj == null)
    {
        return 'EMAIL IS EMPTY';
    }
    else
    {
        return emailObj.emailAddress;
    }
} // .end of customerEmail_getFullEmail

// .end of UTIL
// -----------------------------------------------------------------------------


</script>
