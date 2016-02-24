package screens 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Entity;
	import data.AppDataLoader;
	import entities.interfaces.ICategorizedEntity;
	import entities.SellItemEntity;
	import feathers.controls.AutoComplete;
	import feathers.controls.GroupedList;
	import feathers.controls.ImageLoader;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import screens.consts.CategoriesConst;
	import starling.display.Button;
	import starling.events.Event;
	import ui.buttons.AddButton;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenListSearch extends ScreenSubMain 
	{
		protected var _list:GroupedList;
		protected var _categoryPicker:PickerList;
		protected var _searchInput:AutoComplete;
		protected var _dataProviderArr:Vector.<*>;
		private var _itemsByCategory:Array = new Array();
		
		public function ScreenListSearch() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			//_categoryListArr = CategoriesConst.sellItemsCategories;
			//footerFactory = customFooterFactory;
			this._dataProviderArr = getDataProviderArr;
			
			this._searchInput = new AutoComplete();
			this._searchInput.autoCompleteDelay = .1;
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
			//this._searchInput.prompt = "חפש מוצר";
			this._searchInput.setSize(stage.stageWidth / 2 - 5, UiGenerator.getInstance().fieldHeight);
			this._searchInput.move(5, 10);
			//this._searchInput.addEventListener(Event.OPEN, onAutoCompleteOpen);
			//this._searchInput.addEventListener(Event.CLOSE, onAutoCompleteClose);
			//this._searchInput.addEventListener(Event.CHANGE, onAutoCompleteChange);
			this.addChild(this._searchInput);
			
			_categoryPicker = new PickerList();
			//_categoryPicker.customListStyleName = PickerList.DEFAULT_CHILD_STYLE_NAME_LIST;
			_categoryPicker.customListStyleName = PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON;
			_categoryPicker.prompt = "סנן לפי קטגוריה";
			_categoryPicker.setSize(10, 10);
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
			_categoryPicker.labelField = "text";
			_categoryPicker.selectedIndex = -1;
			addChild(_categoryPicker);
			 
			for (var i:int = 0; i < categoryListArr.length; i++) 
			{
				_categoryPicker.dataProvider.addItem( { text:categoryListArr[i], code:i } );
			}
			_categoryPicker.dataProvider.addItem( { text:"הכול", code:categoryListArr.length } );
			

			_list = new GroupedList();
			_list.setSize(this.width, this.height - _list.bounds.top - 170);
			_list.move(0, _categoryPicker.bounds.bottom + 10);
			_list.dataProvider = new HierarchicalCollection([])
			_list.addEventListener(Event.TRIGGERED, onItemClick);
			
			_list.itemRendererFactory = custemItemRenderer
			
			_list.itemRendererProperties.iconSourceFunction = function(item:Object):String
			{
				return AssetsHelper.SERVER_ASSETS_URL + "secondhand/table1.jpg";
			}

			_list.itemRendererProperties.iconLoaderFactory = function():ImageLoader
			{
				var loader:ImageLoader = new ImageLoader();
				loader.width = 100;
				loader.height = 80;
				return loader;
			}
			addChild(_list);

			if (_dataProviderArr && _dataProviderArr.length)
			{
				handleNewData();
			} else
			{
				showPreloader();
			}
			//AppDataLoader.getInstance().addEventListener(AppDataLoader.SELLITEMS_DATA_LOADED, onDataLoaded);
			AppDataLoader.getInstance().addEventListener(getEventString, onDataLoaded);
			
			
			var addButton:AddButton = new AddButton(onAddClick);
			addButton.x = stage.stageWidth - (addButton.width + 20);
			addButton.y = this.height - (addButton.height + 10)-_list.bounds.top;
			//editButton.addEventListener(Event.TRIGGERED, onAddClick);
			addChild(addButton);
		}
		
		
		protected function custemItemRenderer():IGroupedListItemRenderer
		{
			var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
			renderer.isQuickHitAreaEnabled = true;
			renderer.labelField = "label";
			//renderer.iconSourceField = "thumbnail";
			return renderer;
		}
		
		private function onAddClick(e:Event):void 
		{
			handleAddClick();
		}
		
		protected function handleAddClick():void 
		{
			
		}
		
		private function onDataLoaded(e:Event):void 
		{
			this._dataProviderArr = getDataProviderArr
			handleNewData();
		}
		
		
		protected function get getEventString():String
		{
			throw new Error("no EventString is set");
		}
		
		protected function get getDataProviderArr():Vector.<*>
		{
			throw new Error("no DataProviderArr is set");
		}
		
		protected function get categoryListArr():Array
		{
			throw new Error("no categoryListArr is set");
		}
		
		public function handleNewData():void
		{
			removePreloader();
			if (_list.dataProvider)
			{
				_list.dataProvider.removeAll();
			}
			_itemsByCategory = new Array();
			
			if (_dataProviderArr && _dataProviderArr.length)
			{
				var obj:Object;
				var indexCount:int = 0;
				var autoCompleteArr:Vector.<String> = new Vector.<String>;
				
				for each (var item:Object in _dataProviderArr) 
				{
					autoCompleteArr.push(item.name);

					if (!_itemsByCategory[item.category])
					{
						_itemsByCategory[item.category] = new Array();
					}
					
					obj = getListItemObject(item)
					obj.index = indexCount;
					_itemsByCategory[item.category].push(obj);
					indexCount ++;
				}
				
				this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
				
				populateList();
			}
		}
		
		
		protected function getListItemObject(item:Object):Object
		{
			var obj:Object = new Object();
			//obj.label = item.name+ " " + FormatHelper.getMoneyFormat(item.price, GlobalDataProvider.currencySign);
			obj.label = item.name;
			
			return obj;
		}
		
		private function populateList():void
		{
			var count:int = 0;
			
			for each (var categoryName:String in categoryListArr) 
			{
				//_categoryPicker.dataProvider.addItem( { text:categoryListArr[i], code:i } );
				var itemsInCategory:Array = _itemsByCategory[categoryName];
				
				if (itemsInCategory && itemsInCategory.length && _list.dataProvider.data)
				{
					_list.dataProvider.data[count] = 
					{	
						header : categoryName,
						children: itemsInCategory
					}
					count ++;
				}
			}
			//_categoryPicker.dataProvider.addItem( { text:"הכול", code:categoryListArr.length } );
			_list.dataProvider.updateItemAt(0);
		}
		
		private function onCategorySort(e:Event):void 
		{
			if (!_categoryPicker.selectedItem) return;
			
			if (_list.dataProvider)
			{
				_list.dataProvider.removeAll();
			}
			
			var categoryPickedName:String = _categoryPicker.selectedItem.text;
			if (_itemsByCategory[categoryPickedName])
			{
				this._list.dataProvider.data[0] = 
				{	
					header : categoryPickedName,
					children: _itemsByCategory[categoryPickedName]
				}
			} else if (categoryPickedName == CategoriesConst.All)
			{
				populateList();
			}
			else
			{
				//populateList()
				
				this._list.dataProvider.data[0] = 
				{	
					header : "לא נמצאו התאמות",
					children:[]
				}
			}
			
			_list.dataProvider.updateItemAt(0);
		}
		
		protected function onItemClick(e:Event):void 
		{
			//var entityData:Entity = getDataProviderArr[_list.selectedItem.index];
			//dispatchEventWith(ScreenEnum.SELL_ITEM_VIEW_SCREEN, false, entityData)
		}

		/*private function onAddClick(e:Event):void 
		{
			dispatchEventWith(ScreenEnum.SELL_ITEM_ADD_SCREEN)
		}
		
		protected function customFooterFactory():Header 
		{
			var footer:Header = new Header()
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "צור מודעה חדשה";
			addButton.x = 10;
			addButton.setSize(this.stage.stageWidth - 20, UiGenerator.getInstance().buttonHeight);
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			footer.rightItems = new <DisplayObject>[addButton];
			return footer
		}*/
	}

}