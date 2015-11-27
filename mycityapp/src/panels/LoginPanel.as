package panels 
{
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.skins.StyleNameFunctionStyleProvider;
	import log.Logger;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginPanel extends Panel 
	{
		private var _nameInput:TextInput;
		private var _addressInput:TextInput;
		private var _loginButton:Button;
		private var _detailsInput:TextInput;
		private var _mailInput:TextInput;
		private var _loginBackButton:Button;
		
		public function LoginPanel() 
		{
			super();
			title = "ברוך הבא לאבן יהודה"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			
			_nameInput = new TextInput();
			_nameInput.move(0, 10);
			_nameInput.prompt = "שם תושב*";
			_nameInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(_nameInput);
			
			_addressInput = new TextInput();
			_addressInput.prompt = "כתובת";
			_addressInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			_addressInput.move(0, _nameInput.bounds.bottom + 10);
			addChild(_addressInput);
			
			_detailsInput = new TextInput();
			_detailsInput.prompt = "עוד קצת פרטים עלי";
			_detailsInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight * 2);
			_detailsInput.move(0, _addressInput.bounds.bottom + 20);
			addChild(_detailsInput);
			
			_mailInput = new TextInput();
			_mailInput.move(0, _detailsInput.bounds.bottom + 10);
			_mailInput.prompt = "(דוא''ל (לשם שיחזור חשבון*";
			_mailInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(_mailInput);
			
			
			/*_loginButton = new Button();
			_loginButton.label = "יאללה, בוא נראה מה יש פה";
			_loginButton.move(0, _mailInput.bounds.bottom + 10); 
			_loginButton.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			_loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(_loginButton);*/
			
			/*_loginBackButton = new Button();
			_loginBackButton.styleNameList.add(Button.ALTERNATE_NAME_DANGER_BUTTON);
			_loginBackButton.label = "(מה זה? אני כבר רשום (שחזור חשבון";
			_loginBackButton.move(0, _loginButton.bounds.bottom + 20);
			_loginBackButton.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			//_loginBackButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(_loginBackButton);*/
			
			this.headerFactory = customHeaderFactory;
			this.footerFactory = customFooterFactory;
		}
		
		private function onLoginClick(e:Event):void 
		{
			if (_nameInput.text)
			{
				_nameInput.isEnabled = false;
				_mailInput.isEnabled = false;
				_addressInput.isEnabled = false;
				_detailsInput.isEnabled = false;
				isEnabled = false;
				//_loginButton.isEnabled = false;
			
				GlobalDataProvider.userPlayer.name = _nameInput.text;
				GlobalDataProvider.userPlayer.address = _addressInput.text;
				GlobalDataProvider.userPlayer.details = _detailsInput.text;
				GlobalDataProvider.userPlayer.score = 10;
				GlobalDataProvider.userPlayer.save(onLoginSuccess, onLoginFail)
																
				GlobalDataProvider.commonEntity.addNewResident(	GlobalDataProvider.commonEntity.residents.length.toString(),
																GlobalDataProvider.userPlayer.name, 
																GlobalDataProvider.userPlayer.address,
																GlobalDataProvider.userPlayer.details,
																GlobalDataProvider.userPlayer.score
																);
			} else
			{
				var label:Label = new Label();
				label.text = "בשביל להצטרף הנך חייב להכניס שם למערכת";
				Callout.show( label, _nameInput);
			}
		}
		
		protected function customFooterFactory():Header 
		{
			var footer:Header = new Header();
			var loginButton:Button = new Button();
			loginButton.label = "הצטרף";
			loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(loginButton);
			footer.rightItems = new <DisplayObject>[loginButton];
			
			var loginBackButton:Button = new Button();
			loginBackButton.label = "התחבר";
			loginBackButton.styleNameList.add(Button.ALTERNATE_NAME_QUIET_BUTTON);
			loginBackButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(loginBackButton);
			footer.leftItems = new <DisplayObject>[loginBackButton];
			
			return footer
		}
		
		protected function customHeaderFactory():Header 
		{
			var header:Header = new Header();
			var helpButton:Button = new Button();
			//helpButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			helpButton.label = "?";
			helpButton.addEventListener(Event.TRIGGERED, onHelpClick);
			header.leftItems = new <DisplayObject>[helpButton];
			return header
		}
		
		private function onHelpClick(e:Event):void 
		{
			
		}
		
		private function onLoginFail(message:String):void 
		{
			_loginButton.isEnabled = true;
			Logger.logError("Login fail " + message);
		}
		
		private function onLoginSuccess():void 
		{
			Logger.logEvent("Login Success ");
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}