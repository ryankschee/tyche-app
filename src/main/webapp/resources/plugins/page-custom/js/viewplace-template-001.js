// If you're adding a number of markers, you may want to drop them on the map
// consecutively rather than all at once. This example shows how to use
// window.setTimeout() to space your markers' animation.

var zones = [
	{name: "Default", zoom: 15, lat: 3.126769, lng: 101.678635},
	{name: "Bangsar", zoom: 17, lat: 3.136003, lng: 101.672620},
	{name: "Mid Valley", zoom: 17, lat: 3.118484, lng: 101.676927},
	{name: "KL Sentral", zoom: 17, lat: 3.134360, lng: 101.686465},
];
		
var neighborhoods = [
    {lat: 3.131347, lng: 101.671687},
    {lat: 3.12783, lng: 101.678083},
	{lat: 3.116816, lng: 101.678259},
	{lat: 3.116816, lng: 101.678259},
	{lat: 3.129399, lng: 101.674227},
	{lat: 3.132043, lng: 101.685313}
];

// Location Map Variables
var markers = [];
var map;
var image = '../../resources/images/gpx-icon-start.png';

// Offer Grid Variables
var gridMasonry;
var allNodes = [];
var allNodesWidth = [];
var allNodesHeight = [];

function initMap()
{
	initMap("Default");
}

function initMap(zoneName) 
{
	if (zoneName==undefined)
		zoneName = "Default";
	
	console.log("initMap [" + zoneName + "]");
  
	var selectedZone;
	$.each(zones, function( index, zone ) {
		if (zone.name == zoneName) {
			selectedZone = zone;
		}
	});
  
	var directionsDisplay = new google.maps.DirectionsRenderer;
	var directionsService = new google.maps.DirectionsService;
  
	map = new google.maps.Map(document.getElementById('map'), {
		zoom: selectedZone.zoom,
		center: {lat: selectedZone.lat, lng: selectedZone.lng}
	});
	directionsDisplay.setMap(map);
  
	calculateAndDisplayRoute(directionsService, directionsDisplay);
	document.getElementById('mode').addEventListener('change', function() {
		calculateAndDisplayRoute(directionsService, directionsDisplay);
	});
  
	google.maps.event.addListenerOnce(map, 'tilesloaded', function(){
		// do something only the first time the map is loaded
		console.log("tilesloaded");		
		drop();
	});  
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) 
{
	var selectedMode = document.getElementById('mode').value;
	directionsService.route({
		origin: {lat: 3.131347, lng: 101.671687},  // Haight.
		destination: {lat: 3.132043, lng: 101.685313},  // Ocean Beach.
		// Note that Javascript allows us to access the constant
		// using square brackets and a string value as its
		// "property."
		travelMode: google.maps.TravelMode[selectedMode]
	}, function(response, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(response);
		} else {
			window.alert('Directions request failed due to ' + status);
		}
	});
}
		
function drop() 
{
	console.log("drop");
	clearMarkers();
	for (var i = 0; i < neighborhoods.length; i++) {
		addMarkerWithTimeout(neighborhoods[i], i * 200);
	}
}

function addMarkerWithTimeout(position, timeout) 
{
	window.setTimeout(function() {
	
	markers.push(new google.maps.Marker({
		position: position,
		map: map,
		animation: google.maps.Animation.DROP,
		icon: image
	}));
	var counter = $("#partner-counter").html();
	if (counter=='-')
		counter=0;
	counter++;
	$("#partner-counter").html(counter);
		console.log(counter);
	}, timeout);
}

