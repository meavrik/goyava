package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	import log.Logger;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LostAndFoundEntity extends UserItemEntity 
	{
		//public var ownerName:String;
		public var name:String
		public var description:String;
		public var pictures:Array;
		public var itemType:String;
		public var category:String;
		
		public function LostAndFoundEntity() 
		{
			super();
			this.publicAccess = Access.READ;
		}
		
		public function createNewLostFoundItem(_name:String, _itemType:String,_category:String, _description:String,pictures:Array=null):void
		{
			name = _name;
			category = _category;
			description = _description;
			itemType = _itemType;

			save(onSaveComplete, onSaveFail);
		}
		
		private function onSaveFail(message:String):void 
		{
			Logger.logError("save lost item fail : " + message);
		}
		
		private function onSaveComplete():void 
		{
			Logger.logInfo("save lost item success");
		}
		
	}

}