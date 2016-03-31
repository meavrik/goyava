package screens.mainMenu 
{
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TabBar;
	import feathers.core.FeathersControl;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.skins.StandardIcons;
	import starling.display.Graphics;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.ItemCounter;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainMenuList extends ScrollContainer 
	{
		private var _list:List;
		private var _dataProvider:Object;
		private var _tab:MainTabBar;
		
		public function MainMenuList(dataProvider:Object) 
		{
			super();
			this._dataProvider = dataProvider;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_tab = new MainTabBar();

			var tabInfo:Array = [];
			
			for (var i:int = 0; i < this._dataProvider.length; i++) 
			{
				tabInfo.push({ label: this._dataProvider[i].header })
			}
			/*_tab.dataProvider = new ListCollection([ { label: this._dataProvider[0].header },
					{ label: this._dataProvider[1].header },
					{ label: this._dataProvider[2].header },
			]);*/
			_tab.dataProvider = new ListCollection(tabInfo);
			_tab.setSize(this.stage.stageWidth, 80);
			_tab.addEventListener( Event.CHANGE, tabs_changeHandler );
			
			addChild(_tab)
			
			
			this._list = new List();
			//this._list.dataProvider = new HierarchicalCollection(this._dataProvider);
			this._list.dataProvider = new ListCollection(this._dataProvider[0].children);

			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;
			var count:int;
			
			this._list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				//var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				
				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "label";
				
				renderer.iconSourceField = "thumbnail";
				renderer.accessoryField = "accessory";

				//renderer.accessoryFunction = itemRendererAccessorySourceFunction;
				
				renderer.height = 130;
				renderer.iconOffsetX = -80;
				renderer.labelOffsetX = -100;
				renderer.labelOffsetY = -20;
				
				trace(" count " + count);

				var subLabel:Label = new Label();
				subLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);
				subLabel.text = _dataProvider[0].children[count].subText;
				subLabel.x = 150;
				subLabel.y = 70;
				renderer.addChild(subLabel);
				
				//renderer.itemHasAccessory = false;
				renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_BOTTOM;
				//renderer.itemIndex++
				renderer.isEnabled = false;
				/*var counter:ItemCounter = new ItemCounter();
				counter.x = 130;
				counter.y = 10;
				renderer.addChild(counter);*/

				renderer.iconPosition = DefaultListItemRenderer.ICON_POSITION_RIGHT
				renderer.horizontalAlign = DefaultListItemRenderer.HORIZONTAL_ALIGN_RIGHT;

				//renderer.selectableField = "isSelected";
				//renderer.selectableFunction = null
				//renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				//renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_LEFT; 

				renderer.index=count;

				count++;
				return renderer;
			};
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this._list.setSize(this.stage.stageWidth, this.stage.stageHeight - 400);
			this._list.move(0, this._tab.bounds.bottom);
			
			this.addChild(this._list);
		}
		
		private function custemLabelFactory():String 
		{
			return "test";
		}
		
		public function update(index:int):void 
		{
			this._list.dataProvider.updateItemAt(index);
		}
		
		public function focus():void 
		{
			if (_list)
			{
				_list.selectedItem = null;
			}
		}
		
		private function tabs_changeHandler(e:Event):void 
		{
			_list.dataProvider = new ListCollection(this._dataProvider[_tab.selectedIndex].children);
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function list_changeHandler(event:Event):void
		{
			if (!this._list.selectedItem) return;
			var eventType:String = this._list.selectedItem.event as String;

			this.dispatchEventWith(eventType,true);
		}
		
	}

}