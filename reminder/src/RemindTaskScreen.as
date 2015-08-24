package 
{
	import assets.AssetsHelper;
	import externalServices.ExternalServicesManager;
	import popups.PopupsController;
	import starling.events.Event;
	import starling.textures.Texture;
	import subPanels.SubmitTaskPanel;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
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
			_autoCompleteInput.prompt = TextLocaleHandler.getText(TextsConsts.TasksPrompt);
		}
		
		private function cancelButton_triggeredHandler(event:Event):void 
		{
			PopupsController.removePopUp(_submitTaskPanel)
		}
		
		private function submitButton_triggeredHandler(event:Event):void 
		{
			var index:int = _submitTaskPanel.selectedIndex;
			PopupsController.removePopUp(_submitTaskPanel);
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
			PopupsController.addPopUp(_submitTaskPanel);
		}
		
		override protected function updateArr():void 
		{
			UserGlobal.userPlayer.tasks = listArr;
			super.updateArr();
		}
		
	}

}