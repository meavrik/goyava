package 
{
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainScreenBottomPanel extends FeathersControl 
	{
		private var _callButton:Button;
		
		public function MainScreenBottomPanel() 
		{
			super();
			
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, 160);
			
			_callButton = new Button();
			_callButton.styleNameList.add( Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON );
			_callButton.label = "התקשר לקב''ט : 050-12345697";
			_callButton.x = 20;
			_callButton.setSize(this.stage.stageWidth - 40, 60);
			addChild(_callButton);
		}
		
	}

}