package entities 
{
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ResidentsEntity extends Entity 
	{
		public var arr:Array = new Array();
		
		public function ResidentsEntity() 
		{
			super();
			
		}
		
		public function addNew(name:String, address:String):void
		{
			var obj:Object = { name:name, address:address };
			arr.push(obj);
			
			save(null, null);
		}
		
	}

}