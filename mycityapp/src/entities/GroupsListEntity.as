package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GroupsListEntity extends Entity 
	{
		public var itemsArr:Array = new Array();
		
		public function GroupsListEntity() 
		{
			super();
			
			this.id = EntityIdEnum.GROUPS;
			this.publicAccess = Access.READ_WRITE;
		}
		
		public function addItem(id:String,name:String):void 
		{
			if (!itemsArr) itemsArr = new Array();
			itemsArr.push( { id:id, name:name } );
			save(null, null);
		}
		
	}

}