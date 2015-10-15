package screens 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import entities.CommonEntity;
	import entities.EntityIdEnum;
	import entities.SecondHandEntity;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import data.GlobalDataProvider;
	import panels.AddItemPanel;
	import panels.ItemDetailsPanel;
	import popups.PopupsController;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenSecondHand extends PanelScreen 
	{
		private var _listScreen:BaseListScreen;
		private var _addButton:Button;
		private var _loadItemsLabel:Label;
		
		public function ScreenSecondHand() 
		{
			super();
			
			title = "לוח יד שניה";
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			this._addButton = new Button();
			this._addButton.label = "פרסם פריט למכירה או נתינה";
			this._addButton.move(10, 10);
			this._addButton.setSize(this.width - 20, UiGenerator.getInstance().buttonHeight);
			this._addButton.addEventListener(Event.TRIGGERED, onAddClick);
			addChild(this._addButton);
			 
			_listScreen = new BaseListScreen()
			//_listScreen.isSelectable = false;
			_listScreen.dataProvider = new ListCollection([]);
			_listScreen.move(0, this._addButton.bounds.bottom + 10);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);
			_listScreen.addEventListener(Event.TRIGGERED, onItemClick);
			addChild(_listScreen);
			
			_loadItemsLabel = new Label();
			_loadItemsLabel.text = "טוען מידע...";
			_loadItemsLabel.setSize(this.width - 20, UiGenerator.getInstance().fieldHeight);
			_loadItemsLabel.move(10, this._addButton.bounds.bottom + 10);
			addChild(_loadItemsLabel);
			
			loadData();
		}
		
		private function loadData():void 
		{
			Entity.load(SecondHandEntity, EntityIdEnum.SECOND_HAND, onLoadDataComplete, onLoadDataFail);
		}
		
		private function onLoadDataComplete(entity:SecondHandEntity):void 
		{
			if (_listScreen.dataProvider)
			{
				_listScreen.dataProvider.removeAll();
			}
			
			_loadItemsLabel.removeFromParent(true);
			
			Flox.logInfo("load SECOND HAND data complete " + entity.itemsArr.join(","));
			GlobalDataProvider.secondHandDataProvier.itemsArr = entity.itemsArr;
			
			var item:Object;
			for (var i:int = 0; i < entity.itemsArr.length; i++) 
			{
				item = entity.itemsArr[i];
				_listScreen.dataProvider.addItem( { text:item.name + " " + GlobalDataProvider.currencySign + item.price } );
			}
		}
		
		private function onLoadDataFail():void 
		{
			_loadItemsLabel.removeFromParent(true);
			Flox.logInfo("load SECOND HAND data fail");
		}
		
		private function onItemClick(e:Event):void 
		{
			var itemDetailsPanel:ItemDetailsPanel = new ItemDetailsPanel(GlobalDataProvider.secondHandDataProvier.itemsArr[_listScreen.selectedIndex]);
			PopupsController.addPopUp(itemDetailsPanel);
		}

		private function onAddClick(e:Event):void 
		{
			var addItemScreen:AddItemPanel = new AddItemPanel();
			addItemScreen.width = stage.stageWidth;
			addItemScreen.move(0, 100);
			
			addItemScreen.addEventListener(Event.CLOSE, onPanelClose);
			PopupsController.addPopUp(addItemScreen);
		}
		
		private function onPanelClose(e:Event):void 
		{
			loadData();
		}

	}

}