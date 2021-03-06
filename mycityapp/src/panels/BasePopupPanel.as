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
			
			this.width = this.stage.stageWidth - 50;
			//setSize(this.stage.stageWidth - 10, this.stage.stageHeight - 10);
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			headerFactory = customHeaderFactory;
		}
		
		protected function customHeaderFactory():Header
		{
			var header:Header = new Header();
			var closeButton:Button = new Button();
			//closeButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
			closeButton.label = "x";
			closeButton.addEventListener(Event.TRIGGERED, onCloseClick);
			header.leftItems = new <DisplayObject>
			[
				closeButton
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