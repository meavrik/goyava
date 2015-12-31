package controllers.localStorage 
{
	import com.gamua.flox.Flox;
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Avrik
	 */
	public class LocalStorageController 
	{
		private static var _instance:LocalStorageController = new LocalStorageController();
		
		public static function getInstance():LocalStorageController
		{
			return _instance;
		}
		
		private var _userLoginToken:String;
		private var _userMail:String;
		
		public function LocalStorageController() 
		{
			
		}
		
		public function loadData():void 
		{
			var storedValue:ByteArray = EncryptedLocalStore.getItem("myData");
			if (storedValue)
			{
				loadGlobalObjectData(storedValue.readObject());
			} else
			{
				//LoggerHandler.Instance.error(this, "loadGlobalData error");
				Flox.logError(this, "load user local Data error");
			}
		}
		
		protected function loadGlobalObjectData(object:Object):void
		{
			userLoginToken = object.userLoginToken;
			userMail = object.userMail;
		}
		
		public function saveData():void 
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(saveGlobalObjectData());
			
			EncryptedLocalStore.setItem("myData", bytes);
		}
		
		private function saveGlobalObjectData():Object 
		{
			var result:Object = new Object();
			result.userLoginToken = userLoginToken;
			result.userMail = userMail;
			return result;
		}
		
		public function get userMail():String 
		{
			return _userMail;
		}
		
		public function set userMail(value:String):void 
		{
			_userMail = value;
			saveData();
		}
		
		public function get userLoginToken():String 
		{
			return _userLoginToken;
		}
		
		public function set userLoginToken(value:String):void 
		{
			_userLoginToken = value;
			saveData();
		}
		
	}

}