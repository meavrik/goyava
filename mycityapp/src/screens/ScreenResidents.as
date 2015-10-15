package screens 
{
	import data.GlobalDataProvider;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenResidents extends PanelScreen 
	{
		private var _listScreen:BaseListScreen;
		private var _allArr:Array;
		
		public function ScreenResidents() 
		{
			super();

			title = "רשימת תושבים"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_listScreen = new BaseListScreen()
			_listScreen.dataProvider = new ListCollection( []);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);
			
			var arr:Array = GlobalDataProvider.residentsDataProvier.itemsArr;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				_listScreen.dataProvider.addItem( { text:arr[i].name+ " " + arr[i].address } );
			}
			addChild(_listScreen);
		}
		
	}

}