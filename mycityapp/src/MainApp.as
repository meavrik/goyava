package 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import data.GlobalDataProvider;
	import entities.CommonDataEntity;
	import entities.MessageEntity;
	import panels.LoginPanel;
	import popups.PopupsController;
	import progress.MainProgressBar;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import users.FloxPlayer;
	
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
		
		private var _mainScreenNavigator:MainScreenNavigator;
		private var _progressBar:MainProgressBar;
		private var _noConnection:Boolean;
		private var _loginPanel:LoginPanel;
		
		public function MainApp() 
		{
			super();
		}
		
		public function refreshApp():void 
		{
			Starling.juggler.purge();
			
			PopupsController.removeCurrentPopup(true);

			if (_mainScreenNavigator)
			{
				_mainScreenNavigator.removeFromParent();
			}
			
			initNewPlayer()
		}
		
		public function initNewPlayer():void
		{
			_loginPanel = new LoginPanel()
			Flox.logInfo("login player success " + Player.current);
			GlobalDataProvider.userPlayer = Player.current as FloxPlayer;
			
			_progressBar = new MainProgressBar();
			_progressBar.height = 5;
			addChild(_progressBar);
			
			loadGlobalData();
		}
		
		private function loadGlobalData():void
		{
			//Entity.load(ResidentsEntity, GlobalDataProvider.residentsDataProvier.id, onLoadResidentsComplete, onLoadResidentsFail);
			Entity.load(CommonDataEntity, GlobalDataProvider.commonEntity.id, onLoadCommonComplete, onLoadCommonFail);
		}
		
		public function onLoadCommonFail(message:String):void 
		{
			Flox.logError("Load common data Fail " + message);

			loadUserData();
		}
		
		public function onLoadCommonComplete(entity:CommonDataEntity):void 
		{
			Flox.logInfo("Load Common Complete ");
			
			//GlobalDataProvider.residentsDataProvier.itemsArr = entity.itemsArr;
			GlobalDataProvider.commonEntity = entity;
			
			loadUserData();
		}
		
		private function loadUserData():void 
		{
			_progressBar.value = 50;
			
			Entity.load(FloxPlayer, GlobalDataProvider.userPlayer.id, onUserDataLoadComplete, onUserDataLoadError)
			//Entity.load(MessageEntity, GlobalDataProvider.userPlayer.id, onMessagesDataLoadComplete, onUserDataLoadError)
		}
		
		private function onMessagesDataLoadComplete(data:MessageEntity):void 
		{
			
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
				_noConnection = true;
				Flox.logError(this, "onUserDataLoadError & not new user");
			}
		}
		
		private function onUserDataLoadComplete(playerData:FloxPlayer):void 
		{
			Flox.logInfo("load User Data Complete " + playerData.name);
			GlobalDataProvider.userPlayer = playerData;
			alldataLoadComplete();
		}
		
		private function showLoginPanel():void 
		{
			_loginPanel.addEventListener(Event.COMPLETE, onLoginComplete);
			PopupsController.addPopUp(_loginPanel);
		}
		
		private function alldataLoadComplete():void
		{
			_progressBar.addEventListener(Event.COMPLETE, onProgressComplete);
			//_progressBar.doComplete();
			_progressBar.value = 100;
		}
		
		private function onProgressComplete(e:Event):void 
		{
			dispatchEvent(new Event(Event.READY));
			//startApp()
			
			if (!GlobalDataProvider.userPlayer.name)
			{
				showLoginPanel();
			} else
			{
				startApp()
			}
		}
		
		private function onLoginComplete(e:Event):void 
		{
			_loginPanel.removeEventListener(Event.COMPLETE, onLoginComplete);
			_loginPanel.removeFromParent(true);
			_loginPanel = null;
			startApp()
		}
		
		private function removeProgressBar():void
		{
			if (_progressBar)
			{
				_progressBar.removeEventListeners();
				_progressBar.removeFromParent(true);
				_progressBar = null;
			}
		}
		
		private function startApp():void
		{
			removeProgressBar()
			
			if (_mainScreenNavigator)
			{
				_mainScreenNavigator.removeFromParent();
			}
			
			_mainScreenNavigator = new MainScreenNavigator();
			addChild(_mainScreenNavigator);
		}
		
	}

}