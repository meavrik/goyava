package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import entities.enum.EntityIdEnum;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class CommonDataEntity extends Entity 
	{
		public var groups:Array = new Array();
		public var sellItems:Array = new Array();
		public var residents:Array = new Array();
		public var losts:Array = new Array();
		
		public function CommonDataEntity() 
		{
			super();
			
			this.id = EntityIdEnum.COMMON;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function addSellItem(id:String, name:String, price:Number, currencySign:String, category:String, description:String,created:Number):void
		{
			var obj:Object = { id:id, 
								name:name, 
								price:price, 
								currencySign:currencySign, 
								category:category, 
								description:description , 
								created:created };
								
			if (!idExistInList(sellItems, id))
			{
				sellItems.push(obj);
			}					

			save(null, null);
		}
		
		public function addGroupItem(id:String,name:String,category:String):void 
		{
			if (!idExistInList(groups, id))
			{
				groups.push( { id:id, name:name, category:category } );
			}
			
			save(null, null);
		}
		
		public function addNewResident(id:String,name:String, address:String, details:String, score:Number):void 
		{
			var obj:Object = { id:id,
								created:new Date().time,
								name:name, 
								address:address ,
								details:details ,
								score:score
								};
								
								
			if (!idExistInList(residents, id))
			{
				residents.push(obj);
			}
			
			save(null, null);
		}
		
		public function addLostAndFoundItem(id:String, name:String, description:String, created:Number):void 
		{
			var obj:Object = { id:id,
								created:new Date().time,
								name:name, 
								description:description , 
								created:created };
			if (!idExistInList(losts, id))
			{
				losts.push(obj);
			}
			
			
			save(null, null);
		}
		
		public function removeSellItemByIndex(id:String):void 
		{
			for each (var item:Object in sellItems) 
			{
				if (item.id == id)
				{
					sellItems.splice(sellItems.indexOf(item, 1));
					return 
				}
			}
		}
		
		
		
		private function idExistInList(listArr:Array, id:String):Boolean 
		{
			for each (var item:Object in listArr) 
			{
				if (item.id == id)
				{
					return true;
				}
			}
			
			return false;
		}
		
	}

}