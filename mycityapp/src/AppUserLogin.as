package 
{
	import com.gamua.flox.AuthenticationType;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Player;
	import controllers.localStorage.LocalStorageController;
	import data.GlobalDataProvider;
	import entities.FloxUser;
	import log.LogEventsEnum;
	import log.Logger;
	import panels.LoginPanel;
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
		
		private var _registerPanel:LoginPanel;
		
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
			/*if (LocalStorageController.getInstance().userMail)
			{
				Flox.logEvent(LogEventsEnum.LOGIN_WITH_MAIL, LocalStorageController.getInstance().userMail);
				Player.loginWithEmail(LocalStorageController.getInstance().userMail, onLoginComplete, onLoginError);
			} 
			else
			{*/
				Logger.logEvent(LogEventsEnum.LOGIN_WITH_KEY, Player.current.id);
				Player.login(AuthenticationType.KEY, Player.current.id , null, onLoginComplete, onLoginError);
		}
		
		private function onLoginError(message:String):void
		{
			Logger.logError(this, "onLoginError : {0}" + message);
			dispatchEventWith(Event.COMPLETE);
		}
		
		private function onLoginComplete(userData:FloxUser):void
		{
			Entity.load(FloxUser, userData.id, onUserDataLoadComplete, onUserDataLoadError)
		}
		
		private function onUserDataLoadError(message:String):void 
		{	
			Logger.logError("onUserDataLoadError : " + message);
			handleNewUser();
		}
		
		private function onUserDataLoadComplete(userData:FloxUser):void 
		{
			GlobalDataProvider.myUserData = userData;
			LocalStorageController.getInstance().userLoginToken = userData.id;
			if (userData.name)
			{
				userIsLoggedIn();
			} else
			{
				handleNewUser();
			}
		}
		
		private function handleNewUser():void 
		{
			registerNewUser();
		}
		
		private function registerNewUser():void 
		{
			_registerPanel = new LoginPanel()
			_registerPanel.addEventListener(Event.COMPLETE, onRegisterComplete);
			PopupsController.addPopUp(_registerPanel);
		}
		
		private function onRegisterComplete(e:Event):void 
		{
			_registerPanel.removeEventListener(Event.COMPLETE, onRegisterComplete);
			_registerPanel.removeFromParent(true);
			_registerPanel = null;
			
			userIsLoggedIn();
		}
		
		private function userIsLoggedIn():void 
		{
			Logger.logInfo("USER IS LOGGED : " + GlobalDataProvider.myUserData.name);
			//startApplication()
			dispatchEventWith(Event.COMPLETE);
		}
		
	}

}