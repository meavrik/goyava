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
			//if (!sellItems) sellItems = new Array();
			sellItems.push( {	id:id, 
								name:name, 
								price:price, 
								currencySign:currencySign, 
								category:category, 
								description:description , 
								created:created } );
			save(null, null);
		}
		
		public function addGroupItem(id:String,name:String,category:String):void 
		{
			//if (!groups) groups = new Array();
			groups.push( { id:id, name:name, category:category } );
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
			residents.push(obj);
			
			save(null, null);
		}
		
		public function addLostAndFoundItem(id:String, name:String, description:String, created:Number):void 
		{
			var obj:Object = { id:id,
								created:new Date().time,
								name:name, 
								description:description , 
								created:created };
			losts.push(obj);
			
			save(null, null);
		}
		
	}

}