package 
{
	import feathers.controls.Button;
	import feathers.controls.ToggleSwitch;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainScreenBottomPanel extends FeathersControl 
	{
		static public const CLEAR_LIST_EVENT:String = "clearListEvent";
		
		private var _nagSwitch:ToggleSwitch;
		private var _clearAllButton:Button;
		
		public function MainScreenBottomPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, 200);
			
			_nagSwitch = new ToggleSwitch();
			_nagSwitch.onText = "Nag";
			_nagSwitch.offText = "No Nag";
			_nagSwitch.addEventListener(FeathersEventType.CREATION_COMPLETE, onSwitchCreationComplete);
			_nagSwitch.isSelected = true;
			this.addChild(_nagSwitch);
			
			_clearAllButton = new Button();
			_clearAllButton.label = "Clear list";
			_clearAllButton.addEventListener(Event.TRIGGERED, onClearAllTrigered);
			this.addChild(_clearAllButton);
		}
		
		private function onClearAllTrigered(e:Event):void 
		{
			dispatchEvent(new Event(CLEAR_LIST_EVENT))
		}
		
		private function onSwitchCreationComplete(e:Event):void 
		{
			_nagSwitch.move(this.stage.stageWidth - (_nagSwitch.width + 10), this.stage.stageHeight - (_nagSwitch.height + 10));
			_clearAllButton.move(10, this.stage.stageHeight - (_nagSwitch.height + 10));
		}
		
		public function get clearAllButton():Button 
		{
			return _clearAllButton;
		}
		
	}

}