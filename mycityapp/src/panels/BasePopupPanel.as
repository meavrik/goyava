package panels 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class BasePopupPanel extends Panel 
	{
		
		public function BasePopupPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this.width = this.stage.stageWidth - 20;
			
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			headerFactory = customHeaderFactory;
		}
		
		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			var backButton:Button = new Button();
			backButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
			backButton.label = "חזרה";
			backButton.addEventListener(Event.TRIGGERED, onCloseClick);
			header.leftItems = new <DisplayObject>
			[
				backButton
			];

			return header;
		}
		
		private function onCloseClick(e:Event):void 
		{
			closeMe()
		}
		
		protected function closeMe():void
		{
			dispatchEvent(new Event(Event.CLOSE));
			removeFromParent();
		}
		
	}

}