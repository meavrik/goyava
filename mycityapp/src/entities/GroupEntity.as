package entities 
{
	import com.gamua.flox.Access;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.interfaces.ICategorizedEntity;
	import log.Logger;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GroupEntity extends UserItemEntity implements ICategorizedEntity
	{
		private var _name:String
		private var _category:String
		public var members:Array = new Array();
		private var _description:String;
		
		public function GroupEntity() 
		{
			super();
			//this.publicAccess = Access.READ_WRITE;
			this.publicAccess = Access.READ;
		}
		
		public function createNewGroup(name:String, category:String, description:String):void
		{
			_name = name;
			_category = category;
			_description = description;

			addMeAsMember()
		}
		
		public function addMeAsMember():void
		{
			members.push( { id:GlobalDataProvider.myUserData.id, name:GlobalDataProvider.myUserData.name } );
			
			save(onSaveComplete, onSaveFail);
		}
		
		private function onSaveFail(message:String):void 
		{
			Logger.logError("save group item fail : " + message);
		}
		
		private function onSaveComplete():void 
		{
			AppDataLoader.getInstance().loadGroupsData();
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get category():String 
		{
			return _category;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function set category(value:String):void 
		{
			_category = value;
		}
		
		public function set description(value:String):void 
		{
			_description = value;
		}
	}

}