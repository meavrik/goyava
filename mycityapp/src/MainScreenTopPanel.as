package 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainScreenTopPanel extends Header 
	{
		//private var _langPicker:LanguagePicker;
		private var _loginButton:Button;
		//private var _loginPanel:LoginPanel;
		
		public function MainScreenTopPanel() 
		{
			super();
			
		}
		
		/*override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, 100);
			
			_langPicker = new LanguagePicker();
			addChild(_langPicker);
			
			_loginButton = new Button();
			_loginButton.setSize(60, 100);
			_loginButton.x = stage.stageWidth - (_loginButton.width + 10);

			_loginButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS,2));
			_loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			_loginButton.styleName = Button.ALTERNATE_NAME_QUIET_BUTTON
			addChild(_loginButton);
		}
		
		private function onLoginClick(e:Event):void 
		{
			removeLogin();
			_loginPanel = new LoginPanel();
			PopupsController.addPopUp(new LoginPanel());
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
			_loginButton.removeFromParent(true);
			_loginButton = null;
			super.dispose();
		}*/
		
	}

}