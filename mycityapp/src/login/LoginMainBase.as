package login 
{
	import assets.AssetsHelper;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginMainBase extends PanelScreen 
	{
		protected var _screenImg:Image;
		protected var _nextButton:Button;
		
		protected const FIELDS_GAP:Number = 15;
		public function LoginMainBase() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			_nextButton = new Button();
			_nextButton.addEventListener(Event.TRIGGERED, onNextClick);
			//_nextButton.label = "הרשם כתושב";
			_nextButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			_nextButton.setSize(stage.stageWidth -80, 100);
			//loginButn.move(40, img.bounds.bottom + 40);
			_nextButton.move(40, (this.height-_nextButton.height)/2);
			addChild(_nextButton);
		}
		
		protected function onNextClick(e:Event):void 
		{
			
		}
		
		protected function customHeaderFactory():Header 
		{
			var header:Header = new Header();
			var backButton:Button = new Button();
			backButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
			backButton.addEventListener(Event.TRIGGERED, onBackClick);
			header.leftItems = new <DisplayObject>[backButton];
			return header
		}
		
		private function onBackClick():void 
		{
			dispatchEventWith(LoginScreenEnum.BACK);
			
		}
		
	}

}