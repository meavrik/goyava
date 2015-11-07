package screens.subScreens 
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenSubScreenMenu extends PanelScreen 
	{
		
		public function ScreenSubScreenMenu() 
		{
			super();
			
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
			dispatchEventWith(Event.COMPLETE);
			removeFromParent();
		}
		
		protected function showInvalidMessage(content:DisplayObject,message:String):void
		{
			var label:Label = new Label();
			label.text = message;
	 
			Callout.show( label, content);
		}
		
	}

}