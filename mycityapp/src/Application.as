package
{

	import assets.AssetsHelper;
	import com.gamua.flox.AuthenticationType;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import controllers.ErrorController;
	import data.GlobalDataProvider;
	import feathers.controls.Label;
	import feathers.events.FeathersEventType;
	import feathers.themes.AzurePpgMobileTheme;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.ui.Keyboard;
	import log.LogEventsEnum;
	import popups.PopupsController;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.UiGenerator;
	import users.FloxPlayer;

	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Application extends Sprite
	{
		static public const FLOX_APP_ID:String = "YSJdgJbmT54ceXsp";
		static public const FLOX_APP_KEY:String = "VjSZWf1qGq5mlb9P";
		static public const HERO_LOGIN_KEY:String = "kYWB9PVebJzgOS0O";
		static public const GAME_VERSION:String = "1.0";
		
		private var _loadingLabel:Label;
		static public var noConnection:Boolean;
		
		public function Application()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			init()
		}
		
		private function init():void
		{
			new MetalWorksMobileTheme(false);
			
			_loadingLabel = new Label();
			_loadingLabel.text = "Loading...";
			_loadingLabel.addEventListener(FeathersEventType.CREATION_COMPLETE, onLoadingLabelCreationComplete);
			_loadingLabel.styleName = Label.ALTERNATE_STYLE_NAME_HEADING;
			
			/*addChild(_loadingLabel);
			
			ExternalServicesManager.getInstance().init();
			LocalStorageController.getInstance().loadData();*/
			AssetsHelper.getInstance().init();
			UiGenerator.getInstance().init(this.stage);
			Flox.playerClass = FloxPlayer;
			Flox.init(FLOX_APP_ID, FLOX_APP_KEY, GAME_VERSION);
			
			//loginHero();
			loginUser();
		}
		
		private function onKeyPress(event:KeyboardEvent):void 
		{
			switch (event.keyCode) 
			{ 
				case Keyboard.BACK: 
					event.preventDefault();
					
					if (PopupsController.currentPopup)
					{
						PopupsController.removeCurrentPopup();
					} else
					{
						//PopupsController.addPopUp(new ExitAppPanel());
						NativeApplication.nativeApplication.exit();
					}
					
					break; 
				case Keyboard.MENU: 
					/*if (NativeApplication.supportsMenu)
					{
						var menu:NativeMenu = new NativeMenu();
						menu.addItem(new NativeMenuItem("settings"));
						NativeApplication.nativeApplication.menu = menu;
						menu.display(Starling.current.nativeStage, 0, 0);
					}*/
					MainApp.getInstance().openQuickList();
					break; 
				case Keyboard.SEARCH: 
					break; 
			}
		}
		
		private function onUncaughtError(e:UncaughtErrorEvent):void
		{
			ErrorController.showError(this, "onUncaughtError : " + e.error);
		}
		
		private function onLoadingLabelCreationComplete(e:Event):void
		{
			_loadingLabel.move((this.stage.stageWidth - _loadingLabel.width) / 2, (this.stage.stageHeight - _loadingLabel.height) / 2);
		}
		
		private function loginHero():void
		{
			if (CONFIG::debug == true) {
				Flox.logInfo("login with admin hero : ");
				GlobalDataProvider.userPlayer.isAdmin = true;
				Player.loginWithKey(HERO_LOGIN_KEY, onHeroLoginComplete, onLoginError);
			} else
			{
				startApplication();
			}
		}
		
		private function loginUser():void
		{
			/*if (LocalStorageController.getInstance().userMail)
			{
				Flox.logEvent(LogEventsEnum.LOGIN_WITH_MAIL, LocalStorageController.getInstance().userMail);
				Player.loginWithEmail(LocalStorageController.getInstance().userMail, onLoginComplete, onLoginError);
			} 
			else
			{*/
				Flox.logEvent(LogEventsEnum.LOGIN_WITH_KEY, Player.current.id);
				Player.login(AuthenticationType.KEY, Player.current.id, null, onLoginComplete, onLoginError);
			//}
		}
		
		private function onLoginError(message:String):void
		{
			_loadingLabel.removeFromParent(true);
			
			Flox.logError(this, "onLoginError : {0}" + message);
			noConnection = true;
			
			startApplication();
		}
		
		private function onHeroLoginComplete():void 
		{
			//LocaleManager.getInstance().addEventListener(LocaleManager.SAVE_TEXTS_COMPLETE, onSaveLocaleTextsComplete);
			//LocaleManager.getInstance().addEventListener(LocaleManager.SAVE_TEXTS_ERROR, onSaveLocaleTextsComplete);
			//LocaleManager.getInstance().saveLocaleTexts();
			loginUser()
		}
		
		/*private function onSaveLocaleTextsComplete(e:Event):void 
		{
			LocaleManager.getInstance().removeEventListener(LocaleManager.SAVE_TEXTS_COMPLETE, onSaveLocaleTextsComplete);
			LocaleManager.getInstance().removeEventListener(LocaleManager.SAVE_TEXTS_ERROR, onSaveLocaleTextsComplete);
			loginUser()
		}*/
		
		private function onLoginComplete():void
		{
			startApplication()
		}
		
		private function startApplication():void
		{
			_loadingLabel.removeFromParent(true);
			addChild(MainApp.getInstance())
			MainApp.getInstance().initNewPlayer();
		}
	
	}

}