package
{
	import assets.AssetsHelper;
	import com.gamua.flox.Flox;
	import controllers.ErrorController;
	import controllers.localStorage.LocalStorageController;
	import data.AppDataLoader;
	import entities.FloxUser;
	import events.GlobalEventController;
	import feathers.controls.Label;
	import feathers.themes.FlatThemeGlober;
	import feathers.themes.TopcoatLightMobileTheme;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.KeyboardEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.ui.Keyboard;
	import log.Logger;
	import panels.RegisterPanel;
	import popups.PopupsController;
	import progress.MainProgressBar;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	public class AppEntry extends Sprite
	{
		[Embed(source = "../icons/ios/Default-568h@2x.png")]
		private static var background:Class
		
		private var _backgroundImg:Image;
	
		static public const FLOX_APP_ID:String = "YSJdgJbmT54ceXsp";
		static public const FLOX_APP_KEY:String = "VjSZWf1qGq5mlb9P";
		
		static public const GAME_VERSION:String = "1.0";
		
		//private var _loadingLabel:Label;
		private var _userLogin:AppUserLogin;
		private var _progressBar:MainProgressBar;
		private var _mainApp:AppMain;
		private var _registerPanel:RegisterPanel;
		
		static public var noConnection:Boolean;
		
		public function AppEntry()
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
			addBG();
			
			//new MetalWorksMobileTheme(false);
			//new FlatThemeGlober(false);
			new TopcoatLightMobileTheme(false);
			//new FlatThemeBariol(false);
			
			/*_loadingLabel = new Label();
			_loadingLabel.text = "Loading...";
			_loadingLabel.addEventListener(FeathersEventType.CREATION_COMPLETE, onLoadingLabelCreationComplete);
			_loadingLabel.styleName = Label.ALTERNATE_STYLE_NAME_HEADING;
			
			addChild(_loadingLabel);*/
			
			/*ExternalServicesManager.getInstance().init();
			LocalStorageController.getInstance().loadData();*/
			
			
			GlobalEventController.getInstance().addEventListener(GlobalEventController.RELOAD_APP, onAppReload);
			AssetsHelper.getInstance().init();
			UiGenerator.getInstance().init(this.stage);
			LocalStorageController.getInstance().loadData();
			
			Flox.playerClass = FloxUser;
			Flox.init(FLOX_APP_ID, FLOX_APP_KEY, GAME_VERSION);
			
			_progressBar = new MainProgressBar();
			//_progressBar.height = 5;
			addChild(_progressBar);
			_progressBar.value = 1;
			
			_userLogin = new AppUserLogin();
			_userLogin.addEventListener(Event.COMPLETE, onLoginUserComplete);
			_userLogin.loginUser();
			//_userLogin.loginHero();
			
			_progressBar.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void 
		{
			if (_progressBar.value < 99)
			{
				_progressBar.value++;
			}
			
		}
		
		private function onAppReload(e:Event):void 
		{
			//startApplication();
			setNewMainApp(true);
		}
		
		private function removeBg():void
		{
			if (_backgroundImg)
			{
				_backgroundImg.removeFromParent(true);
				_backgroundImg = null;
			}
		}
		
		private function addBG():void
		{
			var bitmap:Bitmap = new background();
			bitmap.smoothing = true;
			_backgroundImg = new Image(Texture.fromBitmap(bitmap));
			var factor:Number = Math.min(stage.stageWidth / _backgroundImg.width, stage.stageHeight / _backgroundImg.height);

			//_backgroundImg.width = stage.stageWidth;
			//_backgroundImg.height = stage.stageHeight;
			
			_backgroundImg.scaleX = _backgroundImg.scaleY = factor;
			_backgroundImg.x = (stage.stageWidth - _backgroundImg.width) / 2;
			addChild(_backgroundImg);
		}
		
		private function onLoginUserComplete(e:Event):void 
		{
			_progressBar.value = 100;
			Starling.juggler.delayCall(startApplication, .2);
		}
		
		private function onUncaughtError(e:UncaughtErrorEvent):void
		{
			ErrorController.showError(this, "onUncaughtError : " + e.error);
		}
		
		private function startApplication(isAdmin:Boolean=false):void
		{
			removeProgressBar();
			removeBg();
			
			//AppDataLoader.getInstance().loadUsersData();
			//AppDataLoader.getInstance().loadGroupsData();
			//AppDataLoader.getInstance().loadSellItemsData();
			AppDataLoader.getInstance().loadCommonData();
			AppDataLoader.getInstance().loadMyMessagesData();
			
			setNewMainApp(_userLogin.isNewUser);
		}
		
		private function setNewMainApp(newUser:Boolean):void
		{
			if (_mainApp)
			{
				_mainApp.removeFromParent(true);
				_mainApp = null;
			}
			
			_mainApp = new AppMain(newUser);
			addChild(_mainApp);
			_mainApp.init();
		}
		/*private function onAppReady(e:Event):void 
		{
			AppMain.getInstance().removeEventListener(Event.READY, onAppReady);
			
			_backgroundImg.removeFromParent(true);
		}*/
		
		
		private function registerNewUser():void 
		{
			Logger.logInfo(" -- registerNewUser --");
			_registerPanel = new RegisterPanel()
			_registerPanel.addEventListener(Event.COMPLETE, onRegisterComplete);
			PopupsController.addPopUp(_registerPanel);
		}
		
		private function onRegisterComplete(e:Event):void 
		{
			_registerPanel.removeEventListener(Event.COMPLETE, onRegisterComplete);
			_registerPanel.removeFromParent(true);
			_registerPanel = null;
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
					//MainApp.getInstance().openQuickList();
					break; 
				case Keyboard.SEARCH: 
					break; 
			}
		}
	
	}

}