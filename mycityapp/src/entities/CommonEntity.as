package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class CommonEntity extends Entity 
	{
		public var residentsArr	:Array = new Array();
		public var groupsArr	:Array = new Array();
		public var secondHandArr:Array = new Array();
		
		public function CommonEntity() 
		{
			super();
			this.publicAccess = Access.READ_WRITE;
		}
		
		/*public function addSecondHand(name:String, price:Number, phone:String = "", email:String = "", details:String = "", picture:String = ""):void
		{
			var obj:Object = { 	id:0, 
								created:new Date().time,
								name:name, 
								price:price,
								phone:phone,
								email:email,
								details:details,
								picture:picture
								};
								
			secondHandArr.push(obj);
			this.id = EntityIdEnum.SECOND_HAND;
			
			save(null, null);
		}*/
		
		public function addNewResident(name:String, address:String):void
		{
			var obj:Object = { id:0,
								created:new Date().time,
								name:name, address:address 
								
								};
			residentsArr.push(obj);
			this.id = EntityIdEnum.RESIDENTS;
			
			save(null, null);
		}
		
	}

}