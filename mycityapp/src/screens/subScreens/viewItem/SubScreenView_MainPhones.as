package screens.subScreens.viewItem 
{
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class SubScreenView_MainPhones extends Panel
	{
		public function SubScreenView_MainPhones()
		{
			super();

		}
		
		override protected function initialize():void 
		{
			super.initialize();
			//headerFactory = customHeaderFactory;
			setSize(stage.stageWidth, stage.stageHeight / 2);
			
			
			var group:ButtonGroup = new ButtonGroup();
			group.buttonInitializer = function( button:Button, item:Object ):void
			{
				button.label = item.label;
			};
			
			//group.direction = ButtonGroup.DIRECTION_HORIZONTAL
			group.customButtonStyleName = Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON;
			group.dataProvider = new ListCollection(
			 [
				 { label: "התקשר לקב''ט", triggered: onCallClick },
				 { label: "דווח למוקד על מפגע", triggered: onCallClick },
				 //{ label: "אורח", triggered: register_triggeredHandler },
			 ]);
			 addChild( group );
			group.setSize(stage.stageWidth - 40, 200);

		}
		
		private function onCallClick():void
		{
			
		}
		/*protected function customHeaderFactory():Header 
		{
			var header:Header = new Header()
			header.styleNameList.add(Header.DEFAULT_CHILD_STYLE_NAME_ITEM);

			return header
		}*/
		
	}

}