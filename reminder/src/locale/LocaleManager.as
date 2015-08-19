package locale 
{
	/**
	 * ...
	 * @author Avrik
	 */
	public class LocaleManager 
	{
		/*public static var ENGLISH:String = "en";
		public static var ITALIAN:String = "it";
		public static var GERMAN:String = "de";
		public static var RUSSIAN:String = "ru";
		public static var HEBREW:String = "he";*/
		
		private var _langs:Vector.<Language> = new Vector.<Language>;
		
		private static var _instance:LocaleManager = new LocaleManager();
		public static function getInstance():LocaleManager
		{
			return _instance;
		}
		
		public function LocaleManager() 
		{
			addNewLang("en", "English");
			addNewLang("he", "עברית");
			addNewLang("it", "Italian");
			addNewLang("de", "German");
			addNewLang("ru", "Russian");
		}
		
		private function addNewLang(code:String, name:String):void 
		{
			var lang:Language = new Language();
			lang.code = code;
			lang.name = name;
			_langs.push(lang);
		}
		
		public function getLocaleByCode(code:String):Language 
		{
			for each (var item:Language in _langs) 
			{
				if (item.code == code)
				{
					return item;
				}
			}
			return _langs[0];
		}
		
		public function get langs():Vector.<Language> 
		{
			return _langs;
		}
		
		
	}

}