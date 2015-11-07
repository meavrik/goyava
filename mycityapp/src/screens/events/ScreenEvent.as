package screens.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenEvent extends Event 
	{
		static public const BACK:String = "back";
		
		public function ScreenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		

		
	}
	
}