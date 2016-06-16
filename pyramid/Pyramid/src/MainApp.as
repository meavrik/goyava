package 
{
	import assets.AssetsHelper;
	import game.Game;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainApp extends Sprite 
	{
		private var _game:Game
		
		public function MainApp() 
		{
			super();
			AssetsHelper.getInstance().init();
			_game = new Game();
			addChild(_game);
			
		}
		
	}

}