/* VARIABLES */
var map;
var protected_layer;
var carbon_layer;
var kba_layer;

var white_markers= [];
var yellow_markers=[];

var lastMask = 10000;

var e1 = true;
var e2 = true;
var e3 = true;
var e4 = true;
var e5 = true;
var e6 = true;
var e7 = true;

var ppe_infowindow;
var ppe_layer = false;

function initialize(lat,lng) {
		var center = new google.maps.LatLng(18.39195639592592, -97.82797844140623);
 
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 1,
			center: center,
			mapTypeControl:false,
			navigationControl:false,
			mapTypeId: google.maps.MapTypeId.TERRAIN
		});

		bounds = new google.maps.LatLngBounds();
		

		carbon_layer=new SparseTileLayerOverlay();
		    carbon_layer.setUrl = function SetUrl(xy,z){
		    	var u=[];
		    	u[0]= 'http://development3.unep-wcmc.org/ArcGIS/rest/services/LifeWeb/Carbon2/MapServer/tile/'+z+'/'+xy.y+'/'+xy.x;
		    	return u;
		    };
		carbon_layer.setMap(null);
		
		protected_layer=new SparseTileLayerOverlay();
		    protected_layer.setUrl = function SetUrl(xy,z){
		    	var q=[];
		    	q[0]= 'http://184.73.201.235/blue/'+z+'/'+xy.x+'/'+xy.y;
		    	return q;
		    };
		protected_layer.setMap(map);
		
		kba_layer=new SparseTileLayerOverlay();
		    kba_layer.setUrl = function SetUrl(xy,z){
		    	var u=[];
		    	u[0]= 'http://development3.unep-wcmc.org/ArcGIS/rest/services/LifeWeb/KBA/MapServer/tile/'+z+'/'+xy.y+'/'+xy.x;
		    	return u;
		    };
		kba_layer.setMap(null);
		

		$.ajax({
		  url: 'http://lifeweb.heroku.com/projects',
		  dataType: 'jsonp',
		  data: null,
		  success: function(result) {
			
					$.each(result, function(key, value) {
						bounds.extend (new google.maps.LatLng(value.lat,value.lon));
						if (value.matched) {
							var marker = new White_Marker(new google.maps.LatLng(value.lat, value.lon),value,map);
							white_markers.push(marker);
						} else {
							var marker = new Yellow_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
							yellow_markers.push(marker);
						}
						marker.setMap(map);
					});
				
					if (lat==null) {
						map.fitBounds (bounds);
				  	map.setCenter( bounds.getCenter());
						console.log(map.getCenter());
						console.log(map.getZoom());
					} else {
						map.setCenter(new google.maps.LatLng(lat,lng));
						map.setZoom(6);
					}
					
					$('a.filter_markers_legend_button').click(function(ev){
						ev.stopPropagation();
						ev.preventDefault();
						if ($(this).parent().parent().hasClass('unclicked')){
							$(this).parent().parent().parent().children('div.clicked').fadeIn();
						} else {
							$(this).parent().parent().parent().children('div.clicked').fadeOut();				
						}
					});

				  $('div.filterButtons div a').click(function(ev){
					  ev.stopPropagation();
					  ev.preventDefault();

					  if ($(this).parent().hasClass('unclicked')){
				      $(this).parent().parent().children('div.list').show();
				      $(this).parent().removeClass('unclicked');
				      $(this).parent().addClass('clicked');                   
					  } else {
					    $(this).parent().parent().children('div.list').fadeOut();
					    $(this).parent().removeClass('clicked');
					    $(this).parent().addClass('unclicked');                                         
					  }

				  });


					$('#matches').click(function(ev){
						ev.stopPropagation();
						ev.preventDefault();
						if ($(this).children('p').hasClass('enabled')) {
							$(this).children('p').removeClass('enabled');
							$(this).children('p').addClass('disabled');		
							cleanWhiteMarkers();
						} else {
							$(this).children('p').removeClass('disabled');
							$(this).children('p').addClass('enabled');
							showWhiteClusters();
						}
					});


					$('#potential').click(function(ev){
						ev.stopPropagation();
						ev.preventDefault();
						if ($(this).children('p').hasClass('enabled')) {
							$(this).children('p').removeClass('enabled');
							$(this).children('p').addClass('disabled');		
							cleanYellowMarkers();
						} else {
							$(this).children('p').removeClass('disabled');
							$(this).children('p').addClass('enabled');	
							showYellowClusters();
						}
					});

					//Layers checkboxes
					$('div.list ul li a').click(function(ev){
						ev.stopPropagation();
						ev.preventDefault();
						if ($(this).parent().hasClass('checked')) {
							$(this).parent().removeClass('checked');
							$(this).parent().addClass('unchecked');		
							getLayerByPosition(this,false);
						} else {
							$(this).parent().removeClass('unchecked');
							$(this).parent().addClass('checked');	
							getLayerByPosition(this,true);
						}
					});


					//Ecosystem Functions Checkboxes
					$('div.clicked ul li a').click(function(ev){
						ev.stopPropagation();
						ev.preventDefault();
						if ($(this).parent().hasClass('checked')) {
							$(this).parent().removeClass('checked');
							$(this).parent().addClass('unchecked');
							getElementByPosition(this,false);
							if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
							if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
						} else {
							$(this).parent().removeClass('unchecked');
							$(this).parent().addClass('checked');
							getElementByPosition(this,true);
							if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
							if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
						}
					});


					$('div.bttn_zoomIn').click(function(ev){map.setZoom(map.getZoom()+1)});
					$('div.bttn_zoomOut').click(function(ev){map.setZoom(map.getZoom()-1)});

			 }
		});
		
		
		google.maps.event.addListener(map, 'click', function(ev){ 
				if (ppe_layer) {
					$.ajax({
					  url: 'http://www.protectedplanet.net/api2/sites?lat='+ev.latLng.b+'&lng='+ev.latLng.c,
					  dataType: 'jsonp',
					  data: null,
					  success: function(result) {
						 		console.log(result);

						 }
					});
				}
								
			}
		);

}




