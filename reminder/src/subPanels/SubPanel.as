package subPanels 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.core.IFeathersControl;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SubPanel extends Panel
	{
		private var _closeButton:Button;
		
		public function SubPanel() 
		{
			super();
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			headerFactory = function():IFeathersControl
			 {
				 var header:Header = new Header();
				 var closeButton:Button = new Button();
				 closeButton.label = "X";
				 closeButton.addEventListener( Event.TRIGGERED, onCloseClick );
				 header.rightItems = new <DisplayObject>[ closeButton ];
				 return header;
			 };
		}

		override protected function initialize():void 
		{
			super.initialize();
			
		}

		private function onCloseClick(e:Event):void 
		{
			closeMe()
		}
		
		protected function closeMe():void
		{
			removeFromParent();
		}
		
	}

}