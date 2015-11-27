package panels 
{
	import data.GlobalDataProvider;
	import feathers.controls.GroupedList;
	import feathers.controls.Panel;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MessagePanelView extends BasePopupPanel 
	{
		private var _list:GroupedList;
		
		public function MessagePanelView() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "מרכז ההודעות";
			
			_list = new GroupedList();
     
			_list.dataProvider = new HierarchicalCollection(
			[
				{
					header: "הודעות מחברים",
					children:[]
				},
				{
					header: "הודעות מערכת",
					children:[]
				},
				{
					header: "הודעות כלליות",
					children:[]
				}
			]);
			 
			 _list.itemRendererFactory = function():IGroupedListItemRenderer
			 {
				 var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				 renderer.labelField = "text";
				 renderer.iconSourceField = "thumbnail";
				
				return renderer;
			 };
			 
			 _list.addEventListener( Event.CHANGE, list_changeHandler );
			 _list.move(0, 5);
			 _list.setSize(this.stage.stageWidth - 20, this.stage.stageHeight / 2);
			 
			 this.addChild(_list);
			 
			 
			for (var i:int = 0; i < GlobalDataProvider.myMessages.length; i++) 
			{
				var item:Object = GlobalDataProvider.myMessages[i];
				if (item.title)
				{
					this._list.dataProvider.data[0].children.push( { text:item.fromName+" : " + item.title } );
				}
			}
		}
		
		private function list_changeHandler(e:Event):void 
		{
			
		}
		
	}

}