package data 
{
	import com.gamua.flox.Query;
	import entities.BusinessEntity;
	import entities.CommonEntity;
	import entities.ProfessionEntity;
	import flash.utils.Dictionary;
	import log.Logger;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class AppDataLoader extends EventDispatcher 
	{
		[Embed(source = "../../bin/xml/appData.xml", mimeType = "application/octet-stream")]
		private var AppDataXML:Class;
		
		
		
		private var _dataDictionary:Dictionary = new Dictionary();
		
		
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
			//updateDataFromXml()
		}


		public function loadEntityData(entity:Class, onComplete:Function = null, constraints:String = null,limit:int=20):void
		{
			var query:Query = new Query(entity, constraints);
			query.find(onComplete, onLoadDataError);
			query.limit = limit;
		}
		
		
		private function onLoadDataError(error:String):void 
		{
			Logger.logError(this, "error getting data : " + error);
		}
		
		
		

		private function updateDataFromXml():void
		{
			Logger.logInfo("!! updateDataFromXml!! ");
			var xmlData:XML = XML(new AppDataXML());

			for each (var businessItem:Object in xmlData.business) 
			{
				addNewDataToEntity(businessItem,BusinessEntity);
			}
			
			for each (var professionItem:Object in xmlData.profession) 
			{
				addNewDataToEntity(professionItem, ProfessionEntity);
			}
		}
		
		private function addNewDataToEntity(data:Object,EntityClass:Class):void 
		{
			var entity:CommonEntity = new EntityClass();
			entity.generate(data);
			
			var exist:Boolean;
			for each (var item:CommonEntity in GlobalDataProvider.businesses) 
			{
				if (item.name == entity.name) 
				{
					entity.id = item.id;
					exist = true;
				};
			}
			
			if (exist)
			{
				entity.refresh(null, null);
			} else
			{
				trace("ADD NEW " + entity.type + " |  " + entity.name);
				entity.save(null,null);
			}
			
		}
		
		
	}

}