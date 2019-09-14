<!DOCTYPE html>
<html>
  <head>
        <meta charset="UTF-8">
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="853081554726-5rpeps5tm3k2l4d8ca23jnl6hm73a78q.apps.googleusercontent.com">
    
    <title>
    	TYCHEES | New User Registration
   	</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet" type="text/css" />  
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="/resources/plugins/adminlte/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- Customized Theme style -->
    <link href="/console/_common/lib/styles/tychees.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="/resources/plugins/blue/blue.css" rel="stylesheet" type="text/css" />
    <!-- Sweet alert -->    
    <link href="/resources/plugins/sweetalert/sweetalert.css" rel="stylesheet" type="text/css" />
	
  </head>
  <body class="register-page">
    <div class="register-box">
      <div class="register-logo" style="font-size:40pt;">
        <a href="/index.jsp">TYCHEES</a>
      </div>
      <div id="registrationFormPanel" class="register-box-body">
        <p class="register-box-msg">
          Register Your Tychees Account
        </p>
        <div class="input-group" style="width:100%;">
          <span class="input-group-addon" style="width:40px;">
            <i class="fa fa-user" aria-hidden="true"></i>
          </span>
          <input id="inputFirstName" type="text" class="form-control" placeholder="First name (2-20 characters)" required/>
		  <span class="input-group-addon" style="background-color:#DDDDDD; padding:0px;"></span>
		  <input id="inputLastName" type="text" class="form-control" placeholder="Last name (2-20 characters)" required/>
		  <span id="inputFirstName_error" style="color:#FF0000; display:none;">Invalid First Name (2-20 characters)</span>
          <span id="inputLastName_error" style="color:#FF0000; display:none;">Invalid Last Name (2-20 characters)</span>
        </div>
        
        <div style="height:10px;"></div>  
          
        <div class="input-group" style="width:100%;">
          <span class="input-group-addon" style="width:40px;">
            <i class="fa fa-envelope" aria-hidden="true"></i>
          </span>
          <input id="inputEmail" type="email" class="form-control" placeholder="Email (max 90 characters)" required/>
        </div>  
        <div>
          <span id="inputEmail_error" style="color:#FF0000; display:none;">Invalid Email (max 90 characters)</span>
          <span id="inputEmail_duplicate_error" style="color:#FF0000; display:none;">Duplicated Email Found. Plaese use another email</span>
        </div>
        
        <div style="height:10px;"></div>  
        
        <div class="input-group" style="width:100%;">
          <span class="input-group-addon" style="width:40px;">
            <i class="fa fa-key" aria-hidden="true"></i>
          </span>
          <input id="inputPassword" type="password" class="form-control" placeholder="Password (8-20 alphanumeric characters)" required/>
		  <span class="input-group-addon" style="background-color:#DDDDDD; padding:0px;"></span>
          <input id="inputConfirmPassword" type="password" class="form-control" placeholder="Retype password" required/>
        </div>  
        <div>
          <span id="inputPassword_error" style="color:#FF0000; display:none;">Invalid Password (8-20 characters, mix of Uppercase/Lowercase/Alphabet/Number)</span>
          <span id="inputConfirmPassworde_error" style="color:#FF0000; display:none;">Invalid Retyped Password</span>
        </div>
        
        <div style="height:10px;"></div>  
        
        <div class="input-group" style="width:100%;">
          <span class="input-group-addon" style="width:40px;">
            <i class="fa fa-building" aria-hidden="true"></i>
          </span>
          <input id="inputCompanyName" type="text" class="form-control" placeholder="Company name (2-40 characters)" required/>
        </div>  
        <div>
          <span id="inputCompanyName_error" style="color:#FF0000; display:none;">Invalid Company Name (2-40 characters)</span>
        </div>
        
        <div style="height:10px;"></div>  
        
        <div class="input-group" style="width:100%;">
          <span class="input-group-addon" style="width:40px;">
            <i class="fa fa-puzzle-piece" aria-hidden="true"></i>
          </span>
          <select id="inputBusinessType" class="form-control m-b">
            <option value="-">-- BUSINESS TYPE --</option>
            <option value="cafe">Cafe</option>
            <option value="grocery">Grocery</option>
            <option value="restaurant">Restaurant</option>
            <option value="tailor">Tailor</option>
          </select>
        </div>  
        <div>
          <span id="inputBusinessType_error" style="color:#FF0000; display:none;">Invalid Business Type</span>
        </div>
        
        <div style="height:10px;"></div>  
        
        <div class="input-group" style="width:100%;">
          <span class="input-group-addon" style="width:40px;">
            <i class="fa fa-link" aria-hidden="true"></i>
          </span>
          <span class="input-group-addon" style="color:#999;">https://www.tychees.com/</span>
          <input id="inputCompanyId" type="text" class="form-control" placeholder="Company UID (2-40 characters)" required/>
        </div> 
        <div>
          <span id="inputCompanyId_error" style="color:#FF0000; display:none;">Invalid Company UID (2-40 characters)</span>
          <span id="inputCompanyId_duplicate_error" style="color:#FF0000; display:none;">Duplucated Company UID found. Please use another.</span>
        </div>  
          
        <div style="height:10px;"></div>  
          <div class="g-recaptcha" data-sitekey="6Ld34CoUAAAAANQDHUcaxwoPvNpSYyV5AN8sDSr3"></div>  
          <span id="g_recaptcha_error" style="color:#FF0000; display:none;">Invalid reCaptcha</span>
          <br>   
          <div class="row">
            <div class="col-xs-8">    
              <div class="checkbox icheck">
                <label>
                  <input id="inputAgreement" type="checkbox" required> I agree to the <a href="#">terms</a>
                  <span id="inputAgreement_error" style="color:#FF0000; display:none;">Please agree before proceed.</span>
                </label>
              </div>                        
            </div>
            <div class="col-xs-4">
              <button class="btn btn-primary btn-block btn-flat" onclick="validateForm();">Register</button>
            </div>
          </div>
          
        <!-- /form-->        
        <a href="login.jsp" class="text-center">I already have a membership</a>
      </div>
      
      <div id="registrationSuccessPanel" class="register-box-body" style="display:none;">
        <p class="register-box-msg" style="font-size:18pt;">
          Registration Success
        </p>
        <div class="row">
          <div class="col-xs-6">
            <button class="btn btn-primary btn-block btn-flat" onclick="gotoRegistrationForm();">
              <i class="fa fa-user-plus" aria-hidden="true"></i> 
              <span style="padding-left:10px;">Register Another Account</span>
            </button>
          </div>
          <div class="col-xs-6">
            <button class="btn btn-primary btn-block btn-flat" onclick="gotoLoginForm();">
              <i class="fa fa-sign-in" aria-hidden="true"></i>
              <span style="padding-left:10px;">Login Now</span>
            </button>
          </div>
        </div>
        <div style="text-align:center; padding-top:20px;">
          <span>&copy;2017 TYCHEES</span>
        </div>
      </div>
    </div>
    
    <!-- jQuery 2.1.3 -->
    <script src="/resources/plugins/jquery/jquery-2.1.1.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="/resources/plugins/bootstrap/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="/resources/plugins/icheck/icheck.min.js"></script>
    <!-- Sweet Alert -->
    <script src="/resources/plugins/sweetalert/sweetalert.min.js"></script>
    <!-- DirectMe General Util -->
    <script src="/console/_common/lib/scripts/tychees.common.js"></script>
    <!-- JS Cookies (src: https://github.com/js-cookie/js-cookie) -->
    <script src="/resources/plugins/cookie/js.cookie.js"></script>
    <!-- Secure Random (src: https://github.com/jprichardson/secure-random) -->
    <script src="/resources/plugins/secure-random/secure-random.js"></script>
    <!-- Google API platform -->
    <script async defer src="https://apis.google.com/js/platform.js"></script>
    <!-- Google reCAPTCHA -->
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <!-- Crypto-JS -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.6.0/sha256.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/js-sha512/0.4.0/sha512.js'></script>
    <!-- Tychees -->
    <script src="/console/_common/lib/scripts/tychees.common.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.datetime.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.list.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.logger.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.overlay.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.text.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.util.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.database.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.database.io.js" type="text/javascript"></script>
    <script src="/console/_common/lib/scripts/tychees.security.js" type="text/javascript"></script>
    
    <script>
      $(function () {
          $('input').iCheck({
              checkboxClass: 'icheckbox_square-blue',
              radioClass: 'iradio_square-blue',
              increaseArea: '20%' // optional
          });
      });
      
      function validateForm() {
          
          // Reset
          $('#inputFirstName_error').hide();
          $('#inputLastName_error').hide();
          $('#inputEmail_error').hide();
          $('#inputEmail_duplicate_error').hide();
          $('#inputPassword_error').hide();
          $('#inputConfirmPassword_error').hide();
          $('#inputCompanyName_error').hide();
          $('#inputCompanyId_error').hide();
          $('#inputCompanyId_duplicate_error').hide();
          $('#inputBusinessType_error').hide();
          $('#inputAgreement_error').hide();
          $('#g_recaptcha_error').hide();
      
          // Capture user input
  	      var firstName               = $.trim( $('#inputFirstName').val() );
  	      var lastName                = $.trim( $('#inputLastName').val() );
   	      var email                   = $.trim( $('#inputEmail').val() );
   	      var password                = $.trim( $('#inputPassword').val() );
   	      var confirmPassword         = $.trim( $('#inputConfirmPassword').val() );
   	      var companyName             = $.trim( $('#inputCompanyName').val() );
   	      var companyUid              = $.trim( $('#inputCompanyId').val() );
   	      var businessType            = $.trim( $('#inputBusinessType').val() );
   	      var agreement               = $('#inputAgreement').prop('checked');
   	      var googleRecaptchaResponse = $.trim( $('#g-recaptcha-response').val() );
   	       	  
   	      // Validation 
   	      if (firstName.length < 2 || firstName.length > 20) {
   	          $('#inputFirstName_error').show();
   		        return false;
   	      }
   	      if (lastName.length < 2 || lastName.length > 20) {
   	          $('#inputLastName_error').show();
   		        return false;
   	      }
   	      if (email.length < 1 || email.length > 90) {
   	          $('#inputEmail_error').show();
   		        return false;
   	      }
   	      if (password.length < 8 || password.length > 20) {
   	          $('#inputPassword_error').show();
   		        return false;
   	      }
   	      if (password != confirmPassword) {
   	          $('#inputRetypedPassword_error').show();
   		        return false;
   	      }
   	      if (companyName.length < 8 || companyName.length > 20) {
   	          $('#inputCompanyName_error').show();
   		        return false;
   	      }
   	      if (companyUid.length < 8 || companyUid.length > 20) {
   	          $('#inputCompanyId_error').show();
   		        return false;
   	      }
   	      if (businessType == '-') {
   	          $('#inputBusinessType_error').show();
   	          return false;
   	      }
   	      if (agreement == false) {
   	          $('#inputAgreement_error').show();
   	          return false;
   	      }
   	      if (googleRecaptchaResponse.length == 0) {
   	          $('#g_recaptcha_error').show();
   	          return false;
   	      }
   	      // .end of Validation
      
          $('.register-box').hide();
          tycheesOverlay_startLongProgress('Registration in process... ');
          
          // Prepare request body
	   	  var requestBody = {
	   		      'email': email,
	   		      'companyUid': companyUid
	   	  };
          
	   	  // Prepare request body
	   	  var params = new Object();
	   	  params.firstName = firstName;
	   	  params.lastName = lastName;
	   	  params.email = email;
	   	  params.companyName = companyName;
	   	  params.companyUid = companyUid;
	   	  params.businessType = businessType;
	   	    
       	  // Ajax Call
       	  $.ajax({
       		  type: 'post',
              contentType: 'application/json',
       	      url: tycheesCommon_getRemoteServerURL() + '/console/validateUserRegistration',
       	      data: JSON.stringify( requestBody ),
       	      error: function(status) {
       		  	  tycheesdb_clearLocalCachedData();
 			      tycheesOverlay_stopLongProgress();
 			      $('.register-box').show();
 			  
 			      swal({
                      title: 'Validation Failure.',
                      text: "Ajax Exception: " + status,
                      type: "error"
                  });	
       	      },
       	      dataType: 'json',
       	      success: function(data, status, xhr) {
       		      tycheesOverlay_startLongProgress('Validation Success...');

       		      tycheesLogger_logInfo("xhr="+xhr, "onload");
       		      tycheesLogger_logInfo("status="+status, "onload");
       		      tycheesLogger_logInfo("data="+data, "onload");

                  if (data.emailExists) {
 			  	      tycheesOverlay_stopLongProgress();

 			          $('.register-box').show();
                      $('#inputEmail_duplicate_error').show();
   		              return false;
                  }
                  
                  if (data.companyUidExists) {
 			  	      tycheesOverlay_stopLongProgress();
 			  	      
 			          $('.register-box').show();
                      $('#inputCompanyId_duplicate_error').show();
   		              return false;
                  }
                  
                  registerUser(params);
       	      }              	
          });
          
      } // .end of validateForm
      
      function registerUser(params) {
              
    	  // Get user input
   	      var password = $.trim( $('#inputPassword').val() );
    	  // Generate secure random as salt
    	  var salt = tycheesSecurity_getSalt();    	  
    	  
          // Prepare request body
	   	  var requestBody = {
              'firstName': params.firstName,
              'lastName': params.lastName,
	   		  'email': params.email,
	   		  'password': tycheesSecurity_hashPassword(password, salt),
	   		  'salt': salt,
	   		  'companyName': params.companyName,
	   		  'companyUid': params.companyUid,
	   		  'businessType': params.businessType
	   	  };
	   	  
          tycheesLogger_logInfo('requestBody:' + JSON.stringify(requestBody),'registerUser');
          
       	  // Ajax Call
       	  $.ajax({
       		  type: 'post',
              contentType: 'application/json',
       	      url: tycheesCommon_getRemoteServerURL() + '/console/registerUser',
       	      data: JSON.stringify( requestBody ),
       	      error: function(status) {
       		      tycheesdb_clearLocalCachedData();
 			  	  tycheesOverlay_stopLongProgress();
 			  	  $('.register-box').show();
 			  
 			      swal({
                      title: 'Registration Failure.',
                      text: "Exception: " + status,
                      type: "error"
                  });	
       	      },
       	      dataType: 'json',
       	      success: function(data, status, xhr) {
       		        tycheesOverlay_startLongProgress('Registration Success...');

       		        tycheesLogger_logInfo("xhr="+xhr, "onload");
       		        tycheesLogger_logInfo("status="+status, "onload");
       		        tycheesLogger_logInfo("data="+data, "onload");

                  registerUserPostHandler(data);
       	      }              	
          });
       
          return false;
      } // .end of validateForm
      
      function registerUserPostHandler(responseObj)
      {
          var statusObj = responseObj.status;
          var elapsedTime = responseObj.elapsedTimeInMillis;
                          	
      	  // SUCCESS
      	  if (statusObj.code==0)
      	  { 
              tycheesOverlay_stopLongProgress();
              // Hide Form
              $('#registrationFormPanel').hide();
              // Show Buttons
              $('#registrationSuccessPanel').show(); 
              // Show Registration Box
              $('.register-box').show();
      	  }
      	  // EXCEPTION
      	  else
      	  {    	        
      	      tycheesOverlay_stopLongProgress();  
              // Show Registration Box   
      	      $('.register-box').show();
          
          	  swal({
          	      title: 'Registration Error',
                  text: statusObj.message + " (" + statusObj.code + ")",
                  type: "error"
              });
      	  }  	
      } // .end of registerUserPostHandler
      
      function gotoRegistrationForm() {
          // Show Form
          $('#registrationFormPanel').show();
          // Hide Buttons
          $('#registrationSuccessPanel').hide();
      } // .end of gotoRegistrationForm
      
      function gotoLoginForm() {
          // Redirect Begins
          window.location.href = '/console/landing/login.jsp';
      } // .end of gotoLoginForm      
    </script>
  </body>
</html>