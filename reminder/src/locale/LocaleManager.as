package locale 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import entities.LocaleEntity;
	import flash.events.ErrorEvent;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import texts.TextLocaleHandler;
	import users.UserGlobal;
	/**
	 * ...
	 * @author Avrik
	 */
	public class LocaleManager extends EventDispatcher
	{
		static public const LOAD_TEXTS_COMPLETE:String = "loadTextsComplete";
		static public const SAVE_TEXTS_ERROR:String = "saveTextsError";
		static public const SAVE_TEXTS_COMPLETE:String = "saveTextsComplete";
		
		[Embed(source = "../../bin/locale.xml", mimeType = "application/octet-stream")]
		private var localeXmlData:Class
		
		private var _langs:Vector.<Language> = new Vector.<Language>;
		
		private static var _instance:LocaleManager = new LocaleManager();
		private var localeXml:XML;
		
		public static function getInstance():LocaleManager
		{
			return _instance;
		}
		
		public function LocaleManager() 
		{
			TextLocaleHandler.textsEntity = new LocaleEntity();
			TextLocaleHandler.textsEntity.id = "localeTexts";
			//TextLocaleHandler.textsEntity.ownerId = UserGlobal.userPlayer.id;
			TextLocaleHandler.textsEntity.publicAccess = Access.READ;
			
			localeXml = XML(new localeXmlData());
			
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
		
		public function saveLocaleTexts():void 
		{
			/*TextLocaleHandler.textsEntity = new LocaleEntity();
			TextLocaleHandler.textsEntity.id = "localeTexts";
			TextLocaleHandler.textsEntity.publicAccess = Access.READ_WRITE;
			TextLocaleHandler.textsEntity.ownerId = Player.current.id;*/
			
			TextLocaleHandler.textsEntity.publicAccess = Access.READ_WRITE;
			
			saveTextsXmlToEntity();
		}
		
		
		private function saveTextsXmlToEntity():void
		{
			var langObjArr:Array = new Array();
			
			for (var i:int = 0; i < localeXml.children().length(); i++) 
			{
				var node:XML = localeXml.children()[i];
				var textTitleName:String = node.name();
				
				for (var j:int = 0; j < node.attributes().length(); j++) 
				{
					var langName:String=node.attributes()[j].name()
					var text:String = node.attributes()[j]
					
					if (!langObjArr[langName]) langObjArr[langName] = new Object();
					langObjArr[langName][textTitleName] = text;
				}
			}

			TextLocaleHandler.textsEntity.English = langObjArr[LocaleCodeEnum.ENGLISH];
			TextLocaleHandler.textsEntity.Hebrew = langObjArr[LocaleCodeEnum.HEBREW];
			TextLocaleHandler.textsEntity.Spanish = langObjArr[LocaleCodeEnum.SPANISH];
			//TextLocaleHandler.textsEntity.French = langObjArr["fr"];
			TextLocaleHandler.textsEntity.Italian = langObjArr[LocaleCodeEnum.ITALIAN];
			TextLocaleHandler.textsEntity.Russian = langObjArr[LocaleCodeEnum.RUSSIAN];
			TextLocaleHandler.textsEntity.German = langObjArr[LocaleCodeEnum.GERMAN];
			
			TextLocaleHandler.textsEntity.save(onAdminTextsSaveSuccess, onAdminTextsSaveError);
		}
		
		private function onAdminTextsSaveError(message:String):void 
		{
			Flox.logInfo("on Admin Texts Save Error :"+message);
			//startApplication()
			
			//loginUser()
			dispatchEvent(new Event(SAVE_TEXTS_ERROR));
		}
		private function onAdminTextsSaveSuccess():void 
		{
			Flox.logInfo("on Admin Texts Save Success ");
			//startApplication()
			
			//loginUser()
			dispatchEvent(new Event(SAVE_TEXTS_COMPLETE));
		}
		
		public function loadLocaleFromLocal():void 
		{
			Flox.logInfo("load Locale From Local storage");
			
			
			saveTextsXmlToEntity();
			
			
			dispatchEvent(new Event(LOAD_TEXTS_COMPLETE));
		}
		
		public function loadLocaleFromServer():void 
		{
			Flox.logInfo("load Locale From remote Server ");
			Entity.load(LocaleEntity, TextLocaleHandler.textsEntity.id, onLocaleLoadComplete, onLocaleLoadError);
		}
		
		private function onLocaleLoadError(message:String):void
		{
			Flox.logError(this, "on Locale Load Error {0}", message);
			//startApp();
			
			loadLocaleFromLocal();
		}
		
		private function onLocaleLoadComplete(entity:LocaleEntity):void
		{
			Flox.logInfo("on Locale Load Complete ");
			TextLocaleHandler.textsEntity = entity;
			//_progressBar.value = 100
			
			//Starling.juggler.delayCall(startApp, 0.1);
			
			dispatchEvent(new Event(LOAD_TEXTS_COMPLETE));
		}
		
		
		
		
		
		
		public function get langs():Vector.<Language> 
		{
			return _langs;
		}
		
		
		/*public function getLocaleByCode(code:String):Language 
		{
			for each (var item:Language in _langs) 
			{
				if (item.code == code)
				{
					return item;
				}
			}
			return _langs[0];
		}*/
		
		
		
		
		
		
	}

}