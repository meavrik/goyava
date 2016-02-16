package 
{
	import entities.GroupEntity;
	import entities.SellItemEntity;
	import feathers.controls.Drawers;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.motion.Cube;
	import feathers.motion.Slide;
	import panels.DrawerPanel;
	import screens.enums.ScreenEnum;
	import screens.ScreenBusiness;
	import screens.ScreenEducation;
	import screens.ScreenEvents;
	import screens.ScreenGroups;
	import screens.ScreenLostAndFound;
	import screens.ScreenMainMenu;
	import screens.ScreenMap;
	import screens.ScreenMatnas;
	import screens.ScreenRealestate;
	import screens.ScreenResidents;
	import screens.ScreenSecondHand;
	import screens.subScreens.ScreenGroupAdd;
	import screens.subScreens.ScreenGroupView;
	import screens.subScreens.ScreenMyArea;
	import screens.subScreens.ScreenSellItemAdd;
	import screens.subScreens.ScreenSellItemView;
	import screens.subScreens.SubScreenMainPhonesView;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	public class AppScreenNavigator extends Screen 
	{
		private var _screenNavigator:StackScreenNavigator;
		private var _mainScreen		:ScreenMainMenu;
		private var _drawers		:Drawers;
		private var _panelPH		:DrawerPanel
		
		public function AppScreenNavigator() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_panelPH = new DrawerPanel();
			_panelPH.setSize(stage.stageWidth, stage.stageHeight / 2);
			
			_mainScreen = new ScreenMainMenu();
			//_mainScreen = new ScreenMainMenu_Grid();
			var mainScreensArr:Array = [
					{screen:_mainScreen,id:ScreenEnum.MAIN_SCREEN},
					{screen:new ScreenSecondHand(),id:ScreenEnum.SECOND_HAND_SCREEN},
					{screen:new ScreenGroups(),id:ScreenEnum.GROUPS_SCREEN},
					{screen:new ScreenResidents(),id:ScreenEnum.RESIDENTS_SCREEN},
					{screen:new ScreenEducation(),id:ScreenEnum.EDUCATION_SCREEN},
					{screen:new ScreenMatnas(),id:ScreenEnum.MATNAS_SCREEN},
					{screen:new ScreenBusiness(),id:ScreenEnum.BUSINESS_SCREEN},
					{screen:new ScreenEvents(),id:ScreenEnum.EVENTS_SCREEN},
					{screen:new ScreenRealestate(),id:ScreenEnum.REALESTATE_SCREEN},
					{screen:new ScreenMap(),id:ScreenEnum.MAP_SCREEN},
					{screen:new ScreenLostAndFound(),id:ScreenEnum.LOST_AND_FOUND},
			]
			
			var subScreensArr:Array = [
					
					{screen:ScreenMyArea, id:ScreenEnum.MY_AREA_SCREEN },
					{screen:ScreenSellItemAdd,id:ScreenEnum.SELL_ITEM_ADD_SCREEN},
					{screen:ScreenGroupAdd,id:ScreenEnum.ADD_NEW_GROUP_SCREEN},
					//{screen:_groupViewScreen,id:ScreenEnum.VIEW_GROUP_SCREEN},
					//{screen:_sellItemViewScreen,id:ScreenEnum.SELL_ITEM_VIEW_SCREEN},
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
				screen.setSize(this.stage.stageWidth, this.stage.stageHeight-90);
				
				navigatorItem = new StackScreenNavigatorItem(mainScreensArr[i].screen);
				navigatorItem.addPopEvent(Event.COMPLETE);
				if (id == ScreenEnum.MAIN_SCREEN)
				{
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.MY_AREA_SCREEN, ScreenEnum.MY_AREA_SCREEN);
					//navigatorItem.setScreenIDForPushEvent(ScreenEnum.SECOND_HAND_SCREEN, ScreenEnum.SECOND_HAND_SCREEN);
					navigatorItem.setFunctionForPushEvent(ScreenEnum.SECOND_HAND_SCREEN, onSecondHandOpen);
					//navigatorItem.setScreenIDForPushEvent(ScreenEnum.GROUPS_SCREEN, ScreenEnum.GROUPS_SCREEN);
					navigatorItem.setFunctionForPushEvent(ScreenEnum.GROUPS_SCREEN, onGroupsOpen);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.RESIDENTS_SCREEN, ScreenEnum.RESIDENTS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.LOST_AND_FOUND, ScreenEnum.LOST_AND_FOUND);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.BUSINESS_SCREEN, ScreenEnum.BUSINESS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.REALESTATE_SCREEN, ScreenEnum.REALESTATE_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.MAP_SCREEN, ScreenEnum.MAP_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.EVENTS_SCREEN, ScreenEnum.EVENTS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.MATNAS_SCREEN, ScreenEnum.MATNAS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.EDUCATION_SCREEN, ScreenEnum.EDUCATION_SCREEN);
					//navigatorItem.setScreenIDForPushEvent(id, id);
					
					
					navigatorItem.setFunctionForPushEvent(ScreenEnum.VIEW_MAIN_PHONE_CALLS, onMainPhonesViewOpen);
					
				}
				
				if (id == ScreenEnum.GROUPS_SCREEN)
				{
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.ADD_NEW_GROUP_SCREEN, ScreenEnum.ADD_NEW_GROUP_SCREEN);
					//navigatorItem.setScreenIDForPushEvent(ScreenEnum.VIEW_GROUP_SCREEN, ScreenEnum.VIEW_GROUP_SCREEN);
					navigatorItem.setFunctionForPushEvent(ScreenEnum.VIEW_GROUP_SCREEN, onGroupViewOpen);
				}
				
				if (id == ScreenEnum.SECOND_HAND_SCREEN)
				{
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.SELL_ITEM_ADD_SCREEN, ScreenEnum.SELL_ITEM_ADD_SCREEN);
					//navigatorItem.setScreenIDForPushEvent(ScreenEnum.SELL_ITEM_VIEW_SCREEN, ScreenEnum.SELL_ITEM_VIEW_SCREEN);
					navigatorItem.setFunctionForPushEvent(ScreenEnum.SELL_ITEM_VIEW_SCREEN, onSellItemViewOpen);
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
			_drawers.bottomDrawer = _panelPH;
			_drawers.bottomDrawerToggleEventType = ScreenEnum.VIEW_MAIN_PHONE_CALLS;
			this.addChild( _drawers )
		}
		
		private function onSecondHandOpen():void 
		{
			_drawers.bottomDrawerToggleEventType = ScreenEnum.SELL_ITEM_VIEW_SCREEN;
			_screenNavigator.pushScreen(ScreenEnum.SECOND_HAND_SCREEN);
		}
		
		private function onGroupsOpen():void 
		{
			_drawers.bottomDrawerToggleEventType = ScreenEnum.VIEW_GROUP_SCREEN;
			_screenNavigator.pushScreen(ScreenEnum.GROUPS_SCREEN);
		}
		
		private function onGroupViewOpen(e:Event):void 
		{
			var panel:ScreenGroupView = new ScreenGroupView(e.data as GroupEntity);
			_panelPH.setScreen(panel);
		}
		
		private function onSellItemViewOpen(e:Event):void 
		{
			var panel:ScreenSellItemView = new ScreenSellItemView(e.data as SellItemEntity);
			_panelPH.setScreen(panel);
		}
		
		private function onMainPhonesViewOpen(e:Event):void 
		{
			var panel:SubScreenMainPhonesView = new SubScreenMainPhonesView();
			_panelPH.setScreen(panel);
		}
		
		private function onScreenClick(e:Event):void 
		{
			//trace("CLICK");
			_mainScreen.focus()
			//_screenNavigator.showScreen(e.type);
		}
		
		private function onBackToMainClick(e:Event):void 
		{
			//_screenNavigator.showScreen(ScreenEnum.MAIN_SCREEN);
			_mainScreen.focus()
		}

	}

}