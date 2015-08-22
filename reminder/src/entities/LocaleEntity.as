package entities 
{
	import com.gamua.flox.Entity;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LocaleEntity extends Entity 
	{
		//public var MainScreenTitle:Object;
		//public var EmptySentence:Object;
		
		public var English:Object;
		public var Hebrew:Object;
		public var Spanish:Object;
		public var French:Object;
		public var Italian:Object;
		public var Russian:Object;
		public var German:Object;
		
		public function LocaleEntity() 
		{
			super();
			
			//this.id = "localeTexts";
		}
		
	}

}