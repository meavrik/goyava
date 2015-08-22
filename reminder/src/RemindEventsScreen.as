package 
{
	import feathers.controls.PanelScreen;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class RemindEventsScreen extends BaseListScreen 
	{
		
		public function RemindEventsScreen() 
		{
			super();
			title = "Events to remember";
			listArr = UserGlobal.userPlayer.myEvents;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_autoCompleteInput.prompt = TextLocaleHandler.getText(TextsConsts.EventsPrompt);
		}
		
		override protected function updateArr():void 
		{
			UserGlobal.userPlayer.myEvents = listArr;
			super.updateArr();
		}
	}

}