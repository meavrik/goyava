package screens 
{
	import com.adobe.nativeExtensions.maps.Map;
	import feathers.controls.PanelScreen;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMap extends PanelScreen 
	{
		private var googleMap:Map;
		
		public function ScreenMap() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "מפה";
			/*var viewPortMap:Rectangle = new Rectangle(0,0,800,600);
			googleMap = new Map();
			googleMap.viewPort = viewPortMap;
			googleMap.setSize(new Point (800, 600));*/
		}
		
	}

}