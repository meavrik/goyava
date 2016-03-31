package data 
{
	import com.gamua.flox.Entity;
	import entities.BusinessEntity;
	import entities.FloxUser;
	import entities.GroupEntity;
	import entities.LostAndFoundEntity;
	import entities.SellItemEntity;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Avrik
	 */
	public class GlobalDataProvider 
	{
		static private var _ownedDictionary:Dictionary = new Dictionary();
		
		
		static public var myUserData:FloxUser
		static public var currencySign:String = "₪";

		
		static public var myMessages:Array;
		static public var users:Vector.<FloxUser> = new Vector.<FloxUser>;
		
		static public var groups:Vector.<GroupEntity>=new Vector.<GroupEntity>;
		static public var myGroups:Vector.<GroupEntity> = new Vector.<GroupEntity>;
		
		static public var sellItems:Vector.<SellItemEntity> = new Vector.<SellItemEntity>;
		static public var mySellItems:Vector.<SellItemEntity> = new Vector.<SellItemEntity>;
		
		static public var businesses:Vector.<BusinessEntity>= new Vector.<BusinessEntity>;
		static public var lostAndFound:Vector.<LostAndFoundEntity>= new Vector.<LostAndFoundEntity>;
		
		
		static public function getOwnedEntity(type:String):Array
		{
			return _ownedDictionary[type];
		}
		
		static public function addOwnedEntity(item:Entity):void 
		{
			if (!_ownedDictionary[item.type])
			{
				_ownedDictionary[item.type] = new Array();

			}
			_ownedDictionary[item.type].push(item);
		}
	}

}