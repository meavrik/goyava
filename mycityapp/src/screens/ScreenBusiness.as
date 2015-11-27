package screens 
{
	import assets.AssetsHelper;
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.events.FeathersEventType;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenBusiness extends ScreenSubMain 
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
						{ text: "פלאפל משה" },
						{ text: "מגה בעיר" },
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
				 
				var contactButn:Button = new Button();
				contactButn.label = "050-5555555";
				contactButn.width = 220;
				//contactButn.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
				contactButn.move(stage.stageWidth - (contactButn.width + 10), 12);
				contactButn.addEventListener(Event.TRIGGERED, onContactButnClick);
				renderer.addChild(contactButn);
				
				var label:Label = new Label();
				//label.text = GlobalDataProvider.commonEntityy.residents[index].address//"כתובת";
				label.text = "ותיקים 50";
				label.styleNameList.add(Label.ALTERNATE_NAME_DETAIL);
				label.move(35, 55);

				renderer.addChild(label);
				
				return renderer;
			 };
			 
			 list.addEventListener( Event.CHANGE, list_changeHandler );
			 list.width = this.width;
			 list.height = this.height;
			 
			 this.addChild( list );
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