function showWhiteClusters() {
	for (var i=0; i<white_markers.length;i++) {
		console.log(white_markers[i].information_.ecosystem_service);
		if ((e1 && white_markers[i].information_.ecosystem_service.e1!='0') || (e2 && white_markers[i].information_.ecosystem_service.e2!='0') || (e3 && white_markers[i].information_.ecosystem_service.e3!='0') || (e4 && white_markers[i].information_.ecosystem_service.e4!='0') || (e5 && white_markers[i].information_.ecosystem_service.e5!='0') || (e6 && white_markers[i].information_.ecosystem_service.e6!='0') || (e7 && white_markers[i].information_.ecosystem_service.e7!='0') ) {
			white_markers[i].setMap(map);
		} else {
			white_markers[i].setMap(null);
		}
	}
	
}


function showYellowClusters() {
	for (var i=0; i<yellow_markers.length;i++) {
		if ((e1 && yellow_markers[i].information_.ecosystem_service.e1!='0') || (e2 && yellow_markers[i].information_.ecosystem_service.e2!='0') || (e3 && yellow_markers[i].information_.ecosystem_service.e3!='0') || (e4 && yellow_markers[i].information_.ecosystem_service.e4!='0') || (e5 && yellow_markers[i].information_.ecosystem_service.e5!='0') || (e6 && yellow_markers[i].information_.ecosystem_service.e6!='0') || (e7 && yellow_markers[i].information_.ecosystem_service.e7!='0')) {
			yellow_markers[i].setMap(map);
		}else {
			yellow_markers[i].setMap(null);
		}
	}
}


function cleanYellowMarkers() {
	for (var i=0; i<yellow_markers.length;i++) {
			yellow_markers[i].setMap(null);
	}
}

function cleanWhiteMarkers() {
	for (var i=0; i<white_markers.length;i++) {
			white_markers[i].setMap(null);
	}
}


function getElementByPosition(element,checked) {
	switch ($(element).attr('id')) {
	    case 'climate' : e1 = checked;
	      break;
	    case 'climate2' : e2 = checked;
	      break;
	    case 'freshwater' : e3 = checked;
	      break;
	    case 'food' : e4 = checked;
	      break;
			case 'human_health' : e5= checked;
		    break;
			case 'Cultural_and_Spiritual_access' : e6 = checked;
			  break;
			case 'income_generation' : e7 = checked;
				break;
	  }
}

function getLayerByPosition(element,visible) {
	switch ($(element).attr('id')) {
	    case 'protected_layer' : if (visible) {protected_layer.setStyle(0,{alpha:.5});} else {protected_layer.setStyle(0,{alpha:.0});};
	      break;
	    case 'carbon_layer': if (visible) {carbon_layer.setMap(map);carbon_layer.setStyle(0,{alpha:.5});} else {carbon_layer.setStyle(0,{alpha:.0});};
	      break;
	    case 'kba_layer': if (visible) {kba_layer.setMap(map);kba_layer.setStyle(0,{alpha:.5});} else {kba_layer.setStyle(0,{alpha:.0});};
	      break;
	  }
}



