package subPanels 
{
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class EditTaskPanel extends SubPanel 
	{
		static public const SAVE_ITEN:String = "saveIten";
		private var _editInputTf:TextInput;
		private var _saveButton:Button;
		
		public function EditTaskPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			width = this.stage.stageWidth - 100;
			
			title = TextLocaleHandler.getText(TextsConsts.EditTaskPanelTitle);
			
			editInputTf = new TextInput();
			editInputTf.width = this.width - 20;
			editInputTf.move(0, 10);
			editInputTf.setFocus();
			addChild( editInputTf );
			
			/* var group:ButtonGroup = new ButtonGroup();
			 group.dataProvider = new ListCollection(
			 [
				 { label: "Save", triggered: saveEditTask_triggeredHandler },
				 { label: "Cancel", triggered: cancelEditTask_triggeredHandler },
			 ]);
			 
			 
			 addChild( group );
			
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.setSize(this.stage.stageWidth - 20, 50);
			group.move(5, 100)*/
			
			
			_saveButton = new Button();
			_saveButton.label = TextLocaleHandler.getText(TextsConsts.SaveButtonLabel);
			_saveButton.addEventListener(Event.TRIGGERED, saveEditTask_triggeredHandler);
			_saveButton.width = this.width - 20;
			_saveButton.move(0, 100);
			addChild(_saveButton);
			
			
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