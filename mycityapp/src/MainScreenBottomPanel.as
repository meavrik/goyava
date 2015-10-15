package 
{
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainScreenBottomPanel extends FeathersControl 
	{
		private const PHONE_NUMBER:String = "050-12345697";
		private var _callButton:Button;
		
		public function MainScreenBottomPanel() 
		{
			super();
			
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, 120);
			
			_callButton = new Button();
			_callButton.styleNameList.add( Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON );
			_callButton.label = "התקשר לקב''ט : " + PHONE_NUMBER;
			_callButton.move(20, 10);
			_callButton.setSize(this.stage.stageWidth - 40, 60);
			_callButton.addEventListener(Event.TRIGGERED, onClick);
			addChild(_callButton);
		}
		
		private function onClick(e:Event):void 
		{
			const callURL:String = "tel:" + PHONE_NUMBER;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
	}

}