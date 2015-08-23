package externalServices 
{
	import com.gamua.flox.Flox;
	import com.pushwoosh.nativeExtensions.PushNotification;
	import com.pushwoosh.nativeExtensions.PushNotificationEvent;
	import controllers.ErrorController;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	 //A916285328591
	public class PushWooshNotificationService extends EventDispatcher implements IPushNotification
	{
		static public const PUBLIC_ID:String = "publicId";
		
		private var _pushwoosh:PushNotification;
		private var _registered:Boolean;
		
		public function PushWooshNotificationService() 
		{
			super();
			
			Flox.logInfo("init PushWoosh");
			try 
			{
				_pushwoosh = PushNotification.getInstance();
				
				if (_pushwoosh.isPushNotificationSupported)
				{
					Flox.logInfo("PushNotification Supported");
					
					_pushwoosh.addEventListener(PushNotificationEvent.PERMISSION_GIVEN_WITH_TOKEN_EVENT, onToken);
					_pushwoosh.addEventListener(PushNotificationEvent.PERMISSION_REFUSED_EVENT, onError);
					_pushwoosh.addEventListener(PushNotificationEvent.PUSH_NOTIFICATION_RECEIVED_EVENT, onPushReceived);
					_pushwoosh.onDeviceReady();
				} else
				{
					Flox.logWarning("PushNotification is not Supported");
				}
				
				// local push test
				//_pushwoosh.scheduleLocalNotification(10, "{\"alertBody\": \"Time to collect coins!\", \"alertAction\":\"Collect!\", \"soundName\":\"sound.caf\", \"badge\": 5, \"custom\": {\"a\":\"json\"}}");
				_pushwoosh.setMultiNotificationMode();
			} catch (error:Error)
			{
				Flox.logWarning("init pushwoosh error : " + error.message);
			}
		}
		
		
		public function scheduleNotification(seconds:int, txt:String, repeat:int):void
		{
			var addToSentenceArr:Array = [
				"Just reminding you about ",
				"Reminding you again about ",
				"Don't forget to ",
				"When are you going to ",
				"It's about time you "
			]	
			
			var newTxt:String;
			var newSeconds:Number;
			for (var i:int = 0; i < repeat; i++) 
			{
				newTxt = i < repeat?addToSentenceArr[i]:addToSentenceArr[(addToSentenceArr.length - 1)];
				newTxt = newTxt + txt;
				newSeconds = seconds * (i + 1);
				try
				{
					Flox.logInfo("scheduleNotification every " + newSeconds + " seconds with the text : " + newTxt);

					_pushwoosh.scheduleLocalNotification(newSeconds, "{\"alertBody\": \"'" + newTxt + "'\", \"alertAction\":\"Collect!\", \"soundName\":\"sound.caf\", \"badge\": 5, \"custom\": {\"a\":\"json\"}}");
				}
				catch (err:Error)
				{
					Flox.logWarning("scheduleLocalNotification error :" + err.message);
				}
				
			}
			
		}
		
		public function onToken(e:PushNotificationEvent):void{
			Flox.logInfo("onToken TOKEN: {0} params = {1}", e.token);
		}

		public function onError(e:PushNotificationEvent):void{

			_registered = false;
			Flox.logWarning("onError TOKEN: " + e.errorMessage);
		}

		public function onPushReceived(e:PushNotificationEvent):void{
			Flox.logInfo("onPushReceived TOKEN: " + JSON.stringify(e.parameters));
		}

		public function ArmPushNotifications():void 
		{
			if (!_registered)
			{
				Flox.logInfo("ArmPushNotifications ");
				
				_registered = true;
				_pushwoosh.registerForPushNotification();
			}
		}
		
		public function DisarmPushNotifications():void 
		{
			if (_registered)
			{
				Flox.logInfo("DisarmPushNotifications ");
				
				_registered = false;
				_pushwoosh.unregisterFromPushNotification();
			}
			
		}
		
		/* INTERFACE externalServices.IPushNotification */
		
		public function removeNotification(id:int):void 
		{
			
		}
	}

}