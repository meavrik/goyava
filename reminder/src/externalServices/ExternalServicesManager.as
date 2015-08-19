package externalServices 
{
	/**
	 * ...
	 * @author Avrik
	 */
	public class ExternalServicesManager 
	{
		private var _pushNotification:IPushNotification
		
		private static var _instance:ExternalServicesManager = new ExternalServicesManager();
		public static function getInstance():ExternalServicesManager
		{
			return _instance;
		}
		
		public function ExternalServicesManager() 
		{
			
		}
		
		public function init():void
		{
			_pushNotification = new PushWooshNotificationService();
			//_pushNotification = new PushNotificationService();
			_pushNotification.ArmPushNotifications();
		}
		
		public function get pushNotification():IPushNotification 
		{
			return _pushNotification;
		}
		
	}

}