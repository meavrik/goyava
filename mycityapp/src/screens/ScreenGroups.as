package screens 
{
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.data.ListCollection;
	import panels.AddNewGroupPanel;
	import panels.ViewGroupDetailsPanel;
	import popups.PopupsController;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenGroups extends ScreenSubMain 
	{
		private var _listScreen:BaseListScreen;

		public function ScreenGroups() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "חפש אנשים למטרות משותפות"
			
			_listScreen = new BaseListScreen()
			_listScreen.dataProvider = new ListCollection( [ ]);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);
			_listScreen.addEventListener(Event.TRIGGERED, onGroupItemClick);
			addChild(_listScreen);
			
			if (_listScreen.dataProvider)
			{
				_listScreen.dataProvider.removeAll();
			}
			var arr:Array = GlobalDataProvider.commonEntity.groups;
			if (arr)
			{
				Flox.logInfo("load GROUPS complete " + arr.join(","));
				var item:Object;
				for (var i:int = 0; i < arr.length; i++) 
				{
					item = arr[i];
					if (item.name)
					{
						_listScreen.dataProvider.addItem( { text:item.name ,id:item.id } );
					}
				}
			}
		}
		
		private function onAddClick(e:Event):void 
		{
			var newGroupPanel:AddNewGroupPanel = new AddNewGroupPanel();
			newGroupPanel.addEventListener(Event.CLOSE, onPanelClose);
			PopupsController.addPopUp(newGroupPanel);
		}
		
		private function onPanelClose(e:Event):void 
		{
			//loadData();
		}
		
		override protected function customHeaderFactory():Header 
		{
			var header:Header = super.customHeaderFactory();
			var addButton:Button = new Button();
			addButton.label = "+";
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			addButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			header.rightItems = new <DisplayObject>[addButton];
			return header
		}
		
		private function onGroupItemClick(e:Event):void 
		{
			//var groupDetailsPanel:GroupDetailsPanel = new GroupDetailsPanel(GlobalDataProvider.groupsDataProvier.itemsArr[_listScreen.selectedIndex]);
			var groupDetailsPanel:ViewGroupDetailsPanel = new ViewGroupDetailsPanel(_listScreen.selectedItem.id);
			PopupsController.addPopUp(groupDetailsPanel);
		}
		
	}

}