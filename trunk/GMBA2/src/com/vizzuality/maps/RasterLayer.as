package com.vizzuality.maps
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	import com.vizzuality.events.MyEventDispatcher;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;

	public class RasterLayer extends TileLayerBase
	{
        public var rasterUrl:String;	
        public static const ENV_TILES_LOADED:String="envTilesLoaded";
        public static const ENV_TILES_LOADED_PENDING:String="envTilesLoadedPending";
        
        public var pendingTiles:Number=0;
 
		public function RasterLayer(_rasterUrl:String=null) {
			
			rasterUrl=_rasterUrl;	
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
            super(copyrightCollection, 0, 6,0.8); 
		}
		
		public override function loadTile(tile:Point, zoom:Number):DisplayObject {
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {
                var tileUrl:String = rasterUrl;
                tileUrl = tileUrl.replace("|X|",tile.x);    
                tileUrl = tileUrl.replace("|Y|",tile.y);    
                tileUrl = tileUrl.replace("|Z|",zoom); 
                
                
				var tileLoader:CustomTile = new CustomTile(this);
				tileLoader.loader.load(new URLRequest(tileUrl));          
				pendingTiles++;       
				MyEventDispatcher.dispatchEvent(new Event(RasterLayer.ENV_TILES_LOADED_PENDING));
                return tileLoader;    
            }
            
            return null;			
		}
		
		public function customTileLoaded():void {
			pendingTiles--;
			
			if(pendingTiles==0) {
				MyEventDispatcher.dispatchEvent(new Event(RasterLayer.ENV_TILES_LOADED));
			}
			
		}

		
	}
}