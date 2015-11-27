package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import log.Logger;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GroupEntity extends Entity 
	{
		public var ownerName:String;
		public var name:String
		//public var date:Number
		public var category:String
		public var members:Array = new Array();
		public var description:String;
		
		public function GroupEntity() 
		{
			super();

			this.publicAccess = Access.READ_WRITE;
			this.ownerId = GlobalDataProvider.userPlayer.id;
		}
		
		public function createNewGroup(ordinal:int, _name:String,  _category:String, _description:String):void
		{
			this.id = ordinal.toString();
			name = _name;
			//date = new Date().time;
			category = _category;
			description = _description;
			ownerName = GlobalDataProvider.userPlayer.name;

			addMeToGroup();
		}
		
		public function addMember(memberId:String,name:String):void
		{
			members.push( { id:memberId, name:name } );
			
			save(onSaveComplete, onSaveFail);
		}
		
		private function onSaveFail(message:String):void 
		{
			Logger.logError("save group item fail : " + message);
		}
		
		private function onSaveComplete():void 
		{
			//GlobalDataProvider.groupsDataProvier.addItem(groupEntity.id, groupEntity.name);
			GlobalDataProvider.commonEntity.addGroupItem(this.id , name, category);
		}
		
		public function addMeToGroup():void 
		{
			addMember(GlobalDataProvider.userPlayer.id, GlobalDataProvider.userPlayer.name);
		}
	}

}