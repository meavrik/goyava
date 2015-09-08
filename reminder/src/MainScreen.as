package 
{
	import com.freshplanet.ane.AirDatePicker.AirDatePicker;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import flash.geom.Rectangle;
	import screens.events.ScreenEvent;
	import screens.ScreenCodeEnum;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	public class MainScreen extends Screen 
	{
		private var _mainTabBar		:TabBar;
		private var _screenNavigator:ScreenNavigator;
		
		private var _topPanel		:MainScreenTopPanel;
		private var _bottomPanel	:MainScreenBottomPanel;
		
		private var _taskScreen		:RemindTaskScreen;
		private var _birthdayScreen	:RemindEventsScreen;
		private var _shoppingScreen	:RemindShoppingScreen;
		private var _currentScreen	:BaseListScreen;
		
		public function MainScreen() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_taskScreen = new RemindTaskScreen();
			_taskScreen.addEventListener(ScreenEvent.CLEAR, onClearList);
			_taskScreen.addEventListener(ScreenEvent.ADD_FIRST_ITEM, onAddFirstItem);
			_birthdayScreen = new RemindEventsScreen();
			_birthdayScreen.addEventListener(ScreenEvent.CLEAR, onClearList);
			_birthdayScreen.addEventListener(ScreenEvent.ADD_FIRST_ITEM, onAddFirstItem);
			_shoppingScreen = new RemindShoppingScreen();
			_shoppingScreen.addEventListener(ScreenEvent.CLEAR, onClearList);
			_shoppingScreen.addEventListener(ScreenEvent.ADD_FIRST_ITEM, onAddFirstItem);
			
			_screenNavigator = new ScreenNavigator()
			_screenNavigator.addScreen(ScreenCodeEnum.TASKS, new ScreenNavigatorItem(_taskScreen));
			_screenNavigator.addScreen(ScreenCodeEnum.EVENTS, new ScreenNavigatorItem(_birthdayScreen));
			_screenNavigator.addScreen(ScreenCodeEnum.SHOPPING_LIST, new ScreenNavigatorItem(_shoppingScreen));
			_screenNavigator.addEventListener(Event.CHANGE, onScreenChange);
			//_screenNavigator.transition = Fade.createFadeInTransition();
			new ScreenSlidingStackTransitionManager(_screenNavigator);
			
			addChild(_screenNavigator);
			_screenNavigator.y = 90;
			
			addTopPanel();
			addBottomPanel();
			addMainTabPanel();
			
			currentScreen = _taskScreen;
			_screenNavigator.showScreen(ScreenCodeEnum.TASKS);
			//_topPanel.title = _currentScreen.title;
			_topPanel.title = TextLocaleHandler.getText(TextsConsts.MainAppTitle);
			
			trace("AirDatePicker supported : " + AirDatePicker.isSupported);
			if (AirDatePicker.isSupported)
			{
				var currentDate : Date = new Date();
				AirDatePicker.getInstance().displayDatePicker(currentDate, onDatePick, new Rectangle(0, 0, 100, 200));
			}
		}
		
		private function onDatePick(selectedDate:String):void 
		{
			trace("selected date = ", selectedDate.toString());
		}
		
		private function onScreenChange(e:Event):void 
		{
			_bottomPanel.clearAllButton.visible = _currentScreen.gotItems;
		}
		
		private function onAddFirstItem(e:Event):void 
		{
			_bottomPanel.clearAllButton.visible = true;
		}
		private function onClearList(e:Event):void 
		{
			_bottomPanel.clearAllButton.visible = false;
		}
		
		
		
		private function addBottomPanel():void 
		{
			_bottomPanel = new MainScreenBottomPanel();
			_bottomPanel.addEventListener(MainScreenBottomPanel.CLEAR_LIST_EVENT, onClearAllTrigered);
			addChild(this._bottomPanel);
		}
		
		private function addTopPanel():void
		{
			this._topPanel = new MainScreenTopPanel();
			addChild(this._topPanel);
		}
		
		private function addMainTabPanel():void 
		{
			_mainTabBar = new TabBar();
			_mainTabBar.dataProvider = new ListCollection(
			 [
				 { label: TextLocaleHandler.getText(TextsConsts.DailyTasksTab) },
				 { label: TextLocaleHandler.getText(TextsConsts.EventsTab) },
				 { label: TextLocaleHandler.getText(TextsConsts.ShoppingListTab) },
			 ]);
			 _mainTabBar.selectedIndex = 0;
			 _mainTabBar.setSize(stage.stageWidth, 80);
			 _mainTabBar.move(0, 100);

			 _mainTabBar.addEventListener( Event.CHANGE, tabs_changeHandler );
			 
			this.addChild(_mainTabBar);
		}
		
		private function tabs_changeHandler(e:Event):void 
		{
			var id:String = _mainTabBar.selectedIndex.toString();
			var screenItem:ScreenNavigatorItem = _screenNavigator.getScreen(id);
			
			currentScreen = screenItem.screen as BaseListScreen;
			//_topPanel.title = _currentScreen.title;
			_screenNavigator.showScreen(id);
		}

		public function set currentScreen(value:BaseListScreen):void 
		{
			_currentScreen = value;
			/*if (_currentScreen.isInitialized)
			{
				_currentScreen.setFocus();
			} else
			{
				_currentScreen.addEventListener(FeathersEventType.INITIALIZE, onScreenInitialize);
			}*/
		}
		
		/*private function onScreenInitialize(e:Event):void 
		{
			_currentScreen.setFocus();
		}*/
		
		private function onClearAllTrigered(e:Event):void 
		{
			_currentScreen.clearList();
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	
		
	}

}