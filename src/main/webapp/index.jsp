<!DOCTYPE html>
<html lang="en">
<html>
    <head>
        <meta charset="UTF-8">
        
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="853081554726-5rpeps5tm3k2l4d8ca23jnl6hm73a78q.apps.googleusercontent.com">
        
        <title>
        	Tychees	| Console
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
    
        <!-- jQuery 2.1.3 -->
        <script src="/resources/plugins/jquery/jQuery-2.1.3.min.js"></script>
        <!-- Bootstrap 3.3.2 JS -->
        <script src="/resources/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
        <!-- Google Platform Library -->
        <script src="https://apis.google.com/js/platform.js?onload=google_renderButton" async defer></script>
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
        <!-- JS Cookies (src:https://github.com/js-cookie/js-cookie) -->
        <script src="/resources/plugins/cookie/js.cookie.js" type="text/javascript"></script>
      
        <script>
            
            //------------------------------------------------------------------
            // CHECK onLoad: If session still active, logon to Dashboard directly
            var sessionId = tycheesCommon_getCurrentSessionId();
        	tycheesLogger_logInfo("sessionId="+sessionId, "onload");
            
            if( $.trim(sessionId)=='')
            {
            	// Redirect Begins
                window.location.href = location.origin + '/console/landing/login.jsp'
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
        </script>
    </body>
</html>