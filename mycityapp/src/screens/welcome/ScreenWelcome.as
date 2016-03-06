package screens.welcome 
{
	import feathers.controls.PageIndicator;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenWelcome extends Screen 
	{
		
		public function ScreenWelcome() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			var pageIndicator:PageIndicator = new PageIndicator();
			pageIndicator.pageCount = 3;
			pageIndicator.selectedIndex = 1;
			pageIndicator.move(this.stage.stageWidth / 2, this.stage.stageHeight - 100);
			addChild(pageIndicator);
		}
		
	}

}