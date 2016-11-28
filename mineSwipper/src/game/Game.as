package game 
{
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Game extends Sprite 
	{
		private var _tiles:Dictionary
		private var _tilesWithMines:Vector.<Tile>;
		
		private var _boardPH:Sprite = new Sprite();
		
		private var _screenUI:GameScreen;
		private var timer:Timer;
		private var tilesOpened:int;
		private var tilesOpenNeeded:int;
		private var timeStr:String;
		private var _sec:int;
		
		private var totalMines:int;
		private var tilesOnWidth:int;
		private var tilesOnHeight:int;
		private var _difficulty:int;
		
		public function Game(difficulty:int)
		{
			super();
			this._difficulty = difficulty;
			switch (_difficulty) 
			{
				case DifficultyLevelEnum.BEGINER:
					tilesOnWidth = 12;
					tilesOnHeight = 6;
					totalMines = 10;
					break;
				case DifficultyLevelEnum.INTERMEDIATE:
					tilesOnWidth = 20;
					tilesOnHeight = 13;
					totalMines = 40;
					break;
				case DifficultyLevelEnum.EXPORT:
					tilesOnWidth = 30;
					tilesOnHeight = 16;
					totalMines = 99;
					break;
				
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void 
		{
			_screenUI = new GameScreen();
			_screenUI.width = stage.stageWidth;
			_screenUI.height = stage.stageHeight;
			addChild(_screenUI);
			
			//GameCommon.TILE_WIDTH = Math.min(Math.floor((this.stage.stageHeight-90) / tilesOnHeight), Math.floor(this.stage.stageWidth / tilesOnWidth));
			GameCommon.TILE_WIDTH = Math.floor(this.stage.stageWidth / tilesOnWidth);
			GameCommon.TILE_HEIGHT = Math.floor((this.stage.stageHeight - 90) / tilesOnHeight);
			//totalMines = tilesOnWidth * tilesOnHeight / 7;
			_screenUI.addChild(_boardPH);
			
			setTiles();
			placeMines();
			
			setTilesCounters();
			
			tilesOpened = 0;

			_boardPH.x = (_screenUI.width - _boardPH.width)/2;
		}
		
		private function startTimer():void
		{
			_sec = 0;
			timer = new Timer(0);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			_sec++
			timer.delay = 1000;
			
			if (_sec < 10) {
				timeStr = "00" + _sec;
			} else
			if (_sec < 100) {
				timeStr = "0" + _sec;
			}

			_screenUI.setTime(timeStr);
		}
		
		private function onTimerTick():void 
		{
			var tween:Tween = new Tween(_boardPH, .5, Transitions.EASE_OUT);
			tween.moveTo(_boardPH.x, _boardPH.y - GameCommon.TILE_WIDTH);
			Starling.juggler.add(tween);
		}
		
		private function setTilesCounters():void 
		{
			for each (var item:Tile in _tilesWithMines) 
			{
				item.setCounter();
			}
		}
		
		private function setTiles():void
		{
			_tiles = new Dictionary();
			
			for (var i:int = 0; i < tilesOnWidth; i++) 
			{
				for (var j:int = 0; j < tilesOnHeight; j++) 
				{
					setNewTile(i,j);
				}
			}
			
			var tile:Tile
			var nearTilesArr:Vector.<Tile>;
			
			for each (var item:Tile in _tiles) 
			{
				nearTilesArr = new Vector.<Tile>;
				for (var k:int = item.xpos - 1; k < item.xpos + 2; k++)
				{
					for (var l:int =  item.ypos - 1; l < item.ypos + 2; l++) 
					{
						tile = getTileByPosition(k, l);
						if (tile && item != tile)
						{
							nearTilesArr.push(tile);
						}
					}
				}

				item.nearTilesArr = nearTilesArr;
			}
		}
		
		private function setNewTile(xpos:int,ypos:int):void 
		{
			var tile:Tile = new Tile(xpos, ypos);
			tile.setPosition();
			tile.addEventListener(Tile.BOOOM, onTileExplode);
			tile.addEventListener(Tile.OPEN, onTileOpen);
			_tiles[xpos + "_" + ypos] = tile;
			_boardPH.addChild(tile);
			tilesOpenNeeded++;
		}
		
		private function onTileOpen(e:Event):void 
		{
			tilesOpenNeeded--
			if (!timer)
			{
				startTimer();
			}
			
			if (tilesOpenNeeded <= 0)
			{
				endGame(true);
			}
		}
		
		private function onTileExplode(e:Event):void 
		{
			endGame();
		}
		
		private function endGame(won:Boolean=false):void 
		{
			if (timer)
			{
				timer.stop();
			}
			
			if (won)
			{
				Alert.show("in "+_sec+" seconds", "YOU WON!!",new ListCollection(
				[
					{ label: "Play again", triggered: okEndButton_triggeredHandler }
				]));
			} else
			{
				Alert.show("BOOOM!!", "",new ListCollection(
				[
					{ label: "Try again", triggered: okEndButton_triggeredHandler }
				]));
			}
		}
		
		
		
		private function okEndButton_triggeredHandler(e:Event):void 
		{
			dispatchEventWith(GameEvents.NEW_GAME_EVENT)
		}
		
		private function onTileClick(e:Event):void 
		{
			var tile:Tile = e.currentTarget as Tile;
			tile.open();
		}
		
		private function placeMines():void 
		{
			_tilesWithMines = new Vector.<Tile>;
			var tile:Tile
			for (var i:int = 0; i < totalMines; i++) 
			{
				tile = getRandomEmptyTile();
				tile.mine = true;
				_tilesWithMines.push(tile);
				
				tilesOpenNeeded--;
			}
		}
		
		
		private function getRandomEmptyTile():Tile
		{
			var tile:Tile
			var xpos:int;
			var ypos:int;
			
			do
			{
				xpos = Math.floor(Math.random() * tilesOnWidth);
				ypos = Math.floor(Math.random() * tilesOnHeight);
				tile = getTileByPosition(xpos, ypos);
			}
			while (tile.mine);
			
			return tile;
		}
		
		
		private function getTileByPosition(xpos:int, ypos:int):Tile
		{
			var tile:Tile = _tiles[xpos + "_" + ypos];
	
			return tile;
		}
		
		
		private function removeTimer():void 
		{
			if (timer)
			{
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				timer.stop();
				timer = null;
			}
			
		}
		
		override public function dispose():void 
		{
			removeTimer();
			super.dispose();
		}
		
		public function get difficulty():int 
		{
			return _difficulty;
		}
		
		
		
	}

}