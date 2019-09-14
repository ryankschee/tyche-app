<!DOCTYPE html>
<html>

<head>
    <script>
    	(function(){(function(){function e(a){this.t={};this.tick=function(a,c,b){this.t[a]=[void 0!=b?b:(new Date).getTime(),c];if(void 0==b)try{window.console.timeStamp("CSI/"+a)}catch(h){}};this.tick("start",null,a)}var a;window.performance&&(a=window.performance.timing);var f=a?new e(a.responseStart):new e;window.mobilespeed_jstiming={Timer:e,load:f};if(a){var c=a.navigationStart,d=a.responseStart;0<c&&d>=c&&(window.mobilespeed_jstiming.srt=d-c)}if(a){var b=window.mobilespeed_jstiming.load;0<c&&d>=c&&(b.tick("_wtsrt",
    	void 0,c),b.tick("wtsrt_","_wtsrt",d),b.tick("tbsd_","wtsrt_"))}try{a=null,window.chrome&&window.chrome.csi&&(a=Math.floor(window.chrome.csi().pageT),b&&0<c&&(b.tick("_tbnd",void 0,window.chrome.csi().startE),b.tick("tbnd_","_tbnd",c))),null==a&&window.gtbExternal&&(a=window.gtbExternal.pageT()),null==a&&window.external&&(a=window.external.pageT,b&&0<c&&(b.tick("_tbnd",void 0,window.external.startE),b.tick("tbnd_","_tbnd",c))),a&&(window.mobilespeed_jstiming.pt=a)}catch(g){}})();})();
    </script>
	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>TYCHEES | Select Store</title>

    <%@include file="/console/segment/include_stylesheets.jspf" %>

</head>

