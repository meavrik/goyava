package subPanels 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	/**
	 * ...
	 * @author Avrik
	 */
	public class RegisterPanel extends SubPanel 
	{
		private var _userInput:TextInput;
		private var _passwordInput:TextInput;
		private var _loginButn:Button;
		private var _confirmPasswordInput:TextInput;
		
		public function RegisterPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this.title = "Register";
			
			this._userInput = new TextInput();
			this._userInput.prompt = "user name";
			addChild(this._userInput);
			this._passwordInput = new TextInput();
			this._passwordInput.prompt = "password";
			this._passwordInput.displayAsPassword = true;
			this._passwordInput.addEventListener(FeathersEventType.CREATION_COMPLETE, onInputReady);
			addChild(this._passwordInput);
			
			this._confirmPasswordInput = new TextInput();
			this._confirmPasswordInput.prompt = "confirm password";
			this._confirmPasswordInput.displayAsPassword = true;
			addChild(this._confirmPasswordInput);
			
			this._loginButn = new Button();
			this._loginButn.label = "Register";
			addChild(this._loginButn);
		}
		
		private function onInputReady(e:Event):void 
		{
			this._userInput.move(10, 10)
			this._passwordInput.move(10, 90);
			this._confirmPasswordInput.move(10, 170);
			this._loginButn.move(10, 250);

			this._loginButn.width = this._passwordInput.width;
		}
		
	}

}