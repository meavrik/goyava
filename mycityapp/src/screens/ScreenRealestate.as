package screens 
{
	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenRealestate extends BaseScreenMain 
	{
		private var _list:GroupedList;
		
		public function ScreenRealestate() 
		{
			super();
			title = "נדל''ן";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this._list = new GroupedList();
			this._list.dataProvider = new HierarchicalCollection(
			[
				{
					header: "רכישה",
					children:
					[
						{ label: "בית גדול ברחוב..." },
					]
				},
				{
					header: "השכרה",
					children:
					[
						{ label: "בית קטן ב.." },
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
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this.addChild(this._list);
			
			this._list.setSize(this.width, this.height);
		}
		
		private function list_changeHandler(e:Event):void 
		{
			
		}
	}

}