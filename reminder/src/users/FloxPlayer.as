package users
{
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class FloxPlayer extends Player
	{
		public var currentItemID:int;
		public var locale:String;
		public var tasks:Array = new Array();
		public var sentences:Array = new Array();
		public var myEvents:Array = new Array();
		public var myShoppingList:Array = new Array();
		
		public function FloxPlayer()
		{
			super();
		
		}
	
	}

}