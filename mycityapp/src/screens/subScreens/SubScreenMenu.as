package screens.subScreens 
{
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.buttons.CloseButton;
	import ui.buttons.SaveButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SubScreenMenu extends PanelScreen 
	{
		protected var _header:Header;
		
		public function SubScreenMenu() 
		{
			super();
			
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			headerFactory = customHeaderFactory;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_header = new Header();

			var closeButton:CloseButton = new CloseButton(onCloseClick);
			addChild(closeButton);
			
			var saveButton:SaveButton = new SaveButton(onSaveClick);
			saveButton.x = stage.stageWidth - (saveButton.width + 20);
			saveButton.y = this.stage.stageHeight - (saveButton.height + 10) - _header.bounds.bottom;
			//saveButton.addEventListener(Event.TRIGGERED, onSaveClick);
			addChild(saveButton);
			
			_header.rightItems = new <DisplayObject>[saveButton];
			_header.leftItems = new <DisplayObject>[closeButton];
		}
		
		private function onSaveClick(e:Event):void 
		{
			handleSaveClick();
		}
		
		protected function handleSaveClick():void 
		{
			
		}
		
		protected function customHeaderFactory():Header
		{
			return _header;
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