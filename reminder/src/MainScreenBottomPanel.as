package 
{
	import externalServices.ExternalServicesManager;
	import feathers.controls.Button;
	import feathers.controls.ToggleSwitch;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import popups.PopupsController;
	import starling.events.Event;
	import subPanels.AreYouSurePanel;
	
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
			_nagSwitch.addEventListener(Event.CHANGE, onSwitchChange);
			_nagSwitch.isSelected = true;
			this.addChild(_nagSwitch);
			
			_clearAllButton = new Button();
			_clearAllButton.label = "Clear list";
			_clearAllButton.addEventListener(Event.TRIGGERED, onClearAllTrigered);
			this.addChild(_clearAllButton);
		}
		
		private function onSwitchChange(e:Event):void 
		{
			if (!_nagSwitch.isSelected)
			{
				ExternalServicesManager.getInstance().pushNotification.removeAllNotifications();
			}
		}
		
		private function onClearAllTrigered(e:Event):void 
		{
			var popup:AreYouSurePanel = new AreYouSurePanel();
			popup.addEventListener(Event.SELECT, onClearSure);
			PopupsController.addPopUp(popup)
			//dispatchEvent(new Event(CLEAR_LIST_EVENT))
		}
		
		private function onClearSure(e:Event):void 
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
		
		override public function dispose():void 
		{
			if (_clearAllButton)
			{
				_clearAllButton.removeFromParent(true);
				_clearAllButton = null;
			}
			
			if (_nagSwitch)
			{
				_nagSwitch.removeFromParent(true);
				_nagSwitch = null;
			}
			
			super.dispose();
		}
		
	}

}