package screens 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Query;
	import data.GlobalDataProvider;
	import feathers.controls.GroupedList;
	import feathers.controls.ImageLoader;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.layout.AnchorLayout;
	import log.Logger;
	import screens.consts.CategoriesConst;
	import starling.events.Event;
	import ui.buttons.AddButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class BaseScreenList extends BaseScreenMain 
	{
		protected var _list:GroupedList;
		protected var _dataProviderArr:Vector.<Entity>;
		protected var _itemsByCategory:Array = new Array();
		protected var _categoriesArr:Array;
		protected var _selectedItemData:Entity;
		
		public function BaseScreenList() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			this.layout = new AnchorLayout();
			
			
			_list = new GroupedList();
			_list.setSize(this.width, this.height - _list.bounds.top - 170);
			_list.move(0, 0);
			_list.dataProvider = new HierarchicalCollection([])
			_list.addEventListener(Event.TRIGGERED, onItemClick);
			
			_list.itemRendererFactory = custemItemRenderer
			var iconUrl:String = getIconUrl()
			
			if (iconUrl)
			{
				_list.itemRendererProperties.iconSourceFunction = function(item:Object):String
				{
					return iconUrl;
				}

				_list.itemRendererProperties.iconLoaderFactory = function():ImageLoader
				{
					var loader:ImageLoader = new ImageLoader();
					loader.width = 120;
					loader.height =100;
					return loader;
				}
			} 
			
			addChild(_list);
			
			this.backButtonHandler = this.goBack;
		}
		
		
		protected function getIconUrl():String
		{
			//return AssetsHelper.SERVER_ASSETS_URL + "secondhand/table1.jpg";
			return "";// AssetsHelper.SERVER_ASSETS_URL + "secondhand/table1.jpg";
		}
		
		protected function loadPageData(EntityClass:Class,constraints:String=null,...rest):void
		{
			showPreloader();
			if (!_dataProviderArr)
			{
				var query:Query = new Query(EntityClass, constraints, rest);
				query.find(onDataComplete, onLoadDataError);
				query.limit = 20;
			}
		}
		
		protected function onDataComplete(items:Array):void 
		{
			trace("onDataComplete : " + items);
			_dataProviderArr = new Vector.<Entity>;
			for each (var item:Entity in items) 
			{
				_dataProviderArr.push(item);
				if (item.ownerId == GlobalDataProvider.myUserData.ownerId)
				{
					GlobalDataProvider.addOwnedEntity(item)
				}
			}
			handleNewData();
		}
		
		protected function onLoadDataError(error:String):void 
		{
			Logger.logError(this, "error getting data : " + error);
		}
		
		protected function assignAddButton():void
		{
			var addButton:AddButton = new AddButton(onAddClick);
			addButton.x = stage.stageWidth - (addButton.width + 20);
			addButton.y = this.height - (addButton.height + 10)-_list.bounds.top;
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
		

		public function handleNewData():void
		{
			removePreloader();
			if (_list.dataProvider)
			{
				_list.dataProvider.removeAll();
			}
			_itemsByCategory = new Array();
			
			_categoriesArr = [CategoriesConst.All];
			
			if (_dataProviderArr && _dataProviderArr.length)
			{
				var obj:Object;
				var indexCount:int = 0;
				//var autoCompleteArr:Vector.<String> = new Vector.<String>;
				
				for each (var item:Object in _dataProviderArr) 
				{
					//autoCompleteArr.push(item.name);

					if (item.category)
					{
						if (!_itemsByCategory[item.category])
						{
							_itemsByCategory[item.category] = new Array();
						}
					}
					
					obj = getListItemObject(item)
					obj.index = indexCount;
					if (_itemsByCategory[item.category] is Array)
					{
						_itemsByCategory[item.category].push(obj);
					} else
					{
						if (!_itemsByCategory[CategoriesConst.All])
						{
							_itemsByCategory[CategoriesConst.All] = new Array();
						}
						_itemsByCategory[CategoriesConst.All].push(obj);
						
					}
					
					indexCount ++;
					
					if (_categoriesArr.indexOf(item.category) ==-1)
					{
						_categoriesArr.push(item.category);
					}
				}
				
				populateList();
				_list.dataProvider.updateItemAt(0);
			}
		}
		
		
		protected function getListItemObject(item:Object):Object
		{
			var obj:Object = new Object();
			//obj.label = item.name+ " " + FormatHelper.getMoneyFormat(item.price, GlobalDataProvider.currencySign);
			obj.label = item.name;
			
			return obj;
		}
		
		protected function populateList():void
		{
			var count:int = 0;

			for each (var categoryOption:String in _categoriesArr) 
			{
				var childArr:Array = _itemsByCategory[categoryOption];
				
				if (childArr)
				{
					this._list.dataProvider.data[count] = 
					{	
						header : categoryOption,
						children: childArr
					}
					count ++;
				}
			}
		}
		
		protected function onItemClick(e:Event):void 
		{
			_selectedItemData = _dataProviderArr[_list.selectedItem.index];
		}
		
	}

}