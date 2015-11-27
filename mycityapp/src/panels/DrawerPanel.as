package panels 
{
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.core.FeathersControl;
	import screens.subScreens.ScreenSellItemView;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class DrawerPanel extends FeathersControl
	{
		private var _currentPanel:Panel;
		
		public function DrawerPanel() 
		{
			super();
			
		}
		
		public function setScreen(panel:Panel):void
		{
			//this.title = screenData.name?screenData.name:"";
			if (_currentPanel)
			{
				_currentPanel.removeFromParent(true);
			}
			_currentPanel = panel;
			
			addChild(_currentPanel);
		}
		
	}

}