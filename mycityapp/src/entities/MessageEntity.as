package entities 
{
	import com.gamua.flox.Access;
	import entities.enum.MessageTypeEnum;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MessageEntity extends UserItemEntity 
	{
		public var toUserId:String;
		public var toUserName:String;
		public var title:String;
		public var message:String;
		public var messageType:String;
		public var hasBeenReaded:Boolean;
		
		public function MessageEntity()
		{
			super();
			this.publicAccess = Access.READ;
		}
		
		public function createNewMessage(toUserId:String, toUserName:String, title:String = "", message:String = "", mType:String = ""):void
		{
			this.messageType = mType?mType:MessageTypeEnum.PERSONAL;
			this.toUserId = toUserId;
			this.toUserName = toUserName;
			//this.fromName = GlobalDataProvider.myUserData.name;
			this.title = title;
			this.message = message;
			
			
		}

	}

}