package 
{
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import log.Logger;
	import login.AppLoginNavigator;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class AppMain extends Sprite 
	{
		private var _loginScreenNavigator:AppLoginNavigator;
		private var _mainScreenNavigator:AppScreenNavigator;
		private var _newUser:Boolean;
		
		public function AppMain(newUser:Boolean) 
		{
			super();
			this._newUser = newUser;
			
		}
		
		public function init():void
		{
			if (_mainScreenNavigator)
			{
				_mainScreenNavigator.removeFromParent();
			}
			
			_mainScreenNavigator = new AppScreenNavigator();
			
			if (_newUser)
			{
				Logger.logInfo("NEW USER!");
				_loginScreenNavigator = new AppLoginNavigator();
				_loginScreenNavigator.addEventListener(Event.COMPLETE, onLoginComplete);
				addChild(_loginScreenNavigator);
			} else
			{
				addChild(_mainScreenNavigator);
			}
			
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, checkKeypress);
		}
		
		private function onLoginComplete(e:Event):void 
		{
			if (_loginScreenNavigator)
			{
				_loginScreenNavigator.removeEventListeners();
				_loginScreenNavigator.removeFromParent(true);
				_loginScreenNavigator = null;
			}
			
			addChild(_mainScreenNavigator);
		}
		

		private function checkKeypress(event:KeyboardEvent):void 
		{
			switch (event.keyCode) 
			{ 
				case Keyboard.BACK: 
					event.preventDefault();
					
					_mainScreenNavigator.goBack();
					break; 
				case Keyboard.MENU: 
				case Keyboard.SEARCH: 
					break; 
			}
		}
		override public function dispose():void 
		{
			if (_loginScreenNavigator)
			{
				_loginScreenNavigator.removeFromParent(true);
				_loginScreenNavigator = null;
			}
			
			if (_mainScreenNavigator)
			{
				_mainScreenNavigator.removeFromParent(true);
				_mainScreenNavigator = null;
			}
			
			super.dispose();
		}
		
	}

}