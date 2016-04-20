package screens 
{
	import screens.enums.ScreenEnum;
	import ui.GoTabList;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenRealestate extends BaseScreenMain_TabedList 
	{
		public function ScreenRealestate() 
		{
			super();
			title = "נדל''ן";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var dataObj:Object = 
				[ {
					header: "רכישה",
					children:
					[
						setNewListItemData("דירת 4 חדרים", "רח אסותא 2",	ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
						setNewListItemData("דופלקס 6 חדרים", "רחוב הלוחמים 9 ",ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					]	
					
				},
				{
					header: "השכרה",
					children:
					[
						setNewListItemData("קוטג גדול ומרווח", "התפוח 12",	ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
						setNewListItemData("בית 5 חדרים", "העצמאות 57",	ScreenEnum.VIEW_INFO_SCREEN),
						setNewListItemData("דירת 3 חדרים", "הבצל 3",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					]
				},
				{
					header: "תיווך",
					children:
					[
						setNewListItemData("קוטג גדול ומרווח", "תיווך המושבה",ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					]
				},
				]
			
			var insideMenu:GoTabList = new GoTabList(dataObj, false);
			addChild(insideMenu);
		}
	}

}