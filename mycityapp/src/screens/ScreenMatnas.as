package screens 
{
	import screens.enums.ScreenEnum;
	import ui.GoTabList;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMatnas extends BaseScreenMain_TabedList 
	{
		public function ScreenMatnas() 
		{
			super();
			title = "מתנ''ס";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var dataObj:Object = 
				[ {
					header: "חוגים",
					children:
					[
						{
							header: "ספורט",
							children:
							[
								setNewListItemData("התעמלות קרקע", "מתחם המתנס",	ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton("050-5555555")),
								setNewListItemData("חוג כדורגל", "מתחם המתנס",	ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton("050-5555555")),
								setNewListItemData("חוג בלטי", "במגרשים ",	ScreenEnum.VIEW_INFO_SCREEN, getPhoneButton("050-5555555")),
							]
						},
						{
							header: "כללי",
							children:
							[
								setNewListItemData("חוג שחמט", "בית אבי",	ScreenEnum.VIEW_INFO_SCREEN, getPhoneButton("050-5555555")),
								setNewListItemData("חוג לגו", "בית אבי",	ScreenEnum.VIEW_INFO_SCREEN, getPhoneButton("050-5555555")),
							]
						}
					]	
					
				},
				{
					header: "צהרונים",
					children:
					[
						setNewListItemData("צהרוני כיתות א-ג", "רח הנוקד 5",	ScreenEnum.VIEW_INFO_SCREEN, getPhoneButton("050-5555555")),
						setNewListItemData("צהרוני גנים", "רח הנוקד 2",		ScreenEnum.VIEW_INFO_SCREEN, getPhoneButton("050-5555555")),
						setNewListItemData("טפסים", "רישום, ביטול",		ScreenEnum.VIEW_INFO_SCREEN),
					]
				},
				{
					header: "ארועים ועידכונים",
					children:
					[
						{
							header: "ארועים",
							children:
							[
								setNewListItemData("מסיבת פורים", "רח הבית 1",		ScreenEnum.VIEW_INFO_SCREEN),
								setNewListItemData("טורניר כדורעף בנות", "רח הבית ",	ScreenEnum.VIEW_INFO_SCREEN),
							]
						},
						{
							header: "עידכונים",
							children:
							[
								setNewListItemData("ביטול חוג דרמה", "רח הבית 1",	ScreenEnum.VIEW_INFO_SCREEN),
							]
						}
					]
				},
				]
				
			var insideMenu:GoTabList = new GoTabList(dataObj, false);
			addChild(insideMenu);
		}
		
	}

}