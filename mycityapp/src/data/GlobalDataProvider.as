package data 
{
	import entities.BusinessEntity;
	import entities.FloxUser;
	import entities.GroupEntity;
	import entities.SellItemEntity;
	/**
	 * ...
	 * @author Avrik
	 */
	public class GlobalDataProvider 
	{
		static public var myUserData:FloxUser
		static public var currencySign:String = "₪";

		
		static public var myMessages:Array;
		static public var users:Vector.<FloxUser> = new Vector.<FloxUser>;
		
		static public var groups:Vector.<GroupEntity>=new Vector.<GroupEntity>;
		static public var myGroups:Vector.<GroupEntity> = new Vector.<GroupEntity>;
		
		static public var sellItems:Vector.<SellItemEntity> = new Vector.<SellItemEntity>;
		static public var mySellItems:Vector.<SellItemEntity> = new Vector.<SellItemEntity>;
		
		static public var businesses:Vector.<BusinessEntity>= new Vector.<BusinessEntity>;
	}

}