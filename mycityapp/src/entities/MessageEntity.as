package entities 
{
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MessageEntity extends Entity 
	{
		public var messages:Array = new Array();
		
		public function MessageEntity() 
		{
			super();
			this.id = GlobalDataProvider.userPlayer.id;
		}
		
	}

}