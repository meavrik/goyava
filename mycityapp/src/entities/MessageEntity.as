package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MessageEntity extends Entity 
	{
		public var toUserId:String;
		public var toUserName:String;
		public var fromUserId:String;
		public var fromName:String;
		public var title:String;
		public var message:String;
		
		public function MessageEntity()
		{
			super();
			
			this.ownerId = GlobalDataProvider.userPlayer.id;
			this.publicAccess = Access.READ_WRITE
		}
		
		public function createNewMessage(toUserId:String, toUserName:String, title:String = "", message:String = ""):void
		{
			this.toUserId = toUserId;
			this.toUserName = toUserName;
			this.fromUserId = GlobalDataProvider.userPlayer.id;
			this.fromName = GlobalDataProvider.userPlayer.name;
			this.title = title;
			this.message = message;
		}

	}

}