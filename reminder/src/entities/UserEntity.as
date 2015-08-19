package entities 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Player;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class UserEntity extends Entity 
	{
		public var locale:String;
		
		public function UserEntity() 
		{
			super();
			this.id = Player.current.id;
		}
		
	}

}