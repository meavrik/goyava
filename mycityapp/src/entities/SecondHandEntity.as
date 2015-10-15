package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SecondHandEntity extends Entity 
	{
		public var itemsArr:Array = new Array();
		
		public function SecondHandEntity() 
		{
			super();
			this.id = EntityIdEnum.SECOND_HAND;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function addItem(name:String, price:Number, phone:String = "", email:String = "", details:String = "", picture:String = ""):void
		{
			var dateCreated:Number = new Date().time;
			var obj:Object = { 	id:0, 
								created:dateCreated,
								name:name, 
								price:price,
								phone:phone,
								email:email,
								details:details,
								picture:picture
								};
								
			itemsArr.push(obj);
			save(null, null);
		}
		
	}

}