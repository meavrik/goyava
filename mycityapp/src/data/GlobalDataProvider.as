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
		//static public var commonData:CommonEntity;
		//static public var secondHandDataProvier:SecondHandEntity = new SecondHandEntity();
		//static public var residentsDataProvier:ResidentsEntity = new ResidentsEntity();
		
		//static public var groupsDataProvier:GroupsListEntity = new GroupsListEntity();
		
		static public var currencySign:String = "₪";
		static public var commonEntity:CommonDataEntity = new CommonDataEntity();
			
		
	}

}