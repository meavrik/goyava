package entities 
{
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	import log.Logger;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LostAndFoundEntity extends Entity 
	{
		public var ownerName:String;
		public var name:String
		public var description:String;
		public var pictures:Array;
		
		public function LostAndFoundEntity() 
		{
			super();
			
			this.ownerId = GlobalDataProvider.userPlayer.id;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function createNewLostFoundItem(_name:String, _category:String, _description:String,pictures:Array=null):void
		{
			this.id = GlobalDataProvider.commonEntity.losts.length;
			name = _name;
			category = _category;
			description = _description;

			save(onSaveComplete, onSaveFail);
		}
		
		private function onSaveFail(message:String):void 
		{
			Logger.logError("save lost item fail : " + message);
		}
		
		private function onSaveComplete():void 
		{
			Logger.logInfo("save lost item success");
			GlobalDataProvider.commonEntity.addLostAndFoundItem(this.id, name, description,updatedAt.time);
			
			//GlobalDataProvider.userPlayer.mySales.push( { name:name, price:price, category:category } );
			//GlobalDataProvider.userPlayer.save(null, null);
		}
		
	}

}