<body style="background-color:#323238;">

    <div id="store_selection" class="middle-box text-center loginscreen animated fadeInDown" style="width:540px;display:none;">
        <div>
            <div>
                <h1 class="logo-name">TYC</h1>
            </div>
            <div style="color:#999999;">
            	<div class="m-b-md">
	            	<img id="profileImage" alt="image" class="img-circle circle-border" src="http://www.wolves.co.uk/images/common/bg_player_profile_default_big.png" style="height:100px;width:auto;">
	            </div>
            	<h3>Hey <span id="username"></span>, welcome to TYCHEES</h3>
            	<p>Perfectly designed and precisely prepared business apps for everyone.</p>
            	<p>Select Store. To see it in action.</p>
            </div>            

            <form class="m-t" role="form">
                <div class="form-group">
                    <select id="placeList" class="form-control m-b" style="height:48px;font-size:24px;" onchange="selectStore();">
                    </select>
                </div>
                <button class="btn btn-primary block full-width" onclick="gotoStore(event);">
                    <i class="fa fa-sign-in" aria-hidden="true"></i> Go to Store
                </button>
            </form>
            
            <div style="font-size:9pt;color:#ffffff;margin-top:30px;">Copyright TYCHEES &copy; 2017</div> 
        </div>
    </div>

	<!-- Common JS Scripts -->
    <%@include file="/console/segment/include_scripts.jspf" %>
    <!-- DirectMe General Util -->
    <script src="/console/_common/lib/scripts/tychees.common.js"></script>

    <script>
	    (function(){var d="webkitvisibilitychange",g="_ns";if(window.mobilespeed_jstiming){window.mobilespeed_jstiming.a={};window.mobilespeed_jstiming.b=1;var n=function(b,a,e){var c=b.t[a],f=b.t.start;if(c&&(f||e))return c=b.t[a][0],void 0!=e?f=e:f=f[0],Math.round(c-f)},p=function(b,a,e){var c="";window.mobilespeed_jstiming.srt&&(c+="&srt="+window.mobilespeed_jstiming.srt,delete window.mobilespeed_jstiming.srt);window.mobilespeed_jstiming.pt&&(c+="&tbsrt="+window.mobilespeed_jstiming.pt,delete window.mobilespeed_jstiming.pt);try{window.external&&window.external.tran?
	    c+="&tran="+window.external.tran:window.gtbExternal&&window.gtbExternal.tran?c+="&tran="+window.gtbExternal.tran():window.chrome&&window.chrome.csi&&(c+="&tran="+window.chrome.csi().tran)}catch(v){}var f=window.chrome;if(f&&(f=f.loadTimes)){f().wasFetchedViaSpdy&&(c+="&p=s");if(f().wasNpnNegotiated){var c=c+"&npn=1",h=f().npnNegotiatedProtocol;h&&(c+="&npnv="+(encodeURIComponent||escape)(h))}f().wasAlternateProtocolAvailable&&(c+="&apa=1")}var l=b.t,t=l.start,f=[],h=[],k;for(k in l)if("start"!=k&&
	    0!=k.indexOf("_")){var m=l[k][1];m?l[m]&&h.push(k+"."+n(b,k,l[m][0])):t&&f.push(k+"."+n(b,k))}delete l.start;if(a)for(var q in a)c+="&"+q+"="+a[q];(a=e)||(a="https:"==document.location.protocol?"https://csi.gstatic.com/csi":"http://csi.gstatic.com/csi");return[a,"?v=3","&s="+(window.mobilespeed_jstiming.sn||"mobilespeed")+"&action=",b.name,h.length?"&it="+h.join(","):"",c,"&rt=",f.join(",")].join("")},r=function(b,a,e){b=p(b,a,e);if(!b)return"";a=new Image;var c=window.mobilespeed_jstiming.b++;window.mobilespeed_jstiming.a[c]=
	    a;a.onload=a.onerror=function(){window.mobilespeed_jstiming&&delete window.mobilespeed_jstiming.a[c]};a.src=b;a=null;return b};window.mobilespeed_jstiming.report=function(b,a,e){if("prerender"==document.webkitVisibilityState){var c=!1,f=function(){if(!c){a?a.prerender="1":a={prerender:"1"};var h;"prerender"==document.webkitVisibilityState?h=!1:(r(b,a,e),h=!0);h&&(c=!0,document.removeEventListener(d,f,!1))}};document.addEventListener(d,f,!1);return""}return r(b,a,e)};var u=function(b,a,e,c){return 0<
	    e?(c?b.tick(a,c,e):b.tick(a,"",e),!0):!1};window.mobilespeed_jstiming.getNavTiming=function(b){if(window.performance&&window.performance.timing){var a=window.performance.timing;u(b,"_dns",a.domainLookupStart)&&u(b,"dns_",a.domainLookupEnd,"_dns");u(b,"_con",a.connectStart)&&u(b,"con_",a.connectEnd,"_con");u(b,"_req",a.requestStart)&&u(b,"req_",a.responseStart,"_req");u(b,"_rcv",a.responseStart)&&u(b,"rcv_",a.responseEnd,"_rcv");if(u(b,g,a.navigationStart)){u(b,"ntsrt_",a.responseStart,g);u(b,"nsfs_",
	    a.fetchStart,g);u(b,"nsrs_",a.redirectStart,g);u(b,"nsre_",a.redirectEnd,g);u(b,"nsds_",a.domainLookupStart,g);u(b,"nscs_",a.connectStart,g);u(b,"nsrqs_",a.requestStart,g);var e=!1;try{e=window.external&&window.external.startE}catch(c){}!e&&window.chrome&&window.chrome.csi&&(e=Math.floor(window.chrome.csi().startE));e&&(u(b,"_se",e),u(b,"sens_",a.navigationStart,"_se"));u(b,"ntplt0_",a.loadEventStart,g);u(b,"ntplt1_",a.loadEventEnd,g);window.chrome&&window.chrome.loadTimes&&(a=window.chrome.loadTimes().firstPaintTime)&&
	    u(b,"nsfp_",1E3*a,g)}}}};})();
	    </script>
	    <script>
	    (function(){var a=window.mobilespeed_jstiming,b=a.load;window.top==window&&window.addEventListener("load",function(){b.name="load";b.tick("ol");a.getNavTiming(b);setTimeout(function(){a.report(b,{e:"preload_critical_resources"})},300)},!1);})();
    </script>
	
	<script>
		// On Document Ready
	    $(function () {
	  
	        // Set place list
	    	var placeList = JSON.parse( localStorage.getItem(LOCAL_STORAGE_PLACE_ID_LIST) );
	    	$.each(placeList, function(i, placeObj){
	    	    
	    	    var htmlLines = '';
	    	    htmlLines += '<option value="' + placeObj.id + '">';
	    	    htmlLines += placeObj.name;
	    	    htmlLines += '</option>';
	    	    
	    	    $('#placeList').append(htmlLines);
	    	});
	    	
	    	var userObj = JSON.parse( localStorage.getItem(LOCAL_STORAGE_CURRENT_USER_OBJ) );
	    	var userName = $.trim(userObj.firstName) + ' ' + $.trim(userObj.lastName);
	    	var userImageUrl = $.trim(userObj.profileImageUrl);
	    	
	    	// Set name
	    	$('#username').html(userName);
	    	// Set Profile
	    	if (userImageUrl != '')
	    		$('#profileImage').attr("src", userImageUrl);
	    	// Show Page
	    	showPage();
	    });
	    
	    function selectStore()
	    {
	        var selectedPlaceId = $('#placeList').val();
	    } // .end of selectStore
	    
	    function gotoStore(event)
	    {   
	    	// Prevent default button handler
	    	event.preventDefault();

	    	// Set new placeId into cookies
	    	localStorage.setItem(LOCAL_STORAGE_LAST_ACCESSED_PLACE_ID, $('#placeList').val());
	    	
	    	var lastAccessedPageUrl = localStorage.getItem(LOCAL_STORAGE_LAST_ACCESSED_PAGE);
	    	// Default page is Dashboard
        	var nextPage = location.origin + '/console/dashboard/das001/view/das001.jsp';
        	if (lastAccessedPageUrl != null)
        	    nextPage = location.origin + lastAccessedPageUrl;
        	    
        	window.location.href = nextPage;
	    } // .end of gotoStore
	    
	    function showPage()
	    {
	    	$('#store_title').show();
	        $('#store_selection').show();
	    } // .end of showPage
	    	    
	    function hidePage()
	    {
	        $('#store_title').hide();
	        $('#store_selection').hide();
	    } // .end of hidePage
	</script>

</body>

</html>
