package log 
{
	import com.gamua.flox.Flox;
	/**
	 * ...
	 * @author Avrik
	 */
	public class Logger 
	{
		
		public static function logWarning(message:String, ...rest):void
		{
			Flox.logWarning(message, rest);
		}
		
		public static function logEvent(name:String, properties:Object=null):void
		{
			Flox.logEvent(name, properties);
		}
		
		public static function logInfo(message:String, ...rest):void
		{
			Flox.logInfo(message, rest);
		}
		
		public static function logError(error:Object, message:String=null, ...rest):void
		{
			Flox.logError(error, message, rest);
		}
		
	}

}