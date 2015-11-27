package data 
{
	import entities.CommonDataEntity;
	import users.FloxPlayer;
	/**
	 * ...
	 * @author Avrik
	 */
	public class GlobalDataProvider 
	{
		static public var userPlayer:FloxPlayer
		static public var currencySign:String = "₪";
		static public var commonEntity:CommonDataEntity = new CommonDataEntity();
		static public var myMessages:Array;
			
		
	}

}