package entities 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	/**
	 * ...
	 * @author Avrik
	 */
	public class BusinessEntity extends CommonEntity 
	{
		
		public var address:String = "";
		public var category:String = "";
		public var description:String = "";
		public var phone:String = "";
		public var email:String = "";
		public var website:String = "";
		public var pictureUrl:String;
		public var logoUrl:String;
		public var buisnessType:String;
		
		public function BusinessEntity() 
		{
			super();
			
		}
		
		override public function generate(data:Object):void 
		{
			super.generate(data);
			
			if (data)
			{
				//name = data.@name;
				address = data.@address;
				category = data.@category;
				description = data.@description;
				phone = data.@phone;
				email = data.@email;
				website = data.@website;
				pictureUrl = data.@pictureUrl;
				logoUrl = data.@logoUrl;
				buisnessType = data.@type;
			}
		}
		
	}

}