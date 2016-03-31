package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.controls.Slider;
	import feathers.controls.ToggleSwitch;
	import flash.display.Bitmap;
	import screens.enums.ScreenEnum;
	import screens.mainMenu.MainMenuList;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.ItemCounter;
	import ui.buttons.CallButton;
	import ui.buttons.ProfileButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMainMenu extends PanelScreen 
	{
		[Embed(source = "../../bin/mainView.png")]
		private var MainViewPng:Class
		
		private var _groupObject		:Object;
		private var _usersObject		:Object;
		private var _seconHandObject	:Object;
		private var _bgImage			:Image;
		private var _insideMenu			:MainMenuList;
		private var _header				:Header;
		private var _profileButton		:ProfileButton;
		private var _emergencyCallButton:CallButton;

		public function ScreenMainMenu() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_header = new Header();
			_profileButton = new ProfileButton(profileButtonClick);
			_header.leftItems = new <DisplayObject>[_profileButton];

			var bgImg:Bitmap = new MainViewPng();
			_bgImage = new Image(Texture.fromBitmap(bgImg));
			var factor:Number = stage.stageWidth / _bgImage.width;
			addChild(_bgImage);
			_bgImage.width = stage.stageWidth;
			_bgImage.height *= factor;
			
			var welcomeText:String = "בוקר טוב ";
			title = welcomeText + GlobalDataProvider.myUserData.name;
			
			this.headerFactory = this.customHeaderFactory;

			/*AppDataLoader.getInstance().addEventListener(AppDataLoader.MY_MESSAGES_LOADED, onMessagesLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.GROUPS_DATA_LOADED, onGroupsLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.USERS_DATA_LOADED, onUsersLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.SELLITEMS_DATA_LOADED, onSellItemLoaded);*/
			
			var dataObj:Object = 
				[ {
					header: "במושבה",
					children:
					[
						addNewDataItem("עסקים במושבה", "בדיקה",		ScreenEnum.BUSINESS_SCREEN, 10,15),
						addNewDataItem("אנשי מקצוע באזור", "בדיקה",		ScreenEnum.PROFFESION_SCREEN, 11),
						addNewDataItem("מתנס :", "צהרונים, חוגים וארועים",	ScreenEnum.MATNAS_SCREEN, 5),
						addNewDataItem("בתי ספר וגנים", "",			ScreenEnum.EDUCATION_SCREEN, 6),
						addNewDataItem("בריאות", "בדיקה",			ScreenEnum.MATNAS_SCREEN, 7),
						addNewDataItem("תחבורה", "",				ScreenEnum.MATNAS_SCREEN, 14),
						addNewDataItem("נדל''ן", "",				ScreenEnum.REALESTATE_SCREEN, 5),
					]	
					
				},
				{
					header: "בקהילה",
					children:
					[
						_usersObject = addNewDataItem("תושבים", "",		ScreenEnum.RESIDENTS_SCREEN, 2),
						_seconHandObject = addNewDataItem("יד שניה", "בדיקה",ScreenEnum.SECOND_HAND_SCREEN, 0,5),
						_groupObject = addNewDataItem("קבוצות", "",		ScreenEnum.GROUPS_SCREEN, 1,2),
						addNewDataItem("ארועים", "בדיקה",			ScreenEnum.EVENTS_SCREEN, 3,1),
						addNewDataItem("אבדות ומציאות", "בדיקה",		ScreenEnum.LOST_AND_FOUND_SCREEN, 4),
						addNewDataItem("התנדבות בקהילה", "",			ScreenEnum.LOST_AND_FOUND_SCREEN, 17),
					]
				},
				{
					header: "אישי",
					children:
					[
						addNewDataItem("הטבות ומבצעים עבורך", "",		ScreenEnum.MATNAS_SCREEN, 16),
						addNewDataItem("הודעות", "",				ScreenEnum.MESSAGES_SCREEN, 15),
						addNewDataItem("מפה", "",				ScreenEnum.MAP_SCREEN, 14),
					]
				},
				]
			
			this._insideMenu = new MainMenuList(dataObj);
			this._insideMenu.move(0, _bgImage.bounds.bottom);
			addChild(_insideMenu);
			
			_emergencyCallButton = new CallButton(onEmergancyCallClick, 1);
			_emergencyCallButton.x = stage.stageWidth - _emergencyCallButton.width-20;
			_emergencyCallButton.y = stage.stageHeight-_emergencyCallButton.height-150;
			addChild(_emergencyCallButton);
		}
		
		private function addNewDataItem(text:String, subText:String, eventName:String, iconIndex:Number, count:int = 0):Object
		{
			var subLabel:Label = new Label();
			subLabel.text = subText;
			subLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);

			//var toggle:ToggleSwitch = new ToggleSwitch();
		
			var counter:ItemCounter = new ItemCounter();
			counter.x = 130;
			counter.y = 10;
			counter.count = count
		
			return { 	label: text,
						accessory: counter,
						subText: subText,
						event: eventName, 
						thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.MAIN_MENU_ICONS, iconIndex)
					};
		}
		
		/*private function onSellItemLoaded(e:Event):void 
		{
			_seconHandObject.label = "(" + GlobalDataProvider.sellItems.length + ")" + " יד שניה"
			this._insideMenu.update(0);
		}
		
		private function onGroupsLoaded(e:Event):void 
		{
			_groupObject.label = "(" + GlobalDataProvider.groups.length + ")" + " קבוצות";
			this._insideMenu.update(1);
		}
		
		private function onUsersLoaded(e:Event):void 
		{
			_usersObject.label = "(" + GlobalDataProvider.users.length + ")" + " תושבים"
			this._insideMenu.update(2);
		}
		
		private function onMessagesLoaded(e:Event):void 
		{
			if (GlobalDataProvider.myMessages.length)
			{
				_profileButton.messageCounter = GlobalDataProvider.myMessages.length;
			}
		}*/
		


		private function onEmergancyCallClick(e:Event):void 
		{
			dispatchEventWith(ScreenEnum.VIEW_MAIN_PHONE_CALLS);
		}
		
		private function customHeaderFactory():Header
		{
			return _header;
		}
		
		public function focus():void 
		{
			/*if (_list)
			{
				_list.selectedItem = null;
			}*/
			_insideMenu.focus();
		}
		
		private function profileButtonClick(e:Event):void 
		{
			dispatchEvent(new Event(ScreenEnum.MY_AREA_SCREEN));
		}
		
	}

}