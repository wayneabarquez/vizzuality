package {
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Alpha;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.overlays.TileLayerOverlay;
	import com.google.maps.styles.FillStyle;
	import com.greensock.plugins.*;
	import com.vizzuality.maps.Multipolygon;
	import com.vizzuality.tileoverlays.GbifTileLayer;
	import com.vizzuality.tileoverlays.GeoserverTileLayer;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;

	[SWF(backgroundColor=0xeeeeee, widthPercent=100, heightPercent=100)]
	public class BiodiversityMap extends Sprite
	{
		private var map:Map;	
		private var dataLoaded:Boolean=false;
		private var dataAnalyzed:Boolean=false;
		private var data:Object;
		private var pol:Polygon;
		private var mapKey:String = "nokey";
		private var gbifTileLayer:GbifTileLayer;	
		
										
						
		public function BiodiversityMap()
		{ 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			stage.addEventListener(Event.RESIZE, stageResizeHandler);	

			var externalDomains:Array=["ppe.org.tiles.s3.amazonaws.com","174.129.214.28:8080"];
			for each(var dom:String in externalDomains) {
			    Security.allowDomain(dom);
			    Security.loadPolicyFile("http://"+dom+"/crossdomain.xml");
			    var request:URLRequest = new URLRequest("http://"+dom+"/crossdomain.xml");
			    var loader:URLLoader = new URLLoader();
			    loader.load(request);				
			}				
				
			initMap();			

			var dsLoader:URLLoader = new URLLoader();
			dsLoader.addEventListener(Event.COMPLETE,onDataLoaded);
			var paId:Number=root.loaderInfo.parameters.id;
			if(isNaN(paId)) {
				paId=2027;
			}
			dsLoader.load(new URLRequest("http://localhost:3000/sites/"+paId+"/json"));
			
		}

		
		private function onDataLoaded(event:Event):void {
			dataLoaded=true;
			data = JSON.decode(event.currentTarget.data as String);
			
			if(map.isLoaded() && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();				
			}
				
		}
		
		
		private function loadData():void {
			
			
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
			
			var mp:Multipolygon= new Multipolygon();
			mp.fromGeojsonMultiPolygon(data.coordinates,polOpt);						
			mp.addToMap(map);
			
			map.setCenter(mp.getLatLngBounds().getCenter(),map.getBoundsZoomLevel(mp.getLatLngBounds())-1);		
		}
		

		
	
		
		private function initMap():void {
			map=new Map();
			
			var mk:String=root.loaderInfo.parameters.key;
			if(mk!=null) {
				map.key=root.loaderInfo.parameters.key;
			} else {
				map.key=mapKey;
			}			
				
			map.y=0;
			map.x=0;
			map.setSize(new Point(stage.stageWidth, stage.stageHeight));
			
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			
			addChild(map); 				
			
			
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xE9E9E9,alpha: Alpha.OPAQUE});
				mo.mapType=MapType.PHYSICAL_MAP_TYPE;	
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void {
			
			if(dataLoaded && !dataAnalyzed) {
				dataAnalyzed=true;
				loadData();	
			}
			
			var tl:GeoserverTileLayer = new GeoserverTileLayer();
			var tlo:TileLayerOverlay = new TileLayerOverlay(tl);
			//tlo.foreground.alpha=1;
			map.addOverlay(tlo);		
			
			gbifTileLayer = new GbifTileLayer(1);
			var gtlo:TileLayerOverlay = new TileLayerOverlay(gbifTileLayer);
			map.addOverlay(gtlo);

		}	
		
		private function stageResizeHandler(ev:Event):void {
			if(map!=null)
				map.setSize(new Point(stage.stageWidth, stage.stageHeight));
		}		
		
	}
}
