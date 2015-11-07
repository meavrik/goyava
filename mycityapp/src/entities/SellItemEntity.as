package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SellItemEntity extends Entity 
	{
		public var ownerName:String;
		public var name:String
		public var price:Number
		public var category:String;
		public var description:String;
		public var pictures:Array;
		
		public function SellItemEntity() 
		{
			super();
			
			this.ownerId = GlobalDataProvider.userPlayer.id;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function createNewSellItem(_name:String, _price:Number, _category:String, _description:String,pictures:Array=null):void
		{
			this.id = GlobalDataProvider.commonEntity.sellItems.length.toString();
			name = _name;
			price = _price;
			category = _category;
			description = _description;

			save(onSaveComplete, onSaveFail);
		}
		
		private function onSaveFail(message:String):void 
		{
			Flox.logError("save sell item fail : " + message);
		}
		
		private function onSaveComplete():void 
		{
			Flox.logInfo("save sell item success");
			GlobalDataProvider.commonEntity.addSellItem(this.id, name, price, GlobalDataProvider.currencySign, category,description,updatedAt.time);
			
			GlobalDataProvider.userPlayer.mySales.push( { name:name, price:price, category:category } );
			GlobalDataProvider.userPlayer.save(null, null);
		}
		
	}

}