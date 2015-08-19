package entities 
{
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class TaskEntity extends Entity 
	{
		public var remindEvery:String;
		public var tasks:Array = new Array();
		
		public function TaskEntity() 
		{
			super();
			
		}
		
	}

}