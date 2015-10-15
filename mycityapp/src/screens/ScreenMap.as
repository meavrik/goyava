package screens 
{
	import feathers.controls.PanelScreen;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMap extends PanelScreen 
	{
		
		public function ScreenMap() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "מפה";
		}
		
	}

}