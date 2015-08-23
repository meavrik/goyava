package 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Flox;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.core.PopUpManager;
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
			_settingsButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.TIME_ICONS, 14));
			_settingsButton.addEventListener(Event.TRIGGERED, onSettingsClick);
			_settingsButton.styleName = Button.ALTERNATE_NAME_QUIET_BUTTON
			addChild(_settingsButton);
		}
		
		private function onSettingsClick(e:Event):void 
		{
			_loginPanel = new LoginPanel();
			PopUpManager.addPopUp(_loginPanel);
		}
		
		private function onLangChange(e:Event):void 
		{
			Flox.logInfo("onLangChange : " + _langPicker.selectedItem.code);
			UserGlobal.userPlayer.locale = _langPicker.selectedItem.code;
			UserGlobal.userPlayer.save(null, null);
			
			MainApp.getInstance().initNewPlayer();
		}
		
		override public function dispose():void 
		{
			if (_loginPanel)
			{
				PopUpManager.removePopUp(_loginPanel);
				_loginPanel.removeFromParent(true);
				_loginPanel = null;
			}
			
			_langPicker.removeFromParent(true);
			_settingsButton.removeFromParent(true);
			super.dispose();
		}
		
	}

}