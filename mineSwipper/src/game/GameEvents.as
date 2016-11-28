package game 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GameEvents extends Event 
	{
		static public const NEW_GAME_EVENT:String = "newGame";
		static public const DIFFICULTY_SELECTED:String = "difficultySelected";
		
		public function GameEvents(type:String, bubbles:Boolean=false, data:Object=null) 
		{ 
			super(type, bubbles, data);
			
		} 
		
		
	}
	
}