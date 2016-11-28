package
{
	import feathers.themes_v3.TopcoatLightMobileTheme;
	import game.DifficultyLevelEnum;
	import game.GameEvents;
	import starling.events.Event;
	import game.Game;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainApp extends Sprite
	{
		private var _currentGame:Game;
		
		public function MainApp()
		{
			super();
			
			new TopcoatLightMobileTheme();
			
			newGame();
		}
		
		private function newGame(difficulty:int = DifficultyLevelEnum.INTERMEDIATE):void 
		{
			removeCurrentGame();
			
			_currentGame = new Game(difficulty);
			_currentGame.addEventListener(GameEvents.NEW_GAME_EVENT, onNewGame);
			_currentGame.addEventListener(GameEvents.DIFFICULTY_SELECTED, onDifficultySelected);
			addChild(_currentGame);
		}
		
		private function removeCurrentGame():void
		{
			if (_currentGame)
			{
				_currentGame.removeEventListeners();
				_currentGame.removeFromParent(true);
				_currentGame = null;
			}
		}
		
		private function onDifficultySelected(e:Event):void 
		{
			newGame(int(e.data));
		}
		
		private function onNewGame(e:Event):void 
		{
			newGame(_currentGame?_currentGame.difficulty:DifficultyLevelEnum.INTERMEDIATE)
		}
	
	}

}