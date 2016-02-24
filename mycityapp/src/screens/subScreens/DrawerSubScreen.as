package screens.subScreens 
{
	import feathers.controls.PanelScreen;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class DrawerSubScreen extends PanelScreen 
	{
		
		public function DrawerSubScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, stage.stageHeight / 2);
		}
		
	}

}