package externalServices 
{
	
	/**
	 * ...
	 * @author Avrik
	 */
	public interface IPushNotification 
	{
		function ArmPushNotifications():void;
		
		function scheduleNotification(seconds:int, txt:String, repeat:int):void;
		
		function removeNotification(id:int):void;
	}
	
}