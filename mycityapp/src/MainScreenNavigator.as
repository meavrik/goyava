package 
{
	import feathers.controls.Drawers;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.motion.Cube;
	import feathers.motion.Slide;
	import screens.enums.ScreenEnum;
	import screens.events.ScreenEvent;
	import screens.ScreenBusiness;
	import screens.ScreenComunity;
	import screens.ScreenEducation;
	import screens.ScreenEvents;
	import screens.ScreenGroups;
	import screens.ScreenLostAndFound;
	import screens.ScreenMainMenu;
	import screens.ScreenMap;
	import screens.ScreenMatnas;
	import screens.ScreenMyArea;
	import screens.ScreenRealestate;
	import screens.ScreenResidents;
	import screens.ScreenSecondHand;
	import screens.subScreens.ScreenSellItemAdd;
	import screens.subScreens.ScreenSellItemView;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	public class MainScreenNavigator extends Screen 
	{
		private var _screenNavigator:StackScreenNavigator;
		private var _mainScreen		:ScreenMainMenu;
		private var _sellItemViewScreen:ScreenSellItemView;
		
		public function MainScreenNavigator() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			_mainScreen = new ScreenMainMenu();
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
			
			this._sellItemViewScreen = new ScreenSellItemView();
			
			var subScreensArr:Array = [
					
					{screen:ScreenMyArea, id:ScreenEnum.MY_AREA_SCREEN },
					{screen:ScreenSellItemAdd,id:ScreenEnum.SELL_ITEM_ADD_SCREEN},
					{screen:_sellItemViewScreen,id:ScreenEnum.SELL_ITEM_VIEW_SCREEN},
			]

			_screenNavigator = new StackScreenNavigator();
			
			var screen:PanelScreen;
			var id:String;
			var navigatorItem:StackScreenNavigatorItem
			
			for (var i:int = 0; i < mainScreensArr.length; i++) 
			{
				screen = mainScreensArr[i].screen;
				screen.addEventListener(Event.COMPLETE, onBackToMainClick);
				id = mainScreensArr[i].id;
				_mainScreen.addEventListener(id, onScreenClick);
				
				screen.screenID = id;
				//screen.setSize(this.stage.stageWidth, this.stage.stageHeight - (_bottomPanel.height + 70));
				screen.setSize(this.stage.stageWidth, this.stage.stageHeight);
				
				navigatorItem = new StackScreenNavigatorItem(mainScreensArr[i].screen);
				navigatorItem.addPopEvent(Event.COMPLETE);
				if (id == ScreenEnum.MAIN_SCREEN)
				{
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.MY_AREA_SCREEN, ScreenEnum.MY_AREA_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.SECOND_HAND_SCREEN, ScreenEnum.SECOND_HAND_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.GROUPS_SCREEN, ScreenEnum.GROUPS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.RESIDENTS_SCREEN, ScreenEnum.RESIDENTS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.LOST_AND_FOUND, ScreenEnum.LOST_AND_FOUND);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.BUSINESS_SCREEN, ScreenEnum.BUSINESS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.REALESTATE_SCREEN, ScreenEnum.REALESTATE_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.MAP_SCREEN, ScreenEnum.MAP_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.EVENTS_SCREEN, ScreenEnum.EVENTS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.MATNAS_SCREEN, ScreenEnum.MATNAS_SCREEN);
					navigatorItem.setScreenIDForPushEvent(ScreenEnum.EDUCATION_SCREEN, ScreenEnum.EDUCATION_SCREEN);
					//navigatorItem.setScreenIDForPushEvent(id, id);
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

			//new ScreenSlidingStackTransitionManager(_screenNavigator);

			addChild(_screenNavigator);
			////_screenNavigator.showScreen(ScreenEnum.MAIN_SCREEN);

			_screenNavigator.setSize(this.stage.stageWidth, this.stage.stageHeight);
			
			_screenNavigator.pushTransition = Slide.createSlideLeftTransition();
			_screenNavigator.popTransition = Slide.createSlideRightTransition();
			
			this._screenNavigator.rootScreenID = ScreenEnum.MAIN_SCREEN;
			
			_sellItemViewScreen.itemData = { };
			var drawers:Drawers = new Drawers();
			drawers.content = this._screenNavigator
			drawers.bottomDrawer = _sellItemViewScreen;
			drawers.bottomDrawerToggleEventType = ScreenEnum.SELL_ITEM_VIEW_SCREEN

			this.addChild( drawers )
		}
		
		private function onSellItemViewOpen(e:Event):void 
		{
			_sellItemViewScreen.itemData = e.data;
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