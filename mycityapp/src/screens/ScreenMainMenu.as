package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import flash.display.Bitmap;
	import screens.enums.ScreenEnum;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.GoButton;
	import ui.GoTabList;
	import ui.ItemCounter;
	import ui.buttons.CallButton;
	import ui.buttons.CityButton;
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
		private var _insideMenu			:GoTabList;
		private var _header				:Header;
		private var _profileButton		:GoButton;
		private var _cityButton			:GoButton;
		private var _emergencyCallButton:CallButton;

		public function ScreenMainMenu() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_header = new Header();
			_profileButton = new ProfileButton(onProfileButtonClick);
			_cityButton = new CityButton(onCityButtonClick);
			_header.leftItems = new <DisplayObject>[_profileButton];
			_header.rightItems = new <DisplayObject>[_cityButton];

			var bgImg:Bitmap = new MainViewPng();
			_bgImage = new Image(Texture.fromBitmap(bgImg));
			var factor:Number = stage.stageWidth / _bgImage.width;
			addChild(_bgImage);
			_bgImage.width = stage.stageWidth;
			_bgImage.height *= factor;
			
			var welcomeText:String = "בוקר טוב ";
			title =  GlobalDataProvider.myUserData.name?welcomeText +GlobalDataProvider.myUserData.name:welcomeText +"אורח";
			
			this.headerFactory = this.customHeaderFactory;

			/*AppDataLoader.getInstance().addEventListener(AppDataLoader.MY_MESSAGES_LOADED, onMessagesLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.GROUPS_DATA_LOADED, onGroupsLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.USERS_DATA_LOADED, onUsersLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.SELLITEMS_DATA_LOADED, onSellItemLoaded);*/
			
			var dataObj:Object = 
				[ {
					header: "במושבה",
					//defaultIcon: AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.TAB_ICONS, 0),
					children:
					[
						addNewDataItem("עסקים במושבה", "כל העסקים במקום אחד",		ScreenEnum.BUSINESS_SCREEN, 10,15),
						addNewDataItem("אנשי מקצוע באזור", "",		ScreenEnum.PROFFESION_SCREEN, 11),
						addNewDataItem("מתנס", "צהרונים, חוגים וארועים",	ScreenEnum.MATNAS_SCREEN, 5),
						addNewDataItem("חינוך במושבה", "בתי ספר, גנים עירוניים ופרטיים",	ScreenEnum.EDUCATION_SCREEN, 6),
						addNewDataItem("בריאות", "קופ''ח, טיפת חלב, מוקד",			ScreenEnum.HEALTH_SCREEN, 7),
						addNewDataItem("נדל''ן", "מכירה והשכרה",				ScreenEnum.REALESTATE_SCREEN, 5),
						//addNewDataItem("תחבורה", "קווי אוטובוסים ומוניות",			ScreenEnum.TRANSPORT_SCREEN, 14),
					]	
					
				},
				{
					header: "בקהילה",
					//defaultIcon: AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.TAB_ICONS, 1),
					children:
					[
						_seconHandObject = addNewDataItem("יד שניה", "השוק של אבן יהודה",ScreenEnum.SECOND_HAND_SCREEN, 0,5),
						_groupObject = addNewDataItem("קבוצות", "",		ScreenEnum.GROUPS_SCREEN, 1,2),
						addNewDataItem("ארועים", "",			ScreenEnum.EVENTS_SCREEN, 3,1),
						addNewDataItem("אבדות ומציאות", "",		ScreenEnum.LOST_AND_FOUND_SCREEN, 4),
						addNewDataItem("תושבים", "",			ScreenEnum.RESIDENTS_SCREEN, 2),
						addNewDataItem("התנדבות בקהילה", "",		ScreenEnum.LOST_AND_FOUND_SCREEN, 17),
					]
				},
				{
					//defaultIcon: AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.TAB_ICONS, 2),
					header: "אישי",
					children:
					[
						addNewDataItem("הטבות ומבצעים עבורך", "",		ScreenEnum.MATNAS_SCREEN, 16,3),
						addNewDataItem("הודעות", "",				ScreenEnum.MESSAGES_SCREEN, 15),
						addNewDataItem("עידכון פרטים אישיים", "",		ScreenEnum.MY_AREA_SCREEN, 15),
						addNewDataItem("מפה של המושבה", "",			ScreenEnum.MAP_SCREEN, 14),
					]
				},
				/*{
					defaultIcon: AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.TAB_ICONS, 3),
					//header: "אישי",
					children:
					[

						addNewDataItem("תחבורה", "קווי אוטובוסים ומוניות",			ScreenEnum.TRANSPORT_SCREEN, 14),
						addNewDataItem("מפה של המושבה", "",			ScreenEnum.MAP_SCREEN, 14),
					]
				},*/
				]
			
			this._insideMenu = new GoTabList(dataObj, true, 330);
			this._insideMenu.move(0, _bgImage.bounds.bottom);
			//this._insideMenu.setSize(this.stage.stageWidth, this.stage.stageHeight - _insideMenu.bounds.bottom);
			addChild(_insideMenu);
			
			_emergencyCallButton = new CallButton(onEmergancyCallClick, 1);
			_emergencyCallButton.x = stage.stageWidth - _emergencyCallButton.width - 20;
			_emergencyCallButton.y = stage.stageHeight - _emergencyCallButton.height - 150;
			addChild(_emergencyCallButton);
		}
		
		private function addNewDataItem(text:String, subText:String, eventName:String, iconIndex:Number, count:int = 0):Object
		{
			var subLabel:Label = new Label();
			subLabel.text = subText;
			subLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);

			var counter:ItemCounter
			if (count)
			{
				counter = new ItemCounter();
				counter.x = 130;
				counter.y = 10;
				counter.count = count
			}
			
			return { 	label: text,
						accessory: counter,
						subText: subText,
						event: eventName, 
						count:count,
						thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.MAIN_MENU_ICONS, iconIndex)
					};
		}

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
			_insideMenu.focus();
		}
		
		private function onCityButtonClick(e:Event):void 
		{
			dispatchEvent(new Event(ScreenEnum.MY_CITY_AREA_SCREEN));
		}
		
		private function onProfileButtonClick(e:Event):void 
		{
			dispatchEvent(new Event(ScreenEnum.MY_AREA_SCREEN));
		}
		
	}

}