package entities 
{
	import com.gamua.flox.Access;
	/**
	 * ...
	 * @author Avrik
	 */
	public class CommonEntity extends BaseEntity 
	{
		public var name:String;
		
		public function CommonEntity() 
		{
			super();
			this.publicAccess = Access.READ;
		}
		
		
		public function generate(data:Object):void
		{
			if (data)
			{
				name = data.@name;
			}
		}
	}

}