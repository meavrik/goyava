package data 
{
	import com.gamua.flox.Query;
	import entities.BusinessEntity;
	import entities.FloxUser;
	import entities.GroupEntity;
	import entities.MessageEntity;
	import entities.SellItemEntity;
	import log.Logger;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class AppDataLoader extends EventDispatcher 
	{
		[Embed(source = "../../bin/xml/businessData.xml", mimeType = "application/octet-stream")]
		private var BusinessXML:Class;
		
		
		
		static public const GROUPS_DATA_LOADED:String = "groupsDataLoaded";
		static public const MY_MESSAGES_LOADED:String = "myMessagesLoaded";
		static public const SELLITEMS_DATA_LOADED:String = "sellitemsDataLoaded";
		static public const USERS_DATA_LOADED:String = "usersDataLoaded";
		static public const BUSINESS_DATA_LOADED:String = "businessDataLoaded";
		
		private static var _instance:AppDataLoader = new AppDataLoader();
		public function AppDataLoader() 
		{
			super();
			
		}
		
		public static function getInstance():AppDataLoader
		{
			return _instance;
		}
		
		
		public function loadCommonData():void
		{
			loadGroupsData();
			loadUsersData();
			loadSellItemsData();
			loadBusinessData();
		}
		
		public function loadBusinessData():void 
		{
			var query:Query = new Query(BusinessEntity);
			query.find(onBusinessLoadComplete, onLoadDataError);
		}
		
		private function onLoadDataError(error:String):void 
		{
			Logger.logError(this, "error getting data : " + error);
		}
		
		private function onBusinessLoadComplete(businesses:Array):void 
		{
			Logger.logInfo("business found : {0}", businesses);
			
			GlobalDataProvider.businesses = new Vector.<BusinessEntity>;

			for each (var item:BusinessEntity in businesses) 
			{
				if (item.name && item.id)
				{
					GlobalDataProvider.businesses.push(item);
				}
			}
			
			if (GlobalDataProvider.myUserData.isAdmin)
			{
				addBusinessesFromXml();
			}
			
			dispatchEventWith(BUSINESS_DATA_LOADED)
		}
		

		private function addBusinessesFromXml():void
		{
			var BusinessData:XML = XML(new BusinessXML());
			
			for (var i:int = 0; i < BusinessData.business.length(); i++) 
			{
				addNewBusiness(BusinessData.business[i]);
			}
		}
		
		private function addNewBusiness(data:Object):void 
		{
			var buisness:BusinessEntity = new BusinessEntity(data);
			var exist:Boolean;
			for each (var item:BusinessEntity in GlobalDataProvider.businesses) 
			{
				if (item.name == buisness.name) 
				{
					buisness.id = item.id;
					exist = true;
				};
			}
			if (exist)
			{
				buisness.refresh(null, null);
			} else
			{
				buisness.save(null,null);
			}
			
		}
		
		
		
		
		public function loadUsersData():void 
		{
			var query:Query = new Query(FloxUser);
			query.find(onUsersLoadComplete, onLoadDataError);
		}
		
		private function onUsersLoadComplete(users:Array):void 
		{
			Logger.logInfo("users found : {0}", users);
			
			GlobalDataProvider.users = new Vector.<FloxUser>;
			for each (var item:FloxUser in users) 
			{
				if (item.name && item.id)
				{
					GlobalDataProvider.users.push(item);
				}
			}
			
			dispatchEventWith(USERS_DATA_LOADED)
		}
		
		
		
		
		
		public function loadGroupsData():void 
		{
			var query:Query = new Query(GroupEntity);
			query.find(onGroupsLoadComplete,onLoadDataError);
		}
		
		private function onGroupsLoadComplete(groups:Array):void 
		{
			Logger.logInfo("groups found : {0}", groups);
			
			GlobalDataProvider.groups = new Vector.<GroupEntity>;
			GlobalDataProvider.myGroups = new Vector.<GroupEntity>;
			for each (var item:GroupEntity in groups) 
			{
				if (item.name && item.id)
				{
					GlobalDataProvider.groups.push(item);
					if (item.ownerId == GlobalDataProvider.myUserData.id)
					{
						GlobalDataProvider.myGroups.push(item);
					}
				}
			}
			
			dispatchEventWith(GROUPS_DATA_LOADED)
		}
		
		
		
		public function loadSellItemsData():void 
		{
			var query:Query = new Query(SellItemEntity);
			query.find(onSellItemsLoadComplete,onLoadDataError);
		}
		
		private function onSellItemsLoadComplete(sellItems:Array):void 
		{
			Logger.logInfo("sellItems found : {0}", sellItems);
			GlobalDataProvider.sellItems = new Vector.<SellItemEntity>;
			GlobalDataProvider.mySellItems = new Vector.<SellItemEntity>;
			
			for each (var item:SellItemEntity in sellItems) 
			{
				if (item.name && item.id)
				{
					GlobalDataProvider.sellItems.push(item);
					if (item.ownerId == GlobalDataProvider.myUserData.ownerId)
					{
						GlobalDataProvider.mySellItems.push(item);
					}
				}
			}
			
			dispatchEventWith(SELLITEMS_DATA_LOADED)
		}
		
		public function loadMyMessagesData():void 
		{
			var query:Query = new Query(MessageEntity, "toUserId == ?", GlobalDataProvider.myUserData.id);
			query.find(onMessagesComplete, onLoadDataError);
		}
		
		private function onMessagesComplete(messages:Array):void 
		{
			Logger.logInfo("messages found : {0}", messages);
			
			GlobalDataProvider.myMessages = messages;
			dispatchEventWith(MY_MESSAGES_LOADED)
		}
		
		private function existInArr(item:*,arr:*):Boolean
		{
			for each (var itemInArr:SellItemEntity in arr) 
			{
				if (item.id == itemInArr.id)
				{
					return true;
				}
			}
			
			return false;
		}
		
	}

}