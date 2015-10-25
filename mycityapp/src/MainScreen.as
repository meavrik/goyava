package 
{
	import data.GlobalDataProvider;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.OldFadeNewSlideTransitionManager;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.motion.transitions.TabBarSlideTransitionManager;
	import panels.AddItemPanel;
	import screens.ScreenBusiness;
	import screens.ScreenComunity;
	import screens.ScreenEducation;
	import screens.ScreenEvents;
	import screens.ScreenGroups;
	import screens.ScreenMap;
	import screens.ScreenMatnas;
	import screens.ScreenRealestate;
	import screens.ScreenResidents;
	import screens.ScreenSecondHand;
	import starling.events.Event;
	
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
		
		public function MainScreen() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			//title = "אבן יהודה";

			//title = GlobalDataProvider.userPlayer.name?GlobalDataProvider.userPlayer.name:"אבן יהודה";
			
			addTopPanel();
			addMainTabPanel();
			addScreenNavigator();
			
			this.addChild(_mainTabBar);
			
			addBottomPanel()
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
				 { label: "מפה" },
				 { label: "קהילה" },
			 ]);
			 
			_mainTabBar.selectedIndex = 0;
			_mainTabBar.move(this.stage.stageWidth - 150, _topPanel.bounds.bottom);
			_mainTabBar.setSize(150, this.stage.stageHeight - 180);
			_mainTabBar.addEventListener( Event.CHANGE, tabs_changeHandler );
			_mainTabBar.direction = TabBar.DIRECTION_VERTICAL;
		}
		
		private function addScreenNavigator():void 
		{
			var arr:Array = [
					new ScreenSecondHand(),
					new ScreenGroups(),
					new ScreenResidents(),
					new ScreenEducation(),
					new ScreenMatnas(),
					new ScreenBusiness(),
					new ScreenEvents(),
					new ScreenRealestate(),
					new ScreenMap(),
					new ScreenComunity()
			]

			_screenNavigator = new ScreenNavigator();
			
			var screen:PanelScreen
			for (var i:int = 0; i < arr.length; i++) 
			{
				screen = arr[i];
				screen.setSize(this.stage.stageWidth - _mainTabBar.bounds.width, this.stage.stageHeight - 270);
				_screenNavigator.addScreen(i.toString(), new ScreenNavigatorItem(screen));
			}
			
			
			//_screenNavigator.addScreen("AddItemScreen", new ScreenNavigatorItem(new AddItemPanel()));
			
			new ScreenSlidingStackTransitionManager(_screenNavigator);

			addChild(_screenNavigator);
			//_screenNavigator.y = _mainTabBar.bounds.bottom;
			//_screenNavigator.x = _mainTabBar.bounds.left;
			_screenNavigator.showScreen("0");
			_screenNavigator.y = _topPanel.bounds.bottom;
			_screenNavigator.setSize(this.stage.stageWidth - _mainTabBar.bounds.width, this.stage.stageHeight - 180);
		}
		
		private function addBottomPanel():void 
		{
			_bottomPanel = new MainScreenBottomPanel();
			this.addChild(_bottomPanel);
			_bottomPanel.move(0, _screenNavigator.bounds.bottom);
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
			
			if (screenItem)
			{
				_screenNavigator.showScreen(id);
			}
		}
		
		public function get screenNavigator():ScreenNavigator 
		{
			return _screenNavigator;
		}
	
		
	}

}