package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GroupsEntity extends Entity 
	{
		public var itemsArr:Array = new Array();
		
		public function GroupsEntity() 
		{
			super();
			this.id = EntityIdEnum.GROUPS;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function addItem(name:String, creator:String, category:String):void
		{
			var obj:Object = { id:0,
								created:new Date().time,
								name:name, 
								category:category ,
								creator:creator 
								
								};
			itemsArr.push(obj);
			
			save(null, null);
		}
	}

}