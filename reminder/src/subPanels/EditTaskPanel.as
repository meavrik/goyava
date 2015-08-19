package subPanels 
{
	import feathers.controls.ButtonGroup;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class EditTaskPanel extends Panel 
	{
		static public const SAVE_ITEN:String = "saveIten";
		private var _editInputTf:TextInput;
		
		public function EditTaskPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "Edit"
			
			editInputTf = new TextInput();
			editInputTf.width = this.stage.stageWidth - 30;
			editInputTf.x = 10;
			
			 var group:ButtonGroup = new ButtonGroup();
			 group.dataProvider = new ListCollection(
			 [
				 { label: "Save", triggered: saveEditTask_triggeredHandler },
				 { label: "Cancel", triggered: cancelEditTask_triggeredHandler },
			 ]);
			 
			 addChild( editInputTf );
			 addChild( group );
			
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.setSize(this.stage.stageWidth - 20, 50);
			group.move(5, 100)
		}
		
		private function saveEditTask_triggeredHandler():void 
		{
			dispatchEvent(new Event(SAVE_ITEN));
		}
		
		private function cancelEditTask_triggeredHandler():void 
		{
			dispatchEvent(new Event(Event.CANCEL));
		}
		
		public function get editInputTf():TextInput 
		{
			return _editInputTf;
		}
		
		public function set editInputTf(value:TextInput):void 
		{
			_editInputTf = value;
		}
		
	}

}