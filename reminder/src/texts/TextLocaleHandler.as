package texts 
{
	import com.gamua.flox.Flox;
	import entities.LocaleEntity;
	import locale.LocaleCodeEnum;
	import users.UserGlobal;
	/**
	 * ...
	 * @author Avrik
	 */
	public class TextLocaleHandler 
	{
		static public var textsEntity:LocaleEntity;		
		
		static public function getText(str:String):String
		{
			var localeStr:String = "!no text found!";
			
			try 
			{
				/*localeStr= textsEntity[str][UserGlobal.userPlayer.locale];
				if (!localeStr)
				{
					localeStr = textsEntity[str][LocaleCodeEnum.ENGLISH];
				}*/
				
				switch (UserGlobal.userPlayer.locale) 
				{
					case LocaleCodeEnum.HEBREW:
						localeStr = textsEntity.Hebrew[str];
						break;
					case LocaleCodeEnum.ITALIAN:
						localeStr = textsEntity.Italian[str];
						break;
					case LocaleCodeEnum.GERMAN:
						localeStr = textsEntity.German[str];
						break;
					default:
						localeStr = textsEntity.English[str];
						break;
				}
			}
			catch (err:Error)
			{
				Flox.logWarning("TextLocaleHandler", "no text found " + err.message);
			}
			
			return localeStr;
		}
		
	}

}