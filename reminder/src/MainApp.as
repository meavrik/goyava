package 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import controllers.ErrorController;
	import entities.LocaleEntity;
	import feathers.core.PopUpManager;
	import locale.LocaleCodeEnum;
	import localStorage.LocalStorageController;
	import starling.display.Sprite;
	import texts.TextLocaleHandler;
	import users.FloxPlayer;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainApp extends Sprite 
	{
		private static var _instance:MainApp = new MainApp();
		
		public static function getInstance():MainApp
		{
			return _instance;
		}
		
		private var _currentScreen:MainScreen;
		
		public function MainApp() 
		{
			super();
			
		}
		
		public function initNewPlayer():void
		{
			if (_currentScreen)
			{
				_currentScreen.removeFromParent(true);
			}
			
			Flox.logInfo("login player success " + Player.current);
			UserGlobal.userPlayer = Player.current as FloxPlayer;
			
			loadUserData();
		}
		
		private function loadUserData():void 
		{
			Entity.load(FloxPlayer, UserGlobal.userPlayer.id, onUserDataLoadComplete, onUserDataLoadError)
		}
		
		private function onUserDataLoadError(message:String):void 
		{
			Flox.logError(this, "on User Data Load Error :" + message);
			loadLocaleTexts();
		}
		
		private function onUserDataLoadComplete(playerData:FloxPlayer):void 
		{
			Flox.logInfo("onUserDataLoadComplete " + playerData.locale);
			if (!playerData.locale)
			{
				playerData.locale = LocaleCodeEnum.ENGLISH;
				playerData.save(null, null);
			}
			UserGlobal.userPlayer.refresh(onRefreshComplete, onRefreshFail);
			
		}
		
		private function onRefreshFail():void 
		{
			loadLocaleTexts();
		}
		
		private function onRefreshComplete():void 
		{
			loadLocaleTexts();
		}
		
		private function loadLocaleTexts():void
		{
			var localeEntity:LocaleEntity = new LocaleEntity();
			localeEntity.id = "texts";
			localeEntity.ownerId = UserGlobal.userPlayer.id;
			localeEntity.publicAccess = Access.READ_WRITE;
			Entity.load(LocaleEntity, localeEntity.id, onLocaleLoadComplete, onLocaleLoadError);
			//_localeEntity.save(null, null);
		}
		
		private function onLocaleLoadError(message:String):void
		{
			ErrorController.showError(this, "on Locale Load Error :" + message);
			startApp();
		}
		
		private function onLocaleLoadComplete(entity:LocaleEntity):void
		{
			Flox.logInfo("on Locale Load Complete ");
			TextLocaleHandler.textsEntity = entity;

			startApp();
		}
		
		private function startApp():void
		{
			//_loadingLabel.removeFromParent(true);
			
			
			_currentScreen = new MainScreen();
			addChild(_currentScreen);
		}
		
	}

}