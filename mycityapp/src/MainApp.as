package 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import entities.ResidentsEntity;
	import panels.LoginPanel;
	import popups.PopupsController;
	import progress.MainProgressBar;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
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

			if (_mainScreen)
			{
				_mainScreen.removeFromParent();
			}
			
			initNewPlayer()
		}
		
		public function initNewPlayer():void
		{
			_loginPanel = new LoginPanel()
			Flox.logInfo("login player success " + Player.current);
			UserGlobal.userPlayer = Player.current as FloxPlayer;
			UserGlobal.residents = new ResidentsEntity();
			UserGlobal.residents.id = "residents";
			
			_progressBar = new MainProgressBar();
			addChild(_progressBar);
			
			loadUserData();
		}
		
		public function openQuickList():void 
		{
			//var quickMenu:QuickMenuList = new QuickMenuList();
			//addChild(quickMenu);
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
				_noConnection = true;
				Flox.logError(this, "onUserDataLoadError & not new user");
			}
			
			
			
			//UserGlobal.userPlayer.refresh(onRefreshComplete, onRefreshFail);
		}
		
		private function onUserDataLoadComplete(playerData:FloxPlayer):void 
		{
			Flox.logInfo("onUserDataLoadComplete " + playerData.name);
			
			_progressBar.value = 100;
			if (!playerData.name)
			{
				_loginPanel.addEventListener(Event.COMPLETE, onLoginComplete);
				PopupsController.addPopUp(_loginPanel);
			}else
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
				_progressBar.removeFromParent(true);
				_progressBar = null;
			}
		}
		
		private function startApp():void
		{
			removeProgressBar()
			
			if (_mainScreen)
			{
				_mainScreen.removeFromParent();
			}
			
			_mainScreen = new MainScreen();
			addChild(_mainScreen);
		}
		
	}

}