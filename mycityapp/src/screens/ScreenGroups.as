package screens 
{
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenGroups extends PanelScreen 
	{
		private var _addButton:Button;
		private var _listScreen:BaseListScreen;
		
		public function ScreenGroups() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "חפש אנשים למטרות משותפות"
			
			this._addButton = new Button();
			this._addButton.label = "צור קבוצה חדשה";
			this._addButton.move(10, 10);
			this._addButton.setSize(this.width - 20, 60);
			addChild(this._addButton);
			
			
			_listScreen = new BaseListScreen()
			
			_listScreen.dataProvider = new ListCollection(
			 [
				 { text: "(3) קבוצת ריצה" },
				 { text: "(11) קבוצת כדורגל" },
				 { text: "(1) קבוצת פוקר" },
				 { text: "(5) d&d" },
			 ]);
			 
			_listScreen.move(0, this._addButton.bounds.bottom + 10);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);

			addChild(_listScreen);
		}
		
	}

}