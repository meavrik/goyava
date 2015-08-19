package 
{
	import assets.AssetsHelper;
	import externalServices.ExternalServicesManager;
	import feathers.core.PopUpManager;
	import starling.events.Event;
	import starling.textures.Texture;
	import subPanels.SubmitTaskPanel;
	import users.UserGlobal;
	/**
	 * ...
	 * @author Avrik
	 */
	public class RemindTaskScreen extends BaseListScreen 
	{
		private var _submitTaskPanel:SubmitTaskPanel;
		
		public function RemindTaskScreen() 
		{
			super();
			listArr = UserGlobal.userPlayer.tasks;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "My tasks";
			
			_submitTaskPanel = new SubmitTaskPanel();
			_submitTaskPanel.addEventListener(Event.SELECT, submitButton_triggeredHandler);
			_submitTaskPanel.addEventListener(Event.CANCEL, cancelButton_triggeredHandler);
			_autoCompleteInput.prompt = "enter new reminder";
		}
		
		private function cancelButton_triggeredHandler(event:Event):void 
		{
			PopUpManager.removePopUp(_submitTaskPanel)
		}
		
		private function submitButton_triggeredHandler(event:Event):void 
		{
			var index:int = _submitTaskPanel.selectedIndex;
			PopUpManager.removePopUp(_submitTaskPanel);
			var iconTexture:Texture = AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.TIME_ICONS, index);
			submitNewTask(iconTexture, index);
			
			//HOUR , DAY , WEEK , MONTH , YEAR , RANDOM
			//var secondsArr:Array = [3600, 86400, 604800, 2419200, 29030400, Math.round(Math.random() * 604800)];
			//var secondsArr:Array = [600, 3600, 86400, 604800, 2419200, 29030400];
			//ExternalServicesManager.getInstance().pushNotification.scheduleNotification(secondsArr[index], _currentTaskName, 5);
			ExternalServicesManager.getInstance().pushNotification.scheduleNotification(_submitTaskPanel.getTotalSecondsNag(), _currentTaskName, 5);
		}
		
		override protected function showPostTaskPanel():void 
		{
			PopUpManager.addPopUp(_submitTaskPanel);
		}
		
		override protected function updateArr():void 
		{
			UserGlobal.userPlayer.tasks = listArr;
			super.updateArr();
		}
		
	}

}