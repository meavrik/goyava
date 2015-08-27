package 
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import controllers.ErrorController;
	import entities.LocaleEntity;
	import feathers.controls.ProgressBar;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	import progress.MainProgressBar;
	import starling.events.Event;
	import flash.system.Capabilities;
	import locale.LocaleCodeEnum;
	import popups.PopupsController;
	import starling.core.Starling;
	import starling.display.Sprite;
	import subPanels.QuickMenuList;
	import texts.TextLocaleHandler;
	import users.FloxPlayer;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainApp extends Sprite 
	{
		public var firstTimeUser:Boolean;
		private static var _instance:MainApp = new MainApp();
		
		public static function getInstance():MainApp
		{
			return _instance;
		}
		
		private var _mainScreen:MainScreen;
		private var _progressBar:MainProgressBar;
		
		public function MainApp() 
		{
			super();
		}
		
		public function refreshApp():void 
		{
			Starling.juggler.purge();
			
			PopupsController.removeCurrentPopup(true);

			if (_mainScreen)
			{
				_mainScreen.removeFromParent();
				//_mainScreen = null;
			}
			
			initNewPlayer()
		}
		
		public function initNewPlayer():void
		{
			Flox.logInfo("login player success " + Player.current);
			UserGlobal.userPlayer = Player.current as FloxPlayer;
			
			_progressBar = new MainProgressBar();
			addChild(_progressBar);
			
			loadUserData();
		}
		
		public function openQuickList():void 
		{
			var quickMenu:QuickMenuList = new QuickMenuList();
			addChild(quickMenu);
		}
		
		private function loadUserData():void 
		{
			_progressBar.value = 10;
			
			Entity.load(FloxPlayer, UserGlobal.userPlayer.id, onUserDataLoadComplete, onUserDataLoadError)
		}
		
		private function onUserDataLoadError(message:String):void 
		{
			Flox.logInfo("User Data Load Error or empty:" + message);
			if (message == "unknown")
			{
				Flox.logInfo("new user");
				firstTimeUser = true;
			} else
			{
				Flox.logError(this, "onUserDataLoadError & not new user");
			}
			
			loadLocaleTexts();
			
			//UserGlobal.userPlayer.refresh(onRefreshComplete, onRefreshFail);
		}
		
		private function onUserDataLoadComplete(playerData:FloxPlayer):void 
		{
			Flox.logInfo("onUserDataLoadComplete " + playerData.locale);
			
			//UserGlobal.userPlayer.refresh(onRefreshComplete, onRefreshFail);
			_progressBar.value = 50;
			loadLocaleTexts();
		}
		
		/*private function onRefreshFail():void 
		{
			loadLocaleTexts();
		}
		
		private function onRefreshComplete():void 
		{
			if (!UserGlobal.isAdmin)
			{
				TextLocaleHandler.textsEntity = new LocaleEntity();
			}
			loadLocaleTexts();
		}*/
		
		private function loadLocaleTexts():void
		{
			if (!UserGlobal.userPlayer.locale)
			{
				Flox.logInfo("LANG DETECTED : " + Capabilities.language);
				
				//UserGlobal.userPlayer.locale = Capabilities.language;
				UserGlobal.userPlayer.locale = LocaleCodeEnum.ENGLISH;
				UserGlobal.userPlayer.save(null, null);
			}
			
			//var localeEntity:LocaleEntity = new LocaleEntity();
			//localeEntity.id = "localeTexts";
			//localeEntity.ownerId = UserGlobal.userPlayer.id;
			//localeEntity.publicAccess = Access.READ;
			
			if (!TextLocaleHandler.textsEntity)
			{
				TextLocaleHandler.textsEntity = new LocaleEntity();
				TextLocaleHandler.textsEntity.id = "localeTexts";
				TextLocaleHandler.textsEntity.ownerId = UserGlobal.userPlayer.id;
				TextLocaleHandler.textsEntity.publicAccess = Access.READ;
			}
			Entity.load(LocaleEntity, TextLocaleHandler.textsEntity.id, onLocaleLoadComplete, onLocaleLoadError);
			//_localeEntity.save(null, null);
			//Entity.load(LocaleEntity, TextLocaleHandler.textsEntity.id, onLocaleLoadComplete, onLocaleLoadError);
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
			_progressBar.value = 100
			
			Starling.juggler.delayCall(startApp, 0.1);
		}
		
		private function removeProgressBar():void
		{
			if (_progressBar)
			{
				_progressBar.removeFromParent(true);
				_progressBar = null;
			}
		}
		
		private function startApp():void
		{
			//_loadingLabel.removeFromParent(true);
			
			removeProgressBar()
			
			if (_mainScreen)
			{
				_mainScreen.removeFromParent();
				//_mainScreen = null;
			}
			
			_mainScreen = new MainScreen();
			addChild(_mainScreen);
		}
		
	}

}