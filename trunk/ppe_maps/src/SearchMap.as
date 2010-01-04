package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import com.vizzuality.*;
	import com.vizzuality.tileoverlays.MarkersOverlay;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	[SWF(backgroundColor=0xEEEEEE, widthPercent=100, heightPercent=100)]
	public class SearchMap extends Sprite
	{
		
		[Embed(source="assets/btnsMap.swf", symbol="zoomInButton")]
        private var ZoomInButton:Class;
        
        [Embed(source="assets/btnsMap.swf", symbol="zoomInButton_over")]
        private var ZoomInButton_over:Class;
 
        [Embed(source="assets/btnsMap.swf", symbol="zoomOutButton")]
        private var ZoomOutButton:Class;
        
        [Embed(source="assets/btnsMap.swf", symbol="zoomOutButton_over")]
        private var ZoomOutButton_over:Class;		
		
		
		private var map:Map;
		private var mapKey:String = "nokey";
		private var iw:Dictionary=new Dictionary();
		private var domain: String;
		
		private var mo:MarkersOverlay;
		private var markersArray: Array;
							
						
		public function SearchMap()
		{ 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			//this.height = 364;	

			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","174.129.214.28:8080","ppe.tinypla.net"];
			for each(var dom:String in externalDomains) {
			    Security.allowDomain(dom);
			    Security.loadPolicyFile("http://"+dom+"/crossdomain.xml");
			    var request:URLRequest = new URLRequest("http://"+dom+"/crossdomain.xml");
			    var loader:URLLoader = new URLLoader();
			    loader.load(request);				
			}				
					
			initMap();
			
		}

		private var timerResizing:Timer;
		private var isResizing:Boolean=false;
 		private function stageResizeHandler(ev:Event):void {
			if(map!=null && !isResizing) {
				map.setSize(new Point(stage.stageWidth, stage.stageHeight));
				//isResizing=true;
				//timerResizing.addEventListener(TimerEvent.TIMER,function(e:Event):void {
					//isResizing=false;	
					//timerResizing.stop();			
				//});
				//timerResizing.start();
			}
		}	
		
		private function initMap():void {
			map=new Map();
			
			var mk:String=root.loaderInfo.parameters.key;
			if(mk!=null) {
				map.key=root.loaderInfo.parameters.key;
			} else {
				map.key=mapKey;
			}			
			
			//timerResizing = new Timer(100);
			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(stage.stageWidth, stage.stageHeight));
			addChild(map); 				
			
			
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			mo= new MarkersOverlay();
			map.addOverlay(mo);
			markersArray = new Array();
		 	
		 				//zoom buttons
			var zoomIn:Sprite = new ZoomInButton();			
			var zoomIn_over: Sprite = new ZoomInButton_over();
            addChild(zoomIn);
            zoomIn.x = 10;
            zoomIn.y = 10;
            zoomIn_over.x = 0;
            zoomIn_over.y = 0;
            zoomIn.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				zoomIn.addChild(zoomIn_over);
				zoomIn_over.mouseChildren = false;
				zoomIn_over.buttonMode = true;

			}); 
            zoomIn.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				zoomIn.removeChild(zoomIn_over);
				zoomIn_over.mouseChildren = false;
				zoomIn_over.buttonMode = true; 
			}); 
			zoomIn.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()+1);
			}); 
		
			
			var zoomOut:Sprite = new ZoomOutButton();			
			var zoomOut_over: Sprite = new ZoomOutButton_over();
            addChild(zoomOut);
            zoomOut.x = 10;
            zoomOut.y = 45;
            zoomOut_over.x = 0;
            zoomOut_over.y = 0;
            zoomOut.addEventListener(MouseEvent.ROLL_OVER,function (ev:MouseEvent):void {
				zoomOut.addChild(zoomOut_over);
				zoomOut_over.mouseChildren = false;
				zoomOut_over.buttonMode = true;

			}); 
            zoomOut.addEventListener(MouseEvent.ROLL_OUT,function (ev:MouseEvent):void {
				zoomOut.removeChild(zoomOut_over);
				zoomOut_over.mouseChildren = false;
				zoomOut_over.buttonMode = true; 
			});  
			zoomOut.addEventListener(MouseEvent.CLICK, function (ev:MouseEvent):void {
				map.setZoom(map.getZoom()-1);
			});
			//end zoom buttons
			
			var polOpt:PolygonOptions=new PolygonOptions({
				  strokeStyle: {
				    thickness: 2,
				    color: 0xFF7600,
				    alpha: 1
				  },
				  fillStyle: {
				    color: 0xFF7600,
				    alpha: 0.4
				  }	
			});			
			
			//parse the Flashvar
			var varsdata:String = this.root.loaderInfo.parameters.pas;
			var paJson:Object = JSON.decode(varsdata);
			
			var areas:Array =[];
			var bounds:LatLngBounds = new LatLngBounds();
			for each(var areaJson:Object in paJson as Array) {
				var areaCoords:LatLng = new LatLng(areaJson.y,areaJson.x);
				bounds.extend(areaCoords);
				var markerOpt:MarkerOptions=new MarkerOptions({
				
				});
				
                var markerData: Object = new Object();	
                markerData.coordenates = areaCoords;
                markerData.area = areaJson.name;
                //TODO: CONNECT THIS WITH THE JSON SERVICE
                markerData.sites = areaJson.pois;
                markerData.isNeeded = true;	
                markerData.imgURL = areaJson.image;
                markerData.paId = areaJson.id;
                
                markersArray.push(markerData);              
                
			}
			if (markersArray.length<5 && markersArray.length>0) {
				map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds)-5);
			} else {
				map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds));
			}
			TweenLite.delayedCall(0.6,delayedMarkersAddition,[markersArray]);	
		}
		
		private function delayedMarkersAddition(markers:Array):void {
			mo.addMarkerCluster(markers);
		}		     			
	}
}
