package subPanels 
{
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import controllers.ErrorController;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.TextInput;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import flash.text.TextFormat;
	import localStorage.LocalStorageController;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginPanel extends SubPanel 
	{
		private var _userInput:TextInput;
		private var _loginButn:Button;
		private var _logoutButn:Button;
		private var _infoLabel:Label;
		
		public function LoginPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this.title = TextLocaleHandler.getText(TextsConsts.LoginPanelTitle);;
			
			this._userInput = new TextInput();
			this._userInput.prompt = TextLocaleHandler.getText(TextsConsts.LoginMailPrompt);
			this._userInput.move(5, 10)
			this._userInput.addEventListener(FeathersEventType.CREATION_COMPLETE, onInputReady);
			addChild(this._userInput);
			
			this._loginButn = new Button();
			this._loginButn.addEventListener(Event.TRIGGERED, onLoginClick);
			this._loginButn.label = TextLocaleHandler.getText(TextsConsts.LoginButtonLabel);
			this._loginButn.move(5, 90);
			addChild(this._loginButn);
			
			this._logoutButn = new Button();
			this._logoutButn.addEventListener(Event.TRIGGERED, onLogoutClick);
			this._logoutButn.label =TextLocaleHandler.getText(TextsConsts.LogoutButtonLabel);
			this._logoutButn.move(5, 180);
			this._logoutButn.styleNameList.add(Button.ALTERNATE_NAME_QUIET_BUTTON);
			addChild(this._logoutButn);
			
			/*this._infoLabel = new Label();
			this._infoLabel.text = "Attach your tasks to an email, so you can recover your data from any device any time";
			this._infoLabel.wordWrap = true;

			Callout.show( _infoLabel, _loginButn, Callout.ARROW_POSITION_BOTTOM,false);*/
		}
		
		private function onInputReady(e:Event):void 
		{
			this._loginButn.width = this._userInput.width;
			this._logoutButn.width = this._userInput.width;
			//this._infoLabel.width = this._userInput.width;
		}
		
		private function onLogoutClick(e:Event):void 
		{
			LocalStorageController.getInstance().userMail = "";
			Player.logout();
			MainApp.getInstance().refreshApp();
		}
		
		private function onLoginClick(e:Event):void 
		{
			if (this._userInput.text)
			{
				//Player.login(AuthenticationType.EMAIL, Player.current.id, this._userInput.text, onLoginComplete, onLoginError);
				Player.loginWithEmail(this._userInput.text, onLoginComplete, onLoginError);
				this.title = "Connecting...";
				this._userInput.isEnabled = false;
				this._loginButn.isEnabled = false;
			}
		}
		
		private function onLoginError(error:String):void 
		{
			ErrorController.showError(this,"onLoginError " + error);
			Flox.logError(this, "onLoginError : " + error);
			
			Alert.show("Please check your mail for login confirmation", "Try again",new ListCollection([ { label: "Refresh" } ]));
		}
		
		private function onLoginComplete():void 
		{
			Flox.logInfo("login player email success " + Player.current);
			
			LocalStorageController.getInstance().userMail = this._userInput.text;
			//LocalStorageController.getInstance().saveData();
			
			MainApp.getInstance().refreshApp();
		}
		
		override public function dispose():void 
		{
			/*if (_registerPanel)
			{
				_registerPanel.removeFromParent(true);
				PopUpManager.removePopUp(_registerPanel);
			}*/
			
			super.dispose();
		}
		
	}

}