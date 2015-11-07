package screens 
{
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMap extends ScreenSubMain 
	{
		//private var googleMap:Map;
		private const MAP_KEY:String = "AIzaSyBD3qb2JMNfv7UUzCZV98rtWxnIHbKx7gM";

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