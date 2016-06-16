package panels 
{
	import feathers.controls.ButtonGroup;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.data.ListCollection;
	import flash.desktop.NativeApplication;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class QuitPanel extends Panel 
	{
		
		public function QuitPanel() 
		{
			super();
			title = "זהו?";
			
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var label:Label = new Label();
			label.text = "אתה בטוח שאתה רוצה לצאת?";
			addChild(label);
			
			var group:ButtonGroup = new ButtonGroup();
			group.move(0, 50);
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.dataProvider = new ListCollection(
			[
				{ label: "כן", triggered: yesButton_triggeredHandler },
				{ label: "לא", triggered: noButton_triggeredHandler }
			]);
			addChild(group);
		}
		
		private function yesButton_triggeredHandler():void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
		private function noButton_triggeredHandler():void 
		{
			dispatchEventWith(Event.CLOSE)
		}
		
	}

}