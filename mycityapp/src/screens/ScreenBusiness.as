package screens 
{
	import assets.AssetsHelper;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.BusinessEntity;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import feathers.events.FeathersEventType;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import screens.consts.CategoriesConst;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenBusiness extends ScreenSubMain 
	{
		private var _itemsByCategory:Array;
		private var _list:GroupedList;
		private var _dataProviderArr:Vector.<BusinessEntity>;
		private var _searchInput:AutoComplete;
		private var _categoryPicker:PickerList;
		
		public function ScreenBusiness() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "עסקים בעיר";
			
			this._searchInput = new AutoComplete();
			this._searchInput.autoCompleteDelay = .1;
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT);
			this._searchInput.prompt = "חפש עסק";
			this._searchInput.setSize(stage.stageWidth / 2 - 5, UiGenerator.getInstance().fieldHeight);
			this._searchInput.move(5, 10);
			//this._searchInput.addEventListener(Event.OPEN, onAutoCompleteOpen);
			//this._searchInput.addEventListener(Event.CLOSE, onAutoCompleteClose);
			//this._searchInput.addEventListener(Event.CHANGE, onAutoCompleteChange);
			this.addChild(this._searchInput);
			
			
			_categoryPicker = new PickerList();
			_categoryPicker.customListStyleName = PickerList.DEFAULT_CHILD_NAME_LIST;
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
			
			
			
			_list = new GroupedList();
			_list.move(0, this._searchInput.bounds.bottom + 10);
			_list.dataProvider = new HierarchicalCollection([]);
			
			var index:int = 0;
			 _list.itemRendererFactory = function():IGroupedListItemRenderer
			 {
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.labelField = "text";
				renderer.accessoryField = "address";
				renderer.iconSourceField = "thumbnail";
				
				var contactButn:Button = new Button();
				contactButn.label = _dataProviderArr[index].phone;
				contactButn.width = 220;
				//contactButn.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
				contactButn.move(stage.stageWidth - (contactButn.width + 10), 12);
				contactButn.addEventListener(Event.TRIGGERED, onContactButnClick);
				renderer.addChild(contactButn);
				
				var label:Label = new Label();
				//label.text = GlobalDataProvider.commonEntityy.residents[index].address//"כתובת";
				label.text = _dataProviderArr[index].address;
				label.styleNameList.add(Label.ALTERNATE_NAME_DETAIL);
				label.move(35, 55);

				renderer.addChild(label);
				index++;
				return renderer;
			 };
			 
			_list.addEventListener( Event.CHANGE, list_changeHandler );
			_list.setSize(this.width, this.height - _list.bounds.top);
			 
			this.addChild(_list);
			 
			if (GlobalDataProvider.businesses && GlobalDataProvider.businesses.length)
			{
				handleNewData();
			} 
			
			AppDataLoader.getInstance().addEventListener(AppDataLoader.BUSINESS_DATA_LOADED, onBusinessDataLoaded);
		}
		
		private function onBusinessDataLoaded(e:Event):void 
		{
			handleNewData();
			_list.dataProvider.updateItemAt(0);
		}
		
		public function handleNewData():void
		{
			_dataProviderArr = GlobalDataProvider.businesses;
			
			_itemsByCategory = new Array();
			var obj:Object;
			
			var indexCount:int = 0;
			var autoCompleteArr:Vector.<String> = new Vector.<String>;

			//var texture:Texture = AssetsHelper.getInstance().assetManager.getTexture("table1");
			
			for each (var item:BusinessEntity in _dataProviderArr) 
			{
				autoCompleteArr.push(item.name);
				
				if (!_itemsByCategory[item.category])
				{
					_itemsByCategory[item.category] = new Array();
				}
				
				obj = new Object();
				obj.text = item.name;
				obj.itemIndex = indexCount;
				obj.address = item.address;
				_itemsByCategory[item.category].push(obj);
				indexCount ++;
			}
			
			this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
			
			populateList()
		}
		
		private function populateList():void
		{
			var count:int = 0;
			if (_categoryPicker.dataProvider)
			{
				_categoryPicker.dataProvider.removeAll();
			}
			
			for (var i:int = 0; i < CategoriesConst.businessCategories.length; i++) 
			{
				_categoryPicker.dataProvider.addItem( { text:CategoriesConst.businessCategories[i], code:i } );
				
				var categoryName:String = CategoriesConst.businessCategories[i];
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
			_categoryPicker.dataProvider.addItem( { text:"הכול", code:CategoriesConst.businessCategories.length } );
		}
		
		private function onCategorySort(e:Event):void 
		{
			if (!_categoryPicker.selectedItem) return;
			
			if (_list.dataProvider)
			{
				_list.dataProvider.removeAll();
			}
			
			var categoryName:String = _categoryPicker.selectedItem.text;
			if (_itemsByCategory[categoryName])
			{
				this._list.dataProvider.data[0] = 
				{	
					header : categoryName,
					children: _itemsByCategory[categoryName]
				}
			} else
			{
				populateList();
			}
		}
		
		
		
		
		
		
		
		private function onContactButnClick(e:Event):void 
		{
			var contactButn:Button = e.currentTarget as Button;
			const callURL:String = "tel:" + contactButn.label;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
		private function list_changeHandler(e:Event):void 
		{
			
		}
		
	}

}