package screens 
{
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import screens.enums.ScreenEnum;
	import ui.GoTabList;
	import starling.display.Sprite;
	import ui.buttons.CallButton;
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenTransport extends BaseScreenMain_TabedList 
	{
		
		public function ScreenTransport() 
		{
			super();
			title = "תחבורה";
		}
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var dataObj:Object = 
			[ 
				{
					header: "אוטובוסים",
					children:
					[
						setNewListItemData("קו 11", "קווים",		ScreenEnum.VIEW_INFO_SCREEN,getmapButn()),
						setNewListItemData("קו 56", "קווים",		ScreenEnum.VIEW_INFO_SCREEN,getmapButn()),
						setNewListItemData("קו 563", "אגד",		ScreenEnum.VIEW_INFO_SCREEN,getmapButn()),
					]
				},
				{
					header: "מוניות",
					children:
					[
						setNewListItemData("מוניות השרון", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
						setNewListItemData("מוניות אבן יהודה", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
						setNewListItemData("מוניות נתב''ג", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					]
				}
			]
				
			var insideMenu:GoTabList = new GoTabList(dataObj, false);
			addChild(insideMenu);
		}

		private function getmapButn():Button 
		{
			var mapButn:Button = new Button();
			mapButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			mapButn.label = "תחנות";
			
			return mapButn;
		}
		
	}

}