package screens 
{
	import com.adobe.nativeExtensions.maps.Map;
	import com.adobe.nativeExtensions.maps.MapEvent;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMap extends BaseScreenMain 
	{
		//private var googleMap:Map;
		private const MAP_KEY:String = "AIzaSyBD3qb2JMNfv7UUzCZV98rtWxnIHbKx7gM";

		public function ScreenMap() 
		{
			super();
			
		}
		//var map:Map 
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "מפה";
			/*var viewPortMap:Rectangle = new Rectangle(0,0,800,600);
			googleMap = new Map();
			googleMap.viewPort = viewPortMap;
			googleMap.setSize(new Point (800, 600));*/
			
			//navigateToURL(new URLRequest("https://www.google.co.il/maps/place/Even+Yehuda/@32.2843099,34.8521465,15.25z/data=!4m2!3m1!1s0x151d3f73dd4c85e7:0x2ec1cc5f360d156"));
		}
		
	}

}