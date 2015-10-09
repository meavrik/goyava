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
	public class ScreenBusiness extends PanelScreen 
	{
		
		public function ScreenBusiness() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "עסקים בעיר";
			var list:GroupedList = new GroupedList();
     
			list.dataProvider = new HierarchicalCollection(
			[
				 {
					header: "מזון",
					children:
					[
						{ text: "פלאפל משה 09-1234568" },
						{ text: "מגה בעיר 03-1234567" },
						{ text: "סושי - אישאימוטו" },
					]
				 },
				 {
					 header: "חיות",
					 children:
					 [
						 { text: "כלבים" },
					 ]
				 },
				 {
					 header: "בנקים",
					 children:
					 [
						 { text: "פועלים" },
						 { text: "לאומי" },
					 ]
				 },
				 {
					 header: "ילדים",
					 children:
					 [
						 { text: "כחול ורוד - רחוב הלחי 2" },
						 { text: "בגדים" },
						 { text: "Onion" },
					 ]
				 },
				 {
					 header: "ביגוד והנעלה",
					 children:
					 [
						 { text: "המיסדות" },
						 { text: "בגדים" },
						 { text: "בגדים" },
					 ]
				 },
			]);
			 
			 list.itemRendererFactory = function():IGroupedListItemRenderer
			 {
				 var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				 renderer.labelField = "text";
				 renderer.iconSourceField = "thumbnail";
				 return renderer;
			 };
			 
			 list.addEventListener( Event.CHANGE, list_changeHandler );
			 list.width = this.width;
			 list.height = this.height;
			 
			 this.addChild( list );
		}
		
		private function list_changeHandler(e:Event):void 
		{
			
		}
		
	}

}