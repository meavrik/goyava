package subPanels 
{
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Panel;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.SpinnerList;
	import feathers.core.ToggleGroup;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SubmitTaskPanel extends Panel 
	{
		private var _toggleGroup:ToggleGroup;
		private var _spinnerList:SpinnerList;
		private var _buttonGroup:ButtonGroup;
		private var _spinnerListAmount:SpinnerList;
		private var _spinnerListRepeat:SpinnerList;
		private var _closeButn:Button;
		
		public function SubmitTaskPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "Nag me about it every"
			
			_buttonGroup = new ButtonGroup();
			 _buttonGroup.dataProvider = new ListCollection(
			 [
				 { label: "OK", triggered: submitButton_triggeredHandler },
				 { label: "No Nag", triggered: noNagButton_triggeredHandler },
				 { label: "Cancel", triggered: cancelButton_triggeredHandler },
			 ]);
			 addChild( _buttonGroup );
			_buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			_buttonGroup.setSize(this.stage.stageWidth - 50, 50);
			
			
			
			/*
			 _toggleGroup = new ToggleGroup();
			 var arr:Array = ["10 minutes", "hour", "day", "week", "month", "year"];
			 var radio:Radio;
			var padding:Number = 150;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				radio = new Radio();
				radio.label = arr[i];
				radio.toggleGroup = _toggleGroup;
				radio.x =  i > 2?(i - 3) * padding:(i * padding);
				radio.y = i > 2?50:0;
				addChild(radio)
			}
			
			 group.y = radio.y + radio.height + 80;
			_toggleGroup.selectedIndex = 1;*/
			
			_spinnerList = addNewSpinnerList(["minute", "hour", "day", "month"]);
			_spinnerListAmount = addNewSpinnerList(["1", "2", "3", "5", "10", "12"]);
			_spinnerListRepeat = addNewSpinnerList(["x1", "x2", "x3", "x5", "x10", "x50"]);
			_spinnerListAmount.addEventListener(FeathersEventType.CREATION_COMPLETE, onListCreationComplete);
			
			_spinnerList.selectedIndex = 0;
			_spinnerListAmount.selectedIndex = 0;
			_spinnerListRepeat.selectedIndex = 3;
		}
		
		private function addNewSpinnerList(listArr:Array):SpinnerList 
		{
			var newSpinner:SpinnerList = new SpinnerList();
			newSpinner.width = stage.stageWidth / 2;
			
			 newSpinner.dataProvider = new ListCollection(new Array());
			 
			 for (var i:int = 0; i < listArr.length; i++) 
			 {
				 newSpinner.dataProvider.push( { text:listArr[i] });
			 }
			 newSpinner.setSize(stage.stageWidth / 3 - 10, 150);

			 newSpinner.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 renderer.height = 80;
				 renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
				// renderer.iconSourceField = "thumbnail";
				 return renderer;
			 };
			 this.addChild(newSpinner);
			 return newSpinner;
		}
		
		private function onListCreationComplete(e:Event):void 
		{
			_buttonGroup.move(5, _spinnerList.bounds.bottom + 10);
			_spinnerList.x = _spinnerListAmount.bounds.right;
			_spinnerListRepeat.x = _spinnerList.bounds.right;
		}
		
		private function cancelButton_triggeredHandler(event:Event):void 
		{
			dispatchEvent(new Event(Event.CANCEL));
		}
		
		private function noNagButton_triggeredHandler(event:Event):void
		{
			dispatchEvent(new Event(Event.SELECT));
		}
		
		private function submitButton_triggeredHandler(event:Event):void 
		{
			dispatchEvent(new Event(Event.SELECT));
		}
		
		public function get selectedIndex():int 
		{
			//return _toggleGroup.selectedIndex;
			return _spinnerList.selectedIndex;
		}
		
		public function getTotalSecondsNag():Number
		{
			var arr:Array = [60, 3600, 86400, 2592000];
			var seconds:Number = arr[_spinnerList.selectedIndex];

			return seconds * parseInt(_spinnerListAmount.selectedItem.text);
		}

		
	}

}