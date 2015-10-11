package 
{
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import screens.ScreenBusiness;
	import screens.ScreenGroups;
	import screens.ScreenShopping;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	
	public class MainScreen extends PanelScreen 
	{
		private var _mainTabBar		:TabBar;
		private var _screenNavigator:ScreenNavigator;
		private var _topPanel		:MainScreenTopPanel;
		private var _bottomPanel	:MainScreenBottomPanel;
		
		public function MainScreen() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "אבן יהודה";
			
			addMainTabPanel();
			addScreenNavigator();
			
			this.addChild(_mainTabBar);
			
			_bottomPanel = new MainScreenBottomPanel();
			this.addChild(_bottomPanel);
			_bottomPanel.move(0, stage.stageHeight - _bottomPanel.bounds.height);
			
		}
		
		private function addMainTabPanel():void 
		{
			_mainTabBar = new TabBar();
			_mainTabBar.dataProvider = new ListCollection(
			 [
				 { label: "יד שניה" },
				 { label: "קבוצות" },
				 { label: "תושבים" },
				 { label: "חינוך" },
				 { label: "מתנס" },
				 { label: "עסקים" },
				 { label: "ארועים" },
				 { label: "נדל''ן" },
			 ]);
			 
			_mainTabBar.selectedIndex = 0;
			_mainTabBar.move(this.stage.stageWidth - 150, 0);
			_mainTabBar.setSize(150, this.stage.stageHeight - 180);
			_mainTabBar.addEventListener( Event.CHANGE, tabs_changeHandler );
			_mainTabBar.direction = TabBar.DIRECTION_VERTICAL;
			
		}
		
		private function addScreenNavigator():void 
		{
			//var screen:ScreenShopping = new ScreenShopping();
			var screen1:PanelScreen = new ScreenShopping();
			screen1.setSize(this.stage.stageWidth - _mainTabBar.bounds.width, this.stage.stageHeight - 270);
			var screen2:PanelScreen = new ScreenGroups();
			screen2.setSize(this.stage.stageWidth - _mainTabBar.bounds.width, this.stage.stageHeight - 270);
			var screen6:PanelScreen = new ScreenBusiness();
			screen6.setSize(this.stage.stageWidth - _mainTabBar.bounds.width, this.stage.stageHeight - 270);
		
			_screenNavigator = new ScreenNavigator();
			_screenNavigator.addScreen("0", new ScreenNavigatorItem(screen1));
			_screenNavigator.addScreen("1", new ScreenNavigatorItem(screen2));
			_screenNavigator.addScreen("2", new ScreenNavigatorItem(new PanelScreen()));
			_screenNavigator.addScreen("3", new ScreenNavigatorItem(new PanelScreen()));
			_screenNavigator.addScreen("4", new ScreenNavigatorItem(new PanelScreen()));
			_screenNavigator.addScreen("5", new ScreenNavigatorItem(screen6));
			
			new ScreenSlidingStackTransitionManager(_screenNavigator);
			
			addChild(_screenNavigator);
			//_screenNavigator.y = _mainTabBar.bounds.bottom;
			//_screenNavigator.x = _mainTabBar.bounds.left;
			_screenNavigator.showScreen("0");
			_screenNavigator.setSize(this.stage.stageWidth - _mainTabBar.bounds.width, this.stage.stageHeight - 180);
		}
		
		private function addBottomPanel():void 
		{
			//_bottomPanel = new MainScreenBottomPanel();
			//_bottomPanel.addEventListener(MainScreenBottomPanel.CLEAR_LIST_EVENT, onClearAllTrigered);
			//addChild(this._bottomPanel);
		}
		
		private function addTopPanel():void
		{
			this._topPanel = new MainScreenTopPanel();
			addChild(this._topPanel);
		}
		
		
		
		private function tabs_changeHandler(e:Event):void 
		{
			var id:String = _mainTabBar.selectedIndex.toString();
			var screenItem:ScreenNavigatorItem = _screenNavigator.getScreen(id);
			
			//currentScreen = screenItem.screen as BaseListScreen;
			//_topPanel.title = _currentScreen.title;
			if (screenItem)
			{
				_screenNavigator.showScreen(id);
			}
		}
	
		
	}

}