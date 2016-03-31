package login 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import entities.enum.MessageTypeEnum;
	import entities.MessageEntity;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import log.Logger;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginMainScreen2 extends LoginMainBase 
	{
		private var _nameInput:TextInput;
		private var _lastNameInput:TextInput;
		
		public function LoginMainScreen2() 
		{
			super();

		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "פרטים אישיים";
			
			//_screenImg.texture = AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.LOGIN_FRAMES, 2);
			_nextButton.label = "המשך";

			_lastNameInput = new TextInput();
			_lastNameInput.prompt = "שם משפחה";
			_lastNameInput.setSize(stage.stageWidth -80, 100);
			_lastNameInput.move((stage.stageWidth - _lastNameInput.width) / 2, _nextButton.bounds.top  - _lastNameInput.height- FIELDS_GAP);
			addChild(_lastNameInput);
			
			_nameInput = new TextInput();
			_nameInput.prompt = "שם פרטי*";
			_nameInput.setSize(stage.stageWidth -80,100);
			_nameInput.move((stage.stageWidth - _nameInput.width) / 2, _lastNameInput.bounds.top  -_nameInput.height- FIELDS_GAP);
			addChild(_nameInput);
			
			headerFactory = customHeaderFactory;
		}
		
		override protected function onNextClick(e:Event):void 
		{
			super.onNextClick(e);
			
			if (_nameInput.text)
			{
				//isEnabled = false;

				GlobalDataProvider.myUserData.name = _nameInput.text;
				GlobalDataProvider.myUserData.score = 10;
				GlobalDataProvider.myUserData.save(onLoginSuccess, onLoginFail);
				
				var messageEntity:MessageEntity = new MessageEntity();
				messageEntity.createNewMessage(GlobalDataProvider.myUserData.id, GlobalDataProvider.myUserData.name, "ברוך הבא", "ברכות על הצטרפותך לקהילת אבן יהודה", MessageTypeEnum.SYSTEM);
				messageEntity.save(null, null);
				dispatchEventWith(LoginScreenEnum.SCREEN3);
			} else
			{
				var label:Label = new Label();
				label.text = "בשביל להצטרף הנך חייב להכניס שם למערכת";
				Callout.show( label, _nameInput);
			}
			//dispatchEventWith(LoginScreenEnum.SCREEN3);
		}
		
		
		private function onLoginFail(message:String):void 
		{
			//_loginButton.isEnabled = true;
			Logger.logError("Login fail " + message);
		}
		
		private function onLoginSuccess():void 
		{
			Logger.logEvent("Login Success ");
			
			//dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		
	}

}