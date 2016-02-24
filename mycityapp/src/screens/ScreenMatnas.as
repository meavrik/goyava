package screens 
{
	import feathers.controls.GroupedList;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayoutData;
	import feathers.skins.StandardIcons;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMatnas extends ScreenSubMain 
	{
		private var _list:List;
		
		public function ScreenMatnas() 
		{
			super();
			title = "מתנ''ס";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this._list = new List();
			this._list.dataProvider = new ListCollection(
			[
				{ label: "ארועי המתנס החודש", event: ScreenEnum.BUSINESS_SCREEN },
				{ label: "חוגים", event: ScreenEnum.BUSINESS_SCREEN },
				{ label: "צהרון", event: ScreenEnum.EVENTS_SCREEN },
				{ label: "טפסים", event: ScreenEnum.EVENTS_SCREEN },
				{ label: "טלפונים", event: ScreenEnum.MAP_SCREEN },
			]);

			var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;
			
			//this._list.hasElasticEdges = true;
			//this._list.move(0, 0);
			this._list.clipContent = false;
			this._list.autoHideBackground = true;
			this._list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "label";
				//renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_RIGHT;
				renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				return renderer;
			};
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this._list.setSize(this.width, this.height);
			this.addChild(this._list);
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function list_changeHandler(e:Event):void 
		{
			
		}
		
	}

}