package 
{
	import com.gamua.flox.AuthenticationType;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import controllers.localStorage.LocalStorageController;
	import data.GlobalDataProvider;
	import entities.FloxUser;
	import flash.events.ErrorEvent;
	import log.LogEventsEnum;
	import log.Logger;
	import panels.RegisterPanel;
	import popups.PopupsController;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Avrik
	 */
	public class AppUserLogin extends EventDispatcher
	{
		static public const HERO_LOGIN_KEY:String = "kYWB9PVebJzgOS0O";
		static public const LOGIN_ERROR:String = "loginError";
		public var isNewUser:Boolean;
		
		private var _registerPanel:RegisterPanel;
		
		public function AppUserLogin() 
		{
			
		}
		
		public function loginHero():void
		{
			Logger.logInfo("login with admin hero : ");
			Player.loginWithKey(HERO_LOGIN_KEY, onHeroLoginComplete, onLoginError);
		}
		
		private function onHeroLoginComplete(userData:FloxUser):void 
		{
			userData.isAdmin = true;
			GlobalDataProvider.myUserData = userData;
			Logger.logInfo("HERO LOGGED IN : " + userData);
			//dispatchEventWith(Event.COMPLETE);
			
			userIsLoggedIn()
		}
		
		public function loginUser():void
		{
			//trace("AAAAAAAAAAA ==== " + LocalStorageController.getInstance().userLoginToken);
			if (LocalStorageController.getInstance().userLoginToken)
			{
				Logger.logEvent(LogEventsEnum.LOGIN_WITH_KEY, LocalStorageController.getInstance().userLoginToken);
				Player.loginWithKey(LocalStorageController.getInstance().userLoginToken, onLoginComplete, onLoginError);
			} 
			else
			{
				Logger.logEvent(LogEventsEnum.LOGIN_WITH_KEY, Player.current.id);
				Player.login(AuthenticationType.KEY, Player.current.id , null, onLoginComplete, onLoginError);
			}
		}
		
		private function onLoginError(message:String):void
		{
			Logger.logError(this, "onLoginError : {0}" + message);
			//dispatchEventWith(ErrorEvent.ERROR);
			dispatchEventWith(LOGIN_ERROR);
		}
		
		private function onLoginComplete(userData:FloxUser):void
		{
			Entity.load(FloxUser, userData.id, onUserDataLoadComplete, onUserDataLoadError)
		}
		
		private function onUserDataLoadError(message:String):void 
		{	
			Logger.logError("onUserDataLoadError : " + message);
			handleNewUser();
			
			userIsLoggedIn();
		}
		
		private function onUserDataLoadComplete(userData:FloxUser):void 
		{
			GlobalDataProvider.myUserData = userData;
			LocalStorageController.getInstance().userLoginToken = userData.id;
			Logger.logInfo("onUserDataLoadComplete name :" + userData.name);
			/*if (userData.name)
			{
				userIsLoggedIn();
			} else
			{
				handleNewUser();
			}*/
			if (!userData.name)
			{
				handleNewUser();
			}
			userIsLoggedIn();
		}
		
		private function handleNewUser():void 
		{
			//registerNewUser();
			isNewUser = true;
		}
		
		/*private function registerNewUser():void 
		{
			_registerPanel = new RegisterPanel()
			_registerPanel.addEventListener(Event.COMPLETE, onRegisterComplete);
			PopupsController.addPopUp(_registerPanel);
		}
		
		private function onRegisterComplete(e:Event):void 
		{
			_registerPanel.removeEventListener(Event.COMPLETE, onRegisterComplete);
			_registerPanel.removeFromParent(true);
			_registerPanel = null;
		}*/
		
		private function userIsLoggedIn():void 
		{
			Logger.logInfo("USER IS LOGGED : " + GlobalDataProvider.myUserData.name);
			//startApplication()
			dispatchEventWith(Event.COMPLETE);
		}
		
	}

}