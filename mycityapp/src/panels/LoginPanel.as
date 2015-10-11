package panels 
{
	import entities.ResidentsEntity;
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import starling.events.Event;
	import ui.UiGenerator;
	import users.FloxPlayer;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginPanel extends Panel 
	{
		private var nameInput:TextInput;
		private var addressInput:TextInput;
		private var loginButton:Button;
		
		public function LoginPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "ברוך הבא"
			
			nameInput = new TextInput();
			nameInput.prompt = "שם תושב";
			nameInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(nameInput);
			
			addressInput = new TextInput();
			addressInput.prompt = "כתובת";
			addressInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addressInput.move(0, nameInput.bounds.bottom + 10);
			addChild(addressInput);
			
			loginButton = new Button();
			loginButton.label = "המשך";
			loginButton.move(0, addressInput.bounds.bottom + 10);
			loginButton.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(loginButton);
		}
		
		private function onLoginClick(e:Event):void 
		{
			if (nameInput.text)
			{
				UserGlobal.userPlayer.name = nameInput.text;
				UserGlobal.userPlayer.address = addressInput.text;
				UserGlobal.userPlayer.save(null, null);
				
				UserGlobal.residents.addNew(UserGlobal.userPlayer.name, UserGlobal.userPlayer.address);
				
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}

}