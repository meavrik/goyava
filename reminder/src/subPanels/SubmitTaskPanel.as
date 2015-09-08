package subPanels 
{
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Check;
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
	public class SubmitTaskPanel extends SubPanel 
	{
		private var _toggleGroup:ToggleGroup;
		private var _spinnerList:SpinnerList;
		private var _buttonGroup:ButtonGroup;
		private var _spinnerListAmount:SpinnerList;
		private var _spinnerListRepeat:SpinnerList;
		private var _closeButn:Button;
		private var _nagCheck:Check;
		
		private static var doNag:Boolean = true;
		
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
				 { label: "Set new task", triggered: submitButton_triggeredHandler },
				// { label: "No Nag", triggered: noNagButton_triggeredHandler },
				// { label: "Cancel", triggered: cancelButton_triggeredHandler },
			 ]);
			 addChild( _buttonGroup );
			_buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			_buttonGroup.setSize(this.stage.stageWidth - 50, 50);
			
			
			_nagCheck = new Check();
			_nagCheck.label = "Nag";
			_nagCheck.isSelected = doNag
			_nagCheck.addEventListener(Event.CHANGE, onNagChange);
			addChild(_nagCheck);
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
			updateSpinner();
			
			this.width = stage.stageWidth - 50;
			var newWidth:Number = (this.width -10) / 3;
			_spinnerList.width = newWidth;
			_spinnerListAmount.width = newWidth;
			_spinnerListRepeat.width = newWidth;
		}
		
		private function updateSpinner():void
		{
			_spinnerList.isEnabled = doNag;
			_spinnerListAmount.isEnabled = doNag;
			_spinnerListRepeat.isEnabled = doNag;
			
			_spinnerList.alpha = doNag?1:.2;
			_spinnerListAmount.alpha = doNag?1:.2;
			_spinnerListRepeat.alpha = doNag?1:.2;
		}
		
		private function onNagChange(e:Event):void 
		{
			doNag = _nagCheck.isSelected;
			updateSpinner()
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
			_spinnerList.move(_spinnerListAmount.bounds.right, 10);
			_spinnerListRepeat.move(_spinnerList.bounds.right, 10);
			_spinnerListAmount.move(0, 10);
			_nagCheck.move(5, _spinnerList.bounds.bottom + 10);
			
			_buttonGroup.move(5, _nagCheck.bounds.bottom + 10);
		}
		
		/*private function cancelButton_triggeredHandler(event:Event):void 
		{
			dispatchEvent(new Event(Event.CANCEL));
		}
		
		private function noNagButton_triggeredHandler(event:Event):void
		{
			dispatchEvent(new Event(Event.SELECT));
		}*/
		
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