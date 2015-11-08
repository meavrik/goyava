package screens 
{
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.TextInput;
	import feathers.core.ITextRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import flash.text.TextFormat;
	import helpers.FormatHelper;
	import screens.consts.Categories;
	import screens.enums.ScreenEnum;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenSecondHand extends ScreenSubMain 
	{
		private var _list:GroupedList;
		private var _categoryPicker:PickerList;
		private var _searchInput:AutoComplete;
		private var _itemsByCategory:Array;
		
		public function ScreenSecondHand() 
		{
			super();
			
			title = "לוח יד שניה";
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			this._searchInput = new AutoComplete();
			this._searchInput.autoCompleteDelay = .1;
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT);
			this._searchInput.prompt = "חפש מוצר";
			this._searchInput.setSize(stage.stageWidth / 2 - 5, UiGenerator.getInstance().fieldHeight);
			this._searchInput.move(5, 10);
			//this._searchInput.addEventListener(Event.OPEN, onAutoCompleteOpen);
			//this._searchInput.addEventListener(Event.CLOSE, onAutoCompleteClose);
			//this._searchInput.addEventListener(Event.CHANGE, onAutoCompleteChange);
			this.addChild(this._searchInput);
			
			_categoryPicker = new PickerList();
			_categoryPicker.customListStyleName = PickerList.DEFAULT_CHILD_NAME_LIST;
			_categoryPicker.prompt = "סנן לפי קטגוריה";
			_categoryPicker.listProperties.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 return renderer;
			 };
			 
			_categoryPicker.setSize(stage.stageWidth / 2 - 15, UiGenerator.getInstance().buttonHeight);
			_categoryPicker.addEventListener(Event.CHANGE, onCategorySort);
			_categoryPicker.move(stage.stageWidth / 2 + 5, 10);

			_categoryPicker.dataProvider = new ListCollection([]);
	 
			this._categoryPicker.labelField = "text";
			this._categoryPicker.selectedIndex = -1;
			
			addChild(_categoryPicker)
			 
			this._list = new GroupedList();
			this._list.move(0, _categoryPicker.bounds.bottom + 10);
			this._list.dataProvider = new HierarchicalCollection([])

			var arr:Array = GlobalDataProvider.commonEntity.sellItems;
			_itemsByCategory = new Array();
			var obj:Object;
			
			var indexCount:int = 0;
			var autoCompleteArr:Vector.<String> = new Vector.<String>;

			for each (var item:Object in arr) 
			{
				autoCompleteArr.push(item.name);
				
				if (!_itemsByCategory[item.category])
				{
					_itemsByCategory[item.category] = new Array();
				}
			
				obj = new Object();
				obj.label = item.name+ " " + FormatHelper.getMoneyFormat(item.price, GlobalDataProvider.currencySign);
				obj.index = indexCount;
				_itemsByCategory[item.category].push(obj);
				indexCount ++;
			}
			
			this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
			
			_list.setSize(this.width, this.height - _list.bounds.top - 90);
			_list.addEventListener(Event.TRIGGERED, onItemClick);
			
			this._list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "label";
				return renderer;
			};
			addChild(_list);
			
			//setSize(this.stage.stageWidth, this.stage.stageHeight);
			
			showAllItems()
		}
		
		private function showAllItems():void
		{
			var count:int = 0;
			if (_categoryPicker.dataProvider)
			{
				_categoryPicker.dataProvider.removeAll();
			}
			
			for (var i:int = 0; i < Categories.sellItemsCategories.length; i++) 
			{
				_categoryPicker.dataProvider.addItem( { text:Categories.sellItemsCategories[i], code:i } );
				
				var categoryName:String = Categories.sellItemsCategories[i];
				var childArr:Array = _itemsByCategory[categoryName];
				
				if (childArr)
				{
					this._list.dataProvider.data[count] = 
					{	
						header : categoryName,
						children: childArr
					}
					count ++;
				}
			}
			_categoryPicker.dataProvider.addItem( { text:"הכול", code:Categories.sellItemsCategories.length } );
		}
		
		private function onCategorySort(e:Event):void 
		{
			if (!_categoryPicker.selectedItem) return;
			
			if (_list.dataProvider)
			{
				_list.dataProvider.removeAll();
			}
			
			var categoryName:String=_categoryPicker.selectedItem.text
			if (_itemsByCategory[categoryName])
			{
				this._list.dataProvider.data[0] = 
				{	
					header : categoryName,
					children: _itemsByCategory[categoryName]
				}
			} else
			{
				showAllItems()
			}
		}
		
		private function onItemClick(e:Event):void 
		{
			//var sellData:Object = GlobalDataProvider.commonEntity.sellItems[_list.selectedItem.index];
			Entity.load(SellItemEntity, _list.selectedItem.index, onLoadDataComplete,null);
			

			
		}
		
		private function onLoadDataComplete(entity:SellItemEntity):void 
		{
			//var sellData:Object = GlobalDataProvider.commonEntity.sellItems[_list.selectedItem.index];
			//trace("onLoadDataComplete == " + entity.pictures);
			
			dispatchEventWith(ScreenEnum.SELL_ITEM_VIEW_SCREEN, false, entity)
		}

		private function onAddClick(e:Event):void 
		{
			/*var addItemScreen:AddNewItemPanel = new AddNewItemPanel();
			addItemScreen.width = stage.stageWidth;
			addItemScreen.move(0, 100);
			
			addItemScreen.addEventListener(Event.CLOSE, onPanelClose);
			PopupsController.addPopUp(addItemScreen);*/
			
			dispatchEventWith(ScreenEnum.SELL_ITEM_ADD_SCREEN)
		}
		
		private function onPanelClose(e:Event):void 
		{
			//loadData();
		}
		
		
		
		override protected function customHeaderFactory():Header 
		{
			var header:Header = super.customHeaderFactory();
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "+";
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			header.rightItems = new <DisplayObject>[addButton];
			return header
		}
	}

}