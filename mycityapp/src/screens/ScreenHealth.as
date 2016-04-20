package screens 
{
	import screens.enums.ScreenEnum;
	import ui.GoTabList;
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenHealth extends BaseScreenMain_TabedList 
	{
		public function ScreenHealth() 
		{
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "בריאות  במושבה";
			var dataObj:Object = 
				[ {
					header: "סניפי קופ''ח",
					children:
					[
						setNewListItemData("כללית", "רח אסותא 2",ScreenEnum.BUSINESS_SCREEN),
						setNewListItemData("מכבי", "רחוב הלוחמים 9 ",	ScreenEnum.PROFFESION_SCREEN),
					]	
					
				},
				{
					header: "פרטי",
					children:
					[
						setNewListItemData("מרפאת שיניים אא", "",		ScreenEnum.MATNAS_SCREEN),
						setNewListItemData("ריפוי בעיסוק משהו", "",		ScreenEnum.MATNAS_SCREEN),
						setNewListItemData("דוקטר משה", "",		ScreenEnum.MATNAS_SCREEN),
					]
				},
				{
					header: "מוקד וחירום",
					children:
					[
						setNewListItemData("מוקד מכבי נתניה", "09-5555555",		ScreenEnum.MATNAS_SCREEN),
					]
				},
				]
			
			var insideMenu:GoTabList = new GoTabList(dataObj, false);
			addChild(insideMenu);
		}
		
	}

}