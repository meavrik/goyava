package
{
	import feathers.themes_v3.TopcoatLightMobileTheme;
	import starling.events.Event;
	import game.Game;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainApp extends Sprite
	{
		private var _game:Game;
		
		public function MainApp()
		{
			super();
			
			new TopcoatLightMobileTheme();
			
			
			newGame();
		}
		
		private function newGame():void 
		{
			if (_game)
			{
				_game.removeEventListeners();
				_game.removeFromParent(true);
				_game = null;
			}
			
			_game = new Game();
			_game.addEventListener(Game.NEW_GAME_EVENT, onNewGame);
			addChild(_game);
		}
		
		private function onNewGame(e:Event):void 
		{
			newGame()
		}
	
	}

}