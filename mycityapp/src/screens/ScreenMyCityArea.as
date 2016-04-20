package screens 
{
	import feathers.controls.ToggleSwitch;
	import screens.enums.ScreenEnum;
	import starling.display.Sprite;
	import ui.GoTabList;
	import ui.buttons.AddButton;
	import ui.buttons.CallButton;
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenMyCityArea extends BaseScreenMain_TabedList 
	{
		private var _insideMenu:GoTabList;
		
		public function ScreenMyCityArea() 
		{
			super();
			title = "המועצה";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var dataObj:Object = 
			[
			{
				header: "מפגעים",
				
				children:
				[
					{
						header: "חדש",
						children:
						[
							setNewListItemData("פנס רחוב שבור", 'ברחוב ההסתדרות',	ScreenEnum.MATNAS_SCREEN,getToggleSwitch()),
						]
					},
					{
						header: "בטיפול",
						children:
						[
							setNewListItemData("זכוכיות במגרש משחקים", "רח התפוח 5",	ScreenEnum.MATNAS_SCREEN,getToggleSwitch()),
							setNewListItemData("רכב חוסם חנייה", "ברח החוסם",	ScreenEnum.MATNAS_SCREEN,getToggleSwitch()),
						]
					}
					,
					{
						header: "טופל",
						children:
						[
							setNewListItemData("קקי של כלבים ", "ברחוב העצמאות",	ScreenEnum.MATNAS_SCREEN,getToggleSwitch(true)),
						]
					}
				]
			},
			{
				header: "שירותים",
				children:
				[
					setNewListItemData("ספרייה", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("ןיצ''ו", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("מכבי", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("מעיינות השרון", "",	ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("האגודה למען החייל", "",ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("בית חב''ד", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
				]	
				
			},
			{
				header: "מחלקות",
				children:
				[
					setNewListItemData("חינוך", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("אגף חזות", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("ביטחון", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("גבייה", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
					setNewListItemData("גזברות", "",		ScreenEnum.VIEW_INFO_SCREEN,getPhoneButton()),
				]
			},
			
			]
			
			this._insideMenu = new GoTabList(dataObj, false);
			addChild(_insideMenu);
			
			var addButton:AddButton = new AddButton(onAddClick);
			addButton.x = (stage.stageWidth) - (addButton.width + 20);
			addButton.y = this.stage.stageHeight - 400;// (addButton.height + 10);
			_insideMenu.getList(0).addChild(addButton);
		}
		
		private function onAddClick():void 
		{
			
		}
		
		private function getToggleSwitch(selected:Boolean=false):ToggleSwitch
		{
			var toggle:ToggleSwitch = new ToggleSwitch();
			toggle.onText = "טופל";
			toggle.offText = "לא טופל";
			toggle.isSelected = selected;
			return toggle
		}
		
	}

}