package externalServices 
{
	import com.freshplanet.nativeExtensions.PushNotification;
	import com.freshplanet.nativeExtensions.PushNotificationEvent;
	import com.gamua.flox.Flox;
	import controllers.ErrorController;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class PushNotificationService extends EventDispatcher implements IPushNotification
	{
		//static public const GOOGLE_PROJECT_ID:String = "A916285328591";
		static public const GOOGLE_PROJECT_ID:String = "958597314309";
		
		private var _push:PushNotification;
		//private var _registered:Boolean;
		
		public function PushNotificationService() 
		{
			super();
			
			Flox.logInfo("init PushWoosh");
			try 
			{
				_push = PushNotification.getInstance();
				
				if (_push.isPushNotificationSupported)
				{
					Flox.logInfo("PushNotification Supported");
					
					_push.registerForPushNotification(GOOGLE_PROJECT_ID);

					// Register for events
					_push.addEventListener(PushNotificationEvent.PERMISSION_GIVEN_WITH_TOKEN_EVENT, onPushNotificationToken);
					_push.addEventListener(PushNotificationEvent.NOTIFICATION_RECEIVED_WHEN_IN_FOREGROUND_EVENT, onNotificationReceivedInForeground);
					_push.addEventListener(PushNotificationEvent.APP_BROUGHT_TO_FOREGROUND_FROM_NOTIFICATION_EVENT, onNotificationReceivedInBackground);
					_push.addListenerForStarterNotifications(onNotificationReceivedStartingTheApp);
					_push.setIsAppInForeground(true);
				} else
				{
					Flox.logWarning("PushNotification is not Supported");
				}
				
				scheduleNotification(10, "YEAHH!!!",1);
				// local push test
				//_pushwoosh.scheduleLocalNotification(10, "{\"alertBody\": \"Time to collect coins!\", \"alertAction\":\"Collect!\", \"soundName\":\"sound.caf\", \"badge\": 5, \"custom\": {\"a\":\"json\"}}");
				//_push.setMultiNotificationMode();
			} catch (error:Error)
			{
				Flox.logWarning("init pushwoosh error : " + error.message);
			}
		}
		
		private function onNotificationReceivedStartingTheApp():void 
		{
			Flox.logInfo("onNotificationReceivedStartingTheApp");
			
			scheduleNotification(20, "YEAHH!!!",1);
		}
		
		private function onNotificationReceivedInBackground(e:PushNotificationEvent):void 
		{
			Flox.logInfo("onNotificationReceivedInBackground");
		}
		
		private function onNotificationReceivedInForeground(e:PushNotificationEvent):void 
		{
			Flox.logInfo("onNotificationReceivedInForeground");
		}
		
		private function onPushNotificationToken(event:PushNotificationEvent):void
		{
			trace("My push token is: " + event.token);
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
					var timeStamp:Number = new Date().time + newSeconds * 1000;
					//var timeStamp:Number = new Date().time + newSeconds * 1000;
					trace("TIME STAMP === " + timeStamp);
					_push.sendLocalNotification(newTxt, timeStamp, "Remember!", PushNotification.DEFAULT_LOCAL_NOTIFICATION_ID, i);
				}
				catch (err:Error)
				{
					Flox.logWarning("scheduleLocalNotification error :" + err.message);
				}
				
			}
		}
		
		public function removeNotification(id:int):void
		{
			_push.cancelLocalNotification(id);
		}
		
		/*public function onToken(e:PushNotificationEvent):void{
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
				_push.registerForPushNotification();
			}
		}
		
		public function DisarmPushNotifications():void 
		{
			if (_registered)
			{
				Flox.logInfo("DisarmPushNotifications ");
				
				_registered = false;
				//_pushwoosh.unregisterFromPushNotification();
			}
			
		}*/
		
		public function ArmPushNotifications():void 
		{

		}
		
		/* INTERFACE externalServices.IPushNotification */
		
		public function removeAllNotifications():void 
		{
			if (_push)
			{
				_push
			}
		}
	}

}