package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ResidentsEntity extends Entity 
	{
		public var itemsArr:Array = new Array();
		
		public function ResidentsEntity() 
		{
			super();
			this.id = EntityIdEnum.RESIDENTS;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function addItem(name:String, address:String):void
		{
			var obj:Object = { id:0,
								created:new Date().time,
								name:name, address:address 
								
								};
			itemsArr.push(obj);
			
			save(null, null);
		}
		
	}

}