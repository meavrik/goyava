package screens 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import entities.GroupEntity;
	import entities.GroupsListEntity;
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import panels.AddNewGroupPanel;
	import panels.GroupDetailsPanel;
	import popups.PopupsController;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenGroups extends PanelScreen 
	{
		private var _addButton:Button;
		private var _listScreen:BaseListScreen;
		//private var _groupDetailsPanel:GroupDetailsPanel;
		
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
			this._addButton.setSize(this.width - 20, UiGenerator.getInstance().buttonHeight);
			this._addButton.addEventListener(Event.TRIGGERED, onAddClick);
			addChild(this._addButton);
			
			_listScreen = new BaseListScreen()
			
			_listScreen.dataProvider = new ListCollection(
			 [
				 /*{ text: "(3) קבוצת ריצה" },
				 { text: "(11) קבוצת כדורגל" },
				 { text: "(1) קבוצת פוקר" },
				 { text: "(5) d&d" },*/
			 ]);
			 
			_listScreen.move(0, this._addButton.bounds.bottom + 10);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);
			_listScreen.addEventListener(Event.TRIGGERED, onGroupItemClick);

			addChild(_listScreen);
			
			loadData()
		}
		
		private function loadData():void 
		{
			//Entity.load(GroupsEntity, GlobalDataProvider.groupsDataProvier.id, onLoadDataComplete, onLoadDataFail);
			Entity.load(GroupsListEntity, GlobalDataProvider.groupsDataProvier.id, onLoadDataComplete, onLoadDataFail);
		}
		
		private function onLoadDataComplete(entity:GroupsListEntity):void 
		{
			
			GlobalDataProvider.groupsDataProvier.itemsArr = entity.itemsArr;
			if (_listScreen.dataProvider)
			{
				_listScreen.dataProvider.removeAll();
			}
			//_loadItemsLabel.removeFromParent(true);
			
			if (entity.itemsArr)
			{
				Flox.logInfo("load GROUPS complete " + entity.itemsArr.join(","));
				var item:Object;
				for (var i:int = 0; i < entity.itemsArr.length; i++) 
				{
					item = entity.itemsArr[i];
					if (item.name)
					{
						_listScreen.dataProvider.addItem( { text:item.name ,id:item.id } );
					}
					
				}
			}
		}
		
		private function onLoadDataFail():void 
		{
			//_loadItemsLabel.removeFromParent(true);
			Flox.logInfo("load GROUPS data fail");
		}
		
		private function onAddClick(e:Event):void 
		{
			var newGroupPanel:AddNewGroupPanel = new AddNewGroupPanel();
			newGroupPanel.addEventListener(Event.CLOSE, onPanelClose);
			PopupsController.addPopUp(newGroupPanel);
		}
		
		private function onPanelClose(e:Event):void 
		{
			loadData();
		}
		
		private function onGroupItemClick(e:Event):void 
		{
			//var groupDetailsPanel:GroupDetailsPanel = new GroupDetailsPanel(GlobalDataProvider.groupsDataProvier.itemsArr[_listScreen.selectedIndex]);
			var groupDetailsPanel:GroupDetailsPanel = new GroupDetailsPanel(_listScreen.selectedItem.id);
			PopupsController.addPopUp(groupDetailsPanel);
		}
		
	}

}