package ui 
{
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GoTabList extends ScrollContainer 
	{
		private var _onCurrentList	:Object;
		private var _dataProvider	:Object;
		private var _tab			:GoTab;
		private var _lists			:Vector.<Sprite>;
		private var _selectableList:Boolean;
		private var _yOffset:Number;
		
		public function GoTabList(dataProvider:Object, selectableList:Boolean = true, yOffset:Number = 0)
		{
			super();
			this._yOffset = yOffset;
			this._selectableList = selectableList;
			this._dataProvider = dataProvider;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_tab = new GoTab(this._dataProvider.length);
			_tab.setSize(this.stage.stageWidth, 100);

			_lists = new Vector.<Sprite>;
			
			var tabInfo:Array = [];
			
			var list:Scroller;
			var tabDataObject:Object;
			for (var i:int = 0; i < this._dataProvider.length; i++) 
			{
				tabDataObject = { label: this._dataProvider[i].header, defaultIcon: this._dataProvider[i].defaultIcon };
				tabInfo.push(tabDataObject);
				if (this._dataProvider[i].children[0].header)
				{
					list = addGroupList(this._dataProvider[i].children);
				}
				else
				{
					list = addList(this._dataProvider[i].children);
				}
				
				list.addEventListener(Event.CHANGE, onListItemSelect);
				list.setSize(this.stage.stageWidth, this.stage.stageHeight - (_tab.bounds.bottom + _yOffset));
				list.move(0, _tab.bounds.bottom);
				
				_lists.push(list);
			}
			
			_tab.dataProvider = new ListCollection(tabInfo);
			_tab.addEventListener( Event.CHANGE, onTabSelect );
			
			setNewList(0);
		}
		
		private function addGroupList(data:Object):Scroller 
		{
			var count:int;
			var list:GroupedList = new GroupedList();
			list.dataProvider = new HierarchicalCollection(data);
			
			list.isSelectable = _selectableList;
			list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				//handleListRenderer(renderer, data[count]);
				handleListRenderer(renderer, data[0].children[count]);
				count++;
				return renderer;
			};

			return list;
		}
		
		private function addList(data:Object):Scroller 
		{
			var list:List = new List();
			list.dataProvider = new ListCollection(data);

			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			//var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;
			var count:int;
			list.isSelectable = _selectableList;
			list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				handleListRenderer(renderer,data[count])

				count++;
				return renderer;
			};

			return list;
		}
		
		private function handleListRenderer(renderer:BaseDefaultItemRenderer,itemData:Object):void
		{
			renderer.isQuickHitAreaEnabled = _selectableList;
			renderer.labelField = "label";
			renderer.iconSourceField = "thumbnail";
			renderer.accessoryField = "accessory";
			renderer.height = 120;
			
			if (itemData)
			{
				if (itemData.thumbnail)
				{
					renderer.iconOffsetX = -80;
					renderer.labelOffsetX = -100;
				}

				if (itemData.subText)
				{
					var subLabel:Label = new Label();
					subLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);
					subLabel.text = itemData.subText;
					
					subLabel.y = 70;
					subLabel.x = itemData.thumbnail?150:40;
					renderer.addChild(subLabel);
					renderer.labelOffsetY = -10;
				}
			}
			
			//renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_BOTTOM;
			//renderer.isEnabled = false;
			//renderer.iconPosition = DefaultListItemRenderer.ICON_POSITION_RIGHT
			renderer.horizontalAlign = DefaultListItemRenderer.HORIZONTAL_ALIGN_RIGHT;
		}
		
		public function getList(index:int):Sprite
		{
			return _lists[index];
		}
		
		private function custemLabelFactory():String 
		{
			return "test";
		}
		
		public function update(index:int):void 
		{
			this._onCurrentList.dataProvider.updateItemAt(index);
		}
		
		public function focus():void 
		{
			if (_onCurrentList)
			{
				_onCurrentList.selectedItem = null;
			}
		}
		
		private function onTabSelect(e:Event):void 
		{
			setNewList(_tab.selectedIndex);
		}
		
		private function setNewList(selectedIndex:int):void 
		{
			if (_onCurrentList)
			{
				_onCurrentList.removeFromParent();
			}
			_onCurrentList = _lists[selectedIndex];
			addChild(_onCurrentList as FeathersControl);
			addChild(_tab);
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function onListItemSelect(event:Event):void
		{
			if (!this._onCurrentList.selectedItem) return;
			var eventType:String = this._onCurrentList.selectedItem.event as String;

			this.dispatchEventWith(eventType,true);
		}
		
	}

}