var worksGridMasonry;
var worksNodes = [];
var worksNodesWidth = [];
var worksNodesHeight = [];
var markers = [];
var map;
var image = 'resources/images/landing/map/map-marker.png';
var search_text;
var search_mode;
var current_lat;
var current_lng;

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

function loadWorksIntoGrid() 
{	
	console.log("loadWorksIntoGrid() starts.");
	
	searchText = getParameterByName("text");
	searchMode = getParameterByName("mode");
	current_lat = getParameterByName("lat");
	current_lng = getParameterByName("lng");
	
	console.log("searchText="+searchText);
	console.log("searchMode="+searchMode);
	console.log("current_lat="+current_lat);
	console.log("current_lng="+current_lng);
	
	$("#searchtext").val(searchText);
	
	if (searchMode == 'place')
	{
		console.log("add 'btn-lg' to place.");
		$("#searchMode-places").addClass("btn-lg");
	}
	else
	{
		console.log("add 'btn-lg' to item.");
		$("#searchMode-items").addClass("btn-lg");
	}
	
	var imageWidth = [650,1349,1348,940,1402,1348,900];
	var imageHeight = [350,899,899,407,788,899,600];
	var imageList = ["http://directme2208.appspot.com/resources/images/landing/portfolio/3.jpg",
					 "http://mastercleaningnow.com/wp-content/uploads/2014/03/Office-Refurb-2.jpg",
					 "http://cdn.playbuzz.com/cdn/f227e692-4237-4aeb-988f-6a2d3292171e/c011c393-db8a-4712-94ea-4483e8724ef6.jpg",
					 "http://www.theofficegroup.co.uk/wp-content/uploads/2011/07/The-Office-Greville-Office-Space-2-smaller-940x407.jpg",
					 "http://d.fastcompany.net/multisite_files/fastcompany/poster/2014/03/3027542-poster-p-1-inside-fiftythrees-jaw-dropping-new-office-space.jpg",
					 "https://res.cloudinary.com/wework/image/upload/s--JkyfQvdY--/c_scale,fl_progressive,q_jpegmini:1,w_2048/v1420576473/wework.com/locations/new-york/charging-bull/20140217_Charging_Bull_Additional-58.jpg",
					 "http://specials-images.forbesimg.com/imageserve/c6b990ad49fd50d7543363151b075bba/0x600.jpg?fit=scale&background=000000"];
	
	$("#worksGrid").empty();
	for (i=0 ; i<7 ; i++) {				
		var line1 = '<div class="grid-item work-item" id="work-' + i + '">';
		var line2 = '<div class="ibox">';
		var line3 = '<div class="ibox-content product-box">';
		var line4 = '<div class="product-imitation" style="padding: 0;">';
		var line5 = '<img class="work-image" src="' + imageList[i%7] + '" style="width:100%;">';
		var line6 = '</div>';
		var line7 = '<div class="product-desc" style="background-color:#FFFFFF;">';
		var line8 = '<span class="product-price">';
		var line9 = '$10';
		var line10 = '</span>';;
		var line11 = '<a href="#" class="product-name"> Product ' + i + '</a>';
		var line12 = '<div class="small m-t-xs">';
		var line13 = 'Many desktop publishing packages and web page editors now.';
		var line14 = '</div>';
		var line15 = '</div>';
		var line16 = '<div class="contact-box-footer product-footer" style="background-color:#FFFFFF;">';
		var line17 = '<div class="m-t-xs btn-group">';
		var line18 = '<a class="btn btn-xs btn-white"><i class="fa fa-phone"></i> Favorite </a>';
		var line19 = '</div>';
		var line20 = '</div>';
		var line21 = '</div>';
		var line22 = '</div>';
		var line23 = '</div>';
		
		var allLines = line1+line2+line3+line4+line5+line6+line7+line8+line9+line10+
					   line11+line12+line13+line14+line15+line16+line17+line18+line19+line20+
					   line21+line22+line23;
		
		$("#worksGrid").append(allLines);
		
		worksNodesWidth[i] = imageWidth[i%imageList.length];
		worksNodesHeight[i] = imageHeight[i%imageList.length];
	}	

	// Set height for each grid-item element
	$('.work-item').each(function(index, element){
								
		var imageDisplayHeight = getImageHeight(worksNodesWidth[index], worksNodesHeight[index]).toFixed(0);
		var imageElements = $(element).find('.work-image');
		var descElements = $(element).find('.product-desc');				
		var elementHeight = String(parseInt(imageDisplayHeight) + parseInt($(descElements[0]).height()) + 80) + "px";
		
		element.style.height = elementHeight;				
	});
}
		
