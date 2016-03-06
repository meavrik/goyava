package login 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginMainScreen extends LoginMainBase 
	{
		
		public function LoginMainScreen() 
		{
			super();

		}
		
		override protected function initialize():void 
		{
			
			_screenImg = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.LOGIN_FRAMES, 2));
			_screenImg.x = (stage.stageWidth - _screenImg.width) / 2;
			_screenImg.y = 10;
			addChild(_screenImg);
			
			super.initialize();

			//_screenImg.texture = AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.LOGIN_FRAMES, 1);
			
			title = " ברוך הבא לאבן יהודה";
			_nextButton.label = "הרשם כתושב";

			var loginGuestButn:Button = new Button();
			loginGuestButn.addEventListener(Event.TRIGGERED, onGuestClick);
			loginGuestButn.label = "היכנס כאורח";
			loginGuestButn.setSize(_nextButton.width, _nextButton.height);
			loginGuestButn.move(_nextButton.x, _nextButton.bounds.bottom + FIELDS_GAP);
			//loginGuestButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON);
			addChild(loginGuestButn);
			
			var loginBackButn:Button = new Button();
			loginBackButn.addEventListener(Event.TRIGGERED, onLoginBackClick);
			loginBackButn.label = "תושב קיים במערכת";
			loginBackButn.setSize(_nextButton.width, _nextButton.height);
			loginBackButn.move(_nextButton.x, loginGuestButn.bounds.bottom + FIELDS_GAP);
			loginBackButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON);
			addChild(loginBackButn);
		}
		
		private function onLoginBackClick(e:Event):void 
		{
			dispatchEventWith(LoginScreenEnum.SCREEN4);
		}
		
		private function onGuestClick(e:Event):void 
		{
			dispatchEventWith(Event.COMPLETE, true);
		}
		
		override protected function onNextClick(e:Event):void 
		{
			super.onNextClick(e);
			
			dispatchEventWith(LoginScreenEnum.SCREEN2);
		}
		
	}

}