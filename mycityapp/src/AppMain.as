package 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class AppMain extends Sprite 
	{
		private var _mainScreenNavigator:AppScreenNavigator;
		
		public function AppMain() 
		{
			super();
		}
		
		public function init():void
		{
			if (_mainScreenNavigator)
			{
				_mainScreenNavigator.removeFromParent();
			}
			
			_mainScreenNavigator = new AppScreenNavigator();
			addChild(_mainScreenNavigator);
		}
		
		override public function dispose():void 
		{
			if (_mainScreenNavigator)
			{
				_mainScreenNavigator.removeFromParent(true);
			}
			
			super.dispose();
		}
		
	}

}