package screens 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import progress.WaitPreloader;
	import screens.events.ScreenEvent;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenSubMain extends PanelScreen 
	{
		private var _preloader:WaitPreloader;
		public var id:String;
		
		public function ScreenSubMain() 
		{
			super();
			
		}
		override protected function initialize():void 
		{
			super.initialize();
			
			this.headerFactory = this.customHeaderFactory;
		}
		
		protected function showPreloader():void 
		{
			_preloader = new WaitPreloader();
			addChild(_preloader);
			_preloader.x = (this.width - _preloader.width) / 2;
			_preloader.y = (this.height - _preloader.height) / 2;
		}
		
		protected function removePreloader():void
		{
			if (_preloader)
			{
				_preloader.removeFromParent(true);
			}
		}
		
		protected function customHeaderFactory():Header
		{
			var header:Header = new Header();
			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout

			var backButton:Button = new Button();
			backButton.styleNameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
			//backButton.label = "חזרה";
			backButton.label = "";
			backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			header.leftItems = new <DisplayObject>
			[
				backButton
			];
			
			return header;
		}
		
		private function backButton_triggeredHandler(e:Event):void 
		{
			goBack();
		}
		
		private function goBack():void 
		{
			//dispatchEvent(new ScreenEvent(ScreenEvent.BACK));
			this.dispatchEventWith(Event.COMPLETE);
		}
	}

}