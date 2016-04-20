package screens 
{
	import screens.enums.ScreenEnum;
	import ui.GoTabList;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenEducation extends BaseScreenMain_TabedList 
	{
		
		public function ScreenEducation() 
		{
			super();
			title = "חינוך";
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			var dataObj:Object = 
				[ {
					header: "בתי ספר",
					children:
					[
						setNewListItemData("בכר", "רח אסותא 2",			ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("בית אבי", "רחוב הלוחמים 9 ",	ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("הראשונים", "רחוב הלוחמים 9 ",	ScreenEnum.VIEW_INFO_SCREEN),
					]	
					
				},
				{
					header: "גנים",
					children:
					[
						setNewListItemData("גן נופר", "רח הנוקד 5",		ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("גן נאירה", "רח הנוקד 2",		ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("גן סביון", "רח הנוקד 12",		ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("גן במבה", "רח הנוקד 12",		ScreenEnum.VIEW_INFO_SCREEN),
					]
				},
				{
					header: "פרטי",
					children:
					[
						setNewListItemData("גן ענת", "רח הבית 1",		ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("הפעוטון שלי", "רח הבית 1",	ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("משפחתון אנה", "רח הבית 1",ScreenEnum.VIEW_INFO_SCREEN),
					]
				},
				]
			
			var insideMenu:GoTabList = new GoTabList(dataObj);
			addChild(insideMenu);
		}
		
	}

}