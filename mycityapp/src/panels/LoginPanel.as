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
			
			_mailInput = new TextInput();
			_mailInput.move(0, _nameInput.bounds.bottom + 10);
			_mailInput.prompt = "(דוא''ל (לשם שיחזור חשבון*";
			_mailInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(_mailInput);
			
			_addressInput = new TextInput();
			_addressInput.prompt = "כתובת";
			_addressInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			_addressInput.move(0, _mailInput.bounds.bottom + 10);
			addChild(_addressInput);
			
			
			_detailsInput = new TextInput();
			_detailsInput.prompt = "עוד קצת פרטים עלי";
			_detailsInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight * 2);
			_detailsInput.move(0, _addressInput.bounds.bottom + 50);
			addChild(_detailsInput);
			
			_loginButton = new Button();
			_loginButton.label = "הצטרף";
			_loginButton.move(0, _detailsInput.bounds.bottom + 10);
			_loginButton.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			_loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(_loginButton);
		}
		
		private function onLoginClick(e:Event):void 
		{
			if (_nameInput.text)
			{
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
		
		private function onLoginFail(message:String):void 
		{
			Flox.logError("Login fail " + message);
		}
		
		private function onLoginSuccess():void 
		{
			Flox.logEvent("Login Success ");
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}