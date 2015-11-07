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
		public var isAdmin:Boolean;
		public var name:String;
		public var lastName:String;
		public var address:String;
		public var sex:String;
		public var details:String;
		public var score:Number = 0;
		
		public var myGroups:Array = new Array();
		public var mySales:Array = new Array();
		
		public function FloxPlayer()
		{
			super();
			
		}
	
	}

}