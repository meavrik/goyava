package entities
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class FloxUser extends Player
	{
		public var isAdmin:Boolean = false;
		public var name:String = "";
		public var lastName:String = "";
		public var address:String = "";
		public var sex:String = "male";
		public var details:String = "";
		public var score:Number = 0;
		public var phoneNumber:String = "";
		public var email:String = "";
		
		public function FloxUser()
		{
			super();
			
		}
	
	}

}