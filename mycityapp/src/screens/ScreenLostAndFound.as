package screens 
{
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.LostAndFoundEntity;
	import screens.consts.CategoriesConst;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	//public class ScreenLostAndFound extends ScreenSubMain 
	public class ScreenLostAndFound extends ScreenListSearch 
	{
		//private var _list:GroupedList;
		
		public function ScreenLostAndFound() 
		{
			super();
			title = "אבדות ומציאות";
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			this._searchInput.prompt = "חפש מוצר";
		}
		
		/*override protected function getListItemObject(item:Object):Object 
		{
			var obj:Object = new Object();
			obj.label = item.name+ " " + FormatHelper.getMoneyFormat(item.price, GlobalDataProvider.currencySign);
			
			return obj;
		}*/
		
		override protected function get getEventString():String 
		{
			return AppDataLoader.LOST_FOUND_DATA_LOADED;
		}
		
		override protected function get getDataProviderArr():Vector.<*>
		{
			return GlobalDataProvider.lostAndFound as Vector.<*>;
		}
		
		override protected function get categoryListArr():Array 
		{
			return CategoriesConst.sellItemsCategories;
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			var sellData:LostAndFoundEntity = GlobalDataProvider.lostAndFound[_list.selectedItem.index];
			dispatchEventWith(ScreenEnum.LOST_AND_FOUND_SCREEN, false, sellData)
		}

		override protected function handleAddClick():void 
		{
			super.handleAddClick();
			dispatchEventWith(ScreenEnum.LOST_FOUND_ITEM_ADD_SCREEN)
		}
		
		/*override protected function initialize():void 
		{
			super.initialize();
			
			this._list = new GroupedList();
			this._list.dataProvider = new HierarchicalCollection(
			[
				{
					header: "אבדות",
					children:
					[
						{ label: "נאבד שעון ברחוב ה.." },
					]
				},
				{
					header: "מציאות",
					children:
					[
						{ label: "נמצא שעון ברחוב..." },
						{ label: "משקפיים" },
					]
				},
			]);

			this._list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "label";
				return renderer;
			};
			
			//this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this.addChild(this._list);
			
			this._list.setSize(this.width, this.height);
		}
	
		override protected function customHeaderFactory():Header 
		{
			var header:Header=super.customHeaderFactory();
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "עבדה";
			addButton.addEventListener(Event.TRIGGERED, addButton_triggeredHandler);
			
			var addButton2:Button = new Button();
			addButton2.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			addButton2.label = "מציאה";
			addButton2.addEventListener(Event.TRIGGERED, addButton_triggeredHandler);
			
			header.rightItems = new <DisplayObject>
			[
				addButton,addButton2
			];
			return header
		}
		
		private function addButton_triggeredHandler(e:Event):void 
		{
			
		}*/
		
		
	}

}