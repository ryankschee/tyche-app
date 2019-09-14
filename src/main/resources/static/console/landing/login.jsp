<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="853081554726-5rpeps5tm3k2l4d8ca23jnl6hm73a78q.apps.googleusercontent.com">
        
        <title>
        	TYCHEES	| Console Login
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
  
    <body class="login-page">
        <div class="login-box">
            <div class="login-logo" style="font-size:40pt;">
                <a href="/index.jsp">
                    TYCHEES
                </a>
            </div><!-- /.login-logo -->
        
            <div class="login-box-body">
                <p class="login-box-msg">
                    Sign in to start your session
                </p>
                <form id="theForm" data-toggle="validator" name="#" onsubmit="return preLogin(this);" method="post">
                    <div class="form-group has-feedback">
                        <input type="email" id="inputEmail" class="form-control" placeholder="Email" data-error="Bruh, that email address is invalid" required/>
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          				<span id="inputEmail_error" style="color:#FF0000; display:none;">Invalid Email.</span>
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" id="inputPassword" class="form-control" placeholder="Password" data-minlength="6" required/>
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          				<span id="inpuPassword_error" style="color:#FF0000; display:none;">Invalid Password.</span>
                    </div>
                    
                    <!-- 
                    <div class="g-recaptcha" data-sitekey="6Ld34CoUAAAAANQDHUcaxwoPvNpSYyV5AN8sDSr3"></div>  
                    <span id="g_recaptcha_error" style="color:#FF0000; display:none;">Invalid reCaptcha</span>
                     -->
                    <div class="row" style="padding-top:20px;">
                        <div class="col-xs-8">    
                            <div class="checkbox icheck">
                                <label>
                                    <input id="inputRememberMe" type="checkbox" checked> Remember Me
                                </label>
                            </div>                        
                        </div><!-- /.col -->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                        </div><!-- /.col -->
                    </div>
                </form>
        
                <a href="#">
                    I forgot my password
                </a>                
                <br>                
                <a href="register.jsp" class="text-center">
                	Register a new membership
                </a>
            </div><!-- /.login-box-body -->
        </div><!-- /.login-box -->
        
        <div style="text-align:center; padding-top:20px;">
          <span>&copy;2017 TYCHEES</span>
        </div>
        
        <!-- jQuery 2.1.3 -->
        <script src="/resources/plugins/jquery/jQuery-2.1.3.min.js"></script>
        <!-- Bootstrap 3.3.2 JS -->
        <script src="/resources/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
        <!-- Google Platform Library -->
        <script src="https://apis.google.com/js/platform.js?onload=google_renderButton" async defer></script>
        <!-- Google reCAPTCHA -->
        <script src='https://www.google.com/recaptcha/api.js'></script>
    	<!-- Crypto-JS -->
    	<script src='https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.6.0/sha256.js'></script>
    	<script src='https://cdnjs.cloudflare.com/ajax/libs/js-sha512/0.4.0/sha512.js'></script>
        <!-- iCheck -->
        <script src="/resources/plugins/icheck/icheck.min.js" type="text/javascript"></script>
        <!-- Sweet Alert -->
        <script src="/resources/plugins/sweetalert/sweetalert.min.js" type="text/javascript"></script>
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
        <!-- JS Cookies (src:https://github.com/js-cookie/js-cookie) -->
        <script src="/resources/plugins/cookie/js.cookie.js" type="text/javascript"></script>
      
        <script>
            
            //------------------------------------------------------------------
            // CHECK onLoad: If session still active, logon to Dashboard directly
            var sessionId = tycheesCommon_getCurrentSessionId();
        	tycheesLogger_logInfo("sessionId="+sessionId, "onload");
            
            if( $.trim(sessionId)=='')
            {
                // do nothing
            }
            else
            {
            	var nextPage = '';
            	var currentPlaceId = tycheesCommon_getCurrentPlaceId();
            	tycheesLogger_logInfo("currentPlaceId="+currentPlaceId, "onload");
                	
            	if( $.trim(currentPlaceId)=='' )
            	{
            		// Goto console Store Selector
                    nextPage = location.origin + '/console/landing/store-selector.jsp';
            	}
            	else
            	{
            		var lastAccessedPage = tycheesCommon_getLastAccessedPage();
            		if( $.trim(lastAccessedPage)=='' )
                	{
                    	// Goto console dashboard page
                    	nextPage = location.origin + '/console/dashboard/das001/view/das001.jsp';
                	}
            		else
            		{
            			nextPage = location.origin + lastAccessedPage;
            		}
            	}

                // Redirect Begins
                window.location.href = nextPage;
                
                //window.open(nextPage, '_self');
            }
            // .end of CHECK onLoad:
          
            //------------------------------------------------------------------
            // On Document Ready
            $(function () {
          
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional        
                });
            });
          
            /**
             * Process Login on user input from email/password.
             */
            function preLogin(theForm) 
            {                
            	// Reset errors
            	$('#inputEmail_error').hide();
            	$('#inputPassword_error').hide();
            	$('#g_recaptcha_error').hide();
            	
                var email = $.trim(theForm.inputEmail.value);
                var password = $.trim(theForm.inputPassword.value);
                var rememberMe = theForm.inputRememberMe.checked;
         	    //var googleRecaptchaResponse = $.trim( $('#g-recaptcha-response').val() );

         	    if (email.length == 0) {
        	        $('#inputEmail_error').show();
        		    return false;
        	    }
         	    if (password.length == 0) {
         	        $('#inputPassword_error').show();
         		    return false;
         	    }
        	    /*
         	    if (googleRecaptchaResponse.length == 0) {
        	        $('#g_recaptcha_error').show();
        	        return false;
        	    }*/
        	      
                $('.login-box').hide();
                tycheesOverlay_startLongProgress('Authentication in process... ');
               
                // Prepare request body
            	var requestBody = {
            		'email': theForm.inputEmail.value
            	};
                
                var params = new Object();
                params.email = email;
                params.password = password;
                params.rememberMe = rememberMe;
                
                // Ajax Call
                $.ajax({
                	type: 'post',
                    contentType: 'application/json',
                	url: tycheesCommon_getRemoteServerURL() + '/console/prelogin',
                	data: JSON.stringify( requestBody ),
                	error: function(status) {
                		tycheesdb_clearLocalCachedData();
          			    tycheesOverlay_stopLongProgress();
          			  	$('.login-box').show();
          			  
          			    swal({
                            title: 'Authentication Failure.',
                            text: "Exception: " + status,
                            type: "error"
                        });	
                	},
                	dataType: 'json',
                	success: function(data, status, xhr) {
						params.salt = data.salt;                			
                		processLogin(params);
                	}              	
                });
                
                 return false;
             } // .end of preLogin
            
            /**
             * Process Login on user input from email/password.
             */
            function processLogin(params) 
            {
                $('.login-box').hide();
                tycheesOverlay_startLongProgress('Authentication in process... ');
               
                // Prepare request body
            	var requestBody = {
            		'email': params.email,
            		'password': tycheesSecurity_hashPassword(params.password, params.salt),
            		'rememberMe': params.rememberMe
            	};
                // Ajax Call
                $.ajax({
                	type: 'post',
                    contentType: 'application/json',
                	url: tycheesCommon_getRemoteServerURL() + '/console/login',
                	data: JSON.stringify( requestBody ),
                	error: function(status) {
                		tycheesdb_clearLocalCachedData();
          			    tycheesOverlay_stopLongProgress();
          			  	$('.login-box').show();
          			  
          			    swal({
                            title: 'Authentication Failure.',
                            text: "Exception: " + status,
                            type: "error"
                        });	
                	},
                	dataType: 'json',
                	success: function(data, status, xhr) {
                		tycheesOverlay_startLongProgress('Authentication Success...');
                        loginPostHandler(data);
                	}              	
                });
                
                 return false;
             } // .end of processLogin


            /**
             * Handler for Post Login Process.
             */ 
            function loginPostHandler(responseObj)
            {
                var statusObj = responseObj.status;
                var elapsedTime = responseObj.elapsedTimeInMillis;
                var rememberMeFlag = responseObj.rememberMe;
                var sessionObj = responseObj.currentSessionObj;
                var userObj = responseObj.currentUserObj;
                var placeList = responseObj.placeList;
                                	
            	// SUCCESS
            	if (statusObj.code==0)
            	{    	        	   
                    // Set Cookies for Session, if Remember Me is checked.
                    if (rememberMeFlag==true)
                    {
                        localStorage.setItem(LOCAL_STORAGE_SESSION_ID, sessionObj.id);
                        localStorage.setItem(LOCAL_STORAGE_CURRENT_USER_ID, userObj.id);
                        localStorage.setItem(LOCAL_STORAGE_CURRENT_USER_OBJ, JSON.stringify(userObj));
                        localStorage.setItem(LOCAL_STORAGE_SSO_PROVIDER, sessionObj.ssoProvider);
                    }
                    else
                    {
             	        // TODO: keep into sessionStorage
             	        localStorage.setItem(LOCAL_STORAGE_SESSION_ID, sessionObj.id);
                        localStorage.setItem(LOCAL_STORAGE_CURRENT_USER_ID, userObj.id);
                        localStorage.setItem(LOCAL_STORAGE_CURRENT_USER_OBJ, JSON.stringify(userObj));
                        localStorage.setItem(LOCAL_STORAGE_SSO_PROVIDER, sessionObj.ssoProvider);
                    }
                
                    // Decide redirection destination
                    var nextPage = '';
                    
                    if (placeList.length==0)
                    {
                        // No registered store. Therefore bring user to store 
                        // landing page to create own store as first step.
                        nextPage = location.origin + '/console/place/place-main.jsp';
                    }
                    else
                    if (placeList.length==1)
                    {
                    	// Set new placeId into localStorage
                        localStorage.setItem(LOCAL_STORAGE_PLACE_ID_LIST, JSON.stringify(placeList));
                    	localStorage.setItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID, placeList[0].id); 
                        nextPage = location.origin + '/console/dashboard/das001/view/das001.jsp';
                    }
                    else
                    {
                        localStorage.setItem(LOCAL_STORAGE_PLACE_ID_LIST, JSON.stringify(placeList));
                        nextPage = location.origin + '/console/landing/store-selector.jsp';
                    }
                    
                    tycheesOverlay_stopLongProgress(); 
                    
                    // Redirect Begins
                    window.location.href = nextPage;
            	}
            	// EXCEPTION
            	else
            	{    	        
            	    tycheesOverlay_stopLongProgress();     
            	    $('.login-box').show();
                
                	swal({
                	    title: 'Authentication Error',
                        text: statusObj.message + " (" + statusObj.code + ")",
                        type: "error"
                    });
            	}  	
            } // .end of loginPostHandler

            /*******************************************************************************
             * On signing user in, right after user authorized Tychees (the app) to use data
             * from Google Single-Sign-On API. 
             */ 
            function google_processLogin(googleUser) 
            {
                var rememberMe = $('#inputRememberMe').prop('checked');
                
                var profile = googleUser.getBasicProfile();
                tycheesLogger_logInfo("ID: " + profile.getId(), "google_processLogin");	// Do not send to your backend! Use an ID token instead.
                tycheesLogger_logInfo("Full Name: " + profile.getName(), "google_processLogin");
                tycheesLogger_logInfo("Given Name: " + profile.getGivenName(), "google_processLogin");
                tycheesLogger_logInfo("Family Name: " + profile.getFamilyName(), "google_processLogin");
                tycheesLogger_logInfo("Image URL: " + profile.getImageUrl(), "google_processLogin");
                tycheesLogger_logInfo("Email: " + profile.getEmail(), "google_processLogin");
                
                // The ID token you need to pass to your backend:
                var id_token = googleUser.getAuthResponse().id_token;
                tycheesLogger_logInfo("ID Token: " + id_token, "google_processLogin");
                  
                // AJAX CALL
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/loginViaGoogle');
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function() {
                    tycheesLogger_logInfo("Signed in as: " + xhr.responseText, "google_processLogin");
                    
                    var returnObj = $.parseJSON(xhr.responseText);
                    loginPostHandler(returnObj);
                };
                xhr.onerror = function(status) {
                    tycheesLogger_logError("onError.status="+status, "google_processLogin");
                };
                xhr.onprogress = function(status) {
                    tycheesLogger_logInfo("onProgress.status="+status, "google_processLogin");
                };
                
                var params = '';
                  
                //xhr.send(params);
            } // .end of google_processLogin

            /*******************************************************************************
             * On signing user out.
             */ 
            function google_onSignOut() 
            {
                var auth2 = gapi.auth2.getAuthInstance();
                auth2.signOut().then(function () {
                	tycheesLogger_logInfo("User signed out.", "google_onSignOut");
                });
            } // .emd of google_onSignOut

            /*******************************************************************************
             * On Called when platform.js loaded. 
             */ 
            function google_renderButton() {
                gapi.signin2.render('google_signIn', {
                    'scope': 'profile email',
                    'width': 320,
                    'height': 50,
                    'longtitle': true,
                    'theme': 'dark',
                    'onsuccess': google_onSuccess,
                    'onfailure': google_onFailure
                });
            } // .end of google_renderButton

            /*******************************************************************************
             * On Called when rendering process done.
             * 
             */ 
            function google_onSuccess() 
            {
            	tycheesLogger_logInfo("BEGIN.", "google_onSuccess");
            } // .end of google_onSuccess

            /*******************************************************************************
             * On Called when rendering process fails.
             */ 
            function google_onFailure() 
            {
            	tycheesLogger_logInfo("BEGIN.", "google_onFailure");
            } // .end of google_onFailure


            /*******************************************************************************
             * On signing user in, right after user authorized Tychees (the app) to use data
             * from Google Single-Sign-On API. 
             * 
             * Here we run a very simple test of the Graph API after login is successful.  
             * See statusChangeCallback() for when this call is made.
             */ 
            function facebook_processLogin() 
            {
    			tycheesLogger_logInfo("Welcome!  Fetching user information.", "facebook_processLogin");  
    			
                FB.api('/me', function(response) {
        			tycheesLogger_logInfo("Successful login for: " + response.name, "facebook_processLogin"); 
        			tycheesLogger_logInfo("Successful response object: " + JSON.stringify(response), "facebook_processLogin"); 
        			
                	var rememberMe = $('#inputRememberMe').prop('checked');
                    
                    // AJAX CALL
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', '/loginViaFacebook');
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onload = function() {
            			tycheesLogger_logInfo("Signed in as: " + xhr.responseText, "facebook_processLogin");
            			
                        var returnObj = $.parseJSON(xhr.responseText);
                        loginPostHandler(returnObj);
                    };
                    xhr.onerror = function(status) {
            			tycheesLogger_logInfo("onError.status=" + status, "facebook_processLogin");
                    };
                    xhr.onprogress = function(status) {
            			tycheesLogger_logInfo("onProgress.status=" + status, "facebook_processLogin");
                    };
                      
                    var params = '';
                      
                    xhr.send(params);
                });
            }
            
        </script>
    </body>
</html>