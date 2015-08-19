package 
{
	import feathers.controls.PanelScreen;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class RemindShoppingScreen extends BaseListScreen 
	{
		
		public function RemindShoppingScreen() 
		{
			super();
			title = "Shopping list";
			listArr = UserGlobal.userPlayer.myShoppingList;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_autoCompleteInput.prompt = "enter new item";
			
		}
		
		override protected function updateArr():void 
		{
			UserGlobal.userPlayer.myShoppingList = listArr;
			super.updateArr();
		}
		
	}

}