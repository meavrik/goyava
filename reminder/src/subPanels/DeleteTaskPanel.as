package subPanels 
{
	import feathers.controls.ButtonGroup;
	import feathers.controls.Panel;
	import feathers.controls.Radio;
	import feathers.core.ToggleGroup;
	import feathers.data.ListCollection;
	import starling.display.Sprite;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class DeleteTaskPanel extends Panel 
	{
		static public const DELETE_ITEN:String = "deleteIten";
		
		public function DeleteTaskPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = TextLocaleHandler.getText(TextsConsts.removeTaskTitle);
			
			var group:ButtonGroup = new ButtonGroup();
			 group.dataProvider = new ListCollection(
			 [
				 { label: "Yes, it's done!", triggered: deleteTask_triggeredHandler },
				 { label: "Cancel", triggered: cancelEditTask_triggeredHandler },
			 ]);
			addChild( group );
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.setSize(this.stage.stageWidth - 50, 50);
			
			
			
			
			/*var rateGroup:ToggleGroup = new ToggleGroup();
			rateGroup.addEventListener( Event.CHANGE, rateGroup_changeHandler );

			var radio:Radio 
			for (var i:int = 0; i < 3; i++) 
			{
				radio = new Radio();
				radio.label = String(i + 1);
				radio.toggleGroup = rateGroup;
				radio.move(i * 100 + 20, 50);
				addChild(radio);
			}
			 */
		}
		
		private function rateGroup_changeHandler(e:Event):void 
		{
			
		}
		
		private function deleteTask_triggeredHandler():void 
		{
			dispatchEvent(new Event(DELETE_ITEN));
		}
		
		private function cancelEditTask_triggeredHandler():void 
		{
			dispatchEvent(new Event(Event.CANCEL));
		}
		
	}

}