function clearMarkers() 
{
	$("#partner-counter").html('-');
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

function gotoArea(zoneName) 
{
	console.log("Goto zone [" + zoneName + "]");	
	initMap(zoneName);
}
		
function filterGrid(textList) {
	console.log("filterGrid textList="+textList);
	console.log("filterGrid allNodes="+allNodes);
	
	
	
	if (textList[0]=='All') {
		$("#offerGrid").empty();
		$.each(allNodes, function( index, element ) {								
			$("#offerGrid").append(element);
		});
		gridMasonry.masonry('layout');
	}
	else {
		$("#offerGrid").empty();
		$.each(allNodes, function( index, element ) {				
			var titleNode = element.find( ".product-tags" ).html();		
			$.each(textList, function(index, text) {						
				if (titleNode.indexOf(text) != -1) {
					$("#offerGrid").append(element);
					return false;
				}
			});
		});
		gridMasonry.masonry('layout');		
	}					
}			
		
function loadOffersIntoGrid() 
{
	console.log("loadOffersIntoGrid");
	var imageWidth = [650,1349,1348,940,1402,1348,900];
	var imageHeight = [350,899,899,407,788,899,600];
	var imageList = ["http://directme2208.appspot.com/resources/images/landing/portfolio/3.jpg",
					 "http://mastercleaningnow.com/wp-content/uploads/2014/03/Office-Refurb-2.jpg",
					 "http://cdn.playbuzz.com/cdn/f227e692-4237-4aeb-988f-6a2d3292171e/c011c393-db8a-4712-94ea-4483e8724ef6.jpg",
					 "http://www.theofficegroup.co.uk/wp-content/uploads/2011/07/The-Office-Greville-Office-Space-2-smaller-940x407.jpg",
					 "http://d.fastcompany.net/multisite_files/fastcompany/poster/2014/03/3027542-poster-p-1-inside-fiftythrees-jaw-dropping-new-office-space.jpg",
					 "https://res.cloudinary.com/wework/image/upload/s--JkyfQvdY--/c_scale,fl_progressive,q_jpegmini:1,w_2048/v1420576473/wework.com/locations/new-york/charging-bull/20140217_Charging_Bull_Additional-58.jpg",
					 "http://specials-images.forbesimg.com/imageserve/c6b990ad49fd50d7543363151b075bba/0x600.jpg?fit=scale&background=000000"];
	
	$("#offerGrid").empty();
	for (i=0 ; i<100 ; i++) {				
		var line1 = '<div class="grid-item" id="offer-' + i + '">';
		var line2 = '<div class="ibox">';
		var line3 = '<div class="ibox-content product-box">';
		var line4 = '<div class="product-imitation" style="padding: 0;">';
		var line5 = '<img class="offer-image" src="' + imageList[i%7] + '" style="width:100%;">';
		var line6 = '</div>';
		var line7 = '<div class="product-desc" style="background-color:#FFFFFF;">';
		var line8 = '<span class="product-price">';
		var line9 = '$10';
		var line10 = '</span>';
		var line11 = '<small class="text-muted product-tags">Category</small>';
		var line12 = '<a href="#" class="product-name"> Product ' + i + '</a>';
		var line13 = '<div class="small m-t-xs">';
		var line14 = 'Many desktop publishing packages and web page editors now.';
		var line15 = '</div>';
		var line16 = '<div class="m-t text-righ">';
		var line17 = '<a href="#" class="btn btn-xs btn-outline btn-primary">Info <i class="fa fa-long-arrow-right"></i> </a>';
		var line18 = '</div>';
		var line19 = '</div>';
		var line20 = '</div>';
		var line21 = '</div>';
		var line22 = '</div>';
		
		var allLines = line1+line2+line3+line4+line5+line6+line7+line8+line9+line10+line11+line12+line13+line14+line15+line16+line17+line18+line19+line20+line21+line22;
		
		$("#offerGrid").append(allLines);
		
		allNodesWidth[i] = imageWidth[i%imageList.length];
		allNodesHeight[i] = imageHeight[i%imageList.length];
	}	

	// Set height for each grid-item element
	$('.grid-item').each(function(index, element){
								
		var imageDisplayHeight = getImageHeight(allNodesWidth[index], allNodesHeight[index]).toFixed(0);
		var imageElements = $(element).find('.offer-image');
		var descElements = $(element).find('.product-desc');				
		var elementHeight = String(parseInt(imageDisplayHeight) + parseInt($(descElements[0]).height()) + 40) + "px";
		
		element.style.height = elementHeight;				
	});
}
		
function backupGridNodes() {		
	allNodes = [];			
	$( ".grid-item" ).each(function( index ) {
		allNodes.push($( this ));
	});
}

function getImageHeight(originalWidth, originalHeight) {
	var displayWidth = 398;
	var ratio = 398 / originalWidth;
	
	return originalHeight * ratio;
}
		

function isTagInsideList(tag, list) {
	var flag = false;
	$.each(
		list,
		function(index, item)
		{
			var item1 = String(tag);
			var item2 = String(item);
			if ((item1===item2)==true)
			{
				flag = true;
			}				
		});
	
	return flag;
}