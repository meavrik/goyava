package
{
	import assets.AssetsHelper;
	import com.gamua.flox.Access;
	import com.gamua.flox.AuthenticationType;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import controllers.ErrorController;
	import entities.LocaleEntity;
	import externalServices.ExternalServicesManager;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.events.UncaughtErrorEvent;
	import locale.LocaleCodeEnum;
	import localStorage.LocalStorageController;
	import starling.display.Sprite;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import users.FloxPlayer;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Application extends Sprite
	{
		private var _currentScreen:Screen;
		private var _loadingLabel:Label;
		private var _localeEntity:LocaleEntity;
		
		public function Application()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init()
		}
		
		private function init():void
		{
			this.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
			new MetalWorksMobileTheme(false);
			
			_loadingLabel = new Label();
			_loadingLabel.text = "Loading...";
			_loadingLabel.addEventListener(FeathersEventType.CREATION_COMPLETE, onLoadingLabelCreationComplete);
			_loadingLabel.styleName = Label.ALTERNATE_STYLE_NAME_HEADING;
			
			addChild(_loadingLabel);
			
			ExternalServicesManager.getInstance().init();
			AssetsHelper.getInstance().init();
			login();
		}
		
		private function onUncaughtError(e:UncaughtErrorEvent):void
		{
			ErrorController.showError(this, "onUncaughtError : " + e.error);
		}
		
		private function onLoadingLabelCreationComplete(e:Event):void
		{
			_loadingLabel.move((this.stage.stageWidth - _loadingLabel.width) / 2, (this.stage.stageHeight - _loadingLabel.height) / 2);
		}
		
		private function login():void
		{
			LocalStorageController.getInstance().loadData();
			
			Flox.playerClass = FloxPlayer;
			Flox.init("3wqJNGHv61HPcLrH", "Zkuxm7hSIbumjuGl");
			
			if (LocalStorageController.getInstance().userMail)
			{
				Flox.logEvent("login with mail : " + LocalStorageController.getInstance().userMail);
				Player.loginWithEmail(LocalStorageController.getInstance().userMail, onLoginComplete, onLoginError);
				
			} else
			{
				Flox.logEvent("login with key : " + Player.current.id);
				Player.login(AuthenticationType.KEY, Player.current.id, null, onLoginComplete, onLoginError);
			}
		}
		
		private function onLoginError():void
		{
			_loadingLabel.removeFromParent(true);
			
			ErrorController.showError(this, "login error");
		}
		
		private function onLoginComplete():void
		{
			//_loadingLabel.removeFromParent(true);
			
			addChild(MainApp.getInstance())
			MainApp.getInstance().initNewPlayer();
		}
	
	}

}