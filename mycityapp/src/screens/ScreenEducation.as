package screens 
{
	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenEducation extends BaseScreenMain 
	{
		
		public function ScreenEducation() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "חינוך";
			
			var list:GroupedList = new GroupedList();
     
			list.dataProvider = new HierarchicalCollection(
			[
				 {
					header: "בתי ספר",
					children:
					[
						{ text: "בכר" },
						{ text: "בית אבי" },
						{ text: "ראשונים" },
					]
				 },
				 {
					 header: "גני עירייה",
					 children:
					 [
						 { text: "סביון" },
						 { text: "סביון" },
						 { text: "סביון" },
					 ]
				 },
				 {
					 header: "גנים פרטיים",
					 children:
					 [
						 { text: "הגן של ענת" },
						 { text: "גנני" },
					 ]
				 },
				 {
					 header: "חינוך מיוחד",
					 children:
					 [
						 { text: "מיוחד 1" },
						 { text: "מיוחד 2" },
					 ]
				 },
			]);
			 
			 list.itemRendererFactory = function():IGroupedListItemRenderer
			 {
				 var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				 renderer.labelField = "text";
				 //renderer.iconSourceField = "thumbnail";
				 return renderer;
			 };
			 
			// list.addEventListener( Event.CHANGE, list_changeHandler );
			 list.width = this.width;
			 list.height = this.height;
			 
			 this.addChild( list );
		}
		
	}

}