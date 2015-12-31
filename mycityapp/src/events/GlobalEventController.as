package events 
{
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GlobalEventController extends EventDispatcher 
	{
		static public const RELOAD_APP:String = "reloadApp";
		
		private static var _instance:GlobalEventController = new GlobalEventController();
		public static function getInstance():GlobalEventController
		{
			return _instance;
		}
		
		public function GlobalEventController() 
		{
			super();
			
		}
		
	}

}