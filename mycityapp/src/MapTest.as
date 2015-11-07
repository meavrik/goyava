package 
{
	import cl.pcornejo.gmaps.controls.ControlPosition;
	import cl.pcornejo.gmaps.controls.MapTypeControlOptions;
	import cl.pcornejo.gmaps.events.MarkerEvents;
	import cl.pcornejo.gmaps.LatLng;
	import cl.pcornejo.gmaps.Map;
	import cl.pcornejo.gmaps.events.MapsEvents;
	import cl.pcornejo.gmaps.MapOptions;
	import cl.pcornejo.gmaps.MapType;
	import cl.pcornejo.gmaps.overlays.InfoWindow;
	import cl.pcornejo.gmaps.overlays.InfoWindowOptions;
	import cl.pcornejo.gmaps.overlays.Marker;
	import cl.pcornejo.gmaps.overlays.MarkerOptions;
	import cl.pcornejo.gmaps.services.DirectionsRenderer;
	import cl.pcornejo.gmaps.services.DirectionsRendererOptions;
	import cl.pcornejo.gmaps.services.DirectionsRequest;
	import cl.pcornejo.gmaps.services.DirectionsResult;
	import cl.pcornejo.gmaps.services.DirectionsService;
	import cl.pcornejo.gmaps.services.DirectionsStatus;
	import cl.pcornejo.gmaps.services.Geocoder;
	import cl.pcornejo.gmaps.services.GeocoderRequest;
	import cl.pcornejo.gmaps.services.GeocoderResult;
	import cl.pcornejo.gmaps.services.GeocoderStatus;
	import cl.pcornejo.gmaps.services.TravelMode;
	import cl.pcornejo.gmaps.styles.MapTypeControlStyle;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.GeolocationEvent;
	import flash.geom.Rectangle;
	import flash.sensors.Geolocation;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * Example
	 * @author Patricio Cornejo
	 * @link http://www.pcornejo.cl
	 */
	public class MapTest extends Sprite 
	{
		public static var gmap:Map = null;
		private var iw:InfoWindow;
		private var geo:Geolocation;
		private var m:Marker;
		private var ma:Marker;
		private var latitud:Number;
		private var longitud:Number;
		private var drend:DirectionsRenderer;
		
		public function MapTest():void 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			configLocation();
		}
		
		private function configLocation():void 
		{
			if (Geolocation.isSupported) {
				geo = new Geolocation();
				geo.setRequestedUpdateInterval(1500);
				geo.addEventListener(GeolocationEvent.UPDATE, updateLocation);
			} else {
				//throw new Error("Geolocation not supported");
				trace("NO MAP SUPPORT!!");
			}
		}
		
		private function updateLocation(e:GeolocationEvent):void 
		{
			latitud = e.latitude; longitud = e.longitude;
			
			if (gmap == null) {
				configGMap();
			} else {
				if (m) m.setPosition(new LatLng(latitud, longitud));
			}
		}
		
		private function configGMap():void
		{
			var gopts:MapOptions = new MapOptions();
			gopts.zoom = 15;
			gopts.mapTypeId = MapType.ROADMAP;
			gopts.center = new LatLng(latitud, longitud);
			
			gmap = new Map();
			gmap.goptions = gopts;
			gmap.viewport = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			gmap.addEventListener(MapsEvents.MAP_READY, readyGMap);
			gmap.addEventListener(MapsEvents.CENTER_CHANGED, centerChanged);
			addChild(gmap);
		}
		
		private function readyGMap(e:MapsEvents):void 
		{
			trace("MAP_READY");
			makeMarker();
		}
		
		private function centerChanged(e:MapsEvents):void 
		{
			trace("CENTER_CHANGED");
			//gmap.removeEventListener(MapsEvents.CENTER_CHANGED, centerChanged);
		}
		
		private function makeMarker():void
		{
			var mopts:MarkerOptions = new MarkerOptions();
			mopts.position = new LatLng(latitud, longitud);
			mopts.draggable = false;
			mopts.map = gmap;
			
			var iopts:InfoWindowOptions = new InfoWindowOptions();
			iopts.content = "HOLA";
			iopts.map = gmap;
			
			iw = new InfoWindow(iopts);
			
			m = new Marker(mopts);
			m.addEventListener(MarkerEvents.CLICK, clickMarker);
			m.addEventListener(MarkerEvents.ADDED, markerAdded);
		}
		
		private function clickMarker(e:MarkerEvents):void 
		{
			trace("Click Marker");
			//iw.open(m); //Open a InfoWindow
			findAddress(); //Buscar Direccion
		}
		
		private function findAddress():void
		{
			var greq:GeocoderRequest = new GeocoderRequest();
			greq.address = "Mapocho 280, Santiago de Chile";
			
			var gcoder:Geocoder = new Geocoder(gmap);
			gcoder.geocode(greq, addFinded);
		}
		
		private function addFinded(results:Vector.<GeocoderResult>, status:Object):void 
		{
			if (status == GeocoderStatus.OK) {
				gmap.setCenter(results[0].geometry.location);
				
				var mopts:MarkerOptions = new MarkerOptions();
				mopts.position = results[0].geometry.location;
				mopts.map = gmap;
				
				ma = new Marker(mopts);
				ma.addEventListener(MarkerEvents.CLICK, calcRoute);
				ma.addEventListener(MarkerEvents.ADDED, markerAdded);
				
			} else {
				trace("Error al buscar: " + status);
			}
		}
		
		private function markerAdded(e:MarkerEvents):void 
		{
			trace("Marcador Agregado");
		}
		
		private function calcRoute(e:MarkerEvents):void
		{
			trace("CALC ROUTE");
			var dopts:DirectionsRendererOptions = new DirectionsRendererOptions();
			dopts.map = gmap;
			
			drend = new DirectionsRenderer(dopts);
			drend.setMap(gmap);
			
			var dserv:DirectionsService = new DirectionsService(gmap);
			var dreq:DirectionsRequest = new DirectionsRequest();
			dreq.origin = new LatLng(latitud, longitud);
			dreq.destination = ma.getPosition();
			dreq.travelMode = TravelMode.DRIVING;
			
			dserv.route(drend, dreq, routeReady);
		}
		
		/**
		 * When the Route its ready
		 * @param	results DirectionsResult
		 * @param	status String with the status of the route calculation.
		 */
		private function routeReady(results:DirectionsResult, status:String):void 
		{
			if (status == DirectionsStatus.OK) {
				drend.setDirections(results);
			}
		}
		
	}
	
}