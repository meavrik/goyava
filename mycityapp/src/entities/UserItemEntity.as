package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class UserItemEntity extends Entity 
	{
		public var ownerName:String;
		
		public function UserItemEntity() 
		{
			super();
			
			this.ownerId = GlobalDataProvider.myUserData.id;
			this.ownerName = GlobalDataProvider.myUserData.name;
			//this.publicAccess = Access.READ_WRITE;
		}
		
	}

}