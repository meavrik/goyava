package screens 
{
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import panels.addItemPanel;
	import popups.PopupsController;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenShopping extends PanelScreen 
	{
		private var _listScreen:BaseListScreen;
		private var _addItemScreen:addItemPanel;
		private var _addButton:Button;
		
		public function ScreenShopping() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "לוח יד שניה";

			this._addButton = new Button();
			this._addButton.label = "פרסם פריט למכירה\נתינה";
			this._addButton.move(10, 10);
			this._addButton.setSize(this.width - 20, 60);
			this._addButton.addEventListener(Event.TRIGGERED, onAddClick);
			addChild(this._addButton);
			
			_listScreen = new BaseListScreen()
			
			_listScreen.dataProvider = new ListCollection(
			 [
				 { text: "שולחן" },
				 { text: "כדור" },
				 { text: "ספה" },
				 { text: "לגו" },
			 ]);
			 
			_listScreen.move(0, this._addButton.bounds.bottom + 10);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);

			addChild(_listScreen);
			
			_addItemScreen = new addItemPanel();
			_addItemScreen.width = stage.stageWidth;
			_addItemScreen.move(0, 100);
		}
		
		private function onAddClick(e:Event):void 
		{
			PopupsController.addPopUp(_addItemScreen);
		}

	}

}