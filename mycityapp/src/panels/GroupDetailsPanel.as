package panels 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.ScrollText;
	import feathers.data.ListCollection;
	import screens.BaseListScreen;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GroupDetailsPanel extends Panel 
	{
		private var _friendsList:BaseListScreen;
		
		public function GroupDetailsPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "על הקבוצה";
			var label:ScrollText = new ScrollText();
			label.text = "נפגשים כל יום בשש לשחק כדורגל במגרש ליד ביהס ברחוב ההדרים";
			label.setSize(this.stage.stageWidth - 20, 150);
			addChild(label)
			
			var joinButton:Button = new Button();
			joinButton.label = "בקש להצטרף";
			joinButton.move(10, label.bounds.bottom+10);
			joinButton.setSize(label.width, 60);
			addChild(joinButton);
			
			
			var listTitle:Label = new Label();
			listTitle.text = "חברים בקבוצה";
			listTitle.setSize(joinButton.width, 30);
			listTitle.paddingLeft = 100;
			
			listTitle.move(20, joinButton.bounds.bottom + 10);
			addChild(listTitle);
			_friendsList = new BaseListScreen()
			
			
			
			_friendsList.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 renderer.height = 20;
				 return renderer;
			 };
	 
			 _friendsList.dataProvider = new ListCollection(
			 [
				 { text: "דני" },
				 { text: "שמעון כהן" },
				 { text: "דוד לוי" },
				 { text: "אבי" },
			 ]);
			 
			_friendsList.move(10, listTitle.bounds.bottom + 10);
			_friendsList.setSize(label.width, stage.stageHeight / 2);
			
			addChild(_friendsList);
		}
		
	}

}