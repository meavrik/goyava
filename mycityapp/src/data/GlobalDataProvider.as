package data 
{
	import entities.CommonEntity;
	import entities.GroupsEntity;
	import entities.ResidentsEntity;
	import entities.SecondHandEntity;
	import users.FloxPlayer;
	/**
	 * ...
	 * @author Avrik
	 */
	public class GlobalDataProvider 
	{
		static public var userPlayer:FloxPlayer
		//static public var commonData:CommonEntity;
		static public var secondHandDataProvier:SecondHandEntity = new SecondHandEntity();
		static public var residentsDataProvier:ResidentsEntity = new ResidentsEntity();
		static public var groupsDataProvier:GroupsEntity = new GroupsEntity();
		
		static public var currencySign:String = "₪";
			
		
	}

}