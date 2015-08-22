package locale 
{
	/**
	 * ...
	 * @author Avrik
	 */
	public class LocaleManager 
	{
		private var _langs:Vector.<Language> = new Vector.<Language>;
		
		private static var _instance:LocaleManager = new LocaleManager();
		public static function getInstance():LocaleManager
		{
			return _instance;
		}
		
		public function LocaleManager() 
		{
			addNewLang(LocaleCodeEnum.ENGLISH, "English");
			addNewLang(LocaleCodeEnum.HEBREW, "עברית");
			addNewLang(LocaleCodeEnum.ITALIAN, "Italian");
			addNewLang(LocaleCodeEnum.GERMAN, "German");
			addNewLang(LocaleCodeEnum.RUSSIAN, "Russian");
			addNewLang(LocaleCodeEnum.SPANISH, "Russian");
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