package 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import panels.PersonalPanel;
	import popups.PopupsController;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainScreenTopPanel extends Header 
	{
		private var _myPlaceButton:Button;

		public function MainScreenTopPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, 100);
			title = "ברוך הבא";
			
			this._myPlaceButton = new Button();
			this._myPlaceButton.label = "אישי";
			this._myPlaceButton.setSize(100, 60);
			this._myPlaceButton.move(this.stage.stageWidth - (this._myPlaceButton.width + 10), 10);
			this._myPlaceButton.addEventListener(Event.TRIGGERED, onClick);
			
			addChild(_myPlaceButton);
		}
		
		private function onClick(e:Event):void 
		{
			PopupsController.addPopUp(new PersonalPanel())
		}

	}

}