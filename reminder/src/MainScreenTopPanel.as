package 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Flox;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import popups.PopupsController;
	import starling.display.Image;
	import starling.events.Event;
	import subPanels.LanguagePicker;
	import subPanels.LoginPanel;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainScreenTopPanel extends Header 
	{
		private var _langPicker:LanguagePicker;
		private var _settingsButton:Button;
		private var _loginPanel:LoginPanel;
		
		public function MainScreenTopPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, 100);
			
			_langPicker = new LanguagePicker();
			//_langPicker.x = 10;
			_langPicker.addEventListener(Event.CHANGE, onLangChange);
			addChild(_langPicker);
			
			_settingsButton = new Button();
			_settingsButton.setSize(60, 100);
			
			_settingsButton.x = this.stage.stageWidth - 60;
			_settingsButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS,2));
			_settingsButton.addEventListener(Event.TRIGGERED, onSettingsClick);
			_settingsButton.styleName = Button.ALTERNATE_NAME_QUIET_BUTTON
			addChild(_settingsButton);
		}
		
		private function onSettingsClick(e:Event):void 
		{
			removeLogin();
			_loginPanel = new LoginPanel();
			PopupsController.addPopUp(new LoginPanel());
		}
		
		private function onLangChange(e:Event):void 
		{
			Flox.logInfo("onLangChange : " + _langPicker.selectedItem.code);
			UserGlobal.userPlayer.locale = _langPicker.selectedItem.code;
			UserGlobal.userPlayer.save(null, null);
			
			removeFromParent(true);
			MainApp.getInstance().refreshApp();
		}
		
		private function removeLogin():void
		{
			if (_loginPanel)
			{
				PopupsController.removePopUp(_loginPanel);
				_loginPanel.removeFromParent(true);
				_loginPanel = null;
			}
		}
		
		override public function dispose():void 
		{
			removeLogin();
			
			_langPicker.removeEventListeners();
			_langPicker.removeFromParent(true);
			_langPicker = null;
			_settingsButton.removeFromParent(true);
			_settingsButton = null;
			super.dispose();
		}
		
	}

}