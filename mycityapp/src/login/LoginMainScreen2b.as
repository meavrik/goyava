package login 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Player;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import log.Logger;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginMainScreen2b extends LoginMainBase 
	{
		private var _mailInput:TextInput;
		private var _lastNameInput:TextInput;
		
		public function LoginMainScreen2b() 
		{
			super();

		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "שחזר חשבון בעזרת דוא''ל";
			
			//_screenImg.texture = AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.LOGIN_FRAMES, 2);
			_nextButton.label = "שחזר";
			
			_mailInput = new TextInput();
			_mailInput.prompt = "דוא''ל*";
			_mailInput.setSize(stage.stageWidth -80,100);
			_mailInput.move((stage.stageWidth - _mailInput.width) / 2, _nextButton.bounds.top  - _mailInput.height- FIELDS_GAP);
			addChild(_mailInput);
			
			headerFactory = customHeaderFactory;
		}
		
		override protected function onNextClick(e:Event):void 
		{
			super.onNextClick(e);
			
			if (_mailInput.text)
			{
				isEnabled = false;

				Player.loginWithEmail(_mailInput.text, onLoginSuccess, onLoginFail);
				
				dispatchEventWith(LoginScreenEnum.SCREEN3);
			} else
			{
				var label:Label = new Label();
				label.text = "אנא הכנס כתובת דוא''ל חוקית";
				Callout.show( label, _mailInput);
			}		
		}
	
		private function onLoginFail(message:String):void 
		{
			Logger.logError("Login fail " + message);
		}
		
		private function onLoginSuccess():void 
		{
			Logger.logEvent("Login viua mail Success ");
			
			dispatchEvent(new Event(Event.COMPLETE, true));
		}
		
		
		
		
	}

}