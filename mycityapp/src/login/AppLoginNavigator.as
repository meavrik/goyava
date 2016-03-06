package login 
{
	import feathers.controls.PageIndicator;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.motion.Slide;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class AppLoginNavigator extends Screen 
	{
		private var _screenNavigator:StackScreenNavigator;
		private var _pageIndicator:PageIndicator;
		
		public function AppLoginNavigator() 
		{
			super();
			
		}
		
		
		override protected function initialize():void 
		{
			super.initialize();

			_pageIndicator = new PageIndicator();
			_pageIndicator.pageCount = 3;
			
			_screenNavigator = new StackScreenNavigator();
			_screenNavigator.setSize(this.stage.stageWidth, this.stage.stageHeight-100);
			
			var screen1:PanelScreen = new LoginMainScreen();
			var screenItem1:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen1);
			screen1.screenID = LoginScreenEnum.SCREEN1;
			screen1.setSize(_screenNavigator.width, _screenNavigator.height);
			screenItem1.setScreenIDForPushEvent(LoginScreenEnum.SCREEN2, LoginScreenEnum.SCREEN2);
			screenItem1.setScreenIDForPushEvent(LoginScreenEnum.SCREEN4, LoginScreenEnum.SCREEN4);
			
			var screen2:PanelScreen = new LoginMainScreen2();
			var screenItem2:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen2);
			screen2.screenID = LoginScreenEnum.SCREEN2;
			screen2.setSize(_screenNavigator.width, _screenNavigator.height);
			screenItem2.setScreenIDForPushEvent(LoginScreenEnum.SCREEN3, LoginScreenEnum.SCREEN3);
			
			screenItem2.addPopEvent(LoginScreenEnum.BACK);
			
			var screen2b:PanelScreen = new LoginMainScreen2b();
			var screenItem2b:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen2b);
			screen2b.screenID = LoginScreenEnum.SCREEN4;
			screen2b.setSize(_screenNavigator.width, _screenNavigator.height);
			//screenItem2b.setScreenIDForPushEvent(LoginScreenEnum.SCREEN3, LoginScreenEnum.SCREEN3);
			screenItem2b.addPopEvent(LoginScreenEnum.BACK);
			
			
			var screen3:PanelScreen = new LoginMainScreen3();
			var screenItem3:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen3);
			screen3.screenID = LoginScreenEnum.SCREEN3;
			screen3.setSize(_screenNavigator.width, _screenNavigator.height);
			screenItem3.addPopEvent(LoginScreenEnum.BACK);
			
			_screenNavigator.addScreen(LoginScreenEnum.SCREEN1, screenItem1);
			_screenNavigator.addScreen(LoginScreenEnum.SCREEN2, screenItem2);
			_screenNavigator.addScreen(LoginScreenEnum.SCREEN3, screenItem3);
			_screenNavigator.addScreen(LoginScreenEnum.SCREEN4, screenItem2b);
			_screenNavigator.addEventListener(Event.CHANGE, onChange);
			
			
			_screenNavigator.pushTransition = Slide.createSlideLeftTransition();
			_screenNavigator.popTransition = Slide.createSlideRightTransition();
			
			this._screenNavigator.rootScreenID = LoginScreenEnum.SCREEN1;
			
			addChild(_screenNavigator);
			
			
			_pageIndicator.setSize(this.stage.stageWidth, 40);
			_pageIndicator.y = _screenNavigator.bounds.bottom;
			//pageIndicator.move((this.stage.stageWidth-pageIndicator.width) / 2, this.stage.stageHeight - 100);
			addChild(_pageIndicator);
			
			
			_pageIndicator.selectedIndex = 0;
			
		}
		
		private function onChange(e:Event):void 
		{
			_pageIndicator.selectedIndex = parseInt(_screenNavigator.activeScreenID) - 1;
		}
		
	}

}