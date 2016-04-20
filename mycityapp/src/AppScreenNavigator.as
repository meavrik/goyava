package 
{
	import entities.BusinessEntity;
	import entities.GroupEntity;
	import entities.SellItemEntity;
	import feathers.controls.Drawers;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.core.FeathersControl;
	import feathers.motion.Cube;
	import feathers.motion.Slide;
	import log.Logger;
	import panels.DrawerPanel;
	import screens.ScreenBusiness;
	import screens.ScreenEducation;
	import screens.ScreenEvents;
	import screens.ScreenGroups;
	import screens.ScreenHealth;
	import screens.ScreenLostAndFound;
	import screens.ScreenMainMenu;
	import screens.ScreenMap;
	import screens.ScreenMatnas;
	import screens.ScreenMessages;
	import screens.ScreenProfession;
	import screens.ScreenRealestate;
	import screens.ScreenResidents;
	import screens.ScreenSecondHand;
	import screens.ScreenTransport;
	import screens.enums.ScreenEnum;
	import screens.subScreens.SubScreenMyArea;
	import screens.ScreenMyCityArea;
	import screens.subScreens.addItem.SubScreenAdd_Group;
	import screens.subScreens.addItem.SubScreenAdd_SellItem;
	import screens.subScreens.viewItem.SubScreenView_Business;
	import screens.subScreens.viewItem.SubScreenView_Group;
	import screens.subScreens.viewItem.SubScreenView_Info;
	import screens.subScreens.viewItem.SubScreenView_MainPhones;
	import screens.subScreens.viewItem.SubScreenView_SellItem;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	public class AppScreenNavigator extends FeathersControl 
	{
		private var _screenNavigator:StackScreenNavigator;
		private var _mainScreen		:ScreenMainMenu;
		private var _drawers		:Drawers;
		private var _drawerPanel	:DrawerPanel
		
		public function AppScreenNavigator() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_drawerPanel = new DrawerPanel();
			_drawerPanel.setSize(stage.stageWidth, stage.stageHeight / 2);
			
			_mainScreen = new ScreenMainMenu();

			var mainScreensArr:Array = [
					{screen:_mainScreen,id:ScreenEnum.MAIN_SCREEN},
					{screen:new ScreenSecondHand(),		id:ScreenEnum.SECOND_HAND_SCREEN},
					{screen:new ScreenGroups(),			id:ScreenEnum.GROUPS_SCREEN},
					{screen:new ScreenResidents(),		id:ScreenEnum.RESIDENTS_SCREEN},
					{screen:new ScreenEducation(),		id:ScreenEnum.EDUCATION_SCREEN},
					{screen:new ScreenMatnas(),			id:ScreenEnum.MATNAS_SCREEN},
					{screen:new ScreenBusiness(),		id:ScreenEnum.BUSINESS_SCREEN},
					{screen:new ScreenHealth(),			id:ScreenEnum.HEALTH_SCREEN},
					{screen:new ScreenProfession(),		id:ScreenEnum.PROFFESION_SCREEN},
					{screen:new ScreenEvents(),			id:ScreenEnum.EVENTS_SCREEN},
					{screen:new ScreenRealestate(),		id:ScreenEnum.REALESTATE_SCREEN},
					{screen:new ScreenMap(),			id:ScreenEnum.MAP_SCREEN},
					{screen:new ScreenLostAndFound(),	id:ScreenEnum.LOST_AND_FOUND_SCREEN},
					{screen:new ScreenMessages(),		id:ScreenEnum.MESSAGES_SCREEN},
					{screen:new ScreenTransport(),		id:ScreenEnum.TRANSPORT_SCREEN},
			]
			
			var subScreensArr:Array = [
					
					{screen:SubScreenMyArea, 			id:ScreenEnum.MY_AREA_SCREEN },
					{screen:ScreenMyCityArea, 		id:ScreenEnum.MY_CITY_AREA_SCREEN },
					{screen:SubScreenAdd_SellItem,		id:ScreenEnum.SELL_ITEM_ADD_SCREEN},
					{screen:SubScreenAdd_Group,			id:ScreenEnum.ADD_NEW_GROUP_SCREEN},
			]

			_screenNavigator = new StackScreenNavigator();
			
			var screen:PanelScreen;
			var id:String;
			var navigatorItem:StackScreenNavigatorItem
			
			for (var i:int = 0; i < mainScreensArr.length; i++) 
			{
				id = mainScreensArr[i].id;
				screen = mainScreensArr[i].screen;
				screen.addEventListener(Event.COMPLETE, onBackToMainClick);
				screen.screenID = id;
				screen.setSize(this.stage.stageWidth, this.stage.stageHeight - 90);
				
				navigatorItem = new StackScreenNavigatorItem(screen);
				navigatorItem.addPopEvent(Event.COMPLETE);
				if (id == ScreenEnum.MAIN_SCREEN)
				{
					addScreenEventHandler(navigatorItem, ScreenEnum.MY_AREA_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.MY_CITY_AREA_SCREEN);
					
					addScreenEventHandler(navigatorItem, ScreenEnum.BUSINESS_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.PROFFESION_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.REALESTATE_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.EDUCATION_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.MATNAS_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.HEALTH_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.TRANSPORT_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.EVENTS_SCREEN);
					
					addScreenEventHandler(navigatorItem, ScreenEnum.RESIDENTS_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.SECOND_HAND_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.GROUPS_SCREEN);
					
					addScreenEventHandler(navigatorItem, ScreenEnum.LOST_AND_FOUND_SCREEN);
					
					addScreenEventHandler(navigatorItem, ScreenEnum.MESSAGES_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.MAP_SCREEN);
					
					addScreenEventHandler(navigatorItem, ScreenEnum.VIEW_MAIN_PHONE_CALLS);
				}
				
				if (id == ScreenEnum.EDUCATION_SCREEN)
				{
					addScreenEventHandler(navigatorItem, ScreenEnum.VIEW_INFO_SCREEN);
				}
				
				if (id == ScreenEnum.GROUPS_SCREEN)
				{
					addScreenEventHandler(navigatorItem, ScreenEnum.ADD_NEW_GROUP_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.VIEW_GROUP_SCREEN);
				}
				
				if (id == ScreenEnum.SECOND_HAND_SCREEN)
				{
					addScreenEventHandler(navigatorItem, ScreenEnum.SELL_ITEM_ADD_SCREEN);
					addScreenEventHandler(navigatorItem, ScreenEnum.SELL_ITEM_VIEW_SCREEN);
				}
				
				if (id == ScreenEnum.BUSINESS_SCREEN)
				{
					addScreenEventHandler(navigatorItem, ScreenEnum.BUSINESS_ITEM_VIEW_SCREEN);
				}
				_screenNavigator.addScreen(id, navigatorItem);
			}
			
			
			for each (var item:Object in subScreensArr) 
			{
				navigatorItem = new StackScreenNavigatorItem(item.screen);
				id = item.id;
				navigatorItem.setScreenIDForPushEvent(id, id);
				navigatorItem.addPopEvent(Event.COMPLETE);
				
				navigatorItem.pushTransition = Cube.createCubeDownTransition();
				navigatorItem.popTransition =  Cube.createCubeUpTransition();

				this._screenNavigator.addScreen(id, navigatorItem);
			}

			_screenNavigator.setSize(this.stage.stageWidth, this.stage.stageHeight);
			
			_screenNavigator.pushTransition = Slide.createSlideLeftTransition();
			_screenNavigator.popTransition = Slide.createSlideRightTransition();
			
			//_screenNavigator.pushTransition = Cube.createCubeLeftTransition();
			//_screenNavigator.popTransition = Cube.createCubeRightTransition();
			
			this._screenNavigator.rootScreenID = ScreenEnum.MAIN_SCREEN;
			
			_drawers = new Drawers();
			_drawers.content = this._screenNavigator
			_drawers.bottomDrawer = _drawerPanel;
			_drawers.bottomDrawerToggleEventType = ScreenEnum.VIEW_MAIN_PHONE_CALLS;
			this.addChild(_drawers);
		}
		
		private function addScreenEventHandler(navigatorItem:StackScreenNavigatorItem, eventString:String, action:Function = null):void
		{
			navigatorItem.setFunctionForPushEvent(eventString, action is Function?action:onScreenOpen);
		}
		
		private function onScreenOpen(e:Event):void 
		{
			var screenType:String = e.type;
			Logger.logInfo("PICK SCREEN : " + screenType);
			
			switch (screenType) 
			{
				case ScreenEnum.VIEW_INFO_SCREEN:
					pushToDrawer(new SubScreenView_Info( { name:"בדיקה", description:"123" } ));
					return 
				case ScreenEnum.VIEW_MAIN_PHONE_CALLS:
					pushToDrawer(new SubScreenView_MainPhones());
					return
				case ScreenEnum.VIEW_GROUP_SCREEN:
					pushToDrawer(new SubScreenView_Group(e.data as GroupEntity));
					return
				case ScreenEnum.BUSINESS_ITEM_VIEW_SCREEN:
					pushToDrawer(new SubScreenView_Business(e.data as BusinessEntity));
					return	
				case ScreenEnum.SELL_ITEM_VIEW_SCREEN:
					pushToDrawer(new SubScreenView_SellItem(e.data as SellItemEntity));
					return		
					
					
				case ScreenEnum.EDUCATION_SCREEN:
					_drawers.bottomDrawerToggleEventType = ScreenEnum.VIEW_INFO_SCREEN;
					break;
				case ScreenEnum.BUSINESS_SCREEN:
					_drawers.bottomDrawerToggleEventType = ScreenEnum.BUSINESS_ITEM_VIEW_SCREEN;
					break;
				case ScreenEnum.SECOND_HAND_SCREEN:
					_drawers.bottomDrawerToggleEventType = ScreenEnum.SELL_ITEM_VIEW_SCREEN;
					break;
				case ScreenEnum.GROUPS_SCREEN:
					_drawers.bottomDrawerToggleEventType = ScreenEnum.VIEW_GROUP_SCREEN;
					break;
			}
			
			_screenNavigator.pushScreen(screenType);
		}
		
		private function pushToDrawer(panel:Panel):void
		{
			_drawerPanel.setScreen(panel);
		}
		
		
		private function onBackToMainClick(e:Event):void 
		{
			_drawers.bottomDrawerToggleEventType = ScreenEnum.VIEW_MAIN_PHONE_CALLS;
			_mainScreen.focus()
		}

		
		public function goBack():void 
		{
			_screenNavigator.popToRootScreen();
		}

	}

}