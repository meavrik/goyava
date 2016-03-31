package entities 
{
	import com.gamua.flox.Access;
	import data.AppDataLoader;
	import entities.interfaces.ICategorizedEntity;
	import log.Logger;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SellItemEntity extends UserItemEntity implements ICategorizedEntity
	{
		private var _name:String
		public var price:Number
		private var _category:String;
		public var description:String;
		public var phone:String;
		public var email:String;
		public var pictures:Array;
		
		public function SellItemEntity() 
		{
			super();
			this.publicAccess = Access.READ;
		}
		
		public function createNewSellItem(name:String, _price:Number, category:String, _description:String = "", _pictures:Array = null, phone:String = "", email:String = ""):void
		{
			_name = name;
			price = _price;
			_category = category;
			description = _description;
			pictures = _pictures;
			phone = phone;
			email = email;
			
			save(onSaveComplete, onSaveFail);
		}
		
		private function onSaveFail(message:String):void 
		{
			Logger.logError("save sell item fail : " + message);
		}
		
		private function onSaveComplete():void 
		{
			Logger.logInfo("save sell item success");
			//AppDataLoader.getInstance().loadSellItemsData();
			//AppDataLoader.getInstance().loadEntityData(SellItemEntity);
			
			//GlobalDataProvider.commonEntity.addSellItem(this.id, name, price, GlobalDataProvider.currencySign, category,description,updatedAt.time);
			//GlobalDataProvider.userPlayer.mySales.push( { id:this.id, name:name, price:price, category:category } );
			//GlobalDataProvider.userPlayer.save(null, null);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get category():String 
		{
			return _category;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function set category(value:String):void 
		{
			_category = value;
		}
		
	}

}