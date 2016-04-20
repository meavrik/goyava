package screens 
{
	import feathers.controls.AutoComplete;
	import feathers.controls.PickerList;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import screens.consts.CategoriesConst;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class BaseScreenListSearch extends BaseScreenList 
	{
		protected var _categoryPicker:PickerList;
		protected var _searchInput:AutoComplete;
		
		public function BaseScreenListSearch() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			this._searchInput = new AutoComplete();
			this._searchInput.autoCompleteDelay = .1;
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
			this._searchInput.setSize(stage.stageWidth / 2 - 5, UiGenerator.getInstance().fieldHeight);
			this._searchInput.move(5, 10);
			//this._searchInput.addEventListener(Event.OPEN, onAutoCompleteOpen);
			//this._searchInput.addEventListener(Event.CLOSE, onAutoCompleteClose);
			//this._searchInput.addEventListener(Event.CHANGE, onAutoCompleteChange);
			this.addChild(this._searchInput);
			
			_categoryPicker = new PickerList();
			_categoryPicker.customListStyleName = PickerList.DEFAULT_CHILD_STYLE_NAME_LIST;
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
			
			_list.move(0, _categoryPicker.bounds.bottom + 10);
		}
	
		override public function handleNewData():void 
		{
			super.handleNewData();

			if (_dataProviderArr && _dataProviderArr.length)
			{
				var obj:Object;
				var indexCount:int = 0;
				var autoCompleteArr:Vector.<String> = new Vector.<String>;
				
				for each (var item:Object in _dataProviderArr) 
				{
					autoCompleteArr.push(item.name);
				}
				
				this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
			}
		}
		

		override protected function populateList():void 
		{
			super.populateList();
			//var count:int = 0;
			if (_categoryPicker.dataProvider)
			{
				_categoryPicker.dataProvider.removeAll();
			}
			
			for each (var categoryOption:String in _categoriesArr) 
			{
				_categoryPicker.dataProvider.addItem( { text:categoryOption, code:categoryOption } );
			}
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
				this._list.dataProvider.data[0] = 
				{	
					header : "לא נמצאו התאמות",
					children:[]
				}
			}
			
			_list.dataProvider.updateItemAt(0);
		}

	}

}