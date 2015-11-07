package screens 
{
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenLostAndFound extends ScreenSubMain 
	{
		private var _list:GroupedList;
		
		public function ScreenLostAndFound() 
		{
			super();
			title = "אבדות ומציאות";
		}
		
		override protected function initialize():void 
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
			addButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "עבדה";
			addButton.addEventListener(Event.TRIGGERED, addButton_triggeredHandler);
			
			var addButton2:Button = new Button();
			addButton2.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
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
			
		}
	}

}