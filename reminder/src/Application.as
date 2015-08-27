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
	import feathers.events.FeathersEventType;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.UncaughtErrorEvent;
	import flash.ui.Keyboard;
	import locale.LocaleCodeEnum;
	import localStorage.LocalStorageController;
	import log.LogEventsEnum;
	import popups.PopupsController;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.events.KeyboardEvent;
	import subPanels.ExitAppPanel;
	import texts.TextLocaleHandler;
	import users.FloxPlayer;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Application extends Sprite
	{
		static public const FLOX_APP_ID:String = "3wqJNGHv61HPcLrH";
		static public const FLOX_APP_KEY:String = "Zkuxm7hSIbumjuGl";
		static public const HERO_LOGIN_KEY:String = "in4F7SmQmHfqdTdg";
		
		[Embed(source = "../bin/locale.xml", mimeType = "application/octet-stream")]
		private var localeXmlData:Class
		private var _loadingLabel:Label;
		
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
			
			addChild(_loadingLabel);
			
			ExternalServicesManager.getInstance().init();
			LocalStorageController.getInstance().loadData();
			AssetsHelper.getInstance().init();
			
			Flox.playerClass = FloxPlayer;
			Flox.init(FLOX_APP_ID, FLOX_APP_KEY);
			
			loginHero();
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
						PopupsController.addPopUp(new ExitAppPanel());
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
				UserGlobal.isAdmin = true;
				Player.loginWithKey(HERO_LOGIN_KEY, onHeroLoginComplete, onLoginError);
			} else
			{
				//startApplication();
				//loginUser();
				
				startApplication();
			}
		}
		
		private function loginUser():void
		{
			if (LocalStorageController.getInstance().userMail)
			{
				Flox.logEvent(LogEventsEnum.LOGIN_WITH_MAIL, LocalStorageController.getInstance().userMail);
				Player.loginWithEmail(LocalStorageController.getInstance().userMail, onLoginComplete, onLoginError);
			} 
			else
			{
				Flox.logEvent(LogEventsEnum.LOGIN_WITH_KEY, Player.current.id);
				Player.login(AuthenticationType.KEY, Player.current.id, null, onLoginComplete, onLoginError);
			}
			//startApplication();
		}
		
		private function onLoginError():void
		{
			_loadingLabel.removeFromParent(true);
			
			ErrorController.showError(this, "login error");
		}
		
		private function onHeroLoginComplete():void 
		{
			saveLocaleTexts();
		}
		
		private function onLoginComplete():void
		{
			startApplication()
		}
		
		private function saveLocaleTexts():void 
		{
			TextLocaleHandler.textsEntity = new LocaleEntity();
			TextLocaleHandler.textsEntity.id = "localeTexts";
			TextLocaleHandler.textsEntity.publicAccess = Access.READ_WRITE;
			TextLocaleHandler.textsEntity.ownerId = Player.current.id;
			
			var xml:XML = XML(new localeXmlData());
			var langObjArr:Array = new Array();
			
			for (var i:int = 0; i < xml.children().length(); i++) 
			{
				var node:XML = xml.children()[i];
				var textTitleName:String = node.name();
				//trace("node = " + textTitleName);
				
				for (var j:int = 0; j < node.attributes().length(); j++) 
				{
					//var langObj:Object = new Object;
					var langName:String=node.attributes()[j].name()
					var text:String = node.attributes()[j]
					
					//trace("lange name = " + langName);
					//trace("text = " + text);
					if (!langObjArr[langName]) langObjArr[langName] = new Object();
					langObjArr[langName][textTitleName] = text;
				}
			}

			TextLocaleHandler.textsEntity.English = langObjArr[LocaleCodeEnum.ENGLISH];
			TextLocaleHandler.textsEntity.Hebrew = langObjArr[LocaleCodeEnum.HEBREW];
			TextLocaleHandler.textsEntity.Spanish = langObjArr[LocaleCodeEnum.SPANISH];
			//TextLocaleHandler.textsEntity.French = langObjArr["fr"];
			TextLocaleHandler.textsEntity.Italian = langObjArr[LocaleCodeEnum.ITALIAN];
			TextLocaleHandler.textsEntity.Russian = langObjArr[LocaleCodeEnum.RUSSIAN];
			TextLocaleHandler.textsEntity.German = langObjArr[LocaleCodeEnum.GERMAN];
			
			TextLocaleHandler.textsEntity.save(onAdminTextsSaveSuccess, onAdminTextsSaveError);
		}
		
		private function onAdminTextsSaveError(message:String):void 
		{
			Flox.logInfo("onAdminTextsSaveError :"+message);
			//startApplication()
			
			loginUser()
		}
		private function onAdminTextsSaveSuccess():void 
		{
			Flox.logInfo("onAdminTextsSaveSuccess ");
			//startApplication()
			
			loginUser()
		}
		
		private function startApplication():void
		{
			_loadingLabel.removeFromParent(true);
			addChild(MainApp.getInstance())
			MainApp.getInstance().initNewPlayer();
		}
	
	}

}