package panels 
{
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
		private var nameInput:TextInput;
		private var addressInput:TextInput;
		private var loginButton:Button;
		private var codeInput:TextInput;
		
		public function LoginPanel() 
		{
			super();
			title = "ברוך הבא"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			
			nameInput = new TextInput();
			nameInput.move(0, 10);
			nameInput.prompt = "הרשמה";
			nameInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(nameInput);
			
			addressInput = new TextInput();
			addressInput.prompt = "כתובת";
			addressInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addressInput.move(0, nameInput.bounds.bottom + 10);
			addChild(addressInput);
			
			
			codeInput = new TextInput();
			codeInput.prompt = "מספר משלם - ארנונה";
			codeInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			codeInput.move(0, addressInput.bounds.bottom + 50);
			addChild(codeInput);
			
			var label:Label = new Label();
			label.text = "רק מוודאים שאתה תושב";
		 
			Callout.show( label, codeInput, Callout.DIRECTION_UP);
			 
			loginButton = new Button();
			loginButton.label = "המשך";
			loginButton.move(0, codeInput.bounds.bottom + 10);
			loginButton.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(loginButton);
		}
		
		private function onLoginClick(e:Event):void 
		{
			if (nameInput.text)
			{
				GlobalDataProvider.userPlayer.name = nameInput.text;
				GlobalDataProvider.userPlayer.address = addressInput.text;
				GlobalDataProvider.userPlayer.save(null, null);
				GlobalDataProvider.residentsDataProvier.addItem(GlobalDataProvider.userPlayer.name, GlobalDataProvider.userPlayer.address);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}

}