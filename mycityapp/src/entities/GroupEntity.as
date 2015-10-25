package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GroupEntity extends Entity 
	{
		public var name:String
		//public var date:Number
		public var category:String
		public var members:Array = new Array();
		public var description:String;
		//public var groupsArr:Array = new Array();
		
		public function GroupEntity() 
		{
			super();

			this.publicAccess = Access.READ_WRITE;
			this.ownerId = GlobalDataProvider.userPlayer.id;
		}
		
		public function createNewGroup(ordinal:int, _name:String, creator:String, _category:String, _description:String):void
		{
			this.id = ordinal.toString();
			name = _name;
			//date = new Date().time;
			category = _category;
			description = _description;

			//save(null, null);
			addMeToGroup();
		}
		
		public function addMember(memberId:String,name:String):void
		{
			members.push( { id:memberId, name:name } );
			
			save(null, null);
		}
		
		public function addMeToGroup():void 
		{
			addMember(GlobalDataProvider.userPlayer.id, GlobalDataProvider.userPlayer.name);
		}
	}

}