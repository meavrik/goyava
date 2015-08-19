package 
{
	import feathers.controls.PanelScreen;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class RemindBirthdayScreen extends BaseListScreen 
	{
		
		public function RemindBirthdayScreen() 
		{
			super();
			title = "Events to remember";
			listArr = UserGlobal.userPlayer.myEvents;
			
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_autoCompleteInput.prompt = "enter new event";
		}
		
		override protected function updateArr():void 
		{
			UserGlobal.userPlayer.myEvents = listArr;
			super.updateArr();
		}
	}

}